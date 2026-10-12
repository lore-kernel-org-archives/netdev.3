Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17884B4873
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824577; cv=none; b=QYRmssyA7yB635zQuB5HW2nil+V2j/Nx+vFTlLpe3nd9sPgdGhTWD5N+BGOI7e1ABIfUONSIMen4+iMonlRGnJV4wIpsGiscm1LBsgVsiISo/qlYfaKdQ0su5H2WrfMcbvaBYlK8C21lVgK9+I7Z/ViLMI39BvolQsResqsuGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824577; c=relaxed/simple;
	bh=jq51OwC9A43IB0wfYFoIm6Z3y5MJ0fl+hNKb36LWrNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwIrMN7v1Va7uZYshCevfT+CCZ2TTrITBi1aL1lMmOUQNwRxgzZkj47fd3EwjF3vPufZvCPPezraknn/RLjWbs24vLy1wBuF/QOhUPnivLZboRDSjTrUa1wL/rfp4zPN9d14dxItySwK9NFtLD3AxzwFnePpE5zDiXDpqm7sSgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RinBIev1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGyAl3nz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RinBIev1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGyAl3nz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791824573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BE8mHdE/KxjGL6VP/icg38Woqfp2urjjOfjJsE3HU0U=;
	b=RinBIev1LgzGX0qtlPBWXiHfk5/BxCAR9G9RbEp4cK1B4CcaQqekjEXOfbx2Oexz7sQyec
	k2ch6roAZTwEYDSjGOwmYF5Wsci+6/j582XoDRnyghQJfe7PEGQfW7M0PsGD2+JuSLoIF0
	HbS8y1/A8YMZEtFK+e98NmrpfxbhcZg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-3DTpnSswNeuUQ8-vymozAg-1; Mon, 12 Oct 2026 17:02:43 +0000
X-MC-Unique: 3DTpnSswNeuUQ8-vymozAg-1
X-Mimecast-MFC-AGG-ID: 3DTpnSswNeuUQ8-vymozAg_1791824563
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4887e5afd67so1743204f8f.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791824563; x=1792429363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BE8mHdE/KxjGL6VP/icg38Woqfp2urjjOfjJsE3HU0U=;
        b=TGyAl3nzLEdnYV8WA+VPS8QvCbsOih2ezZCv+o7hNYhkWY8tIjWLHXE5g+DyMCgHGh
         3JXbeFcBo6w8vaxAJZgAauxCIYVDx2xFL7GYa2t0hAZS4x3b+CpNhu2ktxDb2OgUwfuY
         UWyZmJopVzFa23m1woUxkXbeEblAdmarFqLMHHMZSpUHzxbfON5shSIolI0id4rHf5e4
         S3m5Ejdx7VcnQ3Mb4zErqMT7sSvClxbHW8H7Ahpf96VEYAOEgTZcfy5E3bSIh+uoN6zI
         V0ON+sEgi0fVTQAPu8GONzaPK6qAu5aGr7z7X+vjyQNjg8FgT5B9F9RezcF40yOqYs50
         R9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824563; x=1792429363;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BE8mHdE/KxjGL6VP/icg38Woqfp2urjjOfjJsE3HU0U=;
        b=VQ3Nl4r3Pn6OIp1DNGi2UmKy6lT6KDWmje048MKbSK3FoRgjp5Kv0kQLpxz75FKAiz
         WdckN9w7YMDRpuOyTsSk5sxCf71gsxVeL2vuTCJ8noxjPQ6TTxPIWoFloWCbOGPgJ9hU
         QJ2d2LBdsCpBsJlLI2o+Tzcuw54WledfE2CUIcL/5f6YBsg3NKMZ0wfVrYLg0soqKs96
         F2PfgmFoo7+gPvKDz2Saxwpaidz0riNg2rz31HsoYtMMOzHR9986hPyap7xloLO5m6BZ
         lKeDeZCDNypGfWDi1OLpD+RTVEkWX27EiWa0rDvHOvrRbXcNuCr4hdvYrH+CmQVrBTz5
         7YLA==
X-Forwarded-Encrypted: i=1; AKwUvBxSpxlEshCLVkIZ66k5wDgjAd9LYTz+PfVJnO2GtoPop+FKfiL3srC1pKa1n5MrOyYeZIG7j8g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJq0qQyzPYiesCNh+B+rzAnvdjtmJBkJfzdlYcAniLxTI38WRhp
	QXFavvEmbOfbhiXGUrNnBZLpURiuJ4XmR+1vnDhEgVoUn+uL7md1JPvr4EPoPtguA9W+0lXHGOi
	b5YToUh5HiRhuypdpoBuBpDeBPte9cgTWSgGcw7tXv0ZumNi4wP4Klle/CQ==
