Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA16230F7EA
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316841; cv=none; b=GI1wMcsyXYKNMvbKEaoodZYT6DvOBaY3zLRC75s/+QIAR5W830Tn1tfgV4wCiBwaMOpV8WT+Pbc+97+d9gaNzZnVruDuLVH8M4Pn1jWVvAAQe2wKGznXOo9M6SgWSEtHX+58pkqrXpF3MYo3CN9VrD2blEXPgznwDHQIzlK2gbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316841; c=relaxed/simple;
	bh=J1aH88llf8FGzGtOEp1PB0UZsD3PdHm8oQjfHuq5lq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUujpvj7Q+MrDygqTaF6ipVh9528NDtwZaEwCNQJauGkOZfOs97vnE2/WyAEvxxXxoyv1bKtmD1nLU22KBW0PbgqTfz2qClGJxE0MJQYKkb+Zi1D/EzFF65FKH8Zbyp5f0G+A4ZdC2m7GIzKFT8bq/9YkuQ7i22qbXuIkF0maKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553b57612so1313295e9.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785316838; x=1785921638;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gZ9PZg5ZyD2hZRV/boMAiZrB/9qvrZ1rOIn/l5ujZzU=;
        b=F/ISEbRZ1+gvG37YaiLQm9zybw884/lCAH14UOfF3o7dw1iRwhX3QBIE16Rp/5jcR5
         iX/2yI9Hwl7cnSUUkNy1GS+Ho94V8Khautv4waL6f1u36Z2C3pK6ofcVMMN91KftM4uw
         eGNAZDQw0WH3j99tN5oPe3MWLYnkoRUptY/J6I1grSlcBSxQCFMvUOLqDVP4bxDVQzLY
         tNBSUhFr4i1KTy5ZtNjuV13qWWf7RxKoyn1+h4DjYyYM91Iw6LF6Oy/fs6+RqS9lcDK5
         PLLToG8LkKjp4PlFe/VxtNwV05NZEb86WOeBR5oZhMLlitpiN+0CRZpiYh6Pa6xMXmAv
         6WUQ==
X-Gm-Message-State: AOJu0YwBRSgF92E7OxhN9xG7i9zIHy6VV3zijh+/Tf9eiwS0VKhdBgY3
	uuSOeDBIpjJe/XleNitdC9Y/IxCwZ4zOIEWoeIYGuypb/5YY+KPOi5pqCC9u/QfF
X-Gm-Gg: AR+sD10sI8K2M3FWhGa0Eg7ZSthS3X+tInAgNwPXhrq6j7l8RosyrKubd7dCNI8AHeL
	YD+qpV0DroMVsRGcqvKU/uuKarsFK2LJ/v6fqSav9Cah34nRyknDz4q0P1HyDTlWTs3QRNWtA/Z
	dyJixIXTlLE9YEzuA3ZIDfoOd4ppjjNxfDiXcefoKbC5A+wx5tbHjggv9BDCoJEn410bQbYx76Z
	TVN2eplWA6FsFwR8CCCBaIVan6dujsKYyz4qywwL+lyC0lH/b9fuptYMvGs2TYy3OHmkB8beSQA
	va+pOumxG9CNjPAz2nWQlTSXB4eQo96QoOaLAT3PHPXbjkqpWYm27yVRChQtOK+u3sHkqvjLJQR
	5fvsRllWKTCOCS770OvkSUXY0TRDLrvEtNxwbgDxoEGFja2m38FO+sc163NUQ0fE/zcNBWJip+J
	3UmDk/EA18Rsnaov9nxOFRKCZtbgBCBi35X7civ4uS5CfE1H/l0s6K+kALU22UZSZQsGE0fwWwv
	m6PdljfLvr314oA8g81H4YIMA==
X-Received: by 2002:a05:600c:154b:b0:495:5e86:4e11 with SMTP id 5b1f17b1804b1-496c64262ddmr63098075e9.12.1785316837522;
        Wed, 29 Jul 2026 02:20:37 -0700 (PDT)
