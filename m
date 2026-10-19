Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D658E49E5ED;
	Mon, 19 Oct 2026 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399876; cv=none; b=cQJmR3/tDA8QFxrpNworDKti64ybbhjlmwIP6rQo4o2PZYckNX3DaGIWRjM8IuELhsvcDVKhCbOY4TdaviAjo1y9dZTTkd/dVAEa7RJ6YF4W4JqmsPEMORzKS8vhky/daksXNNoJg6O3SeVPlBTnoCpWCQzyamp9m23ZmoIJskQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399876; c=relaxed/simple;
	bh=yRgOBFy+C4uubMACqMsY2X2MvN2h2hsDnJ/97y/CgI0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e4nW8ydflESbRqrMKUkQSqDHlq4/TsqP8vYekRPqTHmYfK8tBHBjHhwE2+wIwNkOmD2p2llGLQ8c7ePWAqlzbH6e8+KXwsVMygYoMNg/rhpxO3I6yZL2nOuc7asoyJberhrQhWbdoH0079hXNjhkkrlRZrZl/prMDEzvVAJreKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlVjn1EK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlVjn1EK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B841F000C4;
	Mon, 19 Oct 2026 08:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399874;
	bh=dEEd7H/7kkXmUvradk6puKO4yMY6sZvcHlBFoHhJaSQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TlVjn1EKSEDeUkmSnT9W8pcFM6crnhDlHMpGRl3bPOqPL/FA3FjGJrwRyGQgXBuuE
	 Evv4At+/1L5E12wUyZ/J5UI5X1ANs3vWF6JO2DIrbTd6XR5ZMc1ndoiN88PxD+serW
	 1zerS671tM7FguwwgKg5Vhe5lJDPKIxXwT9AROQ5OMgrngKNFqU3NtFbSO42YUxbtL
	 k/CwlfrrhC6D1AOZN0YkvsJ2UzXAnBP9W1+Vf0LDNoLVbZ49dtfpHVCgDKgpR2TDeN
	 tNAx1Jua52JBd9s/E97GzS3G5u3Q3OyegFOVS67cwVFELkhEgpbXN80wBLS4WfcZp8
	 rUraj8VZkNmFw==
Subject: Re: [PATCH net 05/10] net: pse-pd: check the PI state under the lock
 when setting a power limit
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 piotr.kubik@adtran.com, saikrishnag@marvell.com, horms@kernel.org,
 kyle.swenson@est.tech, netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 08:51:13 +0000
Message-ID: <179239987339.3135.11130245905103238734@kernel.org>
In-Reply-To: <20261018082314.48950-6-github@szelinsky.de>
References: <20261018082314.48950-6-github@szelinsky.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch puts the PD-state check and the budget change in one
  pcdev->lock critical section inside pse_pi_update_pw_budget().
- [Low] The kernel-doc for pse_pi_update_pw_budget() (drivers/net/pse-
  pd/pse_core.c:1835) still says "Return: Previous power allocated on…

--

net: pse-pd: check the PI state under the lock when setting a power limit

