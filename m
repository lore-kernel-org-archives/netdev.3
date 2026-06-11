Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC6A401A3C;
	Thu, 11 Jun 2026 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184449; cv=none; b=TJ+NhOYwLLwe0P2B1bAQNJNslxXEazBvk+24MYTD+uA2iwhWtDX09Y1oOQJ/hmM5YxnPIV1E/v30sXYfSEnNH2FMmZXOVFECeiXcZNi2r7Bn6aGJZs/wKoXo0RAqbLAU+zldjmVSAtwTKorgHlrKaApXGuKDFh1Vd/Ny6rOR+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184449; c=relaxed/simple;
	bh=FTJHjsZAc/hSbo+Mmaam3SfFlDv5G1cWvKnglA5CXy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJOQDEDxSSPODl7wV9oeXMpu1rlwfZmX/yNbYVhMATqhaTcng+9NDgjNu6SCSY/gUcRtjZKNvL9eR4Nn7xF1m3oH7FF5CLYhiLl0z8bfJM0BTy3sfbGhxC9xoyhzPGnkDKOjmStVmyQxOwjM8D043Gdcv9G0lShxW28BGOJqVr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wXfRH-000000005Do-2bmG;
	Thu, 11 Jun 2026 13:27:19 +0000
Date: Thu, 11 Jun 2026 14:27:16 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/4] net: dsa: mxl862xx: add support for
 SerDes ports
Message-ID: <aiq3tDWMjwv4gv_3@makrotopia.org>
References: <f9c3f46f0729e98b6c52f8fa1172eab0aadc7b92.1780968180.git.daniel@makrotopia.org>
 <20260611131043.578836-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611131043.578836-2-horms@kernel.org>

On Thu, Jun 11, 2026 at 02:10:44PM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net: dsa: mxl862xx: add support for SerDes ports
> 
> The MxL862xx has two XPCS/SerDes interfaces. This commit implements phylink
> PCS operations using the firmware's XPCS API and registers a PCS instance
> for each SerDes interface and QSGMII/10G_QXGMII sub-ports.
> 
> > diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
> > --- a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
> > +++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
> [ ... ]
> > @@ -7,20 +7,401 @@
> >   * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
> >   */
> >  
> > +#include <linux/bitfield.h>
> > +#include <linux/mutex.h>
> >  #include <linux/phylink.h>
> >  #include <net/dsa.h>
> >  
> >  #include "mxl862xx.h"
> > +#include "mxl862xx-api.h"
> > +#include "mxl862xx-cmd.h"
> > +#include "mxl862xx-host.h"
> >  #include "mxl862xx-phylink.h"
> >  
> >  void mxl862xx_phylink_get_caps(struct dsa_switch *ds, int port,
> >  			       struct phylink_config *config)
> >  {
> > +	struct mxl862xx_priv *priv = ds->priv;
> > +
> >  	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
> >  				   MAC_100 | MAC_1000 | MAC_2500FD;
> >  
> > -	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> > -		  config->supported_interfaces);
> > +	switch (port) {
> > +	case 1 ... 8:
> > +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> > +			  config->supported_interfaces);
> > +		break;
> > +	case 9:
> > +	case 13:
> > +		__set_bit(PHY_INTERFACE_MODE_SGMII, config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_1000BASEX, config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_2500BASEX, config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_10GBASER, config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_10GKR, config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_USXGMII, config->supported_interfaces);
> > +		fallthrough;
> > +	case 10 ... 12:
> > +	case 14 ... 16:
> > +		if (!MXL862XX_FW_VER_MIN(priv, 1, 0, 84))
> > +			break;
> 
> [Severity: High]
> Since the firmware version check is performed after the supported interface bits
> are set for ports 9 and 13, won't SGMII and other modes remain advertised on
> older firmware versions?
> 
> Because mxl862xx_phylink_mac_select_pcs() returns NULL for ports 9-16 on older
> firmware, phylink would accept the configuration without a PCS, potentially
> leaving the port silently unconfigured.

