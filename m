Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1025E42EEC9
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183410; cv=none; b=W6PZUowS3w0vC3amaODw3VtI2jQFEtMuo7oH/fo+pOzpZsks1iRaTgyLKRDuDPExyxh18E1NeySZbFDua72jpdKN0DjO1iX775IrHeoPTFasGuAIkXd4Tuqw/d57tLMWSurE0nNYwx8OR/rvbNCtDzef4OoEvuqluDcwVGMGGI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183410; c=relaxed/simple;
	bh=RXHMH7L5X5viH8MuZfC3yL4+XM+W6sEJkSUTTYexSWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qT2r3ktFowle0UMa1aZaTLaJM8qRa7THpi9I2VlHf9RbQ7bnotrUlxX9PhSYoD2EUWPhr1Terzrki9nj4FrBkRxFyd9654wp8E+MCvO/whxKY4ZnoKyL1NvgWTTrZkYFa+wC9+IIr5m1iJkoF+J4LnHmO+KnTftHqaTWqWJ7GY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeVuYfBh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeVuYfBh"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c250a2bc3b3so453230866b.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788183407; x=1788788207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fneGRjr+ySvdkLjxtzdgXXRUjfjDg7lmHVjWGaGc48A=;
        b=UeVuYfBhRivUcfKfIBoz9Hx8fwBGsbJgclYgspSZiqGOH0Lk4xO1OAWx9SzBVoFvLq
         ARP2YFH4kVGG7fdrFix+ojcJsjLO025J+axTMiPqRbb88RKHWajuagD9zFatv2tAP0/M
         5SrQpRBm0EDEWRW+6/LyQhRBI8nr2mI2+ViaSKjFh1e/A7y8ga4SIJvQB+1kolvVT9cG
         sEpfmrFrj5iV7yYON3QdhpHoKkGCtGOD+4xjsCTgCj6bHE03DAHkKpIcG2ipmF4nYLjh
         fwSp0CRBQk/U/1MZ+BsBOpYWNCqSfn3Iupnlv3VKNwvFyG/chcjv2ncF8y7R28xDOKJN
         ePvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183407; x=1788788207;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fneGRjr+ySvdkLjxtzdgXXRUjfjDg7lmHVjWGaGc48A=;
        b=M0/CNrzRgyw33CBYa8+P+z/+Z7EJtvX+g4jgoRmZMdDGxee4DaIAoOIZuWLYnRiAsE
         BfIe9GUSkTk9v+DTkqvtF6UWwlVfWWRco48HpTPdJMcJLRYGClXL2F3u4tphNMjFUiqn
         6n80kXIFrK2lIrhOZSEC/4OzCImeQsW6SSB1VxLwqm2ayjTLYGNoyI8MAHeWJJEoJhH+
         lJxVj3tESmXSuY1519AzGV/GFevT08IK0m8bJ8vsmr1ubO/M4B9i75xSgwFv/Eh4yRrZ
         V/X8Ca9cFKdnmtXZrkG5Iusl7CiY9l+4sAb43W0ybwPFJWBO1gYGsO77Du/mYWP2ZFUS
         veLw==
X-Forwarded-Encrypted: i=1; AHgh+RrMR8cUHTBCgfLLX4D34fXwpYM7gKt4icNIHSuwb+AlFB/hfFYDnric1R3qU3eKjwzlGhf/yzQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nb+rj2WWDaMldEeTrjMYCGZJPOvYQIMOw4qBL2UrZ0bCIuwTjC
	jOd0uC+IQtLmRDrqU1NvM8aNL2LxcPb+Uqzi6scTfp68gPSCdnZeh1mY
X-Gm-Gg: AR+sD127k+3YSmKBTyHszorLHRHcn5PwT2Gq6AxrbvtLv+LnzNNctGzNU9JKNWLmKOR
	pr/RiyFmysxIUs3H5qemEp4zyE5SRMPyC/uGc8duGds/AiRrSHonDPQ7gTJzh9lAat6nDUW42O8
	GSsFW/gKYn742324IZRoFEVtY5vA0tDfN32AlrO0+/w4m2g9oSTChkllTMh5Wu+MLgYj4PS9G3L
	HD3K8aqIxPpFytJaEPJYVPaOuzBCa2g7lVcUnqxfWhu4fJLMpocCI+Go7B8Y5m6No4kCeKigSGh
	m65pwR3qRCzo89HH8RIZSzymuPsg4ILvZXsv8MJZ0ZNV6t81wPQhTbd1mvyQxlJ+1kJyLlyz6xD
	AcngevRtWi4NlWWily5ekDboxEjPd0KOlamgmsab0/Rwh/Zt/97HHyULL4uPRXbaMRNmYT71m49
	2KcVZYhTbld5L38fsTlGPPxAXXg1L/iUj6BjspbY5HBDlF79NsxGEU7ug8YNj3+CUnGDuBET+sx
	BMLaAHR79PM6OphW1E/KJZH
X-Received: by 2002:a17:907:d649:b0:c25:62c7:fdef with SMTP id a640c23a62f3a-c2562c83b53mr1418035366b.18.1788183406884;
        Mon, 31 Aug 2026 06:36:46 -0700 (PDT)
Received: from [192.168.1.124] (83-131-188-88.adsl.net.t-com.hr. [83.131.188.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee2853dsm467137066b.18.2026.08.31.06.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 06:36:46 -0700 (PDT)
Message-ID: <97bd737b-31d9-4eef-9594-76fc9739e04a@gmail.com>
Date: Mon, 31 Aug 2026 15:36:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: wwan: qcom_bam_dmux: account network packets
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260830085400.2542956-1-sinyavin@gmail.com>
 <apVH-Wd4d9q1uMzy@linaro.org>
Content-Language: en-US
From: Dmitry Sinyavin <sinyavin@gmail.com>
In-Reply-To: <apVH-Wd4d9q1uMzy@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the review!

31.08.2026 11:23, Stephan Gerhold wrote:
> This is a bit odd, why did you split the two if (netdev) statements?
> The skb stays alive until it is freed here, so you should be able to
> obtain the length even after bam_dmux_tx_done().

Agreed, will join them in v2.

> Would it be better to increment the stats after the packet was already
> passed to the network subsystem in this call?
> 
> I'm not sure if we need to check the return code of netif_receive_skb()
> and increment rx_dropped if it fails. This seems to be handled
> differently in various drivers. Maybe someone else knows?

My understanding is that rx_packets counts good packets received by the 
host even if they are dropped in the stack downstream. I also checked 
that mac80211 follows the same pattern: first dev_sw_netstats_rx_add(), 
then netif_receive_skb(), ignoring the result (the documentation for the 
latter also states that the result is "usually ignored"). If there are 
no strong objections, I'd leave that as is.

Best regards,
Dmitry
