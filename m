Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64155295E
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882631; cv=none; b=KACHhWRHnx/UdIiUk8C2Caj2vNK2FR2ccDfOlFDT/fpq5zBU10IT4NfUAUvVcUvvKfniEa6HeF5STtlp7QdwIleKM0/P62kT1uokFbcayF9mtSS6maVcTX6+zT0Oi7AKxzRUYMLSK5wCXifpkBZ18gIENZekG1QRk/IRF/xeLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882631; c=relaxed/simple;
	bh=sOYHLTiChIhrVkwNVC1/9IjJLRP8fORJ/3H3PHWwqrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jvr1jeZ2YuQbpRdMz+XOrmG1vLMaG98VUo9lXkgVRpvBisUNAvZF9rVuKVOlf5oDWMtpgU6kn8LwuOzQqSy14VeilB0Zb8FCmIR4kdLfpx1B+Zdx+2S8AkNsKSkgH55nTVtxPJnnKAXwD2QOKYSIKMaRYFfmoIPnB6QmozaY3Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=lT5nbR7L; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="lT5nbR7L"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d05d51553so26492875e9.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788882628; x=1789487428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ocf33sKaJ9kuq7ndSPCdhJoezpQyYrKkiYm5HN0yF7Y=;
        b=lT5nbR7L4d8StSVo70d4+f0hjznpTI9tU7sQuNVl3qjFHLNymWKR2j7/AFBvwcXjaN
         foBYzjW8UFMQMuoyfu9X61Hnv6AsSeKPJPn1bp7IIgrf659ZbOzy6SwEQ33mpE6XfDjd
         3rLftBMDrY4qMPXk+XNLA1O45sv/qNCVhCWTbu9MqHrvICOR83S+BxxoHKNXql4guS7o
         F8oTjnsaCLDNi0pSxzMiO2eGOddZD+jR7+9ovwmDG8eRjg+GXvbCrpySCBQfuepWp32D
         i/gBFpvbnMNCMq0et+p2liJG0idqqHBQWI9oJjQc/QC/RXYFFW0kuGUYuRlIo6v609wO
         dOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882628; x=1789487428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ocf33sKaJ9kuq7ndSPCdhJoezpQyYrKkiYm5HN0yF7Y=;
        b=O5Mtmh+0Sjb6PYGgNCfzv4VA3vXjlkKbYYU3pn4oYD9ulcl2BeceqWmg38HhxjR1gi
         x4hgq50bliP/Fc2UXOpJFw0tOhqA9lmi6ksXEOXKt8atE7VijBan2fdRnU5E1WL3JqvZ
         xy+Rc8XR+i44OfrwuY5EdDJUcZdd5bqMi7Tgpd9nVqlqQqAS3zAi/9yWr2dZ13YScPiF
         Tdl51pLtV5OXIBrjsagc9hKXO5zB0x1XT5j5yiCaNtYSRH2crw+DMPaaZfPrUEASApKb
         Sv4NW1roNjiXw8wL5cstelQyLV8W42FMn8jD/J0XwyU2Z65fudLm+3u3wwTnVhM+oLLD
         6NgA==
X-Forwarded-Encrypted: i=1; AKwUvBzOmDvXhvgD8UNAcsmmuD2CsCrnzReuv3PSqFB3phwWnUFFTS93kUHCYydXqcClIq/gB5iHvhA=@vger.kernel.org
X-Gm-Message-State: AFuF++kxggFH0+m9mZ3IGjtL+vttCERK+JgXPdDNDSOYL3HyoijdkMnz
	Bdw9FTHSyHyJfGO+KhcUzP9LZEjXk6sglMN2QJgMKy3hb4aSkfW/5ftWffo2ZhKNJuE=
X-Gm-Gg: AYBFou1FgROqn7cvhh9Np8EcWhO9AUz8ArH+o08nHPNtI0QNM1abdiiafMWS3xfyy8H
	d7HnvdqK0S4lgGQkws/5/Lb0BfpJoBOUkuRS8OdmeJbI/kua5mnL44PDWR3Rv6yKzxqiGiErYun
	9lJY9txicktYX6ZoEXUUfyu3vhkKDhX/MSD6Qx+Yyd4Fhs4TIazS710TxCP2zfcrlkCex03kLSP
	mYUV6v3ckzIb36ukaIDBBr76J7iBCzFRBD9xO1AG9gfspeZFkN5awC8JN7ZHt3xVrgcgvnGRqSK
	n6LMOE4anEi9qCJu+mSL8abHqKZXbL18yoCJyUkUt2sc6hiEUk+oMdZy9yRSzAjzpVRBOl9vRRQ
	erRuZl7R+mU23p4p7z+ZFthu4jxqB9+RCy9bE8WzDKcJUexkGfXKEypbHbqoV/mO4zuUJ41NC6U
	AbPUhLClbGtBTm5Yelz0iQgvdfLxjLz6bQ0QWXnyP5ItGAzJzsqA==
X-Received: by 2002:a05:600c:8b29:b0:49c:ee22:364c with SMTP id 5b1f17b1804b1-49cf824743cmr303896025e9.9.1788882627905;
        Tue, 08 Sep 2026 08:50:27 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bf3f0sm40869652f8f.33.2026.09.08.08.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:50:27 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v6 0/2] net: fix a stale phylink PHY pointer and a lost PHY interrupt
Date: Tue,  8 Sep 2026 15:50:23 +0000
Message-ID: <20260908155025.4155289-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes on the same path: a PHY whose driver is a module on a rootfs
that is not mounted when the MAC probes.

Patch 1 clears a stale pl->phydev when bringup fails after recording it,
so a later disconnect cannot detach the same PHY twice. Unchanged since
v3, where it got a Reviewed-by.

Patch 2 gives back the interrupt phy_probe() replaced with PHY_POLL. v5
kept the number in a new struct phy_device field. Andrew asked for
mdiobus->irq[] to be the source of truth instead, so v6 reads it from
there and the field is gone; the patch is now four lines of logic and no
new state.

That leaves buses whose driver writes only phydev->irq and never the
table. On those the table holds PHY_POLL and there is nothing to give
back, so the fix does not reach them. Three are in that position:
lan78xx and smsc95xx, which Andrew named, and sxgbe_mdio, which writes
its own irqlist and the phydev but not the bus. Converting them is their
maintainers' call and I have left them alone here rather than send a
series across four subsystems; say the word and they follow.

Measured on an MT7981B board, an MT7531 switch port with an Airoha
EN8811H whose driver is a module. The generic driver binds first, and
the number is read out either side of the detach that releases it:

  with patch 2:     bound: irq -1   after detach: irq 15
  without patch 2:  bound: irq -1   after detach: irq -1

-1 is PHY_POLL, 15 is what the device tree gives that PHY. The cycle
repeats once a second and every pass on both builds reads the same.
Reaching that state needs a kernel that lets the generic driver bind
where this board would normally refuse it, so both numbers come from a
modified poller; the patch under test is the only difference between the
two builds.

Previous posting:
https://lore.kernel.org/netdev/20260906174643.4107607-1-f@lex.la/

Aleksei Sviridkin (2):
  net: phylink: unwind the PHY binding when bringup fails late
  net: phy: restore the interrupt the bus gave a PHY

 drivers/net/phy/phy_device.c | 18 ++++++++++++++++++
 drivers/net/phy/phylink.c    | 29 ++++++++++++++++++++---------
 2 files changed, 38 insertions(+), 9 deletions(-)


base-commit: 38b6be101006d3e7af972999f45d4f1e8250587a
-- 
2.53.0

