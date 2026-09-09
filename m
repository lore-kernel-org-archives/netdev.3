Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707653AA1BF;
	Wed,  9 Sep 2026 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935599; cv=none; b=YF6POZJnXak71faVBu13ga2eEJKwVeBB6aJl7uALLNdMIvNDQUr5eRTztDCP1yWZJKoeMtMqpBXwJ40TLbD4vjxEhxL8qcxZQuSUDlFjIk0egrqCAA6VQIE3n8CniHASa4fbX+ZRzKdbhtlwEAhaM+owiXqTOorRa+XkystnWvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935599; c=relaxed/simple;
	bh=qU6ynyUMsUPJ/HLr8KtBfaMQ7QoBHEL8lKyTx7QObSw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nqHJ54hXQ5IOOCffr+uCM4NCIIuJHTtQzbVkB0YwVgmSuYFwysrxtc32wNxxw+XHuNdnS3xDWxP5aoQ62xaR5AwTyon2m4kijx8PA8JiBkiO7GzRZqVk42XqNPMeEubJiGz3TndRiN3X/EwvmrgkjzwGinferVEh6BJLkyu/8bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB1h6/kz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB1h6/kz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2B01F00A3D;
	Wed,  9 Sep 2026 06:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935598;
	bh=UjGleVfRXAs58xJ9uHbePA+zQc0KoO/zs1+ZChk8svQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YB1h6/kzhnBrDPiD0AIk6Dm6QVOAx/SSm3+FDNZWfBBuDT7i0jIYj8DmANpp6Kkq+
	 rBPOc1vPd8/9nqBUJ1/dylIrL0nt5tr3OJd4FApzSfUprEk9MRyGd2xgjV/eFp87+t
	 wHjuH0KIKZeF4cKoC6+azkohvkGKX7+60rtQ5n31TvA+MrvcF1FvPGnoEBh6tty1eI
	 BSsKEYq/2B0a6PaP6W/TGk+aBoq8HS3F+rKqwNrKSESVYWJBnIcT4C0WcEmP4tImm0
	 MbSRRJWkBk3oxRI20n0bVTJwQKk4X0Pn9teJ0c/zj4AEz6ur/M8WoTVvLSiXXIRf2W
	 34UbBY7IV8REw==
Subject: Re: [PATCH net-next v6 2/5] net: pse-pd: fire lifecycle events on
 controller register/unregister
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corey@leavitt.info,
 jelonek.jonas@gmail.com, horms@kernel.org, olek2@wp.pl,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 06:33:17 +0000
Message-ID: <178893559705.219967.11674800741670127760@kernel.org>
In-Reply-To: <20260906153102.959217-3-github@szelinsky.de>
References: <20260906153102.959217-3-github@szelinsky.de>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1

- [High] pse_controller_unregister() fires PSE_UNREGISTERED while @pcdev
  is still linked in pse_controller_list and only calls list_del() at…
- [Low] Reported concern (assessed as not a bug today): both new call
  sites use blocking_notifier_call_chain() and discard the return value;…

Pre-existing issues:
- [High] pse_controller_unregister() calls pse_release_pis() (which
  kfree()s pcdev->pi) at pse_core.c:1158, but only drains the…

--

net: pse-pd: fire lifecycle events on controller register/unregister

This hooks the new pse_controller_notifier chain into the PSE core, firing
PSE_REGISTERED after the controller is added to pse_controller_list and
PSE_UNREGISTERED before it is removed.  A later patch in the series wires
the phy subsystem in as the first subscriber.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 3c4d09f1d6e4f..0190fac33c78a 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -1138,6 +1138,9 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
>  	list_add(&pcdev->list, &pse_controller_list);
>  	mutex_unlock(&pse_list_mutex);
>  
> +	blocking_notifier_call_chain(&pse_controller_notifier,
> +				     PSE_REGISTERED, pcdev);
> +

[Severity: Low]
This isn't a bug today, but both new call sites discard the return value of
blocking_notifier_call_chain().  notifier_call_chain() stops walking as soon
as a callback returns a value containing NOTIFY_STOP_MASK, so a subscriber
returning NOTIFY_STOP or NOTIFY_BAD would hide PSE_UNREGISTERED from
subscribers registered later in the chain, and their pse_control objects
would then outlive pse_release_pis().

