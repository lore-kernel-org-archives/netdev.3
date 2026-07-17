Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1633D6664;
	Fri, 17 Jul 2026 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287414; cv=none; b=XJv0tAQD0VKFxbmDgCnatgomVmwlBJzJdQ9FZtuJ78BiwM1CMCC7vxTADScDOZHjhqPaEQGRevVdAJaexZ2ftVIfzHxoDjHSGqFCU+DvvqcqS9RoUUZ0PU0ca4B4WUJI9lGAm0k5HQfJpbo/pbf5FLVlHQex1fQl/o5hKq6a+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287414; c=relaxed/simple;
	bh=r718MzxFDSHg27xDHpf0BrrCe9gXm0oMCjrDzFHagAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MV+Bo1EseKjjzdTbrk15GjYNqfZnlHMeNhatFUTM+QcKLbJxmZkO3EHMbFSrflbtyC/nb1ZRZCOqK5WynfUzDVmxfidHPHGifNVzYD4uZZJEgK9bBkkBqi0y6yWqwjCy9GAo49OBK/MzHAjmjnX1YZUObeQ8gUpFhml/g4YF+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7y+FOBl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7y+FOBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9031F000E9;
	Fri, 17 Jul 2026 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784287412;
	bh=C9h1yXBfzyWkHXzFOJ8FqgWSzBoF7pfAYjI8j1zi5wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q7y+FOBlFMkRR26aPO9WWmqyKGVe2sALSZ18qnMpuR96BXI8vSIHEFw9wsmkju3iU
	 nHOBFc3EkB8EIYDrotXfx3aSHy5TCXneQCxStjdTYtG/LVSZTHSdAPQnNiOUcZsDr9
	 ha0coJGowXQhvpaewz6BVN6jUknMcoXuSXtoGDf/tTHOxFVOW1eUzmEBW64LNYt8Uj
	 LLqn88NCPLzbBR392ye15blmQWJa8SfYY8VPF7q9uM5YO3mP8vAvYldWgudK7GH2pa
	 aaat2i86klkDWe9nfaBcwbIxAmp2FnN3GjIFQPe3TqRmlcKP3TxTvF9F1nMooAjhFh
	 zi9hMJFSD3K6Q==
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
Subject: Re: [PATCH net v2 2/2] net: pse-pd: guard regulator ops against freed PI data during unregister
Date: Fri, 17 Jul 2026 12:10:43 +0100
Message-ID: <20260717111042.446842-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711121611.1639086-3-github@szelinsky.de>
References: <20260711121611.1639086-3-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260711121611.1639086-2-github@szelinsky.de?part=2
---
--- Patch [2]: [PATCH net v2 2/2] net: pse-pd: guard regulator ops against freed PI data during unregister ---
commit 651be76b54426e6621f4330232053b29d0731f5d
Author: Carlo Szelinsky <github@szelinsky.de>

net: pse-pd: guard regulator ops against freed PI data during unregister

The commit tries to fix a use-after-free by clearing pcdev->pi to NULL under
pcdev->lock during unregister, and adding NULL checks in the regulator
operations.

[Severity: High]
This is a pre-existing issue, but could the entire pcdev object be used after
free because the API fails to establish a stateful device link between the PSE
controller and the consumer?

If the supplier driver is unbound (e.g., via sysfs or hot-unplug), the memory
backing pcdev is freed via devres. Because of_pse_control_get() acquires the
control without adding a device link (device_link_add) to ensure the supplier
cannot be unbound:

of_pse_control_get()
    psec = pse_control_get_internal(pcdev, psec_id, phydev);

The network device continues to hold a dangling psec->pcdev pointer, and
subsequent ethtool requests dereference the freed pcdev:

pse_ethtool_get_status()
    pcdev = psec->pcdev;
    ops = pcdev->ops;

[Severity: High]
This is a pre-existing issue, but does error handling in pse_register_pw_ds()
leak xa_alloc entries, leading to a use-after-free on a subsequent driver
reload?

If pse_register_pw_ds() succeeds in allocating a power domain via
devm_pse_alloc_pw_d():

devm_pse_alloc_pw_d()
    ret = xa_alloc(&pse_pw_d_map, &index, pw_d, XA_LIMIT(1,
                   PSE_PW_D_LIMIT), GFP_KERNEL);

But fails on a later iteration, it bails out without cleaning up previously
allocated and mapped pw_d instances:

pse_register_pw_ds()
    pw_d = devm_pse_alloc_pw_d(pcdev->dev);
    if (IS_ERR(pw_d)) {
        ret = PTR_ERR(pw_d);
        goto out;
    }

The devm-managed pointer remains in the global xarray after devres frees it.
The next time the driver probes, xa_for_each(&pse_pw_d_map, ...) will access
the freed pw_d->supply pointer.

