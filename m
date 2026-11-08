Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174320;
	b=cobNZoS2PTlZ6sI0IODpd8/SPZuAeukRNL+mgqkgfqBiPUnmqv4TxMhgvKHOBxc01faF
	 Mnx0Yf9itZkf871LAGei3dq6MtapWT4IdQELkm7lIWeLgkgq0F5L0HaNCayXSlp3m2nIG
	 Et9l6/ZSqDIUxgWcWeUbZmYjoUxlEb0HYX5IhoBFuMrZPmIz+zRwswyiKfSVBsYUZ2RwS
	 R8gxcCVEDMwXeu1jZzUPIQ2wH1UHVWPy49KoGabczbUWkTZk7HSc3joOj+U0f3Vuto7D8
	 50N+WeABxLmP61TWO28EPmV0QxA1fei5/Zrix75JVe9lre2SSrmPGcN7icQ2/+QNzyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7kqx9M0twER2A25TafVF+Vm+n1vCyoVM7AQSLn5WPCs=;
	b=qwCcLd//VcEEFPyBJp9flYN8Ou/FEiD9+IYUt8/o0InLm3kLqXJ7S3vS3usu2inmB7L5
	 si/QHieagNQxPTiK2TE4h7z/bXgLdZPPeViZgRtdCXabUgalZ7VVE9yXOFXmHuPsjRw5D
	 FJWPIAwf+UHs50ZhaRoBbOF267VDZXTMhUXQEfGN9akN8Z+V/P4/Bxg0UHfEIL58yO6WQ
	 8geZkZYzUCZz9/qyWMVfIqwDjyaXfAwFPDErPB17U4ZVoLNSfXD7dDppSBhjw3ReRCmPx
	 1GYa7EdtjzeleyLkfAlcOM6YrkgNULvq//2UNvfCzpKYYzL8rkY9pnbLw8FOKLmxHAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hkYMsfH2;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E97606D807
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 21:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77E97606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hkYMsfH2
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0d09df973so203678a91.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 13:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794174320; x=1794779120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7kqx9M0twER2A25TafVF+Vm+n1vCyoVM7AQSLn5WPCs=;
        b=hkYMsfH2f3wxOpGpFyxrWGpT3NSKHkSCq3w81dLsEuApiG/ASPvnjULBky+PV2hQfG
         bIZhLWSevMNKv589FdZZfPxm+VyVVKuAqz8ld+OAl+kV7T6+FOdbct6fx1u0/wYcu7wP
         6ch9BaKmVp1d05GIxQdNSBIGjTZvad8jDMjrTHMGRrk32eq1KOkEegELAFtkX7WoBkDy
         uWUhcYVIUeiiz8XLpyT7EMyb8BgM8vfzAJGZCRkKHltRFKW0mF6n4cHKj3j3W5Tfl+kH
         dgRGnmot7zocnIbG4yH5VZ7a9vkVn34DU9RQO/kX80Ih1hdgbxuxAzv5rAW1qDyAbwb+
         ywZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794174320; x=1794779120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7kqx9M0twER2A25TafVF+Vm+n1vCyoVM7AQSLn5WPCs=;
        b=Xlv5LueutarS2KFsS4EcP8um/MBuclLWzhnvN/NlwnUQD2Se2fnf2e6ycQCFeLA9D1
         ARTudXO8ZaxKCUWof/L9B/Y+L5JUOktjm7B2YN4dX+AcCZ6Krx1bStVm2cogcKcmId1H
         hfBHqMSugXr/hyY/0sQ2hc3jmHavlQwqjur6XnmqbcTLV0tsWXJdKiqRqa9gub+wd6Fo
         nSWBD6MsVpxscJdrNmNPvdZ8ENXiW1uj8gw2i/RSZzCfN06aznv6MtXoi5FlY4jlWRFl
         /VXuTvFqhSzeeSya4qAyy0CrWcnJ0J7FobepiDJ7gQi3FvFD8yVkSkvPRomswflnBY2o
         Wtmw==
X-Gm-Message-State: APuU4Z9+Wnyb5F9g7m3173ZsWuB8xQhD9hHZbv7DTia7UDViUpQOKNP2
	3FSF20wDaGIi256qJpN0lwQp+OtlziQNwyGmYhWUzaecMPBYBFejCzuI8BB3sQ==
X-Gm-Gg: AYBFou06Z8DEK6uAybgs63eFK9rxEowTYO5I+KgKEUIeZTmwVbs/cO46Y5BlQ4/hQcO
	sGgeDKrJpp5oeDDj6ckw71rA+cs01QfODksDn2IWHjNzxSM/JNbN9xZII+Qyc+wcLbgiHHX32Ml
	pyqSlw238PHY6ltkMkBrKZfbJgCfvkzybY0PkGfxFpnb4j9CgQ2ru703SkLmTGbowEXJ6V7Ofw1
	lhot8S77pMj1jZtr1PJ7gHdqFVScHP0ePiyOlOK/Mz5vMSqonu7DhO9vV3xNV0eS/OTnzDAHwg+
	tq3fhCwnuHGxpp5PDOTOboe2JdvgGGJFE60wVZihoSRC5yU63dTfYT9zj2HtMHjTJx6/qd41op8
	epaNf1H+TuiY71nyih4jtSyMktTjrk+Mk3tSPJLeM0jylrZq5/i0WsoEqDKZbQmkOI4iFbmAmar
	/EifqHsqYFSfggulwt+8ZcDZLzUEqail12gjcsOA4rVhI23IJ7rkomM3n5xHOV2MNhOndQ9LR1O
	B1enlFwyvCnLz4FsUecmONXlFlao/M3Wa+srbhF+/wt0KRZ7b3zyEXEUDMcTvg68eC2jyofgJ+O
	JieRgUHkOPWJHLwOn6l0EPQGfjNIejCx0P+ElbvhTdE9swpYFNn/vw==
X-Received: by 2002:a17:90b:2d87:b0:3a0:9c9d:eb18 with SMTP id 98e67ed59e1d1-3b12d479035mr2063788a91.54.1794174319748;
        Sun, 08 Nov 2026 13:45:19 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1034718f8sm4619463a91.4.2026.11.08.13.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:45:19 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 4/7] net: dsa: motorcomm: Isolate all ports during chip setup
Date: Mon,  9 Nov 2026 05:44:44 +0800
Message-ID: <20261108214450.1662362-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108214450.1662362-1-mmyangfl@gmail.com>
References: <20261108214450.1662362-1-mmyangfl@gmail.com>
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

Chip setup only blocks unknown unicast and unknown multicast frames,
leaving known multicast and broadcast open, though known multicast
cannot appear while the FDB is still empty.

Isolate every port right after the hardware reset, in preparation for
the isolation refactoring. Note that this only minimizes the window: a
reset always brings the hardware back to a dumb switch, so traffic can
leak before and during it.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/chip.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 7686995b803f..fbf3a0cba49b 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -2220,6 +2220,7 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 {
 	struct device *dev = yt921x_priv_to_device(priv);
 	u16 eth_p_tag;
+	u32 ctrl;
 	u32 val;
 	int res;
 
@@ -2257,6 +2258,17 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
 		return -EINVAL;
 	}
 
+	/* Block all traffic as soon as we reset the hardware since it now acts
+	 * as a dumb switch.
+	 */
+	for (int port = 0; port < YT921X_PORT_NUM; port++) {
+		ctrl = ~(u32)0;
+		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
+				       ctrl);
+		if (res)
+			return res;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

