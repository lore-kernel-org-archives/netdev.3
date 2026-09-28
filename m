Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290003839A9
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619809; cv=none; b=AB0fhQDWVSxDsXTbqkwFrLW1DtWzIxsbNZYEVgHZIEWJfQcZf3WUBvHyK8U0iOCfeNCAsGydAWYCYG8GgolrtGnTOhG3xr9e40OIMdIC0rAoCrCtDJv2h9wAWfwbg0SjkgvUTgAauC9zs/0/QYo4FW3nrVl6e2MjyTCLwd7/f6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619809; c=relaxed/simple;
	bh=NKB5rqSwEt/lKn2AC1ELkAaqSFBsUp6D/aGlIYyMdac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vc2PDlSFk1/nbeRDgXeXKi0pb8PmCL2ZAznHJjBXQdgeMyGsoaDCwkZxNJTrPYBq7IGVbnvums1yTY20PIeGj3WYIk7lz5yyc651EXUTxBRP2jCAuMLMJZ+sU9IhZFkYwuqBTLeare5KvlXCkAlRNGi3985agqpAwf8EeaG4W9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=Zb4f5aNs; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="Zb4f5aNs"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49cfcf2548aso15207485e9.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1790619806; x=1791224606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NKB5rqSwEt/lKn2AC1ELkAaqSFBsUp6D/aGlIYyMdac=;
        b=Zb4f5aNsl5iwLe1FSAwNb0ycX2DrDw2H4HofWQwFBIbhCwwyILo1YciTASRLUGshbU
         +hATWqqRxaQj50ct6KhRnQZZNpD2biq0S0Us8wos/qa/FrCpGlWGYe/c6ASG7YiRfPg2
         7XFhw3gcvxPp6rsE+8y+ssuz4b4wQxCAxn/W/KLW2a30J7ICRm+v+C6Hc4aTx3W4wkYl
         BC3Ea31lnF6PQLfGwthnOpcoLU+SAzh4q7XYf3Q5YWWXYoHlWEn0KkLRaT9GZ2a+g7S0
         7It0LA4w7MvkAGGQM+3ee2n13aq1mxVrGdFHJC43/BsYdMz6V80qRiadoD2KUFXfNync
         7cCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619806; x=1791224606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NKB5rqSwEt/lKn2AC1ELkAaqSFBsUp6D/aGlIYyMdac=;
        b=NgjXcV98rGjVgEzuR7m8eBtoME6hbu9JYh4hupg1+ER0/F/+PAzY7435uGLp89umJg
         YpmhxFYwUP7Jr6TenZuELspGvfXHf9C+O9vAiKYCw4MBmrMS3cAQo0ZNwLXmhYrR1s7c
         MjS7TvMxmpQAorekz+cn+OVsmzYOyB1fJ4GGZkZEV7PpCMZqK0AUfg4Zwa0KEJHV5A9f
         +jp02nOdIkGhVUFWuHyWsPD/FyWSUtGRTHHmsJjejOEwA5yWLYW4U4NyVDkj+Zwj/puj
         yyxQJisQomnstaFbMoE6uTnoo5868nSMJnme3KXy/wT/zGhU8CHH2MAx0YYp2ttog2mY
         uLVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNVHK11luP/XbfMn5TjnyPoNOf+mD0/5/eSfllukp8FkL7s9DEr5nqjnd+igFpyh6bOrdN8kk=@vger.kernel.org
X-Gm-Message-State: AFuF++nReuDtbqqdgqsVRZOcqPezwHh/OVk5ZHax0UkTxMo0GQqDCRph
	rfMp5JyDdLA6mXgsYvvzuh5DkOIO35wh5NdBPiMtM9orSU1CYGUYOsPlk+0M8OuhU8o=
