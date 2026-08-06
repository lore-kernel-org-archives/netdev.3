Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D6A38E8A4
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039485; cv=none; b=QqtoJ6+vnfN0KU91KgRMqbjD+pPcf2XWta2kAd7e+sxgkeVsz7ebUzvP1pngy8WI+VlABwxUW9iSmNX0ruTisLuXUxwB4dq5VnGDENeVIHYMpEOTGFHE4nT1UKRuTjkZik2tV4tfcjHqNdFQq8+sotv0vddWv+7tKhKlEFkDXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039485; c=relaxed/simple;
	bh=eSmfCZoWuBLIwDG5gxYJPAle5XDKjiU0bctlxxr7wLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQx3PZruSkB0m++gb6lv1RjPOVO/TKta4noqX8l6T2evPNxN8BqBe3bcU7FIebhDnwOjfL/ySTv27jVHIde3hqDHYkLdF+MLvcddKVHn4X0vo651t7dgUNrmHUYW376x4zWOOTN32yZgsssUINGfikeF2AhodW2YheB0X8AR3qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JbDGBDOE; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JbDGBDOE"
Message-ID: <d0a41ffd-a8cd-4229-ba87-862583cd1844@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786039482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsagAQGtQUIgdGfw+uHWKnE7Y5Sb9/l08Olj8JWgvBY=;
	b=JbDGBDOEUepyLGzmGSLkLg6ZXPE9dejcF89zBlB4wkzN2ORXiq57N36msmoU8mUJ9Zi4YI
	bEmG00FKns57YwC6C/O+N9263R8azgrA8QXtvPDIBpH3Q90fl4X1wxM9sSSIRcG6xwjYe5
	XmPlpeKssUO+jnsm4zZAB+VH44fjORU=
Date: Thu, 6 Aug 2026 19:04:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] MAINTAINERS: add Ivan Vecera as DPLL reviewer
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: arkadiusz.kubalewski@intel.com, ivecera@redhat.com
References: <20260806094432.163833-1-jiri@resnulli.us>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260806094432.163833-1-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/08/2026 10:44, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Ivan has been continuously active in DPLL development and discussion
> since April 2025. His contributions cover the DPLL core and API,
> netlink, bindings, ICE/SyncE integration, and the ZL3073x driver.
> 
> He also regularly reviews and tests DPLL patches from other contributors
> and already maintains the Microchip ZL3073x driver. Add him as a reviewer
> to reflect his ongoing involvement across the subsystem.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 03bfb79fca2a..ea683dfda21f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7870,6 +7870,7 @@ DPLL SUBSYSTEM
>   M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
>   M:	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>   M:	Jiri Pirko <jiri@resnulli.us>
> +R:	Ivan Vecera <ivecera@redhat.com>
>   L:	netdev@vger.kernel.org
>   S:	Supported
>   F:	Documentation/devicetree/bindings/dpll/dpll-device.yaml

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
