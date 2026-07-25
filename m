Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541BF331A7B
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785012127; cv=none; b=cSRBuGWCkvbl7nsIR9mQSTgX5VpDvr/q/yHxIq0BsNeMbGjMYKajK9M8RQ9nLvpdc0bdLC9ZXOyttNlut71tEjMOMcUxFbiyuqEzgO2fJ91rch4g+aU8NJqN8oL4D2vbgz4m9dJ2cwx6S3cJ5GmS+fmNLN2ppH/oHxPqeGdrLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785012127; c=relaxed/simple;
	bh=qDufYT4rR+yUM4fJZ+BL03XDmGXu8BsQNlGAsEOFyKU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J/YGULO41sh1lNechgfBJIXojsYb9VyB9O6xpzna73h2LInmkaiSUAPYrxfu4hz045AGyfNNrk1X+SX4vjqHGSGXkchsLXoRdhAg6mJn+WuXVoQUW632S2pIrKBY5mBQNDyizg1R0W5m6PKVXZoMUs2je/Q2HZDXf3KYlVblDN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHbGl3er; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHbGl3er"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685211F000E9;
	Sat, 25 Jul 2026 20:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785012125;
	bh=8mADYrqjFd+vYjGmvCJ/2AAsFMgwtCupiq81UWlzduQ=;
	h=From:Subject:Date:To:Cc;
	b=eHbGl3erWwK9qBlKucU2mVX8RqLkfNoj9mxESn1tSNQ1QjYod8EZEpneCuFFyrd1B
	 JTOSw+wOgUcBu8Lt13AsJXrgIoo54IN57TcQgsxgBA8r137+vdy9Pwv8XMG1URwLHU
	 LYsKDtI09O8btZ4EZu0wTPLBJ8eezzo6oovqtbhWCAmi/vB3dLB5DYqe+LfYEepWWH
	 +/K+89KdQObq1Jw9R2o1KFuUMPNYhiLS7fHcnMZn9ydvMo/s/oLE90eQSWB6saToP9
	 e3o4NccrXguwkAIxnC5JhfQnRDrn7/keQe7x8a19Gaw3E6rUI6vmOWJjqftFI5/uVH
	 tDpihmstgXGgw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v12 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Date: Sat, 25 Jul 2026 22:41:39 +0200
Message-Id: <20260725-airoha-ethtool-priv_flags-v12-0-5136a30b2157@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43S22rEIBAG4FdZcl3LjGd71fcopXiYbEKXZElC2
 LLsu9fmphZBiiDo4OePzr1baRlp7V5O926hfVzHecoL5E+nLg5+OhMbU97oOHANeTA/LvPgGW3
 DNs8Xdl3G/aO/+PPKgvbeQMyThS6fvy7Uj7cDf+sm2thEt617z5VhXLd5+Tpu3fGo/8PfkSGTg
 IFH15Pr8fWTlokuz/NyPtidl5RpUTxTRvJovEdCyytKlJRtUSJTgiyJFEVvUFWULCiEFiUZMA1
 kXey57clXlCopbFEqUxExEVhpdarfShcUdy1KZ8rqEDVAEhhiRZlfykAzlclUkKhESFJKbivKl
 pRoUTZTgCp45aN1RBXlCoo3U7lMuYgq2WDQK11RCKXFmz2aU7HEleZRpeRk3VmIJSabGP40RP4
 +8gLAS/iDPR6PbxUaaeXAAwAA
X-Change-ID: 20260606-airoha-ethtool-priv_flags-b6aa70caa780
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Madhur Agarwal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3

Add the capability to configure GDM3/GDM4 as WAN/LAN on demand when QoS
offload is created or destroyed.
Make dev->qdma an RCU pointer so the TX path can safely dereference it
without holding RTNL.
Introduce airoha_qdma_start() and airoha_qdma_stop() helpers.

---
Changes in v12:
- Introduce txq_lock array in order to serialize the access to
  netdev_tx_completed_queue() in airoha_qdma_tx_napi_poll().
- Set AIROHA_DEV_F_TX_QOS flags in airoha_tc_setup_qdisc_htb() and not
  in airoha_enable_qos_for_gdm34().
- Link to v11: https://lore.kernel.org/r/20260724-airoha-ethtool-priv_flags-v11-0-686dea300a40@kernel.org

