Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465788;
	b=T/eopU6Dq9C2vb3xo7bYe/NYe3Sk03vu5HcaDEeZ8VsMFjlbpRAPnnEhDz81LT8qKtki
	 KvoLkSlRmfdZhn6b8TDpPdMigG5pnkg16IjiQm5gN4Ohu7CT2NRj8Kceu4ckmijOae4jS
	 RJvPdp/HXGaVTFpW1vg/SaCYsKW0MXG3rKxvMehLeYz8WOarDnl21GDIm6dkO2vfh0X+8
	 8SmsCVzD8tPACzFEaKBudbJuNXF/ijXJoR1BsO+P1xBmFhOQwgzcN2a1btrmxxFpk5px0
	 QrUU9hI7jf1UBpfSmv51jljoGMkIY7ribxhMh030Z8b0JmEQkKTAGqY1rAZuW3zJAIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465788;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BwMABzq17quVoIHYyKwYmdp349lPbATYRGNxi8kCTYY=;
	b=kDyCxh54ZNnXLQNIlCPAsKNUdDbsR9J8jLlSDBiVSCh3I3B0oqXAwv1sr3IoqTH+rksK
	 IINTOnVWEOJ5Wa9awmtfsPBYII8lRBqjxPLixX/3HnG+a1QIBCr8ubcERuuBiJyVB2IOf
	 E4Z1m6cF7HVQXsYQOAOiCInE2h2Yaw+FRXXznpjhRE5bXyE4VEfxPg1vggBoY4N3S0/2q
	 /G88lLpO1ZmLMiUONfYRtdXVdPxiOBc5qbGnEGgRBYtIUTLgt2HhnxKuDD5GKCl9/E6L9
	 OIsolRMdBaIha38t/T4JfdfDXKQJ0MoaUiXJ3/uozcTir0Q1VspmiJDGWATTxVFuopw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPYyX69e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC460A6F69;
	Tue, 20 Oct 2026 03:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPYyX69e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216911F000C5;
	Tue, 20 Oct 2026 03:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792465788;
	bh=BwMABzq17quVoIHYyKwYmdp349lPbATYRGNxi8kCTYY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dPYyX69eo4wU0/dBW9jZ15xf2ZIpNIZtrDb8AZg/FnVRKI2n+4mqsBL+n17AXoen6
	 5adRlZYqi+iYdB0fU/qEoKvSMqJL09an/ua1yUNN/RT/P4nqzGOmqeXuiwcb7DMoU5
	 rmCk7M65Qup8RmGokk4KAQPpXa5v9oR7Wtm/UcRIMfUxQ7Ur2N+JSW2UhF/D3r4vrr
	 4e3RchktRf3YXhsStH8o87alGJAMT3025sXlfLElof2lnAy5rPDUFSaHcvSTUWXD4A
	 Rvfh9dK5+ZzCDA11XvkzHF/KsEPBYs6lssJfRf6sSolzGaOF5t1R+SRyMeIERY88T8
	 7PQtgbiQbDd8w==
Subject: Re: [PATCH net-next v14 07/12] dpll: sit9531x: add support to get and
 set priority on input pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 03:09:46 +0000
Message-ID: <179246578667.3135.9023338680952688439@kernel.org>
In-Reply-To: <20261016005823.13690-8-arouhi@sitime.com>
References: <20261016005823.13690-8-arouhi@sitime.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] A priority that the device has latched can be rolled back in
  the driver's records and reported to userspace as refused.
- [Medium] A priority change confined to standby inputs can move the PLL
  off a healthy fallback reference.
- [Low] The default priority for a source a PLL has never listed is
  SIT9531X_PRIO_MAX_SLOTS - 1 = 10.

--

dpll: sit9531x: add support to get and set priority on input pins

