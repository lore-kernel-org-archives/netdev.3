Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8D234964
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792373593; cv=none; b=qcoRJ+EBBc7qs3pfKxLvacqYqtDCmrr/Wf9NDlL2AcdBv9t31T2iblu5olnucCxoeV44w9QfxR6JHnp67V6ZePz5N4HdJSbpRDV2WluzDowrmSg6PwgAErMY1SGRLK+72hZDm9CVnD7DfDWyywaD3pYJI+d+Tyfy+l0Yy8DVJF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792373593; c=relaxed/simple;
	bh=9Kc6q9rTpzhwVJQBrjDXbF+l2p6vieI5c5NZJWnYEqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlogAplfZWsY9rCjlWJNM1MuqkR4P/kFlYfXU6ki3YWoHzcDoPPzhHzl7H3nVNgUFu2toVa+gzItyY0/e2AWqZZlYH59HlgzIhVJEn3sczdhFVD4G/6jI8Glc8iv+VbDna3qYoBJY17RAJ0WafDZ85tRG04I8X5Hrb6MxuyOJk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=T5LrC3a8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="T5LrC3a8"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so8588235e9.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 18:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1792373590; x=1792978390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Kc6q9rTpzhwVJQBrjDXbF+l2p6vieI5c5NZJWnYEqo=;
        b=T5LrC3a880ioyxH/Bon90h87LXrfZPcBFzTJtzDwKCZj/44vlkclIDk+IwGhnQRKw3
         1tDqJXA82to0IoFMANb942HhE679CcKnfgV6ZC7Y+nzOnsvypQns2loTUmfODTfnQ3aC
         xSHrqurXtZcVFAjmmUIR4olKxG1yXmwXPd2YyHXz8XolbA+Y5yjrx6uBgzZpEVcWosPa
         VcgGVXxumOClC9d2qlI0M44FE2xO6Xdni/RrkeERQ88XrzUlN0ATHax11jglH0gwLyaY
         15zXiHo/dImLIwF16MvJKUeaVswgekU9VgLtAZ0JaKYY7hrd2rzBscNjrQWjp2MYoAew
         GKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792373590; x=1792978390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Kc6q9rTpzhwVJQBrjDXbF+l2p6vieI5c5NZJWnYEqo=;
        b=LllNX77MrPXiXVagansHUYxCgr7ZJ6wB3OXgw+R3NQLweedT8/R2t/szU7B2O39b8K
         U50R5jz1bbsVIxl6RXqsm4B9r5vyF2A3jG6H+ReAiI1g7+K/jHHGL5OuG1TYK2no//R5
         xH9RgYi7ZUl+A0VVH0IOmYF4/qaL6574S+UbDYqf5u7tw7N6DKMwySFaTf9miZORVPSQ
         PMG2811K7i6CNpfhw0wuU9iQCMh2XLNbqiicmPeEaOsLx2dBsyY/QY729qqQZ/vSr1f5
         ezb3z0yPS4E/rnM5PTgkIhafsgO+UsJAJatdgzhAD8G+ucOr71Q1vvRR5Z+1iToeoNXn
         FnWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJipjGBVWb+ZOZW6gdsLYlvm+ufsRNf71EZFoawOJG2VlB5U7aQJfnJzxvetKVozUWECTe+Qc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmYJnIIK05/7JsLZEjZXjs16M3YTYwGTP5Qlzzc2uv2Rx9Phvw
	uVZuTmClZnNvtbw29LVTLFuVC9x9IoD8MQuF8sH4B3zQ7K++liC1bQg6IS+1EbTIOrU=
X-Gm-Gg: AYBFou1MFL7HaPlyMhZcrW5qJyikQ7gP05z0ck96v+ShfqJU6RaTropYFbCgjVq0dN8
	gQ4UKMCYkhG/1ZmM9cKTW2lB0/Z9zYFRWY7xf631kaVqsS9F1WMHHjCXN4c44xd/jyMXSfEY7T1
	NwNk3U4RfKps+HoChlkOE0xrjt19ZUC5kfG+53Qy0tqREdD0DuDrclDP1rykOap9QmMjFaEKPHR
	uOvCW89qcBnppR1HcPJzsy17Dj38GMspjdz7BOgIvKVBPtB4nJ/n5jtqu5PoyFFjlQKegtHVQVA
	I4wVz0nYathkeVK/idukKjugYOp2yK1+YSspTFp3mnV4yyjx9+1dZ1L/bKWSJqk6PfeLOog8BE4
	h1Zmr/uYGQcXO/hCnw5O4KOw9IXkyzIt2EV6zgXj1cZ+G6tVCTwu5Cv+YEtF1ru3sKF5Dz+z5em
	Yy0a3fMwnUebUFgY9txKE7JbuPDuRnbwsBXzI7evI4TeWawXOFoQ==
X-Received: by 2002:a05:600c:1c0f:b0:4a1:e489:f89f with SMTP id 5b1f17b1804b1-4a1e489fa4bmr64348945e9.14.1792373589447;
        Sun, 18 Oct 2026 18:33:09 -0700 (PDT)
Received: from remote-01 ([84.17.55.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b303csm321116015e9.8.2026.10.18.18.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:33:09 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lucien Jheng <lucienzx159@gmail.com>,
	Albert-AL Lee <albert-al.lee@airoha.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: air_en8811h: use firmware loaded by the bootloader
Date: Mon, 19 Oct 2026 04:33:04 +0300
Message-ID: <20261019013304.1612468-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2d6df47b-2cc3-4003-85db-f72b878427d9@lunn.ch>
References: <2d6df47b-2cc3-4003-85db-f72b878427d9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 18, 2026 at 09:13:46PM +0200, Andrew Lunn wrote:
> Is it possible to figure out from the firmware blob what version it
> is?

Not reliably, as far as I can tell. The version the driver prints is
written into DM by the running MCU; the file holds zeros at that
address. In the DSP blob the halves 0x2506 and 0x2302 sit eight bytes
apart, which looks like the code that builds the word, but that is a
guess at an offset in vendor code.

Lucien, Albert, does Airoha guarantee any field in EthMD32.dm.bin or
EthMD32.DSP.bin as the firmware version, at a fixed place that will not
move in later releases? Without such a guarantee I would rather not
compare versions in the driver.

Aleksei
