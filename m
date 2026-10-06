Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E83E49E2
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791286217; cv=none; b=VpJXmADVWhhyPd1LHpqbojMvz3H5zgkZJuAGSLZHt0HMHF2YQUQPe5HuOri7u09kjBmB2hKJH+kRPKfAwDkxH/X3/l9f1bi1S/yqypsl7Ss1UNp+Bh72/7XszW3++kltCu/qJZY95GFGr6DAWVWJOTcZ5XGh/vzeMHGcEC5WoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791286217; c=relaxed/simple;
	bh=p7aYTQPeC1hyGc3Y0A2cCz+2IUa1ZlgF2Fp8Xves7iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4psQeAPxnmWACBXrIn2mK6uSMZd6IaTT9FWWFSr0sbtv5aLRRKYmzfjOgvgQo/SZCHEHJRQyylUyaksdwE07kUOiMmCwi3HchllUlZtZweUUUeqEbWZotIt8E76IdA0tnoMVcT0svEhYo5noqBxcKS9oQAMwJvEM4V6AUKU5A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=N6ikWCBs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="N6ikWCBs"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48b02b1b4cfso447248f8f.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 04:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1791286214; x=1791891014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p7aYTQPeC1hyGc3Y0A2cCz+2IUa1ZlgF2Fp8Xves7iA=;
        b=N6ikWCBsdcbB3DoCIPyofZc4CvNuoUu5bQyAiB//1y7JqLmqyFJBPuyCSrMAUwv1Nj
         FR1bTKZpOVExf8aC7PoDapYQxX4Jr6ef1lhTQ5+1jLxYHmSF346Ad80+p2WAEDiUO4wq
         yTcqjhA+kV1Nn36ZhTKRsJKsy8SsFvYGy5wZHwGuNTsP27BYF0WptCUyELlbHRYBh8BE
         EHQjcH1/thCFs4IGMwO8+cEHHAqJ86MTgA6Gc+uUt7Yo2yC6erKgZi9nZXcbfJiUuN5Z
         tEEsrvBGF61DfR8Z3oiFrTA8A2qN8aT+oxjEQthcCMfndNLNTwJ35cPCze7GLg4zUeyt
         UX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286214; x=1791891014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p7aYTQPeC1hyGc3Y0A2cCz+2IUa1ZlgF2Fp8Xves7iA=;
        b=uBHRDnW6ZPXIKTa/KUcAG0ZrgeBrgOn4ubGLV1T7spD9GXEBZsQWx/dZyPxs9MUdH/
         OLiZc4ZJRMbEh2rwU0Davx1B7pQDbKpH0PnhaESfddjaI9MVss8zCttg/TOuGBWMj06j
         KBe1nDRfpkkNOHKN5XHTlvw0jrcMK+sELAGs+v+7TMvpPuG4MNSC94+SvLaasxL65sxm
         HGPgtjloeOS1fqSS8tUM3Ol6hGxd3DCD1A9+NP7Kf+X6qHKQj885h0V6mlu3XEyclmqo
         oyf/0jjGcEPnvPEAhGwO0rs7Liz2cu3A9h37BR7D6vERYoY1wvPf8Zo+0A6Xcbvqss2B
         HMuw==
X-Forwarded-Encrypted: i=1; AKwUvBxfm0Lzojub86YW9LmOAr8LVMqZSnBVabm5EjA5uDASEfgEzXmA2TbDJPPfBSyatHBxrmyHBtU=@vger.kernel.org
X-Gm-Message-State: AFuF++m14zTJ+MZPvkhaUy1jIg70XNyQ6BmW0tltE3+gCmKX4KftTibd
	adbzSgoS47oOmAtJErfY0QrtWfnuKe0kcYbiHJYEwQNrZzfkFFnv8VgqAdCVxq43pe0=
X-Gm-Gg: AYBFou0i1z29oF2JcxgbFiRR3F4j6FN58YiZ/3Xcghh4qfxe/4nUmnaUUWp0VIdBNT4
	b7vxePeNzJMFuduqtZs0hDBd3d4iSlKrr9NeAICTepmLXOal9aSZhogxjo6jJlt0SxQeTASQHGL
	lhU3fUK36TViX6+j1/wNMGXHGcBmLNBohHN3NWY7xVi3tesW4gIAJScg0zvmiCvMxK7Xqmf5EyI
	e7JIOw+qwu4/S2kjGC5zH6JgpBwbJOkfo4+hXQBFiBRDVoX0MS2HEGyT90tVLNeEkq/7maGw7Ih
	851WDN7BxcQQnVyznperLDmWGtNmh1KSne3chghlm9JuA8TtcsDChgyRQiTT3Wc+5mkEzLJo7zl
	jrqrtyPClheNa/Z6suXgPKNQdFy5joyyE3pRsvpI4baCIMe05zoUm+seACqetlb9qLjNp5LiLAb
	52IpN/Ud+WNr4ckkAwZ9W/j+Ghdkq0+C7fPFtna/6IU2X3EQPY4Q==
X-Received: by 2002:a05:600d:864d:10b0:4a1:661d:da2e with SMTP id 5b1f17b1804b1-4a178a3053dmr37160135e9.14.1791286213774;
        Tue, 06 Oct 2026 04:30:13 -0700 (PDT)
Received: from remote-01 ([84.17.55.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6bd2bcb0sm3173964f8f.1.2026.10.06.04.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:30:13 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev-bot+sashiko@kernel.org
Cc: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v5 2/3] net: phylink: wait for PHYs that are known to probe late
Date: Tue,  6 Oct 2026 14:30:10 +0300
Message-ID: <20261006113010.741565-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179120736418.434549.3034364543286173403@kernel.org>
References: <179120736418.434549.3034364543286173403@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> should phy_may_probe_late be documented as
> incompatible with mac_requires_rxc, or checked against it?

No. The deferred attach still passes PHY_F_RXC_ALWAYS_ON, and before
it the PHY would only have genphy, which ignores the flag.

The other points are valid and will be fixed in v6.

Aleksei

pw-bot: cr
