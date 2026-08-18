Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33014ABE
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787021073; cv=none; b=FB3RP8qaWQjs3zxWBRjFRovPZiyit+vBieookOJiNADC9kskGXebnNuFWppKuJYgdoklNecH5ai9Q5SHX0SkXmwmyibW4nQCaFHE9AnL3l+0SNHdvryvfQb8Hk+DgmYkPHsDKTGIDz+XDtZSLzHkoeJSWbUYuCzzOHACNqgk6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787021073; c=relaxed/simple;
	bh=pcopF7mH5rO3w8vdqsFe5xTCi1Qe7q3zoBcrZOqbB9w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=D3IVGv/I/IiursnUnkp4jquRUXr5M/ZMswemJ8KZjuIBIont6Cd6KshGpA7bRTr01DdE/tGyN32rIt3HN68M3S9zWtmd4Wm4LfJ1WuOCHW+4DqbDRA9vynJ/j/iyyH1RueGdMSefRoDcBzaIx9pr2xW7qEAo1kRlV6jFLGQYZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMX81wuf; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMX81wuf"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836c718715fso49023377b3.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 19:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787021071; x=1787625871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uB2wZxBX8MEWyapT/Ph8B9oRqGfQi8DHtHP6Vf7bW8Q=;
        b=pMX81wufR0Nm8qUhWC3RjojXII0UjYoIee3Cm9lLso2QmZ0FTb584IPOC+zRP/zzyG
         mYOaryF567o7nuHDiW3vAmgkeQHWhVr4XKV33F4YMnBFok9TpFY1mzv6wFpkClwhjX/7
         JQgOn0f8xezUqiWDaDZIJ/jDpNYx6wYo6kAS0ydDvK/PH4Tw4y85k6RGFvBdAW28Biwk
         Akzh4jKL7ntA/VrA0EDPNGKQM3DsMCsehhCJ3LCsNaOHPLk+2E5Uj17mLalKpDXZwNzG
         San0NOFAFb8Q7cW43c32ZA9+adIaFIIHKVXjE0mZ01g9KuAd6IW4JISD2jnRzdKzBrpz
         mwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787021071; x=1787625871;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uB2wZxBX8MEWyapT/Ph8B9oRqGfQi8DHtHP6Vf7bW8Q=;
        b=Icdvja2Ugbi7HtXcpSkqoooHWA2/uIMTTQHeRfAYFYI9QXdjHS0n9ADTOffSpOu3B8
         iT0daPRm5TYdnGjaCJEetJuF851BIiqoBQoLWd3v1PW8eHbuO7vrwC9COwhVb4CxjSlm
         YJ3XvnAo8R1t/NJ32LJFyLAriCvJEeCrll+KjQ/h7+wDNT++QO+tN7QV8hFCl7KKz7pf
         vDf5+5JAA05SA84M2Rw9Bj2It7/Q23XCXMIVosBwmke9haKXN6iMBWWvwqvyo4a833iT
         JXYDTIVAbUVqZA9NFufDfi/QmMJM+e8Fq7yYhT8ZfUULqPFcgGMgnL2PiNUVXkbHiQN0
         N65g==
X-Gm-Message-State: AOJu0YzTssVDMjNPgl+wDjc6Xwg+z+tuE1DGtFbfTGHbxyB154baXViN
	NvkFd4upYHl6OeiK4tuM3pZkutKrQdjGW3o0zSqCpT5TExjtAXr1deuA
X-Gm-Gg: AR+sD13ICAk6NOsG7Pzi1rXJpO3EFRFM5Fze+TY/ZlfveAE02pQDnN9nX+rfwehWvQy
	2zmYELjB+YsO7tifoJCKnsPxxnWvb3xjqfJMTQg18/xHeLfC7wgQpTmfElbTXqSDBfsmECycx5Y
	pUZSYo0GlRKHAY+kVvHiNKYBIWjGFXlV8y4IuK9obhJYlYnK7eopOm+af6XgtW1/hIJvzB+RvS9
	OnEGF1fs2HqitbTARae+W7jqbVnCEfjtXibH/Hi0R+uPe6O9vCITliAKwK6394ifURomjvRnr8V
	S2mycPd+tj6X45sijSY2bFOEg3NgmfEc6bNOO2dXHR5JKldCfibMU57K+RcMAAt7Xs9ifpM9hdI
	z6mzgyQIJE1NDosLQkTO98TX1xwgmsac7iAP4s0uqN1O7x+fvrU3bWka9pywnwzbTgZkXUinIVP
	R7kxQ/pGRjnDslGRxCXqx1m77q0xN92z5uCtP/Wgv5WtvfXCPVr72YK8eyHR5W4lZxWwS1UvsXI
	H19jCCBmqefDgDwIEHjZPxXkRuBi39cUv8OZkT+Aw==
