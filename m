Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF843314AC;
	Thu,  3 Sep 2026 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472353; cv=none; b=avWhzYvys3LC4+nRLUurExnKRi5VAsuJajM8Kx41R0VxTXSHvw9AaHDJRUksVrHviSCFw2R9fkCgmjHAHUFS0v5fCcxXO1ssGTDuL4MNlqXn0VXa9FsiN3MYrVPCzTnSQDHLlDMXiZXP2ezf5TPBD188fkTDU4ZJOsYkw1gbmMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472353; c=relaxed/simple;
	bh=WWWH2A4YxMgF8e+RMSwJPSpoma1ywMkJkLaDC9mmKEw=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=feeyZFCMeT7Os2sDXuGMMQ5G4IorNw7B87q3I2jS3bxf7WaVwadYWBF/fIcrurmjNyjs1K2T6T7FVvdDkNjodmaS4JNI7ScSEuCTvRye4N/WciCTGHh8QV44By6dwhVvv1xiYoR/nMvoo7EsV21tE3uxSFmbZxfAJfOyPaLeex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
Date: Thu, 03 Sep 2026 22:52:15 +0100
From: Bradley Morgan <brads@mainlining.org>
To: devnull+vjardin.free.fr@kernel.org
CC: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 hkallweit1@gmail.com, ioana.ciornei@nxp.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 pabeni@redhat.com, vjardin@free.fr
Subject: Re: [PATCH net-next v2] net: pcs: lynx: add support for 25GBASE-R
In-Reply-To: <20260922-for-upstream-lynx-25gbaser-v1-v2-1-1e6cf79c7b52@free.fr>
Message-ID: <F8C0FBBD-EBCB-4D94-8ABF-3AF3D86DEBFF@mainlining.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 22 September 2026 

What??


20:40:33 BST, Vincent Jardin via B4 Relay
<devnull+vjardin.free.fr@kernel.org> wrote:
>From: Vincent Jardin <vjardin@free.fr>
>
>The Lynx PCS never supported 25GBASE-R. Add it, so that a 25G DPMAC on
>LX2160A can be driven by phylink.
>
>The SerDes side had the mode since the commit
>  1cab8fba5073 ("phy: lynx-28g: add support for 25GBASER")
>and dpaa2-mac maps DPMAC_ETH_IF_CAUI to PHY_INTERFACE_MODE_25GBASER,
>but the PCS never handled it, so phylink_validate() failed with the
>interface.
>
>25GBASE-R is a serial mode without clause-37 in-band autonegotiation,
>exactly like 10GBASE-R: it does not needs any configuration, its state
>is read with phylink_mii_c45_pcs_get_state(), and it reports
>LINK_INBAND_DISABLE.
>
>phylink_mii_c45_pcs_get_state() is extended in the same patch because
>without it the link comes up reporting Unknown/Unknown.
>
>Suggested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
>Co-developed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
>Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
>Signed-off-by: Vincent Jardin <vjardin@free.fr>
>---
>Repost of the RFC now that net-next has reopened, rebased on net-next.
>---
>Changes in v2:
>- Reword: this adds 25GBASE-R support, it does not fix a regression
>  (Ioana Ciornei)
>- Squash in the phylink_mii_c45_pcs_get_state() 25GBASER case, without
>  which the link comes up as Unknown/Unknown (Ioana Ciornei)
>- Link to v1: https://lore.kernel.org/r/20260825-for-upstream-lynx-25gbaser-v1-v1-1-fd71c8047798@free.fr
>---
> drivers/net/pcs/pcs-lynx.c | 6 +++++-
> drivers/net/phy/phylink.c  | 5 +++++
> 2 files changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
>index a92081560e641..da4f99059eef7 100644
>--- a/drivers/net/pcs/pcs-lynx.c
>+++ b/drivers/net/pcs/pcs-lynx.c
>@@ -46,6 +46,7 @@ static unsigned int lynx_pcs_inband_caps(struct phylink_pcs *pcs,
> 		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
> 
> 	case PHY_INTERFACE_MODE_10GBASER:
>+	case PHY_INTERFACE_MODE_25GBASER:
> 		return LINK_INBAND_DISABLE;
> 
> 	case PHY_INTERFACE_MODE_USXGMII:
>@@ -97,6 +98,7 @@ static void lynx_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
> 		lynx_pcs_get_state_usxgmii(lynx->mdio, state);
> 		break;
> 	case PHY_INTERFACE_MODE_10GBASER:
>+	case PHY_INTERFACE_MODE_25GBASER:
> 		phylink_mii_c45_pcs_get_state(lynx->mdio, state);
> 		break;
> 	default:
>@@ -188,7 +190,8 @@ static int lynx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> 		return lynx_pcs_config_usxgmii(lynx->mdio, ifmode, advertising,
> 					       neg_mode);
> 	case PHY_INTERFACE_MODE_10GBASER:
>-		/* Nothing to do here for 10GBASER */
>+	case PHY_INTERFACE_MODE_25GBASER:
>+		/* Nothing to do here for 10GBASER and 25GBASER */
> 		break;
> 	default:
> 		return -EOPNOTSUPP;
>@@ -279,6 +282,7 @@ static const phy_interface_t lynx_interfaces[] = {
> 	PHY_INTERFACE_MODE_1000BASEX,
> 	PHY_INTERFACE_MODE_2500BASEX,
> 	PHY_INTERFACE_MODE_10GBASER,
>+	PHY_INTERFACE_MODE_25GBASER,
> 	PHY_INTERFACE_MODE_USXGMII,
> 	PHY_INTERFACE_MODE_10G_QXGMII,
> };
>diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
>index 3ec3bb4391095..ff4375f1e9108 100644
>--- a/drivers/net/phy/phylink.c
>+++ b/drivers/net/phy/phylink.c
>@@ -4360,6 +4360,11 @@ void phylink_mii_c45_pcs_get_state(struct mdio_device *pcs,
> 		state->duplex = DUPLEX_FULL;
> 		break;
> 
>+	case PHY_INTERFACE_MODE_25GBASER:
>+		state->speed = SPEED_25000;
>+		state->duplex = DUPLEX_FULL;
>+		break;
>+
> 	default:
> 		break;
> 	}
>
>---
>base-commit: c8ea08ba34f2a2e9bfb18ff3d69eb2d69b324f49
>change-id: 20260825-for-upstream-lynx-25gbaser-v1-30097d909d09
>
>Best regards,
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
