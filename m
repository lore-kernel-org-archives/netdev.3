Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C332861E
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696286; cv=none; b=BBUbmmo8NhK0Zr93Eoe/a+kv06/e2fzh31NWH4+lz5cKrgpDITeu/x+piF31rx+PtSY6frQvr2XFjrlqNkaGrlIcTKpdkgU3eIz/m1VXzQoBtbZ4VxciqoUKSXtUxzsX3oLiYQEIB7Rm1quEmLGFcX3ZcP7tCwihccTzHJ4dc9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696286; c=relaxed/simple;
	bh=AiEucyKYQMPvNWo+IIVc/9PMmV76gLA/FT7OpKG7L+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AaPfjFDYDNUS3DOnFPgB3L8mEvA/HBBCDiIIkfgISk9K+0z7eeCgdyDrrjpTGTcerZGGF2b7xOFDdA0J4HWng1EE7ev5aJsvIujGjn+52B+df5mWnRXrxZV7AGTsEUv9ZSHiLPhnFgSnMAimBG7mDDt+/7pf2syYn4E1pP6KUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=E1WzphlT; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="E1WzphlT"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so1006665e9.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789696271; x=1790301071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vme7iQX7z/ojmxoziUOHospzzgi7+w3Pxzs6D7kYOBQ=;
        b=E1WzphlTuym0BKD8YQegEtuxlSOcqncihpr6N2tMg53b99Wh2CYt0h4Z2fJ5UyKxhh
         BwNppCewlexcbOXEc6UgdtmDa7igjMQmAx+/ZfXpoz2Y8YEfaEbPWOuFo624S7Tm6zSw
         X87dbYDoaNDTlfUN6LaerQ0HWLzJtt9nBcmUzP82Uo3CEdjcCSgKpQGwjkHAHrm8MNUV
         i635SDcz7AwZNMAyvWoJ0j73WNyRmAXthDLaHFF9pD8FRxAdxiHtBRHMP0eRQi1TRjTj
         bThEMNJP1qFFnBKv1Paenn/SdQJEwSYem1FaHJBXY6ORPppUlgEU4aiW8M8921xzVDPC
         3WZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789696271; x=1790301071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vme7iQX7z/ojmxoziUOHospzzgi7+w3Pxzs6D7kYOBQ=;
        b=FCDUEsbBz+iqbjq2qq6bqt+7Wm2na0LfY7i9gr3cn54shuwj+ryZJVna7maNmM22/k
         jXpgDvTvc/lGhXPMRvbU+MkS+VZyXqhkPBPadZkGTnGuZ/qSSFapuOuLw+WhLrPfJQ/V
         lyjrSCdQBQhYBp5q8HStFqPK0ik5NJQIRn2a0ih9dKCl+XAzQxcb1m8sbEYNRsDyOtfj
         4hFqJUzgnJZiYfzJNPdo8dS88km4BTS1ZsLaBgN1QF7BIer4DpfBQh502rMKhDpV4nDT
         2qbkYz43GzDPdNNbsgbwZvcY3zZElhCiDJnsUAO/FNmp3bv5Tkd4foM65eacJiZcXFda
         CGEw==
X-Forwarded-Encrypted: i=1; AKwUvBwuJ2hnt+v7pmfwaiTsSckiejGnS37HUSANJEYdG9KidA6BQFu1u1n1Ijdxe52TMAjKgCJOa+k=@vger.kernel.org
X-Gm-Message-State: AFuF++nKgOGj9GTimEKN7a29wb6klK9XQD8K+rr9528wL+yGivPwXL6y
	yucAJieIa1SxFt5LN0QVcsTJKz5NEArvAAvJb4G1/ZRdspsE12umws0D6hjPLLJ7XyE=
X-Gm-Gg: AYBFou0AeKkA3UJfcSBNCncXYZVLj2N1S0y+P3OryLRojcH9EaQntoN/H71mtFCRvHf
	Zd57G9UXmLdUroVXeMocDvtPzsXe6ihPAT6Tvbmg2E0Tb7psTZ4s55u72wgBx944txodSlM5Bba
	UEsbC9Jvp8IGM1E3qol1hhNxhGavRzNfnuuKT0DPjkuE+I/d6ezRvi0oDtOFXi89LiVOw0tlBgh
	Bw+4kjmqXNKstlDmYz2Xhu3t/FIAFm8zL/n5rKwzpMl7bxuaYSVDOzSlIKSc7lN4UXIt5r30xRw
	QqLG32vqQw6SeIj2X82FhTa65Dp3Tw3354drQ6L8HqgIthzVUa3N5pBhJsRvQKs8B8kaXpZ/aXN
	KFOm87n1/TUgr7+/hoKP9SYZg4qKCYTof1MTAlRkVxjKnUro4TbXfDE40AF/8Ez7onwuM3M4EBk
	e0zq+1cl1dnnvRuwnWQMBdAFBPpp1jA56JPQHNOHFzf6aTj9NL9w==
X-Received: by 2002:a05:600c:34d2:b0:49e:6838:c813 with SMTP id 5b1f17b1804b1-49fc5865314mr7179095e9.33.1789696271060;
        Thu, 17 Sep 2026 18:51:11 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871ff3b186sm80478f8f.12.2026.09.17.18.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 18:51:10 -0700 (PDT)
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
Subject: [PATCH net] net: phylink: unwind the PHY binding when bringup fails late
Date: Fri, 18 Sep 2026 04:51:09 +0300
Message-ID: <20260918015109.2518797-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
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

Notes:
    Split out of the [PATCH net v7 0/2] pair (20260909204306.2374562-1-f@lex.la):
    2/2 is being reworked per review, and this patch has nothing left to wait
    for.
    
    Reviewed-by was given on v2 (net-next v2 1/2), lore message-id
    006ad9d6-b51b-46ed-8c5d-3649b70a4f62@lunn.ch.
    
    Code is unchanged from the v7 posting, patch-id 293623f600b8; only the
    hunk offsets moved with the rebase onto current net/main.

 drivers/net/phy/phylink.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a1458da8111b..1efb45ce8534 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2085,6 +2085,18 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
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
@@ -2199,6 +2211,12 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
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
 
@@ -2349,15 +2367,8 @@ void phylink_disconnect_phy(struct phylink *pl)
 
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

base-commit: 3b95a04eb5f95bf6a016a1bb9ff37d3eee48de63
-- 
2.53.0

