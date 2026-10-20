Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792456766;
	b=wOmhD4QMzVKMgcLzTAhkvafY5mLs7GR5USPKN2KOT7fdeC+Hqm/pj/2sW+t4hcQCHzzl
	 w9EE6p3xAwC7eVYGNmdgCeI1Tg7iPd1brD9SICPR0MUZMhjrc+j1JhMYj+mfQ4Jul+iD/
	 DNIhAE4I/tgj1+5psE/i33fxBjuL2bSX8I5EVLEJ2hoEB2ommgemuVYcaJXQQEYYLxKFy
	 Pgs43arZulgaXRlrbRtluRpXc1kbieGrD4ILO6B19lAzxNTiRLvR9NS13VUSLyhQKyku2
	 uCT99MXDC6aAaQCKh1to9U1zPxPhGSAU8Rz4j+e99KDz+D7IpMgTdhvHorkHXCCpAJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792456766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Nq7RuSjzu7pWdYPp8YjekN5M6ju2Fw1REuHjwrdZuO4=;
	b=GrV/nXjZVgFvgc8lODkHg+2vwmR3iQZBoFLkvb/tjvV0HSH4AhbPobdoeBaGmZn3uUPZ
	 mJQkm8/7eEm/B9sYWXlqjnyXQAAm6Ye9wiDjoBmZLuHD1P8F9avyiZmOHR/UKr0VV9X5A
	 EMjBW/6nIIik9z/JeMbK/csYf8aOzP5ddEXPYGKxeZT3na298oZHbOoQDo/GtmkF8YIlB
	 mYMyyXNa2YU7sVVhs+WnYHeiR2FHtpWrpyu5JpZhgmhql8dG6ot5KXtRb3JnvLTEBHYFB
	 bJebZkc2SiQs8yYE41Chv3vfKin5rHDbCyn+eqde5d7MvSBPRnSP12cjghBKTvQQ4fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=JlUg32JA;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647B606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1647B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=JlUg32JA
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3535a54bed9so3745323eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1792456765; x=1793061565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nq7RuSjzu7pWdYPp8YjekN5M6ju2Fw1REuHjwrdZuO4=;
        b=JlUg32JA8UmnyQ80100sXlOuzLVPOtK+s5uo+Y1B9pKQTult/x0ei1dPHBBpyZF2y5
         ZiaREBK7zMqZ9AS7jh6kPWMZy/aqxV4+pw+XNMK2rf6qMHOlWaj2y0B5L6gg6F3PVBaO
         tnfqEV1rFauvwioIQelhFOa6BNGEXLwsG4saqmSofO8/FnWCNfIAb/stMlg79XyG6lnx
         N9V6SWJMCNV8ajKye+QtbMtyFkNd8EeTcwpKyinJeVUxFbu/3Y7DtnWU/V9fEgb9zL9S
         rRd0uKskuLp2cRShdsC5gwHWpJhhlpnYKTjnES39ICqznvbDr2CnC2sMF4Og8H+TS1sQ
         2mWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792456765; x=1793061565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nq7RuSjzu7pWdYPp8YjekN5M6ju2Fw1REuHjwrdZuO4=;
        b=2b3qjlVcbxVRFIq/y0Hb/U0jO99ExzpV+CAjMOaccW0JM0F/b/AlSYsLaw/MXGyN2Z
         ILc9yAwz9ujPRB+vC951Qzxb1pD7gpdaDut/rlPc5D0GCyjtisFrDJKwD6K//40pZybr
         nKPCnsR6jMic2LO643hLpbZkkeOjaAofbU4cnHSz4WLt7EQebu7hGqc0Zwnyaiokg8yW
         elSrUNH/XL1fXh55rmcHCX6A2SMWWMRtRwWCN3zdAsilZTzp/vavApR2OpKe2ryUOrFq
         Q2Tc7QuLt0iqVweKg9BiKlC/ilMW5rhe4aSMJGW1Zg2fb+IljCy8yON5jQzUdICst6NU
         rGXw==
