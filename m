Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043DB4483A1
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292281; cv=none; b=L9vvOOug3rYhqkDMfTF/x3CrSZN8J6259SsHAFBcyrasVy8YJFxItjkfCyMkeGFGYjh9KvGuOhRYrf5xVoGE0WvbxKVVl5ir4aYkO262sY5ubr1/Oo+Z+9/koffyAYOh4Ku/uS4xVL1hSQfocoawKVe15V/12ELFDfSbNsb4lYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292281; c=relaxed/simple;
	bh=BwLey5dTW4uM292A2Vd7bSxkboLRHGDZjGIzXx+42J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeyTndH4AxOVvSCtK+fpUD9/KWxUytaq7qd8ILe9V1fO07BmrVpNgfvL81Sjjuoix3vo366m0Jdqbk+M7D6nmShFvENcIUCMh6X2dxHcvOlFkovCQsdeAeucbXElNBRTvy90EpKFxpojSCG6O8BKilAJiKVG7D/kXI64h5UTEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=ITG5IN46; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="ITG5IN46"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-482fc3327fdso216123f8f.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788292278; x=1788897078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BwLey5dTW4uM292A2Vd7bSxkboLRHGDZjGIzXx+42J8=;
        b=ITG5IN46vGcwvMKwBFWO2A2I4biFNMH5plPiYYnUi99kTt9ug7TJsZ+OjrRkJP1CtD
         4QzTASJ244haASscNMebdaW/qh4UZpcFnerkaVFy69wpBnYutrc9DxKlhT1vU95OMmx9
         xi6igBx8aoBG8OfgM/QbLOwdRErxuq6878+/L9Nm/ktpQ5hC4Jpd7R6inINqoFz/rLzb
         5yUl7jUXXDsM4Z426JilCySPd3Ae50esTRxex2b3iaumu5zuZIHrz4P7SwsVjwo6N4ag
         cp8oP7OoHA6S7Js8Brio8WESvaMULs0CPEB3pel7kQDeXFhqAjS8L1qm7iQco8DyyIIo
         WM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788292278; x=1788897078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BwLey5dTW4uM292A2Vd7bSxkboLRHGDZjGIzXx+42J8=;
        b=FAFnC4SrhFmhyW7ZRUNrunXnq3/rGD8wpqUcqPLi8mDsnWyQfaUBtgGAfCYphvnl2Z
         QmlcvnY+uKWGQ4CWyCkSYwXlxLAO58K/ha2PtIO3J6cjqdu5dvSD8lcXlkoOwplH8iu8
         oISMbDpouBIYQEZSa8pXGljTjH3urnPrgB1ydsTI0F5gcC9ujJbTemSZi9IbW+dsOR/W
         OOp0e6g9a3JuaUT7egPjzqe/jKUyr8UmMQFrDIUdfuRvWx2U4Ph8iJi6vCeBoR5Uhwne
         hZhdaSLqMJMG4ZtC2rdGpGldd1ScVZs6ak5r4WnLemYPklcZzb9CDs1jIs/UOc5cGN1z
         tu6g==
X-Forwarded-Encrypted: i=1; AKwUvBw9IWqApnsyq9NXysijFOaii89D8gO65KYJk5FPYtwheuGP2sJXnYyRSCWUw99Wi8MMfM1Pkj0=@vger.kernel.org
X-Gm-Message-State: AFuF++kHxgmmOFm4by+ynaX8Ml7ZkKOXb9DVwE/jmoGavPKy4MkQZQiC
	iYP624A4NdrhvJwEAAMwvCVpxlGwvi0VZVGLjuMGORdsoRBsrPwOWAASlfgsfLfBYRg=
X-Gm-Gg: AYBFou3ay2JuqhRIJH1RcA8/N09BLnZ+Xj7cntF8KbJ7MnjN1kPY9Jz1dti5lY+c/c1
	sdJsdSeGvoJgxrN2nzJA99Y+unWoAkoIfHAcs/5+XxcxXppWAsQE/8uxi0YvMiPXtKKkyBwFkgN
	DpqyyQWkPrnh0x3uLljfIYvaNx5AsflTbH4X9OxYPURtctM/r8qWgG9F/KP9GcTfSJ0gOCvzMft
	G+b200E9xA/0ETPsdyrl5OS3yhStXFg7UoVWMQVdvOoSi4wpHR4qG8uR1OagF0qWVjl2x8nNRE+
	7ziQm0mZqzyvdDBmDavd+2DuQVICxl51aIsvAUZwB+0eToWzCwz9xKcn2iqYAANtLehH1RBLKtS
	yNua10yox8tIHvyvjsTmO7tJ2SPKSlTyzDinyl9pHLScNyjIKLrSGYVO468RFhpFVL6xaTuO6QU
	2IppL9tb/U20PmfrkDBy50ZanxoixXiiCIS5IdP5RdK9somJNpMQ==
X-Received: by 2002:a05:6000:648:b0:484:4189:6b09 with SMTP id ffacd0b85a97d-48441896b75mr15334529f8f.17.1788292278109;
        Tue, 01 Sep 2026 12:51:18 -0700 (PDT)
Received: from remote-01 ([84.17.55.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492ce236sm1316681f8f.35.2026.09.01.12.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:51:17 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Chester A . Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v3 2/2] net: ethernet: mtk_eth_soc: populate lpi_interfaces to fix EEE support
Date: Tue,  1 Sep 2026 19:51:12 +0000
Message-ID: <20260901195112.37184-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <68c51086-eb10-4074-8495-b31c8e8a21e0@redhat.com>
References: <20260827211652.63504-1-f@lex.la> <20260827211652.63504-3-f@lex.la> <68c51086-eb10-4074-8495-b31c8e8a21e0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> For a 'net' patch, I think it makes more sense to restrict the lpi
> interface to the chip revisions with support confirmed.

v4 will gate lpi_interfaces on a per-SoC capability bit, so only chips
with a confirmed LPI exit get it and the rest keep the current
behaviour.

MT7981 is confirmed on my bench: with tx-lpi armed the PHY's MMD 3.1
shows Tx LPI asserted by the MAC, and thousands of LPI exits at 1G and
100M against a BCM5720 lost nothing. Details in the v4 cover.

Qingfang, which SoC did you validate the wake-up values on when adding
EEE? That would be the second entry.
