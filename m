Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586536EA93
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325774; cv=none; b=RfKF3F4eNgTvZxEYewX3yzuoeb9k1s2Q3fxIurBgZVzoWBQYHa9i6VNmmX+GQdx/7KesiboLomouZ4u6xQXdjb+uvlc0LFwff8WFpugfLR9KAnLBxSaB94ldC3G5qgg5KRLRXJqWQeSHso0rEOFH54CQIHZdZ72iYsck5pJTy6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325774; c=relaxed/simple;
	bh=/4/5xS5cGEqInJJDB9B2sgbhHxXgFfr1gYRUpzmTHMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtKUr6e9Vi5KIdeZ0W19TqwqmEgC6UKMs1MX52TJaZsi2HefXDSbCo+WpcXyypSU2zTs0VXxfUM5SGjMY44WnEZirSal79DEUeO8ppHvyML9gUwW3rJ4p+NDujjY+tLxF5jKGh95WC1kXiNId+k1kZM7wCCMfwu9PY/HJpeV+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3frtcWE; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3frtcWE"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6501c9903edso10908547d50.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777325772; x=1777930572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4/5xS5cGEqInJJDB9B2sgbhHxXgFfr1gYRUpzmTHMo=;
        b=j3frtcWEYZeyLKhCwrstoAhzspkcBklegmgCzVJWGvCAUzHI4el8V0o5S+EIbIfR1I
         aJaSe9xUEQUaYSSvzCkurZd8hxrx0I9umBpx8ux0WHp+iC0YrasUFFaX31mTK4OvhJhT
         V8xn5rr4sFvVdGpBTp4SKV6B+mYvpsdc04hGg73P6vhT7n5pGarsN5IzW9u9qyXF8IVy
         Av729Qn+yRLA9iZRHB9gylg1BNq6t+cd3dpBmjm9SLzZ5JE9edvxhEs2sgcd2k7ofrIE
         rj/oouwBm2xm8+Eh/s3JJ0+zZXTtr6wsKQ3uxJA9X5Vkwb4rbVwMXU7sXYB4Fs2j8j8v
         nU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325772; x=1777930572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/4/5xS5cGEqInJJDB9B2sgbhHxXgFfr1gYRUpzmTHMo=;
        b=p/RMOuL6GhnC2QLKXUB94jx4j6Vp9OTwo4g2z2mgP2Jtc07auMFEw6Nh+YJ8H1dr/0
         PhfbNyxLlWZ5y+wbiKJGuy0JvhyUwd/YZFqx4eSa/urasyZseANwRgFZUIY0tWOlcGqZ
         p5a6/HqBBW5x9n03h2Pea2Qi3ZMbmYzovPHNbbPTNkwiTdHB0THF1+pB7NrpmlOPl2Ht
         pjK2LPq1tDZTKecH2an1Z435q4Z8HXCMpc+CEHaWcxGxNeqlvn2ygqnS1n4QeesrRdX6
         z7SWUyWbI1nq/wnmxMQBl3hZCNfNB4gkvaLP/nCdDnLFKieL5WluzseoaLlQbHBlzLow
         fElA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZgxoEuc/Zs0l/alyNsJuC1PDsTzFBipLGkwd80SZWU93/Q6+kHBAQqyuHwtDCfOI47Iobh7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh4ZhLTT51bb8kk+uPSXpHcD4MDszD6oE/WynBv1UwXF/U+ylB
	6egS02ufN5SreSQmF6NqR0SUykEsV9VnppMGnVGE+WdfneS4Cw7Jx/Nc
X-Gm-Gg: AeBDietJ9T8ISQ4/19jvpCU8t6UzyYDkzLvdJpC40rvML/MFWHHNs7IV24LYHXXqpQQ
	eaSpxbMW/XfS+rgRkXXD9vPZ+7WN02bUx0MjBlDtqBm+mPxQZPB+zzus9Qo0ZHK5r2XQ9ifgUcA
	1aGDg6L5VZ/1GwJzpOgFpGvAOsNoha7JXpfv/OFnEW7xUltC8iiJKU01DnKhtBQuNzrf1nJetgW
	lRTIn56E167wwYqs6AtxPZYfPR3308W1zIEpBmA2mY0j0rahJu37vu311y0UOHHe6cSTe6wJwyD
	Z6cn3YB4n2IMcRICSYMmQcT4O3H/k88IMD3OjeP0/aE+NG9sxTPq/eWR3/H4RcoxREv6wBGqnrz
	HS5c8NhePRpR6IktjHT+YrVBDeQhVlb4TJTjidEbRV/iKX48KAdi2e1b+SRjgHSsHTqp4bYvHcK
	qdJcec3Yi1IqIAFokr3/ZsRy0z3d5kjYcPjO/oCdEVU8xvEt+HtO162A==
X-Received: by 2002:a05:690e:1482:b0:651:cf84:7744 with SMTP id 956f58d0204a3-65beed3a66emr297378d50.11.1777325772430;
        Mon, 27 Apr 2026 14:36:12 -0700 (PDT)
Received: from localhost.localdomain ([2804:d59:7f1c:1e00:6632:a8ff:fea4:c8d3])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bee49dd24sm190628d50.19.2026.04.27.14.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:36:12 -0700 (PDT)
From: Gustavo Arantes <dev.gustavoa@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Javen Xu <javen_xu@realsil.com.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] r8169: expose software counters through netdev qstats
Date: Mon, 27 Apr 2026 18:35:55 -0300
Message-ID: <20260427213555.9005-1-dev.gustavoa@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <a7b8a496-baf9-4e0e-b1c0-510e24d0bbaa@gmail.com>
References: <a7b8a496-baf9-4e0e-b1c0-510e24d0bbaa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Apr 27, 2026 at 11:21:44PM +0200, Heiner Kallweit wrote:
> What do you mean with RTNL here?

I meant the rtnetlink link statistics exposed through ndo_get_stats64(),
i.e. struct rtnl_link_stats64.

> Counters are exposed to userspace already. So what's the benefit of
> duplicating this functionality? To me the patch looks like AI slop.

The benefit I had in mind was coverage for userspace using the netdev
qstats generic-netlink interface, so that it could query r8169 through
the same qstats path as drivers which already implement netdev_stat_ops.

That said, it does not expose additional driver-specific information.

> This is generic, driver-independent code. If exposing dev->tstats this
> way makes sense, then this should go to net core.

Agreed, I'll drop this version. Thanks for the review.