This moves the software power control, admin state and PD detected checks
from pse_ethtool_set_pw_limit() into pse_pi_update_pw_budget(), so they now
run under pcdev->lock. A new updated output parameter reports whether the
budget changed. The rollback after a failed regulator_set_current_limit()
now runs only when updated is true.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 336f00d82b5f8..d5f863834179c 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -1829,22 +1829,32 @@ EXPORT_SYMBOL_GPL(pse_ethtool_set_config);
>   * @pcdev: a pointer to the PSE controller device
>   * @id: index of the PSE PI
>   * @pw_req: power requested
> + * @updated: set to true if the budget was changed
>   * @extack: extack for reporting useful error messages
>   *
>   * Return: Previous power allocated on success and failure value on error
>   */
>  static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
> -				   const unsigned int pw_req,
> +				   const unsigned int pw_req, bool *updated,
>  				   struct netlink_ext_ack *extack)
>  {

[ ... ]

>  	mutex_lock(&pcdev->lock);
> +	/* Only a powered PI under software power control holds a budget.
> +	 * Check it here, as pse_isr() changes it under the same lock.
> +	 */
> +	if (!pse_pw_d_is_sw_pw_control(pcdev, pi->pw_d) ||
> +	    !pi->admin_state_enabled || !pi->isr_pd_detected)
> +		goto out;
> +

[Severity: Low]
This isn't a bug, but the kernel-doc for pse_pi_update_pw_budget() still
says:

 * Return: Previous power allocated on success and failure value on error

This new early exit returns 0 with *updated = false, whatever
pi->pw_allocated_mW holds. The existing !pw_diff exit also returns 0.

pw_allocated_mW can be non-zero when this check fails. For example,
_pse_pi_disable() returns before pse_pi_deallocate_pw_budget() if
ops->pi_disable() fails, but pse_set_config_isr() still clears
isr_pd_detected on disconnection.

Could the Return description say that 0 can also mean no change was made?
It could also say that callers should check *updated, not the return
value, before rolling back.

>  	previous_pw_allocated = pi->pw_allocated_mW;
>  	pw_diff = pw_req - previous_pw_allocated;
>  	if (!pw_diff) {

[ ... ]

> @@ -1908,21 +1920,17 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
>  	/* Update power budget only in software power control case and
>  	 * if a Power Device is powered.
>  	 */
> -	if (pse_pw_d_is_sw_pw_control(psec->pcdev,
> -				      psec->pcdev->pi[psec->id].pw_d) &&
> -	    psec->pcdev->pi[psec->id].admin_state_enabled &&
> -	    psec->pcdev->pi[psec->id].isr_pd_detected) {
> -		ret = pse_pi_update_pw_budget(psec->pcdev, psec->id,
> -					      pw_limit, extack);
> -		if (ret < 0)
> -			return ret;
> -		previous_pw_allocated = ret;
> -	}
> +	ret = pse_pi_update_pw_budget(psec->pcdev, psec->id, pw_limit,
> +				      &updated, extack);
> +	if (ret < 0)
> +		return ret;
> +	previous_pw_allocated = ret;
>  
>  	ret = regulator_set_current_limit(psec->ps, 0, uA);

[Severity: Medium]
The scenario in the commit message, where budget is reserved for a port
that is no longer powered, looks closed now. But can the budget and the
hardware limit still drift apart in the other direction?

The state check and the budget change now share one pcdev->lock critical
section. The hardware limit is still written in a separate one:

pse_ethtool_set_pw_limit()
  pse_pi_update_pw_budget()        <- takes and drops pcdev->lock
  regulator_set_current_limit()
    pse_pi_set_current_limit()     <- takes pcdev->lock again
      ops->pi_set_pw_limit()

The threaded pse_isr() only needs pcdev->lock, so it can run in between:

CPU0 (ethtool set_pw_limit)
pse_pi_update_pw_budget()
  sees isr_pd_detected == false
  *updated = false, nothing reserved
  mutex_unlock(&pcdev->lock)

CPU1 (pse_isr, classification event)
pse_set_config_isr()
  isr_pd_detected = true
  _pse_pi_delivery_power_sw_pw_ctrl()
    pw_req = min(pi_get_pw_req(), pi_get_pw_limit())  <- old hw limit
    pse_pi_allocate_pw_budget(pcdev, id, pw_req, extack)
    ops->pi_enable()

CPU0
regulator_set_current_limit()
  pse_pi_set_current_limit()
    ops->pi_set_pw_limit()         <- new, higher limit

The port would then be powered with a hardware limit above its reserved
budget, and nothing later corrects pi->pw_allocated_mW. Could that
over-subscribe the power domain?

A disconnect followed by a reconnect between the two sections seems to end
the same way. If regulator_set_current_limit() then fails, this rollback
writes back the previous_pw_allocated value that was read before the
reconnect:

	if (ret < 0 && updated) {
		pse_pi_update_pw_budget(psec->pcdev, psec->id,
					previous_pw_allocated, &updated,
					extack);

Would a full fix need the state check, the budget update and
ops->pi_set_pw_limit() in a single pcdev->lock critical section?
pse_pi_set_current_limit() takes pcdev->lock itself, so that looks like it
needs a different structure from calling regulator_set_current_limit()
after pse_pi_update_pw_budget().

> -	if (ret < 0 && previous_pw_allocated) {
> +	if (ret < 0 && updated) {
>  		pse_pi_update_pw_budget(psec->pcdev, psec->id,
> -					previous_pw_allocated, extack);
> +					previous_pw_allocated, &updated,
> +					extack);
>  	}
>  
>  	return ret;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018082314.48950-1-github%40szelinsky.de
