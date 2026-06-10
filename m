Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532C222582
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097933; cv=none; b=Ewnogk7J8U9hO2KxG4rer9V4Oiqjoli/OTxETMnKtxXpzAnL3pxygJwHDKAZta7fi63PXecKwTxWqWpcx1JvEtlfffeTaxRts3dCCKfZvPLD2r+0BJP33g/eEuHo1gzjZ7CqCTpwjZhLUIm/2b9Oz6fk1rhJf8P2GKUpWAYc+OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097933; c=relaxed/simple;
	bh=79RAFI0eLfuo16XAHmrtpKfVd79PIk6sghlg9OoAz7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tAjl0kVCwnt2XbTIC31Lg1zaMvS3cL0nVJvCMGvIHyKWOaWkliLTD0ixNT6pmGrJTNpwyrsrtDYkmcrnrUWOm0JdhLv9rtOCwDLYDRH2uBbMiF+NYeP4h8D2bH47E/Ef1IKYndGtkb5JjGnS0AGPhpMc5KVt6IvbeOySkPMDzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NESv/YSM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NESv/YSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4039B1F00893;
	Wed, 10 Jun 2026 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781097931;
	bh=BGHkQNIcnO67qdZeWXWc4L3zaP3PkHtDlFiASvmwoyg=;
	h=From:Date:Subject:To:Cc;
	b=NESv/YSMug2guyTsmzMnuCCgaUFCkr0wAxYOPF+X1JObiDY4BXiB6Yyeujo8fUF9A
	 9n6eE+JDQf0SUbiIqUoOm+IQPPPe8dEy+WhMTr6vVv+bVbwlQ06hb4d+ieZ9o+Ajg4
	 TAyejcYp5cFMkhncjyk12SQzBV+/bTYcyQ9xjZm0PUxQXvl1WbmRDVGIE+/xl2vgyi
	 9OkAqW0oEWsWRd19ktJIZwcwk7ell69E3SNYcZD6c2hazWQpWT+cQ77N8A9rdIMLZk
	 0bE0AjbQ4nhRjBA8nICiqpfVIZLLZ81AvPYgJUJaBEnw5IOmnhNxjMgRS9KyOlqXIM
	 7ADpHfcoZ10/w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 10 Jun 2026 15:25:13 +0200
Subject: [PATCH net-next v2] net: airoha: simplify WAN device check in
 airoha_dev_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-airoha-eth-simplify-dev-init-v2-1-8f244e69b0d4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQqDMBBFryKz7pRotbWueo/iQuLEDLWJTEJQx
 Ls3eILyV48H7+8QSJgCdMUOQokDe5ehuhSg7eAmQh4zQ6Wqu8rDgcXbASlaDPxdZjYbjpSQHUd
 sxuamH1orVRPkxCJkeD3zb3AU0dEaoc/GcohetvM3laf/7yKVWKJRrWmpVnnP14fE0Xz1MkF/H
 McPMGzOmtMAAAA=
X-Change-ID: 20260606-airoha-eth-simplify-dev-init-5d53c7cc004e
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3

airoha_register_gdm_devices() iterates eth->ports[] in order, so GDM2's
netdev is always registered before GDM3/GDM4. This means the explicit
check for eth->ports[1] && eth->ports[1]->devs[0] is a redundant
special-case of what airoha_get_wan_gdm_dev() already covers, since
GDM2 is always marked as WAN during its own ndo_init.
Remove the redundant check and rely solely on airoha_get_wan_gdm_dev()
which handles both the GDM2-present and GDM2-absent cases.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Rebase on top of net-next.
- Link to v1: https://lore.kernel.org/r/20260606-airoha-eth-simplify-dev-init-v1-1-f08f8e404049@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5a8e84fa9918..b333a7b309c2 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2004,18 +2004,10 @@ static int airoha_dev_init(struct net_device *netdev)
 
 	switch (port->id) {
 	case AIROHA_GDM3_IDX:
-	case AIROHA_GDM4_IDX: {
-		struct airoha_eth *eth = dev->eth;
-
-		/* GDM2 supports a single net_device */
-		if (eth->ports[1] && eth->ports[1]->devs[0])
-			break;
-
-		if (airoha_get_wan_gdm_dev(eth))
+	case AIROHA_GDM4_IDX:
+		if (airoha_get_wan_gdm_dev(dev->eth))
 			break;
-
 		fallthrough;
-	}
 	case AIROHA_GDM2_IDX:
 		/* GDM2 is always used as wan */
 		dev->flags |= AIROHA_PRIV_F_WAN;

---
base-commit: 5855479abc796c3b5d7b2f2ca147d68fc56cae1f
change-id: 20260606-airoha-eth-simplify-dev-init-5d53c7cc004e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

