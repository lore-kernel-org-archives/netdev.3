Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759964FDE68;
	Mon,  5 Oct 2026 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221611; cv=none; b=XWKDrbCTG5Ad8NjDISTra78PzE5couQvWmsROzcFRWHUQI8gJrXhI7vAyJwr5OROLqsSjB+bEklO8fn4BV+qj5+N3y29TPsC111BScQN9p/8xhVNetIJparhSvn//iCY5k3/W3RR8KbO2UmE2UKfYkvi+w3J0hNmZvthqknXgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221611; c=relaxed/simple;
	bh=nV8orihuoCAhnSxmF3qRf+zoIc6htvf2bHL57JoxfQ4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u3UrlpYwJA6YIsDhiZz+lUfYHmTGpdd7yiQ8u49D0tD23WWqVeBk6jzgH6OFJlb8Sa0Zw4miwtb9Am2ns1t+Q7oK1jjsK5lk2LBad2Ctku0pi8dALMImNPueefFaIbtdK95OCNCnL38Wb5Kzbg+eWhmnmHqsbAvzBzXQz2qH92w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cht0NPSU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cht0NPSU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94CE1F000FF;
	Mon,  5 Oct 2026 17:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791221609;
	bh=l6osWULBa/GYOFe9cSFdcQUBYzSDcUmOqumWZxYeTxw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cht0NPSU3WbcPyIjlXfSdSVA4BiLQ21gFM1Folq8r1fX+R4rqIKf6BdGTuAQfXtG5
	 bT2jzz4pq9WZP9QaCSM9opjAbRta0fs3BQHdRtNkRVwMWcfrJ9gre6xwJ6lR9ghd38
	 Os0bl6rOnjilUXzCfvou5xm0cFIRC/12kwXERKycRaE59449KAevFEg/J9ca2Izouy
	 s2s6l2UGGZXogVljwf+hkDnswyYnj0qdxDJ0UeCcLg5kD7q4/gKT6OIUAhPJ9Skghk
	 B1/2ynO2gVL67mAPVrkMjh/sxvq3PobWe7lsMXQJzxRjZ7xi5Z91MWaxcpSvedkx+I
	 2lX2bYQ6B8f1A==
Subject: Re: [PATCH net-next v8 3/7] net: pse-pd: unwind allocations when
 controller registration fails
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 saravanak@kernel.org, corey@leavitt.info, jelonek.jonas@gmail.com,
 horms@kernel.org, olek2@wp.pl, broonie@kernel.org, lgirdwood@gmail.com,
 netdev-bot+sashiko@kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 17:33:27 +0000
Message-ID: <179122160743.434549.17705968645948888828@kernel.org>
In-Reply-To: <20261004164219.1161294-4-github@szelinsky.de>
References: <20261004164219.1161294-4-github@szelinsky.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The use-after-free the patch says it closes is still reachable
  when two controllers register concurrently.
- [Medium] The subject says the patch unwinds allocations when
  registration fails.
- [Medium] pse_flush_pw_ds() now stores NULL to pcdev->pi[i].pw_d (lines
  941 and 954) so that nothing is left pointing at the devm-allocated…
- [Low] The patch fixes a real memory-safety bug but carries no Fixes:
  tag and no stable Cc.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the podl-pse-
  regulator driver can never register a PSE controller.

--

net: pse-pd: unwind allocations when controller registration fails

This patch adds error unwinding to pse_controller_register(). The
notification kfifo is now freed on failure, and early failures also free
the PI array and its OF references. Power domains left by a partial
pse_register_pw_ds() are flushed, pse_flush_pw_ds() now clears pi[].pw_d,
and failures from the PI regulator loop onward deliberately leave the PI
array allocated.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index dc261beb61702..eeefbf25e6716 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -937,11 +937,21 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
>  			continue;
>  
>  		pw_d = xa_load(&pse_pw_d_map, pcdev->pi[i].pw_d->id);
> -		if (!pw_d)
> +		if (!pw_d) {
> +			pcdev->pi[i].pw_d = NULL;
>  			continue;
> +		}
>  
>  		kref_put_mutex(&pw_d->refcnt, __pse_pw_d_release,
>  			       &pse_pw_d_mutex);
> +		/* The pw_d is devm memory of whichever controller created
> +		 * it, so it can go away as soon as that probe unwinds.
> +		 * Nothing may be left pointing at it: pse_pi_is_enabled()
> +		 * reaches pi[].pw_d from the regulator "state" attribute,
> +		 * which stays readable until the PI regulators are
> +		 * unregistered after us.
> +		 */
> +		pcdev->pi[i].pw_d = NULL;

