Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD2444D03B
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749872; cv=none; b=YW4ybYqBlpdnnnTfrJxQTvI/P8StvtwubnytbTU8/dxAFbxGTWaOEsvZHI9P5YJXF+MajGj8qcFPRaBVjP4JjgK7OoO7IKo1bN1xLyOeXZ5Dr21Xzgr0jlCUiIqI/QHxTYpV9IZJDguA0pfdr0VmvUIiWnkfYOYEtku17em/2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749872; c=relaxed/simple;
	bh=WqhBofm4eK3cIkaiJNeSHAk27qGtAfuckY2aVS1t/Tg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qI1U3RArGJlS4G7vpY4dWjrhWDHrJLrX3ICQohkinWh2d29E7HvC95mdATbi4FCrLByU1qlGQBets59GVtHB6LvY6XRsyUYL2v8rKAM8yrTFmD3GiWSHeJrp3zizkDvuszrZrd+S7jNHL4GtfdQfSs0YAvvHz7vZi60zcVJRfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fueaL2uS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fueaL2uS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D47C1F000E9;
	Mon, 29 Jun 2026 16:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782749871;
	bh=VGY/3EzI62yFaI09WF4nYhkRMXoCQ4SWEaDV21wSZvE=;
	h=From:Subject:Date:To:Cc;
	b=fueaL2uSLEFm8xGRg+6kNXydNXBZ3jt5Dkw/8CoZxSIIzgEAalHhudEgU14lJCe6N
	 +oyh7CK2gK8o2Re/1A93HVCvhyQZXyxFuJkfbhAxlvXzgDrMW0PWp4m4CoZ8nRjyfY
	 lWr5+mPfRxx8+P2vpHoOu/FgkagKOChxuBAEgobRuFOmeIMCNEJpcIXvpL7QBG6rKz
	 JcA5XX5L4yMWOc+LKhTGr+OuySXGiXRP1vY4R408DO9n5XKJw8+GzTerAzQ7fHJG4T
	 fUS2XesV3+wGKD9pTgyoOwp5BRR+plec1XuUH6foSVjc+uHKj6bc/7WbCce9YemvCx
	 Xj/eOVjwkoTxg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v6 0/2] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Date: Mon, 29 Jun 2026 18:17:28 +0200
Message-Id: <20260629-airoha-ethtool-priv_flags-v6-0-86bc600d31bc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QwWrEIBAG4FdZPNfiaKKmp75HKYtrxkQadFGRX
 Za8eyWnlEAoAwM/w3wD8yIZk8dMPi4vkrD67GNoQb5diJ1NmJD6sWXCGZesFTU+xdlQLHOJcaH
 35OvVLWbK9CaNUcy2phlp+/eEzj82+4sELDTgo5DvNpl9LjE9t6MVtvk//AoUaMfgxu3gcHDw+
 YMp4PIe07Sxle8pdUbxRqmOW2UMIGh+oMSe0meUaJRAjWK0winoD1S3o4CdUR1lVDLUg3VcOzQ
 Hqt9TcEb1jbIAIzLdaTn+/dW6rr+RN8Re+QEAAA==
X-Change-ID: 20260606-airoha-ethtool-priv_flags-b6aa70caa780
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Madhur Agrawal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3

Add the capability to configure GDM3/GDM4 as WAN/LAN on demand when QoS
offload is created or destroyed.
Make dev->qdma an RCU pointer so the TX path can safely dereference it
without holding RTNL.
Introduce airoha_qdma_start() and airoha_qdma_stop() helpers.

---
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
Lorenzo Bianconi (2):
      net: airoha: rename airoha_priv_flags to airoha_dev_flags
      net: airoha: defer GDM3/GDM4 WAN mode and GDM2 loopback to QoS offload

 drivers/net/ethernet/airoha/airoha_eth.c  | 231 ++++++++++++++++++++++++++----
 drivers/net/ethernet/airoha/airoha_eth.h  |  19 ++-
 drivers/net/ethernet/airoha/airoha_ppe.c  |   9 +-
 drivers/net/ethernet/airoha/airoha_regs.h |   1 +
 4 files changed, 223 insertions(+), 37 deletions(-)
---
base-commit: 805185b7c7a1069e407b6f7b3bc98e44d415f484
change-id: 20260606-airoha-ethtool-priv_flags-b6aa70caa780

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

