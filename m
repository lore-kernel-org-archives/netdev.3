Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09E3815F9
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600879; cv=none; b=rRpbFTrCUUFulBnt3zGfldliP5i4hJ3tiKAVQmptQRRCPVSSlE8RwBemdQlOug0hPXtt5BC9l1erHzZEeVxhNf/KXkRFNaNpCPEKG5o2FT49iFwrpVweKC9xkVcCNDeXpL16uMrgAvXO102XiMg2txZCu62n0QLKUGhqOI0teXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600879; c=relaxed/simple;
	bh=FICK8ILQID+v9T4ZSHD1bwcr1gDc46fcc7Nt0qBOrO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5Cdp9wTNVE6aO8WTK6oGG6leNjluLgWx9C2QyPaYxQIefP+hZ+SVVJalG87F6h1unhsy079CF3QEQTAU2+zlx/DuqtAwNZIFPmr6tdamSNvgRS26Uif7AY8G+4S7fBQrVmHVXlMGsJdK8ECKMub2tSuPn4d7x2rPoWDCADkLso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJjVJUL8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJjVJUL8"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c16794450aeso566511566b.2
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 12:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787600875; x=1788205675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FICK8ILQID+v9T4ZSHD1bwcr1gDc46fcc7Nt0qBOrO8=;
        b=iJjVJUL8YZxAcDq+059BCHwWRdKQbN/T0xrmRBJqe6K95zdfGi5o88GZTrUUVfIjmT
         ueqb0s2Llc2YqH+wLa2k9Rot3gQgLGkpYykDIkBmRRipEmA9w8rI3rCq51joJjU+PU3y
         T6tTSRxI17KtGaUB0iBKQIO0NwJnZmY9C4Gh6tFYmownAVtNuW1wiH6vKDR0fhcK07Yv
         uj1hpT8W9+mtcOYAbsvezZORSbIO9ls7EThxrBbBQfhieZQoFLO5dMHrHhi6M+B3cCM9
         sErX2c3u5PgHG4cuaVMTa9kxiArNlLpaLp/zx0glkOhfX0lNJKkdme4vyEQ75yT32DH5
         65TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787600875; x=1788205675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FICK8ILQID+v9T4ZSHD1bwcr1gDc46fcc7Nt0qBOrO8=;
        b=eUlWQl1heE3jTTTO0u010Q046AaJQukjd+3vxEjBpwedfX3FQwtBoEb42CaYkFb+zT
         Ozq/uLyZ9VfZ5KInt9mG2TJVr9npffpDr7110mgonJjX4GakYdhaJ/sOwv/lPa1+GiML
         idLLXjYDFT6PQnLQaRo516mQ5jCL22DsXEDyTyf2bH9p5TDb/tVfFDnhP7uAIZlOroeY
         gtJV4vDB46CsWYsQ26EoZGVAsN4tKggSzzyykVfOkGRpeUdciDkAq1vDqy2BDvzqJMup
         Mlog9vRPdR65xKTWt1bjlpOHTRxt/6n2UvYcjz59w/OOaiFoqPPgUQQYoI4qs5RRskE7
         WLSg==
X-Forwarded-Encrypted: i=1; AHgh+Rpn68VE6zmWbWbqSsJBp6RBL1cpZ+Ox1sAcIa2OewnYWNVWPGSlrTD67cvzwURgwXdn+3XHtC4=@vger.kernel.org
X-Gm-Message-State: AFuF++lMf9bvZGLgC7m64R3DYqH1YOd5J93f+UTd+LSf3QGOHwIh95Lf
	FKjPuIE3B8bE8j8+LT7XzXV5QxXFWrDhbT9BFrBsFL5gjKNnwNGXNzji
