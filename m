Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6C44E0B79;
	Tue, 13 Oct 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889084; cv=none; b=U2pYgYNTm0Gt3dg1sf2kLoEoTpRsI6ciXBkNRE5sOp5V7d4SRSQ2Z1Jp5Nh5h3Omnxmu0SzU2puf2+nmlQiKuyJPknrg3bJh2VBzI6vTdTnUZQmRZc8Cnr5ZxU78ctSx5keqmy58cdwM7wcRim3mAEtl00yX7ahPrO1WLeZZNnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889084; c=relaxed/simple;
	bh=Z4KJuwgsZ39MB4mm98MJBYX75Wce9AeK6S8qxmXdcBc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xs1R/EJmoB8O1Xq42DAFpOr2COVwDdqTzwK0+v/FLNylwkXsD6iw4dM40K2l/VhGyYcv96qlMHTi1XneX+sy/C5PjJjD85SkwjeCzXS5qh2OIgvmxUNMmtaIibBP8y4z+eIZMuIFuk/4JRsvXgvFj5U/17eQoVpulJitOSQl0nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDM2u2u6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDM2u2u6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B881F00898;
	Tue, 13 Oct 2026 10:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791889072;
	bh=oXLSiEF0IbD5c5Y/dirPwQYZ27Ijc9UIrfKVhG9lics=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NDM2u2u68Vrs4dIlY6eEnOWD5LQ43rY0JHUxZsTwFnxNcLaYqhfFN5XHx9Ki8LxJQ
	 kFcXgTqwrZdtv1hjYXOGJZM6XNVwIKjDnQzIDrhdJ5R/lO+kxtJCMMjDqeSxnB3Kbc
	 DuhCSi/YbU/GQfuzuMUdHTLV+7WZ3/dSfkrNTAGp7LFOGPnWsLnYQPYoq/sotFQwe/
	 Q8oDsf5OCnbq4a1Je9L4cfBHRGIr8VoVT8147YrN71qmVijXTXH7YZoEXJCyed8ZEN
	 wlGwfxN6DrpXOwgEZ4D8QsZI+f9+4AQYIHQwFeQlTn5BC0kcNi+o6rZhMRE6GRDUBG
	 JlxgxcT5enpGQ==
Subject: Re: [PATCH v5 net-next 4/9] net: dsa: netc: tie setup resources and
 reset to DSA setup/teardown
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, linusw@kernel.org, wei.fang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 13 Oct 2026 10:57:51 +0000
Message-ID: <179188907149.434549.9657555602480791517@kernel.org>
In-Reply-To: <20261012095924.1129312-5-wei.fang@oss.nxp.com>
References: <20261012095924.1129312-5-wei.fang@oss.nxp.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] netc_setup() now calls pci_reset_function(A->pdev) whenever
  A->in_probe is false.