Changes in v11:
- Fix possible bql races moving the net_device between different QDMA.
- Use atomic APIs for airoha_gdm_flags.
- Link to v10: https://lore.kernel.org/r/20260722-airoha-ethtool-priv_flags-v10-0-d2562c5dd942@kernel.org

Changes in v10:
- Fix a theoretical race condition between tx completion NAPIs moving the
  net_device between different QDMA.
- Rebase on top of next-next main branch
- Link to v9: https://lore.kernel.org/r/20260721-airoha-ethtool-priv_flags-v9-0-9c15d8b71a56@kernel.org

Changes in v9:
- Rebase on top of next-next main branch
- Link to v8: https://lore.kernel.org/r/20260703-airoha-ethtool-priv_flags-v8-0-015ba5ac89ee@kernel.org

Changes in v8:
- Rebase on top of next-next to fix conflicts.
- Link to v7: https://lore.kernel.org/r/20260701-airoha-ethtool-priv_flags-v7-0-b4153bd44428@kernel.org

Changes in v7:
- Fix ETS stats accounting in patch 2/3
- Reset ETS stats accounting in airoha_dev_set_qdma().
- Link to v6: https://lore.kernel.org/r/20260629-airoha-ethtool-priv_flags-v6-0-86bc600d31bc@kernel.org

Changes in v6:
- Rebase on top of next-next
- Add patch 1/3: "rename airoha_priv_flags to airoha_dev_flags"
- Drop patch 2/3: "refactor QDMA start/stop into reusable helpers"
- Link to v5: https://lore.kernel.org/r/20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org

Changes in v5:
- Add patch 1/3: use int instead of atomic_t for qdma users counter
- Protect dev->flags with flow_offload_mutex mutex.
- Introduce AIROHA_PRIV_F_QOS in order to handle better WAN/LAN
  switching.
- Link to v4: https://lore.kernel.org/r/20260610-airoha-ethtool-priv_flags-v4-0-60e89cf28fea@kernel.org

Changes in v4:
- Move back QDMA TX/RX DMA enable to airoha_dev_open()/airoha_dev_stop().
- Configure GDM3/4 as WAN if GDM2 is not available in ndo_init()
  callback.
- Protect qdma pointer in airoha_gdm_dev struct using RCU.
- Rely on rtnl_dereference() to access qdma pointer in the control path.
- Add airoha_qdma_start() and airoha_qdma_stop() utility routines in
  patch 1/2
- Link to v3: https://lore.kernel.org/r/20260608-airoha-ethtool-priv_flags-v3-1-3e8e3dc3f715@kernel.org

Changes in v3:
- Do not introduce ethtool private flags support to configure LAN/WAN
  for GDM3/4 and rely on tc qdisc offload for it instead.
- Set GDM3/4 ports as LAN by default.
- Move QDMA TX/RX DMA enable from airoha_dev_open() to airoha_probe()
  and the corresponding disable from airoha_dev_stop() to airoha_qdma_cleanup().
- Link to v2: https://lore.kernel.org/r/20260607-airoha-ethtool-priv_flags-v2-1-742c7aa1e182@kernel.org

Changes in v2:
- Rework airoha_dev_set_wan_flag routine
- Enable GDM_STRIP_CRC_MASK in airoha_disable_gdm2_loopback()
- Do not always reset REG_SRC_PORT_FC_MAP6 in
  airoha_disable_gdm2_loopback() but use the same condition used in
  airoha_enable_gdm2_loopback().
- Link to v1: https://lore.kernel.org/r/20260606-airoha-ethtool-priv_flags-v1-1-401b2c9fe9f1@kernel.org

---
Lorenzo Bianconi (3):
      net: airoha: rename airoha_priv_flags to airoha_dev_flags
      net: airoha: fix ETS QoS stats counter underflow and cross-channel corruption
      net: airoha: defer GDM3/GDM4 WAN mode and GDM2 loopback to QoS offload

 drivers/net/ethernet/airoha/airoha_eth.c  | 265 ++++++++++++++++++++++++++----
 drivers/net/ethernet/airoha/airoha_eth.h  |  33 +++-
 drivers/net/ethernet/airoha/airoha_ppe.c  |   9 +-
 drivers/net/ethernet/airoha/airoha_regs.h |   1 +
 4 files changed, 263 insertions(+), 45 deletions(-)
---
base-commit: 04026c998c24ac47eb76886b9790c5710b603eb4
change-id: 20260606-airoha-ethtool-priv_flags-b6aa70caa780

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