X-Gm-Gg: AR+sD11bWxFNH/91cL6oa3hDhCCSGQ3L6zZi+muTU3qsMEIaJ4EzJtYScfoZPZgpBlX
	Dvrntx2L6wB7M1bBZkSii/0y9Edt7n2RpXGiDJdSQHhzasg6qvq8lmep8iYyB26JsdNVUlJeyaE
	D47IAWffyL3bW6aYvsOvpH8MYPlME0j2CFgfsAoL0Qc2Imj91dkFpuToyyF3Xr0CmEhv2EvTlV3
	CoNcXNVV3zPhv+Iiu0gPRxsfm6siTsfn/OD2fGfStLzeraeE2nAESSdDrDB/2kd60pOVlJNFvyo
	n/JRbEHHaVlE77gaIcixSBJwbvdvayo64jaF7qoCjgSVsdazC/scv07YtvUTc/Ass7BsdUtZ4Tb
	VzPhUSF4rf+dTnLXruwWMy8jnMV/bbnG4AIVMoLtJcjvyzmIbEC33THhYNhiCCeLTddPkA+zYZF
	f5xMzLO5t77KPECIXRHCcZ7QNi4LQK+iSlMHELAwKHrfmNZ+zh0uNmBmJpcSDB4RX8hRfmUQQ/O
	QNjD6+eMGM2/3l86dkdIV7Bnq/7S1mT4Qd2PlONQkv9vkh3CcNXrBkKIvS+5spd
X-Received: by 2002:a17:907:d0d:b0:c24:87e5:6491 with SMTP id a640c23a62f3a-c2487e58617mr2774348266b.2.1787600875267;
        Mon, 24 Aug 2026 12:47:55 -0700 (PDT)
Received: from localhost.localdomain (46-138-191-2.dynamic.spd-mgts.ru. [46.138.191.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1558080966b.8.2026.08.24.12.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 12:47:54 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Ren Wei <weir@nebusec.ai>,
	Zixuan Chai <petalzu987@gmail.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 1/1] ip6_tunnel: snapshot encap in xmit
Date: Mon, 24 Aug 2026 22:47:40 +0300
Message-ID: <20260824194741.215979-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809123335.GA2443083@shredder>
References: <cover.1786088695.git.petalzu987@gmail.com> <b58876297f7d45de008f2e94b6ecab8b2ed84d21.1786088695.git.petalzu987@gmail.com> <20260808194001.853434-1-kuniyu@google.com> <20260809123335.GA2443083@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Aug 09, 2026 at 03:33:35PM +0300, Ido Schimmel wrote:
> It's on my TODO list since last week, but I don't have the time to work
> on it right now. It's a very large change (see the geneve change) that
> is needed across all the IP tunnels, not something that I consider
> suitable for net.

I'd like to pick this up for net-next, unless you have already started.

The shape I have in mind follows the geneve conversion: a separately
allocated config struct hanging off the tunnel under an __rcu pointer,
holding encap together with encap_hlen, tun_hlen and hlen. xmit
dereferences it once and passes the pointer down to ip6_tnl_encap() and
the header length helpers. changelink builds a new one, validates it,
and only then publishes it with rcu_assign_pointer(). That also stops a
rejected changelink from leaving the encap half applied, which is what
happens today when ip6_tnl_encap_setup() runs before the collect_md and
duplicate checks.

The synchronize_net() in ip6_tnl_update() and its siblings is a
separate question. It is there for hash coherence: ip6_tnl_lookup()
matches on parms.laddr, raddr and link while walking the bucket. It
does nothing for the header geometry xmit reads, so it can only go once
parms is in the config as well and the lookups dereference it.

Two things I'd settle before writing code. Header geometry only in a
first series, with parms following, or everything at once? And the
order: ip6_tunnel first, since that is where the report landed and
ip6_gre builds on it, then ip_tunnel.c for ipip and gre, and sit's own
copy in net/ipv6/sit.c after that. vti has no encap and no hlen, so it
needs nothing.

If you have notes or a half-done branch I'd gladly build on them.

Artem
