Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFD23947AE;
	Wed, 16 Sep 2026 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572373; cv=none; b=kbsDThdVlTN+UZG6bVeJ3PLT7fyTi3WdJQ7lu+hPjnuWUGJmeZ+g0EVKHot8vTngNZM6Eo5jSNq5gAwx9c374RY6QF524MVUOw/FHOYYIBM6YwcQBwMKcDwqHo3dpCHjLYeYx9e5U299zB8Ez2zOIYxgCQif0pD/ukHLYTntR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572373; c=relaxed/simple;
	bh=1T8RPT9pP2V6OlcWkw9Asafth5FfY14l/EEYZ798V/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQrZmhfRIB3YSLIOXSx2F6+oVDQBFOFRAXapv4I/rbCChFuIWCPX299jNwBe1o/ghqnlisWzf1/4gv81VDL8SkqNOG56xNh6cXc3cSBPn8HnNReag/Asxiwyfs5Dfl0hNwsy4CTK33raDQf3DLdnms6l0Daj2lq/wko3n7A/xWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=cRByXnkh; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="cRByXnkh"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [186.210.28.117])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id E7D4A1203BC;
	Wed, 16 Sep 2026 12:25:30 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1789572331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaFoqU+EogLCr42KfhIbunb00wPla6Jsw4l3DdvaJSI=;
	b=cRByXnkhUJO88fshxXZYMMyfE8TE7Ljz4pPg+U+fylx4o91I6nTTqdozs8VdfvbIaXhpb0
	GV6L+LJv7BgGbj+NQipvJ5eSPcuCodWgHSKdEhW1ywrq2d9zcdg2KZc56KlQzEB7/5xXdK
	I7EPz1bqYEpCX9URdUrck0bw01J1qgNg5lPD8/LqHfPeo4d/C+oVL9TQYNETtA0eSrU5Gd
	ccfPFzvLBJqz8rq4u3y64Z6n1RBuf4/+XEV6K6yvNdahhwUP163juKlcvXpKOfbFSp1RvV
	iEQJS3ufo0rNxhSGGJLgsPf2SY/m8+/4qrWfqaKCdJ5r2rKUOppCJpsrpGK5HA==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH net-next 3/3] r8169: release firmware on application failure
Date: Wed, 16 Sep 2026 12:24:44 -0300
Message-ID: <20260916152444.167196-4-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
References: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After an rtl_fw_write_firmware() failure, r8169_apply_firmware() does
not release the firmware. A TODO notes that it should be released
in this case.

Release the firmware on failure and remove the TODO.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3c37c5a6c..c54423cd2 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2596,12 +2596,14 @@ void r8169_apply_firmware(struct rtl8169_private *tp)
 {
 	int val;
 
-	/* TODO: release firmware if rtl_fw_write_firmware signals failure. */
 	if (tp->rtl_fw) {
-		rtl_fw_write_firmware(tp, tp->rtl_fw);
+		int rc = rtl_fw_write_firmware(tp, tp->rtl_fw);
 		/* At least one firmware doesn't reset tp->ocp_base. */
 		tp->ocp_base = OCP_STD_PHY_BASE;
 
+		if (rc < 0)
+			rtl_release_firmware(tp);
+
 		/* PHY soft reset may still be in progress */
 		if (tp->phydev)
 			phy_read_poll_timeout(tp->phydev, MII_BMCR, val,
-- 
2.43.0

