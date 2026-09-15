Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0243B05A7
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467801; cv=none; b=foMANsH5t+dscFTUlkpQc6BRRLHJ0fhrxhbDtsltTJEqLya3DmwMIivH0VrbAfdSfzA9TiWbN87sdEM4RNYNe4zz9oWRoN02ytWDLLgO5E0OMfXsxn9aWi+GDZtxPtpio8PHZ1wgqzxJCVTaIi+DLACk6m5nICVEVnjEYeDLquY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467801; c=relaxed/simple;
	bh=VOUBpyRp34OXryxgM5Zw0tpiAqDS/kFSwbZiQ9LEYEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOlXG6GSY6M5ZcfDfBYu1Ch8RXmf325fE35haQUyHKOmpguFzbfqLWjNzaLK4A4o654nJbA+crtJZVbASW0AjYhSUPaIo4VINml4BlNGCfdesyyTypca1XtvMPMwulC/Kf00Zwn/n6eOQbgU5Rl8kkBEF0V+pwmiSEq6JmDPelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YncPpsIF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jy/QMBWF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YncPpsIF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jy/QMBWF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789467799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8iyB1VIdARn1Y5KDniNBe9GaBJ6kkLcc88CEhktHYls=;
	b=YncPpsIF9CsH5HhfpGfNneFzjeWtjBBi4xknOzuRya9ioZYSYD4Y/r4xCtkuocp/zXju8i
	/Y8z/caR0REibmfiDWw/NYDoFI/gDFd0CCaJ/Wjoth09kNeuNfJMUYmxwlnO+BfHyWGjVw
	uiw/5qBIoME0+TVORfHXAmoGWLh0Q3E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-1BlwAp6FM8KglvxqnzEW-A-1; Tue, 15 Sep 2026 06:23:17 -0400
X-MC-Unique: 1BlwAp6FM8KglvxqnzEW-A-1
X-Mimecast-MFC-AGG-ID: 1BlwAp6FM8KglvxqnzEW-A_1789467797
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e65bee41aso6915575e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789467796; x=1790072596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8iyB1VIdARn1Y5KDniNBe9GaBJ6kkLcc88CEhktHYls=;
        b=jy/QMBWFFSHaxvgNE6rdM3pt5XDllOTN1Ip+xLZ5lH+hS1XKoImYaW/iaiT3ERLzPW
         6y4fIioMDryu49ZqV64Y6XjzEYH0us7EMPa57bkI/cXXU6HvT7lq91ZRnJV1EjzqFU7B
         EVzPFwAerV6jr6JSXQsH4YJpO8F/aQw4MNDeH3zWLRQNQFr1+BMQq6YR23qtrFpVyEbS
         nSe6Q0W4eli4bT/Ky45RHnovflkAaJ7tdCfesitNYmBDV+fIggju73u89D0FLixqqlOI
         OhaHb16Vgwn7DLKddFt1CQl2kmSXh8WfNXOMBBB4fiqVMCA/q+s10w5wOrbzaQY4KKFh
         StTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467796; x=1790072596;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8iyB1VIdARn1Y5KDniNBe9GaBJ6kkLcc88CEhktHYls=;
        b=AMs1F+E7RsE5ScXltjeqpc6vKI8AEiyjFE+X+t+HjxTCmscOXBLIesTX8BsOPfXQVJ
         wraqlE0eYkEgd4FXrMvRG3ujOt80jEsz0OcfJRMyKxQ6MVgnqOczwmJtU+VL4cRGuSWn
         8TLpXGL6GM/8S53PanRwLkB5hhgOoJfiiH8ntRiMawZN5jCRphw77YADr6rjZ1FxWaoa
         0ur3WRtk0s4o/iXjg/tZn5lQ2zmA6vBdrGrl50l+Ty2VuXQub80o7ddpgykGpalZmZvb
         Br0NMx7DMqmNb2VWHCuuYD45uiWDkw2VvWqqvxvP0rmJPxGDAGk8dOh7LAo7kuIi++Kr
         y+dQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwsHtvJaAMdr+hyuDpNXqoOGYvBeTu0LRe1A/mDivRMo1guO0oJgBd0UaQv0dZKMKrFCsJuOg=@vger.kernel.org
