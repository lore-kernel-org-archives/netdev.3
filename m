Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5129B766;
	Mon,  7 Sep 2026 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788820125; cv=none; b=Isdu8FgHDVvuojB4r6LTLHc1fLP50ijp/+FBK3qd9XT6O5FHk0EFcNrctaMPvV/O9e9zUx3Ti+i2diDmGMeg2USRgNLbGOZ3Q4K4ofIKzvvFKOqmY55W0TjEV30iFvG//MamIgWYuXhALvQtWIK/u9SnGkbNYi1zQuSzPkHa7oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788820125; c=relaxed/simple;
	bh=okZP9YA8of/dppP99bLktXk24pN3bXeDO5/37rESBwo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0IrvWBqcHj41oM4WA1kxw5TCDVO2efY1yWGdn1oRgyKa1/JQG3JKDQQT3jihjH7od/pV1GbTmwnimUyPHBe3k8zrXHmanyA/HK8sBOL8E60wxa+bQk/tzQcMg/VJMwweLlRa/ncRPmXtooPhQPUkYTY+R2OTs0AsovwmZLNq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLsCg+pp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLsCg+pp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CF51F00A3A;
	Mon,  7 Sep 2026 22:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788820124;
	bh=uWvwo68q0NiNc9fVhinIy0eFRzsHQNVbNmrCZS9XcMo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lLsCg+pp8pIi8dXNlao2ibO+D5LwxEnDKcbLC39blku54J243+/c5Vmro+lWuRKAN
	 E2GAqmXC1XmMDrACulrCvrZlIRIsz7MN0BoHdv9Kt8NqzLhHE0y15fsQ507KeFcZbh
	 pUudh6VlmDcDE04Xo26Iuob3GQYzt6C5G3nE7jO8xOfqwcnTbpIJgB6PnNBYpiRpLV
	 MOpAkOO/NIUlnBi/F+42ms+W7DfYk6LvSBvs/gzFCPo75DCvptT48SVSFO4KKmRnbv
	 dmFyGzPiEthtKD60mKISiRt95q6HGRwP2QIKmuovmzi7Wy9YsMGIQbbaYkp/JTlD95
	 ssEAcJlWZHstw==
Subject: Re: [PATCH net-next v2] net: davicom: Propagate wakeup IRQ errors
From: netdev-bot+sashiko@kernel.org
To: phucduc.bui@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, paul@crapouillou.net,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 07 Sep 2026 22:28:43 +0000
Message-ID: <178882012336.219967.15894359577050376625@kernel.org>
In-Reply-To: <20260903102656.370039-1-phucduc.bui@gmail.com>
References: <20260903102656.370039-1-phucduc.bui@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 2 (2) · Medium: 0 · Low: 0 (1)

- [High] dm9000_probe() now aborts the whole probe when the *optional*
  wakeup-IRQ setup fails.
- [High] The newly added 'goto out' after a failing
  irq_set_irq_wake(db->irq_wake, 1) is taken while…

Pre-existing issues:
- [High] The wakeup IRQ requested in dm9000_probe() is never released on
  any path other than the newly added one either: the pre-existing later…
- [High] In dm9000_probe() the shared wakeup IRQ is requested (line 1521,
  IRQF_SHARED, handler dm9000_wol_interrupt, dev_id = ndev) before…
