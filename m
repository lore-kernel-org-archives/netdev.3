Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EDD38331C
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788257448; cv=none; b=n+3Ni1EAmcEEvowUmiHE45J6NIFDgkI9+gvjsFrbAbNIy79+E8lYS/F73FYmudGpHy8dyH/Tpqbo2IrIxwEsmWtx0Ft2V0ySU2ZgAiDsIV2zxO+OMddhEdg4vLMUR50SclZxptbAHgo0bB0yMbJ07VIkcu1T/319UJ451K3E+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788257448; c=relaxed/simple;
	bh=eCiXJ0V1lD61eU/nkm8ptcqiGA2d3BIel3Y3IprKT38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVpBXlrIndUzckMvK00RJh/lYIRsboPKfSIAcfDoid96066YtK9ShsH6aEgpHJ7xhjbWRqOwp2JHvYorwcMrbKnxWWnaWvow+yhHVpnK02QmFfjKLztpquCu+1TOu8BZeIfoGGR83eiI7sXOcg+Qk5Okjz6am41YlkblRtUQqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMdoaF1+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhGDhSlr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMdoaF1+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhGDhSlr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788257445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACL54tT4vMHsYH0XEuJ1PQI1LaYJnFwQ29QPKJ7kRX8=;
	b=JMdoaF1+SDQFe5BbwSNgWXlTrSFwT6RVKPXobm7xDF/pIhXiPMnGo3TLTw2p+x+Ec3CTkT
	kcZewsDrw6RpPQcaecQ4gUoIW3d7TeKLlP07TpQ4leU0rqrbmPYLTSaPk0IVay7iHPEi3c
	xz7VkWO5pST/8Zc1J7AmOE+9TfLkTJw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-iXjp41XpOLGmSmma7Hr-Dw-1; Tue, 01 Sept 2026 06:10:36 -0400
X-MC-Unique: iXjp41XpOLGmSmma7Hr-Dw-1
X-Mimecast-MFC-AGG-ID: iXjp41XpOLGmSmma7Hr-Dw_1788257436
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-484337a63bbso1898402f8f.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 03:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788257436; x=1788862236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ACL54tT4vMHsYH0XEuJ1PQI1LaYJnFwQ29QPKJ7kRX8=;
        b=LhGDhSlrf+Er51VzBuOG21/scn3624sohXDDOfFUiVa1/0/4nCly9+hpSbS+WOfmTK
         TKZOxm7qClycm9NoirhmWjNlLVMJ0Ps/2B5jJEJ5rq6gnQij3xpc91ac8QbUPx19kRxZ
         2YFk4JtVrls6lZohSiioJoSkbDwX1JD2xzbE5tJFdr86LMIsIX1lFLlOu94QcIx7Qf/0
         FG86KvmykgXdt9q6xsKSp4VEwYdQKJUIhL5RiCSJrC1PzRggapc3D/WYtPpX8mOwckbr
         Ks/lxVC9A0410iZQaLbcUJZXRggbPMlp1A9K7tYB2H7xEHwtXI65OD7LTyOOMlQGgZVS
         f9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788257436; x=1788862236;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ACL54tT4vMHsYH0XEuJ1PQI1LaYJnFwQ29QPKJ7kRX8=;
        b=rNTAClsMlBu7qJJhxPgljYUiodPc1JgK2zrJC2weUuhU/byTUZSTcRT6PSbydrp04B
         uWaZtf8X+wKSQs8hZ+yEZBtVWPVB7bUtxp2DCLSSaArDIqWADb+M1KnKJBR4bIWxo14w
         vBJ3G7SIQH6kiUe9TvZq238IKICSEGbIfrvzCKiJDZR5HQYZ+N4SIy3vmKJ4BjSsbuyp
         n5SDiaEVdlRlPzWFzm6qDfMU0qtr63rSB0gH7eEN8rTgOGtHXiodBeWYO95XT+6hMQaW
         8DqYV6i+0SGIoZuTyIsax9bzHd9TdBC9nH0KHOCE9XnQpiArnqK87zVY93ulkjd8rE5h
         yWXg==
