Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CBF383987;
	Fri, 17 Jul 2026 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286643; cv=none; b=F2lyGz8rbnVBgeHjx0wDALH4b9Ni693I48vzF42aAjUz5BlCo4XvUVSjGbEZrl/EnV6Fd/igtbQR0bqjrMsu+twAXIkaC+6ZEfDsOdj52dxbCg5IAVOZ4ziChVuPBCiYCVZyXO1a1bckRaVgvX6oJ6ieH3MxQLejvRwvt26GCTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286643; c=relaxed/simple;
	bh=tRqd0EAGrekvMGV5L3970EMos9wtQgqKgqLNUsNj+a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQur3r+EcWNoq5kU+5QnoAwck0XWtnNYY7jKTjoP/dJK8m7MyTI+y8xO1OQJUxwY13U/07yZRlFGmH18jDZorVvM5JIqz6QK4IYwmRojRWOfa5aIEyssGY8Y0Du8GO2Q9/nukGljglbH9KQIY3palFr5M8Np0IJOeiTz/p9zAeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbYcolXk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbYcolXk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D5C1F000E9;
	Fri, 17 Jul 2026 11:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784286641;
	bh=3aIVEYtAR72ng+crQ33EbNtM9flUWSUj0gIuRMf9BbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZbYcolXknMdWJYz3e5cRSvqil7NRUmMmNm7YeqGCRTog/CKWHYTV1auNENnCOaNuT
	 h8X2WF/RFskj6bVDqb4F/Pq0ceRf5Z4oPhOO2A1iuQfYTe0aLAfippzm9Xn+qp+buC
	 2x76h8EviBAVMuKzHldLPNH3SGo++GWhXxrdh9qfXbNgqM+qEV/5MmL+K3dO/Afi0W
	 /U+jZoa/q3U2qjRr2daL+N2IDB4Io/irl2DOS2q4Nkl5q6TiwuL2uU9RCyVaUqAV2Y
	 hWOfsiJcoaPLhPdAr37SlUKFg3mYvfst3hMHeXL2Z3uCtDun8bHmgR7uqE3st2M3q8
	 v5KJFPKhWvfSg==
From: Simon Horman <horms@kernel.org>
To: github@szelinsky.de
Cc: Simon Horman <horms@kernel.org>,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: pse-pd: stop async event sources before freeing PI data in unregister
Date: Fri, 17 Jul 2026 12:07:35 +0100
Message-ID: <20260717110734.443214-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711121611.1639086-2-github@szelinsky.de>
References: <20260711121611.1639086-2-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260711121611.1639086-2-github@szelinsky.de?part=1
---
--- Patch [1]: [PATCH net v2 1/2] net: pse-pd: stop async event sources before freeing PI data in unregister ---
commit bc4c653b9b2b42b2c22ca8b6cae3af394c8add0e
Author: Carlo Szelinsky <github@szelinsky.de>

net: pse-pd: stop async event sources before freeing PI data in unregister

This commit reorders the teardown process in pse_controller_unregister().
It disables the IRQ and flushes the notification worker before flushing power
domains and releasing the PI array. This is intended to prevent use-after-free
issues caused by asynchronous accessors referencing freed data structures.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index a5e6d7b26b9fd..6045b6c399c26 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -1114,11 +1114,15 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
>   */
>  void pse_controller_unregister(struct pse_controller_dev *pcdev)
>  {
> -	pse_flush_pw_ds(pcdev);
> -	pse_release_pis(pcdev);
> +	/* Stop the IRQ and notification worker before freeing what they
> +	 * reach: both touch pcdev->pi, and the IRQ also uses pw_d->supply
> +	 * that pse_flush_pw_ds() drops.
> +	 */
>  	if (pcdev->irq)
>  		disable_irq(pcdev->irq);

[Severity: High]
Does this code call disable_irq() on an already freed IRQ line?

In tps23881.c, devm_pse_controller_register() is called before
tps23881_setup_irq(). Because devres executes teardown actions in LIFO order,
the IRQ is freed before pse_controller_unregister() runs.

Calling disable_irq() here operates on a freed IRQ descriptor, which can cause
warnings or corrupt state.

>  	cancel_work_sync(&pcdev->ntf_work);
> +	pse_flush_pw_ds(pcdev);
> +	pse_release_pis(pcdev);

[Severity: High]
This isn't a bug introduced by this patch, but releasing the PIs here causes a
use-after-free via sysfs.

In pse_controller_register(), PI regulators are registered via
devm_pse_pi_regulator_register() before devm_pse_controller_register() is called
by the driver. Devres LIFO ordering means pse_controller_unregister() runs
first, freeing pcdev->pi.

The regulators remain active until their devres actions run later.

If a user space read via sysfs triggers pse_pi_is_enabled() during this window,
it will dereference the freed pcdev->pi array.

[Severity: High]
This is a pre-existing issue, but does freeing the power domains here create a
use-after-free for shared domains?

In pse_register_pw_ds(), shared power domains are added to a global pse_pw_d_map
and their refcount is incremented, but they are allocated with devm_kzalloc()
tied to a specific device.

When the original allocating device is unbound, devres frees the memory, leaving
dangling pointers in the global map and in any other device sharing the domain.

>  	kfifo_free(&pcdev->ntf_fifo);
>  	mutex_lock(&pse_list_mutex);
>  	list_del(&pcdev->list);

[Severity: High]
This is a pre-existing issue, but does destroying internal data structures
before removing the controller from the global list create a use-after-free?

Because pse_release_pis() runs before list_del(), a concurrent device probe
calling of_pse_control_get() can iterate over pse_controller_list, call
of_pse_match_pi(), and dereference the already-freed pcdev->pi[i].np.

[Severity: High]
This is a pre-existing issue, but the PSE control references don't seem to
manage object lifetime properly.

When a consumer gets a control via of_pse_control_get(), it takes a module
reference but does not establish a device link enforcing that the supplier
outlives the consumer.

If the PSE controller is unbound via sysfs, this teardown path frees pcdev->pi.
The active consumer can then dereference freed memory when it later calls
__pse_control_release().

[Severity: Medium]
This is a pre-existing issue, but does pse_controller_register() leak memory on
error paths?

If setup steps fail after allocating the kfifo and the PI structures (e.g.,
missing callbacks or setup_pi_matrix() failures), the function returns the
error without calling kfifo_free() or pse_release_pis().
