Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B034369225;
	Sat, 26 Sep 2026 02:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390095; cv=none; b=TYr1AQ2NDE/jNVBufpiIAh/dwYx1Fq97gtJF+loTbtl9Lo3VYuI7bwUVEepwoRrBkJ8hE+EFXV12ri/oDy+bQ3U3XD/eiukwvQJAxrJkyx7cQy6PDjnsLamSaOoQOv+ET3wTBVMu/tRgJ2yAIJIYKJ7K9S49rsqAcXzaeZ7M1AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390095; c=relaxed/simple;
	bh=m8fD1YBP1kOSeoMPnOqxuAUHZ6FZvqi4Eoq91WyehSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cqvub5DDyOV7vJnsaY1joquZ9D30MK55iZD2QFVNxG+jCgZacFIAB5PqyzcPToQLU1ScYFDLM8uay9UtwEskpoPA9WG0hbXrLEc6yoVY/g3h6Zolhj9ZDP+/Zxa5nalq74jbz6+yiAYoxNplE0h9FxdKJPWiWZdfbTq8a5MWZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnCoCDyT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnCoCDyT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7547C1F00898;
	Sat, 26 Sep 2026 02:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790390088;
	bh=A/IxxE1jPG/+IwqTaHIkKikKX6Xu0AWWP9S+ZMIUIbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cnCoCDyTFiagF8lKiJMA3+PMbaVWI3DghkR3oUlJv6pqnPt7/pWhTyWv4TbbJMq9I
	 ozVrL9sKlNj+jUo2Jwb5UIsYUi2BKOR6F3AnM/Z3kV3KOOO03iryihEl+RBmhEZAZ5
	 P25Q6bRjOB0O6vr7oSFZDmIUnjtREZuLtUDC7rTBXse76ArYO5yYAUYExkey4aRyr5
	 lHcDcDkmEphkSi6K4N8yk1dulWwIUqmi3sj3C3DB+W8JpJ1RO+d/OJF4KY2cTSOjrC
	 iuPeHPry4/gftBhw8ayOpyJdBwjAXGnB4zzigIZ7if99JqUck+IXJd4DRjeWyHbjbP
	 3DGwwHmlIvsxA==
From: Jakub Kicinski <kuba@kernel.org>
To: arouhi@sitime.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	ivecera@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cjubran@nvidia.com,
	pabeni@redhat.com,
	Oleg.Zadorozhnyi@devoxsoftware.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	dev@kael-k.io,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 07/14] dpll: sit9531x: add support to get and set priority on input pins
Date: Fri, 25 Sep 2026 19:34:46 -0700
Message-ID: <20260926023446.1567764-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201108.42676-8-arouhi@sitime.com>
References: <20260921201108.42676-8-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dpll: sit9531x: add support to get and set priority on input pins

This adds prio_get and prio_set callbacks for the sit9531x input pins.
They are backed by a cached copy of each PLL's priority table, which
sit9531x_prio_mask_build() now maintains. prio_set moves an input to the
requested slot and notifies the other pins whose slots shifted, and
sit9531x_prio_table_commit() gains a rollback of partially written slots.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 84c1f86e6d4cf..ac184c93258cb 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -543,34 +543,87 @@ bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev, u8 pll_idx,
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

[Severity: Low]
This isn't a bug, but is "last slot" accurate here?

sit9531x_prio_mask_build() fills prio_last from first[], which holds the
first (highest priority) slot a source occupies among its duplicates. It
also clears the entry to 0 as soon as the source leaves the table:

		if (!first[src_canon])
			first[src_canon] = slot + 1;

The "last-slot-seen array" wording in the sit9531x_prio_mask_build()
comment below has the same problem. The @prio_last description in core.h
does match the code.

[ ... ]