X-Gm-Message-State: AFuF++l67O9cyalQNixFxRzRuVU87DQ89KMOfVZrb9ek4hEe2YLiRGAd
	FP7yfw6XQO3duMJe8e0gPryPOu1dBCaySUpvJvkTx2uFI1BBe1L74cfXwf/0eKUqZJRcenLql2d
	mvDubo16khXaZt8q8PjhsGuwAiJ3aKvaNKWjBhfMCZ2n6o6+vLfBsCYGCPA==
X-Gm-Gg: AYBFou2WY92XdVa6jaQT+pe9J7+o10oF5DcL+goOPI2NfZwCfUu0CM4gYNanREcrzfE
	29rD/ygjjc1bx3xTBnoct0AP6Smmrvl3wZqZo7clXn9nTs5TGxlei+FIWHLGZqseMQGzuASl5K9
	clxqJAULXY2KS6CvJv/EuY3kh7C84LxQ0AJ0711xI2QRPxz6+VmHGEAnGlJnt7x5xMR8ehpXh+Y
	/xb2xfDNWwJ8OJBPPX4C6eqmcTSmtHxj8nB0Cxh+hBHei3g4pB57FkLxrC+K9flfiAd6bdshnyM
	5aMQbLIh2EtaKi6uPgO/iN9gSupGLN/h8nNnS/qSGnUI5E9QXnOfCMWRSZQ6D+J0KTBa9eogDa2
	7sl1XcZn+9npJa3gKGoqFQVx2lthtREbgA18lKMoZ/Uf1ELcJmbb1kxaVLZaR/NqbmtcFGL+IlA
	==
X-Received: by 2002:a05:600c:e557:20b0:49d:1916:2133 with SMTP id 5b1f17b1804b1-49e7d7332f7mr26989265e9.8.1789467796474;
        Tue, 15 Sep 2026 03:23:16 -0700 (PDT)
X-Received: by 2002:a05:600c:e557:20b0:49d:1916:2133 with SMTP id 5b1f17b1804b1-49e7d7332f7mr26988995e9.8.1789467796028;
        Tue, 15 Sep 2026 03:23:16 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d66a4a3sm72734105e9.1.2026.09.15.03.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 03:23:15 -0700 (PDT)
Message-ID: <7043a1fb-fd55-4a4a-82bf-c5428f67a035@redhat.com>
Date: Tue, 15 Sep 2026 12:23:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: mst: move switchdev call outside rcu
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, tobias@waldekranz.com,
 bridge@lists.linux.dev
References: <20260911105021.1385934-1-razor@blackwall.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260911105021.1385934-1-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 12:50 PM, Nikolay Aleksandrov wrote:
> This is a follow-up of one of sashiko's pre-existing bug reports.
> br_mst_set_state() calls switchdev_port_attr_set() for nonzero MSTIs
> while holding rcu_read_lock() which invokes the blocking switchdev
> notifier chain and may sleep. Nonzero MSTI changes come from netlink
> with rtnl held. Move the switchdev call before entering the rcu section and
> assert that rtnl is held.
> 
> The call cannot be deferred because netlink needs its error and extack.
> Also DSA reads the old bridge MST state during the callback and checks it.
> A deferred callback will be late and will see the updated state.
> 
> Fixes: 7ae9147f4312 ("net: bridge: mst: Notify switchdev drivers of MST state changes")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Clashiko noted that the fixes tag looks inaccurate, should be:

Fixes: 3a7c1661ae1383 ("net: bridge: mst: fix vlan use-after-free")

do you agree? I can fix the tag while applying the patch no need to repost.

/P

