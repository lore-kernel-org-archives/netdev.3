Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8035F3CB544
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488144; cv=none; b=EvYWEum8xo4h2I6K5084dbmtTdOokXr2ACwpkZI83TH3wXqYeCQAqkH8kMOOp0iAMWy+6EqMeu9Ua3xxQicX6iO91P6Kr86o3YLiu7Ufc0kg1fO71f3eZalKAuQum4hBr/2fhsY7BEb+dT9lWkMVzlQQlU0Z0oVjdv5WjcikTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488144; c=relaxed/simple;
	bh=fVvNhp/bhy8s5DEGKp2uImUHHOGSx/B3GI6jpnh2WvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n34Iq+p1e8JBfBGGF1dokHPWRt+GL/2iqITnLHErzxFkEwLkBiTE6ZDQx1Zg/xjzpLiJdaiGd7Yi+LURfAqCLeRsbh+7HEgsoyaiLVbU92ZsM0oSAQmM/lFLpaTEnqe/EcskFb2Rp77Y8foUuZwv2yAISGOeAhf7+oTjvssOJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAOMJsFj; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAOMJsFj"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2055573c8cso461478066b.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791488142; x=1792092942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fVvNhp/bhy8s5DEGKp2uImUHHOGSx/B3GI6jpnh2WvE=;
        b=eAOMJsFjbCS+N/L5McZ3g6Ix1JCKP9Sz4N39RNd4/geHzzn5ovlYY/U1TU9+v/DbO+
         giXDEcNSDDXnEcepTX2hes8XJyjfpLR2JIGcv+IIOWBwNM2cNy/Cx2+tqMaKzHx0IcIU
         Ga8/Z10seqGr723vaJ9n6fvWHLBssfnmbu7v6zER829fuw0QcjHDCnxWMyvnpPI3CwSg
         pRILhUQxhe4fL5yC9uwoCBtZpoYMljsXdZjgf0qpcRJhVwMIzZG7sawaXs2t0U0ypjz5
         A8NjMkH97LyQNoYLbmdJM40WnUQuG6VM51xL1nzjmKOl14ecBm4p4TNKMoHAvKAlOd8z
         neVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488142; x=1792092942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fVvNhp/bhy8s5DEGKp2uImUHHOGSx/B3GI6jpnh2WvE=;
        b=VGUwIC3Z3VsEFR0rRy1x0E+QIcDc/FrKi58AHPYNVHRuDlnxlnPefvcD3jMvY/rRhG
         TCMyuuS1zJB8Mcmo8yAZgFTlJiZnlIPAFehxm9mnipY4wZHs/DsAs41YXiM5LZCALwR/
         HNR63SzUL8ae7p8yE3r5cyWR0WAK1+i3gNGJNb/7ThavokzxJKA4CSBMD+Vs7RdU0W2I
         RRK7ssfpuy4mm9tvFWETVFaDvCbdoKCabwlD+WiPTVkFtoPndEu7YvMo+54xE88OlBmy
         hMozJKx6d6NehdU9pKwsu3zZg4xOmeVKSbr9f1jSc3LTKphgZ/3oYkOHjh4wSGrtY8nS
         kzbw==
X-Forwarded-Encrypted: i=1; AKwUvBwtl3vXXxjxxWfJxTZ7ZNE4seMscia8I7+E5cZL4b7f4EH52v3v7e1PGLwvejZA+i2Ap+2+xdQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nuidZE/qngKSbbHzZyk8BRj4GBchQ+3nePLG3WQ7pAIJiNUvKw
	LIoY+CtzbERqkgtb8zokHQBsWrHaxrq+z8CrlxQfrSn013DjWFbRcy1K