- [Low] Documentation/devicetree/bindings/net/davicom,dm9000.yaml
  restricts 'interrupts' to 'maxItems: 1' (and defines no interrupt-…

--

net: davicom: Propagate wakeup IRQ errors

This changes dm9000_probe() so that an error from
platform_get_irq_optional(pdev, 1) is returned to the caller unless it is
-ENXIO, and so that failures of request_irq() and irq_set_irq_wake() for
the optional wakeup IRQ abort the probe instead of only being logged.

A few questions about the new error paths below.

> diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
> index b87eaf0c250c..904b859f0a63 100644
> --- a/drivers/net/ethernet/davicom/dm9000.c
> +++ b/drivers/net/ethernet/davicom/dm9000.c
> @@ -1511,13 +1511,18 @@ dm9000_probe(struct platform_device *pdev)
>  	}
>  
>  	db->irq_wake = platform_get_irq_optional(pdev, 1);
> -	if (db->irq_wake >= 0) {
> +	if (db->irq_wake < 0 && db->irq_wake != -ENXIO) {
> +		ret = db->irq_wake;
> +		goto out;
> +	}
> +	if (db->irq_wake > 0) {

[Severity: Low]
This is a pre-existing inconsistency and not something introduced here, but
is the wakeup IRQ index reachable at all from device tree?

Documentation/devicetree/bindings/net/davicom,dm9000.yaml declares:

  interrupts:
    maxItems: 1

and defines no interrupt-names.  For a node that validates against that
schema, index 1 does not exist, so of_irq_get() fails and
platform_get_irq_affinity() falls back to platform_get_resource(), which
returns NULL and produces -ENXIO.  That is exactly the value the new check
tolerates, so on schema-compliant device trees the whole wakeup block that
this patch hardens is skipped.

Should the binding gain a second interrupt entry (with interrupt-names) so
the driver and the documented contract agree on how many interrupts a
davicom,dm9000 node may declare?

>  		dev_dbg(db->dev, "wakeup irq %d\n", db->irq_wake);
>  
>  		ret = request_irq(db->irq_wake, dm9000_wol_interrupt,
>  				  IRQF_SHARED, dev_name(db->dev), ndev);
>  		if (ret) {
>  			dev_err(db->dev, "cannot get wakeup irq (%d)\n", ret);
> +			goto out;

[Severity: High]
Is it intended that a failure to set up an optional feature now takes down
the whole netdev?

request_irq() here uses IRQF_SHARED, so it can legitimately return -EBUSY
when a non-shared handler already owns that line.  Before this change the
failure was logged, db->wake_supported stayed 0, and the interface
registered normally; dm9000_set_wol() then simply refused WoL:

	if (!dm->wake_supported)
		return -EOPNOTSUPP;

With the new goto out, register_netdev() is never reached and such a board
loses Ethernet entirely.  Would it be better to keep the graceful
degradation for the two setup failures and only propagate the
platform_get_irq_optional() error (which is where -EPROBE_DEFER matters)?

[Severity: High]
This ordering isn't introduced by this patch, but can the shared wake
handler run before the register window exists?

request_irq() installs dm9000_wol_interrupt() here, while db->io_addr and
db->io_data are only filled in later in dm9000_probe():

	db->io_addr = ioremap(db->addr_res->start, iosize);
	...
	db->io_data = ioremap(db->data_res->start, iosize);

db comes from alloc_etherdev()/netdev_priv() and is zeroed, so both
pointers are NULL in that window.  The handler starts with MMIO
immediately:

	nsr = ior(db, DM9000_NSR);
	wcr = ior(db, DM9000_WCR);

and ior() has no guard:

	writeb(reg, db->io_addr);
	return readb(db->io_data);

Since the line is shared, a co-tenant device (or an already-asserted
level-triggered line at request time) can invoke this and dereference NULL
in hard-IRQ context.  Would moving the wake-IRQ request to after the
ioremap()/dm9000_set_io() sequence close this, and at the same time make
the new error paths easier to unwind?

>  		} else {
>  
>  			/* test to see if irq is really wakeup capable */
> @@ -1525,6 +1530,7 @@ dm9000_probe(struct platform_device *pdev)
>  			if (ret) {
>  				dev_err(db->dev, "irq %d cannot set wakeup (%d)\n",
>  					db->irq_wake, ret);
> +				goto out;

[Severity: High]
The comment right above this call describes the operation as a capability
test:

	/* test to see if irq is really wakeup capable */
	ret = irq_set_irq_wake(db->irq_wake, 1);

Is a non-zero return really an error condition here?  set_irq_wake_real()
in kernel/irq/manage.c starts with:

	int ret = -ENXIO;

	if (irq_desc_get_chip(desc)->flags &  IRQCHIP_SKIP_SET_WAKE)
		return 0;

	if (desc->irq_data.chip->irq_set_wake)
		ret = desc->irq_data.chip->irq_set_wake(&desc->irq_data, on);

so -ENXIO is the normal result for any irqchip that implements no
.irq_set_wake and is not flagged IRQCHIP_SKIP_SET_WAKE, which covers many
simple platform, SoC and GPIO controllers.  On such a board the probe now
fails where it previously succeeded with WoL disabled.

[Severity: High]
Can this goto out leave the wake handler registered on a freed net_device?

At this point request_irq(db->irq_wake, dm9000_wol_interrupt, IRQF_SHARED,
dev_name(db->dev), ndev) has already succeeded, but the unwind path is:

out:
	dev_err(db->dev, "not found (%d).\n", ret);

	dm9000_release_board(pdev, db);
	free_netdev(ndev);

and dm9000_release_board() does no IRQ teardown at all:

	iounmap(db->io_addr);
	iounmap(db->io_data);

	if (db->data_req)
		release_resource(db->data_req);
	kfree(db->data_req);
	...

The only free_irq() in the driver is free_irq(ndev->irq, ndev) in
dm9000_stop(), so nothing releases db->irq_wake.  After free_netdev(ndev)
the shared handler is still installed with dev_id pointing at the freed
net_device, and any assertion of that line runs:

	struct net_device *dev = dev_id;
	struct board_info *db = netdev_priv(dev);
	...
	spin_lock_irqsave(&db->lock, flags);

	nsr = ior(db, DM9000_NSR);

which touches freed memory and does MMIO through the already-iounmapped
bases in hard-IRQ context.  Should this path get its own label that calls
free_irq(db->irq_wake, ndev) before dm9000_release_board()?

[Severity: High]
This isn't a bug introduced by this patch, but the same missing free_irq()
applies to the paths that already existed.  The later goto out failures in
dm9000_probe() (request_mem_region() or ioremap() failure, unknown chip ID,
register_netdev() failure), for example:

	if (db->addr_req == NULL) {
		dev_err(db->dev, "cannot claim address reg area\n");
		ret = -EIO;
		goto out;
	}

and dm9000_drv_remove():

	unregister_netdev(ndev);
	dm9000_release_board(pdev, dm);
	if (dm->power_supply)
		regulator_disable(dm->power_supply);

	free_netdev(ndev);		/* free device structure */

all reach free_netdev(ndev) while dm9000_wol_interrupt() is still
registered with dev_id = ndev, so an unbind or rmmod of a device that has a
wake IRQ leaves a dangling handler on a shared line.  Would it make sense
to add the wake-IRQ release in a helper shared between the probe error
paths and remove()?

>  			} else {
>  				irq_set_irq_wake(db->irq_wake, 0);
>  				db->wake_supported = 1;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903102656.370039-1-phucduc.bui%40gmail.com