Received: from [192.168.88.241] (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49764d8e826sm49100205e9.8.2026.07.29.02.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 02:20:37 -0700 (PDT)
Message-ID: <3f3a5a70-5f3b-4271-82e6-278a68fdb8cf@ovn.org>
Date: Wed, 29 Jul 2026 11:20:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: openvswitch: fix stack exhaustion from
 unaccounted clone_execute() recursion
To: yang zhuorao <alexyoung0@163.com>, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org
Cc: netdev@vger.kernel.org, dev@openvswitch.org, pabeni@redhat.com,
 kuba@kernel.org, horms@kernel.org, edumazet@google.com, davem@davemloft.net
References: <178530596969.1425642.13386639281745710112@163.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <178530596969.1425642.13386639281745710112@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 8:19 AM, yang zhuorao wrote:
> clone_execute() only increments and decrements exec_level when
> clone_flow_key is true.  When clone_flow_key is false the optimized
> path reuses the original flow key and calls do_execute_actions()
> directly without updating the recursion counter, making those layers
> invisible to the OVS_RECURSION_LIMIT check in ovs_execute_actions().
> 
> A single action tree allows up to OVS_COPY_ACTIONS_MAX_DEPTH (16)
> nested clone actions.  When the innermost clone contains a RECIRC
> that selects another flow with its own 16-layer validation budget,
> multiple trees of unaccounted recursion can be stacked.  The deferred
> action threshold (OVS_DEFERRED_ACTION_THRESHOLD =
> OVS_RECURSION_LIMIT - 2 = 3) allows three synchronous recirc levels
> before clone_key() forces deferral, yielding 3 x 16 = 48 layers of
> synchronous, unaccounted clone recursion.
> 
> Per-layer stack usage is approximately 296 bytes (from disassembly:
> do_execute_actions() allocates 0x98 bytes, clone_execute() allocates
> 0x20 bytes, plus saved registers and return address).  48 layers
> consume ~14,208 bytes before recirc, flow lookup, Netlink, and base
> call frames, exceeding the 16 KiB x86_64 task stack and hitting the
> guard page.
> 
> An unprivileged user can trigger this from a private user/net
> namespace (clone(CLONE_NEWUSER | CLONE_NEWNET)) by installing three
> flow rules each with 16 nested clone actions linked by RECIRC, then
> injecting a single packet via OVS_PACKET_CMD_EXECUTE.  The result is
> a kernel panic:
> 
>     BUG: TASK stack guard page was hit ...
>     CPU: 0 UID: 1000 PID: 85 ... 7.2.0-rc5+
>     RIP: 0010:clone_execute+0x5a/0x2c0 [openvswitch]
>     [do_execute_actions / clone_execute alternating repeatedly]
>     Kernel panic - not syncing: Fatal exception in interrupt
> 
> Fix this by extracting the exec_level management into helpers
> ovs_exec_level_enter() and ovs_exec_level_exit(), and calling them
> unconditionally for all synchronous clone recursion edges.  When the
> limit is exceeded the packet is dropped with a net_crit_ratelimited()
> log, consistent with the existing handling in ovs_execute_actions()
> which now also uses the same helpers.
> 
> Tested on Linux 7.2.0-rc5+ (mainline HEAD 62cc90241548), x86_64,
> CONFIG_VMAP_STACK=y, CONFIG_OPENVSWITCH=m, isolated QEMU guest.
> Confirmed that the PoC (./poc_clone_overflow 2 16 3, run as UID 1000)
> no longer triggers a panic with this patch applied.
> 
> Fixes: b233504033db ("openvswitch: kernel datapath clone action")
> Cc: stable@vger.kernel.org
> Reported-by: yang zhuorao <alexyoung0@163.com>
> Signed-off-by: yang zhuorao <alexyoung0@163.com>
> ---
> Changes in v2:
>   - Extract exec_level management into ovs_exec_level_enter() /
>     ovs_exec_level_exit() helpers, consolidating the recursion
>     check with ovs_execute_actions() (Aaron)
>   - Add net_crit_ratelimited() log on limit hit instead of
>     silently dropping (Aaron)
>   - Refactor ovs_execute_actions() to use the same helpers
>   - CC netdev maintainers
> 
> v1: https://lore.kernel.org/netdev/178521875706.803907.3226960398667307795@163.com

Please, avoid sending new versions until the conversation on v1 is concluded.
We're all in different time zones and it takes time to analyze things and to
respond.  Posting new versions right away is just wasting time and CI resources.

Also, since you're sending these patches publicly, you should not involve
the security team (moved to Bcc).

Best regards, Ilya Maximets.
