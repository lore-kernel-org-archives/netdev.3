Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863833EE1D4;
	Sat, 12 Sep 2026 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244393; cv=none; b=tBys+elr+gogwknMPi6jMEM8u+vqWMpXE2oGYMI9aCq15o6qbK4r40ehmoedi3o2Rar6vUO2Xvo83kUmQjZPrXY4J7BDZerKBJKpxNM+upmTzNGDmrTjN3VxFGZmm3K5hnG2q6HYrb9M4n+PcTLmkq6etjOJ9u2/SUSjDu2ksOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244393; c=relaxed/simple;
	bh=8KDiagFVF/56cSIM7a9Abw3YjlECzCBnp2f34urURrc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E1gMQLLkKkASSXu7p9r/YgVnVVTd+Ceo9b3DWtfzd1F/UKBN5vktaHCHGCxGlgv+LuNChX3sO+ayGpgwawTwXpmzHJpWoorBoJZYLAKoOXv8NRo89yXMK23qM6hACmsw+XGNx6i/0s9JHip7J48SQRlXVE6KaCy2frfcIGEY4hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNteXKUR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNteXKUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4001F000FF;
	Sat, 12 Sep 2026 20:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244391;
	bh=OQ9NVScvgC4BMkM7GTv869E+8Lvyv75U1Iz3a0deaNk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZNteXKURJLNxVIh3/9pYFjUkHAWx88TF/5Uor1RhEb2ubsid/dYfke1EY/to9fS7D
	 GHA20mzT215OoPRmsMojOZNh0zyN2nUd1p8MNQsZYvqAaFYbD0fHqR7wPdABKq/uTP
	 PY0DH8NfE8/+WNkXSHht70sE0lcc+UrFLZqHRbhb8DbvxIfOCGoNg0MjRxwiU+4Xio
	 YL9Z2Zd7ZQoxbLqTy7kCxBGvsTu+7wY5f9F/7Yo95bn6CZDXDzrcLHHAZQeaJHidsh
	 t9OiuWODrQlXh5QjsU75Ub3gMlx7AObeMZSnFhnY72qDMuxlQFfMGJAEd1ewuj1kCU
	 cdEiXN0LD3nRg==
Subject: Re: [PATCH net-next v3 3/8] r8152: refactor rtl8156_enable,
 rtl8156_up, and rtl8156_down
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Sat, 12 Sep 2026 20:19:50 +0000
Message-ID: <178924439038.3125.16601942086126763280@kernel.org>
In-Reply-To: <20260908075634.23740-4-nic_swsd@realtek.com>
References: <20260908075634.23740-4-nic_swsd@realtek.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 3 · Low: 0

- [High] Version guard collapsed in the wrong direction:
  `ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3))` in…
