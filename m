Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2A559CA3;
	Wed,  9 Sep 2026 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957547; cv=none; b=LPTKn4Ub1ai7O1ozVLbsg2yJpvIvQHvwsPWux7bCrzvWkkhXvKRTw5ZAt2EJVD0Z68WDptq29efaeFNntKXaN+2oAGGhu5skKqtettkE9H+WXqZXJNTJr4ZxyYqYeG2DRq+qJggUbandzb1bUHdUvm8pdbPrPhfJKVMk6tfFL2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957547; c=relaxed/simple;
	bh=IdcxEiGmXAdQ2pJO0tkiHtsxWR5Mqusn6wl8E+jTwYI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j9Knt+g4GKxrNk6add5Qit6d3bRrxwGHhl7lP8Gi5V7ssgL2/mNm9ILVjtIrL3MyovlCBCgg+w0/blrOgWZlpCTVl4eDSPdfGSrVAa1vUS2ep4lEyRLvxawySaEJzlgyCq6m/nUe9a/fInByydJCVW7BMijTX9ra4zCLa8sMsbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyYlQj/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyYlQj/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D6A1F00A3E;
	Wed,  9 Sep 2026 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957542;
	bh=tSIaSL0ymmmaxqC51K3SNloZqopwpchw+uADipbUbhk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iyYlQj/lDMy6UbCX088wWUj+cITAJa4/z7FGrbvlw2NoxMQW/xVAxyd2AYhUQO/YY
	 I5MZQimghmrYmmNcJsdkFe4RwloKl4NWSjFjQg0KzUeiqrcAJFu0+NFY5wgF9/6t2g
	 02CgqHDbStOBeSqzryupNmu9I3ikEIJ4Qm+Uo3z0ZnlKIyzRMhZ1/NQZVQ6C1/H9Nf
	 DZ9YPSWMicQ4AwOM9CG1+FrzcPOtaT6qBm9lCMbq+3LRxL5JKy3c6/DrwLOkUOhf5N
	 GUEtBVNHGP42SbMtn+qIsaiDDLjB7ZvGXKtIijLLfcueZjKJxL3mckPGt6cH30UuJW
	 CWuOexNYEQ4xw==
