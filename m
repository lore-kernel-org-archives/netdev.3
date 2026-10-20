Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465785;
	b=McypTiDUIRZBgBtnsl8uYAEp6ONMB7d662K/gauzJC+B2VFO61eQgqm6E6lc1kq0hgB+
	 kfFzwec2CelK/0Fs/g0UV3Rxe1VejiUoILYiAKDTd7Fpfl3i3ZMRDSA0uGNqzO5/iGN6M
	 7kmNdRHD9opybduxhxmhc3hJnlaMs2agxPUFv66oDjhlJF6iT+ZoFl/19+0CXen63Gizy
	 ykdmjotfFiH/UMSh9HH0RRMV8fs8Ib7ZagQp1idqo+CHpiFL8a7tNICK4tT2PZzUIM443
	 Ei76G48FvjbKU0nlECuVldD/OEO77LOOLxCVgw0ORinccuCvOjeqi4Eu3U+PRr9WvMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465785;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IfL1YpjRMTUWS4zQrfAe51404IjkHHoLvglXoKL+x/A=;
	b=dsHKfQ9GYEy8fWOTIPZUMcy+2u2C3pgi6sVW/MGy3VzhLzxoBz1hd5bVDerpZ182xfe6
	 eZCBPk+glCNkTTggUTksdpaiwrQhsIoFDXjBI44kwzUfVmrQOmz6VCIXv4uX9ESd4o3oY
	 l9cO2UP+pN2pmIk4+CFZfjkV8A3EBJOcsEc8/rRbTsTadthJ4EDrHs09jKrNYqIlioCaP
	 4x1emSd+vtEVVrEY9hFLjWxexzQHT/1OCqZOVgNIsNTUXXrtgPIuhnT8Kz5bLPPd5Mvvk
	 6XDLRkgHDmNq+8vTnpuAu4TYs+CKI2bS+YCx+OlfUhY8en70Io108FVLGDR6cQOA1jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2EUiwBR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB7F60A4AD5;
	Tue, 20 Oct 2026 03:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2EUiwBR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7441F01574;
	Tue, 20 Oct 2026 03:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792465784;
	bh=IfL1YpjRMTUWS4zQrfAe51404IjkHHoLvglXoKL+x/A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M2EUiwBRscpOoENuomzzB19HqYfatThUt1hxmg1aPERjR/AyN401mo0ENNboIGSeF
	 BllqZ9bkGjPtTvEb6ZmVNXxc90PlqgllWl5js+Ui14lVfnsYR90vfkPL71n28r1MGa
	 CLTdFpkhmjdWi2m6li72jRiBH50GmUzevV0vMy0ZwpXZHIVIc/34qv48FljjnEu59n
	 AMBdvR80tFtZjmlA0zfrrm1XI+CxdAJ8DjlGwdkey5bnqv8qLKqSnLy2pnaQDmF3sd
	 ikzOs7iQ5E1C/CyS2Tm7Se20m6DsKPiwYR8vEb7sP0XaArYIFRSdsdHVssz41cTNYR
	 0TA9xef0ugZ7g==
Subject:
 Re: [PATCH net-next v14 05/12] dpll: sit9531x: register DPLL devices and pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 03:09:43 +0000
Message-ID: <179246578341.3135.4793320596114957014@kernel.org>
In-Reply-To: <20261016005823.13690-6-arouhi@sitime.com>
References: <20261016005823.13690-6-arouhi@sitime.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] sit9531x_dpll_mode_get() always returns DPLL_MODE_AUTOMATIC,
  and sit9531x_dpll_supported_modes_get() advertises only AUTOMATIC.
- [Medium] When the device stops answering on I2C (unpowered, held in
  reset, bus fault, adapter error), the 500 ms poll floods the kernel…
- [Low] Some documentation in this commit describes code that is not
  here.
- [Low] sit9531x_derive_clock_id() builds the uAPI-visible DPLL clock_id
  as SIT9531X_OUI (0x0090C2FFFE) << 24 | (i2c bus & 0xffff) << 8 | addr,…

