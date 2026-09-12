Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF913D53C;
	Sat, 12 Sep 2026 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244390; cv=none; b=O1PJJsdv6t7AKH163M5mUdG0IMwrvQ2RztFI8qaRZ61Zddx9h8jF1A2kdQjPyBdhAsR4ZjXbq5JDgrLaNOhRRDhRUWRYYnTUj/ncjCazuoVRIEJt8d6R1pcH7kKx63cSJZ8QZ/lG82FTzTIn9U7e9DCxceCUYaTb4KijRBs0mHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244390; c=relaxed/simple;
	bh=AUKycJACMVz2Gk21IN24EX2E4oM2G13pkuX1hgS6AaM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fiM3cHcSwR7FZItH0vWAsh/ydag4HRih2Kzhj9WOcTwu704wwmibcrNgC6eEFrVegzJ605EQ2F3347803XSh/lErNP6Bq9YZIqNfd5WkIW4nyCiU4NkszqulDwXQwazXtOm8Surezw/7NoCI/LQQFG2GIpMtZKynzwe1A0iIEPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9edPZ5H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9edPZ5H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446C81F000FF;
	Sat, 12 Sep 2026 20:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244388;
	bh=3ZOeXZk4a6bXWzhlnINYnl7uianZzMfav2/SWA/BfTs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T9edPZ5Hy/biZ9093QAp1VUgDpnCsHF0H28JM9d2ubr67+H7I4As/Qump2YFOYzL4
	 brXZxu+ri98VzUc8Bf6MkBPMJ62ZNOOHHMgk5lHDYJLdsO4Az6AcfaUSmvEWN/5SVU
	 fa1vyFxnbJGjrzwHXhSIermuDF2+BXSlnr7IJ3TGmRh9iqL+isZSmGCrce11LrekFX
	 Pzi+uEOwqWhsKCP71gIqXVyAZVrwtN53oOlzt0neO+HbIBXi209T+8uQmp+6UGpt1k
	 wr1Jd+W9CGASa4hF6aycHR/O3gF3bciTO9c/C1m9DzA2lnhAnJpDJ9Y0XSOsGpFjQf
	 kXhIDQdFHYUpg==
Subject: Re: [PATCH net-next v3 1/8] r8152: refactor r8156_init
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Sat, 12 Sep 2026 20:19:47 +0000
Message-ID: <178924438783.3125.10975381287375934654@kernel.org>
In-Reply-To: <20260908075634.23740-2-nic_swsd@realtek.com>
References: <20260908075634.23740-2-nic_swsd@realtek.com>
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
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 2 (1) · Low: 0

- [High] wait_autoload_done() drops the per-iteration
  test_bit(RTL8152_INACCESSIBLE, &tp->flags) abort that every one of the…
- [High] On a genuine autoload timeout the new `if
  (wait_autoload_done(tp)) return;` aborts initialization mid-sequence…
- [Medium] Commit message mischaracterizes the change: a patch titled
  "refactor r8156_init" adds brand-new hardware programming and changes…
- [Medium] The new wait_autoload_done() helper is applied to five open-
  coded autoload-done loops that belong to chips outside the patch's…

Pre-existing issues:
- [Medium] `tp->coalesce = 15000;` carries the comment `/* 15 us */`, but
  tp->coalesce is exported verbatim to userspace as…

--

r8152: refactor r8156_init

