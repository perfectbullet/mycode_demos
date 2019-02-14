# 数字转字典数据 arr:对象数组
def arr2dict(arr):
    return [obj2dict(obj) for obj in arr]


# 对象转字典数据 obj:对象实例
def obj2dict(obj):
    if not hasattr(obj, '__dict__'):
        return obj
    objdict = {key: value for key, value in obj.__dict__.items() if not key.startswith('_')}      # 对象转字典常用的方法,使用迭代去掉key.startswith('_')
    for key, val in objdict.items():
        if isinstance(val, list):   # 列表
            objdict[key] = arr2dict(val)
        elif isinstance(val, Enum):     # 枚举
            objdict[key] = val.value
    return objdict


# 字典数据转实例对象, 对于内部数组不处理
def dict2obj(data, TType):
    obj = TType()
    for key, value in data.items():
        if key.startswith('_'): continue
        if not hasattr(obj,key):
            # print 'dict2obj error: %s has not attr %s' %(str(TType), key)
            continue
        defval = getattr(obj, key)          #获取默认值
        if isinstance(defval, Enum): value = type(defval)(value)        #枚举类型 数据转化
        elif isinstance(defval, list) and hasattr(obj,'_'+key):
            arrtype = getattr(obj, '_'+key)
            value = dict2arr(value, arrtype)
        setattr(obj, key, value)
    return obj

#字典数据转化为数组
def dict2arr(data, TType):
    return [dict2obj(d,TType) for d in data]
