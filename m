Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FDE382393
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781214978; cv=none; b=fdqSU0mXGWZeayNSf8a2HXb958UmoxfjV/E9j1QMDMDF/th/Vfs0nV8oj4w9KUJq3WJiJaWa5HctaiCEZxSpoGSw5G4bpxmtctyzz2S6qjkz1vOJQP/xJpYaoyj74IN5kRq1pwDnU+JREPUFITbxcs/4fgP6M0dlRsGjXoB0xpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781214978; c=relaxed/simple;
	bh=NHC/w53pXGDQ4+4bbQGi9IXxEfL5AkB4J6nLGuqeftg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p2auuelXONCRpkN0DbjtBhzX2F18BCBfXs0hhvbJAAzFtR0CTCTHWg91r/3a3D+SOer5Bo08yT/TzIVHKJWbG1/c9pU3bufAP9y7XaZSchu089fPutb0BkXKhWenPdbk26Ox1TPRn/VDXjBSuWk1jowzUH4gyMNKBtOynWmdTZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTGJIjdI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTGJIjdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1E81F000E9;
	Thu, 11 Jun 2026 21:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781214976;
	bh=6qBwSk+puYij3SlBze+P7GUqLUavspZMpeFrJqlN8VI=;
	h=From:Subject:Date:To:Cc;
	b=GTGJIjdI4H3BIetMRo453XUAHpueqIdJGGFOdwNQouxjmpudpfRjS522TN5tMKN/w
	 lAfjkyR781GvJQDp7BMIfe52Yn8Y9UBWiIuMrF54x3bFDgUQOnrs/WfeeVkhUNdrp8
	 +B5R6em9ijjgqaYE8DZGuzpvrlKx+WX9IOWVX5vth49R+1C7QljSme6ncOsiVJ0aR/
	 3HH2BYKtTwyKxQpzl6FzHyfK4GopAuv/LxVVJUMxJ9IurSOaGDm1r8uChFwaWahYyV
	 xSHi9mGV9efjNKQ6lH8Pr0bGPGVNjKIl45fZI8MK330Bz17z9YIGNzqOn8nMi0kVlK
	 h7gcLKPkeMQZw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v5 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Date: Thu, 11 Jun 2026 23:55:50 +0200
Message-Id: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43N0YrDIBAF0F8pPu8UR9No9mn/Y1kWa8dENmhRk
 S4l/17JU0ohlIGBy2XO3Fmm5Cmzz8OdJao++xhaOH0cmJ1MGAn8pWUmuOh5GzA+xckAlanEOMM
 1+frrZjNmOPfGKG7b0py1+2si52+r/c0CFQh0K+ynNZPPJab/9WnFtX/DrwgIHcezsIOjweHXH
 6VA8zGmcWWr2FJqjxKNUp2wyhgk1OKFkltK71GyUZI0yYuVTuHpheo2FPI9qgMOPSc9WCe0I/N
 ELcvyAJD5Fv2uAQAA
X-Change-ID: 20260606-airoha-ethtool-priv_flags-b6aa70caa780
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Madhur Agrawal <madhur.agrawal@airoha.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
X-Mailer: b4 0.14.3

Add the capability to configure GDM3/GDM4 as WAN/LAN on demand when QoS
offload is created or destroyed.
Make dev->qdma an RCU pointer so the TX path can safely dereference it
without holding RTNL.
Introduce airoha_qdma_start() and airoha_qdma_stop() helpers.

---
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
      net: airoha: use int instead of atomic_t for qdma users counter
      net: airoha: refactor QDMA start/stop into reusable helpers
      net: airoha: defer GDM3/GDM4 WAN mode and GDM2 loopback to QoS offload

 drivers/net/ethernet/airoha/airoha_eth.c  | 287 +++++++++++++++++++++++++-----
 drivers/net/ethernet/airoha/airoha_eth.h  |  15 +-
 drivers/net/ethernet/airoha/airoha_ppe.c  |   9 +-
 drivers/net/ethernet/airoha/airoha_regs.h |   1 +
 4 files changed, 262 insertions(+), 50 deletions(-)
---
base-commit: dad4d4b92a9b9f0edb8c66deda049da1b62f6089
change-id: 20260606-airoha-ethtool-priv_flags-b6aa70caa780

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

