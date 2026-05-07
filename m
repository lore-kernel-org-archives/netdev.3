Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB63FE361
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159099; cv=none; b=AuNFvCuCeMEM5ccjav0jv8i4OJOBQxWCdsKdr9FgMZvO0e5m/oI5PZIXsB+8L04d3YtKPO/2u0FtpRBPuGnmqcVzYnUYUTCb6zTowiCpbJmdzCS6vgaqHYLNTRgmxBVOwpgMOw4MnW3DdXnzz414ovaFKMktSDl4ZwCh7qW71qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159099; c=relaxed/simple;
	bh=12g3QsZLhXc7VKjxdjXJI547ZYjfnKDMrMTDgWBdsUU=;
	h=Message-Id:From:Date:Subject:To:Cc; b=ZLxKpxw1kk2lMMRgJkbQ2MOx11OUzpSfobfG0CsLHjxOjdDfjdyegxK9EnxiTDuixUN00ZRYO7qLP8NzVf/S5a/tLqbA4A4P1T05fEOuQQcXLysxlP37CmhvMYXizzIxJzEGXuO9dgqr1ahP85FyE2A5+ImiS1eD9PK4CKTNYoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 4C59FC1E;
	Thu, 07 May 2026 15:04:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1B8E06029989; Thu,  7 May 2026 15:04:53 +0200 (CEST)
Message-Id: <39de1b025928d9a457976010b2324e7e99baa92a.1778158755.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 7 May 2026 15:04:59 +0200
Subject: [PATCH net-next] bnxt_en: Drop pci_save_state() after pci_restore_state()
To: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Cc: netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Commit 383d89699c50 ("treewide: Drop pci_save_state() after
pci_restore_state()") sought to purge all superfluous invocations of
pci_save_state() from the tree.

Unfortunately the commit missed one invocation in the Broadcom
NetXtreme-C/E driver.  Drop it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8c55874..10196f9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17386,7 +17386,6 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 				pci_write_config_dword(bp->pdev, off, 0);
 		}
 		pci_restore_state(pdev);
-		pci_save_state(pdev);
 
 		bnxt_inv_fw_health_reg(bp);
 		bnxt_try_map_fw_health_reg(bp);
-- 
2.51.0

