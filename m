Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35DE45DF6B;
	Tue, 25 Aug 2026 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666435; cv=none; b=TFQVBTNjBh/RUxlxjOBlErPAwAQUK4Dd6fQhc+77ZmFLd9Z+1oycz3lhE2ChpmEuXdcT69/RnbiCCL00AwKkkcMd79MtECkA4nV4OyWIjYEYHQxkyYzTVuTb4rKQtGZ1Lk5xIwTzeXyFUPWqr3u3DUi7uwFrChkXv28gRZ/e6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666435; c=relaxed/simple;
	bh=I4QSCefobgK/YJS5oxXsLSIpFlLME1PYHxxwa3CV6dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iRjmQci2rG08jSEbZYvlHuj9VlLSK3Sn98J5BuUuCqueiFxbULt2W3EXXoCw1p1dhnC97v3gWc6+6mYtdIOboZpdnFevmgLiq/jTtJraFUjmE8aEZUV4L7sotiL12espqbyJF8UvVo/qLPIFQ/U5yxftMdsynhH5zGspha29VwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/McnPQ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/McnPQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B4CFC2BCB8;
	Tue, 25 Aug 2026 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787666435;
	bh=I4QSCefobgK/YJS5oxXsLSIpFlLME1PYHxxwa3CV6dk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=c/McnPQ4H02NckWE6c60J5vmUi0Uz1vGlaGMSODb3ABElUWhQXnqqKBQJ5oGUSt0C
	 5Hfgb0zaamU9S+zYQuq0DdJydrq7hUib4CgzcSvntc7RAPHQOtjFBe/8LDR01cw+2p
	 w07USHSZB27HP33b1CmfeIm1kRcJeU5oIpOkK6Trr7hBoiGjp6a2lAiR15HVA2urix
	 Z6z88f+oGbzm6L/7IGi6ijwhOtaNnmXvtIxLos1yErEZp3FAVGeM8OuVwlihjVOy8e
	 R+AMI7p8FOOpYiu81ZYdIsmJEpiba5V7sWFZczwbiQVHsrBgo6pr46wZV5H11Z3Quq
	 1J2D4k0PqCUuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25695C61DBD;
	Tue, 25 Aug 2026 14:00:35 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Tue, 25 Aug 2026 16:00:31 +0200
Subject: [PATCH RFC net-next] net: pcs: lynx: add support for 25GBASE-R
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-for-upstream-lynx-25gbaser-v1-v1-1-fd71c8047798@free.fr>
X-B4-Tracking: v=1; b=H4sIAP6fjWoC/x3MwQrCMAwA0F8pORvIKlPrVfADvI4dqs1mQLPR1
 lEZ+3eLx3d5KySOwgnOZoXIiySZtKLZGXg8vY6MEqrBkj3QybY4TBE/c8qR/RtfXy1o2/Hua4N
 Lg3sidwyOXCAH9ZgjD1L+fwe368UoZ1QuGfpt+wHFD1/afQAAAA==
To: Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787666434; l=1923;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=a3VjYJXTcxGzdn/YmMU6HZTS4gXEW2AU9kDzte4XKBQ=;
 b=EwUEgjPIsepaU9c2urQfJiF3YOT1Ua67SsGOr0aq+OR6vUUUHexeqbNRFO62UlZdKRyk9L/2E
 8QfwNpIh7HZBv6E62byJ4UL38mRb2rARRq8uwuz56LLev7ZX4KmffSC
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

The 25G is missing since commit 1cab8fba5073 ("phy: lynx-28g: add
support for 25GBASER").

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
RFC to check if we apply NXP's intend.
---
 drivers/net/pcs/pcs-lynx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index a92081560e641..da4f99059eef7 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -46,6 +46,7 @@ static unsigned int lynx_pcs_inband_caps(struct phylink_pcs *pcs,
 		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
 
 	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_25GBASER:
 		return LINK_INBAND_DISABLE;
 
 	case PHY_INTERFACE_MODE_USXGMII:
@@ -97,6 +98,7 @@ static void lynx_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 		lynx_pcs_get_state_usxgmii(lynx->mdio, state);
 		break;
 	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_25GBASER:
 		phylink_mii_c45_pcs_get_state(lynx->mdio, state);
 		break;
 	default:
@@ -188,7 +190,8 @@ static int lynx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		return lynx_pcs_config_usxgmii(lynx->mdio, ifmode, advertising,
 					       neg_mode);
 	case PHY_INTERFACE_MODE_10GBASER:
-		/* Nothing to do here for 10GBASER */
+	case PHY_INTERFACE_MODE_25GBASER:
+		/* Nothing to do here for 10GBASER and 25GBASER */
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -279,6 +282,7 @@ static const phy_interface_t lynx_interfaces[] = {
 	PHY_INTERFACE_MODE_1000BASEX,
 	PHY_INTERFACE_MODE_2500BASEX,
 	PHY_INTERFACE_MODE_10GBASER,
+	PHY_INTERFACE_MODE_25GBASER,
 	PHY_INTERFACE_MODE_USXGMII,
 	PHY_INTERFACE_MODE_10G_QXGMII,
 };

---
base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
change-id: 20260825-for-upstream-lynx-25gbaser-v1-30097d909d09

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>


