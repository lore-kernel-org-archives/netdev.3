Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ECE23BD02
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851412; cv=none; b=TwvRKvwfaScmtPO4di7bEJH9sshElP1pZvj5WJ5Z6lW0gk4uX18G0Wr6JRXHWQC71Y/yG9kFrR8YQYuFe2+rUqx8ib066HZZ/BpuCsk0bc/YaNlto17DZZ1PxvrRUQ7hYafkGQIE/rqtnlI8hmrFkNbOea5F5oDeQMQDmsUqSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851412; c=relaxed/simple;
	bh=sbf2Dn8YBRZOAg2ibU3pldajj3oGZG7xjUwIImJ8KdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8TZtJI8eZRRcku/RZYaAALCIEHEX9ZBY4/rDwJQ6TkEUDnw5ePuX8q9W5FVGbBtr/4Y1yxP7nEjvTrFPMcZ3aZ0DyY+X3N/QgQ8lEBDk/C7eM3hAJuVub3lpnsGiUMMZikNFpBIi1stnEI67qj1WjYHdAbKGdzHxBo5JsWwiSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cswjRvoC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j4CSdvzH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cswjRvoC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j4CSdvzH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790851409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gj2DS4EAwFpnikZL+8trXmfNUv61SvUNH/RIKPA1W8k=;
	b=cswjRvoC53UzpBd4maaEdOWQ9m4DYa9AoP9uE0HASktaMn+4ayNhWyVrxojSKcj8avi4Bh
	WWdt68mrAiQtrVfCdaaqLlU2ZP/nFRhI+aF2f0k69XCj0K5OfvqG1paB639TqL6oWyslbP
	piepQ4PsGHZ9+W0DpvMkXFsSDEaMpKA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-8gmMhqePPg2KBxRfhcaV-w-1; Thu, 01 Oct 2026 06:43:28 -0400
X-MC-Unique: 8gmMhqePPg2KBxRfhcaV-w-1
X-Mimecast-MFC-AGG-ID: 8gmMhqePPg2KBxRfhcaV-w_1790851407
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48aef5cfe43so2072915f8f.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790851407; x=1791456207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gj2DS4EAwFpnikZL+8trXmfNUv61SvUNH/RIKPA1W8k=;
        b=j4CSdvzHVxmj5cTwtSlEX4kbjMyKROUnyyPx15XRqnBNnQyYh8Cg0xlc9EHDC3Nq4G
         J+GQvANps/ev45jFV/kG+L7OvcyJseI385enfWb6Kmk+EakZ0+/BlmHQvucyuBSM3WNp
         ioVOtmhoq+dHAUXE94Na3jZjW5/6sDzMLPlKBdDRcxvE1KrMvqEhIqyZreHBpzEbsiMo
         IG9JUHMCBE0HBRuzoRhYIN2ep9yzuwF2wqafwgZD7gkY6prFxqTg6pXfWcxyEp7M41l8
         IukmB8gAG2zUyTQgk4Ggi1J+Tg/KHSTJnVA1LXnRoYTGJXdve9rQUotkQ6SQDR2uxDyO
         13/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790851407; x=1791456207;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gj2DS4EAwFpnikZL+8trXmfNUv61SvUNH/RIKPA1W8k=;
        b=rAp2hlLKS+D7jr+u2XigbjtIir2EjYqh1IPcroF9btx2kfUX4Gi99h1v6lo5jC4PQq
         nfIMUr1vw7t9uRLfIGXFG7Qkho9eSPn+ko0+aPqW7frgwsFpLu8Jc7nTXJdjGDFpnsAF
         cxp2DBIdL2QiudY2GOfZM8kU/wAsvNKyNhQOLJ/tCZCHgk8nTQpRLQdisu/tmGqs/ZoX
         Gdx93mipajjp79eAa+8sphGty04Gek3Bi38QIs+EjfGBe2P4Swy18mnEcwhUQRSfeGzR
         8h7HjwQvwcMj5SAzoHT1qhkw1gC3GB7W8TLO7WqnOzphjeYTat/5cic4o6bu2IuXJZ0W
         ioAw==
X-Gm-Message-State: AFq9FYKGI2jcP6Rn29E7wv6A6xJEAZimsQZloMUM4xt21gfwz4wDYP6i
	y91QsX5/HFSwDq9YiAVsDeEh7oRN80D5BBUiONiMz7j28DLiZ/VxaM3j7+SN2hkY2SaUDLknNmD
	QRr+fPV9UqU/XqS888EOMzNn5Dzk3kusmHfmrMxCyNg30HhRjlcZzW2mJMg==
X-Gm-Gg: AYBFou3DmQ40uvvW9zr7fvlh6KMqCvec6bRGkV0KxfecvhlVSVOuPDtt7hoaBdof31j
	xFc1dTnvHGMJdRdeTjxqtF334sELI2Jb53pqixAG5kPWMdThn8beGZdk82/IAzEqYlO/HjknDw7
	8WvsW7k9RPZ/TVZdWDBamS54CL2G6SuECSDk0jmczopHZySLm6mtN6qR1SQUf9wYPoDKX3deTTk
	1RGtsy4EUARVqMiMyPYzDeskwB39Xv59+AKwJElHSByX5yvG/AIwnavzQOSJTHGz9+pUXlI8j18
	Be+0FWRfdijgE8dvHZgzm/+w9zQ/0bo6FNg/kgmPypSyAbpUimFbBd2xOgXNldixwWQFxZzx9dD
	K4u6np/LDR9H7RnJXNmg2v1USd3VP139sYBTk+LjfGBesbNSzCgzP0b+BMF35n09l62RwrT8URQ
	==
X-Received: by 2002:a05:6000:4029:b0:488:6ed9:b11d with SMTP id ffacd0b85a97d-48b0255927fmr8239042f8f.52.1790851406723;
        Thu, 01 Oct 2026 03:43:26 -0700 (PDT)
X-Received: by 2002:a05:6000:4029:b0:488:6ed9:b11d with SMTP id ffacd0b85a97d-48b0255927fmr8239012f8f.52.1790851406322;
        Thu, 01 Oct 2026 03:43:26 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b06a2d732sm5056631f8f.33.2026.10.01.03.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 03:43:25 -0700 (PDT)
Message-ID: <ef3b5996-db58-49ef-bdc6-30ee5a87e76b@redhat.com>
Date: Thu, 1 Oct 2026 12:43:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: only give queue leasing devices a separate
 instance lock class
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, razor@blackwall.org,
 dw@davidwei.uk
References: <20260929191543.3295633-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260929191543.3295633-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/29/26 21:15, Jakub Kicinski wrote:
> diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
> index f5558b12877c..27cb6397bdd4 100644
> --- a/net/core/netdev_queues.c
> +++ b/net/core/netdev_queues.c
> @@ -61,21 +61,24 @@ struct device *netdev_queue_get_dma_dev(struct net_device *dev,
>   bool netdev_can_create_queue(const struct net_device *dev,
>   			     struct netlink_ext_ack *extack)
>   {
> -	if (dev->dev.parent) {
> -		NL_SET_ERR_MSG(extack, "Device is not a virtual device");
> -		return false;
> -	}
> -	if (!dev->queue_mgmt_ops ||
> -	    !dev->queue_mgmt_ops->ndo_queue_create) {
> -		NL_SET_ERR_MSG(extack, "Device does not support queue creation");
> -		return false;
> -	}
> +	const char *msg = NULL;
> +
>   	if (dev->real_num_rx_queues < 1 ||

Clashiko flags a possible data race while reading `real_num_rx_queues`
but that should be IMHO addressed separately, if ever addressed.

/P

