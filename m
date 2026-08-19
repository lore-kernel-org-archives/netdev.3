Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A0F3C1D7C
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129440; cv=none; b=FDdlaOQDtvSvOsGj3auDEp1IjSF0Lmh89qhevmKLind0WZ5fRG9dSWZ9rSIE12t5BLv9I+NSb5UErdi0Zgg1/VdlbY/Z3lz875d63Hfbd+frY4GaMLtBo3YmII7lkXG//h6K8872CzO0Rl82VwtZMhfjzum15OeEYLBOC6zDBBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129440; c=relaxed/simple;
	bh=So5IbViF9LFyXxy230v1ixqUAWB4/JrVKy6ngXjevpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWP0dS8v7ncazJuCEouVBFx7RHaco0IN4wj170BT9tzLlT3Qu3q6jynrMgCAsu8Rj9k46ejycZuCtucnvrBr3yNzUnDrqqpWQfprdXZZ7p0OfEKpghIlvNIaezNQ5Nnn8YKM4fC+kjZmpj0XDdtuvw7lpxkW8YIXxLiBlV1RNUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imoGpgRJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xqa9pnH/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imoGpgRJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xqa9pnH/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787129438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KzahBh4VmXVQert28d6nftv0k38yoDFZF+6i2Q9FYns=;
	b=imoGpgRJlxyNKncLVHwyKvQVbVXJlq04ePwdC4oQlhf2dvicpv9U7G58mdjXzWPXrq5aD6
	PYW1JUIeCKeMpzd4B5UfCx9CEQSxggFqewwAx2KkRHEo9baaaqFQqXXg+LEYZ0I6FGR15U
	x+AnMCZuX0z+nkrVbK4yoYyeGrewQwA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-xFlerYS0OS67w-lGSJH9Iw-1; Wed, 19 Aug 2026 04:50:36 -0400
X-MC-Unique: xFlerYS0OS67w-lGSJH9Iw-1
X-Mimecast-MFC-AGG-ID: xFlerYS0OS67w-lGSJH9Iw_1787129435
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4814806ab89so1235536f8f.0
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 01:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787129435; x=1787734235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KzahBh4VmXVQert28d6nftv0k38yoDFZF+6i2Q9FYns=;
        b=Xqa9pnH/2GbvWwRFYzKbelw2A87G0j78gDYC54YVlFL8Wa57nA8j22vJqYREqLvjhv
         9CA8qw1QsYKYux4rS7q1mnNkjCOoSajlgAcmr5pykCFGNQoFdpC5zJ3DiiI4l5a55WHO
         PQ/O+wV9ExpmF/jtEM+YFJCKuPCCrs7AXLRNwdMqqJxkO9Qtg8I+vPXo/SZZS3klAeWQ
         CLFGQ/hbJbk0jr54RdawEvjInrQT9XRM7XJJAPuY4pcnyFC0h1cnO23sj/t1hyw4yI7T
         QH0xpMp22lu3/q2SqNRMWfGG4COUsXsEZkc9gDBaQgl/BLuaQJne/56VfViwxisofkB0
         Amow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787129435; x=1787734235;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KzahBh4VmXVQert28d6nftv0k38yoDFZF+6i2Q9FYns=;
        b=ZN7KYw5oqNMAfXSvi77ScEw7zS7rwJSN1dkGWbPg7NVz2/w3BiW/cuT7olOjTp3oB8
         XvVLsWQEBQQA44NF58g7DRuTLefPUouK9+UBM17nfGhqWO4Jr4it1tcSMNPCwPRUiHfS
         TknxXnJUeDV1eNzNwAk5xWEWd6bEzLYKw8DAAQd1dmijhqVoUZ0v6UOEbl/wBGn2GMkU
         Gur0olKr9mVhTn25rajxgaOTn0aquPMErgA2lM7Q1pvzHM9oU9eqn3H996RRTdO+SsfN
         KqXI1jpvO8L+jT3oV3NHUU22XgC32XaldcJ5CXVMCfSrz0rtSiY9oZnNWSoxFTAAQ0R2
         GXkw==
