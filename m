Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826479;
	b=NbljackmaXAGsztdwRWILPBm236Q8OF2Mh+GJHu8wE5V5iwJYSsCkYHWdKoIZAucFfMK
	 ka7H2OZY/vnK3WzaLoa764q8j94SWpBtJ4zmKx6TIEV6eLvq5mPKne28OCnzG3yrxtOWN
	 YM2Esrw3b9NoVe80ZkMwEhqBhqR9bfnFl4ABE+nhE+XlG/7qqMD3bx5qUDcywbGpDR87b
	 xhe8qbWDF+1JGzIb3XMBO2Ctfmivj3Z9QOiABIjz6oC1XYt9JYMfWzyeHiKen17Eiw841
	 rJjv6ZSMHl5GGTV6KNVNozYIh7V+z+gczI09xQxzvhYI6gLQ5O2VyRe8zY9nDzDHuMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=crHCt2MR5Ttn/zJ8+YoRv9/ml29BnKFxyv9jVqax4Mg=;
	b=BvTq9HnFbOSdTZI/or223ix19mn08hiJAEnmPnevv5rqox4XmDjEbAcdYyzvwNiQ36r3
	 Sy4YkVsKfRpQ1UZbOvEzC2wxVMnQ9w/MYN2f9RQEMc/eGYhIf38m0YaBvb50nLKPbTUd4
	 FeRMXfh57F3y11vl9yexdlYl3EElqzIHCYJqNcdUhB+NxCZTTC4uCQflOTQIcX4sqIG2+
	 PUDPv5yUQklcLeI4PuQ9UazA82z2Gup9+BP1UsR2ivu9ErCzHArw78ypViOR4sVT2jyzq
	 xzSIE54i/56DpZteErI9ZAL+8Z4j6xDoCIJiSM/AgnFb9o4Hp9iANIJA6FSMvLZxCag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=plewQ1XY;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45942606D80A
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45942606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=plewQ1XY
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so764522f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 13:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826478; x=1794431278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=crHCt2MR5Ttn/zJ8+YoRv9/ml29BnKFxyv9jVqax4Mg=;
        b=plewQ1XYTlFetiU2TTz26yDa2ARYkikgSrvIcV1jYDK3f4qxMUoG+SniaCzZPjZYED
         16NIvioGDx0IssF3JDJ6To0fEyJLz0p4u4wh3nqHB99+os5cojeac6nTWtq5HSkmnzpn
         mG2ez6wKWHXdP7NHJv8x4OPDQ+zLaWFJ8xiPj1X765O/ydItUvMaOkebm4dTTfr6W3CP
         jooEP0+SMBQzXpx1lVrlF/0pZYTC59TSWGN3VaBb3uc07A0KTq8rGg30MndLtd5eHMbG
         4MyljSthQJclglrrNTHYcplG8RaRUTlp0WgWyEjCdJ0UJ4afBE55m83C/kDIi2x+tsNn
         cDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826478; x=1794431278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=crHCt2MR5Ttn/zJ8+YoRv9/ml29BnKFxyv9jVqax4Mg=;
        b=tO00ZCGDtDC58vNSsJkDCSs5folOnw0MJ/iBtnwOFKJAeQJu0yQ/Bau1XolnOwi+s6
         BhmkOZrIVjEMFyKGU8WLbwgkMos0FBKHojZUPOkUsHZCVzMAlbI9PtBGiUDLJc0Jmkm4
         jQdLCdmx50T4MFEcsoSxfRSdjGAWkd5wqgp1Ww1axFmhTPe4cZsg1ZR1PdBARyZBsFfl
         kFEnDk/MylECdnnavKl4Egb60u/cHhwhRiAiY0fFIDZmbtRrQDYtd52ORCwlu200nk6V
         YADvPdmqrdo1PcERV46FJXGOMtCaXR9QiYE076w0/JRq35LGJCKk/L0N2mDie7NEKJVo
         92CQ==