X-Gm-Gg: AYBFou0wZ0ynOckJ8q5uo6IOtkiKmMdYTxotkBXd82Qz9pqDUTeKpzvlyRlNNpMw6zU
	lJdMIDU+Z/m9b8GpkodfHCJ5PMgehnn4rjryajWCj2s6Vie3dCqbXdIBtdf2MeTMY+NHO6/kaR4
	7pElB/jKGvs571sloSWlAZmrHR2xKwu5c7s7xJL+L04q43hQGvnHEz6MaybjrDJTTcPEIsltgur
	gSvYF1KYHRlK8doSu1rqoVC2QGZc0bGC1V+zEL3lQUpu+yFTkL+IyPBqPuDm3ij1/6OlfX+9KMv
	Cp3hMKQV6PwK9CqbUY/8JL2CLfzYNpqLVqAagjfwzlbhiXWxdM3cX0ibCSaq+w6cluJz8d9MNgt
	pAOD/wRXben/bxwpqXvmvYnwlThzybBsLvrUpY3CHD+M7znGmKU7Jk6xa7maCKgMRzcu9s7a0+c
	KZR2LexUzFxrvGWoG5PoLI4YmgJW5dlLFnwKsXfvIY2fdN6gokjI+by9tIiz58Bk3KS6LzYTj/1
	6NBfFbhHYrwkD7UwWm9aafIRAVLr+K5k7A6glNStaDdH1LJtqZIud7LOBWv0FSQad0Vr0abbRHJ
	U/a6W5CBoRQBjVYlaAT6slu3nbyy9GfijA==
X-Received: by 2002:a17:907:1c84:b0:c2d:ca8d:435a with SMTP id a640c23a62f3a-c317c081874mr606329666b.38.1791488141493;
        Thu, 08 Oct 2026 12:35:41 -0700 (PDT)
Received: from localhost.localdomain (94-255-221-162.cust.bredband2.com. [94.255.221.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a4d99db6sm8410766b.54.2026.10.08.12.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:35:41 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sashiko@kernel.org,
	George Moussalem <george.moussalem@outlook.com>,
	Ziyang Huang <hzyitc@outlook.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: phy: qcom: at803x: Apply IPQ5018 analog settings at probe
Date: Thu,  8 Oct 2026 21:35:27 +0200
Message-ID: <20261008193528.14906-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20261008095547.6715b24e@kernel.org>
References: <20261002210408.730-1-yongzhao.derek@gmail.com> <179106246893.434549.12601361985639254046@kernel.org> <20261008095547.6715b24e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 03 Oct 2026 21:21:08 +0000 netdev-bot+sashiko@kernel.org wrote:
> Is the GE PHY ready for these debug and MMD register accesses this soon
> after the reset?

[ ... ]

> The patch notes already ask whether a minimum delay or a readiness check
> is needed after ARES is deasserted. Would it make sense to add one after
> reset_control_reset() and before ipq5018_analog_init()?

I have found no basis for a delay after ARES, and the measurements on
the tested board show no sign that one is needed.

I have no data sheet figure for the time after GCC_GEPHY_MISC_ARES is
deasserted, and the GCC entry sets no udelay. The vendor SDK waits
200 ms after each assert and deassert, but it applies the same wait to
every Ethernet block reset (GE PHY, UNIPHY, both GMACs) in one loop.

On a Redmi AX5400, I logged six warm boots at register level. Every
access after the reset returned without error, and none read as
0xffff. In the three boots with the probe-time writes, the EEE, MSE
and DAC writes read back as written, the MDAC/EDAC values were still
in place before attach, and the PHY-to-PHY link came up at 1 Gb/s at
about 5 s. In the three boots without them, both PHYs downshifted at
about 15-17 s and the link stayed down. One write is an exception: the
LDO_EFUSE field at debug register 0x1 read back 0x8031 instead of
0x8052. The vendor SDK uses register 0x180 for that setting, and which
address is correct is still open.

The remaining gap is ANA_DAC_FILTER. Its read right after the reset
returned 0x0000 in all six boots. I have no later read without an
earlier write to compare it with, so a transient value remains
possible. The existing config_init() path makes the same read with no
settle guarantee either; how long after the reset it runs depends only
on when the MAC attaches the PHY.

George, or anyone with IPQ5018 boards: do you have empirical data
showing that the GE PHY needs time after ARES before these accesses?
If so, I will add a wait based on it.

Thanks,
Yongzhao Chen