X-Forwarded-Encrypted: i=1; AHgh+RpLuDdVbqPiWMafUEOUEU3Ay9PCEZNgzy/D3iS9IEafmj55oR4TgVnOdwgPZr5dVcMjo8Rwt/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfHcL7jYi0mObyTcJpOBgsmW3Wd9tR7QEmqRMUpYhR9C0ByWiy
	Qu0MK/4hqy8Nc4i71fgKhi2TMWYPES/axZW3ewr9eZ48GHPgmZIoGt3P1enFDzlAfW52eDA6jQ1
	pTpIJO8IZrScwrQbHlcnVVb4o1V41Bkj1JElM4YtEm7uo/s9mV+mnVSc7bw==
X-Gm-Gg: AR+sD10SjnHXCsDIgENf/CrICaKVjizJ74qnEvVtiBa4Ddz/vldyZdeJk7BdhHo4CjI
	gmpyeaJ+mmIJTFDXJzLNvc89ffXlFgVtCyH7u75IL6zjc3Djh7iwStNo4Iv/aSqD86IAMDs3rRg
	a6u8zTqh9UWXDww4mZ4YrI1nZHamwGEzhjbh5LIXx06RaqLuqMBiWYhcV0m3CendYmhLtbDvl9B
	+v4lzsUAvA4kcedsogsOHnMQnmmtg5SHX4MPJ2iL/J1sussXooKJFmULDqR/7W/I4lG12ILcYqo
	IVuGvD/z1cPD9/gKLMYhFMMbMiyzSWRW7aWD6Wq/Z/XYHeRVjF1JvBtZGoFF1P8PVQG2ph1Z3VN
	aY0azayEpGg/mF8V4YWs6cPDw6XiN6z7J+hh8DiJGP1faI4uzCZcl0URHHcbp0Oosw6PRcZyhTE
	I=
X-Received: by 2002:a05:600c:5943:b0:493:e543:1dd9 with SMTP id 5b1f17b1804b1-499aa11e5famr32993475e9.9.1787129435037;
        Wed, 19 Aug 2026 01:50:35 -0700 (PDT)
X-Received: by 2002:a05:600c:5943:b0:493:e543:1dd9 with SMTP id 5b1f17b1804b1-499aa11e5famr32992935e9.9.1787129434587;
        Wed, 19 Aug 2026 01:50:34 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b144173csm4419412f8f.6.2026.08.19.01.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 01:50:34 -0700 (PDT)
Message-ID: <e204fa6b-90c4-4f53-a989-aa4f1843b61f@redhat.com>
Date: Wed, 19 Aug 2026 10:50:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] vlan: fix skb_under_panic and races when toggling
 HW VLAN offload
To: Eric Dumazet <edumazet@google.com>, xietangxin <xietangxin@h-partners.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, stable@vger.kernel.org
References: <20260811085246.2267779-1-edumazet@google.com>
 <64a0b57c-040c-4703-95eb-886701bdf745@redhat.com>
 <492adef9-936e-490d-ba1e-3d026ff1223a@h-partners.com>
 <CANn89iLdXQGiLRFTjZOiskWhyKq9nOQJkQ_OuLCHhWw5h8W6kA@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CANn89iLdXQGiLRFTjZOiskWhyKq9nOQJkQ_OuLCHhWw5h8W6kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/26 10:07 AM, Eric Dumazet wrote:
> Regarding the reorder_hdr=off finding from Sashiko:
> 
> 1. reorder_hdr=on is the default for VLAN devices, which continues to use
>    __vlan_hwaccel_put_tag() and HW VLAN TX insertion offload as before.
> 
> 2. For the rare reorder_hdr=off configuration, the intention of the flag
>    is specifically to produce inline Ethernet headers, unless I am mistaken.
> 
>    Previously, whether reorder_hdr=off generated an inline tag or used HW
>    offload depended on whether the lower device advertised VLAN offload
>    at device creation time.
> 
>    Using vlan_header_ops unconditionally makes the behavior consistent across
>    all lower devices without changing the wire format.
> 
> If you prefer, I can send a v4 clarifying this consequence in the commit
> description.
IMHO it's not needed, it is enough for me that the implications are
known and well understood.

/P