X-Forwarded-Encrypted: i=1; AKwUvBydV8J8sw8BpPkKWhDGsZsMXIbvymMrXZsqwOr3VoEw+Jfv6ptRTEiuBwxqOfhOO4JQIgWuXOo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBLz6qfgnQeu59LFPBpu8SkhdCGaWFwbTrAmvJprGyEhnXThln
	PBcfTd14LT1bIHFjrIJv12N+Q0CsuMbZP051DnliB4TzLXAtL+lc/mk9OEb/itIn1NE=
X-Gm-Gg: AYBFou2nCwakTwQus6wDeHrN6ZmQTlGvI5csB9S6LpEG1Eq5/8Tv14xZsROO5l/FBLJ
	VEO7x+p+TFm8VkB4ssdP4J7ekSD12hwA2d+pz79A4bZhaGHSjr+bSKzepzwiWx5dom5H3sN/Rqv
	S7bTiQ3V2XxKnUS/rk7pOKp4+kwaqfefq70DiopGxDycR0WJOHHaqgdZsRmfM776/XZTGHs4jXn
	M79z55/8Sh6Ha0HfueOVK9PkklYHYsSjo/e98l4m+BMmf/X8PEgYd4AL4nu7DBkxB6yh5gSrcJo
	+3KrBNu8ZDbhaRMLs53uVx/vqIYDnhHsyI6uMmGzQFoQcsnMtVG40AmVqMuHtU8riX/PZBIml6o
	3USPGh7BIB4Vuu28NCacx/k2LEH2LqVRPorO5Ykq0YqAPSpD4KM8/jTH0tDHanxc07hzwr5vDc/
	miUnOZ36xouBVFVFGqmEPKyn4bpr7UXBYhBAyjKEfGLWXxYyMf0hpqW5gepV55Ox/XTCWnrDZ/z
	OC8SYGy/9G45DXqZ01gAnN95SwQ1uDbBmhBUXwQQghCW5oXmLMVm9v148FV+fFF
X-Received: by 2002:a05:693c:8814:20b0:35d:e49e:74ec with SMTP id 5a478bee46e88-361a3221e66mr13065995eec.41.1792456764917;
        Mon, 19 Oct 2026 17:39:24 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm59413465eec.28.2026.10.19.17.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:39:24 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: netdev-bot+sashiko@kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: Re: [PATCH net v4 0/5] amt: relay tunnel lifetime, validation and request-path hardening
Date: Tue, 20 Oct 2026 00:39:22 +0000
Message-ID: <20261020003922.4114766-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020002557.3984927-1-omar@blockcast.net>
References: <20261020002557.3984927-1-omar@blockcast.net>
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

Thanks for the review. The findings are addressed in v5.

The group/source worker lifetime finding is valid. Taking rcu_read_lock()
inside a delayed-work callback was too late: the callback could be dequeued,
preempted, and its owner freed before it entered RCU. v5 gives source and
group nodes separate deferred-GC links, clears their owner pointers while
teardown holds tunnel->lock, and synchronously cancels each timer in the GC
worker before kfree_rcu(). The GC worker runs outside tunnel->lock, so it can
wait for a callback that is already running. Tunnel teardown drains the group
GC before freeing the tunnel. This also prevents a source callback from
running through a freed group or tunnel.

The tunnel->dead checks are now part of patch 1. amt_update_handler() checks
tunnel->dead under tunnel->lock before either report handler, and both tunnel
freers set it while holding the same lock. The deferred Query source check is
intentional and is now described by patch 2: a queued Query is revalidated
against the current remote_ip after relay changes or reset.

Request-only tunnels retain the original GMI timeout in the intermediate
lifetime fix. They do not stamp last_seen; only an authenticated Membership
Update refreshes it and receives the 3*GMI lifetime.

Patch 5's message now describes only stateless Requests, keyed Query MAC
authentication, endpoint admission, key generations, and the liveness guard.
The unauthenticated Request endpoint scan no longer holds amt->lock, and a
failed verified tunnel allocation is dropped silently rather than reflected
with ICMP. The dead comment again documents both locks.

pw-bot: cr
