Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B62F617C;
	Thu,  3 Sep 2026 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788396967; cv=none; b=r+6AlFM7eDazApFjsoBBGxTFX0v9sLohM1wnEuwiIq96vKA8px9vFYawxZiRHlq9TJSON4pRKFaUbJlbvLIoN6BpiNSjwzEFm3OB3KIJk/xookxgkX/830UlyXN6Q8b1vUZ0T3jvb0OhkSMajw+wM4Hm/t+/ipxwd4cMCZraSuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788396967; c=relaxed/simple;
	bh=qHclBw6f1D5fOinDArWQ74lwndwlYzt0VwvHFMzjYZg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=duSlSkqFCZ4nd5fd4w0BG41uI9tUDEBPj4jV7SDfKpTXg/LE82MCDd8G324xcR5wur2H8+yHvzEJ+I5dILPNvFG+nQ+Yevk0AK2kv3pyEGMbSPd5j6fVSgTuIfjbSgtiYdKH+FUnQ3cHpAp35Vy5z9ZJhzlF9DKhmk+vJm/eeqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji22n6YH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji22n6YH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03E71F000E9;
	Thu,  3 Sep 2026 00:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788396965;
	bh=doUj5Uau3ZDGbBvQuu838gda3byGycRb+dWaUEufzq4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ji22n6YH1xdADbkqx4ZHGteO+chEk2O56gzhVwzYV5o3aOLWku1EK6RF2MLLaNd4R
	 B2RQHzxRepvQu9kJD4NtyZPijo12eXVqtdFd8LdyYr0b4WgnmMtV9xdnZ8VV/fome0
	 HRYRH/MC+cLlccK6S69rFNzKKtmRPHjWuJ7o9kDkwnIIsuvpeimzDGaCO2qLjIkTaw
	 JphSjFK2zJKJjiQDYksWilhCfWYGLu433OT6ExxxIaGX8MPSvakbXfiUYcxmlz5QPo
	 VujtJQc+WdrRSwE66g1dnyrfWtZsYl94bcPj4Wzx0uhXQkkhiMnsxa/8jddxi4Y3UJ
	 txFrP7KS76Ptw==
Subject: Re: [net-next,v6,3/3] w5100: detect carrier state using link status
 bit and optional interrupt
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 00:56:04 +0000
Message-ID: <178839696443.3394541.11998106403165239318@kernel.org>
In-Reply-To: <20260831-wiznet-link-gpio-v6-3-abee6c5c966e@marmottus.net>
References: <20260831-wiznet-link-gpio-v6-3-abee6c5c966e@marmottus.net>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 4 · Low: 1 (1)

- [Medium] On a W5500 whose optional LINKLED interrupt is not described
  in the device tree, the driver's two link-state interfaces permanently…
- [Medium] w5500_get_phycfgr_lnk() (line 352) converts a register-read
  failure into "link down": int ret = w5100_read(priv, W5500_PHYCFGR);…
- [Medium] w5100_remove() frees both IRQs and resets the hardware while
  the netdev is still registered and possibly UP, and uses an…
- [Medium] w5100_open() and w5100_resume() sample the PHYCFGR link bit
  and commit the carrier state *before* arming the link interrupt: if…
- [Low] The binding schema allows two `interrupts` entries for all three
  compatibles (wiznet,w5100, wiznet,w5200, wiznet,w5500) with no…

Pre-existing issues:
- [Low] The binding example specifies the main interrupt as
  `IRQ_TYPE_EDGE_FALLING` while the driver requests that same interrupt…

--

w5100: detect carrier state using link status bit and optional interrupt

This adds link detection for the w5500 by reading the Link Status bit of the
PHY Configuration register, exposes it through ethtool get_link, and wires an
optional second interrupt (LINKLED pin) to update the carrier on link
changes. It also moves register_netdev() to the end of w5100_probe() and
reworks the probe/remove unwind order.

A few questions below, plus two about the dt-bindings patch earlier in the
series.

> diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
> index 53d8dc642fbd6..d91881ecd797c 100644
> --- a/drivers/net/ethernet/wiznet/w5100.c
> +++ b/drivers/net/ethernet/wiznet/w5100.c

[ ... ]