- [Medium] priv->in_probe is a plain bool.
- [Medium] Moving the initial reset from before pcim_enable_device() into
  netc_setup() means pci_set_master() (netc_switch_pci_init(), line…

--

net: dsa: netc: tie setup resources and reset to DSA setup/teardown

This patch replaces the one-time pcie_flr() in probe with a
netc_switch_reset() call at the start of netc_setup(). The reset uses
pci_reset_function_locked() during probe and pci_reset_function()
otherwise. It also converts the devm_ allocations on the setup path to
explicit alloc/free, so their lifetime matches DSA setup and teardown.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 77077352c1a57..c639ae67c9b71 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c

[ ... ]

> +static int netc_switch_reset(struct netc_switch *priv)
> +{
> +	if (priv->in_probe)
> +		return pci_reset_function_locked(priv->pdev);
> +
> +	return pci_reset_function(priv->pdev);
>  }

[Severity: High]
Can the pci_reset_function() branch deadlock against unbind in the
multi-switch case this patch is preparing for?

In a multi-switch tree, ds->ops->setup() runs under dsa2_mutex for every
switch in the tree, including switches that are already bound:

dsa_register_switch(B)
  mutex_lock(&dsa2_mutex)
  dsa_switch_probe()
    dsa_tree_setup()
      ...
        netc_setup(A)
          netc_switch_reset(A)
            pci_reset_function(A->pdev)
              pci_dev_lock(A->pdev)    /* device_lock(A) */

The remove path takes the same two locks in the opposite order, because
the driver core already holds device_lock(A) when it calls the driver:

device_release_driver(A)           /* holds device_lock(A) */
  netc_switch_remove()
    dsa_unregister_switch()
      mutex_lock(&dsa2_mutex)

Shutdown has the same ordering through
netc_switch_shutdown()->dsa_switch_shutdown().

If CPU0 is probing switch B while CPU1 is unbinding switch A, would both
threads hang forever? Re-probing A while B is being unbound looks like
the same inversion with the roles swapped.

device->mutex uses lockdep_set_novalidate_class(), so lockdep would not
report this.

This code is still the same at the end of the series. Should this
branch use a different approach, rather than resetting another switch
under its device lock from inside .setup while dsa2_mutex is held?

>  static int netc_setup(struct dsa_switch *ds)
> @@ -875,6 +957,10 @@ static int netc_setup(struct dsa_switch *ds)
>  	struct dsa_port *dp;
>  	int err;
>  
> +	err = netc_switch_reset(priv);
> +	if (err)
> +		return err;
> +
>  	err = netc_init_switch_id(priv);
>  	if (err)
>  		return err;

[ ... ]

> @@ -1045,7 +1136,6 @@ static int netc_switch_pci_init(struct pci_dev *pdev)
>  	void __iomem *base;
>  	int err;
>  
> -	pcie_flr(pdev);
>  	err = pcim_enable_device(pdev);
>  	if (err)
>  		return dev_err_probe(dev, err, "Failed to enable device\n");

[Severity: Medium]
Now that pcie_flr() is gone from here, netc_switch_pci_init() calls
pci_set_master() before the switch has been reset. The first reset now
comes much later. It happens after netc_switch_get_ip_revision() and
netc_switch_platform_probe(), once dsa_register_switch() reaches
netc_setup().

Is that ordering safe after a kexec? pci_device_shutdown() only clears
bus mastering:

	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
		pci_clear_master(pci_dev);

netc_switch_shutdown()->dsa_switch_shutdown() does not call
netc_teardown() or ntmp_free_cbdr(). Also, netc_xmit_ntmp_cmd() can
return on a read_poll_timeout() expiry after it has already advanced the
producer index.

The switch could then keep enabled command BD rings with a pending
command that points at the previous kernel's DMA addresses. If the
hardware resumes fetching as soon as bus mastering is set again, could
it access memory the new kernel has reused? With an IOMMU, would it
cause faults instead?

Also, if probe fails between pci_set_master() and netc_setup(), for
example in netc_switch_platform_probe() or dsa_register_switch(), the
device is never reset before devres disables it.

Would it work to keep a probe-time reset in netc_switch_pci_init()
before pci_set_master()?

[ ... ]

> @@ -2475,12 +2565,15 @@ static int netc_switch_probe(struct pci_dev *pdev,
>  	ds->ageing_time_max = U32_MAX;
>  	ds->priv = priv;
>  	priv->ds = ds;
> +	priv->in_probe = true;
>  
>  	err = dsa_register_switch(ds);
>  	if (err)
>  		return dev_err_probe(dev, err,
>  				     "Failed to register DSA switch\n");
>  
> +	priv->in_probe = false;
> +
>  	return 0;
>  }

[Severity: Medium]
netc_switch_reset() reads priv->in_probe to decide whether the current
thread holds A's device lock. The flag only records that A's probe is in
progress somewhere, not that the current thread owns the lock.

dsa_register_switch() drops dsa2_mutex before it returns, and it returns
0 when the tree is still incomplete. Consider this sequence:

CPU0 (probe of A)
  priv->in_probe = true;
  dsa_register_switch(A)
    mutex_unlock(&dsa2_mutex);
  <window>
  priv->in_probe = false;

CPU1 (probe of B, async probe or deferred probe)
  dsa_register_switch(B)
    dsa_tree_setup()
      netc_setup(A)
        netc_switch_reset(A)    /* sees in_probe == true */
          pci_reset_function_locked(A->pdev)

In this case pci_reset_function_locked() runs on B's thread, which does
not hold A's device lock. Wouldn't device_lock_assert() fire under
lockdep?

The FLR includes msleep(100) and a readiness poll. Could it still be
running after A's probe returns and the driver core releases
device_lock(A)? If so, it would not be serialized against other
device-locked operations such as a sysfs reset.

The cross-CPU write and read of in_probe is also unsynchronized.

This code is still the same at the end of the series. Could the caller
context decide whether the lock is held, for example through a parameter
or by doing the probe-time reset directly in probe, instead of a shared
per-device flag?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012095924.1129312-1-wei.fang%40oss.nxp.com
