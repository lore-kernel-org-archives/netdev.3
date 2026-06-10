Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354540B6E7
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098458; cv=none; b=p/kFc+7AL+n0zOoYF/q+JsCUIQ1LxSmtoFsBJEy8rid654FtrskHw022bjTiVSoPF/ROIjThMdt7w8KXBoNW1c3znxD3EvO3r/dh3xiExaG9tdudihvdoNfCcMJWi0LJHB5vXT7iWE9sQ3W2YZj1yxsta/2+sosrAIhZ0C/fftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098458; c=relaxed/simple;
	bh=qgrA3XioKdkJphht2g8d3A6h701hC/9PRE5eNNfMt8k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q6IovgHQWzj0JBA5N76WJVo9oSJEF1jlUyImfLRz/QvfZAvQD/Vc8OimjdLjQAaaP8se83MUtpM8vZIsocUJK2YWG7+pn89C0O1pvw1zbQxsRWaiV+r+yUSGyeTAEqb3SsnfqmlAQ6A5DCpff4JDZSHESnBXMYL9qDjjTX94t/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkiQtbdI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkiQtbdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5001F00893;
	Wed, 10 Jun 2026 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781098452;
	bh=pud1BKNlE340QqB4LGfMxf04oM6t5suYLOhM/DdiAO0=;
	h=From:Subject:Date:To:Cc;
	b=HkiQtbdIhjM43fJCPp/ffFJDxFzwsT3cnJXX0EzqTwMusjiO2M4XhYPjBbePdgoNL
	 Z/TfQnTF+PV6dK0VAfJaUYtz+V9dv30cDiVoIw/Hgk9WhlmWZ1wgDrCRE4q2OBAPKM
	 ev9d1Nwq37b6VLf3XrDUoMPod/ndCmujlghN46Cb6d4D5/utQ2ot/xXSbFUwFIdy7l
	 V78+5ibnp4V9QNQdhw/LqLC40kpWEqGtb2WBrYb61LpSLfNaQsBNrrieUbL+vPBrE8
	 O2w8SapdOfLxd091jSR+CxiTwSHJ79KWQtQaf1yuiWUJHqWKEXYoUEMNg5QfZKk9eg
	 THbhH5McTNGIA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v4 0/2] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Date: Wed, 10 Jun 2026 15:33:35 +0200
Message-Id: <20260610-airoha-ethtool-priv_flags-v4-0-60e89cf28fea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NTQqDMBAF4KtI1k3JjzXaVe9RSolxoqGSSBKCR
 bx7gytLQcrAwOMx3ywogDcQ0LVYkIdkgnE2h/JUIDVI2wM2Xc6IEVaRPFga7waJIQ7RuRFP3qS
 nHmUfcFtJKYjKqyYo308etJk3+44sRGxhjuiRm8GE6Px7e5ro1v/hJ4opLgltmWo0NJreXuAtj
 Gfn+41NbE+JI4plSpRMCSkp0Jr9UHxP1UcUzxSHGninuBb08kWt6/oB5XQpe2MBAAA=
X-Change-ID: 20260606-airoha-ethtool-priv_flags-b6aa70caa780
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Madhur Agrawal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3

Add the capability to configure GDM3/GDM4 as WAN/LAN on demand when QoS
offload is created or destroyed.
Make dev->qdma an RCU pointer so the TX path can safely dereference it
without holding RTNL.
Introduce airoha_qdma_start() and airoha_qdma_stop() helpers.

---
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
      net: airoha: refactor QDMA start/stop into reusable helpers
      net: airoha: defer GDM3/GDM4 WAN mode and GDM2 loopback to QoS offload

 drivers/net/ethernet/airoha/airoha_eth.c  | 273 +++++++++++++++++++++++++-----
 drivers/net/ethernet/airoha/airoha_eth.h  |  24 ++-
 drivers/net/ethernet/airoha/airoha_ppe.c  |  18 +-
 drivers/net/ethernet/airoha/airoha_regs.h |   1 +
 4 files changed, 267 insertions(+), 49 deletions(-)
---
base-commit: 5855479abc796c3b5d7b2f2ca147d68fc56cae1f
change-id: 20260606-airoha-ethtool-priv_flags-b6aa70caa780

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

