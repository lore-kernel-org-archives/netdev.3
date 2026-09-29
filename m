Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D52DEA68
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790661472; cv=none; b=QG2cJmsYLgJ6l0C6PcS6on1tOc0E9pRgoNbD8dktxkvQBQLFqN6SE6BnbLgPq+j1fOyTIcHjebmLnU0EYJbAR1K2w9oKCZlwiaaYyhie/DWx9RsTAlEshHxiyQ/IWqAQ/J/JglnsK+ry6XEtjMlZtObkIqH2SCkvqdJPsVYNPWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790661472; c=relaxed/simple;
	bh=8GeD1rGFh7Sr4ZZ4qudEj72V5sCZrYz5g3zvNBQtZW4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5Se/DD7t22vSGYallt/+DyV1wf9Hx6kc+GWfiB4oSAdrWMR15kfAwzdMF0B1kKWQgk36guqnS38KTZC7BCWoUk9+W1RdNXh16Z1bFgJwAIzAlX24mt1OUcaABeiS3CnOi4Kws7b88TZq0WKd0hzws3wNiwMxs++iJIsI9Z10r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxErdAJT; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxErdAJT"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so28551095e9.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790661469; x=1791266269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1GXVESBfLCGBvUWXT3oiO+mxnjJmlmx/9o26nbyYTUA=;
        b=VxErdAJT8+e0H+m0/+O1gXSc9InKpEq3StE6uy39tFEmB61rXVJoY40iEPMZVJcZaC
         McwC488APP8JYlL3PD19Grg3z3Zn9SyHSauVUAe677HAFU/Nfy1pVhK0z7gIE56RUWMC
         NxZUEorThSLhQFlpoX2QtGnbJzDA/oLNpl/6B/mQ17F707oSF4w9bxsBq6SlA9alelKn
         7k1+Okr6Ul2W2deRIg3VY8kKNnpojlXHGObXQff8WXrjAz5fQfPd7pxckI+hE0buNbeJ
         aFZbdXLFoZekEt6RDDMTC/nHSiGW75hk0fgzEiadtpnV2qcP8LqR3285dmRevHNnVPXi
         NjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790661469; x=1791266269;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1GXVESBfLCGBvUWXT3oiO+mxnjJmlmx/9o26nbyYTUA=;
        b=ZwLkCBLDGcZtOrfMRSUbfkG9yoWBQ4BdzTpwrLZq0Z1xn72SYTVpOiWsvW8Cce18KL
         zFcd9IA1qwbUtNdznwsLjIb1Hm7uKIVzP0OlPIVGQt8DhauxU53DHdlkj9acnPjsQn27
         ACdnLtKM6pEoIr5+FQnpD82Mac+uWPzUfkVXXLsBl+Oo+oPKyPVqVGCP+VwQNh/X/3bh
         8qo5k+rYzxC8Nbism07kYyz/BftvBADA9cGz3JjVK05GhVNBqKnzv1FdVsV5FgHkBGPq
         KHbxzL0vaib9MRw7Ik4c5YoFfY0mXX+fxO7MlIy9mVuK1hPlAxJz6zRk7faOYygfSyw+
         wOvQ==
X-Gm-Message-State: AFuF++mBLo5ugNipzLizDPRLGh+yx4qEswqDAQ4uai7EV15GPS4NS3gh
	QbF1/JB/2ifZkNGoxWjHLdKn28CDGkFHIb6aCazliXoJ87avpuFfylLe
X-Gm-Gg: AYBFou1/YMiRhKI4E8Qe7Q17IkCcmsKXt+ZQp1xNh9I4UVkm6PxH9EZ3CwIC/XTMLfy
	m9L6BKgCsOG+dNVxUly/6Y9MA3Sdow76HmQdXYa1169lwL+Kds0s1mwKTaem28UKpyH9p0Kne4W
	+XnAT6msRBgaWNGOt8filI3wYZr3WxeKMVyL8WV6mKAnPfl3V8sRzzxZOsuvGRFofSCtedhpqCm
	K8lB/q5HLYP0oNJ49qyzK14IFyGHiWPI04elDA7C+ATeDA3RRgb3ISGJxKkOa6Sco/doGSndfWk
	rVQzq0N0mTT004EENOMrg0eQnsWuTYZwNY7d6sUc2LF+KMOvLqw43IYVelDTR94DdtLd3EO3/QE
	fSsBZqw9vjXXDx6JxXEwWxD8Kedf5oWblsabJ5LQPhBo2ng1/BjfFf+mr3dfITGhquBOrrp31o+
	+umpOGiiWJSHZfMDRcadDySykTRCdkHhNU2UeXZmeZJesQ8nC4OtIQNrtuw6cbFqXI1/2kI3c8A
	75un6Db+sh4P3FpThwaS+UcCnNxCmCwbd/EJkSi9aJ+GG5/FdbYAyagBg==
