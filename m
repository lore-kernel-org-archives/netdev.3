Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7423F44D3;
	Wed,  3 Jun 2026 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780466462; cv=none; b=f0DjusZyMto+mJFsI2qbNdaUoXeQV5AdrWqneig8DWRjP08cgbBdtJOYjTE5JAbNIklhaEZFOzWqN+Z5Hzl2WhO3BM4IvYKXWWI+PZ4DZb3n6UsyZmmupChnM6rq8fOeDKQds4ONxmmdFXslHslZqLy0IPFdsIsPNDITXVh5WMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780466462; c=relaxed/simple;
	bh=pp9HcY2xS66toHNxbB7sr3vXGCzSt2XLjnl7od/onoQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g812IOS9Rdi+Ihoi+V4yG5lx86J7JgIdDTzQ1FHAFRz+pVU0lYZ9T0J2oJqqMzkzDb3ObwisYtKSsCcJOAA1UdMjw9Jx71oKd6ePuC7zwy3T9L3A61WNOWh/jtfAGNCkWe5+Q+7Xs5x+ycnRnGyuunqh1QWkdf9pNX3OLqXPT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4BWVMxy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4BWVMxy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD51E1F00893;
	Wed,  3 Jun 2026 06:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780466461;
	bh=iIDbnu+hln/EA7ynrMKJhtLipUKdalEJHgUvmnSOonw=;
	h=From:Subject:Date:To:Cc;
	b=D4BWVMxyAgWppCpi4bvzqMJ4AIDUZxqBAU22i0RzX1a45PJPKzI5Ds+Ov9YJ4Rjwf
	 dTwpB4gOMSH28nKGKfZqLZ7YoXlf6Bz7cGFVUqxaJcuK6NaC1qwSaZThoy7EWt9tSn
	 D1srZz0Z+JtH+Ar/9iFyPUG217PLpTmPZa6IKSZpCookmaR6sXqrAFkCjnzrXoVTl4
	 fhAASpCyoqKqfwfymk+5Pv/IfCkBCPybMSwBh3CdwS8WDY6QYQwrUlWtrJN7UasygI
	 4dcLiOtPguoM/MFFziTZ6aAmQrkUeOflkdJYH1iwdlKPXevF5Tc3vD92+yP1FUUMQE
	 WLccJ2II+F3lA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v9 0/6] net: airoha: Support multiple net_devices
 connected to the same GDM port
Date: Wed, 03 Jun 2026 08:00:14 +0200
Message-Id: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33SS2rEMAwG4KsMXtdF8TPuqvcoXfghT0ynSXHSM
 GXI3esJhUkxyVIIfUI/upERc8KRvJxuJOOcxjT0pTBPJ+I725+RplBqwoAp4ExQm/LQWYpTRz+
 /L1OiBQg40uiEk1IhaqlImf7KGNN1ld9IjxPt8TqR99Lp0jgN+WddOTdr/083u/rcUKAAUbLgu
 QJvXz8w93h5HvJ5RWf2gAQ0+xArkPWCaYvCIboK4ltI7UP8DjmFVpggTYwVJB6QBL0PiTsUVcO
 daiwCqyC5hQ4ykgVqQSJvMXhm64zUBmoOMlIF8q0xQjEvopYVpLfQQUa6QMYggOEcONantVvo4
 LS2QMoFDVi+JET1D1qW5RcsUjGkyAIAAA==
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
 Madhur Agrawal <madhur.agrawal@airoha.com>
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
Changes in v9:
- Do not stop device probe if mac address are misconfigured but just
  report the warning
- Rebase on top of net-next main branch
- Remove redundant net_device pointer inside airoha_gdm_dev struct.
- Link to v8: https://lore.kernel.org/r/20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org

Changes in v8:
- Fix dts schema issues reported by sashiko.
- Fix possible NULL-pointer dereference in patch 2/10.
- Fix max mtu computation in airoha_dev_change_mtu().
- Link to v7: https://lore.kernel.org/r/20260516-airoha-eth-multi-serdes-v7-0-99e0093303e2@kernel.org

Changes in v7:
- Fix dma_sync_single_for_cpu() size in airoha_qdma_rx_process().
- Fix hw stats reset.
- Fix typos.
- Add fix for airoha_tc_remove_htb_queue queue index.
- Fix dts schema issues.
- Remove hw stats patch from the series.
- Link to v6: https://lore.kernel.org/r/20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org

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
Lorenzo Bianconi (6):
      dt-bindings: net: airoha: Add GDM port ethernet child node
      net: airoha: Remove private net_device pointer in airoha_gdm_dev struct
      net: airoha: Support multiple net_devices for a single FE GDM port
      net: airoha: Do not stop GDM port if it is shared
      net: airoha: Introduce WAN device flag
      net: airoha: Support multiple LAN/WAN interfaces for hw MAC address configuration

 .../devicetree/bindings/net/airoha,en7581-eth.yaml |  56 ++-
 drivers/net/ethernet/airoha/airoha_eth.c           | 490 ++++++++++++++++-----
 drivers/net/ethernet/airoha/airoha_eth.h           |  25 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |  32 +-
 4 files changed, 480 insertions(+), 123 deletions(-)
---
base-commit: dfcc2ff12925d99e858eaf539eaa4aaaf81fe2a6
change-id: 20260324-airoha-eth-multi-serdes-fb4b556ee756

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