This splits the shared r8156_init() into per-chip init functions for
RTL8156, RTL8156B, RTL8157 and RTL8159, and introduces a new
wait_autoload_done() helper that replaces the open-coded autoload-done
poll loops in several init and UPS paths.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index f61686433031c..013e8d1abfc24 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -78,6 +78,7 @@
>  #define PLA_EEE_TXTWSYS_2P5G	0xe058
>  #define PLA_EEEP_CR		0xe080
>  #define PLA_MAC_PWR_CTRL	0xe0c0
> +#define PLA_RMT_WAKE		0xe0c8
>  #define PLA_MAC_PWR_CTRL2	0xe0ca
>  #define PLA_MAC_PWR_CTRL3	0xe0cc
>  #define PLA_MAC_PWR_CTRL4	0xe0ce
> @@ -371,6 +372,9 @@
>  #define MCU_CLK_RATIO_MASK	0x0f0f0f0f
>  #define ALDPS_SPDWN_RATIO	0x0f87
>  
> +/* PLA_RMT_WAKE */
> +#define RMT_WAKE_EN		BIT(0)
> +
>  /* PLA_MAC_PWR_CTRL2 */
>  #define EEE_SPDWN_RATIO		0x8007
>  #define MAC_CLK_SPDWN_EN	BIT(15)
> @@ -417,6 +421,7 @@
>  
>  /* PLA_INDICATE_FALG */
>  #define UPCOMING_RUNTIME_D3	BIT(0)
> +#define PREBOOT_OPTION		BIT(1)

[Severity: Medium]

The changelog says:

    Split r8156_init into per-chip functions:
    - r8156_init (VER_10/11)
    - r8156b_init (VER_12/13/15)
    - r8157_init (VER_16)
    - r8159_init (VER_17)

Is that a complete description of what the patch does?  These new register
and bit definitions have no user in the baseline, so the clears that use
them are new hardware programming rather than code motion:

  PLA_RMT_WAKE (0xe0c8) / RMT_WAKE_EN
  PLA_INDICATE_FALG / PREBOOT_OPTION

The same applies to several other writes that appear only after this patch:

  r8156b_u2phy_backup(): USB 0xd3ce/0xd3d0/0xd3d4/0xd3d8/0xd3dc
  r8157_init() and r8159_init(): USB 0xcd06 BIT(11) clear
  r8159_init(): USB 0xb9a6 BIT(0) clear and the write 0xb9a2 = 0x0448

A few existing sequences also change behaviour: AUTO_SPEEDUP is now cleared
for VER_16/VER_17 (previously only inside the VER_12..VER_15 block), the
0xcf04 interrupt-mitigation clear now also runs during init (previously
only in the unload path), and r8156b_wait_loading_flash() moved from before
the autoload poll to after it for VER_16/17.

Would it be possible to split the mechanical function split from the new
chip programming, so that a regression on RTL8156/8156B/8157/8159 does not
bisect to a commit that describes itself as a pure refactor?

[ ... ]

> @@ -4193,6 +4199,22 @@ static u16 r8153_phy_status(struct r8152 *tp, u16 desired)
>  	return data;
>  }
>  
> +static int wait_autoload_done(struct r8152 *tp)
> +{
> +	u16 ocp_data;
> +	int ret;
> +
> +	ret = read_poll_timeout(ocp_read_word, ocp_data,
> +				ocp_data & AUTOLOAD_DONE, 20000,
> +				10 * USEC_PER_SEC, false, tp, MCU_TYPE_PLA,
> +				PLA_BOOT_CTRL);
> +
> +	if (ret)
> +		dev_err(&tp->intf->dev, "autoload done timeout\n");
> +
> +	return ret;
> +}
> +

[Severity: High]

Every loop this helper replaces tested RTL8152_INACCESSIBLE on each
iteration, but the new poll has no exit other than the condition or the
10 second deadline.  Can this keep sleeping for 10 seconds under
tp->control after the device is gone?

Once RTL8152_INACCESSIBLE is set (rtl_set_unplug() on disconnect, pre-reset,
or a failed control transfer), the read never touches the caller's buffer:

drivers/net/usb/r8152.c:generic_ocp_read() {
	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
		return -ENODEV;
	...
}

and ocp_read_word() ignores that error while converting an uninitialized
variable:

drivers/net/usb/r8152.c:ocp_read_word() {
	u32 data;
	__le32 tmp;
	...
	generic_ocp_read(tp, index, sizeof(tmp), &tmp, type | byen);

	data = __le32_to_cpu(tmp);
	...
}