--

dpll: sit9531x: register DPLL devices and pins

This patch registers each of the four on-chip PLLs as a DPLL device, and
the crystal as a fixed pin on each. It adds a kthread worker that polls
chip state twice a second into a per-input and per-PLL cache, and an
optional INTRB interrupt that kicks the poll. The clock_id is built from
the SiTime OUI, the I2C bus number and the address.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 20ccf024077bc..78a7a1def2137 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> @@ -193,109 +213,1690 @@ int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,
>  	return rc;
>  }
>  
> -static int sit9531x_read_variant_id(struct sit9531x_dev *sitdev, u8 *id)
> +/*
> + * sit9531x_input_get_regs - get force mask and state register addresses
> + * @index:	logical input index
> + * @force_reg:	output force mask register address
> + * @state_reg:	output state register address

[Severity: Low]
These say "output", but the helper returns the Page 0x02 input receiver
registers (SIT9531X_REG_IN_*_FORCE / SIT9531X_REG_IN_*_STATE). Should
they say "input"?

There is also a repeated sentence in the kernel-doc of
sit9531x_dpll_pins_register():

  * and registers each one.  Input pins come first, then output pins,
  * with input pins first, then output pins.

Both of these are still there at the end of the series.

Some other text in this patch describes code that is not in this
commit. The commit message says:

  Output state is not polled: it changes only through a request, and
  the getter reads the device again when one could not be confirmed.

This patch registers no output pins and has no output state getter or
set path. That getter (sit9531x_output_state_refresh()) only shows up
in the later "dpll: sit9531x: implement output pin state on a DPLL"
commit. Could this sentence move to that commit?

These forward references are also resolved later in the series:

- the Kconfig help text ("exposes input/output clocks as DPLL pins,
  providing runtime configuration via Generic Netlink")
- the "five pin ops tables below" comment in dpll.c, although this
  commit defines three
- the comment in sit9531x_ref_state_fetch() that mentions
  sit9531x_input_enable()
- the sit9531x_dpll_register() kernel-doc claiming that all input and
  output pins are registered

> + *
> + * Selects the correct Page 0x02 register pair based on the pair's
> + * signal mode and the lane (P/N) the index refers to.
> + */

[ ... ]

> +static void sit9531x_dev_ref_states_update(struct sit9531x_dev *sitdev)
> +{
> +	int i, rc;
> +
> +	for (i = 0; i < sitdev->info->num_inputs; i++) {
> +		rc = sit9531x_ref_state_fetch(sitdev, i);
> +		if (rc)
> +			dev_warn(sitdev->dev,
> +				 "Failed to get REF%u status: %d\n", i, rc);
> +	}
> +}
> +
> +static void sit9531x_dev_chan_states_update(struct sit9531x_dev *sitdev)
> +{
> +	int i, rc;
> +
> +	for (i = 0; i < SIT9531X_NUM_PLLS; i++) {
> +		rc = sit9531x_chan_state_fetch(sitdev, i);
> +		if (rc)
> +			dev_warn(sitdev->dev,
> +				 "Failed to get PLL%c state: %d\n",
> +				 'A' + i, rc);
> +	}
> +}

[ ... ]

> +static void sit9531x_dev_periodic_work(struct kthread_work *work)
> +{

[ ... ]

> +	mutex_lock(&sitdev->multiop_lock);
> +	sit9531x_dev_ref_states_update(sitdev);
> +	sit9531x_dev_chan_states_update(sitdev);
> +	mutex_unlock(&sitdev->multiop_lock);

[ ... ]

> +	mutex_lock(&sitdev->multiop_lock);
> +	rc = sit9531x_clear_notifications(sitdev);
> +	mutex_unlock(&sitdev->multiop_lock);
> +	if (rc)
> +		dev_warn_ratelimited(sitdev->dev,
> +				     "Failed to clear notifications: %d\n",
> +				     rc);
> +
> +	/* Run twice a second */
> +	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work,
> +				   msecs_to_jiffies(SIT9531X_STATUS_POLL_MS));
> +}