[Severity: Medium]
Is this store enough to keep pse_pi_is_enabled() away from a freed pw_d?
The store is done without pcdev->lock, but the reader holds that lock:

pse_pi_is_enabled() {
	...
	mutex_lock(&pcdev->lock);
	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
	...
}

On the new pse_register_pw_ds() failure path the PI regulators are still
live. That means the world-readable state attribute can reach this at any
time:

state_show()->_regulator_is_enabled()->pse_pi_is_enabled()

Say a reader has loaded pcdev->pi[id].pw_d and is preempted before
pse_pw_d_is_sw_pw_control() reads pw_d->budget_eval_strategy. In that gap,
pse_flush_pw_ds() can clear the field and return, and the probe fails.
devres then frees the pw_d before it unregisters the PI regulators,
because the pw_d was allocated after them. The reader then reads freed
memory.

Would it close this window to take pcdev->lock around the pointer clear
and do the kref_put_mutex() calls afterwards, outside pcdev->lock?

There is a second race in the intermediate state of the series.
pse_ethtool_get_status() checks pi->pw_d, calls the sleeping
pi_get_admin_state(), and then does:

	switch (pi->pw_d->budget_eval_strategy) {

If that races with pse_controller_unregister(), the new unlocked NULL
store turns this into a NULL dereference. Later in the series, "net: phy:
own phydev->psec via PSE notifier and remove fwnode_mdio hook" closes
that part: the ethtool PSE paths take pse_phy_lock(), and psec is
detached before the flush. The pse_pi_is_enabled() window is still there
at the end of the series.

[ ... ]

> @@ -1092,17 +1102,18 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
>  	    !pcdev->ops->pi_get_pw_status) {
>  		dev_err(pcdev->dev,
>  			"Mandatory status report callbacks are missing");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto free_kfifo;
>  	}

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
this patch reworks the kfifo handling here. Can the kfifo ever be
allocated for podl-pse-regulator? Earlier in pse_controller_register():

	ret = kfifo_alloc(&pcdev->ntf_fifo, pcdev->nr_lines, GFP_KERNEL);
	if (ret) {
		dev_err(pcdev->dev, "failed to allocate kfifo notifications\n");
		return ret;
	}
	INIT_WORK(&pcdev->ntf_work, pse_send_ntf_worker);

	if (!pcdev->nr_lines)
		pcdev->nr_lines = 1;

The kfifo size comes from nr_lines before the default is applied.
__kfifo_alloc_node() rounds the size up to a power of two and returns
-EINVAL if the result is below 2, and both 0 and 1 end up there.

pse_reg_probe() in drivers/net/pse-pd/pse_regulator.c never sets
nr_lines before it calls devm_pse_controller_register(). That probe
therefore seems to always fail with "failed to allocate kfifo
notifications". A controller with nr_lines == 1 fails the same way.

