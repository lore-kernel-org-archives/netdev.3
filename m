Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2D3B813A;
	Sun,  4 Oct 2026 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129397; cv=none; b=mH4DsgPiPSKUUiEEie9rUAANsvihiMdMn9HYd4RtLlaH43pZ/6V0+QHcVB4COrppyWoI3fDzltSMJz0MNVBYLWAwViBuuPrijag+C8s6nPmqAxiLIwVuZUvz4K3p1nbgUj2qQhHMqgZZmLNjnsdVUcwoT8gan/EmzFVAhrDAhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129397; c=relaxed/simple;
	bh=srTToKtrXoF3/wiACVuxg8T9VVWfB3aizelY+qHQcr4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K5O2erXqTcazMj+tc2IYGzynRtoMupGwjQw+StQs7m8kSsbNQNdWVFUPHMKTs9q9ReLO4G0j/tnnZjMtGC/FzMsaMnUyz5KFVJz/iSrNRTCgCGadLZBxTegUgEtKSLkcsU0fYWYTZDmCTLriudQeT5QE8FChWU0NpxngTwuoA7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iahwf4yd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iahwf4yd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717FC1F00893;
	Sun,  4 Oct 2026 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791129396;
	bh=jHdztTmu5RpzXiQ8As4ez6SsU+xIsb0ri5znTu4Abxg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Iahwf4ydrCG7GpU7cBPfG2+kXBSsrB+CZEhq8adRO6w4xacmaXiQELr4OEX9/IauE
	 m8O6jTtbPnvFUKz4KjmuVP6XH5AF34yYnYdKwYfbtnuvLHT+iAWKTVbfY1Nb3oCaik
	 yvkNxpvI7s4Ge2oHgy0j8Ocwx3uZhkNA9GlZEt3aQYx6obhmPBy2Yr86/JBKxpYdNX
	 7Ve+qxuNlz0MIW0YyxjLwmgaW0vL3kCHonzYE3KAubDi8dks1z3Iz0gZsxEVljLJmd
	 e4Of/M9peN/cT/ZmCApQW/hHRihGlm0JwtepgIUzhU44YT7njRP74WhbhbciJm50pa
	 SnSAdpo0+BFWw==
Subject:
 Re: [PATCH net-next v19 3/6] driver core: add device_schedule_reprobe()
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Sun, 04 Oct 2026 15:56:35 +0000
Message-ID: <179112939501.434549.6403479745310890424@kernel.org>
In-Reply-To: =?utf-8?q?=3Cff5b5f2963a45a8e1877ad1006b026ce730b7d9d=2E1791035?=
 =?utf-8?q?885=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Cff5b5f2963a45a8e1877ad1006b026ce730b7d9d=2E17910358?=
 =?utf-8?q?85=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] device_schedule_reprobe() (drivers/base/dd.c:1578-1579 and 1597)
  reads the bitfield dev->p->dead with plain accesses: first with no…

--

driver core: add device_schedule_reprobe()

This commit adds device_schedule_reprobe(). It detaches and re-probes a
device after a delay chosen by the caller, from work that lives in
built-in driver core code, so callers do not need a module reference.
Each device has at most one request, tracked in struct device_private,
and device_del() and device_unbind_cleanup() cancel it.

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index f6525a7ee8c54..21973cf0f1a41 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c

[ ... ]

> +int device_schedule_reprobe(struct device *dev, unsigned int delay_ms)
> +{
> +	const struct device_driver *drv;
> +	struct device_reprobe *rp;
> +	int ret = 0;
> +
> +	drv = READ_ONCE(dev->driver);
> +	/*
> +	 * A bus taking the parent lock would need @dev's parent pinned until
> +	 * the work runs, which device_move() can invalidate.
> +	 */
> +	if (!drv || !dev->bus || dev->bus->need_parent_lock || !dev->p ||
> +	    dev->p->dead || !device_is_registered(dev))
> +		return -EINVAL;
> +
> +	rp = kzalloc_obj(*rp);
> +	if (!rp)
> +		return -ENOMEM;
> +
> +	rp->dev = get_device(dev);
> +	INIT_DELAYED_WORK(&rp->work, device_reprobe_work_fn);
> +
> +	/*
> +	 * A release or deletion that got here first has cleared the driver or
> +	 * set dead before cancelling, so a request published after its cancel
> +	 * is refused here; one published before is cancelled by it.
> +	 */
> +	spin_lock(&device_reprobe_lock);
> +	if (dev->p->reprobe)
> +		ret = -EBUSY;
> +	else if (dev->p->dead || READ_ONCE(dev->driver) != drv)

[Severity: Low]
This isn't a functional bug, but will KCSAN report these reads of
dev->p->dead as a data race?

kill_device() writes the bitfield while holding only the device lock:

drivers/base/core.c:kill_device() {
	device_lock_assert(dev);
	...
	dev->p->dead = true;
}

device_schedule_reprobe() reads it with plain accesses in two places. The
first read takes no lock. The second runs under device_reprobe_lock, but
kill_device() never takes that lock. The kernel-doc says callers do not
need to hold the device lock. So device_del() can run at the same time,
for example when a device removal races the mxl862xx devlink
flash_update path. The first check also has an unlocked read of
kobj.state_in_sysfs through device_is_registered().

The ordering looks correct. kill_device() is followed by device_unlock()
and then spin_lock() in device_reprobe_cancel(). A schedule that runs
after the cancel sees dead set, and a request published before the
cancel gets cancelled.

Would it help to wrap these lockless reads in data_race(), or add a
comment saying they are intentional snapshots? READ_ONCE() cannot be used
on the bitfield.

The plain read of defer_all_probes in device_reprobe_work_fn() is
similar, although it matches existing unannotated reads elsewhere in
dd.c.

> +		ret = -EINVAL;
> +	else
> +		WRITE_ONCE(dev->p->reprobe, rp);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791035885.git.daniel%40makrotopia.org