This is intentional. The firmware configures the SerDes interfaces to the
modes defined in a on-flash configuration. This means the CPU port typically
works fine if DT reflects what is in the on-flash configuration without
needing the driver to do anything for that.
On the other hand, if we error out here, the driver will fail to probe
because it cannot bring up the CPU port. The problem is that this would
also prevent firmware updates via devlink (which are going to be introduced
in a later follow series), which require the driver to at least probe.
A dev_warn() is issued in this case, so the user is informed about SerDes PCS
configuration being unsupported on the old firmware version.

> 
> [ ... ]
> > +static void mxl862xx_pcs_disable(struct phylink_pcs *pcs)
> > +{
> > +	struct mxl862xx_pcs *mpcs = pcs_to_mxl862xx_pcs(pcs);
> > +	struct mxl862xx_xpcs_pcs_disable dis = {};
> > +	struct mxl862xx_priv *priv = mpcs->priv;
> > +
> > +	dis.port_id = mpcs->serdes_id;
> > +
> > +	/* The SerDes is shared across QSGMII/QUSXGMII sub-ports; only
> > +	 * power it down once the last active sub-port goes away. Hold
> > +	 * serdes_lock across the count and the power-down so a sibling
> > +	 * sub-port enable cannot race the transition to zero.
> > +	 */
> > +	mutex_lock(&priv->serdes_lock);
> > +	if (--priv->serdes_refcount[mpcs->serdes_id] == 0)
> > +		MXL862XX_API_WRITE(priv, MXL862XX_XPCS_PCS_DISABLE, dis);
> > +	mutex_unlock(&priv->serdes_lock);
> > +}
> 
> [ ... ]
> > +static int mxl862xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> > +			       phy_interface_t interface,
> > +			       const unsigned long *advertising,
> > +			       bool permit_pause_to_mac)
> > +{
> > +	struct mxl862xx_pcs *mpcs = pcs_to_mxl862xx_pcs(pcs);
> > +	struct mxl862xx_priv *priv = mpcs->priv;
> > +	struct mxl862xx_xpcs_pcs_cfg cfg = {};
> > +	int if_mode, lane, ret, adv;
> > +
> > +	if_mode = mxl862xx_xpcs_if_mode(interface);
> > +	if (if_mode < 0) {
> > +		dev_err(priv->ds->dev, "unsupported interface: %s\n",
> > +			phy_modes(interface));
> > +		return if_mode;
> > +	}
> > +
> > +	/* The XPCS bringup is per-instance and idempotent in the
> > +	 * firmware: every QSGMII/QUSXGMII sub-port may call pcs_config
> > +	 * and the firmware will skip the bringup if the requested mode
> > +	 * matches the cached one, then update MAC pause for the
> > +	 * sub-port indicated by @usx_subport.
> > +	 */
> > +	lane = (interface == PHY_INTERFACE_MODE_10G_QXGMII) ?
> > +	       MXL862XX_XPCS_USX_QUAD : MXL862XX_XPCS_USX_SINGLE;
> > +
> > +	cfg.mode = cpu_to_le16(FIELD_PREP(MXL862XX_XPCS_CFG_PORT_ID,
> > +					  mpcs->serdes_id) |
> > +			       FIELD_PREP(MXL862XX_XPCS_CFG_USX_SUBPORT,
> > +					  mpcs->slot) |
> > +			       FIELD_PREP(MXL862XX_XPCS_CFG_USX_LANE_MODE, lane) |
> > +			       FIELD_PREP(MXL862XX_XPCS_CFG_INTERFACE, if_mode) |
> > +			       FIELD_PREP(MXL862XX_XPCS_CFG_NEG_MODE,
> > +					  mxl862xx_xpcs_neg_mode(neg_mode)) |
> > +			       FIELD_PREP(MXL862XX_XPCS_CFG_ROLE,
> > +					  MXL862XX_XPCS_ROLE_MAC) |
> > +			       FIELD_PREP(MXL862XX_XPCS_CFG_PERMIT_PAUSE,
> > +					  permit_pause_to_mac));
> > +
> > +	if (neg_mode & PHYLINK_PCS_NEG_INBAND) {
> > +		adv = phylink_mii_c22_pcs_encode_advertisement(interface,
> > +							       advertising);
> > +		if (adv >= 0)
> > +			cfg.advertising.cl37 = cpu_to_le16(adv);
> > +	}
> > +
> > +	ret = MXL862XX_API_READ(priv, MXL862XX_XPCS_PCS_CONFIG, cfg);
> 
> [Severity: High]
> Can mxl862xx_pcs_disable() on one sub-port race with mxl862xx_pcs_config() on
> another sub-port, potentially leaving the shared XPCS powered down?
> 
> mxl862xx_pcs_disable() synchronizes the hardware disable command using
> serdes_lock, but it seems mxl862xx_pcs_config() issues the firmware config
> command (which implicitly powers up the hardware) without holding
> serdes_lock. If mxl862xx_pcs_disable() executes its firmware command right
> after mxl862xx_pcs_config() executes, could this cause a permanent link failure
> on the newly configured sub-port?

Yes, mxl862xx_pcs_config() needs to hold the lock as well, I'll fix that.

> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = (s16)le16_to_cpu(cfg.result);
> > +	if (ret < 0)
> > +		return mxl862xx_xpcs_errno(ret);
> > +
> > +	mpcs->interface = interface;
> > +	return ret > 0 ? 1 : 0;
> > +}
> > +
> > +static void mxl862xx_pcs_get_state(struct phylink_pcs *pcs,
> > +				   unsigned int neg_mode,
> > +				   struct phylink_link_state *state)
> > +{
> > +	struct mxl862xx_pcs *mpcs = pcs_to_mxl862xx_pcs(pcs);
> > +	struct mxl862xx_priv *priv = mpcs->priv;
> > +	struct mxl862xx_xpcs_pcs_state st = {};
> > +	int if_mode, lane, ret;
> > +	u32 mode;
> > +	u16 bmsr;
> > +
> > +	if_mode = mxl862xx_xpcs_if_mode(state->interface);
> > +	if (if_mode < 0)
> > +		return;
> 
> [Severity: High]
> Does returning early here without setting state->link = 0 cause issues?

In practise this is not a problem as phylink prevents the function from
being called with any other interface mode than the ones defined in the
capabilities. If at all, then we should issue a WARN here.

> 
> Phylink initializes state->link = 1 before calling pcs_get_state(), expecting
> the callback to clear it if the link is down or an error occurs. Leaving it
> as 1 might cause phylink to process uninitialized parameters.
> 
> > +
> > +	lane = (state->interface == PHY_INTERFACE_MODE_10G_QXGMII) ?
> > +	       MXL862XX_XPCS_USX_QUAD : MXL862XX_XPCS_USX_SINGLE;
> > +
> > +	st.mode = cpu_to_le32(FIELD_PREP(MXL862XX_XPCS_ST_PORT_ID,
> > +					 mpcs->serdes_id) |
> > +			      FIELD_PREP(MXL862XX_XPCS_ST_INTERFACE, if_mode) |
> > +			      FIELD_PREP(MXL862XX_XPCS_ST_USX_SUBPORT,
> > +					 mpcs->slot) |
> > +			      FIELD_PREP(MXL862XX_XPCS_ST_USX_LANE_MODE, lane));
> > +
> > +	ret = MXL862XX_API_READ(priv, MXL862XX_XPCS_PCS_GET_STATE, st);
> > +	if (ret)
> > +		return;
> 
> [Severity: High]
> Could the early return here also leave state->link = 1 incorrectly when the
> firmware command fails?

Yes, and that's intentional. A failing firmware command doesn't mean that the
link went down -- it means that there has been a problem with the MDIO bus
communication with the firmware, or the specific firmware command returning an
error. As pcs-polling will retry pcs_get_state() I figure that just not touching
state->link in this case is the best thing to do.

