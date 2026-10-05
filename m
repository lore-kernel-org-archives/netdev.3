Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3482E440635;
	Mon,  5 Oct 2026 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193348; cv=none; b=AB4t+dmFWrGmw3oeqwNlBCLk4qBkQcbqFXSrHtCfx9c7abntP3HrXno5AU17AJ8PFjxjq7o6/dLJkPwfO7fbwAtIncfgBzlwW3UaSM+wILhbhBKLeqn0Y0Ce6QYadzCXfdeE1PCRMGdzjLQpqE9bZPPtPVUYRKuB9qFJoc/CCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193348; c=relaxed/simple;
	bh=xwS+dM9MR3PElIsksHhyrTZR/0e1YiPd2zkimhOVSaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S57PidFlmDdH7KkFIfH3OPp3Cs/pDwx+wlQTIZ8dmaeEyaEc75Lnwuqix6pGYvm4txlIcTalgvnNBGmLk0IZosGjzqvaIR0885Cuy7WCUrrFyuNJckdrY54BwAfo3YPlVampiKhFePc7JftbDtV5DFe1QfbzJPY2JaodOckXuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bRNFQCQk; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bRNFQCQk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A4BAA4E4118C;
	Mon,  5 Oct 2026 09:42:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6AE0D604FE;
	Mon,  5 Oct 2026 09:42:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6C5B103306B9;
	Mon,  5 Oct 2026 11:42:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791193331; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=73AYElbtEmVWL6vDctqxranKQ1VJ7OLTU3RbIiA1qgY=;
	b=bRNFQCQkltUfpB5MVOFS1CVO3sVp+Pn5fJvIjmjwE9JnJ0WBUTCGHO1cNrLHTs0rW69WlB
	AhhiXdPbBg8cWRaJeJbGh9F8F9+Q/K5Eyvj68btVktJOwemLoLWmO6Ufv961JIKFUlmEWe
	iwgH/wNM5gpUs5YmNGCsQmWapfCxZ67usLkzZ/+5zYAtgMwMVfBLWCKl84KI4rHUd0/PEZ
	vfUoa05ZOPui51liNuZX0GTpRDC0dYgSSytTuhfJ9o3ZFRg2FjRGeY+uEFxJEcFv8Qui9e
	Cij8sfzbu9iTx55tXXZybqOR4t77zCGynD4ORDwOmewuUr2pw3zntHWqLDcHOQ==
Message-ID: <fc208b6e-7808-4b6a-bb49-9d4e27e757bb@bootlin.com>
Date: Mon, 5 Oct 2026 11:42:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net-next v3 2/2] net: pse-pd: Add LTC4266 PSE controller
 driver
To: Kyle Swenson <kyle.swenson@est.tech>,
 "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
Cc: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Roland_Kov=C3=A1cs?= <roland.kovacs@est.tech>,
 =?UTF-8?Q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
References: <20260927212929.593366-3-kyle.swenson@est.tech>
 <179080386247.434549.15817042587071985098@kernel.org>
 <asM8rcKC1n1Tn4JD@est-xps15>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <asM8rcKC1n1Tn4JD@est-xps15>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Kyle,

