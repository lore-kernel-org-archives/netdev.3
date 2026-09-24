Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312013DA7D9
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790293739; cv=none; b=tPL5zSe5FC1+Z+/PTTrcfFzMtRrGDZ83Wbc7zs8GCYVRq0WAQOVJn3E2wMMvR+GlcBQH0owvr5jxjePnjsumRxKEedNcZTyKuHcCYkDe0taAfGxS7iFbAguvUc8TlhlcG69RUvWtuZb0MUXHH1T7zeGtS+BLXhMdQnGHAQeDQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790293739; c=relaxed/simple;
	bh=dbHu+AE4VkqwE4hdxWOw8Pd3ulBp7JneHZ1XgHBh5Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KROb5KI63mjaKYeYSmoPVok2LdvskliWe+FjSh1+sHry2XZP32YgE0B0eXGX2CCmNAUViFzFxEIa+R7mzoA9YVOF0Ws+m0NQg8o9sLo8/34SKwrEVuSm5InecL3nZMudVVncxiQZRryZZ/gvbg3ZTJALN2BE+QOnmi02MLscRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTF+YdPF; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTF+YdPF"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so54105266b.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 16:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790293736; x=1790898536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dbHu+AE4VkqwE4hdxWOw8Pd3ulBp7JneHZ1XgHBh5Ks=;
        b=MTF+YdPFRUMY99nPghn0rh1y3vpP7ACV525T+k4SSHbV5juIrKCufP0psQzVF21i0m
         nKd3RSjS/4VQcGrNXmOxraACkZPKF0ivmU/pHdoDNXPeYDYAQqRmHVhr8ywKY/3J6fWd
         GbY8HBYWmWmFNbM6WaLvs1inAdigmckzi1sgQZyta7FVMCTmDFeSIaEo41cLq7aMh4cF
         vDHBV8b3wAstxwKKNOgK9sSAIWZ8DwPEeB6rdsEy6JMHKepiEaeUujnYKMgDKmlar9Zg
         x4muAxm5J5uOKWx9GQRozNf/6fhdGInntJYxztOTL32zR6gF+SBNGvRbEv/DX83KpYqb
         9E2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790293736; x=1790898536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dbHu+AE4VkqwE4hdxWOw8Pd3ulBp7JneHZ1XgHBh5Ks=;
        b=Hs6juN8nr+2EDy9sn+zouBQw9qvB3ghoPMhy/Fo5UQQAQCvfu929MrnncHJY/ctb9G
         pJohzbB5aagU3xydBaWluveE4n4fuIkoXN41PDN8F/2HITxUMaKe0lHTg729YwvQH8yo
         JDtMX6KpRoRHpjn6JFJuSUdITL0a66h8RjVYzKPnyoK/IhPLeoQ4JSWXhT1zOKBXgpIx
         6yrMZvrziXXimBNkZPlzUl/ouNWLr2ivczXjZFnmzaeLP5qzITBLBTHlZjPnlEmatrpP
         ccuGzmUyrnv8qO2UoNpdzhzHCutAbgjWHbKRU2gUNl/1e4sAy/4h1nCs3RFz3AkoOgYi
         vxUw==
X-Gm-Message-State: AFuF++lngzUQZ4FhkcpnWPpXYp4AitW8XUkTqepTi3397SC/BuglE5Us
	Kbgq8rse2KssvfOheTl4EKDEdR5aI2z9Sm8rwP+hlMRlm7zfjg22yxzI
