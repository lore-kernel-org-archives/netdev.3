Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88575381C4
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774524084; cv=none; b=NV7DvYqZbxbWEnIc9kDnihfUuT+YFWkDT9sO6yF5hM3RLArDUtgpcZXRpXn6seHUduUIuurGZ44bIaoKJ9OlCKWQLYncvBToouu/u4LsbOBlxPorO9MskmusT3VNq+YZWROFslJ894Px+UevLOe2lqGe2+Q0uz1lmFZQJqe+bYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774524084; c=relaxed/simple;
	bh=X0Do9qkcftjMRF5OFnXzgQtZlAZLmNeCZnVSabSiuik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sd8TwltUjLjtsJj4CQc01tBbuRO0l1054dgxnoTMAkv975E8BFP+xbXNgnk1MMFye4zn/WQDqKhGFO7/GGhQYVkFDFS3uVBUkUWzT63gKqmYzlQrdnwfEa07n6Yi4dKBSgGyQwH8pBvOyFVDQ8WE+aMR4Bn6MJgPKX/lGJuzBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l3oJhkAq; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l3oJhkAq"
Message-ID: <d0a6d302-c5af-4ad1-87e2-fa017bdd96a8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774524071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeaHEVMmFG+GkHSOXJpAtPu+S6loJl/i8IeYwFoTz/E=;
	b=l3oJhkAqUZ4Mf3rXVV8kXB75aHPvwXDf4/GShZtn85EmACTtGe+0rJNOQ4ovsCJ7BRHP90
	Dx5kH6fcIcrvwnbo6C03/cF5QjwERa5LruoLGWVRbCCJWbFqa+SrYl2wcq1YW6gTpK+TjA
	s3L62PEvjmRTIC4KIqCu4OgkBElludU=
Date: Thu, 26 Mar 2026 11:21:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/3] dpll: add actual frequency monitoring
 callback ops
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Petr Oros
 <poros@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260325193914.124898-1-ivecera@redhat.com>
 <20260325193914.124898-3-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260325193914.124898-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/03/2026 19:39, Ivan Vecera wrote:

> +static int dpll_msg_add_actual_freq(struct sk_buff *msg, struct dpll_pin *pin,
> +				    struct dpll_pin_ref *ref,
> +				    struct netlink_ext_ack *extack)
> +{
> +	const struct dpll_device_ops *dev_ops = dpll_device_ops(ref->dpll);
> +	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
> +	struct dpll_device *dpll = ref->dpll;
> +	enum dpll_feature_state state;
> +	u64 actual_freq;
> +	int ret;
> +
> +	if (!ops->actual_freq_get)
> +		return 0;
> +	if (dev_ops->freq_monitor_get) {
> +		ret = dev_ops->freq_monitor_get(dpll, dpll_priv(dpll),
> +						&state, extack);
> +		if (ret)
> +			return ret;
> +		if (state == DPLL_FEATURE_STATE_DISABLE)
> +			return 0;

I think we have to signal back to user that frequency monitoring is
disabled via extack.

> +	}
> +	ret = ops->actual_freq_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
> +				   dpll, dpll_priv(dpll), &actual_freq, extack);
> +	if (ret)
> +		return ret;
> +	if (nla_put_64bit(msg, DPLL_A_PIN_ACTUAL_FREQUENCY,
> +			  sizeof(actual_freq), &actual_freq, DPLL_A_PIN_PAD))
> +		return -EMSGSIZE;
> +
> +	return 0;
