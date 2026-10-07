Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BC83815F3;
	Wed,  7 Oct 2026 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791385420; cv=none; b=jzqFZXRD797U6FlT4T7CYtrh+/L5vtrXugSCopQinTw7RTQwhBhQYbUw+V5lQ1QTL82w4Zc03abL9GlJcR6w4vFOSeWeTZOZVUTHs5BQAezhaJs3GbKr8dZfHhhlgIyhisFgcrGYHXAj/AvPQ4Gjo16ziwqiWoutgP/6JG0phe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791385420; c=relaxed/simple;
	bh=bRxyAyeMyuT8X1aAIHRubCtQCl/UpGFQpunpCnzKtNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=mkQecn7BaGe/0zoCSfj2EJ/yiwkcj/qwR12KNymWGnBSBpfVL74WsOL23bwZjm4C5pvc+EmfM+v/vh7JZ3SRk/K6W2fiWin4MderZtcbRxkcdXwhrt1RaQR4gETajmASBABixy7+xgjduokiVK+djiPUB7UzfuumIvJJ5xXpFP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=V3+qzj3I; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="V3+qzj3I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791385413; x=1822921413;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=bRxyAyeMyuT8X1aAIHRubCtQCl/UpGFQpunpCnzKtNs=;
  b=V3+qzj3IfCtl1x/BmNx52rZEG86asodQsl3Ta5VpuHuCwaSBMFjjCRGt
   xuI3pxzPuczcBdAq4AriQ5WoCjvH+dq8YpXydq3WcxJl6FtvIEfYVKUpv
   KXrEpMR+WNVYwhTLtEr0JFA9XotboxkZh5/ksG1BcL9EVDHTmT1Na6Twk
   Mo3Z4bfpqyiNXAurynrnoRkH8ikGCeow3SyJFhXtMv0DOd6s6Xshs7h/5
   sieLNnN/KLWfm2SytMPXLdZ62ZOoV4ZhNhlmoncMXZmXe1LM79iN9hzch
   usTbkI5bRwoDpu8jDNz1XdoRnPAi4wE/SIgoDlExGn1alAE7DoupV2zBF
   Q==;
X-CSE-ConnectionGUID: lFivHuwqSOyVpuk07g+c1A==
X-CSE-MsgGUID: s4qJiHJATZuOqn//qTJG4g==
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="296120675"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2026 08:03:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 7 Oct 2026 08:03:32 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 7 Oct 2026 08:03:30 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 7 Oct 2026 17:03:15 +0200
Subject: [PATCH net] net: sparx5: free the matchall entry on destroy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261007-sparx5-matchall-kfree-net-v1-1-c8918685b337@microchip.com>
X-B4-Tracking: v=1; b=H4sIADNfxmoC/x2MSwqEQAwFryJZG2h1/OBVxEV00hrUVtIignj3C
 bMsXr16ILIKR2iTB5QvibIHgyxNYJwpTIzyNYbc5VXmXI3xIL1L3Oi0fV1x8cqMgU8kT8M4FL4
 qmw/Y/1D2cv/bHZgA/fv+AI1UnnFwAAAA
X-Change-ID: 20261007-sparx5-matchall-kfree-net-afabcb3f6584
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Kees Cook <kees@kernel.org>
X-Mailer: b4 0.14.3

sparx5_tc_matchall_replace() allocates a struct sparx5_mall_entry for
every offloaded matchall filter and adds it to sparx5->mall_entries.
sparx5_tc_matchall_destroy() removes the entry from the list, but never
frees it, so the entry of every deleted mirror and goto matchall filter
is leaked.

Free the entry after unlinking it.

The leak was discovered by an AI code review agent, and reproduced with
kmemleak on a lan969x EV board (EV23X71A) by repeatedly adding and
deleting matchall mirror and goto filters. With the fix, kmemleak no
longer reports the leak.

Fixes: 1ede4acf045c ("net: sparx5: add bookkeeping code for matchall rules")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
index 702257979462..146d7f28e8f3 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
@@ -160,6 +160,7 @@ static int sparx5_tc_matchall_destroy(struct net_device *ndev,
 	}
 
 	list_del(&entry->list);
+	kfree(entry);
 
 	return err;
 }

---
base-commit: 23609bce9e1de525d1d0e73fc68c6e7971d0b49e
change-id: 20261007-sparx5-matchall-kfree-net-afabcb3f6584

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

