Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E95867F1
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986609; cv=none; b=n0fQhtp2rv0xfWyLpVPAnqLvCLnty5kWGo3ce7NN3di/aMTz2h12MBXhh6FvoblIFt/mFaAsCvyEhrgP8BdYxBf2Q5rkhHbviCtr2uUwg7ybrmMKfmbrClGO/ZzXUUvUVlyMV2x4IeRAuUVbbZaZcEKlWizvjgWRonc9QhOP7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986609; c=relaxed/simple;
	bh=QLj6uunsHhqrnqb4W1X3o/tolvu2AXeojwPQZ4VHJ30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qw5rd1byL1UCi7kpsTGHaZBbCky4Flq9E+1VaJ5lBDjB6T4JTBIVRUiaRPQFPPgRR+M/plRzlbb9UxgNQ/3Swgy3wPw3LfFN35Qna8FJbCs/RryvtqNZoY0E1m0syahYWDEkrpg+QxcumHtTPiRyV/UF/CuwH5lrbHU0p6hwnqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=buQZp8QK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="buQZp8QK"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48441a2ba14so5329247f8f.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788986594; x=1789591394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8grsZT6wiO1Q660+0ec29fANgzXjMngSvEn31FO65nQ=;
        b=buQZp8QKGQOsLAX3qV6RsuiBBaW4rS5CWHhxiieTjrbCoF0cwSKDpUcS2bf7nim/GP
         GO5QCIdMpmXrwF9eXwAwn9++wsmR6O/tVkYFKrIJwfd+H0O6AMglSgbj6AwXXC32ogZT
         YYXHqw0NnfiL2kGEpcpW0a3D1wh90CtxEmyVOx2OY1OvGvh6KyofR9E96Y5xUTzWbaqG
         CxSRlzalOzrKrD1cSQAZJy2QsJWonHIE581Zey4pORvTK///eZPpRFe3m/8XvmWyw6v2
         jcYckcz9+eX5eXEv51FfkCMQqlLSRY5J7dSSjO7Mh51FRM9lcwNPXsxxIU9KbmYa0PsP
         ZGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986594; x=1789591394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8grsZT6wiO1Q660+0ec29fANgzXjMngSvEn31FO65nQ=;
        b=NhD/nVg7Oe6tJmv8mG0Y68zmLYpa31gf5s9Bv8viUy4VoMIDL9BJMoi8k1fgfrdokt
         2ALOS/aeBD9mOA6wsNRUXhGwLShw94/3yWjQ1Ts3IjQK7X8nff26DSDoP2Y6A2nX/pgw
         tEdLm7903cwcUtvjrfwQ1mRQBieRcUMPAV81JXJE7alRKzyXkYhwk43vHWKvRQ5R2dOx
         akzwLAFUErrJL0R4WIMFt8s5B0NmI26GQZWVAypinbZG2gXj/oqatfem/+Dy52bCM7n3
         Ni7MviSfwcf7zLdqdm4OEQlyQOJpe4zawBPllVFSOvJTxzN6JbnS99XEDRPfZ/bO6L8I
         gseA==
X-Forwarded-Encrypted: i=1; AKwUvBzQVowEwQc344CF67N5NJjFWd8FXTSXuRxnEsgNnltF38lj51VZ+SSJK4ighI67DnPF/Vhj4Lg=@vger.kernel.org
X-Gm-Message-State: AFuF++nfhv9kcvpahOsuTv21e6WkqWO5KLcrhnQzQ39SiFIZhMq9mXAm
	UuD+HNlaBpIcS8ny/GdI8Zq9Hfh/wNA/jIICjB6brnY1wCKy21xc/JfRQWH1ZnsXadQ=
X-Gm-Gg: AYBFou1dnXa8ett9A+vJP4rQWQ6xW982c/4XMnvr1bvBnjYKNCE2koJQ1IibBfMv3kn
	4s3RHTjSph4Zp4XHuGuMNxwm23egBHHgJoTI2ezyGblkzDniPLDEfZWMnKemieVdtnAlomGAeso
	x5QviBxhhhIENdG+iMa0oClVKRzqjk6LUnARkNLK/PZjJ2D3InBc+fHA5Y5TqEyPGW9kZc1exEg
	sv3EpD07TTiSsDJy152z96LPus5WIBJs+/u1lD+11AsWXIDk35n7qzkXVBuIewhzQULkXx7EC9Y
	Vs4SSY3cUj8JDevgJ8J2pkcvGvd/xyydQ96dxPgjYkIdFyPhOsI3TI2AF2wfVgs+wCwEcrY7Oxx
	cJNIF/Gq0dRdSxkL5rx0KDd4grhhryfnwNns1oDhhcePezIzSAwU0vmailPVZa+dX9qe0VjHds/
	cPTWnXzlq0Kbu47NBiLNY7Qb7Br3gp3C8weebHmEll+p1FuoaDVQ==
