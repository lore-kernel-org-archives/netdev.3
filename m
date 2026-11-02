Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625526;
	b=STbnGkR+lqqVhESHywc3CWbX2SA4NkbUwEsvn6/ZuzFduIkPyuNR7HKpFGSJX2OfIHfn
	 aJfz20TYj+v1xDk2BMfq1Gosk/NTlw3oqykWpoTjhP9SukQ/0LMOyvXbKpjuSqGnHCwnH
	 OSKcUAYy16mY2dOpDg1HVFZ+3nwX6ixy0R37lsNtLJGhc9p6QleDQSbsJUaBpteU74Uqr
	 94E3Wtm+6sf5Vf1p2vG5nMQn2jDP0RbUJWewI7OtsBTN5rjTKNIBZa0MPD7vIeUMvhzP+
	 PyggdEK0qSCzMX9e32mPW7P1xHJ49nLS3qH7bSF+uawRY9PIbkT5T49MVkTO+KBm0KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/djIokTma7cGa0Kj/4n5LFRRxYa150VHT4D61l8dCPA=;
	b=zoY5IQ0V2gECO19laA8cER2E7g5eeZ55TjN48g08AUdOGMpwC4NyR+u62JQjpBy9D/l1
	 Awx7AxvG0LQDyaRv0n3MOWZHa65ECJIHnveBAzMXYXSNHKD/zfkXYPbAIyMjhhpTzQBMu
	 g+mBgMYMFoqh7oo2d+/5gqN7vHe6x4Auo3MlO/N16BRt2/5UfMn8NPtKZh+CzMQvveCR1
	 tcEXI7lZef0O0x+/QzqisA14ryAS2BpEhRrf4wQWnkpx+Az2eCPOco9z/bboKXYJA3A4u
	 XiN2jGbv9Jm/hIB0BwPafYrCJgqdlsgW7toTw3HwTHTH41Ma1T/m6500xgyfNdn4Xpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QaNx9xWq;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8C7606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 13:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D8C7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QaNx9xWq
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so19972835e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 05:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793625524; x=1794230324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/djIokTma7cGa0Kj/4n5LFRRxYa150VHT4D61l8dCPA=;
        b=QaNx9xWqvk9ifE6aYb5mY+vkxyJcq2ZFy+uOmU953b1hasAz8Mjtr2mgxkH9IFYcPS
         OvRwjZIgWU9VYZld2h9JWGIfR2vuaqEO9U9KpSiGRmD6tEib32etFg8sg0Qu1seKSsKP
         MVyLnbJYrht6XhPTK8RQQK03xXeK7ScuZqYw2wldOCeO057MRxtghXDQo6uPhMIor3bB
         6H9d9XEhQg8sAZBCQA4tQhIH1kOtQ3QxwJLNOj0VQjTl3ScfzDLYBa1saHeSQ5QHXSRu
         Adl3Dn8/MrnTm7iA74wtvHbnk/ik2es4066wWIGAWGry1Y0wYMEl1o+OwRo13CK55YZZ
         SEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793625524; x=1794230324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/djIokTma7cGa0Kj/4n5LFRRxYa150VHT4D61l8dCPA=;
        b=AmADBYrVzj10jppfi1d9d6+ZH9vXGeCt3o2hFEPge4/BFhQbaETe64EkxiJmU7vzEE
         sC2CyCclYV4MgJW6zV/y5kY/dcd6YrN3YceY37vxCRNvmCwWka3+DbsSp57Pxl0Lmk0p
         cUbrJMVpEyXoDcyb9mY8+IoaoWspDiLL/0LqKlTsuRxGrmfAidpHiFMfKiJkSy0HpQwi
         m8ilknrdnnDefRhvrv8zKIqRLf05y8clNKQzmi4s46iilTVerkgtf8gbspHVflGcinN6
         mh72U6tNBQeDDVzrheNB08eegxKD/bRJqlPPGGsny+XJv6xc82n46AdTV6yBh5LZhJGh
         8pag==
X-Forwarded-Encrypted: i=1; AKwUvBzIpD4zwbjPSIqxo5lsr88zenluimv6AjM4lVK39AIoWXnb/nTP0C51cxZzoKw5+v2ofMm6NoI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKWtZnU/A4Dsozz2Rb/92MCVIAeSySPYFM6lbpKpQLj4J7Oady
	cz0G9HCwiECGYY5qGTb+Le/gQsflZ0RAth36EIXShSxZ8PxYgkJqRoGz
X-Gm-Gg: AYBFou0jBxc7rXqbHeeXEa3I/ozuXV5/GclTp92Fi9MTO0/EQli4p9B2Z1YYouLDJwu
	hGd6zrA9UiTzdDcwLv6tZTEg44eRXiSxRNzJc5CZvcc4UyE3MpvWmvm8J/sF0QAQBYjVa+15DcW
	V7A9GDflkvpYdLTOkV4lwCc94swV8GtgjAIEjGUs0HFD7XWhw7IlXr1409srtiznmsZJIaQRyBp
	ac+8Rqn2HaUPkyVPyTg633gpWlH34Uk1Up8DZGASibv2JKEf6Spdq6928KqNifqDM8uh6Oh1yEB
	/vp8Mb+nBY/U20JWSp53CroSkXqO4JbGME2rng054rN1QAc89WFh/cxjNeeSIMtViKj5iJfLH+A
	A4Ctl9JoG7qBurwfGq1BRHhQzB26dNr1tofG72JT6K/aI91CAE71ZLUgiTu89/4WuxK4e4RxE5V
	i8BsjyURWFA4eRrvA9RnsqjTSt0AesAbN3cMkohjBTvzYsFcS+oL6H5Nl5D/p8g5k9QQ+celcWc
	p5mSDCX7Zx22gjMEQiVtgx+kDy3XvQPXGY/mkEQwYmzUZU8QU9R4NaKPcuXO0lj60NkYErp4PAw
	WLwP2krbFwxzeNk+MOlBPyiB4pDWuUBKz/GnlnVMELhfkx/QtBkx4OPXzkw+K7i5PW+VvkS0RLo
	Oz4ntsXc=
X-Received: by 2002:a05:600c:4e43:b0:4ab:e27d:e241 with SMTP id 5b1f17b1804b1-4ac180f28f7mr215180225e9.15.1793625524195;
        Mon, 02 Nov 2026 05:18:44 -0800 (PST)
Received: from pop-os.. ([51.36.40.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7c5063e3sm336511045e9.0.2026.11.02.05.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:18:43 -0800 (PST)
From: Ahmad AG <ahmadag1001@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net/packet: account user-triggered allocations to memcg
Date: Mon,  2 Nov 2026 16:18:36 +0300
Message-ID: <20261102131836.1074942-1-ahmadag1001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179361314688.3131.15505744143383263524@kernel.org>
References: <20261101094847.664612-1-ahmadag1001@gmail.com> <179361314688.3131.15505744143383263524@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Does this fully close the PACKET_ADD_MEMBERSHIP bypass described in the
> commit message?

It covers the packet_mclist entries, which is what the commit message
claims, and the PACKET_MR_PROMISC numbers measure exactly that path.

The struct netdev_hw_addr entries are a separate case. They are device
state in net/core, shared and refcounted across every dev_uc_add() and
dev_mc_add() caller, and allocated with GFP_ATOMIC under
netif_addr_lock_bh(). Accounting them changes behaviour for all of
those callers, not just AF_PACKET, so I would rather keep it out of
this fix and look at it as a separate net/core patch if that is wanted.
