Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86D2931CF;
	Wed, 15 Jul 2026 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121204; cv=none; b=IbuMWNxH1/fCdEsDVfra21VAVM46am5jqIWLk8RuNW/VmzsCsjhjNOoAGwZ1IVp9soduhQSU9GTIGFbZKuxjkbK7f6IqdYMomoMrRD1okH1N80wDE83QTSjDwLgGXMY1W9BUmxroXesw5ttFn7eGQwldYQfzsYHZk7SbB9Uud1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121204; c=relaxed/simple;
	bh=U8+EzAEURWuyga3Nxl/Pxe938ZSfE4wTWFRaQ2EOEH4=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=czKFvo6MvwS1bFX+mEpPGelTl/2IkxQdrcluwKKOF6bSjCaSu+opphaL/6JoXVUI2HRl5Z3rRNpmR8R4dbyyhIsoyQ2dKXi4tY+e902rFxY3j/+WanKmPLob/OVezp/xekHI68lLc8HBqU6CfOafm+W/FiXj/oBmlEafJGo1nSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=Bh9BSFqE; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="Bh9BSFqE"
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1784120288; h=from:subject:to:date:message-id;
	bh=U8+EzAEURWuyga3Nxl/Pxe938ZSfE4wTWFRaQ2EOEH4=;
	b=Bh9BSFqEk2aH8K9IO1AgqspFA+n7wE0h+TuVDPwuEUb2bqh0AghlxpefNCbqaOR97Tt1ab1YXeQ
	+QLfNBV7IR+C52+XmA4JqbCd1iPsb1ZXeGrzylJ/L3H0vsqKmnBx7hYeJZ7f86DyKsDJNJwrFJteD
	IORREb+BPd93pZhIU2quzI429Zn+AzUOoO4BaY0cGMuIrcgJfkqJlE2u7Zj8fmTyHH+5qetGQAJ5d
	pUHs6VTyz7FB4Drog8n+A4df+FFiRY12o0Kvrzw/+Q8UEB0n3+C7UC286WcmLtyfJ3d9wRK/4eMGM
	Kz8sgzm3H8KHf+na1JqOcUxS7DTfmNl3iAhA==
Received: from dish.amicon.lan (172.16.30.10) by mail.amicon.lan
 (192.168.0.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 15 Jul
 2026 15:58:07 +0300
From: Daniil Iskhakov <dish@amicon.ru>
To: Jian Shen <shenjian15@huawei.com>
CC: Daniil Agalakov <ade@amicon.ru>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Daniil
 Iskhakov" <dish@amicon.ru>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rrv@amicon.ru>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net-next v2] net: hns: use u32 for register offset in RCB TX coalescing
Date: Wed, 15 Jul 2026 15:58:48 +0300
Message-ID: <20260715125856.19346-1-dish@amicon.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)

From: Daniil Agalakov <ade@amicon.ru>

In both hns_rcb_get_tx_coalesced_frames() and
hns_rcb_set_tx_coalesced_frames(), the local variable reg holds a
register offset passed to dsaf_read_dev() or dsaf_write_dev().

Register offsets on this hardware are 32-bit values. Use u32 for reg
to match the register access interfaces and avoid implying that
64-bit offsets are supported.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Daniil Agalakov <ade@amicon.ru>
Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
---
This is an unchanged resend of v1, which missed the previous net-next
development cycle.

Changes in v2:

  - no code changes
  - reword the commit message
  - add my Signed-off-by tag
  - rebase onto the current net-next tree

v1: https://lore.kernel.org/all/20260420144047.2846673-1-ade@amicon.ru/

 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
index 635b3a95dd82..3c4e4e8ca140 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -563,7 +563,7 @@ u32 hns_rcb_get_rx_coalesced_frames(
 u32 hns_rcb_get_tx_coalesced_frames(
 	struct rcb_common_cb *rcb_common, u32 port_idx)
 {
-	u64 reg;
+	u32 reg;
 
 	reg = RCB_CFG_PKTLINE_REG + (port_idx + HNS_RCB_TX_PKTLINE_OFFSET) * 4;
 	return dsaf_read_dev(rcb_common, reg);
@@ -634,7 +634,7 @@ int hns_rcb_set_tx_coalesced_frames(
 {
 	u32 old_waterline =
 		hns_rcb_get_tx_coalesced_frames(rcb_common, port_idx);
-	u64 reg;
+	u32 reg;
 
 	if (coalesced_frames == old_waterline)
 		return 0;

base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
-- 
2.43.0