X-Received: by 2002:a53:b6cb:0:b0:667:c3c0:f2b7 with SMTP id 956f58d0204a3-66c72bb3e7bmr7139790d50.19.1787021071364;
        Mon, 17 Aug 2026 19:44:31 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cb47809d1sm1668235d50.13.2026.08.17.19.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 19:44:30 -0700 (PDT)
Date: Mon, 17 Aug 2026 22:44:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.8f910d53181c@gmail.com>
In-Reply-To: <20260817161250.1ca33d86@kernel.org>
References: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
 <20260813020529.3506539-2-willemdebruijn.kernel@gmail.com>
 <20260817161250.1ca33d86@kernel.org>
Subject: Re: [PATCH net-next v6 1/6] net: rtnetlink: add
 pacing_offload_horizon attribute to net_device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Wed, 12 Aug 2026 22:03:56 -0400 Willem de Bruijn wrote:
> > The 'max_pacing_offload_horizon' field of 'struct net_device' represents
> > the maximum pacing offload horizon supported by the device.
> > 
> > Add a new field 'pacing_offload_horizon' to store the active pacing
> > offload horizon.
> > 
> > The new attribute is initialized to 0 (disabled) and can be set from
> > userspace via RTM_SETLINK up to dev->max_pacing_offload_horizon. This
> > new default off behavior does not cause regressions, as no driver yet
> > advertises max_pacing_offload_horizon.
> > 
> > The attribute is omitted from the newlink request spec, because the
> > value may need to be bound by a device maximum that first needs to be
> > negotiated with firmware, as is the case for the idpf driver in this
> > series.
> > 
> > Make both fields u32, to maintain net_device cacheline layout. This
> > expresses up to 4s of pacing offload, which is sufficient.
> > 
> > Update the YNL specification ('rt-link.yaml') to add the
> > 'pacing-offload-horizon' attribute and include it in link-all-attrs.
> 
> Forgive my slowness but I don't get how the new param squares against
> TCA_FQ_OFFLOAD_HORIZON. IIRC in v5 review I asked something like "should 
> this new option be a boolean" because the exact time horizon already
> exists in the qdisc uAPI. As AI points out (among other things),
> the two params are not synced in anyway. User can configure qdisc
> offload higher than the device level one.

They cannot. Or at least that sure is the intent.

After this patch fq tests against active limit
dev->pacing_offload_horizon:

-               if (offload_horizon <= qdisc_dev(sch)->max_pacing_offload_horizon) {
+               if (offload_horizon <=
+                   READ_ONCE(qdisc_dev(sch)->pacing_offload_horizon)) {
                        WRITE_ONCE(q->offload_horizon, offload_horizon);

A manual test to replace the root qdisc with fq offload_horizon 50ms
seems to verify this: the command fails unless a device limit of >= 50ms
is configured.

Perhaps I don't understand how dev->pacing_offload_horizon
would function as a boolean.

> In fact any non-zero value of
> the device one acts the same - hence the bool question.
>
>
> Why do we need both? How are you going to use this new knob?
> The commit msg explains the what not the why.
> 
> My naive understanding is that the main missing piece is a handshake
> between the driver and qdisc to tell the driver that the qdisc is
> indeed offloading pacing on queue X. And therefore the driver should
> pay attention to the timestamps. This does not require uAPI changes.
> 
> >  python3 tools/net/ynl/pyynl/cli.py \
> 
> uber-nit: python3 tools/net/ynl/pyynl/cli.py -> ynl
> (the CLI is named ynl when packaged for end users)

Should this also then point to the (default) installed spec path:

       ynl --spec /usr/local/share/ynl/specs/rt-link.yaml 
 
