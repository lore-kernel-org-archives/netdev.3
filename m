Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5534959D634;
	Thu, 17 Sep 2026 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657324; cv=none; b=s17luskQ29BgEc4begnN8YPTEcReJSlzTyvlM0MXDqMV0W1lYpZ/qvk99OMUqMEQ6DHO21DigvkGO7PLRAkbhzN8KG8IKRCzDLDRO210Jz93UKf+WG0qUcj+YKTeqCchaDrnFLoFjJS0228nR08FSA8auVrvSMJomrCIczM+cWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657324; c=relaxed/simple;
	bh=tC2vs3KQAIstskHq2AFdgLqHR5hLms98H56Fh5TmSuA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I/lQ7ipc/Q9Hl2Dw6skb/rbGyHpAqOsQyLwm26Y/1xeYwo3Pg0cTUVve4D3lhOEqLGISfzC0yC/TJPYvYFWyVejXVlT5UWMJWYAABQODBNfCMH68vw3SiaOXtpSexO5x8e4RTj+WYeJLiiNOOE8FkvG0m6o7wpHl5Qu4xtamBzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqZ5q8Hv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqZ5q8Hv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DF71F0089E;
	Thu, 17 Sep 2026 15:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657310;
	bh=vauecJTTLfuBzQaTojtAAcw0E71zoJ4hYEmrOrMYAoY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nqZ5q8HvqUXJ1aQp3U7NT459CFY1CC0tnnngJ9B2rvi+xypQpGvt/k5jfmey9Nmqn
	 T+6ohEr3lAwTrXANeNHF5S/jLKQiH/hnFACVwyE4ANqXVML+zk9E8Zqats7pwLkl+b
	 wZCT4Ud77v/GRkZdozz30pHnbzdogDrXhgSjy8T5y/gQ0MU+G5Iq3+0y5KVIVkMteo
	 6Ujfw4VVaE7UZdG6eAJhRgBdMF8FmGgGyAWV5igR1a4dLWSQzEAUxuiDo0GixTZuzN
	 yV6sl37CIn/XcGJNTLT0po/QeWRYnj5+Bvf5T93FSIhPDQ60jY386c0H2iQvPzKxf0
	 bO+8lLfRBlTtg==
Subject: Re: [PATCH net-next v9 07/15] dpll: sit9531x: add support to get and
 set priority on input pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 pabeni@redhat.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 17 Sep 2026 15:01:49 +0000
Message-ID: <178965730954.22033.15674954043478310598@kernel.org>
In-Reply-To: <20260915000015.80480-8-arouhi@sitime.com>
References: <20260915000015.80480-8-arouhi@sitime.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 2 · Low: 3