So is the poll condition ocp_data & AUTOLOAD_DONE decided by stack garbage
in that state?  If bit 1 happens to be set, wait_autoload_done() reports
success and the caller programs the whole bring-up sequence, including
tp->rtl_ops.hw_phy_cfg() from r8153b_ups_en()/r8153c_ups_en(), against a
device that is already gone.  If bit 1 is clear, the caller sleeps the full
10 seconds and then logs a timeout that did not really happen.

There is a related case on plain transfer failures:

drivers/net/usb/r8152.c:get_registers() {
	...
	if (ret < 0)
		memset(data, 0xff, size);
	...
}

0xffff & AUTOLOAD_DONE (0x0002) is non-zero, so the poll reports completion
on read errors too.

All the other wait loops in this file (r8153_phy_status(),
r8156b_wait_loading_flash(), rtl_phy_patch_request(), rtl_disable(),
r8153_aldps_en()) still honour RTL8152_INACCESSIBLE.  Should the poll
condition terminate on that flag as well, and should the read path preserve
the error status instead of returning an undefined value?

>  static void r8153b_ups_en(struct r8152 *tp, bool enable)
>  {
>  	if (enable) {
> @@ -4211,16 +4233,8 @@ static void r8153b_ups_en(struct r8152 *tp, bool enable)
>  				  UPS_FORCE_PWR_DOWN);
>  
>  		if (ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0) & PCUT_STATUS) {
> -			int i;
> -
> -			for (i = 0; i < 500; i++) {
> -				if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> -					return;
> -				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
> -				    AUTOLOAD_DONE)
> -					break;
> -				msleep(20);
> -			}
> +			if (wait_autoload_done(tp))
> +				return;
>  
>  			tp->rtl_ops.hw_phy_cfg(tp);
>  

[ ... ]

> @@ -7246,22 +7252,14 @@ static void r8152b_init(struct r8152 *tp)
>  static void r8153_init(struct r8152 *tp)
>  {
>  	u32 ocp_data;
> -	int i;
>  
>  	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>  		return;
>  
>  	r8153_u1u2en(tp, false);
>  
> -	for (i = 0; i < 500; i++) {
> -		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
> -		    AUTOLOAD_DONE)
> -			break;
> -
> -		msleep(20);
> -		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> -			break;
> -	}
> +	if (wait_autoload_done(tp))
> +		return;
>  
>  	r8153_phy_status(tp, 0);
>  

[Severity: Medium]

The helper is also applied to five call sites outside the chips named in
the changelog: r8153_init() (VER_03..06), r8153b_init() (VER_08/09),
r8153c_init() (VER_14), r8153b_ups_en() and r8153c_ups_en().

For r8153_init() and r8153b_init() the previous poll only did break on
expiry and then executed the rest of the bring-up (power-cut disable,
u1u2 re-enable, LPM, RX aggregation, rtl_tally_reset(), and the
tp->coalesce assignment at the tail of r8153_init).  With the new

	if (wait_autoload_done(tp))
		return;

all of that is skipped instead.  The helper also newly emits
dev_err("autoload done timeout") on paths that were previously silent, and
drops the per-iteration test_bit(RTL8152_INACCESSIBLE, &tp->flags) abort.

Is this change of failure semantics on the RTL8153/8153B/8153C families
intended?  Right now a regression there would bisect to a commit titled
"r8152: refactor r8156_init".

[ ... ]

> @@ -8351,90 +8331,132 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  	set_bit(PHY_RESET, &tp->flags);
>  }
>  
> -static int r8159_wait_backup_restore(struct r8152 *tp)
> +static void r8156_init(struct r8152 *tp)
>  {

[ ... ]

> +	r8156_mdio_force_mode(tp);
> +	rtl_tally_reset(tp);
> +
> +	tp->coalesce = 15000; /* 15 us */
>  }