Subject: Re: [PATCH net-next v7 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@oss.qualcomm.com
Date: Wed, 09 Sep 2026 12:39:01 +0000
Message-ID: <178895754151.219967.10801079239966954315@kernel.org>
In-Reply-To: <20260904-wiznet-link-gpio-v7-3-69f01b70c96f@marmottus.net>
References: <20260904-wiznet-link-gpio-v7-3-69f01b70c96f@marmottus.net>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 1

- [High] On w5500 the carrier state is now sampled exactly once per ifup
  (and once per resume) from PHYCFGR, with no polling fallback and no…
- [Medium] `w5500_get_phycfgr_lnk()` returns a tri-state value (<0 on
  SPI/register read error, 0 link down, 1 link up), and its consumers…
- [Medium] The carrier state is computed and published by two
  unsynchronized contexts.
- [Low] The YAML binding added earlier in this series
  (Documentation/devicetree/bindings/net/wiznet,w5100.yaml, commit "dt-…

--

w5100: detect carrier state using link status bit and optional interrupt

This adds link detection on the w5500 by reading the Link Status bit of
the PHY Configuration register, and adds an optional second interrupt
(LINKLED) to notice link changes. The netdev is now registered as the
last step of w5100_probe(), and the link interrupt is enabled/disabled
in open/stop and resume/suspend.

A few questions about the carrier handling below.

> diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
> index 53d8dc642fbd6..ecb99621d0a1e 100644
> --- a/drivers/net/ethernet/wiznet/w5100.c
> +++ b/drivers/net/ethernet/wiznet/w5100.c

[ ... ]

> @@ -345,6 +349,44 @@ static void w5500_memory_configure(struct w5100_priv *priv)
>  	}
>  }
>  
> +static int w5500_get_phycfgr_lnk(struct net_device *ndev)
> +{
> +	struct w5100_priv *priv = netdev_priv(ndev);
> +	int ret = w5100_read(priv, W5500_PHYCFGR);
> +
> +	if (ret < 0) {
> +		netif_err(priv, link, ndev,
> +			  "failed to read link status: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret & PHYCFGR_LNK;
> +}
> +
> +static irqreturn_t w5500_detect_link(int irq, void *ndev_instance)
> +{
> +	struct net_device *ndev = ndev_instance;
> +	struct w5100_priv *priv = netdev_priv(ndev);
> +	int state;
> +
> +	if (!netif_running(ndev))
> +		return IRQ_HANDLED;
> +
> +	state = w5500_get_phycfgr_lnk(ndev);
> +	if (state < 0)
> +		return IRQ_HANDLED;
> +
> +	if (state) {
> +		netif_info(priv, link, ndev, "link is up\n");
> +		netif_carrier_on(ndev);
> +	} else {
> +		netif_info(priv, link, ndev, "link is down\n");
> +		netif_carrier_off(ndev);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +

[ ... ]

> @@ -414,6 +456,16 @@ static void w5100_get_drvinfo(struct net_device *ndev,
>  		sizeof(info->bus_info));
>  }
>  
> +static u32 w5100_get_link(struct net_device *ndev)
> +{
> +	struct w5100_priv *priv = netdev_priv(ndev);
> +
> +	if (priv->ops->chip_id == W5500)
> +		return w5500_get_phycfgr_lnk(ndev) > 0;

[Severity: Medium]
Does the "> 0" here turn a register read failure into a definite "link
down"?

w5500_get_phycfgr_lnk() returns three distinct things: a negative errno,
0 for link down and 1 for link up.  w5500_spi_read() can really return an
error, since it propagates spi_write_then_read():

	return ret ? ret : data;

w5500_detect_link() deliberately leaves the carrier alone in that case:

	state = w5500_get_phycfgr_lnk(ndev);
	if (state < 0)
		return IRQ_HANDLED;

but w5100_get_link() folds the errno into 0, so w5100_open() will call
netif_carrier_off() on a transient SPI failure even when the link is up,
and w5100_resume() (which has no else branch) will leave the carrier off.
The same lossy mapping is what the newly added ethtool .get_link reports,
so an SPI error shows up as "Link detected: no".

Would it be better to keep the error case out of the carrier decision, the
way the interrupt handler does?

> +
> +	return 1;
> +}
> +

[ ... ]

> @@ -659,6 +711,15 @@ static int w5100_open(struct net_device *ndev)
>  	w5100_hw_start(priv);
>  	napi_enable(&priv->napi);
>  	netif_start_queue(ndev);
> +
> +	if (priv->link_irq >= 0)
> +		enable_irq(priv->link_irq);
> +
> +	if (w5100_get_link(ndev))
> +		netif_carrier_on(ndev);
> +	else
> +		netif_carrier_off(ndev);

[Severity: High]
Can the interface end up permanently NO-CARRIER on a w5500 board whose
device tree only declares the single INT interrupt?

The second (LINKLED) interrupt is optional and is introduced by this
series, so on existing device trees w5100_probe() does:

	priv->link_irq = ops->chip_id == W5500 ?
			 fwnode_irq_get(dev_fwnode(dev), 1) : -ENODEV;

fwnode_irq_get() returns a negative value for index 1, no link interrupt
is requested, and every "if (priv->link_irq >= 0)" site is skipped.

That leaves the sample taken here as the only carrier update for the whole
lifetime of the ifup.  If PHYCFGR.LNK reads 0 at that moment (cable not
plugged, or auto-negotiation not finished yet after the reset done in
w5100_probe() -> w5100_hw_reset()), netif_carrier_off() is called and
nothing turns it back on: the only netif_carrier_on() call sites are
w5500_detect_link(), w5100_open() and w5100_resume(), and there is no
timer or delayed work polling PHYCFGR.

Before this patch the w5500 carrier was never cleared at ifup, so is this
a behaviour change for existing w5500 device trees, where a link that
comes up after ifup is never noticed until the user bounces the interface?

The commit message says:

	"The interrupt is only needed to detect subsequent link changes."

Could this state that without the interrupt there is no detection of
subsequent link changes at all, including the initial link-up?

[Severity: Medium]
Separately, does the ordering of enable_irq() and the PHYCFGR sample here
allow the threaded handler's newer verdict to be overwritten by an older
one?

__dev_open() sets __LINK_STATE_START before calling ndo_open, so
netif_running() is already true and the early bail in w5500_detect_link()
does not exclude a concurrent run.  enable_irq() can also replay an edge
that arrived while the line was masked:

w5100_open()
	enable_irq(priv->link_irq);
	w5100_get_link()	  /* sleeping SPI read, old value */

			w5500_detect_link()	 /* newer PHYCFGR value */
				netif_carrier_on(ndev);

	netif_carrier_off(ndev);  /* overwrites with the stale sample */

Nothing serializes the read-and-publish pair: the handler takes no lock,
open holds only RTNL which the IRQ thread never takes, and struct
w5100_priv has no lock covering the carrier update.  With edge-only
notification and no polling, the wrong state then persists until the link
toggles again.

w5100_resume() has the same enable-then-sample order and only ever calls
netif_carrier_on(), so a "down" seen by the handler can be discarded.

Note the teardown paths do it the other way around and disable_irq()
first, which does synchronize with the threaded handler.

> +
>  	return 0;
>  }
>  

[ ... ]

> @@ -745,13 +811,21 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
>  		break;
>  	default:
>  		err = -EINVAL;
> -		goto err_register;
> +		goto err_wq;
>  	}
>  
>  	priv->ndev = ndev;
>  	priv->ops = ops;
>  	priv->irq = irq;
>  
> +	priv->link_irq = ops->chip_id == W5500 ?
> +			 fwnode_irq_get(dev_fwnode(dev), 1) : -ENODEV;

[Severity: Low]
This isn't a bug in the C code, but does the binding added earlier in the
series match this restriction?

Documentation/devicetree/bindings/net/wiznet,w5100.yaml describes the
interrupts as:

  interrupts:
    minItems: 1
    items:
      - description: Main interrupt (INT pin on the device).
      - description:
          Optional interrupt for link status changes (LINKLED pin on w5500).

with no allOf/if-then keyed on the compatible string, so wiznet,w5100 and
wiznet,w5200 nodes may declare two interrupts and still pass
dt_binding_check.  Here index 1 is only looked up for chip_id == W5500, so
such a line is silently ignored (priv->link_irq stays -ENODEV).

Would an if-then block limiting the second interrupt to wiznet,w5500 (or
honouring the second interrupt for all parts) express this better?  The
w5500-only restriction is currently only in free-form description text,
which validation does not enforce.

> +	if (priv->link_irq == -EPROBE_DEFER) {
> +		err = dev_err_probe(dev, priv->link_irq,
> +				    "failed to get link irq\n");
> +		goto err_wq;
> +	}
> +

[ ... ]

> @@ -839,6 +931,9 @@ static int w5100_suspend(struct device *dev)
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
>  	if (netif_running(ndev)) {
> +		if (priv->link_irq >= 0)
> +			disable_irq(priv->link_irq);
> +
>  		netif_carrier_off(ndev);
>  		netif_device_detach(ndev);
>  
> @@ -857,6 +952,12 @@ static int w5100_resume(struct device *dev)
>  		w5100_hw_start(priv);
>  
>  		netif_device_attach(ndev);
> +
> +		if (priv->link_irq >= 0)
> +			enable_irq(priv->link_irq);
> +
> +		if (w5100_get_link(ndev))
> +			netif_carrier_on(ndev);
>  	}
>  	return 0;
>  }

Since suspend unconditionally clears the carrier and resume only sets it
when this single read reports link, is there any path that re-asserts the
carrier later when there is no link interrupt or when the PHYCFGR read
fails here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-wiznet-link-gpio-v7-0-69f01b70c96f%40marmottus.net