> +/*
> + * Refresh a PLL's cached view of its priority table from the source codes
> + * the table holds -- here after a write, and once per poll from the
> + * read-back in sit9531x_chan_state_fetch().
> + *
> + * The membership mask is what the pin state getters test; the per-slot
> + * copy and the last-slot-seen array are what priority get answers from,
> + * so neither costs a register read per pin.
>   */
>  static void sit9531x_prio_mask_build(struct sit9531x_dev *sitdev, u8 pll_idx,
>  				     const u8 *srcs, u8 written)
>  {
> +	struct sit9531x_chan *chan = &sitdev->chan[pll_idx];
> +	u8 first[SIT9531X_PRIO_NUM_SRC] = { 0 };
>  	u16 mask = 0;
> -	u8 slot;
> -
> -	/*
> -	 * A table written only in part is not described by the values the
> -	 * request carried, and there is nothing here to describe it with
> -	 * instead, so the mask it had stands until the next poll reads the
> -	 * table back.
> -	 */
> -	if (written < SIT9531X_PRIO_MAX_SLOTS)
> -		return;
> +	u8 slot, src, src_canon;
>  
>  	for (slot = 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {
> -		u8 src = srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;
> +		/*
> +		 * A slot the caller could not write still holds what it
> +		 * held before, so take that rather than the value the
> +		 * request wanted to put there.
> +		 */
> +		src = slot < written ? srcs[slot] : chan->prio_srcs[slot];
> +		src &= SIT9531X_PRIO_NIBBLE_MASK;
> +		chan->prio_srcs[slot] = src;
> +		src_canon = sit9531x_prio_src_canon(sitdev, src);
> +		if (!sit9531x_prio_src_usable(src))
> +			continue;
>  
> -		if (sit9531x_prio_src_usable(src))
> -			mask |= BIT(src);
> +		mask |= BIT(src_canon);
> +		if (!first[src_canon])
> +			first[src_canon] = slot + 1;
>  	}

[Severity: Low]
This isn't a bug, but this hunk changes sit9531x_prio_mask_build() in two
ways that the commit message doesn't mention. Both affect existing users:
the pin state getter, sit9531x_input_prio_present(),
sit9531x_ref_pll_mask_rebuild() and the periodic poll.

First, the mask is now built from BIT(src_canon) instead of BIT(src).
Before this patch, when a differential pair's table entry held the N-lane
code, the P-lane pin was reported as disconnected and prio_present()
returned false. Now the same entry reports the pin as listed.

Second, the early return on a partial write is gone. The requested values
for the written slots are now merged with chan->prio_srcs for the rest.
That changes what prio_present() tells the rollback branches of
sit9531x_dpll_input_pin_state_on_dpll_set() after a failed commit.

Should these changes be described in the commit message, or moved into
the commit that introduced sit9531x_prio_mask_build()?

[ ... ]

> @@ -629,9 +683,34 @@ static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_idx,
>  
>  	written = SIT9531X_PRIO_MAX_SLOTS;
>  
> +	if (rc && written) {
> +		/*
> +		 * Put the slots that did reach the device back the way they
> +		 * were.  Latching a table that is neither the previous order
> +		 * nor the requested one hands the reference selection loop
> +		 * a priority list nobody asked for.  The cache is the table
> +		 * as last read, which is what those slots held.
> +		 */
> +		for (slot = 0; slot < written; slot += 2) {
> +			u8 old;
> +
> +			old = sit9531x_prio_slot_set(0, slot,
> +						     chan->prio_srcs[slot]);
> +			old = sit9531x_prio_slot_set(old, slot + 1,
> +						     chan->prio_srcs[slot + 1]);
> +			if (sit9531x_write_u8(sitdev,
> +					      sit9531x_prio_reg(pll_idx, slot),
> +					      old))
> +				break;
> +
> +			restored = slot + 2;
> +		}
> +		written = restored;
> +	}

[Severity: Medium]
Can this block ever run? Every failing register access earlier in
sit9531x_prio_table_commit() jumps straight to the label:

		rc = sit9531x_write_u8(sitdev, reg, val);
		if (rc)
			goto commit;

The read and the write of the last register use the same goto. The only
way to reach "if (rc && written)" is to fall through after the last write
succeeded, and rc is 0 at that point.

So when a table write fails partway through prio_set, prio_add or
prio_remove, sit9531x_prio_prg_commit() still latches the half-written
table and the forced holdover is still released.

For example, take [A,B,C,D,E,F,G,H,X,I,J] and move X to slot 0. If the
write for slots 4 and 5 fails, the device latches
[X,A,B,C,E,F,G,H,X,I,J], and D drops out of this PLL's selection list.

The partial latch itself comes from the earlier "dpll: sit9531x: implement
input pin state on a DPLL" commit. The comment here, though, says this
block prevents it.

If the gotos were pointed at this block, would a few more things need
fixing?

With written == SIT9531X_PRIO_MAX_SLOTS (11), the loop reaches slot 10 and
reads chan->prio_srcs[11], one past the end of the 11-entry array.

The last register shares its other nibble with CLK_ACTIVESEL. This block
rewrites that register from a 0 base, not with the read-modify-write the
forward path uses.

After "written = restored", sit9531x_prio_mask_build(sitdev, pll_idx,
srcs, written) would cache the requested srcs[] for exactly the slots that
were just put back to their old values.

The commit message also doesn't mention this change to a helper shared by
prio_add, prio_remove and prio_set.

[ ... ]

> diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h
> index 033e1059bde9b..2c5d0100b450e 100644
> --- a/drivers/dpll/sit9531x/core.h
> +++ b/drivers/dpll/sit9531x/core.h
> @@ -126,6 +126,12 @@ struct sit9531x_out {
>   * @ho_freeze:		holdover freeze active
>   * @ho_valid:		holdover memory acquired, i.e. the holdover window
>   *			holds a valid estimate to fall back on
> + * @prio_srcs:		cached copy of the priority table, one source code
> + *			per slot; refreshed together with @prio_mask, so
> + *			priority reads generate no register traffic
> + * @prio_last:		slot each source occupies, plus one (0 = the source
> + *			is not in the table); refreshed from the same scan
> + *			as @prio_mask, so the two never disagree
>   * @prio_mask:		bit per hardware source code present in this PLL's
>   *			priority table, i.e. the sources it may select.  Read

[Severity: Low]
This isn't a bug, but the @prio_mask description still says "bit per
hardware source code".

sit9531x_prio_mask_build() now sets BIT(src_canon). An N-lane code in the
table therefore sets the P-lane bit and leaves its own bit clear.

Could this be updated to say the mask is indexed by the canonical source?

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 4437c95f578f8..56a8213dee077 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -489,10 +489,139 @@ sit9531x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *pin,

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
> +	if (!rc) {

[Severity: Low]
If sit9531x_input_prio_set() returns an error after the table has already
changed, is the sibling update skipped entirely?

In sit9531x_prio_table_commit(), the table is latched and
sit9531x_prio_mask_build() refreshes prio_last before the holdover release
is retried. A failure there still becomes the return value:

	if (ho_rc) {
		...
		if (!rc)
			rc = ho_rc;

A partially written table is also latched and cached on the write failure
paths.

In both cases this callback returns an error, so dpll_pin_prio_set() in
the core also skips __dpll_pin_change_ntf() for the named pin. Several
pins' reported priorities can then change with no PIN_CHANGE_NTF for any
of them, and sibling->prio stays stale.

> +		list_for_each_entry(sibling, &sitdpll->pins, list) {
> +			if (!sit9531x_dpll_is_input_pin(sibling) ||
> +			    sit9531x_dpll_is_xo_pin(sibling))
> +				continue;
> +
> +			hw_src = sit9531x_input_hw_src(sibling->id);
> +			get_rc = sit9531x_input_prio_get(sitdev, sitdpll->id,
> +							 hw_src, &slot);
> +			if (get_rc)
> +				continue;
> +
> +			if (sibling->prio == slot)
> +				continue;
> +
> +			sibling->prio = slot;
> +
> +			/*
> +			 * The core notifies the pin the request named, so
> +			 * only the others are collected here.  A pin whose
> +			 * dpll_pin is already NULL is mid-unregister: that
> +			 * runs with the device lock dropped between the
> +			 * unregister and the free, so it can be seen from
> +			 * here, and notifying through it would follow a
> +			 * pointer that is on its way out.
> +			 */
> +			if (sibling == dpin || !sibling->dpll_pin)
> +				continue;
> +
> +			if (changed_cnt < ARRAY_SIZE(changed))
> +				changed[changed_cnt++] = sibling->dpll_pin;
> +		}
> +	}
> +	mutex_unlock(&sitdev->multiop_lock);

[Severity: High]
Is it safe to walk sitdpll->pins and read sibling->dpll_pin here while
holding only multiop_lock and the core's dpll_lock? The teardown path
takes neither lock for the list or for this field:

drivers/dpll/sit9531x/core.c:sit9531x_dpll_pin_unregister() {
	...
	dpll_pin_unregister(sitdpll->dpll_dev, pin->dpll_pin, ops, pin);
	dpll_pin_put(pin->dpll_pin, &pin->tracker);
	pin->dpll_pin = NULL;
	...
}

drivers/dpll/sit9531x/core.c:sit9531x_dpll_pins_unregister() {
	...
	list_for_each_entry_safe(pin, next, &sitdpll->pins, list) {
		sit9531x_dpll_pin_unregister(pin);
		list_del(&pin->list);
		kfree(pin);
	}
}

dpll_pin_unregister() and dpll_pin_put() each take and drop dpll_lock.
The NULL store only happens after both.

Suppose a PIN_SET prio request arrives for a pin that is still registered
on the same DPLL while sit9531x_dev_stop() or a probe error path is
running. Could this loop pick up a sibling's dpll_pin after the last
dpll_pin_put() has freed it, and pass it to __dpll_pin_change_ntf()?

Could the loop also be standing on a sit9531x_dpll_pin that another CPU
is list_del()'ing and kfree()'ing? It would then write sibling->prio into
freed memory or follow LIST_POISON1.

sit9531x_dpll_pins_register() has a similar problem. It does
list_add(&pin->list, &sitdpll->pins) without the lock, after earlier pins
are already reachable from netlink.

The !sibling->dpll_pin check added in v10 reads the pointer without any
lock that orders it against teardown. It doesn't seem to close the window
the comment describes.

[ ... ]

> +	/*
> +	 * The core notifies only the pin the request named, so the ones whose
> +	 * slots moved are notified here.  This runs inside a pin op, where
> +	 * the core already holds the lock the notification needs, so it is
> +	 * the underscore helper rather than the wrapper that takes it.
> +	 */
> +	while (changed_cnt--)
> +		__dpll_pin_change_ntf(changed[changed_cnt]);
> +
> +	return 0;
> +}

[Severity: Medium]
Sibling notifications are only sent from this prio_set path. What about
sit9531x_dpll_input_pin_state_on_dpll_set() with
DPLL_PIN_STATE_DISCONNECTED?

That path calls sit9531x_input_prio_remove(). It rebuilds the table from
the sources it keeps and backfills the tail:

	} else {
		/* Backfill freed tail slots with the lowest-priority src */
		while (count < SIT9531X_PRIO_MAX_SLOTS) {
			kept[count] = kept[count - 1];
			count++;
		}
	}

Every later source moves up a slot, and sit9531x_prio_mask_build() updates
prio_last, which is what prio_get now reports. For example, removing A
from [A,B,C,...] moves B from 1 to 0 and C from 2 to 1.

dpll_pin_state_set() in the core only notifies the named pin. The
disconnect path neither notifies the siblings nor refreshes their
sibling->prio.

sit9531x_dpll_changes_check() doesn't catch this later either, because it
only compares pin state:

		if (state != pin->pin_state) {
			...
			pin->pin_state = state;
			dpll_pin_change_ntf(pin->dpll_pin);
		}

Would userspace listening for PIN_CHANGE_NTF miss the priority changes of
the other inputs after a disconnect?

[ ... ]