X-Forwarded-Encrypted: i=1; AKwUvByWE/GpWBaxOgZAiN2HSQer/QP/0wllHku9EKsq0rEx/ebWmbEjLyaKRCPcLtYVo6kU6RMSXE4=@vger.kernel.org
X-Gm-Message-State: AFuF++lFZFwMvlssz2RqvWCQp7ec1s6EyngsBjz5NJVZ+qhzjnf3BZVB
	uTy/OPyWK6iIIHMkpmRzmqTtmPP2YSGxrCPE3/l544hJKfx0h50a0A/7D18jjops5dF0KQ6b81B
	pixRpkZsGHfcOrijzLKMavwA7HoPz8/6hVk+WM5EtRjd2QwUsx/12m8FAkQ==
X-Gm-Gg: AYBFou2gsmj6GOnok/qawGUi6uQG6AJRjP4cgOT/aixibyA9vmLY16BobtZSL7UjMbI
	yoGWPuUpQP+Z1C1UV5+DSHMWCVa4mqRwUaOQlvv884doKvCr+0l50TjmrOstA6hDc8k9SjykVLk
	MZGmnSAuaNm4slL7mIcX6t7AI8RvmhJ6C8I+iQV5HCsAaTgaa+ZmbQtMI9MfCYwTRbNiJlaMejB
	elXl6RLBQZ4JkloKzQ2EdnSSAmFrf374nodr3m7NFJNRz/jE2A+6g1l5pVP1w61PVXJxkEpx+P2
	Q6MhIdLKdTYn7C2cwnWOOHse65V9Y2cZSwVKteHVCzm1vyNq7c91tMX9s/jC97+4vCda+MgQuyk
	YyO6luQ62mf73xnJapohoFSH8lrQyfIA+KtF/gzXT5Kj3HSDy/G5RIgtKkBISxcAxwJLhQ/8Hkg
	==
X-Received: by 2002:adf:f105:0:b0:481:51b7:290b with SMTP id ffacd0b85a97d-484416aadccmr9393885f8f.14.1788257435717;
        Tue, 01 Sep 2026 03:10:35 -0700 (PDT)
X-Received: by 2002:adf:f105:0:b0:481:51b7:290b with SMTP id ffacd0b85a97d-484416aadccmr9393781f8f.14.1788257435275;
        Tue, 01 Sep 2026 03:10:35 -0700 (PDT)
Received: from [192.168.188.218] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d3c4absm3951169f8f.10.2026.09.01.03.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 03:10:33 -0700 (PDT)
Message-ID: <53a67f9a-b8a0-4967-b2c6-be4ee3a09735@redhat.com>
Date: Tue, 1 Sep 2026 12:10:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vxlan: use one headroom snapshot for neighbour
 replies
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Stevens <dlstevens@us.ibm.com>,
 linux-kernel@vger.kernel.org
References: <20260831054614.2069896-2-sanghyun.park.cnu@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260831054614.2069896-2-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 7:46 AM, Sanghyun Park wrote:
> vxlan_na_create() samples LL_RESERVED_SPACE() to size the reply skb and then
> samples it again to reserve headroom. A concurrent vxlan_changelink() can
> update needed_headroom between the two reads, creating a TOCTOU race. The
> second value can exceed the allocation and make the Ethernet header write out
> of bounds.
> 
> Snapshot the headroom once and use that value for both allocation and
> reservation.
> 
> Fixes: 4b29dba9c085 ("vxlan: fix nonfunctional neigh_reduce()")
> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
The patch LGTM, but the changelog needs some improvements: if you have
can observe a splat on the unpatched kernel, please include it,
otherwise please explain whythe issue is not just a theoretical one.
Also please specify if some LLM has been used.

Thanks,

Paolo

