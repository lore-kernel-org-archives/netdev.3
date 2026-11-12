Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489296;
	b=35ARGeHSk5OCEgLerrf2irZxZf9BQxbb0Z9/I1wXILstNG9annEEE/zZr/2i8SC3ERFN
	 rWF7v0pLnrvdjU397YVfsmEsTCJOjT54mKtnQ9GhjacCEw4ggPGGHGHr076ncQ1v4pw8p
	 CS09vgRfny388bKT8UWbteDv9Azfh559Zo+mB81a0d9KeuMWQQKHmhbOx91MI7JSpbkau
	 AP8r98hlpz4x/FuQjWRLAENNJrkjCEmY4Q/Xj+yObflQ5rRrfq/Nwk9RUJGvQelMBn+4I
	 Q79455j1YL6xFaJ92W3pACUxIBcYQTrZjE61wdwWVYp3rqrXo8OD47cLD5NPuhTyxzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l3qR4fbwmcH1ch8aJsFgigRVRt4HxyD2/C6Feim+5RI=;
	b=KDqUN37zRKdaCH3Esm21Xgbcd95E99wtzYodglz+Zi3i0Kn3PUz0cgVmAsUz8u5OXBu3
	 XZiA/Ta53EshlfP+GGsKSg4UX2nChyECCxvZ7K0Qnl7KwD2OTCxjwsfPS5y8GvzY7CGUx
	 wQE0RSkpHz5S7oVkeC3qHRQP5zmBIJi2hlrmM3Fb/i+pkBkF21Qjiv71ZA+kUGfTlebJK
	 6QKTNgLcAgIn5bnhcStv0l98Ob5Co8mkGuJnKbGtEWTKyks1dOLnvxDW4Je0DOgzKn6qn
	 kc8HuTSK1ppFmA0Wv/7FBbBztfpwttxJanLSx3dsmrnruz4J0mFShg8WVc+xh2a0Gpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxpD6u9r;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8E1606A8B1
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B8E1606A8B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxpD6u9r
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso40700485e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 05:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794489295; x=1795094095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l3qR4fbwmcH1ch8aJsFgigRVRt4HxyD2/C6Feim+5RI=;
        b=oxpD6u9r1PIdjZiJXIwCdj4PZnoYigiueu0k1eB5tnXI8EhoUmY4pXfe51EtUAnFNj
         atmBKHNaEUrIjdL1kRTPepktv7bBpma5C5deNxi4g2TsrIPAdNKmAlXoDtioWGXB0PgK
         2E1QvvSKa2hqf9WsTEGC5R67UqyA1LP9QBg2KuJB8dkz1iMPK+wu4UE/QJi2uGycL0Op
         xLuSWuEbyQTxgeVoaSZ5gONzsPAgpWozuxYaEpwoavwH7bTwqXSGZqhJF9lUrhFHXuSm
         n9i0ro0Wi1SD8hAUOgGu/9uBJB4LnRWGrEIrJP1QPNmlI3MYTmpMMDbu1W15eYAntCV/
         eLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489295; x=1795094095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l3qR4fbwmcH1ch8aJsFgigRVRt4HxyD2/C6Feim+5RI=;
        b=qrc1xDCkmb/yn4RwSlUF7iNbl0/xr/OsZRiwfjVFCKn/5Zp6E4QQCfovCweBovCWbY
         tjEzeKQobYy4+RxoLnvjnbM1lRKW10PeQwEB2ScfAM3mcj6rlb2RlQxiNe8bvTjwOiWw
         gUHHLhXlpGcjUgZAFRJgHZ6TwJ6MMKJltwhFIcEflmlI5hRyisCqaZNkGUFOtPBiBGJH
         U7w1/agDUqUN7SfIuZw66alyHFqEdTDLbiF0GNP3RbdBBX1t4r+zaQUHfb8gmj/VRspG
         QttDgZJWJn9kLpJ/8Y3a+4vZZO5GM8wP7pIZdeTnGIFlkKe6HhaWeN30hFCXcLlQMBGe
         KuaQ==
X-Forwarded-Encrypted: i=1; AL+hErFw1iTycYAbV5UxGN/zSSCGXodNyaRzLbmW1mAGjtZUNTB2KIYQEGi3gqNR2FcgdoTOk1hhwdk=@vger.kernel.org
X-Gm-Message-State: APuU4Z88BgDNDcyJ07uhgwFO3lKe2BsL8ZSahzxoEH7khIjzLyYpxmEK
	LFC4FisK8mlYmK05n1E1Adya4L3fwhEQa8ToThj8fAzvzWx/upSK5AsD