X-Gm-Gg: AYBFou0n+9K2Ly46NuKGr8+6cogjrTWAYDbRKPqmHoPBWkHBZWed1KVqPOXPWN7jwMu
	dyhyvBCyv8ILiYkEeJpCiwnoc90R84mh3F32yLJyx+7OFr+Odnp0pfsfp7CFrRCKrtLLdqSXIWD
	q2crQj2057bV3NWIcDaRxqyXwcQ3iYwiojG6+AAgAiuhuNabVqz8F+j5251VbEh7L5kY0JI2+Fa
	5o70nTTEUEjvmFlgyhC0IPF0PpoX0/VNbl/K+NiKGqdy0bfHlDd7LTqGk4ysRBY3vbBeiSinSTh
	D8l0VQONp2Ori7c6LjuX7VdvohaFlQWmIsRiJWAxdB32JX3UDolLqBoPhqc+LeAjlzrOTcpAWxr
	G0ZYtLUVpEiKsenOGq1+My+IiIcsxPwKsP9rme2GEwhcEMNEFoOFmXrl9d7Ecl85QVLh9nQP8/T
	ZU6D/4rGf2u0/LOsUa4awYan2X0tlD1W8sSu9U0/s/WqMK/vAt1kBfCT4ai8L6VfIwMBG6fuXEy
	koborabVloYMeHHbQns4ZvXNAFjVdpObr4dMsS0DnIv3Fe1oF0Piavk6jEs/5/SinLlPJz265kS
	6Q==
X-Received: by 2002:a05:600c:4744:b0:49c:e1cd:536 with SMTP id 5b1f17b1804b1-49fe7b6371bmr246224735e9.12.1790619806453;
        Mon, 28 Sep 2026 11:23:26 -0700 (PDT)
Received: from localhost.localdomain ([197.51.38.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00d0f68basm9476785e9.12.2026.09.28.11.23.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 11:23:25 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Cen Zhang <cenzhang@linux.microsoft.com>
Cc: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	Xiang Mei <xmei5@asu.edu>,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: Re: [PATCH net v2] amt: do not store tunnel pointer in skb control block
Date: Mon, 28 Sep 2026 21:23:22 +0300
Message-ID: <20260928182322.90171-1-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <179038364383.2160803.12085088814406803245@kernel.org>
References: <20260922214150.13970-1-cenzhang@linux.microsoft.com> <179038364383.2160803.12085088814406803245@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Sep 26, 2026, Sashiko wrote:
> [Severity: Medium]
> Can this lookup return a tunnel that amt_request_handler() has published but
> not finished initializing?

Yes, I think this one is real for v2. amt_request_handler() makes a
new tunnel visible with list_add_tail_rcu() before it writes nonce and
mac at the send: label. A query left in the qdisc from an expired
tunnel can therefore match a re-created tunnel for the same gateway
and port during that window.

The direct-send approach proposed earlier in this thread avoids it by
construction. amt_send_igmp_gq() and amt_send_mld_gq() run at the end
of amt_request_handler(), after the same context has written nonce and
mac. They call amt_send_membership_query() for that tunnel, and nothing
is looked up again at dequeue. I've posted that as v3:
https://lore.kernel.org/netdev/20260928181601.85857-1-omar@blockcast.net/

I ran Cen's reproducer on net at 17741334d00 (KASAN, slub_debug=FZU):
the unpatched tree reports the slab-use-after-free in amt_dev_xmit(),
and both v2 and the direct-send diff run clean. The reproducer does
not exercise the re-creation window above, so this confirms the UAF
fix, not the v2 race.

> [Severity: Medium]
> [...] a query that was successfully handed to udp_tunnel_xmit_skb() is
> counted as tx_dropped

v3 removes the relay query branch from amt_dev_xmit(), so a General
Query that was sent is no longer counted as dropped. The gateway report
path (a successful amt_send_membership_update() followed by goto
unlock) has the same miscount. That is independent of the UAF; I'll
send a separate patch for it once v3 is in, since it applies on top.

> [Severity: High]
> amt_dev_stop() deletes the same entries with no lock at all

This predates the fix and is independent of it. Reading net, it looks
right to me: nothing disables the per-tunnel gc_wq before the unlocked
loop. cancel_delayed_work_sync() comes after list_del_rcu(), so it can
wait for a running amt_tunnel_expire() that then deletes the entry and
calls kfree_rcu() on it a second time. Cen already posted a fix for
this, "amt: fix tunnel list corruption on device stop":
https://patchwork.kernel.org/project/netdevbpf/patch/20260822045407.28983-1-blbllhy@gmail.com/
so I'll leave that one to that thread.

pw-bot: cr
