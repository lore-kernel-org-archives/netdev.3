Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465791;
	b=UB4WbiYOjzbkGIHSLoQDuUnGl8c83bohJmTUthGaq+q6X3EURNrFriSpQxCFWSz32ppi
	 dNAU5X7jNRTLTQY28drcU/tc5HTgu6kNb0oY5Jv8b+W++7IXdsOam+m1YsuYXkFINql8n
	 r5y1GXgV0wqgR7XXUfIs7wsVGBgvm5bXGAZDgvI0/h5ljYUpHbgdrwu4KFpQqHigI+AU6
	 tJzPzeBNdd6DQNgfkfTvnnDWuQ/Vma5woZPbC8x6m5l6uLLtfh1ft0HUSQx9vLlyYl3hi
	 hJh8vDNk+6XrYHEdge8yVWHTmKHVqb6opFo899XUswCxen1qrAC/lh0CMW37Q4y94ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465791;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YTnEwrqbClY+qztthSIjAqrp48KfJq8i6dyBJdAnUnc=;
	b=jcwCZ0hNeYqsxcoogH7B/sWsdI2THMoxxhflZ7NClsmx1fZgKlZfF4ZyP5SRORZLQKzO
	 O8ba7hPsYFE4C4zbuCwK8tpannMzDBrva1DCdACk55nsIA/xHYYyChZfSK31bOLikyzTV
	 O7HhrhxVuZCb4wh6lqas6G+N23fTyOT7L0GoL/Zn+90yeqSbD1iYmADV7CQ3+Z7iEt4ZH
	 a5vxHk5RLDIHaBVK09uTZfzyY5+p9TLZKYr1hXwyReE4mJCiSlIIW2ssp9y9zJFchk7zk
	 BGuhODzAL2xAUhCMBW4jvjtt55LulL8iJtVQxTKFxZjv9Anwk3oh2aJ6A26EoLqJBvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEKbZmvW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCCC606AF54;
	Tue, 20 Oct 2026 03:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEKbZmvW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F23C1F000D0;
	Tue, 20 Oct 2026 03:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792465791;
	bh=YTnEwrqbClY+qztthSIjAqrp48KfJq8i6dyBJdAnUnc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XEKbZmvWLH7j5eOauzcXAL8MS5xYGY+G9EztGIAMD+2fxgWPOre3OPGOAkkusV2iS
	 wgHWLM8c02lywHGZXHKnRHQO8R6o0TjtmJbt30VsnexfvCif2vap0Pa0MZ9ImlRKxN
	 aEe9g2d756bS3cmv6W06UdjR8KifwEegD0NJbUpzQTHFlXDmLf89WZaXLCWiZSyrfF
	 Nrd/O3I62Hr6u7RXrAYEfGdrflalDf8eOdPPTs3bVOIgcIQbfnchfOLXlQRL3tInnr
	 Hr1FGEWvjMsfmG7xZzHnW7Kz2eLCzCfvlGGSCgwZt95iScppC2kOzfLUO+VKeR5dzC
	 dEo7NJL4UNKbg==
Subject: Re: [PATCH net-next v14 09/12] dpll: sit9531x: implement output pin
 state on a DPLL
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 03:09:49 +0000
Message-ID: <179246578976.3135.2089146013224508142@kernel.org>
In-Reply-To: <20261016005823.13690-10-arouhi@sitime.com>
References: <20261016005823.13690-10-arouhi@sitime.com>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 3 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In sit9531x_output_hiz_write() (drivers/dpll/sit9531x/core.c),
  un-mute does not undo mute.
- [Medium] In sit9531x_dpll_output_pin_state_on_dpll_set(), a CONNECTED
  request is answered with success without running the un-mute whenever…
- [Medium] The new no-op short-circuit can report success while the
  output system is still in PRG_CMD with its loops open.
- [Low] The commit message describes the register writes inaccurately in
  three ways.
- [Low] Two kernel-docs in drivers/dpll/sit9531x/dpll.c do not match the
  implementation.
- [Low] The commit message promises that "A request that fails after some
  of its writes landed still announces the change, so a subscriber is…

Pre-existing issues:
- [Low] If the first write in sit9531x_prg_enter()
  (SIT9531X_DEBUG_UNLOCK_VAL to SIT9531X_REG_OUTSYS_DEBUG) reports an…

--

dpll: sit9531x: implement output pin state on a DPLL

This adds state_on_dpll_get/set callbacks for sit9531x output pins.
DISCONNECTED mutes an output by forcing its pads to Hi-Z, and CONNECTED
releases the override. The patch also starts registering output pins with
the DPLL core.

> The force bit and the state bit are separate, and a pad follows the loaded
> configuration while the force bit is clear, so both are read to decide
> whether an output is muted and both are written to change it.  Which of
> the four register banks applies depends on the slot and on whether the pad
> is single-ended or differential.

[Severity: Low]
Is this description accurate? A few parts of it don't match the code.