X-Gm-Gg: AYBFou33mmyAp+C6AWZQ90nh1aZ4lcb073vfgFvPoIpPv6IcGwwb4MCMmaJuuX+kY2U
	57s5WJzpYRTOX3T24acgyBM7P0x4N4L6lz28cD16tIobksaKZEsr0Sn/NSXr6jN/MlpGz2Zn1u7
	pShYTJJA8yYZB/ATyvaXqbCeMj/H2otnNmpdrp/yIZy8hgm4RI/AIprO25SRhMrvmr70ucpdMPs
	TU276oFRqr/17CsbLiq7Voqt9AvNZjbhJAyCdpz1j942+GA0hRWp5jHhwiT45PTNBKUNUuSYCGw
	WpG1RHYpPI5qewx4h3gQcWtLy4FxvuvO4b16kyv4GzuAZ6rBNkLxaDfyQnrn1xGINigxRANqW/J
	8H8lkP3k59io9isqtedrmT4+eCdZmkJjEMSxhkm0qW72aNFoccZiPh8ZwSZu1WWZginmtdEHiS4
	M78NSRiu7I6RioRr8RtkyxVLc5oxoOH9NVL8SQg6Wl7Lw4bl145MJy4aRxEBtxZXEJicpFyONKv
	nNwiVKgguN4RvNWcxJaqbWJEaaMblMoWWM6EmrZPZu7ZPNUWsV/zCoWao4qqmD2yXF31ntSrS/G
	qibsdFrzP1SpjF41wKP/ga0mBChKWbJxFgqsk+kPtna+w6j6SCypRilcPvGa/fXrEm659H61ZNr
	+kVdJ/tostjn8GC1lXnE3Xs3fNErWqgoerH1PSFiEjAzT/rJMeHjqEHuwg/eUZ9yS3+MvnPnr5Q
	==
X-Received: by 2002:a05:600c:3e8f:b0:4b2:2ec5:8a2b with SMTP id 5b1f17b1804b1-4ba0936c927mr96232865e9.10.1794489294531;
        Thu, 12 Nov 2026 05:14:54 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (host-212-171-11-167.retail.telecomitalia.it. [212.171.11.167])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4ba0951fe22sm146453225e9.3.2026.11.12.05.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:14:54 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH net-next 2/2] net: phy: fix trivial whitespace/format issue
Date: Thu, 12 Nov 2026 14:13:57 +0100
Message-ID: <20261112131358.106442-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112131358.106442-1-ansuelsmth@gmail.com>
References: <20261112131358.106442-1-ansuelsmth@gmail.com>
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

Running checkpatch on phylink code, points out some trivial issue with
whitespace instead of tab, if-else condition with a return in the if
condition and manually printing the function name instead of using
__func__.

Fix all of these trivial issue to mute checkpatch warning.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index bf1962e572f8..e7734e45376c 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3151,7 +3151,7 @@ int phylink_ethtool_ksettings_get(struct phylink *pl,
 EXPORT_SYMBOL_GPL(phylink_ethtool_ksettings_get);
 
 static bool phylink_validate_pcs_inband_autoneg(struct phylink *pl,
-					        phy_interface_t interface,
+						phy_interface_t interface,
 						unsigned long *adv)
 {
 	unsigned int inband = phylink_inband_caps(pl, interface);
@@ -4080,12 +4080,12 @@ static int phylink_sfp_module_start(void *upstream)
 	if (pl->phydev) {
 		phy_start(pl->phydev);
 		return 0;
-	} else {
-		ret = phylink_add_sfp_mod_port(pl);
-		if (ret)
-			return ret;
 	}
 
+	ret = phylink_add_sfp_mod_port(pl);
+	if (ret)
+		return ret;
+
 	/* If the module may have a PHY but we didn't detect one we
 	 * need to configure the MAC here.
 	 */
@@ -4207,6 +4207,7 @@ void phylink_resolve_c73(struct phylink_link_state *state)
 
 	for (i = 0; i < ARRAY_SIZE(phylink_c73_priority_resolution); i++) {
 		int bit = phylink_c73_priority_resolution[i].bit;
+
 		if (linkmode_test_bit(bit, state->advertising) &&
 		    linkmode_test_bit(bit, state->lp_advertising))
 			break;
@@ -4635,7 +4636,8 @@ void phylink_replay_link_end(struct phylink *pl)
 
 	if (WARN(!test_bit(PHYLINK_DISABLE_REPLAY,
 			   &pl->phylink_disable_state),
-		 "phylink_replay_link_end() called without a prior phylink_replay_link_begin()\n"))
+		 "%s called without a prior phylink_replay_link_begin()\n",
+		 __func__))
 		return;
 
 	pl->force_major_config = true;
-- 
2.55.0

