package ${controllerPackageName};

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

<#if model.serviceBeanName?if_exists!="">@Service("${model.serviceBeanName}")<#else></#if>

@Controller
public class ${model.entityName}Controller {
	private static final Logger LOGGER = LoggerFactory.getLogger(${model.entityName}Controller.class);

	<#if model.entityName?if_exists!="">
 	@Resource
	private ${model.entityName}Service ${model.entityName?uncap_first}Service;
 	</#if>

	@RequestMapping(value = "/${model.entityName?uncap_first}List.html")
	public ModelAndView findList(${model.entityName} ${model.entityName?uncap_first}, PageVO pageVO) {
		ModelAndView view = new ModelAndView("${model.entityName?uncap_first}/list-${model.entityName?uncap_first}s");

		Page page= ${model.entityName?uncap_first}Service.findPage(${model.entityName?uncap_first}, pageVO);
		view.addObject("page", page);
		view.addObject("${model.entityName?uncap_first}", ${model.entityName?uncap_first});
		return view;
	}

	@RequestMapping(value = "/toAdd${model.entityName}.html")
		public ModelAndView toAdd${model.entityName}() {
		ModelAndView view = new ModelAndView("${model.entityName?uncap_first}/input-${model.entityName?uncap_first}");
		${model.entityName} ${model.entityName?uncap_first} = new ${model.entityName}();
		view.addObject("${model.entityName?uncap_first}", ${model.entityName?uncap_first});
		return view;
	}

	@RequestMapping(value = "/show${model.entityName}.html")
	public ModelAndView show${model.entityName}(String id) {
		ModelAndView view = new ModelAndView("${model.entityName?uncap_first}/show-${model.entityName?uncap_first}");
		${model.entityName} ${model.entityName?uncap_first} = ${model.entityName?uncap_first}Service.get${model.entityName}(${model.columnKey.javaName});
		view.addObject("${model.entityName?uncap_first}", ${model.entityName?uncap_first});
		return view;
	}

	@RequestMapping(value = "/toUpdate${model.entityName}.html")
		public ModelAndView toUpdate${model.entityName}(String id) {
		ModelAndView view = new ModelAndView("${model.entityName?uncap_first}/input-${model.entityName?uncap_first}");
		${model.entityName} ${model.entityName?uncap_first} = ${model.entityName?uncap_first}Service.get${model.entityName}(Long.parseLong(id));
		view.addObject("${model.entityName?uncap_first}", ${model.entityName?uncap_first});
		initEnumsMap(view);
		return view;
	}

	@RequestMapping(value = "/add${model.entityName}.html",method = RequestMethod.POST)
	public ModelAndView add${model.entityName}(@Valid ${model.entityName} ${model.entityName?uncap_first}, BindingResult re) {
		ModelAndView view = new ModelAndView("redirect:${model.entityName?uncap_first}List.html");
		if (re.hasErrors()) {
			LOGGER.error("form submit error ！${model.entityName?uncap_first}:{}", GsonUtils.toJson(${model.entityName?uncap_first}));
			view = new ModelAndView("${model.entityName?uncap_first}/input-${model.entityName?uncap_first}");
			view.addObject("${model.entityName?uncap_first}", ${model.entityName?uncap_first});
			view.addObject("errorMsg", re.getFieldErrors());
			initEnumsMap(view);
			return view;
		}
		boolean flag;
		try {
			if (${model.entityName?uncap_first}.getId() == null)
				flag = ${model.entityName?uncap_first}Service.add${model.entityName}(${model.entityName?uncap_first});
			else
				flag = ${model.entityName?uncap_first}Service.update${model.entityName}(${model.entityName?uncap_first});
		} catch (Exception e) {
			LOGGER.error("添加羊毛失败!",e);
			flag = false;
		}
		if (!flag){
			view = new ModelAndView("${model.entityName?uncap_first}/input-${model.entityName?uncap_first}");
			view.addObject("${model.entityName?uncap_first}", ${model.entityName?uncap_first});
			view.addObject("errorMsgInfo", "保存数据失败，请稍候重试！");
			initEnumsMap(view);
			return view;
		}
		return view;
	}

	@RequestMapping(value = "/del${model.entityName}.html")
	@ResponseBody
	public String del${model.entityName}(String id) {
		Result result = new Result();
		try {
			result.setSuccess(${model.entityName?uncap_first}Service.del${model.entityName}(${model.entityName?uncap_first}));
		} catch (Exception e) {
			LOGGER.error("删除羊毛失败!",e);
			result.setSuccess(false);
		}
		return JSON.toJSONString(result);
	}

	@RequestMapping(value = "/update${model.entityName}.action")
	@ResponseBody
	public Result update${model.entityName}(${model.entityName} ${model.entityName?uncap_first}) {
		Result result = new Result();
		try {
			result.setSuccess(${model.entityName?uncap_first}Service.update${model.entityName}(${model.entityName?uncap_first}));
		} catch (Exception e) {
			LOGGER.error("删除羊毛失败!",e);
			result.setSuccess(false);
		}
		return result;
	}
}