X-Forwarded-Encrypted: i=1; AKwUvByMGxucyG0CbTG5Fl3TkkdJpfLSzhfK3vNYRMLhcZls97VVC2A+z2LKXr70JlIpxB0ZZeqBvXU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CbiUTPT5zhmhCHB4m262LNQApjc5eRsbJ0a/mflI+bcUZk/9Z
	VFPPO20yQbp8hhJ2D1SGFVqifpNhfR2M9PV4zizA39+ycVLZT3ez4PiF
X-Gm-Gg: AYBFou2HtK8h/9rUzhCwgcaHH3AHxXUjbkt8mxJOwIIIiyWMjCDCqwXhvhyZOEcM+VB
	/qP+XXZmuHd0gLIov4WK/A+McT1XjzwDLko5KSWPb1yaKJdEvu+3Tu6GVF5TnvVmss63ALtVCUw
	ZeD+7h0dzSomX5X5ChN9MBLgLilSU4njSQHc/4DonLZQphr2KI61KeLjokZinYdRonDehsnUSFd
	ciUAtQm4ey/EeJxqnWyAjunUrBhZzRrGaba/Yny/MtYpFGL5jKUDGDqTonOxHTgWgCqKlsxGT7M
	PiwLtzVwBNuYYz7fo0PT68gYfbisK4oYENtzuHFVhIFbPqZEj4yxYjB8bkNj8XHrXcWiUCqRI9+
	cAZ9JzGLp42Ql5SqBvdAdV00izreqMe5S251tQsyiBLLp6INozRjPaz2jP6RywSD4hub0HbtgH3
	QligSJD422IqZz58peXIGiuv8eavFoUPBIWhprgHRyqQ5kFEFD8ooAECabuxZsgLUTzlR7nLMjD
	wPK/zYRYuvasnLZEXOG1NpwasRhhuUa87Fw3k1QJWwa6/2NVfUzSOkFUrRe8T8HzG3gtMp03dCY
	0n+tW9TS5s1KjZ4K3NUmDEnDD22/18erJukrWL/cwRm98uxcWCA=
X-Received: by 2002:a5d:63ce:0:b0:48e:247f:a106 with SMTP id ffacd0b85a97d-48e6e4fa97bmr29312958f8f.54.1793826477458;
        Wed, 04 Nov 2026 13:07:57 -0800 (PST)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c23:788d:6769:d03c:c916:2aca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed45d2bbsm6224901f8f.33.2026.11.04.13.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:07:55 -0800 (PST)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: dsa: qca8k: drop MIB autocast frames once the request is over
Date: Wed,  4 Nov 2026 22:07:52 +0100
Message-ID: <20261104210752.467937-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179304303832.3134.328719975361344250@kernel.org>
References: <20261022192933.384898-3-kuncy7@gmail.com> <179304303832.3134.328719975361344250@kernel.org>
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

Thanks for the review. The sequence is right: a frame carries nothing
that ties it to a cast, so after a timeout the frames of the previous
cast are taken for the next request's. v2 polls QCA8K_MIB_BUSY before
sending a cast, as qca8k_mib_init() does for the flush, so the switch
never has two casts in flight, and the handler records the ports it
has seen in a bitmap instead of counting frames down, so an extra frame
can neither underflow the count nor complete the request early. What
remains is that a frame of the previous cast which was still queued on
the host side can serve the next request; its counters are then one
cast old, which the commit message now says instead of claiming that
every late frame is dropped.

v2 also carries two fixes for the issues you found in the same
handlers: the MDIO fallback of qca8k_bulk_read() storing each register
one byte after the previous one, and qca8k_rw_reg_ack_handler() reading
past a short frame and past its 16-byte buffer. It goes to net-next, as
Andrew asked for the related MTU series: the problems were found by
review, not seen in production. Patch 1 of this series, the regmap
locking, is not in v2: Yongzhao Chen carries it in his net-next v8.

pw-bot: cr
