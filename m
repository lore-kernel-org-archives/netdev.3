Received: from way2.hanami.run (way2.hanami.run [78.46.240.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B77421FF29
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.240.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791114775; cv=none; b=jttAjJUMjbPvBD1jmgeDA2JU7O0+pm6Rizi//+ltZsCryRiivPN+ySlQzZ9EXx272ohZNs1S2lgV3o/N+L9E1ffm6b0YRjsEe3yxlIb3fd7O2agnm8Rx+CYUgwh6PJFZff665hDUnUfPgZ9xhisBSDRWRJMbX3JXGukJb87SdTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791114775; c=relaxed/simple;
	bh=oERsfS6WaeGM3ImSAneFtZjVg0LD+MPgOOoD9WW18PI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rzDu9o8zuRU6TqomNLHQxUh8aQqbzAjZP+2rc8mYdDK4VMWewNzgOnHF+7Y58mhujcPdtNjCCB8cji29TPxGZV8Js+wcIWM7ug6NH390setujJdE2p/7POqv2uHKihSILMx1JJsN7mC9CuQ+FHRdIA/1UNY6PjU6hHpdMRJLsD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yago.blog; spf=pass smtp.mailfrom=yago.blog; dkim=pass (2048-bit key) header.d=yago.blog header.i=@yago.blog header.b=VOy7YtPA; arc=none smtp.client-ip=78.46.240.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yago.blog
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yago.blog
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yago.blog header.i=@yago.blog header.b="VOy7YtPA"
Received: from way3.hanami.run (way3 [10.2.0.9])
	by way2.hanami.run (Postfix) with UTF8SMTPS id C51BC3D7CC
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 11:44:09 +0000 (UTC)
X-Mailwip-Queue: 1791114249
X-Hanami-Loop: smtp
X-Hanami-Session-Id: db13o20h17fnvs40r6n0
X-Mailwip: v1.2.1-20211209
X-Hanami-Loop: smtp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=hanami; d=yago.blog; t=1791114249; x=1791117849; l=5; h=
 content-type:subject:from:to;
 bh=ldanoqfkyGCIxbr/473PV+3haxLuMOT80C0ccrMs3Io=;
 b=VOy7YtPAcI/SI4xDCMpqwG2yZN3JaPE5fzAolwDZYnfz9Lu9K6V0XTQvSzO6W+gmQjUNGF
 PxRqsN4O3EAV4MYHwYMWQ2uTJUFQLWXwSqZIHf94KET3p8HL/WrIoDEWhem3GNfeIIAfRv
 GUXaDfdtAaTXu/Q/jyGOK43jLU4A0O85gexZCRzikFswcpc4wcqUm2SyT+HT2HZbe+Q5qU
 em2IWqDuqTQtNy3onWvpxUyqoayVHwtdqiMhv6h9gpuVRXFh4yfM8csmBZbYKDQjS7MPFf
 FJRtEA+AzdTLXs/VOGIdZQOJP+PTR1r71ngifGwFnp0dSXnvhE57uFUoGlxFNg==
Received: from 3ea5db18ba66 (79-116-239-145.digimobil.es. [79.116.239.145])
        by way3.hanami.run (Mailwip) with SMTP
        for <linux@armlinux.org.uk>; Sun,  4 Oct 2026 11:44:09 +0000 (UTC)
From: Yago <yago@yago.blog>
To: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Martino Dell'Ambrogio <tillo@tillo.ch>
Subject: [PATCH net] net: sfp: ignore soft LOS on FS XGS-SFP-ONT-MACI
Date: Sun,  4 Oct 2026 11:44:08 +0000
Message-ID: <20261004114408.754312-1-yago@yago.blog>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FS XGS-SFP-ONT-MACI (MaxLinear PRX126 XGS-PON ONU stick) got the
potron fixup, which masks the TX_FAULT and LOS hardware pins. That is
not enough for this module: it advertises soft RX_LOS
(SFP_ENHOPTS_SOFT_RX_LOS, enhanced options byte 0xf6) and its EEPROM is
bridged from the internal optics, so the diagnostics status byte carries
a real LOS bit. Because potron only clears the LOS bit in state_hw_mask
and does not set it in state_ignore_mask, sfp_soft_start_poll() adds
SFP_F_LOS to state_soft_mask and the LOS bit is polled from the
diagnostics page instead. The module asserts it whenever there is no PON
light.

The result is that without fibre the state machine stays in
SFP_S_WAIT_LOS and the host link never comes up, so the stick's
management interface (used to configure the ONU serial, MIB and VLANs
before the fibre is connected) is unreachable. Add a fixup that keeps
the potron behaviour and additionally ignores LOS, and use it for this
module.

Tested on a Banana Pi BPI-R4 (MT7988A). With the plain potron fixup and
no fibre, sfp-wan comes up and drops ~30 ms later and the stick is
unreachable. With this fixup and no fibre, the diagnostics LOS bit reads
asserted for the whole test while the host link stays up and the stick
stays reachable. With fibre connected, behaviour is unchanged and the
ONU registers with the OLT.

Fixes: 03fa69146f2f ("net: sfp: add quirks for OEM XGSPONST2001 and FS XGS-SFP-ONT-MACI")
Signed-off-by: Yago <yago@yago.blog>
---
 drivers/net/phy/sfp.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 96361584791b..345069b8a25b 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -472,6 +472,20 @@ static void sfp_fixup_potron(struct sfp *sfp)
 	sfp_fixup_ignore_hw(sfp, SFP_F_TX_FAULT | SFP_F_LOS);
 }
 
+static void sfp_fixup_potron_ignore_los(struct sfp *sfp)
+{
+	/*
+	 * In addition to the potron fixup, this module implements soft LOS
+	 * (enhanced options 0xf6), so masking the hardware pins is not enough:
+	 * the state machine would fall back to the LOS bit polled from the
+	 * diagnostics page, which the module asserts whenever there is no PON
+	 * light. Ignore LOS entirely so the host link, and thus the module's
+	 * management interface, stays up without fibre.
+	 */
+	sfp_fixup_potron(sfp);
+	sfp_fixup_ignore_los(sfp);
+}
+
 static void sfp_fixup_rollball_cc(struct sfp *sfp)
 {
 	sfp_fixup_rollball(sfp);
@@ -572,10 +586,11 @@ static const struct sfp_quirk sfp_quirks[] = {
 
 	// Fiberstore XGS-SFP-ONT-MACI is a MAC-mode XGS-PON ONT stick with
 	// ONT-class serial-passthrough TX_FAULT/LOS wiring and slow startup;
-	// mask both signals and extend T_START_UP via the potron fixup. The
+	// mask both signals and extend T_START_UP via the potron fixup. It
+	// also implements soft LOS, so ignore LOS entirely (see fixup). The
 	// PN is the product name (XGS-SFP-ONT-MAC-I) truncated at the 16-byte
 	// field width, so the field is fully occupied and matches exactly.
-	SFP_QUIRK_F("FS", "XGS-SFP-ONT-MACI", sfp_fixup_potron),
+	SFP_QUIRK_F("FS", "XGS-SFP-ONT-MACI", sfp_fixup_potron_ignore_los),
 
 	SFP_QUIRK_F("HALNy", "HL-GSFP", sfp_fixup_halny_gsfp),
 
-- 
2.53.0

