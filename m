Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A54E3C5856
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788736636; cv=none; b=DGfp62RYmUcFpjVHAlwUipS4Qrf9y/UmHdLuCC8fzlLL2HMNgvbqW43iONr19p44djStZxn6q18BnsA/lN7WxJFqMDxE7N77P2gdPPa8Qy/D7clyFzClPi40pD8SLWzrdipFjaRu8xJL+86N/mu4yxQAH5r3tCxWycfyjI3SErI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788736636; c=relaxed/simple;
	bh=Kn2an4UgoV9oapRFIFqr6zIuyrpL8cpztNPculK4XS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLGR50gomIufHJui+Cqhl9gDOPHi5/ziBwsbow1a/OoRTuGHyoxx3QaO9RcqE3UGDs1s4MCLhV/t21RaNmiEmfym6j1SCGM4p+MBwSrO4s1XAbu6pYagIMHDqRPnPqJUJowYKupYLYWuniyytmvABEFMPX4Xc5vKgAKbS7fMq7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6RVOG4c; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6RVOG4c"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso28731365e9.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 16:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788736632; x=1789341432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zqq6+2YqOOspGjw7lQ1tAUoqTHlrvoAXLTfWbJE6nSM=;
        b=n6RVOG4cS/q+uqPU8X0/6cOjlhTOVM8ds/96dpr4Yaa6DSXtUf9Vbxr4fL+4FuW0rV
         4UI2uGdUMEjsBDECTcioQaB1FqnbXUiJn02mKefMIzzrzwDjf+Ti3E/eLbQhCMPSs89w
         6BtaaIipqrb8x+bw85TXkHw6xP92MkmNwvDrxaew006xXvoonc0WVhQpeSpOQ7xYgAmx
         MiXs8lVTqnU3KQqsVcz5SERsOnQoEaC3U0c6/Kw59sV+mfu5k0ZcI75kVe8gifgpnmtr
         C7RoeTuN7yDMQaT3ECpMY3VeaVco7h/eSm9oCFvAd1cwX6x+V2M4/+85K85Jczvw+99M
         bgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788736632; x=1789341432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zqq6+2YqOOspGjw7lQ1tAUoqTHlrvoAXLTfWbJE6nSM=;
        b=WNfap4jeTex+2w9br1pkHW79m4QJMZEeImrqskF056ha9BZY+3f3+mM9hm+K6iEXHd
         RIJkpI7eKHi7muBZBgU0wBwyVE6ZRudkDPp2KCnvsD1zpMCMXkBod6sF35k/T13uvFXz
         cix6h4gw9KLmAyNOcEyb108bYgdWFOsKZGxV3PsW564eOE9GaXiqeXozN35/h+a3m3DG
         WK6f82xQNSyHqfd/UDxmTWTqHk/R5rr2SRE9tuKIRD+Obt7ZcWwGRX1/OP2+6uL22TzD
         5I0VgNwOqtYqAoAkSDc85ngjdHUoYrtP4tQTGRsX6DsfuCvuRM75aefw/7Xb1LGnJ2EP
         Ukng==
X-Gm-Message-State: AFuF++l3Hp7zYjusFqXGN9xbMHhNFDsn957z47lmHyNepjVv2TDlNi6p
	yAgqzJ43AGm9jhzlgRouCaDjjDZKJXiH6EJy6urHuQE3l7/3LIq87fHpw8PYuYVEvT0=