- [High] During the split of rtl8156_up()/rtl8156_down(), the two power-
  management writes for RTL8157/RTL8159 (RTL_VER_16,…
- [Medium] The commit message describes a pure code-motion refactor ("Add
  dedicated rtl8156b_enable (VER_12/13/15), rtl8157_enable, rtl8157_up,…
- [Medium] rtl8156_down() (RTL_VER_10/11 and RTL_VER_12/13/15) and the
  new rtl8157_down() (RTL_VER_16/17) both add two OOB hand-off register…
- [Medium] New 'Clear_SDR' hardware programming is introduced with raw
  register addresses and no symbolic defines: `ocp_word_set_bits(tp,…

--

r8152: refactor rtl8156_enable, rtl8156_up, and rtl8156_down

This splits the shared RTL8156 enable/up/down handlers into per-family
variants: rtl8156b_enable() for RTL_VER_12/13/15 and rtl8157_enable(),
rtl8157_up(), rtl8157_down() for RTL_VER_16/17.  The inline version
guards inside rtl8156_enable(), rtl8156_up() and rtl8156_down() are
dropped and rtl_ops_init() is updated to install the new callbacks.

[Severity: Medium]
The changelog reads as a pure code-motion refactor:

  "Add dedicated rtl8156b_enable (VER_12/13/15), rtl8157_enable,
   rtl8157_up, and rtl8157_down (VER_16/17) instead of handling
   per-version differences with inline version guards."

But rtl8156_up() and rtl8156_down() themselves are also modified, and
several register writes change for every family involved:

  - PLA_RCR1 BIT(3) clear becomes unconditional in rtl8156_up(), so it
    is now a new write on RTL8156/RTL8156B.
  - a new "Enable Clear_SDR" write to USB 0xd3ca BIT(15) for
    RTL_VER_13/15 in rtl8156_up().
  - rtl8156_down() replaces the bare PLA_OOB_CTRL |= NOW_IS_OOB with
    PLA_BDC_CR |= ALDPS_PROXY_MODE plus
    PLA_OOB_CTRL |= NOW_IS_OOB | DIS_MCU_CLROOB.
  - rtl8157_up() performs the USB_SPEED_OPTION clear that the baseline
    skipped for RTL_VER_16+, drops the PLA_MCU_SPDWN_EN clear, and adds
    two new writes (USB 0xd378 BIT(7) set, USB 0xcd06 BIT(15) clear).
  - rtl8157_down() changes PLA_RMS/PLA_MTPS and drops the
    PLA_MCU_SPDWN_EN set.

Could the changelog describe these hardware programming changes, or could
they be split into separate patches so they can be reverted or bisected
independently of the refactor?

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index f01f442fa71a0..6c189790b0bab 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -6869,8 +6912,7 @@ static void rtl8156_up(struct r8152 *tp)
>  
>  	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
>  
> -	if (tp->version >= RTL_VER_16)
> -		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));
> +	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));

[Severity: High]
Was this guard collapsed in the wrong direction?  After the split,
rtl_ops_init() installs rtl8156_up() only for RTL_VER_10/11 and
RTL_VER_12/13/15, and gives RTL_VER_16/17 the new rtl8157_up():

	ops->up			= rtl8156_up;	/* VER_10/11, VER_12/13/15 */
	...
	ops->up			= rtl8157_up;	/* VER_16, VER_17_QFN68/100 */

So the "tp->version >= RTL_VER_16" condition can no longer be true in
rtl8156_up(), which suggests the write should have been removed together
with its guard rather than made unconditional.  The new rtl8157_up()
already contains the identical write:

	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1, BIT(3));

Does this mean RTL8156/RTL8156B now clear bit 3 of PLA_RCR1 (0xc012) on
every bring-up and resume, a write those parts never received before?
The driver only names OUTER_VLAN BIT(7) and INNER_VLAN BIT(6) for that
register, so the effect of BIT(3) on those chips is not obvious from the
code.

>  
>  	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
>  
> @@ -6892,11 +6934,11 @@ static void rtl8156_up(struct r8152 *tp)
>  	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
>  		      0x08);
>  
> -	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
> +	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
> +			  PLA_MCU_SPDWN_EN);
>  
> -	if (tp->version < RTL_VER_16)
> -		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
> -				  RG_PWRDN_EN | ALL_SPEED_OFF);
> +	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
> +			  RG_PWRDN_EN | ALL_SPEED_OFF);
>  
>  	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
>  
> @@ -6906,10 +6948,19 @@ static void rtl8156_up(struct r8152 *tp)
>  	}
>  
>  	r8153_aldps_en(tp, true);
> -	if (tp->version < RTL_VER_16)
> -		r8153_u2p3en(tp, true);
> +	r8153_u2p3en(tp, true);
>  
> -	if (tp->version < RTL_VER_16 && tp->udev->speed >= USB_SPEED_SUPER)
> +	switch (tp->version) {
> +	case RTL_VER_13:
> +	case RTL_VER_15:
> +		/* Enable Clear_SDR */
> +		ocp_word_set_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(15));
> +		break;
> +	default:
> +		break;
> +	}

[Severity: Medium]
This "Clear_SDR" programming is new, has no baseline counterpart, and
uses a raw address with no #define.  Two questions about it:

The same USB address is accessed as a byte register elsewhere in this
file, in r8157_init() and r8159_init():

	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(0));

while the new code does a 16-bit read-modify-write covering
0xd3ca..0xd3cb and sets BIT(15).  Is the upper byte a plain read/write
field?  If any of it is W1C or status, can this read-modify-write clobber
unrelated state?

Also, RTL_VER_12 is RTL8156B silicon as well but is excluded here.  Is
VER_12 genuinely unaffected, or was it missed?

There is no matching clear of this bit in rtl8156_down().  Is the bit
expected to persist across an ifdown/ifup cycle?

> +
> +	if (tp->udev->speed >= USB_SPEED_SUPER)
>  		r8153b_u1u2en(tp, true);
>  }
>  
> @@ -6922,12 +6973,9 @@ static void rtl8156_down(struct r8152 *tp)
>  
>  	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
>  			  PLA_MCU_SPDWN_EN);
> -
>  	r8153b_u1u2en(tp, false);
> -	if (tp->version < RTL_VER_16) {
> -		r8153_u2p3en(tp, false);
> -		r8153b_power_cut_en(tp, false);
> -	}
> +	r8153_u2p3en(tp, false);
> +	r8153b_power_cut_en(tp, false);
>  	r8153_aldps_en(tp, false);
>  
>  	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
> @@ -6949,7 +6997,102 @@ static void rtl8156_down(struct r8152 *tp)
>  	 */
>  	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TEREDO_WAKE_BASE, 0x00ff);
>  
> -	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
> +	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_BDC_CR, ALDPS_PROXY_MODE);
> +
> +	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL,
> +			  NOW_IS_OOB | DIS_MCU_CLROOB);

[Severity: Medium]
These two writes are new for the chips rtl8156_down() still serves
(RTL_VER_10/11 and RTL_VER_12/13/15 per rtl_ops_init()).  The baseline
ended the OOB entry with only:

	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);

ALDPS_PROXY_MODE in PLA_BDC_CR and DIS_MCU_CLROOB in PLA_OOB_CTRL change
who owns OOB state and how the MCU proxies during ALDPS, so does this
alter WoL and ARP-proxy behaviour on RTL8156/RTL8156B after an ifdown or
suspend?  The same two writes are added to rtl8157_down() below.

It looks like this brings 8156 in line with r8152b_enter_oob() and
r8153_enter_oob(), which do program both bits.  If that is the intent,
could it be stated in the changelog or split out so a WoL regression
report can be traced back to it?

> +
> +	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
> +
> +	rtl_rx_vlan_en(tp, true);
> +	rxdy_gated_en(tp, false);
> +
> +	ocp_dword_set_bits(tp, MCU_TYPE_PLA, PLA_RCR,
> +			   RCR_APM | RCR_AM | RCR_AB);
> +
> +	r8153_aldps_en(tp, true);
> +}
> +
> +static void rtl8157_up(struct r8152 *tp)
> +{

[ ... ]

> +	/* share FIFO settings */
> +	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
> +		      0x08);
> +
> +	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
> +			  RG_PWRDN_EN | ALL_SPEED_OFF);

[Severity: High]
Are the two power-management writes for RTL8157/RTL8159 swapped here?

The baseline guarded this USB_SPEED_OPTION clear specifically to exclude
these versions:

	if (tp->version < RTL_VER_16)
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
				  RG_PWRDN_EN | ALL_SPEED_OFF);

and rtl8157_up() is installed only for RTL_VER_16 and
RTL_VER_17_QFN68/QFN100, so this now runs on exactly the parts the guard
excluded.  Does clearing RG_PWRDN_EN | ALL_SPEED_OFF change PHY power
management on 8157/8159?

In the other direction, the PLA_MCU_SPDWN_EN clear that rtl8156_up()
does just before this point is missing from rtl8157_up(), and the paired
set is missing from rtl8157_down().  The baseline did both
unconditionally for RTL_VER_16/17, and grepping the file after this patch
the remaining PLA_MCU_SPDWN_EN sites are rtl8153b_up/down, rtl8153c_up,
rtl8156_up/down, r8153b_init, r8156_init and r8156b_init - none of which
are reachable for VER_16/17, and r8157_init()/r8159_init() only clear it
"if (tp->version < RTL_VER_16)".

Does that leave PLA_MAC_PWR_CTRL3 PLA_MCU_SPDWN_EN at whatever value the
ROM, OOB firmware or a previous driver instance left while the interface
is up on those chips?

> +
> +	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
> +
> +	if (tp->saved_wolopts != __rtl_get_wol(tp)) {
> +		netif_warn(tp, ifup, tp->netdev, "wol setting is changed\n");
> +		__rtl_set_wol(tp, tp->saved_wolopts);
> +	}
> +
> +	r8153_aldps_en(tp, true);
> +
> +	/* Clear_SDR */
> +	ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xd378, BIT(7));
> +	ocp_word_clr_bits(tp, MCU_TYPE_USB, 0xcd06, BIT(15));

[Severity: Medium]
These two writes have no baseline counterpart, no symbolic defines, and
no matching undo in rtl8157_down().  Could they get names, and is the
comment "Clear_SDR" enough to explain what the two different addresses
do?

> +}
> +
> +static void rtl8157_down(struct r8152 *tp)
> +{

[ ... ]

> +	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, 1526);
> +	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, 10 * 1024 / 64);

[Severity: Medium]
The baseline down path applied 1522 and MTPS_DEFAULT for RTL_VER_16/17.
Is the change to 1526 and 10 * 1024 / 64 intentional, and could it be
mentioned in the changelog?

> +
> +	/* Clear teredo wake event. bit[15:8] is the teredo wakeup
> +	 * type. Set it to zero. bits[7:0] are the W1C bits about
> +	 * the events. Set them to all 1 to clear them.
> +	 */
> +	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TEREDO_WAKE_BASE, 0x00ff);
> +
> +	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_BDC_CR, ALDPS_PROXY_MODE);
> +
> +	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL,
> +			  NOW_IS_OOB | DIS_MCU_CLROOB);
>  
>  	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
>  
> @@ -10071,7 +10214,7 @@ static int rtl_ops_init(struct r8152 *tp)
>  		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
>  		tp->eee_adv2		= MDIO_EEE_2_5GT;
>  		ops->init		= r8156b_init;
> -		ops->enable		= rtl8156_enable;
> +		ops->enable		= rtl8156b_enable;
>  		ops->disable		= rtl8153_disable;
>  		ops->up			= rtl8156_up;
>  		ops->down		= rtl8156_down;
> @@ -10110,10 +10253,10 @@ static int rtl_ops_init(struct r8152 *tp)
>  		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
>  		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
>  		ops->init		= r8157_init;
> -		ops->enable		= rtl8156_enable;
> +		ops->enable		= rtl8157_enable;
>  		ops->disable		= rtl8153_disable;
> -		ops->up			= rtl8156_up;
> -		ops->down		= rtl8156_down;
> +		ops->up			= rtl8157_up;
> +		ops->down		= rtl8157_down;

[ ... ]

For reference, none of the above is changed later in the series; the
same code is still present in rtl8156_up(), rtl8156_down(),
rtl8157_up() and rtl8157_down() at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908075634.23740-1-nic_swsd%40realtek.com
