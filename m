Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472908;
	b=0Ya4cXqWoPHVeTEOXWOadeRJ1uB3EDR6/AFqazgW622vys8/pzTBdHKzQAhtStmKgxrG
	 NjwbvX6P1RSBGXj797VAUphkv+99eEjnICmOnqE7qNtaeJQE742IFtIur3I4gNMIBP4VM
	 ozLRl8Rbm5R0ogGZL1dV/8BhHGSzputATDa6TljtbY/hKLTXC+3AXM4ynrSiuZYZ23dzN
	 8G0dxeKikiiPD6UgyYzZIG3es+a4NlGrrucsKLOmQCLjuBunKUblIgxfKS3fQAdOH2ajk
	 JAHyjzWgRzts0UOfo3tURiGN+4WIlgunCIsN0ok+KMQRbyh/ElwSYTymnLOM+2evi5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472908;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=cOZOcx0Mu9HyNEyLOdYNEnsYBK2dtuXmhg8/FXfAGjg=;
	b=lSJpvIDdWB6xoHQ5dfaQXsqnNgU4gZ5lJIr93dGotWfpS5uLcbp6v3O8QghWOs2M9TFc
	 z0uQ7Ig3sVK2/V9XyM4385IHOA1sFAmsL52EQkkcANeZunETk7vy/jfw/NE/OEpOF4IXP
	 aAq+1NnhcCoT6kB7E4nDyUI4EoyPJc28aHkVK0RNwOiHOLbklDKAcjq0+TSyH6LVjN3t5
	 BhXx1+T8OApa2BE26OXIJuN0GPPT8gxruQR0lBK5e6Tmqw87kxD0VquANwOSxxj2NM/ZM
	 TGyMIfQjnrfrKWuBaahas6MRy0zpy4yuC/7mo/c57KgP2EXKDcz8SNQTr03MUlDIS4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5xqkIVF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B93606C82D;
	Thu, 12 Nov 2026 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5xqkIVF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794472908;
	b=IyRk5o3fdl2Mkm3fODFjLtfEztDpa5yabMmiaMDbou56QgUEA2Ozm8jcPu7P0yJ7C+K3
	 hTouAO5bN3DiVmyIAEKXcmU/Ya/KecBrofNzZPptNnKhA8+4vYnPd4F+Qzqq5rjWyNwtz
	 wI6XPwJ0ANJcs3lA10O5yitAP3/KsQDYlqIarLbGSJ5lJnaydrIVLcfxE+enk83RV1N5E
	 iO/+5xf2V5yaB2uDmuBsc0Ygd6ZJsVRQhT6th9Ss6sIE8Dnhsj5qUwU++1SaLci0hoX8J
	 aUGMEpkOtuuCKmvPLFG0Aj79O4OZIYFZYqt+CW1aBZEZzEd3Hi47AQ7GPxnyRMGcKwg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472908;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=cOZOcx0Mu9HyNEyLOdYNEnsYBK2dtuXmhg8/FXfAGjg=;
	b=QiF3GPUEKQOa9FhrIolusbGbHn6mRtLBdQdgZNHDgOxyu+IkNEe68foYe5pkqZTHisuN
	 xAtbXgLJqKlxY/uwdce+F/oxWyumBtIpdbJr84rA9lAehS67ZR0P78+UG2IhLVDh6scRj
	 ZSrKqjSngDP06sqmUeOcgs0GTQIKtE89ImnSjVfcL4igxUeoT1fDSTWy3KX+8YEKSKA7V
	 rJ8TPRjBXBt6d60lsymkv5bdj7hCLDTj4JOiZ5k40LKJxE7U8CcUlgn3S3uB6Rhtbjw11
	 +cjp/uR/eHcnvvwLsDPJju4CWJvO3o66vYV14wf/+p/bjJYkFQimoHv+hzRRM9fx1sg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B1A8B1F00A07;
	Thu, 12 Nov 2026 08:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472908;
	bh=cOZOcx0Mu9HyNEyLOdYNEnsYBK2dtuXmhg8/FXfAGjg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=C5xqkIVFcXa2Er8OpXLp0CrJD/qDyPZbRPo2JhNEr75D1dslMHGuaAVoCixhq8sqj
	 UwCKmawRJ1qUWuUgqIF8P8XXzM5oQmrZBRpcxxyQdiYwZz7mQfXu1mg1nmvg5LGrJL
	 tzJ5dFaR6LOXjZP4UXgDN8wfSeG49TFLWoqUwJF6oSax670YdetQwyY4M55zGgk5E+
	 hOmTD8QgANWd5iu/rI+Lw82WrFtrrO5hJyVKUujf0ZXZz2AWkmBmq7xsL2+lNcbPhb
	 pe9WY2IsGnxoo35RKYQQN6r4DUQsNiVPS4vKiFjqqEmxOPfR6a6FWxQo+ZTa4Cjb2h
	 hh2LwTK5M69kw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 10827493CA;
	Thu, 12 Nov 2026 08:41:47 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH net-next v2 0/2] net: stmmac: dwmac-sun8i: Jumbo frames and
 an RX_TH fix