- [High] Self-deadlock: sit9531x_dpll_input_pin_prio_set()
  (drivers/dpll/sit9531x/dpll.c) ends with `while (changed_cnt--)…
- [High] Use-after-free / NULL dereference window:
  sit9531x_dpll_input_pin_prio_set() is the first pin op that walks the…
- [Medium] sit9531x_input_prio_get() (drivers/dpll/sit9531x/core.c)
  collapses the documented 'absent' encoding (chan->prio_last[src] == 0,…
- [Medium] Silent no-op priority set: sit9531x_input_prio_set()
  (drivers/dpll/sit9531x/core.c:671) locates only the FIRST slot holding…
- [Low] The new struct member sit9531x_chan.prio_srcs[] (core.h:152) is
  written by sit9531x_prio_mask_build() ('chan->prio_srcs[slot] = src;')…
- [Low] sit9531x_dpll_input_pin_prio_set() notifies the pin the request
  was made for, in addition to the shifted siblings: the traversal…
- [Low] sit9531x_prio_table_commit() rebuilds the newly extended cache
  (chan->prio_srcs / chan->prio_last, alongside prio_mask) from the…

--

dpll: sit9531x: add support to get and set priority on input pins

This adds .prio_get and .prio_set to the sit9531x input pin ops, backed by a
new cached view of the hardware priority table (prio_srcs[] and prio_last[])
that is refreshed whenever the table is written or polled.  Getting a
priority looks up the cached slot for the pin's source code; setting one
moves the source to the requested slot through sit9531x_input_prio_set().

A few questions below.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 25418485e9757..484c94def578c 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -521,21 +521,81 @@ bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev, u8 pll_idx,
>  }
>  
>  /*
> - * Rebuild a PLL's membership mask from the source codes of its priority
> - * table.  The mask is what the pin state getters test, so it is refreshed
> - * from exactly the values the table holds -- here after a write, and once
> - * per poll from the read-back in sit9531x_chan_state_fetch().
> + * sit9531x_input_prio_get - read an input's priority slot for a PLL
> + * @input_idx:	input source in hardware encoding (see
> + *		sit9531x_input_hw_src())
> + * @prio:	output slot position (0 = highest)
> + *
> + * Reports the last slot this source occupied on this PLL.  The value is
> + * cached from the hardware table read at startup and refreshed after every
> + * table write and poll read-back, so pin-get reflects hardware state without
> + * issuing synchronous register reads per pin.  A source with no known slot
> + * falls back to the lowest-priority valid slot.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
> +int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,
> +			    u8 input_idx, u8 *prio)
> +{
> +	const struct sit9531x_chan *chan;
> +	u8 slot;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	if (pll_idx >= SIT9531X_NUM_PLLS)
> +		return -EINVAL;
> +	input_idx = sit9531x_prio_src_canon(sitdev, input_idx);
> +	if (input_idx >= SIT9531X_PRIO_NUM_SRC)
> +		return -EINVAL;
> +
> +	chan = &sitdev->chan[pll_idx];
> +	slot = chan->prio_last[input_idx];
> +	if (!slot)
> +		slot = SIT9531X_PRIO_MAX_SLOTS;
> +
> +	*prio = slot - 1;
> +
> +	return 0;
> +}

[Severity: Medium]
The commit message says:

  "An input absent from the table has no priority to report, and the core is
   told so rather than handed a made-up number."

Does sit9531x_input_prio_get() actually tell the core that?  The absent
encoding documented for prio_last[] in core.h (0 = the source is not in the
table) is turned into SIT9531X_PRIO_MAX_SLOTS and the function returns 0:

	slot = chan->prio_last[input_idx];
	if (!slot)
		slot = SIT9531X_PRIO_MAX_SLOTS;

	*prio = slot - 1;

Since SIT9531X_PRIO_MAX_SLOTS is 11, *prio becomes 10, which is a valid
slot.  dpll_msg_add_pin_prio() puts whatever prio_get returns into
DPLL_A_PIN_PRIO, and dpll_msg_add_pin_dplls() calls it for every pin/dpll
reference regardless of connection state.

Can userspace then tell "input not in the priority table" apart from "input
programmed at slot 10"?

The value also does not round-trip: writing 10 back reaches
sit9531x_input_prio_set(), which returns -EINVAL when the source is not
found in the table, so
sit9531x_dpll_input_pin_prio_set() answers with "Pin is not a reference of
this DPLL; connect it first".

Would it be clearer either to return an error from prio_get for an absent
source, or to reword the changelog to match the fallback the code
implements?

> +
> +/*
> + * Refresh a PLL's cached view of its priority table from the source codes
> + * the table holds -- here after a write, and once per poll from the
> + * read-back in sit9531x_chan_state_fetch().

[Severity: Low]
sit9531x_prio_table_commit() calls sit9531x_prio_mask_build() with the
intended srcs[] array even when a slot read or write failed mid-sequence
(the "goto commit" path).  With this patch prio_last[] becomes the source of
truth for the priority reported by the new .prio_get op, so a get issued
after a failed set can report a slot the device never accepted, and after a
partial shift-write the device may hold the source in two slots and select
it at a higher priority than the driver reports.

The existing comment at the rebuild site documents this choice, and
sit9531x_chan_state_fetch() calls sit9531x_prio_table_read() plus
sit9531x_prio_mask_build() on every poll, so the window is bounded by the
poll period.  Is it worth noting in the kernel-doc for
sit9531x_input_prio_get() that the cached slot may be an intended rather
than a confirmed one until the next poll?

> + *
> + * The membership mask is what the pin state getters test; the per-slot
> + * copy and the last-slot-seen array are what priority get answers from,
> + * so neither costs a register read per pin.
>   */
>  static void sit9531x_prio_mask_build(struct sit9531x_dev *sitdev, u8 pll_idx,
>  				     const u8 *srcs)
>  {
> +	struct sit9531x_chan *chan = &sitdev->chan[pll_idx];
> +	u8 first[SIT9531X_PRIO_NUM_SRC] = { 0 };
>  	u16 mask = 0;
> -	u8 slot;
> +	u8 slot, src, src_canon;
>  
> -	for (slot = 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)
> -		mask |= BIT(srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK);
> +	for (slot = 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {
> +		src = srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;
> +		chan->prio_srcs[slot] = src;

[ ... ]

> diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h
> index f628bd5b7a975..1ab8ebfd78da1 100644
> --- a/drivers/dpll/sit9531x/core.h
> +++ b/drivers/dpll/sit9531x/core.h
> @@ -129,6 +129,12 @@ struct sit9531x_out {
>   * @ho_freeze:		holdover freeze active
>   * @ho_valid:		holdover memory acquired, i.e. the holdover window
>   *			holds a valid estimate to fall back on
> + * @prio_srcs:		cached copy of the priority table, one source code
> + *			per slot; refreshed together with @prio_mask, so
> + *			priority reads generate no register traffic
> + * @prio_last:		slot each source occupies, plus one (0 = the source
> + *			is not in the table); refreshed from the same scan
> + *			as @prio_mask, so the two never disagree
[ ... ]
> @@ -143,6 +149,8 @@ struct sit9531x_chan {
>  	bool		inner_lol;
>  	bool		ho_freeze;
>  	bool		ho_valid;
> +	u8		prio_srcs[SIT9531X_PRIO_MAX_SLOTS];

[Severity: Low]
Is prio_srcs[] read anywhere?  Grepping drivers/dpll/sit9531x/ turns up only
this declaration and the single store in sit9531x_prio_mask_build()
("chan->prio_srcs[slot] = src;"), both at this commit and at the end of the
series.  sit9531x_input_prio_get() reads prio_last[] only.

The kernel-doc above ("so priority reads generate no register traffic") and
the comment on sit9531x_prio_mask_build() ("the per-slot copy and the
last-slot-seen array are what priority get answers from") describe a
consumer that does not exist.  Was a user of this array dropped, or can the
member and those comment lines go?

> +	u8		prio_last[SIT9531X_PRIO_NUM_SRC];
>  	u16		prio_mask;
>  };
>  
> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index ab9aa7db1839c..e2ff21adfdb23 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -469,10 +469,112 @@ sit9531x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *pin,
>  	return rc;
>  }
>  
[ ... ]
> +/*
> + * sit9531x_dpll_input_pin_prio_set - set input pin priority
> + *
> + * writes input priority table on Page 1 via
> + * core.c sit9531x_input_prio_set().  Forces holdover during update.
> + */
> +static int
> +sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
> +				 const struct dpll_device *dpll, void *dpll_priv,
> +				 u32 prio, struct netlink_ext_ack *extack)
> +{
> +	struct dpll_pin *changed[SIT9531X_MAX_INPUTS + 1];
> +	struct sit9531x_dpll_pin *sibling;
> +	struct sit9531x_dpll_pin *dpin = pin_priv;
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +	u8 changed_cnt = 0, hw_src, slot;
> +	int get_rc, rc;
[ ... ]
> +	mutex_lock(&sitdev->multiop_lock);
> +	rc = sit9531x_input_prio_set(sitdev, sitdpll->id,
> +				     sit9531x_input_hw_src(dpin->id),
> +				     (u8)prio);

[Severity: Medium]
This is the first caller of sit9531x_input_prio_set(); in the parent commit
the helper has none.  Can a set through it report success without changing
the effective priority?

sit9531x_input_prio_set() locates only the first slot holding the source:

	for (from = 0; from < SIT9531X_PRIO_MAX_SLOTS; from++)
		if (sit9531x_prio_src_canon(sitdev, srcs[from]) == input_idx)
			break;
	...
	srcs[prio] = input_idx;
	if (!memcmp(srcs, orig_srcs, sizeof(srcs)))
		return 0;

Duplicated source codes are the driver's own representation of an unused
slot -- sit9531x_input_prio_remove() backfills the freed tail:

	/* Backfill freed tail slots with the lowest-priority remaining src */
	while (count < SIT9531X_PRIO_MAX_SLOTS) {
		kept[count] = kept[count - 1];
		count++;
	}

So for a table like [A,B,B,B,...,B], moving B down to slot 5 shifts
duplicates onto each other, the array comes out bit-identical, the memcmp
shortcut returns 0 and no register is written.  The device keeps selecting B
at its old, higher slot, while sit9531x_prio_mask_build() records the first
occurrence, so a following get reports the old slot and not the one just
written.

The changelog says "setting it moves the input to the requested slot" --
should sit9531x_input_prio_set() clear or account for the other slots
holding the same source code?

> +	if (!rc) {
> +		list_for_each_entry(sibling, &sitdpll->pins, list) {
> +			if (!sit9531x_dpll_is_input_pin(sibling) ||
> +			    sit9531x_dpll_is_xo_pin(sibling))
> +				continue;

[Severity: High]
This is the first pin op that walks the other pins of the DPLL, and
sibling->dpll_pin is collected into changed[] without a NULL check.  Can it
race with teardown?

sit9531x_dpll_pins_unregister() in core.c does, per pin:

	list_for_each_entry_safe(pin, next, &sitdpll->pins, list) {
		sit9531x_dpll_pin_unregister(pin);
		list_del(&pin->list);
		kfree(pin);
	}

sit9531x_dpll_pin_unregister() calls dpll_pin_unregister(), which takes and
then drops dpll_lock:

drivers/dpll/dpll_core.c:dpll_pin_unregister() {
	mutex_lock(&dpll_lock);
	__dpll_pin_unregister(dpll, pin, ops, priv, NULL);
	mutex_unlock(&dpll_lock);
}

and then sets pin->dpll_pin = NULL, while list_del() and kfree() run with
dpll_lock dropped.  In that gap a netlink pin-set on a still-registered
sibling holds dpll_lock and walks &sitdpll->pins, so it can store a NULL
dpll_pin into changed[] and later hand it to dpll_pin_change_ntf() ->
__dpll_pin_change_ntf() -> dpll_pin_notify(pin, pin->clock_id, ...), or
follow a list node that is being list_del()'d and kfree()'d.

The pre-existing poll worker does a similar traversal, but
kthread_cancel_delayed_work_sync() in sit9531x_dev_stop() runs before any
unregister.  Is anything serializing this new traversal against
sit9531x_dpll_pins_unregister()?

> +
> +			hw_src = sit9531x_input_hw_src(sibling->id);
> +			get_rc = sit9531x_input_prio_get(sitdev, sitdpll->id, hw_src, &slot);
> +			if (get_rc)
> +				continue;
> +
> +			if (sibling->prio == slot)
> +				continue;
> +
> +			sibling->prio = slot;
> +			if (changed_cnt < ARRAY_SIZE(changed))
> +				changed[changed_cnt++] = sibling->dpll_pin;

[Severity: Low]
The traversal filter skips only non-input and XO pins, so dpin itself is
collected here too.  The core already emits a notification for that pin
after a successful callback:

drivers/dpll/dpll_netlink.c:dpll_pin_prio_set() {
	ret = ops->prio_set(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
			    dpll_priv(dpll), prio, extack);
	if (ret)
		return ret;
	__dpll_pin_change_ntf(pin);
}

Does one priority change end up sending two DPLL_CMD_PIN_CHANGE_NTF
messages for the requested pin?  Skipping sibling == dpin in the loop would
leave that notification to the core.

> +		}
> +	}
> +	mutex_unlock(&sitdev->multiop_lock);
[ ... ]
> +	while (changed_cnt--)
> +		dpll_pin_change_ntf(changed[changed_cnt]);

[Severity: High]
Can this deadlock on dpll_lock?  The .prio_set callback is invoked with
dpll_lock already held:

dpll_pin_pre_doit()
	mutex_lock(&dpll_lock);
	...
dpll_pin_set_from_nlattr()
  dpll_pin_prio_set()
	ret = ops->prio_set(...);
	if (ret)
		return ret;
	__dpll_pin_change_ntf(pin);	/* lockdep_assert_held(&dpll_lock) */

and dpll_pin_change_ntf() is the wrapper that takes the same non-recursive
mutex again:

drivers/dpll/dpll_netlink.c:dpll_pin_change_ntf() {
	mutex_lock(&dpll_lock);
	ret = __dpll_pin_change_ntf(pin);
	mutex_unlock(&dpll_lock);
}

changed_cnt is non-zero in the ordinary case: sibling->prio starts at 0 from
the kzalloc_obj() in sit9531x_dpll_pin_alloc() and is never seeded, and the
loop does not exclude the pin being set, so the first "pin-set ... prio N"
with N different from the cached value queues at least one entry.

Should this use __dpll_pin_change_ntf(), the way the core does from this
context, instead of dpll_pin_change_ntf()?

>  static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops = {
[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915000015.80480-1-arouhi%40sitime.com