X-Received: by 2002:a05:600c:4754:b0:49c:c96a:d36b with SMTP id 5b1f17b1804b1-49fe66d1663mr267010055e9.12.1790661468906;
        Mon, 28 Sep 2026 22:57:48 -0700 (PDT)
Received: from Ansuel-XPS. (host-82-57-191-234.retail.telecomitalia.it. [82.57.191.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf2d973sm60122945e9.0.2026.09.28.22.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 22:57:48 -0700 (PDT)
Message-ID: <6abb535c.8fb0a6ce.10321.5538@mx.google.com>
X-Google-Original-Message-ID: <artTWbIkfjiekJiR@Ansuel-XPS.>
Date: Tue, 29 Sep 2026 07:57:45 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>
Subject: Re: [PATCH net-next v4 2/3] net: dsa: qca8k: serialize CPU MAC pause
 during MTU changes
References: <20260928220811.1880-1-yongzhao.derek@gmail.com>
 <20260928220811.1880-3-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928220811.1880-3-yongzhao.derek@gmail.com>

On Tue, Sep 29, 2026 at 12:08:10AM +0200, Yongzhao Chen wrote:
> The global maximum frame size must be updated with CPU MACs disabled.
> The previous logic only paused ports 0 and 6, leaving an internal PHY
> CPU port enabled while modifying the register.
> 
> Include enabled internal CPU ports in the pause sequence. Use the
> existing reg_mutex to serialize the MTU update against port enable, port
> disable, and phylink link-up and link-down transitions. Read and restore
> each port's original TXMAC and RXMAC bits, ensuring ports that were down
> remain down and preserving LINK_AUTO. Retain existing handling for ports
> 0 and 6.
> 
> Abort before updating the frame size if reading port status or pausing
> the MAC fails. Attempt to restore all ports already modified, and report
> any restoration failures even if an earlier error occurred.
> 
> The standalone qca8k MDIO error-propagation fix is a prerequisite for
> this series; that error-handling bug predates this locking change.
> 
> Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
> Assisted-by: LLM
> ---
>  drivers/net/dsa/qca/qca8k-8xxx.c   |  2 +
>  drivers/net/dsa/qca/qca8k-common.c | 79 ++++++++++++++++++++++++------
>  2 files changed, 66 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index 89113d22d5d..7bd9d9abcef 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -1495,7 +1495,9 @@ qca8k_phylink_mac_link_up(struct phylink_config *config,
>  
>  	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
>  
> +	mutex_lock(&priv->reg_mutex);
>  	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port), reg);
> +	mutex_unlock(&priv->reg_mutex);
>  }

I'm not entirely sure we need to use the reg mutex here since each port
have their own register and is independent... a dedicated mutex should be
considered for the task...

>  
>  static struct qca8k_pcs *pcs_to_qca8k_pcs(struct phylink_pcs *pcs)
> diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
> index 13005f10edb..6b32bdd75ea 100644
> --- a/drivers/net/dsa/qca/qca8k-common.c
> +++ b/drivers/net/dsa/qca/qca8k-common.c
> @@ -463,7 +463,8 @@ int qca8k_mib_init(struct qca8k_priv *priv)
>  	return ret;
>  }
>  
> -void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
> +static void qca8k_port_set_status_locked(struct qca8k_priv *priv, int port,
> +					 int enable)

Personal taste but I always feel this might be confusing...
_locked may imply that the function will lock, not that you should lock
before calling... I know it's already pattern in the kernel, your choice to
use this or __ variant.
I would use __qca8k_port_set.. and add tag to enforce that the mutex should be
locked here.

