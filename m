Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F0325783C;
	Wed,  9 Sep 2026 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960729; cv=none; b=kH9OWtSjomVy9R5oLWgqXSQbqDtnwXcDJPzf9f2qxKMUaSi5ew3Vc86uGoVVWPIb6o+IT/0CcGsxUVeDAoEDcptfoj/XjGqr0PTy/j9hbWlUe8OxZHmbwwRgJKARQx47A6Ty1sqmihPuZT3Mvjs1XG1p7GfOHRSbSIymNWOPmS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960729; c=relaxed/simple;
	bh=zSM5VG159u39sjNq+cytusn8LdltBLcuT7ogBYB1VzY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RDOKymJcCVbuh2JZoIM9GjvWd1lRRxXR6pTCvHGvSqGZQ0dlmGga4IAWoRtZaQ72c1rzHVCyzN1in7VR60Uo5ujgMJ3yFzSDqSCKaWm3nhRjOOOXbiyq6QmJNkMby04ZPlYWYF3RsZZLs7kVbNJPN55sYsylUIvueKddZcsOiU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsiotwiW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsiotwiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1771F00A3A;
	Wed,  9 Sep 2026 13:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960727;
	bh=X1wlPyWvp+uWft4BoVv1w+TvY56EVumeURiIwghSngs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QsiotwiW/hcUP7VhgD4gQ46+IS3ZUHEwBpHK1Tz1h0LyMEoem9LfaZMFrlYFe2Wt2
	 uGAJXjlA666hmUFCErsV11qxfLPgCGsslSygRruF5LOXP8b1wmBzr/aQlhIbYPEf71
	 phSPI1WdT8Xac6Wkh8TXEGF4Ks1O79fi20nYPkzYr1KZsguYT3EkElk4SyaGGEcVD/
	 LuLPZjwdfHn1+CvB3S62zAdWy93Q3GYVj/+AVKekIYzUb+zSuw8htb17pp/FhZn7SV
	 PkW8grsCsUTqw/r7QiN87vxvHvYig1R9J8RMmMhcuw53DG7hWlj7oBHSclvi98EKai
	 Cy4IJdikO5iUg==
Subject: Re: [PATCH net-next v2 1/8] r8152: refactor r8156_init
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Wed, 09 Sep 2026 13:32:06 +0000
Message-ID: <178896072650.219967.13636563786857215412@kernel.org>
In-Reply-To: <20260903072852.58695-2-nic_swsd@realtek.com>
References: <20260903072852.58695-2-nic_swsd@realtek.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 0

- [Medium] The commit message describes only a mechanical split ("Split
  r8156_init into per-chip functions"), but the new per-chip functions…
- [Medium] The new wait_autoload_done() helper
  (drivers/net/usb/r8152.c:4202) drops the per-iteration…
- [Medium] Converting the open-coded autoload polls into `if
  (wait_autoload_done(tp)) return;` turns a previously non-fatal, fall-…

--

r8152: refactor r8156_init

This splits the shared r8156_init() into per-chip initializers
(r8156_init, r8156b_init, r8157_init, r8159_init) and introduces a new
wait_autoload_done() helper based on read_poll_timeout() which replaces the
open-coded autoload polling loops in the RTL8153 and RTL8156 family init
and UPS paths.

A few questions below about the new helper and about init sequence changes
that reach chips other than RTL8157/RTL8159.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index f61686433031..013e8d1abfc2 100644
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

[Severity: Medium]
Should this poll also bail out when RTL8152_INACCESSIBLE is set?

Every loop replaced here checked the flag on each iteration, so an unplug
or a failed control transfer terminated the wait within one 20 ms step.
read_poll_timeout() only exits on ocp_data & AUTOLOAD_DONE or on the 10 s
timeout, so after rtl_set_unplug()/rtl_set_inaccessible() the wait keeps
sleeping for up to 10 s inside tp->rtl_ops.init(), r8153b_ups_en() and
r8153c_ups_en(), all of which run in process context holding tp->control
(and the USB device lock for probe/reset_resume/PM).

Is the polled value trustworthy in that state? generic_ocp_read() returns
-ENODEV before touching the caller's buffer when RTL8152_INACCESSIBLE is
set:

drivers/net/usb/r8152.c:generic_ocp_read() {
	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
		return -ENODEV;
	...
}

and ocp_read_word() ignores that return value while decoding an
uninitialized __le32 tmp, so the loop condition can be driven by
uninitialized stack data. On an ordinary transfer error get_registers()
fills the buffer with 0xff, which gives 0xffff and has AUTOLOAD_DONE
(BIT(1)) set, so the helper would report success.

Other polling helpers in this file, for example r8156b_wait_loading_flash(),
r8153_phy_status(), rtl_phy_patch_request() and rtl_disable(), still test
the flag on each iteration.

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

[ ... ]

> @@ -8351,90 +8331,132 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
>  	set_bit(PHY_RESET, &tp->flags);
>  }
>  
> -static int r8159_wait_backup_restore(struct r8152 *tp)
> +static void r8156_init(struct r8152 *tp)
>  {
> -	u32 ocp_data;
> +	u16 data;
>  
> -	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
> -	if (!(ocp_data & PCUT_STATUS))
> -		return 0;
> +	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> +		return;
>  
> -	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL),
> -			       ocp_data & BACKUP_RESTRORE, 200, 20000, false);
> +	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);

[ ... ]