On 10/5/26 08:00, Kyle Swenson wrote:
> Hello,
> 
> On Wed, Sep 30, 2026 at 09:31:02PM +0000, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 9 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 1 (2) · Medium: 6 (3) · Low: 2
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [High] If a PI's vpwr-supply is described in DT but not yet registered
>>    when the LTC4266 probes, ltc4266_pi_nominal_uv() carries on (warn plus…
>> - [Medium] ltc4266_pi_get_pw_class() reports the wrong power class to
>>    userspace.
>> - [Medium] ltc4266_pi_nominal_uv() swallows -EPROBE_DEFER from
>>    of_regulator_get_optional().
>> - [Medium] ltc4266_map_event() loses hardware events on every error exit.
>> - [Medium] ltc4266_pi_set_pw_limit() treats every negative
>>    ltc4266_port_get_class() result as 'not classified', including…
>> - [Medium] ltc4266_map_event() reports
>>    ETHTOOL_C33_PSE_EVENT_CLASSIFICATION whenever the detevn high nibble…
>> - [Medium] ltc4266_pi_disable() is carried out by ltc4266_port_init(),
>>    whose first write (RSTPB = BIT(chan)) removes power from the port.
>> - [Low] The LTC4266 binding sets maxItems: 1 for pse-pi 'pairsets' but
>>    does not list it as required, and pse-controller.yaml requires only…
>> - [Low] ltc4266_regmap_config sets only reg_bits, val_bits and
>>    max_register (0x5F), with no precious_reg or readable_reg callbacks.
>>
>> Pre-existing issues:
>> - [High] This problem wasn't introduced by this patch, but the new driver
>>    makes it easy to hit.
>> - [High] This problem wasn't introduced by this patch, but the new driver
>>    opts into the affected path.
>> - [Medium] This problem wasn't introduced by this patch, but: when
>>    ops->setup_pi_matrix() fails, pse_controller_register() returns…
>> - [Medium] This problem wasn't introduced by this patch, but:
>>    pse_controller_unregister() calls pse_release_pis() (kfree(pcdev->pi))…
>> - [Medium] This problem wasn't introduced by this patch, but:
>>    pse_control_get_internal() calls try_module_get(pcdev->owner) and…
>>
>> --
>>
>> net: pse-pd: Add LTC4266 PSE controller driver
>>
>> This commit adds a new I2C driver for the Linear Technology LTC4266 PoE PSE
>> controller and hooks it into the PSE controller core. The driver runs the
>> chip in semi-auto mode and maps PSE PIs to delivery channels from the
>> device tree. It uses the chip interrupt together with the static power
>> budget evaluation strategy.
>>
>>> diff --git a/drivers/net/pse-pd/ltc4266.c b/drivers/net/pse-pd/ltc4266.c
>>> new file mode 100644
>>> index 0000000000000..37dea467811a4
>>> --- /dev/null
>>> +++ b/drivers/net/pse-pd/ltc4266.c
>>> @@ -0,0 +1,1386 @@
>>
>> [ ... ]
>>
>>> +static int ltc4266_pi_disable(struct pse_controller_dev *pcdev, int id)
>>> +{
>>> +	struct ltc4266_port *port = ltc4266_pi_port(pcdev, id);
>>> +
>>> +	/* Resetting the port (RSTPB, issued at the start of ltc4266_port_init)
>>> +	 * removes power, disables detection and classification, and clears the
>>> +	 * port's status register. Re-init the port so that detection and
>>> +	 * classification can happen again.
>>> +	 */
>>> +	return ltc4266_port_init(port);
>>> +}
>>
>> [Severity: Medium]
>> What happens if one of the writes after the RSTPB reset in
>> ltc4266_port_init() fails?
>>
>> The first write in ltc4266_port_init() has already removed power from the
>> port. A later failure in the OPMD, HPEN, HPMD, TLIM, DISENA or DETPB write
>> is still returned as a failed disable, and _pse_pi_disable() then skips
>> the budget release:
>>
>> drivers/net/pse-pd/pse_core.c:_pse_pi_disable() {
>>      ...
>> 	ret = ops->pi_disable(pcdev, id);
>> 	if (ret)
>> 		return ret;
>>
>> 	pse_pi_deallocate_pw_budget(&pcdev->pi[id]);
>>      ...
>> }
>>
>> Would the core then keep budget allocated and admin_state_enabled set for
>> a port that has no power? DETPB was never written, so detection stays off.
>> No later classification interrupt would arrive to resync the state.
>>
> 
> Yes, it appears the TPS23881 driver has this issue as well.  I can see
> the contract go in one of two directions: drivers only return non-zero
> if the port wasn't able to be disabled enough to give back power budget
> or the core's _pse_pi_disable should always free the budget after
> calling pi_disable and then return the error at the end of the
> _pse_pi_disable.
> 
> Kory, Oleksij, what are your thoughts?

Mmh that's indeed a policy we need to decide.
My first thought was in favor of always freeing the budget with a 
warning message. But after a second though we need to decide what is the 
harmless. Deallocating the budget while the PI is still power on could 
lead to an hardware over budget which mean there could be smoke.
So I think the first option is the safer. It would be good to add kdoc 
and a warning to explain this.

>> [ ... ]
>>
>>> +static int ltc4266_pi_get_admin_state(struct pse_controller_dev *pcdev, int id,
>>> +				      struct pse_admin_state *admin_state)
>>> +{
>>
>> [ ... ]
>>
>>> +	ret = regmap_read(port->ltc4266->regmap, LTC4266_REG_STATPWR, &val);
>>> +	if (ret < 0)
>>> +		return ret;
>>
>> [Severity: Medium]
>> This isn't a bug introduced by this patch, but an I2C error returned here
>> reaches a module reference leak that already exists in the PSE core.
>> pse_control_get_internal() calls try_module_get(pcdev->owner) and then
>> does this:
>>
>> drivers/net/pse-pd/pse_core.c:pse_control_get_internal() {
>>      ...
>> 	ret = pse_pi_is_hw_enabled(pcdev, index);
>> 	if (ret < 0)
>> 		goto free_psec;
>>      ...
>> }
>>
>> That jump skips the put_module label. If an I2C error happens while a PHY
>> is acquiring its PSE control, does the ltc4266 module stay pinned?
>>
> 
> Sure seems like it.  It appears like it'd also stay pinned in a few of
> the other goto free_psec; statements after the try_module_get.  I'll
> plan on pushing a separate patch with an appropriate Fixes: tag later,
> since I'm hesitant to mix it in with a v4 of this series.

If there are fixes to be sent please send them standalone to net and 
with the fixes tag.

>> [Severity: High]
>> Continuing with a deferred vpwr-supply also has a functional effect. Can
>> the PI end up with no PSE power domain for good?
>>
>> If the supply is not registered yet, regulator_resolve_supply() returns
>> -EPROBE_DEFER and regulator_register() leaves rdev->supply NULL for the PI
>> regulator. pse_register_pw_ds() runs only once, from
>> pse_controller_register():
>>
>> drivers/net/pse-pd/pse_core.c:pse_register_pw_ds() {
>>      ...
>> 		if (!rdev || !rdev->supply)
>> 			continue;
>>      ...
>> }
>>
>> So pi->pw_d stays NULL even after the supply resolves, and
>> pse_pw_d_is_sw_pw_control() returns false for this PI. Two things follow.
>>
>> First, pse_isr() never calls pse_set_config_isr(). The CLASSIFICATION and
>> DISCONNECTION events from ltc4266_map_event() then never power the port
>> or re-arm it.
>>
>> Second, on admin enable pse_pi_enable() calls ltc4266_pi_enable()
>> directly. That fails in ltc4266_port_get_class() with -EINVAL or -EAGAIN
>> when no PD has been classified.
>>
>> The chip runs in semi-auto mode and never powers a port without a PWRPB
>> write. Would a PD that is plugged in later stay unpowered until the
>> driver is rebound?
>>
>> This only affects a supply that is described but deferred. When
>> vpwr-supply is missing entirely, the dummy regulator is used and a power
>> domain is still created.
>>
> 
> This seems correct to me, and I'm pretty sure the cleanest option is to
> fix the pse-core.

It seems there are still several flaws in the PSE core.
If you have the time, please fix them, but tell me if you don't. I will 
tackle them.

>> [Severity: High]
>> This isn't a bug introduced by this patch, but choosing the static budget
>> strategy exposes a lock ordering problem that already exists in the PSE
>> core.
>>
>> pse_isr() holds pcdev->lock and ends up taking the supply regulator lock:
>>
>> pse_isr()
>>    pse_set_config_isr()
>>      _pse_pi_delivery_power_sw_pw_ctrl()
>>        pse_pi_allocate_pw_budget_static_prio()
>>          regulator_request_power_budget(pw_d->supply)
>>            regulator_lock(rdev)
>>
>> An admin enable running at the same time takes the locks in the opposite
>> order:
>>
>> regulator_enable(psec->ps)
>>    regulator_lock_dependent()    (PI rdev, then its supply rdev)
>>      _regulator_enable()
>>        pse_pi_is_enabled() / pse_pi_enable()
>>          mutex_lock(&pcdev->lock)
>>
>> Can a classification interrupt on one PI, racing with an admin enable of
>> another PI on the same supply, deadlock both the IRQ thread and the
>> ethtool task? The ww_mutex scheme cannot break a cycle that includes the
>> plain pcdev->lock mutex.
>>
>>> +
>>> +	ret = devm_pse_controller_register(ltc4266->dev, &ltc4266->pcdev);
>>> +	if (ret)
>>> +		return dev_err_probe(&client->dev, ret,
>>> +				     "Failed to register PSE controller\n");
>>
> 
> Yes, this is a deadlock I've hit in my testing, and it's unclear to me
> why lockdep doesn't seem to catch it.  This is another thing I'll fix
> separately but it'll take some time for me to get it figured out.

Meh there is still a lock issue, again related to the regulator lock.
It's painful.

>> -- 
>> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927212929.593366-1-kyle.swenson%40est.tech
> 
> So just to summarize, for me mostly, I'll change several things in this
> driver:
> 
> - ltc4266_pi_get_pw_class() will return the raw class to match
>    tps23881_pi_get_pw_class().
> - ltc4266_pi_set_pw_limit() will set port->pw_limit first.
> - I'll rework the error path in ltc4266_map_event() to balance clearing
>    stuck event registers on a persistent I2C failure against not
>    discarding events on a single transient one.
> - The lltc,ltc4266.yaml binding will list pairsets as required under
>    pse-pi.
> - Mark the COR registers "precious."
> 
> But I'd contend the remaining fixes should be in the pse core, and I'll
> push a series for that before re-spinning this series on top:
> 
> - Unwind pse_pi array and the notification fifo allocation when
>    pse_controller_register() fails after of_load_pse_pis(), instead of
>    leaking them on probe failure.
> - Return -EPROBE_DEFER from pse_register_pw_ds() when a PI's supply is
>    described but has not registered yet.
> - Fix the pse_power_domain use-after-free on unbind when multiple
>    drivers share a supply and the first one unbinds.
> - Stop the notification worker before releasing the PI array in
>    pse_controller_unregister().
> - Fix the try_module_get reference leak
> - Fix the deadlock in the pse_core that can happen when PI enable
>    races with map_event.
> - Fix the possible double budget allocation in the PSE core.
> 
> 
> Thanks for your credits, it's appreciated.
> 
> Cheers,
> Kyle
> 
> pw-bot: cr

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