The only in-tree subscriber added by this series, phy_pse_notifier_event(),
returns NOTIFY_OK or NOTIFY_DONE, so the chain cannot currently be
truncated.

Would it be worth checking notifier_to_errno() (or at least warning) here,
and/or warning in pse_controller_unregister() when pcdev->pse_control_head
is not empty after the broadcast?

>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pse_controller_register);
> @@ -1148,6 +1151,9 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
>   */
>  void pse_controller_unregister(struct pse_controller_dev *pcdev)
>  {
> +	blocking_notifier_call_chain(&pse_controller_notifier,
> +				     PSE_UNREGISTERED, pcdev);
> +

[Severity: High]
Can a new pse_control still be handed out for this controller after the
event has been broadcast?

PSE_UNREGISTERED is emitted while pcdev is still linked in
pse_controller_list, and list_del() only happens at the very end of
pse_controller_unregister(), after pse_flush_pw_ds(), pse_release_pis(),
disable_irq() and kfifo_free().

of_pse_control_get() gates resolution purely on list membership plus
try_module_get(pcdev->owner):

	list_for_each_entry(r, &pse_controller_list, list) {
		if (!r->no_of_pse_pi) {
			ret = of_pse_match_pi(r, args.np);

There is no "dying" state that of_pse_control_get() rejects, and
try_module_get() succeeds in the common case since unregister runs from the
devm release on device unbind while the provider module is still loaded.

The subscriber added later in the series does not close the window either:
phy_pse_notifier_event() takes and then releases pse_phy_mutex, while the
concurrent acquirer path is:

phy_device_register()
  pse_phy_lock()
  phy_try_attach_pse()
    of_pse_control_get()
  pse_phy_unlock()

so the lock does not cover the rest of the teardown.  Two outcomes look
possible:

If the attach wins before pse_release_pis(), the phy stores a pse_control
whose psec->pcdev->pi[] array is freed moments later, and the final put
reads freed memory:

drivers/net/pse-pd/pse_core.c:__pse_control_release() {
	if (psec->pcdev->pi[psec->id].admin_state_enabled)
		regulator_disable(psec->ps);
	devm_regulator_put(psec->ps);

	module_put(psec->pcdev->owner);

If the lookup runs after pse_release_pis(), of_pse_match_pi() dereferences
pcdev->pi[i].np directly, and pse_release_pis() does not clear the pointer:

drivers/net/pse-pd/pse_core.c:pse_release_pis() {
	...
	kfree(pcdev->pi);
}

The header text added by the series says subscribers "must not acquire new
references for it" for PSE_UNREGISTERED, but non-subscriber lookup paths can
still resolve the controller.

Would it be more robust to make the controller unresolvable first (list_del()
or a dying flag checked by of_pse_control_get()) and only then broadcast
PSE_UNREGISTERED?

>  	pse_flush_pw_ds(pcdev);
>  	pse_release_pis(pcdev);
>  	if (pcdev->irq)

[Severity: High]
This isn't a bug introduced by this patch, but the ordering here becomes
easier to hit with the new broadcast, so it seems worth raising.

pse_release_pis() frees pcdev->pi, while the notification worker is only
drained afterwards:

	pse_flush_pw_ds(pcdev);
	pse_release_pis(pcdev);
	if (pcdev->irq)
		disable_irq(pcdev->irq);
	cancel_work_sync(&pcdev->ntf_work);

pse_send_ntf_worker() takes a real reference via pse_control_find_by_id():

		if (psec->id == id) {
			kref_get(&psec->refcnt);

then drops pse_list_mutex and sleeps across rtnl_lock() /
ethnl_pse_send_ntf() / rtnl_unlock() before calling pse_control_put().

With PSE_UNREGISTERED now telling the phy subscriber to drop its reference
first, can the in-flight worker end up being the last holder, so that its
pse_control_put() runs __pse_control_release() against the already freed
pcdev->pi:

	if (psec->pcdev->pi[psec->id].admin_state_enabled)
		regulator_disable(psec->ps);

Should disable_irq() and cancel_work_sync() run before pse_release_pis(), so
the IRQ producer and the worker are stopped and drained before controller
state is released?

> 		disable_irq(pcdev->irq);
>  	cancel_work_sync(&pcdev->ntf_work);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906153102.959217-1-github%40szelinsky.de