X-Gm-Gg: AYBFou33xvILdUPc8Fz6UHdZBSefEs8JCcZ1TqOOMI1GkCLIxVbzKLf1yHhY7Fk37H1
	993aM9VLTfwYEE6Js3zTTeBZ6mDC9pQ2dJm5bwKGhMFVaW3vLNsEzi87qULd1tNLXC2F08nO6EV
	uPcGmhc1ysaTgDXTqTUUCqIyAGTcXvAGyoSbPp3zu9AtyPu23/sJPXV8olPV+Hg72Eh5nh7Hs3z
	uggaY+Rr+GDqMkbRaP8UI8RsNZuUjmqmmDZne+jQv7IdCE1rRjyrSMzwi4Vjw6up/W/2TdYXGig
	jIVVZzQMboI0/ruWwYmBbLB9wVJyB9fNSNtKjpON5oJNEeo5jwRgEt0N8I7lTaKsER4xmr5l09N
	1mayMgWbIFNyoTgexWtZD/5mCwX4uRRk3tIi82IDVaEb1FrXRnBVsJb/hzQh65mtIjia36TTxgA
	==
X-Received: by 2002:a05:6000:984:b0:48d:c29e:40c3 with SMTP id ffacd0b85a97d-48dc29e4118mr14053030f8f.33.1791824562681;
        Mon, 12 Oct 2026 10:02:42 -0700 (PDT)
X-Received: by 2002:a05:6000:984:b0:48d:c29e:40c3 with SMTP id ffacd0b85a97d-48dc29e4118mr14052972f8f.33.1791824562147;
        Mon, 12 Oct 2026 10:02:42 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab5b03sm471519f8f.30.2026.10.12.10.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 10:02:41 -0700 (PDT)
Message-ID: <97bc33f6-1566-4449-9343-9e3463d5b8bf@redhat.com>
Date: Mon, 12 Oct 2026 19:02:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/3] net: stmmac: add tc mqprio hw queue
 priority offload
To: Daniel Thompson <daniel@riscstar.com>,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Vladimir Oltean <olteanv@gmail.com>,
 Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Davide Caratti <dcaratti@redhat.com>
References: <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
 <20261006-stmmac-mqprio-prio-offload-v5-3-d7da93419784@oss.qualcomm.com>
 <ase3UrUehtLY6b_5@aspen.lan>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ase3UrUehtLY6b_5@aspen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/26 17:31, Daniel Thompson wrote:
> On Tue, Oct 06, 2026 at 12:46:27PM +0200, Lorenzo Bianconi wrote:
>> Implement the offload of the tc mqprio hw queue priority in the stmmac
>> driver. When the mqprio qdisc is configured in channel mode, the MTL TX
>> scheduler is switched to strict priority, and the PSTQX/PSTC priority
>> bitmask of each TX queue is programmed from the set of frame priorities
>> mapped to the owning traffic class (qopt->prio_tc_map).
>>
>> The channel mode offload requires the DCB hw feature and a 1:1 TC to TX
>> queue mapping, with a single queue per TC. Configurations with AVB queues
>> are rejected, since forcing strict priority conflicts with the CBS
>> algorithm. The CBS offload is refused while the strict-priority scheduler
>> is active, and so is a channel count change that would enable an AVB
>> queue.
> 
> I don't think these CBS offload checks are necessary. It's quite reasonable
> to mix strict priority on low priority queues with CBS on higher
> priority queues.
> 
> In fact on the hardware I have (TC956x) the lower priority queues don't
> implement CBS so mixing AVB and DCB queuing (whether SP or ETS) isn't
> just reasonable, it's pretty much unavoidable when using CBS!
> 
> As a concrete example of combining mqprio and CBS, the following works well on
> TC956x (when I tested an older version of your patch):
> 
> --- cut here ---
> tc qdisc replace dev eth0 handle 100 parent root mqprio num_tc 4 \
>      map  0  0  0  0  0  1  2  3  0  0  0  0  0  0  0  0 \
>      queues 1@0 1@1 1@2 1@3 mode channel hw 1
> 
> # No CBS for TxQ1 means we can't offload this (h/ware stays in SP mode)
> tc qdisc replace dev eth0 parent 100:2 handle 102: cbs \
>      idleslope 800000 sendslope -1700000 hicredit 494 locredit -1049 \
>      offload 0
> 
> tc qdisc replace dev eth0 parent 100:3 handle 103: cbs \
>      idleslope 400000 sendslope -2100000 hicredit 247 locredit -1296 \
>      offload 1
> 
> tc qdisc replace dev eth0 parent 100:4 handle 104: cbs \
>      idleslope 200000 sendslope -2300000 hicredit 124 locredit -1419 \
>      offload 1
> --- cut here ---
Given your later tested-by, I assume you are looking for future possible
improvement?

Also it's not clear which revision you are referring to: AFAICS this
patch is (attempting to) refusing CBS + SP since v1?!?

/P