X-Received: by 2002:a05:6000:4304:b0:484:3311:3702 with SMTP id ffacd0b85a97d-485872db94cmr41018597f8f.25.1788986593260;
        Wed, 09 Sep 2026 13:43:13 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858e239862sm40693606f8f.9.2026.09.09.13.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:43:13 -0700 (PDT)
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
Subject: [PATCH net v7 1/2] net: phylink: unwind the PHY binding when bringup fails late
Date: Wed,  9 Sep 2026 20:43:05 +0000
Message-ID: <20260909204306.2374562-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909204306.2374562-1-f@lex.la>
References: <20260909204306.2374562-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phylink_bringup_phy() records the PHY in pl->phydev before its last
fallible step: on a MAC whose phylink ops implement LPI,
phy_eee_rx_clock_stop() can fail with a real MDIO error. The callers
unwind with phy_detach(), which knows nothing about pl->phydev, so a
pointer to a PHY that is no longer attached outlives the failed
connect.

What that costs depends on how the caller got here.
phylink_connect_phy() goes through phylink_attach_phy(), which refuses
to attach while pl->phydev is set, turning a transient MDIO error into
a permanent -EBUSY. The SFP path is worse than that: sfp_sm_probe_phy()
answers the failure with phy_device_remove() and phy_device_free(), and
it assigns sfp->mod_phy only past that error return, so nothing clears
pl->phydev and it is left pointing at a freed phy_device that
phylink_resolve() and the ethtool helpers go on reading.
phylink_fwnode_phy_connect() has no such check, so a later connect
overwrites the stale pointer and hides the problem. A disconnect does
not: phylink_disconnect_phy() hands that pointer to phy_disconnect(),
and the second phy_detach() on the same PHY drops references the first
one already released.

Clear the binding on the failure path. This is the same operation
phylink_disconnect_phy() performs, so both now share a helper. The
PHY-side fields are left to phy_detach(), which every caller already
runs on this path.

Fixes: 03abf2a7c654 ("net: phylink: add EEE management")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phylink.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3ec3bb439109..6a92fac58f25 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2083,6 +2083,18 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
 	return phylink_validate(pl, supported, state);
 }
 
+/* Disassociate @phy from @pl. Caller must hold pl->phydev_mutex. */
+static void phylink_clear_phydev(struct phylink *pl, struct phy_device *phy)
+{
+	mutex_lock(&phy->lock);
+	mutex_lock(&pl->state_mutex);
+	pl->phydev = NULL;
+	pl->phy_enable_tx_lpi = false;
+	pl->mac_tx_clk_stop = false;
+	mutex_unlock(&pl->state_mutex);
+	mutex_unlock(&phy->lock);
+}
+
 static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 			       phy_interface_t interface)
 {
@@ -2197,6 +2209,12 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	if (ret == 0 && phy_interrupt_is_valid(phy))
 		phy_request_interrupt(phy);
 
+	if (ret) {
+		mutex_lock(&pl->phydev_mutex);
+		phylink_clear_phydev(pl, phy);
+		mutex_unlock(&pl->phydev_mutex);
+	}
+
 	return ret;
 }
 
@@ -2347,15 +2365,8 @@ void phylink_disconnect_phy(struct phylink *pl)
 
 	mutex_lock(&pl->phydev_mutex);
 	phy = pl->phydev;
-	if (phy) {
-		mutex_lock(&phy->lock);
-		mutex_lock(&pl->state_mutex);
-		pl->phydev = NULL;
-		pl->phy_enable_tx_lpi = false;
-		pl->mac_tx_clk_stop = false;
-		mutex_unlock(&pl->state_mutex);
-		mutex_unlock(&phy->lock);
-	}
+	if (phy)
+		phylink_clear_phydev(pl, phy);
 	mutex_unlock(&pl->phydev_mutex);
 
 	if (phy) {
-- 
2.53.0

