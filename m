Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8AA3C5544;
	Mon, 11 May 2026 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496591; cv=none; b=MD9H7Xb74eFR6Mp1eoDpbVv39edgXZAfBPPf8eihvB+AjY0qG0nlT8XWmz9En9zl/ELTAHUZQJc2iW98eohtyC9CBB2G+k3g6omgABL6MgrYQTjLo8CgEyALyr649zU0MEvXv2gRYbacKJcIBtVoRSZcuX0AeChmmVoaViPdlZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496591; c=relaxed/simple;
	bh=+WnaQeg2j2puQqd3ullH+3O7LQQhcl2YZbpdexf4wAM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HhACC5EarEf7jWssd3bVmw0gD5p121tr3PJfRwWAbfqqFpq4Ci665ok8K+8rmB571CGv5Xh+MJZGqKSU2DL34BexAbz/MULFCjrJh7GpPNu8xxg4qvG+COTAfKE6laaYgYiF4VlSp8mhxXXKOE1EftO/vRlveEqOr06eS2styZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgJ2PYlL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgJ2PYlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E95C2BCC9;
	Mon, 11 May 2026 10:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778496591;
	bh=+WnaQeg2j2puQqd3ullH+3O7LQQhcl2YZbpdexf4wAM=;
	h=From:Subject:Date:To:Cc:From;
	b=IgJ2PYlLmrhJjJKJBWkk/9bbnPrH7smbkHblihbRZZJlF4vZp8T2aV2JfAuVF2BC3
	 ZNwi4+bfZvQ9NvfSGq1hsZXtjGK5r1ag5fKP5uFFgEyyEHODUJeLbtAUcr+qh4w0ZM
	 qvyv3V+HahYikgY3RfCL2CiGhZ0lVEWvkI8e5d3Oam8DpreCMsbyW8iq4JMdR9XKCQ
	 UV4mMucVeaF54iYJuUf0d299IaCD0s6a7yCHd/YFBUFRwbMZWrtxH5uGchUSn1WxRG
	 dXA796TaeXBjhc+WIBAGTa7Hkbg3X5+jrUKWi2qIX9lZn6I/Cuwl3Dt+3gaSe+Beez
	 yMgh9hXrX59fg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v6 00/12] net: airoha: Support multiple
 net_devices connected to the same GDM port
Date: Mon, 11 May 2026 12:49:26 +0200
Message-Id: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33Qy2rDMBAF0F8JWkdl9HScVf+jdKHHKBZN5CKpJ
 iX436uYQlKMu7xc5gzcGymYIxZy3N1IximWOKYW9H5H3GDSCWn0LRMOXIPgkpqYx8FQrAO9fJ1
 rpA3wWGiw0iqlETulSbv+zBjidZHfSMJKE14reW/NEEsd8/fycmJL/6v3m/rEKFCAoLh3QoMzr
 x+YE55fxnxa0Ik/IAlsG+INMk7yzqC0iHYFiWdIb0PiDlmNRvZe9SGsIPmAFHTbkLxDQTNhNTM
 IfAWpZ+ifjVSDDqBQHNA7bv5uNM/zD2cZMTrtAQAA
X-Change-ID: 20260324-airoha-eth-multi-serdes-fb4b556ee756
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>, 
 Madhur Agrawal <madhur.agrawal@airoha.com>, 
 Brown Huang <Brown.huang@airoha.com>
X-Mailer: b4 0.14.3

EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw arbiter that
manages the traffic in a TDM manner. As a result multiple net_devices can
connect to the same GDM{3,4} port and there is a theoretical "1:n"
relation between GDM ports and net_devices.

           ┌─────────────────────────────────┐
           │                                 │    ┌──────┐
           │                         P1 GDM1 ├────►MT7530│
           │                                 │    └──────┘
           │                                 │      ETH0 (DSA conduit)
           │                                 │
           │              PSE/FE             │
           │                                 │
           │                                 │
           │                                 │    ┌─────┐
           │                         P0 CDM1 ├────►QDMA0│
           │  P4                     P9 GDM4 │    └─────┘
           └──┬─────────────────────────┬────┘
              │                         │
           ┌──▼──┐                 ┌────▼────┐
           │ PPE │                 │   ARB   │
           └─────┘                 └─┬─────┬─┘
                                     │     │
                                  ┌──▼──┐┌─▼───┐
                                  │ ETH ││ USB │
                                  └─────┘└─────┘
                                   ETH1   ETH2

