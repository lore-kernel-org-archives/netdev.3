Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792920269;
	b=EumV5Ff9Q8GydZjtveKFroDKLXyboP5xxLsXeSHH9je6tTzozBOZvfSkvu1zcOs1EgeM
	 dWRU4ihSy3CPnXzxuvpOiKQgwz0Go5lDXR8rViNnyV4J1uJQpZ1v82EgtHzhjx2WJidPn
	 1Elu4a4+NKMiIym56p8f57Wi1PbHw3dDXE+K9XEQwLrnn3VDaSl0bLWMYwEz0UD9b/INa
	 WCE+PmpxMipbxjCS85k4+mIQct5fzmg/ahR/r0lR/zS+KcqBPm2grHoq9c1KDqMxOdCpS
	 5QrTYUmCDRDiEBxbhmg3RGpT1hgkjpxe4w/bbnuVdRWtWR0aM6xS4SSTQh0WaAliliQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792920269;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MWi098cMJlP1WHrul13CB7sxRj2mt5l+cQpJpKNbkFE=;
	b=Tet1MUh3SfJSYLvTIADDH5ieR4B5gYp3lFU0oR+NKWJDr11xPIrwOMGdOCSZAENX3WYN
	 kuyUMXBG2yosVwoJd0jYfkc8XgAWoEKYZiFJF4vdIzmcUKBX+Zhm6jmnSzhYWcHde3XC7
	 zNUUW2ew4MiZ6lZzMU8411EtFmPY2tSxvSF12ddu/133WyHhv8s9jE0sHltc0idp7xMwu
	 fs41GlEDZEWLbut9X2pMi9bmzqO0MdiYvz6p5guvkgxJKcibtSoosn3Ke/3vifzSECApn
	 CTmxSzlZfG5Nz8g8UWMMBlGyhCPHsLiZyeK6yPAlS+lN4ca+khKZzX85agg1Hh0IyxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3Fgbnsx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D7D606A33A;
	Sun, 25 Oct 2026 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3Fgbnsx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7A31F031E0;
	Sun, 25 Oct 2026 09:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792920269;
	bh=MWi098cMJlP1WHrul13CB7sxRj2mt5l+cQpJpKNbkFE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z3FgbnsxHuUoMF9Yn+bT/7DfPaX9z9PxDxzZEcti3v+turLoQluyVSKWjGuNNQFTy
	 /XNXRG0MS8k+c5nCVn8tYCOVhXW/jf8QA4o7DNjshsA/G7YivdBHuJU4R6Idf8zsTD
	 dl4P5QUkMSw6OkA39KTwIpp3xcrRgeTvqgUZmWV7uHhQx9/iOGdVtHdirQk1QhSFVQ
	 1IvKM/xGpvgr0+O1islperjpzXRtaOHiq0b0xDyO2JOIEz1ArIlBOVX6JzLE5sCjLY
	 I/9Bx+tcKcbuN6CHlUwem3kPM2DMD6VO2b5hXePaKVH015kQiXpvbjXAWbXYr7l8eB
	 Sx2vX2oJejYgg==
Subject: Re: [PATCH v32 net-next 7/8] net/nebula-matrix: add common/ctrl dev
 init/remove operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 09:24:27 +0000
Message-ID: <179292026791.3134.7406957765573459661@kernel.org>
In-Reply-To: <20261021062113.2158-8-illusion.wang@nebula-matrix.com>
References: <20261021062113.2158-8-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] At this commit, several new comments in nbl_dev.c (and one
  existing comment in nbl_hw_leonis.c) mention functions that are not…
- [Low] The teardown-ordering comment above nbl_dev_remove_ctrl_dev()
  (nbl_dev.c lines 180-183) says that nbl_probe_chip_deps() 're-checks…
- [Low] In nbl_dev_remove_common_dev() (nbl_dev.c lines 151-156), the
  comment says 'A register_chan_task(..., NULL) from here would be a no-…

--

net/nebula-matrix: add common/ctrl dev init/remove operation

This adds nbl_dev.c with nbl_dev_init() and nbl_dev_remove(). They set up
the mailbox channel queue and its clean work. On the control PF they also
program the mailbox QINFO routing and run init_module/deinit_module, and
the new entry points are wired into nbl_core_init() and nbl_core_remove().

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> new file mode 100644
> index 0000000000000..cbb0b06b80117
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> @@ -0,0 +1,295 @@

[ ... ]

> +static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
> +	struct nbl_msix_info *msix_info = &dev_common->msix_info;
> +
> +	/* mailbox vector allocated in nbl_dev_start() via
> +	 * nbl_dev_init_interrupt_scheme(); nbl_dev_request_mailbox_irq()
> +	 * only attaches the irq handler to pre-allocated vectors.
> +	 */