> @@ -345,6 +349,38 @@ static void w5500_memory_configure(struct w5100_priv *priv)
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
> +		return 0;
> +	}
> +
> +	return ret & PHYCFGR_LNK;
> +}

[Severity: Medium]

Returning 0 on a failed read makes a bus error indistinguishable from a
genuine LNK=0 for every caller.  For the w5500, w5100_read() ends up in
w5500_spi_read():

drivers/net/ethernet/wiznet/w5100-spi.c:w5100_spi_read() {
	ret = spi_write_then_read(spi, cmd, sizeof(cmd), &data, 1);

	return ret ? ret : data;
}

so negative returns are reachable (spi_write_then_read() can fail with
-ENOMEM on its internal buffer, or with any controller error).

If that happens once inside w5100_open(), the else branch latches
netif_carrier_off(); inside w5100_resume() it just skips netif_carrier_on()
and the carrier stays off.  After that, the only code that ever touches the
carrier again is w5500_detect_link(), which runs on a LINKLED edge only, so
if the cable is left plugged in does the interface stay carrier-down for the
rest of its lifetime with no retry or re-read anywhere?

Would returning the error to the callers, and leaving the carrier state
unchanged on a failed read, be preferable?

One more note on the diagnostic: priv->msg_enable is never initialised in
w5100_probe() (the priv area comes from the zeroed alloc_etherdev()) and the
only writer is w5100_set_msglevel(), so netif_msg_link(priv) is false by
default and this netif_err() prints nothing unless the message level was
raised beforehand.