Date: Thu, 12 Nov 2026 08:41:46 +0000
Message-Id: <20261112-sun8i-emac-jumbo-v2-0-aca0cf23cf17@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6DIBREr2L+ur8BNQa66j0aF0g/iinQABob4
 92rdt3ly8y8WSFRtJTgVqwQabbJBr9DeSlAD8r3hPa5M5SsbDjnDNPkhUVySuM4uS5gLSpppKh
 VoyTss3ckY5dT+QBPGT0tGdpfkqZuJJ0P49EdbMohfs73mZ+L/0czR4ai7gxjJI1R1b13yr6uO
 jhot237Alda2frMAAAA
X-Change-ID: 20261110-sun8i-emac-jumbo-4839f984a6a9
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
 linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472906; l=2223;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=4lSOCGIxuhr5scVSNymqWxWTq8eeBYQM5ER9DID9Zyk=;
 b=8f+Qdim9xm+qJ7Nqsq62ye44HOsAZgiddAr0jN0CQpUvgGKZYonOGdxtlRWyHja9k02ORMRlz
 1VDwiIjldWeC16DzPzfuMVXbGC6rEq1jOCRMrrKL1v98YFevFuiQsCz
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

The sun8i EMAC advertises a maximum MTU of 3712, but drops every frame
longer than 1518 bytes. Patch 2 sets the receiver's jumbo frame enable
bit and limits the MTU to what fits in one normal descriptor buffer
(2018). Patch 1 corrects two swapped RX threshold values; no in-tree
Allwinner board uses RX threshold mode, so none is affected.

Tested on an Orange Pi Zero2 (H616, RTL8211F over RGMII) at 1 Gbit/s,
with a 7.3 kernel carrying both patches:
- MTU 2000 and 2018: pings with DF set up to the full MTU pass in both
  directions, iperf3 gives 955 Mbit/s to the board and 905 Mbit/s from
  it, and the rx_length and rx_crc_errors counters stay at 0.
- Setting MTU 2019 is refused.
- At MTU 1500, a 90 minute run (bulk transfers up to 256 MiB both ways,
  iperf3 853/873 Mbit/s, 1000 pings each of 56, 1472 and 8000 bytes)
  had no loss and no new error counters.

In that 7.3 kernel, frames longer than 2044 bytes were dropped by a
local norm_desc change; v7.4-rc2 does the same through commit
834ec9530832 ("net: stmmac: drop split frames on AF_XDP zero-copy RX"),
which patch 2 now relies on.

These patches were developed with Claude (Anthropic) as a coding
assistant. It investigated the problem and wrote the code and the commit
messages; I reviewed them, and they were tested on an Orange Pi Zero2
(H616) as described above.

---
Changes in v2:
- Patch 1: add the Fixes: tag, and correct the commit message: RX
  threshold mode depends on snps,force_thresh_dma_mode, not on RX
  checksum offload (Sashiko AI review)
- Cc Corentin Labbe (author of the Fixes: target)
- Rebased onto current net-next; patch 2 unchanged
- Link to v1: https://patch.msgid.link/20261110-sun8i-emac-jumbo-v1-0-84bf00e9ffa3@gmail.com

---
Arun Iyengar (2):
      net: stmmac: dwmac-sun8i: Fix the RX_TH threshold encoding
      net: stmmac: dwmac-sun8i: Enable jumbo frames up to MTU 2018

 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 29 +++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)
---
base-commit: c88fd6989aea9237a60a4859139a265bfb7ddc0b
change-id: 20261110-sun8i-emac-jumbo-4839f984a6a9

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