[Severity: Low]
Are nbl_dev_start(), nbl_dev_init_interrupt_scheme() and
nbl_dev_request_mailbox_irq() defined anywhere at this commit? They only
seem to appear in comments: here, in the nbl_dev_setup_common_dev() note
further down, and in the comment above nbl_hw_clear_stale_status() in
nbl_hw_leonis.c.

The comment above INIT_WORK in nbl_dev_setup_common_dev() has a similar
problem:

	 * INIT_WORK must precede nbl_dev_register_chan_task() below: the
	 * registration hands the work item to the channel and the IRQ
	 * path may queue it as soon as setup_queue() completes.

This commit doesn't request any mailbox IRQ, and nbl_probe() ends after
nbl_core_init()->nbl_dev_init().

The next patch in the series, "net/nebula-matrix: add common dev
start/stop operation", adds these functions and wires up
nbl_probe()->nbl_core_start()->nbl_dev_start(). That makes the
references valid.

Two wording problems remain after that patch. The INIT_WORK note still
refers to an IRQ path, but the IRQ is only requested later, in
nbl_dev_start(). This note also reads like development history in a
newly added file:

	 * VSI/ETH identity fetch moved to nbl_dev_start().

Could these comments be reworded to describe the code as it stands?

> +	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1;
> +}

[ ... ]

> +static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +
> +	if (!common_dev)
> +		return;
> +	cancel_work_sync(&common_dev->clean_mbx_task);

[ ... ]

> +	 * Unregistering the clean task is the channel layer's job too:
> +	 * teardown_queue() clears clean_task under state_lock and then
> +	 * cancel_work_sync()es it, after shutdn has blocked new queues.  A
> +	 * register_chan_task(..., NULL) from here would be a no-op anyway,
> +	 * because nbl_chan_register_chan_task() ignores writes once shutdn
> +	 * is set.
> +	 */
> +	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +}

[Severity: Low]
Is shutdn actually set at this point? It only becomes true in
nbl_chan_teardown_queue(), which runs from nbl_dev_remove_chan_queue()
after this comment:

nbl_chan_teardown_queue() {
    ...
	mutex_lock(&chan_info->state_lock);
	WRITE_ONCE(chan_info->shutdn, true);
	task = READ_ONCE(chan_info->clean_task);
	WRITE_ONCE(chan_info->clean_task, NULL);
    ...
}

Until then, nbl_chan_register_chan_task() still accepts writes:

	mutex_lock(&chan_info->state_lock);
	if (!READ_ONCE(chan_info->shutdn))
		WRITE_ONCE(chan_info->clean_task, task);
	mutex_unlock(&chan_info->state_lock);

So a register_chan_task(..., NULL) at this point would clear clean_task,
not do nothing. It is still true that no explicit unregister is needed,
but the reason is that teardown_queue() clears clean_task itself.

Could the last sentence of the comment be corrected? The comment is
unchanged at the end of the series.

[ ... ]

> + * Teardown ordering guarantee: every non-management PF creates a
> + * consumer->control PF device link in its probe path, so the driver
> + * core always unbinds all siblings before allowing the control PF to
> + * be detached (sysfs unbind, driver unregister and hot-unplug alike).
> + * nbl_probe_chip_deps() defers a sibling's probe until the control PF
> + * is fully bound (DL_DEV_DRIVER_BOUND), and re-checks that state after
> + * device_link_add() so a supplier that slipped to DL_DEV_NO_DRIVER or
> + * DL_DEV_PROBING in between also defers.  A sibling therefore cannot

[Severity: Low]
Does nbl_probe_chip_deps() actually do this re-check? In nbl_main.c it
checks the state once under device_trylock(). It then creates the link
with the lock still held and unlocks without checking the state again:

	if (mgt->dev.driver != pdev->dev.driver ||
	    mgt->dev.links.status != DL_DEV_DRIVER_BOUND) {
		device_unlock(&mgt->dev);
		pci_dev_put(mgt);
		return -EPROBE_DEFER;
	}
	...
	if (!device_link_add(&pdev->dev, &mgt->dev,
			     DL_FLAG_AUTOPROBE_CONSUMER)) {
		...
	}

	device_unlock(&mgt->dev);
	pci_dev_put(mgt);

	return 0;

The comment in that function says the guarantee comes from holding the
lock:

	 * Holding the lock is what makes the check and the link creation
	 * below atomic with respect to func 0: ...

Is this sentence left over from an earlier version of
nbl_probe_chip_deps()? The mismatch is still there at the end of the
series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021062113.2158-1-illusion.wang%40nebula-matrix.com
