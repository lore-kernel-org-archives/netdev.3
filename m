Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E613CAA57
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370381; cv=none; b=IjhM6YpQku2zuu8/SMla3AqE05b95kC/WEE8hi6oHk9kAzbFx6Nm0d0bjPLD8YaUIrytK9KRRWMvse0H5sqA5OKZ784N0PKAs4yKCm9ZvevBgl06YTnjEQUYYXOZHcxENouB2PwuYwOxsK8lZHaLE5kzcsgs+TVYPkD6DUfWqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370381; c=relaxed/simple;
	bh=LNR9irp27/9ZIGeSfR/hSo4oAQFZGjwDcuFbX1E0I2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FvHKC04cFugxxlhv/gK1OsT6P4rMC2uT7n/670MYdsnAAbmar21czqNvctaREiO3yRa0jZ9z2QzGTgZLDBx7bRVRBxN8O1yIAE7/GH7vho0WWQ2lGkQji3ZvomfsQm60+3fybYK3aZQ313CnUvf3B7iX+YOgdTZeYEWoCGI1xR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ASZFePPV; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ASZFePPV"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260810131918e6d20506dc000207b2
        for <netdev@vger.kernel.org>;
        Mon, 10 Aug 2026 15:19:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=1K5nMdBJ3F0LWFyBOgVo9wQEt2vYV/K/0BEbypgk2Ok=;
 b=ASZFePPVed4fX53qu+qLG0Qkkyld7u75e9Sq5Nw9EsL5g0+b5XKPA/u4Mh1HLbbztmNwtk
 3VfmwbH+NMGhrGeOSDHeP9BQPPJRD0QoSGYErRhvfsHqSpIQZj3c50sWyAVgvLkCOVSWwutr
 j70BZA4It/i7ea7A8+Q4gK6p5KAZq/mc8P/GSbQkVTVLWH3GyoJTk9SaFhiIUW3BKxZ8PTw3
 QtYdwV6+lemXt0lVV1t7Yb+EaddtdF23Sqp3twbHT/PyxQ0gGNuUmG/eAC0S1Ob6hy1yQDls
 01AnM1JW3qbej+dVYoSgxxSRu9cRx0cOv0zjt+v/L7FyUYWMDr5BNhzA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 10 Aug 2026 15:19:17 +0200
Subject: [PATCH net-next v2] net: stmmac: intel: Add missing
 pci_free_irq_vectors() calls
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-flo-net-stmmac-default-affinity-core-v2-1-d2105780b8ca@siemens.com>
X-B4-Tracking: v=1; b=H4sIANTPeWoC/42OQQ6CMBBFr2Jm7RhaS42uvIdhUcpUJoHWtIVAC
 He3cgKX///kvb9BosiU4HHaINLMiYMvQZ5PYHvj34TclQyykroS4o5uCOgpY8rjaCx25Mw0ZDT
 Osee8og2R0NbKGVU70tcOCqo1ibCNxtu+wPw0DKX8RHK8HO4X/JCelgxNWXpOOcT1ODWLYz/8U
 lT/+WeBFSq6aS2kUorEMzGN5NPFhhGafd+/Ep+10PkAAAA=
X-Change-ID: 20260119-flo-net-stmmac-default-affinity-core-c54fa45fe63d
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The IRQ vectors allocated in stmmac_config_multi_msi() or
stmmac_config_single_msi() where never explicitly cleaned up. As
pcim_enable_device() is used, all sorts of other functions are switched
to managed mode. The missing cleanup here isn't actually missing, it's
buried in the depths of PCI code.

But: There are some ongoing activities to remove that cleanup magic.
See the linked discussions below.

This patch prepares the dwmac-intel code for the removal.

Link: https://lore.kernel.org/netdev/27fec7d0ed633218a7787be3edce63c3038c63e2.camel@mailbox.org/
Link: https://lore.kernel.org/netdev/7e024db2557a4d5822a0dd409ae678d10d815d9c.camel@mailbox.org/
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Hi all,

This are some fallouts of a quick stmmac "review", while trying to
understand some issues that we have around the IRQ spreading implemented
by stmmac.

The root cause turned out to be something more generic, so not limited
to stmmac. I will try to prepare a discussion starting point later. This
is more a RT specific problem, so I have to bring in more people.
---
Changes in v2:
- Patch 1: Rework patch description as suggested by Russell
- Patch 2: Drop, will be handled separately
- Link to v1: https://lore.kernel.org/r/20260210-flo-net-stmmac-default-affinity-core-v1-0-4e76612444e1@siemens.com
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 4d207f41a43b3eac64b6ae269765590107f1b30b..f5f9fa67ecd77f6b8a9b5ad5b39f338c4ba49a5f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -1348,6 +1348,7 @@ static int intel_eth_pci_probe(struct pci_dev *pdev,
 err_alloc_irq:
 	clk_disable_unprepare(plat->stmmac_clk);
 	clk_unregister_fixed_rate(plat->stmmac_clk);
+	pci_free_irq_vectors(pdev);
 	return ret;
 }
 
@@ -1367,6 +1368,7 @@ static void intel_eth_pci_remove(struct pci_dev *pdev)
 
 	clk_disable_unprepare(priv->plat->stmmac_clk);
 	clk_unregister_fixed_rate(priv->plat->stmmac_clk);
+	pci_free_irq_vectors(pdev);
 }
 
 #define PCI_DEVICE_ID_INTEL_QUARK		0x0937

---
base-commit: aa2e13ae8d3cbe2c15ef4f7e971b2de0832794aa
change-id: 20260119-flo-net-stmmac-default-affinity-core-c54fa45fe63d

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