Would it be better to size the kfifo from the defaulted nr_lines with a
minimum of 2, for example max(nr_lines, 2)? This came in with
ffef61d6d273 ("net: pse-pd: Add support for budget evaluation
strategies"), and it is still the same at the end of the series.

[ ... ]

> @@ -1110,7 +1121,12 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
>  	 */
>  	reg_name_len = strlen(dev_name(pcdev->dev)) + 18;
>  
> -	/* Register PI regulators */
> +	/* Register PI regulators. Once one of these exists, pse_pi_ops index
> +	 * pcdev->pi[] and nothing here can unregister it again, so the array
> +	 * must outlive this function. Failures below therefore unwind to
> +	 * free_kfifo and deliberately leak it, as they already do today,
> +	 * rather than hand the live regulators a freed pointer.
> +	 */
>  	for (i = 0; i < pcdev->nr_lines; i++) {
>  		char *reg_name;
>  
> @@ -1119,20 +1135,27 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
>  			continue;
>  
>  		reg_name = devm_kzalloc(pcdev->dev, reg_name_len, GFP_KERNEL);
> -		if (!reg_name)
> -			return -ENOMEM;
> +		if (!reg_name) {
> +			ret = -ENOMEM;
> +			goto free_kfifo;
> +		}
>  
>  		snprintf(reg_name, reg_name_len, "pse-%s_pi%d",
>  			 dev_name(pcdev->dev), i);
>  
>  		ret = devm_pse_pi_regulator_register(pcdev, reg_name, i);
>  		if (ret)
> -			return ret;
> +			goto free_kfifo;
>  	}

[Severity: Medium]
Doesn't this still leak pcdev->pi and the OF references on the PI and
pairset nodes? That happens on every failure from here on: the reg_name
allocation, this one, and the pse_register_pw_ds() failure below. It even
happens on the first loop iteration, before any PI regulator exists.

On registration failure, devm_pse_controller_register() frees only its
devres cookie, so nothing else releases the array.

The commit message says:

    Freeing the array safely past the loop
    would need the regulator ops to tolerate a NULL pcdev->pi, which they do
    not today.

Is that really the only way to do it? devm_pse_pi_regulator_register()
registers the PI regulators on pcdev->dev with devm_regulator_register().
A devm action on pcdev->dev that releases the PIs could be added right
after of_load_pse_pis() succeeds. Devres releases in LIFO order, so that
action would run after every PI regulator has been unregistered. No
regulator op would ever see a freed or NULL pcdev->pi.

That would also cover pse_controller_unregister(), which the commit
message notes calls pse_release_pis() while the PI regulators are still
registered.

The later patch "net: pse-pd: check the PI vpwr supply before registering
the controller" moves the common -EPROBE_DEFER case ahead of the loop.
The leaks from the loop and from pse_register_pw_ds() are still there at
the end of the series.

>  
>  	ret = pse_register_pw_ds(pcdev);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		/* Deliberately not release_pis: the PI regulators registered
> +		 * above index pcdev->pi[] and outlive this function.
> +		 */
> +		pse_flush_pw_ds(pcdev);
> +		goto free_kfifo;
> +	}

[Severity: High]
Can a controller probing at the same time still hit the use-after-free
the commit message describes? On its error path, pse_register_pw_ds()
drops pse_pw_d_mutex while the domains it just created are still in
pse_pw_d_map:

out:
	mutex_unlock(&pse_pw_d_mutex);
	return ret;

pse_flush_pw_ds() runs only after that, without the mutex. Here is one
possible sequence, where controller B shares the same vpwr supply:

controller A
pse_register_pw_ds()
  devm_pse_alloc_pw_d()       /* pw_d published in pse_pw_d_map */
  regulator_get() fails on a later PI
  mutex_unlock(&pse_pw_d_mutex)

controller B
pse_register_pw_ds()
  regulator_is_equal(pw_d->supply, rdev->supply) matches
  pcdev->pi[i].pw_d = pw_d
  kref_get(&pw_d->refcnt)     /* 1 -> 2 */

controller A
pse_flush_pw_ds()
  kref_put_mutex()            /* 2 -> 1, no xa_erase() */
devres frees pw_d

Now pse_pw_d_map and B's pi[].pw_d both point at freed memory. The next
pse_register_pw_ds() reads pw_d->supply, and B's own flush later does
kref_put on the freed object.

Every domain the failing call created stays private to it until
pse_pw_d_mutex is dropped. Could pse_register_pw_ds() undo those domains
itself before the out: label, doing kref_put/xa_erase/regulator_put while
it still holds pse_pw_d_mutex? That would close this window without
moving pw_d out of devm memory.

[Severity: Low]
Should this patch carry Fixes: tags and a stable Cc? A partial
pse_register_pw_ds() leaves freed power domains in pse_pw_d_map, so this
fixes a real use-after-free. The commit message has only a Signed-off-by.

According to blame, the bare returns this patch replaces came from these
commits:

- after pse_register_pw_ds(): 50f8b341d268 ("net: pse-pd: Add support
  for PSE power domains")
- kfifo_alloc(): ffef61d6d273 ("net: pse-pd: Add support for budget
  evaluation strategies")
- after of_load_pse_pis(): 9be9567a7c59 ("net: pse-pd: Add support for
  PSE PIs")
- after setup_pi_matrix(): 29e28d1d7a16 ("net: pse-pd: Add support for
  setup_pi_matrix callback")

Could this also go to net on its own, rather than sit inside the
notifier chain / phylib ownership series?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004164219.1161294-1-github%40szelinsky.de
