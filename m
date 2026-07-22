Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F94457C2;
	Wed, 22 Jul 2026 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745863; cv=none; b=ECqn00zZcyK3UEdbYTBIGogHmBZcQUnd66Pz2AdUsEKSAL/8lTC5url21kjtlN3QRupRJ/nsDs08+LMMckHLtfT93hNewkx2mToQNGCWYoN5y27rMlfZaYG+p/TX4WfLLptC1ynMLi4G3hPVNp6moUdUNDQsAlR/bdu8ec3N8Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745863; c=relaxed/simple;
	bh=3nH9saLZ18RFCsQfSJql80tdJ0vsONDbRsbB7IH2j5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/4BU3LfNqTUULeZF1Qq0d4ylGI59b2r7ye8uPlNR3vEKN+BIe3c+jN3+/InOiT0ahT4xSz3c6qVuj2EYrPlI/rn6bGERHlkLJ1nbICIHeMGDB4oUGu1YTPQoGMG0RO0Ut2XAYwIC7r+EGokMKP5nEqJISkboXPPqYnRmOvJntY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EI414KpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EI414KpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B141F000E9;
	Wed, 22 Jul 2026 18:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784745862;
	bh=fg6TkAjDxFRHs44IEzWoVJKPbz4qlnAAPW4Jc5CEMK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EI414KpCTU1ZICWxIzlX65cOmDrvF2sieTRgBqzW43gRp1fvZOXhYwoXpkMr06hSj
	 nVmPBhH42VXH2GoJ7Kjrj7h2GYXk/fkrIQRzBR/tm/k5Fbb9lPbuobxiVOQxjZN442
	 K9wGZr9qS894dPIiHYsVsWf3A+8mohUzxVJj8zeorKJX+qdy5FJxr6P12fkOke+zCf
	 KM8SBxh48uhZixBtUlkVjAo1pdWauVtyDD7i39W9vBLEBYT95zNRbCj34ZR2ldAa0D
	 oi4afCiv9t+TWDIpEeM/LMJknxquy++iea4AgS4io4ahIap0sndcZku8aS/GomESgX
	 ikZOd7qpipB5g==
From: Jakub Kicinski <kuba@kernel.org>
To: maimon.sagi@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 1/1] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
Date: Wed, 22 Jul 2026 11:44:18 -0700
Message-ID: <20260722184418.266546-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716132939.5377-1-maimon.sagi@gmail.com>
References: <20260716132939.5377-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ptp: ocp: add CPLD ISP support for ADVA TimeCard X1

This patch adds sysfs interfaces (i2c_bus_ctrl and cpld_i2c_xfer) on the
ADVA TimeCard X1 variant so userspace can program the Lattice MachXO3
CPLD over a shared I2C bus.  A new mutex, adapter-number cache and
response buffer are added to struct ptp_ocp for the passthrough path.

A few questions inline.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 35e911f1ad78..91fa06f0e44c 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -4224,6 +4230,205 @@ static const struct ocp_attr_group art_timecard_groups[] = {
>  	{ },
>  };
>  
> +/*
> + * i2c_bus_ctrl exposes the MicroBlaze I2C bus arbitration register.

[Low]
Should Documentation/ABI/testing/sysfs-timecard grow entries for the two
new attributes added here (i2c_bus_ctrl and cpld_i2c_xfer)?  The other
timecard sysfs files are described there, and cpld_i2c_xfer in
particular defines a private binary protocol (header layout, allowed
slave addresses, response-buffer semantics) that userspace cannot
discover from the filesystem alone.

[ ... ]

> @@ -4902,6 +5114,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>  		clk_hw_unregister_fixed_rate(bp->i2c_clk);
>  	if (bp->n_irqs)
>  		pci_free_irq_vectors(bp->pdev);
> +	mutex_destroy(&bp->tap_i2c_lock);
>  	device_unregister(&bp->dev);
>  }

[Medium]
Is mutex_destroy() here always called on an initialised mutex?

Looking at ptp_ocp_probe() below, mutex_init(&bp->tap_i2c_lock) runs
only after pci_alloc_irq_vectors() succeeds:

	err = pci_alloc_irq_vectors(pdev, 1, 17, PCI_IRQ_MSI | PCI_IRQ_MSIX);
	if (err < 0) {
		dev_err(&pdev->dev, "alloc_irq_vectors err: %d\n", err);
		goto out;
	}
	bp->n_irqs = err;
	pci_set_master(pdev);

	mutex_init(&bp->tap_i2c_lock);
	bp->tap_i2c_adap_nr = -1;

If pci_alloc_irq_vectors() fails, the "goto out" reaches
ptp_ocp_detach(), which now unconditionally calls
mutex_destroy(&bp->tap_i2c_lock) on a bp that was zero-initialised by
devlink_alloc().

With CONFIG_DEBUG_MUTEXES=y, mutex_destroy() checks lock->magic and
would splat via DEBUG_LOCKS_WARN_ON(lock->magic != lock) on that error
path.

Would it be simpler to move the mutex_init() (and the tap_i2c_adap_nr
= -1 assignment) earlier, e.g. right after ptp_ocp_device_init()
succeeds, so every path that reaches ptp_ocp_detach() sees an
initialised mutex?

> @@ -5093,6 +5306,14 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	bp->n_irqs = err;
>  	pci_set_master(pdev);
>  
> +	/* Initialise before ptp_ocp_register_resources() so that the I2C bus
> +	 * notifier (ptp_ocp_i2c_notifier_call) cannot fire and write
> +	 * tap_i2c_adap_nr before ptp_ocp_adva_board_init() overwrites it
> +	 * with -1, leaving the adapter number lost for the device lifetime.
> +	 */
> +	mutex_init(&bp->tap_i2c_lock);
> +	bp->tap_i2c_adap_nr = -1;
> +
>  	err = ptp_ocp_register_resources(bp, id->driver_data);
>  	if (err)
>  		goto out;

[Low]
Does this comment describe what the code actually does?

The comment says the ordering matters because
ptp_ocp_adva_board_init() would otherwise overwrite tap_i2c_adap_nr
with -1.  Looking at ptp_ocp_adva_board_init(), it only touches
flash_start, eeprom_map, sma_op, signals_nr, freq_in_nr, fw_tag,
fw_version, fw_cap and calls a couple of sub-init routines.  The -1
assignment is done here in ptp_ocp_probe() directly, not in
ptp_ocp_adva_board_init().

Should the comment be reworded to refer to the actual initialiser?

[ ... ]
-- 
pw-bot: cr