> +	r8153b_power_cut_en(tp, false);
> +	r8156_ups_en(tp, false);
> +	r8153_queue_wake(tp, false);
> +	rtl_runtime_suspend_enable(tp, false);
> +
> +	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG, PREBOOT_OPTION);
> +
> +	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_RMT_WAKE, RMT_WAKE_EN);

[ ... ]

> -static void r8156_init(struct r8152 *tp)
> +static void r8156b_u2phy_backup(struct r8152 *tp)
> +{
> +	ocp_write_word(tp, MCU_TYPE_USB, 0xd3ce, 0x181b);
> +	ocp_write_dword(tp, MCU_TYPE_USB, 0xd3d0, 0x616ccd99);
> +	ocp_write_dword(tp, MCU_TYPE_USB, 0xd3d4, 0x08fc8101);
> +	ocp_write_dword(tp, MCU_TYPE_USB, 0xd3d8, 0x159b1100);
> +	ocp_write_word(tp, MCU_TYPE_USB, 0xd3dc, 0x0a00);
> +}

[Severity: Medium]
The commit message describes only a split ("Split r8156_init into per-chip
functions"), but the new functions also change what gets programmed on
chips that were already supported. Could the functional changes be split
into separate patches with their own descriptions?

RTL8156 (r8156_init) and RTL8156B (r8156b_init) both gain two writes the
old shared r8156_init() never did:

	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG, PREBOOT_OPTION);
	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_RMT_WAKE, RMT_WAKE_EN);

PLA_RMT_WAKE (0xe0c8) is a newly defined register that the baseline driver
never touched at all.

r8156b_init() also calls the new r8156b_u2phy_backup() magic write
sequence (USB 0xd3ce..0xd3dc) unconditionally on shipping RTL8156B parts.

For RTL8157/RTL8159, r8157_init() and r8159_init() now clear AUTO_SPEEDUP
in USB_FW_CTRL, which the baseline did only inside the
"version >= RTL_VER_12 && version <= RTL_VER_15" block, and add new
"Disable Interrupt Mitigation" (0xcf04 bits 0/1/2/7) and "Clear Warm RST /
Bus RST event flag" (0xcd06 BIT(11)) writes. r8159_init() adds a 0xb9a6
BIT(0) clear and ocp_write_word(0xb9a2, 0x0448) on top of that.

Was the reordering of r8156b_wait_loading_flash() intentional too? The
baseline called it before the autoload-done poll for VER_13/15/16/17, while
r8157_init() and r8159_init() now call it after the poll (and, for
RTL8159, after r8159_wait_backup_restore()).

[ ... ]

> @@ -8442,73 +8464,261 @@ static void r8156_init(struct r8152 *tp)
>  	/* U1/U2/L1 idle timer. 500 us */
>  	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
>  
> -	if (tp->version >= RTL_VER_16)
> -		r8157_power_cut_en(tp, false);
> -	else
> -		r8153b_power_cut_en(tp, false);
> +	r8156b_u2phy_backup(tp);
>  
> +	r8153b_power_cut_en(tp, false);
>  	r8156_ups_en(tp, false);
>  	r8153_queue_wake(tp, false);
>  	rtl_runtime_suspend_enable(tp, false);
>  

[ ... ]

> +static void r8159_init(struct r8152 *tp)
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
> +
> +	if (r8159_wait_backup_restore(tp)) {
> +		rtl_set_inaccessible(tp);
> +		dev_err(&tp->intf->dev,
> +			"init failed, backup-restore timed out\n");
> +		return;
>  	}

[Severity: Medium]
Should the autoload timeout latch the failure the way the backup-restore
timeout right below it does?

Two adjacent "the chip never came up" conditions in the same function are
handled differently: r8159_wait_backup_restore() failure calls
rtl_set_inaccessible() and logs, while wait_autoload_done() failure just
returns.

Before this patch a timeout fell through and the rest of the init sequence
still ran. Now r8153_init(), r8153b_init(), r8153c_init(), r8156_init(),
r8156b_init(), r8157_init() and r8159_init() return after only the first
few writes (U1/U2 disabled, EN_ALL_SPEED cleared, BYPASS_MAC_RESET set,
plus the 0xcffe/0xd3ca SW reset writes for RTL8157/8159), skipping the
BMCR_PDOWN clear, power-cut/UPS disable, the MSC and U1/U2 timers,
usb_enable_lpm(), the USB_USB_CTRL RX aggregation and descriptor format
bits, rtl_bmu_clr_bits(), r8156_mdio_force_mode(), rtl_tally_reset() and
the trailing tp->coalesce = 15000.

Since ops->init returns void and nothing sets RTL8152_INACCESSIBLE on this
path, can rtl8152_probe_once() still queue hw_phy_work and register a
netdev whose PHY may still be in BMCR_PDOWN and whose bulk-in/RX
descriptor configuration was never written? Does rtl8152_reset_resume()
likewise continue into rtl8152_resume() unaware that init was abandoned?

tp->coalesce is left at 0 from the zeroed netdev private data in that case,
and is later consumed as tp->coalesce / 8 by r8153_set_rx_early_timeout()
and reported as 0 by rtl8152_get_coalesce().

The same conversion in r8153b_ups_en() and r8153c_ups_en() now skips
tp->rtl_ops.hw_phy_cfg() and the speed restoration on a plain timeout, and
in r8153c_ups_en() it additionally skips the trailing
PLA_CRWECR/PLA_CONFIG34 BIT(8)/PLA_CRWECR sequence that previously always
ran.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903072852.58695-1-nic_swsd%40realtek.com