> +
> +static irqreturn_t w5500_detect_link(int irq, void *ndev_instance)
> +{
> +	struct net_device *ndev = ndev_instance;
> +	struct w5100_priv *priv = netdev_priv(ndev);
> +
> +	if (netif_running(ndev)) {
> +		if (w5500_get_phycfgr_lnk(ndev)) {
> +			netif_info(priv, link, ndev, "link is up\n");
> +			netif_carrier_on(ndev);
> +		} else {
> +			netif_info(priv, link, ndev, "link is down\n");
> +			netif_carrier_off(ndev);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int w5100_hw_reset(struct w5100_priv *priv)
>  {
>  	u32 rtr;
> @@ -414,6 +450,16 @@ static void w5100_get_drvinfo(struct net_device *ndev,
>  		sizeof(info->bus_info));
>  }
>  
> +static u32 w5100_get_link(struct net_device *ndev)
> +{
> +	struct w5100_priv *priv = netdev_priv(ndev);
> +
> +	if (priv->ops->chip_id == W5500)
> +		return w5500_get_phycfgr_lnk(ndev);
> +
> +	return 1;
> +}
> +

[ ... ]

> @@ -659,6 +705,15 @@ static int w5100_open(struct net_device *ndev)
>  	w5100_hw_start(priv);
>  	napi_enable(&priv->napi);
>  	netif_start_queue(ndev);
> +
> +	if (priv->link_irq < 0 || w5100_get_link(ndev))
> +		netif_carrier_on(ndev);
> +	else
> +		netif_carrier_off(ndev);

[Severity: Medium]

Since || short-circuits, w5100_get_link() is not called at all when link_irq
is negative and the carrier is unconditionally turned on.  The ethtool
callback added just above, however, keys on the chip id rather than on
link_irq:

	if (priv->ops->chip_id == W5500)
		return w5500_get_phycfgr_lnk(ndev);

The binding patch earlier in this series documents the second interrupt as
optional, so a w5500 node with a single interrupts entry leaves
fwnode_irq_get(dev_fwnode(dev), 1) returning -EINVAL, which is accepted
silently (only -EPROBE_DEFER aborts probe).

On such a board with the cable unplugged, does ip link report LOWER_UP while
ethtool reports "Link detected: no"?  With no link interrupt there is no
code path left that updates the carrier after open, so is there anything
that can reconcile the two afterwards?  Consumers that use ETHTOOL_GLINK
instead of the carrier (for example bonding with use_carrier=0 through
bond_check_dev_link()) would then see the opposite state from the stack.

The same short-circuit is repeated in w5100_resume(), so the state is
re-asserted on every resume.

The commit message says the link status on the w5500 is detected "using the
Link Status bit from the PHY Configuration register (PHYCFGR)" and that only
"On w5100/w5200, which lack this register, the link is always reported as
up."  Should the carrier decision key on chip_id, the way w5100_get_link()
already does, rather than on the presence of the interrupt?

> +
> +	if (priv->link_irq >= 0)
> +		enable_irq(priv->link_irq);

[Severity: Medium]

The link bit is sampled and the carrier committed before the LINKLED source
is armed here.  The interrupt is requested with IRQF_NO_AUTOEN, so this
first enable_irq() is what performs irq_startup(); can an edge that arrives
between the PHYCFGR read (an SPI transfer) and enable_irq() be dropped
rather than replayed by check_irq_resend()?

w5100_resume() has the same order, right after w5100_hw_reset() /
w5100_hw_start() where the PHY renegotiates, which looks like a spot where a
link-up edge is likely to land in the window.

Since w5500_detect_link() also writes the carrier from its own PHYCFGR
sample, with no lock in common with open/resume, would swapping these two
statements be sufficient on its own, or does the "sample plus carrier
update" pair need serializing against the handler (or a re-sample after
enable_irq())?

If a transition is lost here, the carrier stays stale until the next
physical link change.

> +
>  	return 0;
>  }
>  
> @@ -667,6 +722,10 @@ static int w5100_stop(struct net_device *ndev)
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
>  	netif_info(priv, ifdown, ndev, "shutting down\n");
> +
> +	if (priv->link_irq >= 0)
> +		disable_irq(priv->link_irq);
> +
>  	w5100_hw_close(priv);
>  	netif_carrier_off(ndev);
>  	netif_stop_queue(ndev);

[ ... ]

> @@ -745,13 +805,21 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
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
> +	if (priv->link_irq == -EPROBE_DEFER) {
> +		err = dev_err_probe(dev, priv->link_irq,
> +				    "failed to get link irq\n");
> +		goto err_wq;
> +	}
> +

[ ... ]

> @@ -795,21 +859,39 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
>  	if (err)
>  		goto err_hw;
>  
> +	if (priv->link_irq >= 0) {
> +		err = request_threaded_irq(priv->link_irq, NULL,
> +					   w5500_detect_link,
> +					   IRQF_TRIGGER_RISING |
> +					   IRQF_TRIGGER_FALLING |
> +					   IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					   "w5100-link", priv->ndev);
> +		if (err < 0)
> +			goto err_link_irq;
> +	}
> +
> +	err = register_netdev(ndev);
> +	if (err < 0)
> +		goto err_register;
> +
>  	return 0;
>  
> +err_register:
> +	if (priv->link_irq >= 0)
> +		free_irq(priv->link_irq, ndev);
> +err_link_irq:
> +	free_irq(priv->irq, ndev);
>  err_hw:
>  	destroy_workqueue(priv->xfer_wq);
>  err_wq:
> -	unregister_netdev(ndev);
> -err_register:
>  	free_netdev(ndev);
>  	return err;
>  }
> @@ -820,14 +902,20 @@ void w5100_remove(struct device *dev)
>  	struct net_device *ndev = dev_get_drvdata(dev);
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
> +	if (priv->link_irq >= 0) {
> +		free_irq(priv->link_irq, ndev);
> +		priv->link_irq = -ENODEV;
> +	}
> +
>  	w5100_hw_reset(priv);
>  	free_irq(priv->irq, ndev);
>  
> +	unregister_netdev(ndev);
> +

[Severity: Medium]

Both interrupts are freed and the chip is reset here while the netdev is
still registered and possibly up, and priv->link_irq = -ENODEV is used as
the only guard against the other side.  Driver unbind
(device_release_driver() -> w5100_remove()) holds no rtnl, while
w5100_open() / w5100_stop() run under rtnl, and both read priv->link_irq
with no lock, barrier or READ_ONCE/WRITE_ONCE.

Can this interleaving happen?

CPU0 (unbind, no rtnl)			CPU1 (ip link set dev down, rtnl)
w5100_remove()				w5100_stop()
					if (priv->link_irq >= 0)  /* true */
free_irq(priv->link_irq, ndev);
priv->link_irq = -ENODEV;
					disable_irq(priv->link_irq);

disable_irq() on a descriptor with no installed action leaves desc->depth
unbalanced; after a re-bind, request_threaded_irq() with IRQF_NO_AUTOEN plus
the single enable_irq() in w5100_open() would not bring the depth back to
zero, so would link detection stay dead until reboot?