[Severity: Medium]

This is a pre-existing issue and not introduced by this patch, but the
comment and the value disagree with the unit that is exported to
userspace.  tp->coalesce is handed to ethtool verbatim as
ETHTOOL_COALESCE_USECS:

drivers/net/usb/r8152.c:rtl8152_get_coalesce() {
	...
	coalesce->rx_coalesce_usecs = tp->coalesce;
	...
}

drivers/net/usb/r8152.c:rtl8152_set_coalesce() {
	...
	tp->coalesce = coalesce->rx_coalesce_usecs;
	...
}

while the internal unit is nanoseconds, one register tick being 8 ns:

drivers/net/usb/r8152.c:r8153_set_rx_early_timeout() {
	u32 ocp_data = tp->coalesce / 8;
	...
	/* ... For USB_RX_EARLY_TIMEOUT, we fix it to 128ns. */
	ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_TIMEOUT, 128 / 8);
	...
}

So ethtool -c reports rx-usecs 15000 for a 15 us setting, and
ethtool -C rx-usecs 15 programs about 15 ns.  Since this patch replicates
the same constant and comment into r8156b_init(), r8157_init() and
r8159_init(), would it make sense to fix the unit (or at least the comment)
while these functions are being created?

> +
> +static void r8157_init(struct r8152 *tp)
> +{
> +	u16 data;
> +
> +	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> +		return;
> +
> +	/* Enable SW reset */
> +	ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xcffe, BIT(3));
> +	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd3ca, BIT(0));
> +
> +	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
> +
> +	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION, BYPASS_MAC_RESET);
> +
> +	r8153b_u1u2en(tp, false);
> +
> +	if (wait_autoload_done(tp))
> +		return;

[Severity: High]

On a real autoload timeout this returns in the middle of the sequence, after
the SW reset bits (0xcffe BIT(3), 0xd3ca BIT(0)) and the U1/U2 disable have
already been applied, and without marking the device inaccessible.

What state does the adapter end up in?  The rest of the function is skipped:
r8153b_u1u2en(tp, true), usb_enable_lpm(), r8156_mac_clk_spd(), the
PLA_MCU_SPDWN_EN clear, the PLA_EXTRA_STATUS link polling setup, the RX
aggregation / RX_DESC_16B / BMU programming, r8156_mdio_force_mode(),
rtl_tally_reset() and tp->coalesce.

tp->coalesce then stays 0 in the freshly allocated private area, and:

drivers/net/usb/r8152.c:r8153_set_rx_early_timeout() {
	u32 ocp_data = tp->coalesce / 8;
	...
}

programs USB_RX_EARLY_TIMEOUT / USB_RX_EXTRA_AGGR_TMR with 0.  The same
applies to r8153_init(), where the tp->coalesce = COALESCE_SUPER/HIGH/SLOW
switch sits at the very end of the function.

Since ops->init is void and the timeout path sets neither
RTL8152_INACCESSIBLE nor PROBE_SHOULD_RETRY, does anything upstream learn
about the failure?  rtl8152_probe_once() still registers the netdev and
rtl8152_reset_resume() still continues into the normal resume path.

The intended contract seems to be the one used a few lines below in the
same patch for the other failure of the same class:

> +	if (r8159_wait_backup_restore(tp)) {
> +		rtl_set_inaccessible(tp);
> +		dev_err(&tp->intf->dev,
> +			"init failed, backup-restore timed out\n");
> +		return;
>  	}

Should the autoload timeout do the same (rtl_set_inaccessible() plus an
error), so the device is not registered and used half-programmed?

The same early return in r8153b_ups_en()/r8153c_ups_en() skips
hw_phy_cfg() and rtl8152_set_speed() right after the chip left power-cut,
and in r8153c_ups_en() also the trailing PLA_CRWECR/PLA_CONFIG34 writes
that previously always ran.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908075634.23740-1-nic_swsd%40realtek.com