This patch adds prio_get and prio_set callbacks for the sit9531x input
pins. Both work on a per-PLL configured priority, and the Page 1 table is
rebuilt in priority order when a listed input's priority changes. The
poll now also watches priority and operational state, and the baseline
for that comparison is taken when each pin is registered.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 1aad598930d72..f3dbe949f219b 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -671,6 +671,44 @@ bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev, u8 pll_idx,
>  	return !!(sitdev->chan[pll_idx].prio_mask & BIT(input_idx));
>  }
>  
> +/*
> + * sit9531x_input_prio_get - read an input's priority for a PLL
> + * @input_idx:	input source in hardware encoding (see
> + *		sit9531x_input_hw_src())
> + * @prio:	output priority (lower is preferred)
> + *
> + * Reports the priority configured for the source on this PLL, which is
> + * kept whether or not the source is currently in the table: state and
> + * priority are separate attributes, so disconnecting an input and
> + * connecting it again must not change the priority it reports.  The
> + * value is seeded from the hardware table, and re-seeded whenever the
> + * read-back shows the table was rewritten by something other than this
> + * driver.  A source that was never listed reports the lowest slot.

[ ... ]

> +	chan = &sitdev->chan[pll_idx];
> +	if (chan->cfg_known & BIT(input_idx))
> +		*prio = chan->cfg_prio[input_idx];
> +	else
> +		*prio = SIT9531X_PRIO_MAX_SLOTS - 1;
> +
> +	return 0;
> +}

[Severity: Low]
Is "the lowest slot" still accurate now that priorities from 0 to 255 are
accepted?

The default for a source the PLL has never listed is
SIT9531X_PRIO_MAX_SLOTS - 1, which is 10. sit9531x_prio_cfg_seed() seeds
it the same way:

	chan->cfg_prio[src] = SIT9531X_PRIO_MAX_SLOTS - 1;
	chan->cfg_known |= BIT(src);

The commit message says the same thing:

  "An input the PLL has never listed reports the lowest slot, the
  priority it would be connected at."

However, sit9531x_dpll_input_pin_prio_set() accepts values up to U8_MAX:

	if (prio > U8_MAX) {
		NL_SET_ERR_MSG(extack, "Priority out of range (0-255)");

sit9531x_prio_table_build() sorts members by cfg_prio and uses
prio_last only to break ties:

	kc = (chan->cfg_known & BIT(cur)) ?
	     chan->cfg_prio[cur] : U8_MAX;

Here is an example. IN0 is listed and is set to 50. IN1 has never been
listed and keeps the default of 10. Connecting IN1 then goes through
sit9531x_input_prio_add()->sit9531x_prio_table_apply()->
sit9531x_prio_table_build(), which puts IN1 in slot 0, ahead of IN0.
sit9531x_prio_activesel_pick() may then move the PLL to it.

Should the default follow the real lowest priority (U8_MAX, for example),
or should the comments and commit message stop promising "lowest"?

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 4c7cae4ce93ec..0400444d91a55 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c

[ ... ]

> +static int
> +sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
> +				 const struct dpll_device *dpll,
> +				 void *dpll_priv, u32 prio,
> +				 struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	mutex_lock(&sitdev->multiop_lock);
> +	rc = sit9531x_input_prio_set(sitdev, sitdpll->id,
> +				     sit9531x_input_hw_src(dpin->id),
> +				     (u8)prio);

[Severity: Medium]
Can a priority change that only touches standby inputs move the PLL off
a healthy fallback reference?

sit9531x_prio_table_commit() takes the current source from the
CLK_ACTIVESEL nibble it reads back, not from the reference actually
routed to the PLL:

		u8 sel = sit9531x_prio_slot_get(val, slot + 1);
		...
		sel = sit9531x_prio_activesel_pick(sitdev, chan->prio_srcs,
						   srcs, sel);

The driver's comments say that when the selected source A loses its
signal, the device fails over to B on its own and leaves the selection
naming A. Suppose A then recovers while the PLL is still on B.

Now a prio_set that only reorders inputs below A and B rewrites the
table. In sit9531x_prio_activesel_pick(), A is the top live source in
both the old and the new table, so the function falls through to:

	if (sit9531x_prio_src_usable(cur) &&
	    sit9531x_prio_src_live(sitdev, cur))
		for (i = 0; i < SIT9531X_PRIO_MAX_SLOTS; i++)
			if (srcs[i] == cur)
				return cur;

It returns A, and latching that selection moves the PLL from B to A.

Doesn't that contradict "a change further down the table leaves the PLL
where it is" in the commit message? The comment above the pick also
says "a change further down the table must not pull a PLL off a healthy
reference".

The selection logic came with the previous patch, for state changes.
This patch adds prio_set as a new way to reach it. When the top is
unchanged, would keeping the routed reference (chan->routed_ref) rather
than the stale selection nibble avoid the switch?

> +	if (!rc)
> +		dpin->prio = prio;
> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	if (rc) {
> +		NL_SET_ERR_MSG(extack, "Failed to set input priority");
> +		return rc;
> +	}

[Severity: Medium]
Can the driver's record of this priority end up disagreeing with what
the device latched?

In sit9531x_prio_table_commit(), the slot writes and the latch can
succeed. The new table is then recorded as the read-back baseline:

	if (!rc) {
		sit9531x_prio_mask_build(sitdev, pll_idx, srcs);
		memcpy(chan->seen_srcs, srcs, sizeof(chan->seen_srcs));
		chan->seen_valid = true;
	}

The holdover release runs after that. If all SIT9531X_HO_CLEAR_TRIES
attempts fail:

	if (ho_rc) {
		...
		if (!rc)
			rc = ho_rc;
	}
	chan->ho_release_pending = !!ho_rc;

sit9531x_ho_release_retry() clears HO_FORCE later from the poll, so the
PLL ends up running the new order.

Meanwhile sit9531x_input_prio_set() sees rc != 0 and reverts:

	rc = sit9531x_prio_table_apply(sitdev, pll_idx, chan->prio_mask);
	if (rc) {
		chan->cfg_prio[input_idx] = old_prio;
		chan->cfg_known = old_known;
	}

sit9531x_dpll_input_pin_prio_set() then returns the error and leaves
dpin->prio as it was.

sit9531x_chan_state_fetch() re-seeds only when the read-back differs
from seen_srcs:

	if (!chan->seen_valid ||
	    memcmp(srcs, chan->seen_srcs, sizeof(chan->seen_srcs)))
		sit9531x_prio_cfg_seed(sitdev, pll_idx, srcs);

seen_srcs already holds the new table, so the poll never repairs this.
The getter and the poll snapshot keep reporting the old priority while
the device holds the new order, and no notification is sent.

The next sit9531x_prio_table_apply() for some unrelated reason, such as a
sibling's state change, builds from the reverted cfg_prio. That reorders
the device back without anyone asking, and
sit9531x_prio_activesel_pick() may move the PLL off its reference.

A latch failure in sit9531x_prio_prg_commit(), or a rollback that fails
part-way, looks like it ends in the same split. In both cases seen_srcs
comes from the read-back table while cfg_prio has been reverted.

The commit message says:

  "A priority the table write refused is not kept: the configured
  value goes back to what it was, so nothing reports a priority the
  device never took."

On this path, isn't the driver reporting the opposite of what the device
holds? Could the rollback be based on what the read-back table actually
encodes, rather than on the errno?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016005823.13690-1-arouhi%40sitime.com