>  {
>  	u32 mask = QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
>  
> @@ -477,6 +478,13 @@ void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
>  		regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(port), mask);
>  }
>  
> +void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
> +{
> +	mutex_lock(&priv->reg_mutex);
> +	qca8k_port_set_status_locked(priv, port, enable);
> +	mutex_unlock(&priv->reg_mutex);
> +}
> +
>  void qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset,
>  		       uint8_t *data)
>  {
> @@ -751,8 +759,10 @@ int qca8k_port_enable(struct dsa_switch *ds, int port,
>  {
>  	struct qca8k_priv *priv = ds->priv;
>  
> -	qca8k_port_set_status(priv, port, 1);
> +	mutex_lock(&priv->reg_mutex);
> +	qca8k_port_set_status_locked(priv, port, 1);
>  	priv->port_enabled_map |= BIT(port);
> +	mutex_unlock(&priv->reg_mutex);
>  

Can port be enabled concurrently and corrupt the port enable map? Can you
check with AI if this case is possible? If yes then this might be a good
idea to make a separate prereq patch introducing a dedicated mutex for
port status and protect it accordingly. (might also be worth for net)

>  	if (dsa_is_user_port(ds, port))
>  		phy_support_asym_pause(phy);
> @@ -764,14 +774,20 @@ void qca8k_port_disable(struct dsa_switch *ds, int port)
>  {
>  	struct qca8k_priv *priv = ds->priv;
>  
> -	qca8k_port_set_status(priv, port, 0);
> +	mutex_lock(&priv->reg_mutex);
> +	qca8k_port_set_status_locked(priv, port, 0);
>  	priv->port_enabled_map &= ~BIT(port);
> +	mutex_unlock(&priv->reg_mutex);
>  }

ditto.

>  
>  int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
>  {
> +	u32 mask = QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
>  	struct qca8k_priv *priv = ds->priv;
> -	int ret;
> +	u32 status[QCA8K_NUM_PORTS] = { 0 };

nit. Reverse tree.

> +	int ret, restore_ret, i;
> +	u32 stopped = 0;
> +	u32 ports;
>  
>  	/* We have only have a general MTU setting.
>  	 * DSA always set the CPU port's MTU to the largest MTU of the user
> @@ -784,25 +800,58 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
>  
>  	/* To change the MAX_FRAME_SIZE the cpu ports must be off or
>  	 * the switch panics.
> -	 * Turn off both cpu ports before applying the new value to prevent
> -	 * this.
> +	 * Include internal PHY CPU ports as well as the two MAC-only ports.
> +	 * Toggle only MAC enables, preserving the phylink link-control mode.
>  	 */
> -	if (priv->port_enabled_map & BIT(0))
> -		qca8k_port_set_status(priv, 0, 0);
> +	ports = BIT(0) | BIT(6);
> +	for (i = 1; i < 6; i++)
> +		if (dsa_is_cpu_port(ds, i))
> +			ports |= BIT(i);

In the context of internal PHY CPU port port 0 and port 6 won't be
connected... Should we check that and create a mask of the cpu port right
from the start?

>  
> -	if (priv->port_enabled_map & BIT(6))
> -		qca8k_port_set_status(priv, 6, 0);
> +	mutex_lock(&priv->reg_mutex);
> +	ports &= priv->port_enabled_map;
> +
> +	for (i = 0; i < QCA8K_NUM_PORTS; i++) {

for_each_set_bit might be better?

> +		if (!(ports & BIT(i)))
> +			continue;
> +
> +		ret = regmap_read(priv->regmap, QCA8K_REG_PORT_STATUS(i),
> +				  &status[i]);
> +		if (ret)
> +			goto unlock;
> +	}
> +
> +	for (i = 0; i < QCA8K_NUM_PORTS; i++) {

ditto.

> +		if (!(ports & BIT(i)) || !(status[i] & mask))
> +			continue;
> +
> +		stopped |= BIT(i);
> +		ret = regmap_clear_bits(priv->regmap, QCA8K_REG_PORT_STATUS(i),
> +					mask);
> +		if (ret)
> +			goto restore;
> +	}
>  
>  	/* Include L2 header / FCS length */
>  	ret = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, new_mtu +
>  			  ETH_HLEN + ETH_FCS_LEN);
>  
> -	if (priv->port_enabled_map & BIT(0))
> -		qca8k_port_set_status(priv, 0, 1);
> -
> -	if (priv->port_enabled_map & BIT(6))
> -		qca8k_port_set_status(priv, 6, 1);
> +restore:
> +	for (i = 0; i < QCA8K_NUM_PORTS; i++)
> +		if (stopped & BIT(i)) {
> +			restore_ret = regmap_update_bits(priv->regmap,
> +							 QCA8K_REG_PORT_STATUS(i),
> +							 mask, status[i] & mask);
> +			if (restore_ret) {
> +				dev_err(priv->dev, "failed to restore MAC state on port %d: %d\n",
> +					i, restore_ret);
> +				if (!ret)
> +					ret = restore_ret;
> +			}
> +		}
>  
> +unlock:
> +	mutex_unlock(&priv->reg_mutex);
>  	return ret;
>  }
>  
> -- 
> 2.43.0
> 

-- 
	Ansuel