X-Gm-Gg: AYBFou3Vyf9D3L34w0H54yfUttmP6v+qtndhKwuqgXsdVI3jfVyw29ptXqUKbuZX2tl
	MouFF9Yu/pXdGLwuEYOsPW6RDJLylieh+E8iJYSkZpke8AqqGIINFsid/GWK0r2slsIqqmcRVGl
	RIYIHa/M4C0qLJtK2vzxdTldUrQC4Gx5up0n2O4GHBf7w7MVbB7LRo+GSPGYLRBo29GI1CQEUP2
	9l1kqXkcQIlp2agIXfnBtxlnKJHrCs4izLaNCAHJnykfuMy47RNbGNYUk+O4efIX6zPmp/+KHmS
	E10YImfvGl6Pbci4Z1kZ9LQj3XyvzRJM4gylgf1uhmZMxamsmthwJR85VkqjsJ+KDfFppnJocBN
	U2fyaC4vBaoWHFqFMeacxKE7p21QJ140qY3sPyAVUbnLjzgvTTRI/EdVyk/vw2Wm/RA4lQHMDpO
	zPCgxT28J2VlCKwNccHoKYoUS2hY9VZ67oapgkuWk8Rx43XdQEi5Km9i7Nv9/l2YRrDG+Pj0bA3
	rDLK4eKcM1eV8vDBfcUoLiEVw1LodioVOvCrB+Ht+xjPZ7y3JEzFZRVlpaqQZ9j3BFyI4wX99Qh
	JyMgsz2Tc63+dWu9Rv//J3/ml+DmFzo=
X-Received: by 2002:a17:907:9346:b0:c29:f5d8:9c80 with SMTP id a640c23a62f3a-c2ac22d5a02mr344175566b.47.1790293736279;
        Thu, 24 Sep 2026 16:48:56 -0700 (PDT)
Received: from localhost.localdomain (31-208-26-100.cust.bredband2.com. [31.208.26.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae757ac8dsm30673566b.25.2026.09.24.16.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:48:56 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Ziyang Huang <hzyitc@outlook.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jie Luo <jie.luo@oss.qualcomm.com>
Subject: Re: [RFC PATCH net-next v2 5/5] net: phy: qca83xx: disable SmartSpeed before resetting CPU PHYs
Date: Fri, 25 Sep 2026 01:48:41 +0200
Message-ID: <20260924234842.1405-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <c09a810b-79a9-4a4a-b484-c26e1b4acb52@lunn.ch>
References: <20260922202653.1153-6-yongzhao.derek@gmail.com> <c50f5ffd-a67d-4adf-a38e-048acf7bd61d@lunn.ch> <20260923215735.234-1-yongzhao.derek@gmail.com> <c09a810b-79a9-4a4a-b484-c26e1b4acb52@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

I agree that if downshift is broken more generally, disabling it in the
PHY driver, possibly with a default-off tunable, would avoid the need
for this flag. I have not established that. I ran into this on my own
home router and don't have a way to force a downshift, such as a
two-pair cable, so I have not tested user ports. If anyone with
QCA8337 hardware can try a user port with a two-pair cable, that would
answer the general question. Disabling it in qca83xx without a flag
would also remove downshift from user ports, where I have no evidence
that it misbehaves.

On how it differs from other PHYs: in the failing state there was no
link at any layer. BMSR read 0x7949 with link and AN-complete clear,
0x11 was 0x1030 with resolved and link clear, and the conduit had no
carrier. So I have not observed a downshifted link, only the 1000BASE-T
advertisement in CTRL1000 being cleared by a path I have not
identified. The 0x11 value does have bit 5 set, which the QCA8337N
datasheet I have describes as downgrade, but bit 4, documented as
reserved/always 0, is also set, so I am not relying on that decoding.

For the next RFC I would keep the flag, limited to QCA8337 internal CPU
ports. qca8k knows the switch model and port role, qca83xx owns the
registers and reset/resume, and get_phy_flags() delivers the
requirement before the first reset without the PHY driver inspecting
DSA topology. phydev->is_internal also covers user ports. The
workaround has only been tested on CPU PHY4 on RA74, and that result
does not by itself show that a flag is the right selection mechanism.

I have not found a verified erratum for this revision, and as a home
user I do not have a Qualcomm support channel, so I have added Jie Luo,
who has worked on the Qualcomm PHY drivers, to Cc.

Jie, could you forward this to someone at Qualcomm who can check
whether there is a SmartSpeed erratum for the QCA8337 internal PHYs?
If you have seen SmartSpeed problems on an internal PHY used as a CPU
link, or have a recommended way to handle it, that would also help.

Christian, as the qca8k maintainer, have you seen SmartSpeed cause
link problems on QCA8337 PHYs, either on CPU links or on user ports?
That would help answer whether this is specific to the CPU link.

Would you consider this CPU-link scope and get_phy_flags() approach
reasonable for the next RFC, or suggest a different way to select the
workaround?

Thanks,
Yongzhao Chen