The un-mute branch of sit9531x_output_hiz_write() only clears the MASK
(force) bit. It never writes STATE.

Only the read side, sit9531x_output_forced_hiz(), looks at
sitdev->out[].cmos. Mute and un-mute both write all three pairs (DIFF,
CMOS OutP, CMOS OutN), whatever the output's wiring.

sit9531x_output_get_hiz_regs() uses five mask/state register pairs
(DIFF_07, SE_07, SEN_07, DIFF_811, SE_811), not four banks.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 875a5fe783d5c..9aa0d327b6bf6 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> @@ -622,6 +601,251 @@ static int sit9531x_prg_commit(struct sit9531x_dev *sitdev)
>  	return 0;
>  }
>  
> +/*
> + * Enter the output-system programming state: unlock the debug
> + * registers on Page 3 and issue the PRG_CMD state command.  Register
> + * writes that reconfigure the output system only take effect when
> + * they are made inside this state.
> + */
> +static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)
> +{
> +	int rc;
> +
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,
> +			       SIT9531X_DEBUG_UNLOCK_VAL);
> +	if (rc)
> +		return rc;

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. The
previous patch's sit9531x_prg_enter() had the same early return, and this
patch only moves it.

If this first write reports an error but the transfer still reached the
part, does the output-system debug key stay unlocked? Nothing on this path
writes SIT9531X_DEBUG_LOCK_VAL back. The key would stay open until the next
sequence that runs sit9531x_prg_commit().

> +
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
> +			       SIT9531X_PRG_CMD_STATE);

[ ... ]

