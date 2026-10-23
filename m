Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743219;
	b=j3fyGBacd0cROXITw2VZdG7SrfsPr+w/04cpaoS7fmf4ojvzhtgeAOZx0JtfvoRjN9MB
	 v4J9I+J/KFRWezE1O/HxC/pHnldLEYwn9ZjoxW0dGNwvvlGF+413e/yrCv89jysjXN+4w
	 IYScdEcT21H2bVE0vyrYD6ES9x7jLigJDppw/HnBQKQu/GBhTHUuWsdQ0qL8+KIsL7Ocw
	 7FqZ/Kb/rr8BAMxRpO9FQCey1vmEXKGGgI/jjqk74nH+8BQ2pscVyJe0qKZ1WHcqPK36x
	 SuZSOwxwqbXMD4BynWVaLp25l5uvJSSYVhL/clMTQEzuI3GkoFzhO+nxjkVfXPsT0Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743219;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+F6j0xWfq1vEyamf1Z414WUdZnVjQSJJP1lFrzc8lFw=;
	b=0zBrJzhulpch/zCrBJC8xYpVTn+aT9Fk/FHsaD6/niKfhJcJNk2Ddrg/TsIpWykO+n8J
	 yBpDMKd+7lwaSjktjnunYwwF2l4vYbULTeGfYA7+dHe1MJqnoT1a7Vfo5Mea+qcvnOR1Z
	 nWI7DXcL0FJJN8E/K0WZp78etgbngQsjmrSG2072am+DtHtnA0clrKC+J9gkw1wnbxMR0
	 1k6E6BcBF0uoDqzLiwHcZofEl/K5V16bxT47mXaKs/HpenYQG0kHxyXpOBkw2tWI7UdY9
	 CzzBzBysu7yxqdg27u2U2Yeb5O9cXUAj+cyLkksC8Lek5/1tHC26NP6xAceegd1oA4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HEkIvuQc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB254606A339;
	Fri, 23 Oct 2026 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HEkIvuQc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A447F1F031E4;
	Fri, 23 Oct 2026 08:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792743218;
	bh=+F6j0xWfq1vEyamf1Z414WUdZnVjQSJJP1lFrzc8lFw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HEkIvuQcbjJ6n9J1jjnp9OsqPklCDE6kesqvfNOsezhuk3w3QPqRTJlMOYSiJkXG9
	 OXx5LcUtBwORPENDfCgXUtWy1MkmUf0cmbZ2mJV7XlhyBnAMZ3VIw7SPqeTF1uWMcK
	 ktcTrWQy4v1ckCk8FKoEqFzuCTOmPMvgiR8UKavaMFl3NEvUFKSMHISpF3E3zjfpHQ
	 eL+woJh2zht4RYfXgRBZvz636B8o2RalJ0yV60ss3aWY9QG7/c13hYTiVJdleoOBKH
	 wJvduD4nwx3AZLDh7gntM6pqvJXuR5xyRzcZXJjfRpkgHAtEu5jCnDjzuZEKLHC8BU
	 ZVQxN2w8EEMRA==
Subject: Re: [PATCH net v2 08/14] net: pse-pd: stop async event sources before
 freeing PI data in unregister
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kyle.swenson@est.tech, ross@r-sc.ca,
 netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Oct 2026 08:13:37 +0000
Message-ID: <179274321725.3134.14426162965545087203@kernel.org>
In-Reply-To: <20261020171249.853085-9-github@szelinsky.de>
References: <20261020171249.853085-9-github@szelinsky.de>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch's reorder lets ntf_work be queued again after
  cancel_work_sync().

--

net: pse-pd: stop async event sources before freeing PI data in unregister

This commit reorders pse_controller_unregister() so the IRQ is disabled
and the notification worker is cancelled before the power domains are
flushed and the PI array is released. The aim is to stop pse_isr() and
the worker from using freed PI data.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 13d6bd29525f3..21280479312e6 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -1137,11 +1137,15 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
>   */
>  void pse_controller_unregister(struct pse_controller_dev *pcdev)
>  {
> -	pse_flush_pw_ds(pcdev);
> -	pse_release_pis(pcdev);
> +	/* Stop the IRQ and the notification worker first: pse_isr() uses
> +	 * pcdev->pi and the power domains that pse_flush_pw_ds() drops,
> +	 * and the worker reads the kfifo that is freed below.
> +	 */
>  	if (pcdev->irq)
>  		disable_irq(pcdev->irq);
>  	cancel_work_sync(&pcdev->ntf_work);
> +	pse_flush_pw_ds(pcdev);
> +	pse_release_pis(pcdev);
>  	kfifo_free(&pcdev->ntf_fifo);

[Severity: High]
Can ntf_work be queued again after this cancel_work_sync()?

pse_isr() is not the only producer. pse_disable_pi_pol() also queues the
worker, and the IRQ has nothing to do with it:

drivers/net/pse-pd/pse_core.c:pse_disable_pi_pol() {
    ...
	kfifo_in_spinlocked(&pcdev->ntf_fifo, &ntf, 1, &pcdev->ntf_fifo_lock);
	schedule_work(&pcdev->ntf_work);
    ...
}

It is reached through this chain:

_pse_pi_delivery_power_sw_pw_ctrl()
  pse_pi_allocate_pw_budget()
    pse_pi_allocate_pw_budget_static_prio()
      pse_disable_pi_prio()
        pse_disable_pi_pol()

That chain can start from three places:

- pse_pi_enable(). The PI regulators are devres-managed, so they are
  still registered when unregister runs.
- _pse_pi_disable()->pse_pw_d_retry_power_delivery().
- pse_ethtool_set_prio().

On these paths the only gate is pse_pw_d_is_sw_pw_control(). For a STATIC
budget domain it returns true until pse_flush_pw_ds() sets pw_d to NULL:

	if (pw_d->budget_eval_strategy == PSE_BUDGET_EVAL_STRAT_STATIC)
		return true;

The old order cleared pw_d before the final cancel_work_sync(). Take
tps23881 as an example: it uses the STATIC strategy and allocates priv
with devm_kzalloc(). With the new order, this sequence looks possible:

CPU0                                  CPU1
pse_controller_unregister()
  disable_irq()
  cancel_work_sync(&pcdev->ntf_work)
                                      pse_ethtool_set_prio()
                                        mutex_lock(&pcdev->lock)
                                        ... goes over budget ...
                                        pse_disable_pi_pol()
                                          schedule_work(&pcdev->ntf_work)
  pse_flush_pw_ds()
  pse_release_pis()
  kfifo_free(&pcdev->ntf_fifo)
devres frees priv (embeds pcdev)
                                      pse_send_ntf_worker()
                                        kfifo_out(&pcdev->ntf_fifo, ...)

Would pse_send_ntf_worker() then use the freed pcdev and the freed kfifo?

The new comment says the worker is stopped first. Nothing seems to stop
it from being queued again between cancel_work_sync() and
pse_flush_pw_ds().

A later patch in this series, "net: pse-pd: keep the PI data until the
PI regulators are gone", appears to close this window. It sets
pcdev->unregistering under pcdev->lock before cancel_work_sync(). While
that flag is set, _pse_pi_delivery_power_sw_pw_ctrl() and
pse_pi_enable() return -ENODEV.

Could that check be moved into this patch, or the patches reordered, so
the intermediate state does not have this window?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020171249.853085-1-github%40szelinsky.de