The mirror case is w5100_open() calling enable_irq() on a just-freed link
irq, and running w5100_hw_start() / w5100_get_link() against a chip that
w5100_hw_reset() has already reset and whose main irq handler has already
been released by free_irq(priv->irq, ndev).  The window covers several
sleeping SPI transfers plus a synchronize_irq(), so it is not narrow.

Would calling unregister_netdev() first, before free_irq(priv->link_irq),
free_irq(priv->irq) and w5100_hw_reset(), close this?  It closes the device
under rtnl and guarantees no further ndo_ or ethtool callbacks can start,
which would also make the priv->link_irq = -ENODEV store unnecessary.

>  	flush_work(&priv->setrx_work);
>  	flush_work(&priv->restart_work);
>  	destroy_workqueue(priv->xfer_wq);
>  
> -	unregister_netdev(ndev);
>  	free_netdev(ndev);
>  }
>  EXPORT_SYMBOL_GPL(w5100_remove);

[ ... ]

> @@ -857,6 +948,12 @@ static int w5100_resume(struct device *dev)
>  		w5100_hw_start(priv);
>  
>  		netif_device_attach(ndev);
> +
> +		if (priv->link_irq < 0 || w5100_get_link(ndev))
> +			netif_carrier_on(ndev);
> +
> +		if (priv->link_irq >= 0)
> +			enable_irq(priv->link_irq);
>  	}
>  	return 0;
>  }

Two questions about the preceding dt-bindings patch in the series, commit
6a4ec8a759 ("dt-bindings: net: wiznet,w5100: add link status interrupt"):

> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> index 601d828bae927..d0717ab45de6c 100644
> --- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> +++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> @@ -24,7 +24,11 @@ properties:
>        - wiznet,w5500
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: Main interrupt (INT pin on the device).
> +      - description:
> +          Optional interrupt for link status changes (LINKLED pin on w5500).

[Severity: Low]

This relaxes the count to two entries for all three compatibles, including
wiznet,w5100 and wiznet,w5200, even though the second item's own description
says the pin only exists on the w5500, and the driver only resolves index 1
for that chip:

	priv->link_irq = ops->chip_id == W5500 ?
			 fwnode_irq_get(dev_fwnode(dev), 1) : -ENODEV;

Should this be expressed with an allOf / if-then block, so that

  if:
    properties:
      compatible:
        contains:
          enum:
            - wiznet,w5100
            - wiznet,w5200

keeps interrupts at maxItems: 1, and only wiznet,w5500 allows maxItems: 2?
As it stands a w5100/w5200 tree with a second interrupt passes
dt_binding_check while the driver ignores the line.

>  
>    reg:
>      maxItems: 1
> @@ -58,7 +62,8 @@ examples:
>              pinctrl-names = "default";
>              pinctrl-0 = <&eth1_pins>;
>              interrupt-parent = <&gpio>;
> -            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +            interrupts = <25 IRQ_TYPE_EDGE_FALLING>,
> +                         <24 IRQ_TYPE_EDGE_BOTH>;

[Severity: Low]

This isn't an issue introduced by this series, but the example describes the
main interrupt as IRQ_TYPE_EDGE_FALLING while the driver requests that same
line with a hard-coded IRQF_TRIGGER_LOW in both paths:

	err = request_threaded_irq(priv->irq, NULL, w5100_interrupt,
				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
				   dev_name(dev), ndev);
	...
	err = request_irq(priv->irq, w5100_interrupt,
			  IRQF_TRIGGER_LOW, dev_name(dev), ndev);

A non-zero IRQF_TRIGGER_ mask makes __setup_irq() call __irq_set_trigger()
and reprogram the controller, so the type from the device tree is
discarded.  The same example text came from the deleted
Documentation/devicetree/bindings/net/wiznet,w5x00.txt.  Since the file is
being touched anyway, is it worth aligning the example with what the driver
actually programs?  The second entry is consistent, IRQ_TYPE_EDGE_BOTH
matches IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING.

>              spi-max-frequency = <30000000>;
>              local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
>          };

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-wiznet-link-gpio-v6-0-abee6c5c966e%40marmottus.net