> +static int sit9531x_output_hiz_write(struct sit9531x_dev *sitdev, u8 slot,
> +				     bool mute)
> +{
> +	u8 mask[SIT9531X_HIZ_PAIRS], state[SIT9531X_HIZ_PAIRS];
> +	struct sit9531x_hiz_pair p[SIT9531X_HIZ_PAIRS];
> +	int i, rc, undo_rc;
> +
> +	sit9531x_output_get_hiz_regs(slot, p);
> +
> +	if (!mute) {
> +		for (i = 0; i < SIT9531X_HIZ_PAIRS; i++) {
> +			rc = sit9531x_hiz_set_bit(sitdev, p[i].mask, p[i].bit,
> +						  false);
> +			if (rc)
> +				return rc;
> +		}
> +		return 0;
> +	}
> +
> +	/*
> +	 * Remember every pair as it was: if the mute fails part-way, that
> +	 * is what the pad goes back to -- which may already be a mute, from
> +	 * an earlier request or from the loaded profile.
> +	 */
> +	for (i = 0; i < SIT9531X_HIZ_PAIRS; i++) {
> +		rc = sit9531x_read_u8(sitdev, p[i].state, &state[i]);
> +		if (rc)
> +			return rc;
> +		rc = sit9531x_read_u8(sitdev, p[i].mask, &mask[i]);
> +		if (rc)
> +			return rc;
> +	}

[Severity: Medium]
Does un-mute actually undo a mute here? The mute path reads each pair's
MASK and STATE first, because a pair "may already be a mute, from an
earlier request or from the loaded profile". Those values are only used
by the rollback.

The !mute branch above clears MASK on all three pairs unconditionally. So
any Hi-Z override the loaded profile set on one of these pads is lost
after a DISCONNECTED -> CONNECTED cycle.

Take a CMOS output where the profile forces only one pad to Hi-Z. It still
decodes as CONNECTED, because sit9531x_output_forced_hiz() needs both pads
forced. After a mute/un-mute round trip, that pad follows its
unoverridden configuration. The getter reports CONNECTED both before and
after.

The kernel-doc of sit9531x_output_enable() says the device drives the
output "again as the loaded profile configures it". That doesn't hold in
this case. Could the pre-mute MASK/STATE bits be kept and restored on
un-mute?

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index aa021b374c45c..f6e76318a567a 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -831,10 +831,140 @@ sit9531x_dpll_output_pin_frequency_set(const struct dpll_pin *pin,
>  	return rc;
>  }
>  
> +/*
> + * sit9531x_dpll_output_pin_state_on_dpll_get - get output pin state
> + *
> + * reports CONNECTED when the output is driven and
> + * DISCONNECTED when it has been muted via sit9531x_output_disable().
> + */

[ ... ]

> +/*
> + * sit9531x_dpll_output_pin_state_on_dpll_set - mute/un-mute an output
> + *
> + * Forces Hi-Z on the output through the Hi-Z force/state register pairs
> + * of its slot, the differential and the single-ended one.
> + *   CONNECTED    -> enable (release the override, the device drives it)
> + *   DISCONNECTED -> disable (force Hi-Z)
> + */

[Severity: Low]
This isn't a bug, but these two comments don't match the implementation.

sit9531x_output_hiz_write() writes three pairs (DIFF, CMOS OutP and CMOS
OutN), not two. For slots 8-11, CMOS OutN is a second bit inside the
DIFF_811 registers (slot - 8 + SIT9531X_HIZ_SEN_811_SHIFT).

The getter comment says DISCONNECTED means the output was muted via
sit9531x_output_disable(). However, sit9531x_out_state_fetch() also
reports DISCONNECTED for a Hi-Z override the loaded profile left at
probe.

> +static int
> +sit9531x_dpll_output_pin_state_on_dpll_set(const struct dpll_pin *pin,

[ ... ]

> +	mutex_lock(&sitdev->multiop_lock);
> +
> +	/*
> +	 * The core forwards a request for the state the output is already
> +	 * in.  The Hi-Z pairs say what the pad does now, so read them and
> +	 * answer such a request from them rather than run the programming
> +	 * sequence, which holds the output loops unlocked for the 100 ms its
> +	 * commit takes and would change nothing.  A read that fails leaves
> +	 * the request to the sequence and its own read-back.
> +	 */
> +	if (!sit9531x_output_state_refresh(sitdev, dpin->id) &&
> +	    sitdev->out[dpin->id].enabled == enable) {
> +		mutex_unlock(&sitdev->multiop_lock);
> +		return 0;
> +	}

[Severity: Medium]
Can this early return leave a CMOS pad forced to Hi-Z while every
CONNECTED request reports success?

For a CMOS output, sit9531x_output_forced_hiz() reports muted only when
both pads are forced. It stops as soon as CMOS_P isn't forced:

	rc = sit9531x_hiz_pair_forced(sitdev, &p[SIT9531X_HIZ_CMOS_P], muted);
	if (rc || !*muted)
		return rc;

So enabled here means "not every CMOS pad is forced", not "no override is
left".

The un-mute branch of sit9531x_output_hiz_write() clears MASK in the order
DIFF, CMOS_P, CMOS_N. It returns on the first failure without rolling
back. Suppose the CMOS_N read-modify-write fails after CMOS_P was released:

sit9531x_output_enable()
  sit9531x_output_hiz_write(mute=false)   CMOS_P released, CMOS_N fails
  sit9531x_prg_commit()                   commits the partial result
  sit9531x_output_forced_hiz()            decodes enabled = true

The callback returns an error and notifies CONNECTED. A CONNECTED retry
then sees enabled == enable here and returns 0 without calling
sit9531x_output_enable(). CMOS_N stays forced on every later retry.

The same thing happens if a mute's CMOS_N write fails and its CMOS_P
rollback also fails, leaving P forced and N released. Only a DISCONNECTED
followed by a CONNECTED clears it.

[Severity: Medium]
Could the same early return also skip re-locking the output loops?

Suppose the Hi-Z writes in sit9531x_output_enable() or
sit9531x_output_disable() succeed, but all SIT9531X_LOOP_LOCK_TRIES writes
of SIT9531X_LOOP_LOCK in sit9531x_prg_commit() fail. prg_commit() only
logs "output loops left unlocked after programming" and returns rc2.

If the bus recovers before the read-back that follows the msleep(100),
the cache shows the requested state, state_stale is cleared, and the
callback returns an error.

A retry of the same request then takes this early return and returns 0
without running prg_enter()/prg_commit(). The loops stay open until some
unrelated programming sequence runs. Without this short-circuit, a retry
would re-run the sequence and re-lock them. Nothing records that the exit
from the programming state failed.

[ ... ]

> +	if (rc) {
> +		struct dpll_pin *dpll_pin;
> +
> +		NL_SET_ERR_MSG(extack, "Failed to set output pin state");

[ ... ]

> +		dpll_pin = READ_ONCE(dpin->dpll_pin);
> +		if (changed && dpll_pin)
> +			__dpll_pin_change_ntf(dpll_pin);
> +	}

[Severity: Low]
The commit message says:

  A request that fails after some of its writes landed still announces
  the change, so a subscriber is not left with the old state

Does that hold when the read-back keeps failing? If the Hi-Z read-back in
sit9531x_output_enable()/disable() fails, state_stale is set and this
code calls __dpll_pin_change_ntf(). That builds the message synchronously:

__dpll_pin_change_ntf()
  dpll_pin_event_send()
    dpll_cmd_pin_get_one()
      dpll_msg_add_pin_dplls()
        dpll_msg_add_pin_on_dpll_state()
          sit9531x_dpll_output_pin_state_on_dpll_get()
            sit9531x_output_state_refresh()

If that second read also fails, the getter returns an error and
dpll_pin_event_send() cancels the message without multicasting it:

	ret = dpll_cmd_pin_get_one(msg, pin, NULL);
	if (ret)
		goto err_cancel_msg;

The return value of __dpll_pin_change_ntf() is ignored here, and no
pending notification is recorded. The periodic poll doesn't look at
outputs. After the bus recovers, would subscribers keep the old state
until some other operation sends a notification?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016005823.13690-1-arouhi%40sitime.com