This series introduces support for multiple net_devices connected to the
same Frame Engine (FE) GDM port (GDM3 or GDM4) via an external hw
arbiter. Please note GDM1 or GDM2 does not support the connection with
the external arbiter.

---
Changes in v6:
- Reconfigure REG_GDM_LEN_CFG() whit max 'running' MTU in
  airoha_dev_stop().
- Fix port staring MIB counters in airoha_update_hw_stats().
- Fix regression in TC_HTB_NODE_MODIFY command.
- Fix length check in airoha_qdma_rx_process().
- Fix dts schema.
- Link to v5: https://lore.kernel.org/r/20260509-airoha-eth-multi-serdes-v5-0-805e38edc2aa@kernel.org

Changes in v5:
- Move qos_sq_bmap bitmap in airoha_gdm_dev struct.
- Unregister netdevice before running of_node_put().
- Move stat MIB counters in airoha_gdm_dev struct.
- Fix airoha_ppe_init_upd_mem() mac address configuration.
- Do not return -EBUSY if we try to decrease configured MTU of a shared
  GDM port, just skip hw configuration.
- use int instead of atomic_t for GDM port users.
- Add patch "net: airoha: Reserve RX headroom to avoid skb reallocation"
- Fix typos.
- Link to v4: https://lore.kernel.org/r/20260507-airoha-eth-multi-serdes-v4-0-af613b61ae02@kernel.org

Changes in v4:
- Make ethernet-port property available just for GDM3 and GDM4 in DTS
  specification
- Move cpu_tx_packets, fwd_tx_packets qos_sq_bmap fields in airoha_qdma
  struct
- Fix of_node leak removing the net_device in airoha_remove() or
  airoha_probe() error path
- Fix nbq backward compatibility
- Link to v3: https://lore.kernel.org/r/20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org

Changes in v3:
- Fix MTU and VIP configuration when the GDM port is shared between
  multiple net_devices.
- Add sanity check for nbq parameter.
- Add missing of_node_get() for net_device np node.
- Check if GDM port is shared before decresing device MTU.
- Move port forward configuration in airoha_dev_stop() before
  configuring DMA tx/rx engine.
- Introduce PRIV_FLAG_WAN parameter.
- Link to v2: https://lore.kernel.org/r/20260401-airoha-eth-multi-serdes-v2-0-ac427ae4beeb@kernel.org

Changes in v2:
- Rename multiplexer in arbiter in the commit logs.
- Rebase on top of net-next main branch.
- Add missing PPE cpu port configuration for GDM2 when loopback is
  enabled.
- Link to v1: https://lore.kernel.org/r/20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org

---
Christian Marangi (1):
      net: airoha: Better handle MIB for GDM with multiple port attached

Lorenzo Bianconi (11):
      dt-bindings: net: airoha: Add EN7581 ethernet-ports properties
      net: airoha: Reserve RX headroom to avoid skb reallocation
      net: airoha: Introduce airoha_gdm_dev struct
      net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct
      net: airoha: Rely on airoha_gdm_dev pointer in airhoa_is_lan_gdm_port()
      net: airoha: Move qos_sq_bmap in airoha_gdm_dev struct
      net: airoha: Move {cpu,fwd}_tx_packets in airoha_gdm_dev struct
      net: airoha: Support multiple net_devices for a single FE GDM port
      net: airoha: Do not stop GDM port if it is shared
      net: airoha: Introduce WAN device flag
      net: airoha: Support multiple LAN/WAN interfaces for hw MAC address configuration

 .../devicetree/bindings/net/airoha,en7581-eth.yaml |   64 +-
 drivers/net/ethernet/airoha/airoha_eth.c           | 1013 +++++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h           |   54 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |   43 +-
 4 files changed, 809 insertions(+), 365 deletions(-)
---
base-commit: 63751099502d10f0aa6bb35273e56c5800cc4e3a
change-id: 20260324-airoha-eth-multi-serdes-fb4b556ee756

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

