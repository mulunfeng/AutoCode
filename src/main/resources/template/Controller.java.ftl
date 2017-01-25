package ${controllerPackageName};

import ${model.packageName}.vo.PageVO;
import ${model.packageName}.vo.Page;
import ${model.packageName}.vo.Result;
import ${model.packageName}.utils.GsonUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import javax.annotation.Resource;
import javax.validation.Valid;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.validation.BindingResult;
import ${model.packageName}.service.${model.entityName}Service;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import ${model.packageName}.entity.${model.entityName};

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
		ModelAndView view = new ModelAndView("${model.entityName?uncap_first}/list-${model.entityName?uncap_first}");

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
		${model.entityName} ${model.entityName?uncap_first} = ${model.entityName?uncap_first}Service.get${model.entityName}(${DATA_TYPE_TRANS_MAP[model.columnKey.type]}${model.columnKey.javaName}));
		view.addObject("${model.entityName?uncap_first}", ${model.entityName?uncap_first});
		return view;
	}

	@RequestMapping(value = "/toUpdate${model.entityName}.html")
		public ModelAndView toUpdate${model.entityName}(String id) {
		ModelAndView view = new ModelAndView("${model.entityName?uncap_first}/input-${model.entityName?uncap_first}");
		${model.entityName} ${model.entityName?uncap_first} = ${model.entityName?uncap_first}Service.get${model.entityName}(Long.parseLong(id));
		view.addObject("${model.entityName?uncap_first}", ${model.entityName?uncap_first});
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
			return view;
		}
		boolean flag;
		try {
			if (${model.entityName?uncap_first}.getId() == null)
				flag = ${model.entityName?uncap_first}Service.add${model.entityName}(${model.entityName?uncap_first});
			else
				flag = ${model.entityName?uncap_first}Service.update${model.entityName}(${model.entityName?uncap_first});
		} catch (Exception e) {
			LOGGER.error("添加${model.tableRemarks}失败!",e);
			flag = false;
		}
		if (!flag){
			view = new ModelAndView("${model.entityName?uncap_first}/input-${model.entityName?uncap_first}");
			view.addObject("${model.entityName?uncap_first}", ${model.entityName?uncap_first});
			view.addObject("errorMsgInfo", "保存数据失败，请稍候重试！");
			return view;
		}
		return view;
	}

	@RequestMapping(value = "/del${model.entityName}.html")
	@ResponseBody
	public String del${model.entityName}(String ${model.columnKey.javaName}) {
		Result result = new Result();
		try {
			result.setSuccess(${model.entityName?uncap_first}Service.del${model.entityName}(${DATA_TYPE_TRANS_MAP[model.columnKey.type]}${model.columnKey.javaName})));
		} catch (Exception e) {
			LOGGER.error("删除${model.tableRemarks}失败!",e);
			result.setSuccess(false);
		}
		return GsonUtils.toJson(result);
	}

	@RequestMapping(value = "/update${model.entityName}.action")
	@ResponseBody
	public Result update${model.entityName}(${model.entityName} ${model.entityName?uncap_first}) {
		Result result = new Result();
		try {
			result.setSuccess(${model.entityName?uncap_first}Service.update${model.entityName}(${model.entityName?uncap_first}));
		} catch (Exception e) {
			LOGGER.error("删除${model.tableRemarks}失败!",e);
			result.setSuccess(false);
		}
		return result;
	}
}
