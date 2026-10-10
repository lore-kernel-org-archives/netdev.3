Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DAB4B7A24
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661507; cv=none; b=hgrL7POMIeg32daG5mLsZ59NtunkkJgAYexozTXAUuKBHKH8zg33e7hwX7vDcp1uK49yXNTFpHgo/CbKHoPlCzeqnWCZ8PuCtNTn/QCzopHYhxBRqf5wKLmwWnwLWrg2fdOhEp1a/nIxyz54d7mx5Qa2R8sQh+oKR+RPGUgpSAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661507; c=relaxed/simple;
	bh=jBWuGD2YqZU0E2e6O/mVHlk6Lcec7KbBe/dsJotPZqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUYWUfCfcKSNNeQKcLS4hGBA0OTfCfB7+V/p0O7hLlJ9xxVSp9yBsQsfvrTyBo5+VY5dXY71y/SMyLde5dQQQXmU/TvpTtR21Et1BpoDsn/0Pv0hQZL9kzxwTds45++Z/2Z3cAYGGmeR5kOYn6v85zIDV2rk+NPX4U8J/SqwIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=SxVrH9Ug; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="SxVrH9Ug"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1923f15afso2886525e9.3
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1791661504; x=1792266304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jBWuGD2YqZU0E2e6O/mVHlk6Lcec7KbBe/dsJotPZqY=;
        b=SxVrH9UgkmgMBmm71be1Hp9yPkJh6wNDiKPmxnCijnMEjXuFHFR5Rtjp/kvOWRZ1B2
         nzpNXW9gDxdiu/vMImTJinNWOYuoinCzdMNyLdBrS37Z/R3bO/gLy6FZb0AkCaGgBBzf
         Vsz7BHi9Mp3EOT/10OULKgeRheq5AUHPyKVJT01CUJRtP8c2iKPm0S79GVv5CH0alGB5
         jkh7Fk22tibJtNJsRpzQoFop2wW9uQj+VkZRLASSPza9eh+5QKlLLOxHtNDAkJhAGbaL
         9JTVzJx0giyBaCd0S/aLOAfnL4dcNpQDkPtDK0pHECcV5+2b0soeK+ULDsmxBcj9fQip
         CSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791661504; x=1792266304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jBWuGD2YqZU0E2e6O/mVHlk6Lcec7KbBe/dsJotPZqY=;
        b=DeaZBqcCx2QK93ZiRp9WFiM4wLkqChGfd7jzUH6wSdiIBOgniET9lzwqLy1+hwnKH3
         OvNagwHPd9XRYl++In7RdglbpqgkDDQ8n99J4WQ3LxdGOlhOuGRu83Dhkgfmrcu6Bift
         6iP2Wx88OEQI+op7dbpwnEkrvRSWbPknr+4zr0n5rZqm8AeuJQfzZ0Uj6ND4+oxMwaA0
         jxu/C5uzymd5HejpmGr6dLju6ctuWfo84aT99GZkxdgM0CHOan0kfkxWOTgzpLLKlouL
         4e1NeaRZRla0CClkVE2zFBav5g/wqHmdBXp6LCnO3uMwsK9/CZwVgEBwVE0IbngmIPV9
         UaYQ==
X-Forwarded-Encrypted: i=1; AKwUvBztbAj3UjjCtSgGNg4ZPbdofGzybQiV31qCqKaSNwjRzBzL14GyUujLz4/us8BjK3hkNUdl2io=@vger.kernel.org
X-Gm-Message-State: AFq9FYLj78jd1clVdNyyx9/ccrR8QKPNZltJZ9WPxwStRjHyMk/2Ad1c
	8MSL+J/oyo+X7NW9//DNui+VhDYgW684ZTmmZ4mn5cuF8I7VJT0bDXX8kOopE70eMaE=
X-Gm-Gg: AYBFou2zKluPWx8nT4bAXvyBIk5JWct/zzmVdRp34I7Eoo8u/2HJsPge2KcZqz6BNYN
	R35RztOEeVoUmeufyD2ZPebA6C0FOU7OdH3E3L3fWJGsMTorUJ6ia9XtP6onzrNamJscq2bjqgX
	GPp/hsM0K9nn55MHGPwZMzhlmgKridZTSr2tU75jWepvOMVIf3XQNMp7RJcrjN4tzdD6N0XQJxv
	0MU1t74ER5TCiOBKLTZUZVwU9LX1xsSPq5eThtPPc3sdWPkvN9toprXK6QWHN/A6M0psxZxwwkk
	2NG+VHpjVHZR6GlkuRU0tv1Sub2sYcztjIqefXu6e1QRF5Kx6y+rOWJBemsdjJobM58F626BkkL
	YqmUluMDt6ERDM93iYciJ6qSKhzOPK9qonEDtTZ+Ne+5eR0exRnErVD23hNwCWhTNem+bGS2w2H
	rxqmt0DpVvOtbTLqAxBYTLjg2wQQNypixFSO8daSiNS8ZSF1F4eH+2hkBmr4XJ
X-Received: by 2002:a05:600c:3b0a:b0:4a0:1e68:d28d with SMTP id 5b1f17b1804b1-4a18e4a177cmr99986885e9.6.1791661504056;
        Sat, 10 Oct 2026 12:45:04 -0700 (PDT)
Received: from remote-01 ([84.17.55.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf35930sm151457265e9.13.2026.10.10.12.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 12:45:03 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 4/4] net: phy: make an unbind wait for the attached consumer to detach
Date: Sat, 10 Oct 2026 22:44:58 +0300
Message-ID: <20261010194458.2943738-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009180551.1234107-5-f@lex.la>
References: <20261009180551.1234107-5-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Russell,

Sashiko's review of this patch showed that waiting in phy_remove() for
the consumer to detach can hang: on the unbinding thread itself through
device links, and with the device lock held across reboot and suspend.

For v6 I would rather not wait. phy_remove() would call back into the
consumer under rtnl, and phylink would answer with
phylink_disconnect_phy(), the path it already takes when an SFP module
with a PHY goes away. Consumers without the callback keep today's
behaviour.

Is a callback from phylib into phylink like this acceptable to you, or
would you rather see it shaped differently?

Aleksei

pw-bot: cr