[Severity: Medium]
What happens to the kernel log if the part stops answering on I2C, for
example when it is unpowered, held in reset, or the bus has failed?

On every tick, each failed input fetch logs the unconditional dev_err
from sit9531x_read_u8() and then the dev_warn above. The 4 PLLs do the
same through sit9531x_dev_chan_states_update().
sit9531x_clear_notifications() adds another dev_err from
sit9531x_write_u8(). Only its follow-up warning is ratelimited.

That is about 25 lines per tick, roughly 50 lines a second. The work
requeues itself unconditionally, with no backoff or failure count, so
it never stops. The IRQ path gives up after SIT9531X_IRQ_ACK_TRIES.
Could the poll use ratelimited messages, or back off after repeated
failures?

The same pattern is still there at the end of the series, which adds
more reads per tick.

[ ... ]

> +static u64 sit9531x_derive_clock_id(struct sit9531x_dev *sitdev)
> +{
> +	u64 clkid;
> +	int adap;
> +
> +	adap = i2c_adapter_id(sitdev->client->adapter);
> +
> +	/*
> +	 * The OUI with its EUI-64 filler takes the top 40 bits.  Bus numbers
> +	 * are not bounded by the number of adapters -- a DT alias or a mux
> +	 * child can number a bus 256 or above on a board with a handful of
> +	 * them -- so the bus gets 16 bits.  The variant does not need a
> +	 * field: one address on one bus holds one part.
> +	 */
> +	clkid  = SIT9531X_OUI << 24;
> +	clkid |= (u64)(adap & 0xffff) << 8;
> +	clkid |= (u64)sitdev->client->addr;
> +
> +	return clkid;
> +}

[Severity: Low]
Is this identifier really an EUI-64? core.h documents the field as:

  * @clock_id:		IEEE 1588 EUI-64 clock identifier

But every board that puts the part on the same bus number and address
gets the same value under the SiTime OUI.

The value also depends on i2c_adapter_id(). That is allocated
dynamically unless DT aliases fix the bus numbers. On DT without
aliases, or on ACPI through PRP0001, can the clock_id change between
boots when adapters probe in a different order? Userspace that keys
its configuration on clock-id would then lose the device.

For comparison, zl3073x uses get_random_u64() and lets the user
override the clock_id through a devlink parameter, without claiming
an EUI-64.

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> new file mode 100644
> index 0000000000000..e88fa4e29bdf3
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -0,0 +1,411 @@

[ ... ]

> + * Advertising MANUAL and then refusing the one request MANUAL exists for
> + * is the worse of the two incomplete answers, and after merge it would be
> + * ABI.  A profile that sets manual select anyway is reported at probe,
> + * since the mode this driver reports would then be wrong.
> + */
> +static int
> +sit9531x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
> +		       enum dpll_mode *mode, struct netlink_ext_ack *extack)
> +{
> +	*mode = DPLL_MODE_AUTOMATIC;
> +
> +	return 0;
> +}

[Severity: Medium]
Should this report AUTOMATIC for a PLL whose profile sets
PLL_CONFIG1F bit 6 (manual active select)?

In that configuration the PLL follows its active-selection register,
the input-select pins, or the GPIO_INPUT_FUNC_CTRL5..8 code. It does
not arbitrate by priority. sit9531x_manual_sel_report() detects this
at probe but only logs it. The comment above agrees that the reported
mode would then be wrong.

The netlink mode attribute is uAPI. Once the priority patch adds
prio_set, a controller that sees AUTOMATIC would tune priorities the
hardware ignores.

Would it work to report MANUAL as both the current and the only
supported mode for such a PLL? That keeps the reported value correct
without implementing mode switching.

This code is the same at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016005823.13690-1-arouhi%40sitime.com