X-Gm-Gg: AYBFou09uD/k0S2RPn66h/xYp1QYoIen/4y6XF6k0pdifHzbz735x3zAboM57cVTS/n
	5Zr19da5YH7ga6BmOe8hd187mKN/8ThXqgKQ39WZPNrFOCgL7FygO+st/056qZBzXmyVGUkCnaF
	cuM5irNGRHt+XWfjEAut36b+iUgvNQXdCTwI2zBlx2cOfgTH0T+iIFsS9gkAuQUh6yvwg1QasT4
	UC3RpUEY1L6B3g6pD2XziW4icbIGT82mWnRatK0lLupa8CBRU+yUvKHtfBBmybJ1zA74qXXjbvA
	HWGk8PilUUO1jozK5EW7yVCa5Vhf2S1VZhRxnDx6zI/ih0PIBGP+z+cH00T9gJQeJV+Zao2qYEq
	Ei0aH77l+EwZg0TBBQBJs836SSzo04BhTVVNOzkK/v4V60fmLFZGH/JMkmIg28wMeVcwy6FGuV6
	qEcDT6fQ9NodYSCGJ2IyUL66QBv5Am8b6/CAtwDOjCrZqsT6TyDdCuAwYUQznxE3WAuhv3YUebt
	VMDzRUPWFjdTg==
X-Received: by 2002:a05:600c:3105:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49cf82bea15mr182183965e9.1.1788736631922;
        Sun, 06 Sep 2026 16:17:11 -0700 (PDT)
Received: from kali ([169.224.126.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d0656e7bbsm162702315e9.10.2026.09.06.16.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 16:17:11 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	idosch@nvidia.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	Ali Firas <alishmery18@gmail.com>
Subject: Re: [PATCH net v2] vxlan: vnifilter: validate the VNI range in vni_filter_entry_policy
Date: Mon,  7 Sep 2026 02:16:09 +0300
Message-ID: <20260906231609.2995559-1-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902154609.594009-1-alishmery18@gmail.com>
References: <20260902154609.594009-1-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I tend to agree, either this is a security fix and we need a stronger
> check. Or it's just making things slightly better and doesn't deserve
> Fixes/stable.

You're right, and my justification was worse than incomplete. Sorry for the
slow reply.

To be precise about what is and isn't real: the loop's own bound genuinely is
broken at END=U32_MAX -- v is int, end_vni is __u32, so the comparison is
unsigned and the loop has no exit condition of its own; it leaves only via
"if (err) goto out". But the wrap is unreachable. vxlan_vni_add() allocates
for every fresh VNI, so -ENOMEM ends the loop long before v could wrap, and
the delete path stops at the first absent VNI with -ENOENT. So it is not a
non-terminating loop, and the changelog should never have said so.

What I did observe in a 2G KASAN guest was a global OOM, and that is a
resource problem, not a control-flow one. The clamp does not address it:
START=0 END=0xFFFFFF passes the new policy and allocates just the same.

vxlan_vni_alloc() uses plain GFP_KERNEL for both the node and its per-CPU
stats, so none of it is charged to the caller. By size -- I haven't measured
the struct yet -- that is on the order of 192 bytes plus 64 per CPU per VNI,
so a full in-range request is a few GB on 2 CPUs and tens of GB on 64, from
one netlink message, by an unprivileged user holding CAP_NET_ADMIN in a
netns.

That looks like the same class as 1beb81947eb4 ("net/sched: account classifier
filter allocations to memcg"), and __netdev_alloc_pcpu_stats() already takes a
gfp, so no new API is needed. One difference worth flagging: that patch also
had to fix a real error-path hazard, because cls_basic did idr_alloc before
alloc_percpu. vxlan doesn't -- both allocations are inside vxlan_vni_alloc()
and return NULL before rhashtable_lookup_insert_fast(), so making them
failable exposes nothing new.

So I'd rather split this:

  - GFP_KERNEL_ACCOUNT on the node and its per-CPU stats. This is the actual
    fix. Given the difference above, I'm not sure whether it belongs in net
    with a Fixes tag or in net-next -- happy to go either way.
  - the range validation on its own, to net-next, no Fixes and no security
    claim. Its only real justification is that vxlan_vni_rht_params already
    declares .max_size = VXLAN_N_VID, so the netlink edge never enforced the
    bound the driver assumes. It does tighten uAPI: requests that used to
    succeed with an out-of-range VNI will now get -EINVAL.

I'm measuring the full in-range request against the accounting patch before
sending anything.

Thanks for the review,
Ali
