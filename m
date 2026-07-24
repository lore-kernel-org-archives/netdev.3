Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47C3CF218
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882069; cv=none; b=QFL/6h4ScX2A4INAR/U/ogErrteT+7XcWL8oJcV6Uez8HsdJVjeKlhg/OQBCkamsYDGxXV/PPc/qPqrom9WcHtLgFEsC8w1sVEvwddABSrzA5T+qtdv905moiakCBhRQIs484c5bo0MhyQhftwciZbf2SiZy+7Turjbiv3b/Cdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882069; c=relaxed/simple;
	bh=txPjE/Cf2Lgn5ZMVBhdqMUBO5oUMI0jfoL+IKOX98cs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PizsY5pBJQ8onoazpjZhypQCevPPCQW675phs4mRq+s7H3/3u93JC6cE+m+rRUFs9zn0eKfB7fRvHLjDL+T3dQJYLPh6S1+A/+mUtYmuQPwtxkrDBqF60xLRYjIWMybjnpHVxFi356ZkEfEBAO39JyFaZ++euJvzIdgz40Qe5/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=fPWArTzf; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="fPWArTzf"
Received: (wp-smtpd smtp.wp.pl 40711 invoked from network); 24 Jul 2026 10:34:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1784882051; bh=yX3WVtZnxYM1eCUN1sbpwedP3O2ECrKxgbE69vGv4D4=;
          h=From:To:Cc:Subject;
          b=fPWArTzf2ebUQUjXwHdwlUxkuLcezoz5dG0st8kHLE0khDna8zboF+mb19lN0KVb9
           5Uc0ObFVcaMQPhdjQrHKZvH4pIich2jFWajQOCNxtTF773YQ4QpB1+rLL7kIbHLodq
           0tkK8LrNWKoqJX1QG8/JDAs4kGgDZ7rr9lp2fl07hssyKKawQrx/nX6T7o4yxlEWyx
           C2/Vowi3Q2xlNbx4y4qBy4dlvZklaUagE+usx8aLspmXL/+CctgvRsZkd4CUH3Vqe0
           3bH9s9m6Wp1rr2UW02necAbkZgS77bynW5pZd6/kmybIEO96aciI0nGD+D6VfpDoRM
           kKscp98YPwPog==
Received: from 77-236-11-167.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.11.167])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <netdev@vger.kernel.org>; 24 Jul 2026 10:34:11 +0200
From: stf_xl@wp.pl
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: ax88796: initialize all fields of eeprom_93cx6 struct
Date: Fri, 24 Jul 2026 10:34:11 +0200
Message-Id: <20260724083411.8562-1-stf_xl@wp.pl>
X-Mailer: git-send-email 2.25.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: b47d6443534302c823d9dbeca5fb22fc
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [gTP0]                               

From: Stanislaw Gruszka <stf_xl@wp.pl>

Commit 7738a7ab9d12 ("misc: eeprom: eeprom_93cx6: Add quirk for extra
read clock cycle") added extra 'quirk' field to struct eeprom_93cx6,
which change how the data is read.

Some existing users of eeprom_93cx6, including ax88796 driver, allocate
the structure on the stack without initialization of all the fields.
As a result, the added quirk field has undefined value, what can
randomly cause reading wrong data from the EEPROM.

Fix by using designated initialization.

Fixes: 7738a7ab9d12 ("misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle")
Cc: stable@kernel.org # v6.13+
Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/ethernet/8390/ax88796.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/8390/ax88796.c b/drivers/net/ethernet/8390/ax88796.c
index e1695d0fbd8b..5ee1fbafdcfc 100644
--- a/drivers/net/ethernet/8390/ax88796.c
+++ b/drivers/net/ethernet/8390/ax88796.c
@@ -722,12 +722,12 @@ static int ax_init_dev(struct net_device *dev)
 #ifdef CONFIG_AX88796_93CX6
 	if (ax->plat->flags & AXFLG_HAS_93CX6) {
 		unsigned char mac_addr[ETH_ALEN];
-		struct eeprom_93cx6 eeprom;
-
-		eeprom.data = ei_local;
-		eeprom.register_read = ax_eeprom_register_read;
-		eeprom.register_write = ax_eeprom_register_write;
-		eeprom.width = PCI_EEPROM_WIDTH_93C56;
+		struct eeprom_93cx6 eeprom = {
+			.data = ei_local,
+			.register_read = ax_eeprom_register_read,
+			.register_write = ax_eeprom_register_write,
+			.width = PCI_EEPROM_WIDTH_93C56,
+		};
 
 		eeprom_93cx6_multiread(&eeprom, 0,
 				       (__le16 __force *)mac_addr,
-- 
2.50.1