[Severity: High]
Does this patch series introduce a disable_irq() operation on an already
freed IRQ during devres unwind?

Devres unwinds resources in LIFO order. In drivers like tps23881.c, the devres
order is established where the controller is registered before the IRQ is
requested:

tps23881_i2c_probe()
    ret = devm_pse_controller_register(dev, &priv->pcdev);
    if (ret) {
        return dev_err_probe(dev, ret, "failed to register PSE controller\n");
    }
    
    ret = tps23881_setup_irq(priv, client->irq);

On driver detach, the IRQ is freed first. Then devm_pse_controller_release()
runs and calls pse_controller_unregister(), which calls disable_irq() on an
IRQ that was already freed:

pse_controller_unregister()
    if (pcdev->irq)
        disable_irq(pcdev->irq);

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 6045b6c399c26..21ccb51466160 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -144,7 +144,13 @@ static void pse_release_pis(struct pse_controller_dev *pcdev)
>  		of_node_put(pcdev->pi[i].pairset[1].np);
>  		of_node_put(pcdev->pi[i].np);
>  	}
> +	/* Free under the lock so the NULL store is authoritative against
> +	 * the regulator ops that read pcdev->pi under pcdev->lock.
> +	 */
> +	mutex_lock(&pcdev->lock);
>  	kfree(pcdev->pi);
> +	pcdev->pi = NULL;

[Severity: High]
Does setting pcdev->pi to NULL without guarding consumer paths convert a
use-after-free into a deterministic NULL pointer dereference?

For example, a network consumer holding a pse_control reference can call
ethtool status, which evaluates the pointer from the NULL pcdev->pi and
dereferences it:

pse_ethtool_get_status()
    pi = &pcdev->pi[psec->id];
    mutex_lock(&pcdev->lock);
    if (pi->pw_d) {

Similarly, __pse_control_release() unconditionally accesses pcdev->pi
completely unguarded:

__pse_control_release()
    if (psec->pcdev->pi[psec->id].admin_state_enabled)
        regulator_disable(psec->ps);


[Severity: High]
Could freeing and NULLing pcdev->pi here while the controller is still
globally visible cause a race condition with of_pse_control_get()?

pse_controller_unregister() calls pse_release_pis(), and only later removes
the controller from the globally visible list:

pse_controller_unregister()
    pse_release_pis(pcdev);
    kfifo_free(&pcdev->ntf_fifo);
    mutex_lock(&pse_list_mutex);
    list_del(&pcdev->list);

Concurrently, of_pse_control_get() can iterate the list and call
of_pse_match_pi(), which dereferences the NULL pcdev->pi array:

of_pse_match_pi()
    for (i = 0; i < pcdev->nr_lines; i++) {
        if (pcdev->pi[i].np == np)

> +	mutex_unlock(&pcdev->lock);
>  }
>  
>  /**

[ ... ]

> @@ -702,15 +718,20 @@ static int pse_pi_enable(struct regulator_dev *rdev)
>  static int pse_pi_disable(struct regulator_dev *rdev)
>  {
>  	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
> -	struct pse_pi *pi;
>  	int id, ret;
>  
>  	id = rdev_get_id(rdev);
> -	pi = &pcdev->pi[id];
>  	mutex_lock(&pcdev->lock);

[Severity: High]
This is a pre-existing issue, but is there a race condition between
pse_flush_pw_ds() and pse_pi_disable() that causes a use-after-free of the
regulator supply?

pse_flush_pw_ds() drops the power domain refcount, which leads to
regulator_put() freeing the regulator object. This is done without holding
pcdev->lock:

pse_flush_pw_ds()
    kref_put_mutex(&pw_d->refcnt, __pse_pw_d_release, &pse_pw_d_mutex);

Concurrently, if the regulator core's delayed disable worker invokes
pse_pi_disable(), it can see a non-NULL pcdev->pi, proceed to call
_pse_pi_disable(), and eventually call pse_pi_deallocate_pw_budget().

pse_pi_deallocate_pw_budget() then attempts to dereference the freed regulator
supply:

pse_pi_deallocate_pw_budget()
    regulator_free_power_budget(pi->pw_d->supply, pi->pw_allocated_mW);

> +	/* Reached via the regulator core's deferred-disable flush after
> +	 * pcdev->pi is freed on unregister.
> +	 */
> +	if (!pcdev->pi) {
> +		mutex_unlock(&pcdev->lock);
> +		return 0;
> +	}
>  	ret = _pse_pi_disable(pcdev, id);
>  	if (!ret)
> -		pi->admin_state_enabled = 0;
> +		pcdev->pi[id].admin_state_enabled = 0;
>  
>  	mutex_unlock(&pcdev->lock);
>  	return 0;
