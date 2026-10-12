Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F81473C8B;
	Mon, 12 Oct 2026 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795975; cv=none; b=tkgyssZVqOCTS+pddORQzFNfPahFHxG+Rgrs3CIo6C1Hu6MNYQ5jd/Ddo15gkLC6rHjeZ4zJje5LMgTBQ7KboVfHKZ2xZARFtiMtE8QEHkOd2MqkHIcmW3c92aygL9ID+Uj4dz2aJXnvDLcF84RNxm7M04eg/G+jkmQ3u0owP/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795975; c=relaxed/simple;
	bh=ELra+itGMZW4o1yA+Ml2GNaPl0baqErmCJ4VpYAUCkA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qj6wlU/2Li8enAlfzMUTAkVu8SKkHTCnLmWFVllIARCxIWAVbygto1SypKtgzmLuoY8BORRI4VFI3N27Mmbvx1LxZDhgWuAqu9dS4UCepPZXbVO9bMGHR3iLhkUD06Pae6XH2F5MEJz4M1dWz2lzAP2TJtnTVtNULycbv9BmcaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWYtcP+e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWYtcP+e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAB11F0089B;
	Mon, 12 Oct 2026 09:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795973;
	bh=BR2asC40CkjKnTQcQcTqOVLC1yyX/RYyprqTUDz0ryg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bWYtcP+ezwUTar/SRJVvX7Ul7HNRmbKkQ8CWe9WGJfSFj4/4kqQq3wBQjgx6SuJgE
	 g/+LIWmj/1u3JywQsakMvd3ZyHcvJ56JS96xLahqAu6/9dui6fcA7KF5GC757AC4DF
	 3giuovwmWP+Aie+dA6g2HZaXR5cLnGEpTyr8LR1M7h/WarG9jU8adaBcUnXEqWdg0F
	 ZNtTu0GPpXDqlmteo/QXJGWx3Y3UNGlffAo4hCfwb5aIQlBd8nRxUqgsMD3zoy6MWQ
	 NN94NsMyo+mrtxb3XUmJ0LCOfcUNsylGaK14U1c3OA/NGLFS5dX0V0zS9CEhTrD6Vh
	 5clKyuV28W4Ww==
Subject: Re: [PATCH net-next v6 08/10] r8152: add TGPHY register access for
 RTL8157 and RTL8159
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch,
 mail@birger-koblitz.de
Date: Mon, 12 Oct 2026 09:06:12 +0000
Message-ID: <179179597215.434549.4684180030649022864@kernel.org>
In-Reply-To: <20261008081556.47901-9-nic_swsd@realtek.com>
References: <20261008081556.47901-9-nic_swsd@realtek.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 8 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On the MII library path, a TGPHY timeout can write a corrupted
  BMCR value to the PHY.
- [High] rtl_phy_patch_request() still ignores whether the PATCH_REQUEST
  write succeeded, even though the commit message lists 'the PHY patch…
- [High] rtl8152_set_speed() still throws away the status of its
  advertisement writes, although the commit message lists it among the…
- [Medium] The two new `return ret;` error paths in
  rtl_phy_patch_request() leave PATCH_REQUEST asserted.
- [Medium] rtl8152_set_speed() now returns early after it has already
  changed hardware and driver state, and it can lose a pending PHY reset.
- [Medium] r8153_phy_status() now gives up its PHY readiness wait (up to
  500 × 20 ms) on the first failed ocp_reg_read().
- [Medium] On a read failure, rtl8153_in_nway() now returns false, which
  permits autosuspend while the PHY may be negotiating.
- [Medium] PHY SRAM is programmed by writing OCP_SRAM_ADDR once and then
  streaming consecutive words to OCP_SRAM_DATA, with the hardware auto-…
- [Medium] The patch moves RTL8157/RTL8159 off a PHY access path that
  cannot fail (r8152_phy_read()/r8152_phy_write()) onto the TGPHY…
- [Medium] A stuck TGPHY channel turns PHY bring-up and firmware loading
  into a long stall that floods the kernel log.
- [Medium] Several statements in the commit message do not match the
  code.

--

r8152: add TGPHY register access for RTL8157 and RTL8159

This patch adds a TGPHY command channel (USB_TGPHY_ADDR/DATA/CMD) for PHY
register access on RTL8157 and RTL8159. It turns ocp_reg_read() and
ocp_reg_write() into wrappers over new per-chip rtl_ops.phy_read and
rtl_ops.phy_write hooks. The PHY accessors and the helpers built on them now
return int, and the status is propagated in a subset of callers.

> RTL8157 and RTL8159 can reach PHY registers through the same
> OCP-base-switching path as earlier chips, but they also provide a
> TGPHY command channel (USB_TGPHY_ADDR/DATA/CMD) that needs no base
> switching.  Use it for these chips.

[Severity: Medium]
Is there a hardware reason these chips need the TGPHY channel?

The existing r8152_phy_read()/r8152_phy_write() path cannot fail. The TGPHY
path can, and the commit message says the MII callbacks will take errnos as
register values until a follow-up series lands.

A TGPHY read is at least 5 control transfers (busy poll, ADDR, CMD, busy
poll, DATA), and a write is at least 4. The old path needs 1 or 2. That cost
applies to every hw_phy_cfg step and every firmware word.

Could the switch in rtl_ops_init() land after the callers are hardened? If
not, could the commit message describe the hardware benefit?

> form a single transaction.  Like the ADV command channel, it only
> logs the timeout and does not mark the device inaccessible.  If the

[Severity: Medium]
Is this comparison accurate? wait_cmd_ready() is a bare poll_timeout_us()
with no message, and ocp_adv_read()/ocp_adv_write() don't log either.

> Not handled here, and left to a follow-up series: the remaining
> callers, notably the hw_phy_cfg and init sequences,
> r8153_phy_status(), r8152_mmd_read(), EEE handling and the MII
> library callbacks, still ignore the status.

Several of these do change in this patch:

  - r8153_get_eee() now returns errnos to ethtool.
  - r8156_eee_en() now returns early on a failed OCP_EEE_ADV2 read.
  - r8153_phy_status() now stops polling on the first error.
  - rtl8152_get_link_ksettings() now returns PHY errnos to userspace.
  - rtl8153_in_nway(), r8156_mdio_force_mode() and rtl8152_fw_phy_fixup()
    gain early returns.

Could the message describe these changes?

> Older chips are unaffected, as r8152_phy_read() always succeeds.

r8156_hw_phy_cfg() (RTL8156) now reads PHY register 0xd068 before the
MID_REVERSE test. Previously that test skipped the read. The extra read is
harmless, but the statement isn't quite accurate.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index b7c201ac6d160..023e7af4c5fa6 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -1664,16 +1675,33 @@ static void ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
>  
>  	ocp_index = (addr & 0x0fff) | 0xb000;
>  	ocp_write_word(tp, MCU_TYPE_PLA, ocp_index, data);
> +
> +	return 0;
>  }
>  
> -static inline void r8152_mdio_write(struct r8152 *tp, u32 reg_addr, u32 value)
> +static int ocp_reg_read(struct r8152 *tp, u16 addr, u16 *data)
>  {
> -	ocp_reg_write(tp, OCP_BASE_MII + reg_addr * 2, value);
> +	return tp->rtl_ops.phy_read(tp, addr, data);
>  }
>  
> -static inline int r8152_mdio_read(struct r8152 *tp, u32 reg_addr)
> +static int ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
>  {
> -	return ocp_reg_read(tp, OCP_BASE_MII + reg_addr * 2);
> +	return tp->rtl_ops.phy_write(tp, addr, data);
> +}
> +
> +static inline int r8152_mdio_write(struct r8152 *tp, u32 reg_addr, u32 value)
> +{
> +	return ocp_reg_write(tp, OCP_BASE_MII + reg_addr * 2, value);
> +}
> +
> +static int r8152_mdio_read(struct r8152 *tp, u32 reg_addr)
> +{
> +	u16 data;
> +	int ret;
> +
> +	ret = ocp_reg_read(tp, OCP_BASE_MII + reg_addr * 2, &data);
> +
> +	return ret < 0 ? ret : data;
>  }

[Severity: High]
read_mii_word() is still registered as tp->mii.mdio_read, and it passes this
return value through unchanged. On RTL8157/8159, can a TGPHY busy timeout
here end up writing a bogus value to BMCR?

mii_nway_restart() in drivers/net/mii.c does:

	bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);

	if (bmcr & BMCR_ANENABLE) {
		bmcr |= BMCR_ANRESTART;
		mii->mdio_write(mii->dev, mii->phy_id, MII_BMCR, bmcr);
		r = 0;
	}

-ETIMEDOUT is 0xffffff92, which has BMCR_ANENABLE set.
wait_tgphy_cmd_ready() leaves RTL8152_INACCESSIBLE clear, so write_mii_word()
goes ahead. r8152_mdio_write() then writes 0xff92 to MII_BMCR.

0xff92 sets BMCR_RESET, BMCR_LOOPBACK, BMCR_PDOWN and BMCR_ISOLATE. The write
does its own 20 ms busy wait first, so a channel that recovers within that
window will accept it. ethtool -r (rtl8152_nway_reset()) and ethtool
--set-eee (rtl_ethtool_set_eee()) would then return 0.

mii_ethtool_get_link_ksettings() has a similar problem. It stores the errno
in u16 bmcr/bmsr/ctrl1000/stat1000, reports made-up link modes, and sets
mii->full_duplex from them.

The commit message defers this, and read_mii_word() is unchanged at the end
of the series. Should the switch to the TGPHY accessors wait until
read_mii_word() filters errors?

[ ... ]

> @@ -1906,100 +1950,217 @@ static void ocp_byte_set_bits(struct r8152 *tp, u16 type, u16 index, u8 set)

[ ... ]

> +static int wait_tgphy_cmd_ready(struct r8152 *tp)
> +{
> +	u16 ocp_data;
> +	int ret;
> +
> +	ret = read_poll_timeout(ocp_read_word, ocp_data,
> +				test_bit(RTL8152_INACCESSIBLE, &tp->flags) ||
> +				!(ocp_data & TGPHY_CMD_BUSY),
> +				2000, 20000, false, tp,
> +				MCU_TYPE_USB, USB_TGPHY_CMD);
> +
> +	if (ret)
> +		dev_err(&tp->intf->dev, "TGPHY cmd busy timeout\n");

[Severity: Medium]
What happens if the TGPHY channel stays busy? Most callers ignore the
status, including:

  - the per-word OCP_SRAM_DATA loops in rtl8152_fw_phy_union_apply() and
    rtl8152_fw_phy_nc_apply()
  - the hw_phy_cfg and init sequences

Each access would wait 20 ms and print this message, all while holding
tp->control. An N-word firmware block would stall for about N * 20 ms and
print N errors. Meanwhile ethtool, the ioctls and runtime PM are blocked.

Would a rate-limited message or some sticky failure state help here?

> +
> +	return test_bit(RTL8152_INACCESSIBLE, &tp->flags) ? -ENODEV : ret;
> +}
> +
> +static int rtl_tgphy_access(struct r8152 *tp, u16 addr, u16 *data, bool write)
> +{
> +	u16 cmd = 0;
> +	int ret;
> +
> +	ret = wait_tgphy_cmd_ready(tp);
> +	if (ret < 0)
> +		goto out;

[Severity: Medium]
On a write, this early return drops the word without any visible effect.
The PHY SRAM loaders write OCP_SRAM_ADDR once, then stream words to
OCP_SRAM_DATA with auto-increment, and they ignore each status:

rtl8152_fw_phy_union_apply() / rtl8152_fw_phy_nc_apply():
	ocp_reg_write(tp, OCP_SRAM_ADDR, __le16_to_cpu(phy->fw_reg));
	for (i = 0; i < num; i++)
		ocp_reg_write(tp, OCP_SRAM_DATA, __le16_to_cpu(data[i]));

If one word is dropped, would every remaining word land one slot early?

The breakpoint and bp_en writes would then be applied on top of the shifted
image, and "successfully applied" would still be logged. The inline tables
in r8157_hw_phy_cfg() and r8159_hw_phy_cfg() follow the same pattern.
rtl8157-1.fw and rtl8159-1.fw are configured for these chips, so this path
is reachable.

[ ... ]

> @@ -4177,11 +4338,13 @@ static void r8153b_green_en(struct r8152 *tp, bool enable)
>  
>  static u16 r8153_phy_status(struct r8152 *tp, u16 desired)
>  {
> -	u16 data;
> +	u16 data = 0;
>  	int i;
>  
>  	for (i = 0; i < 500; i++) {
> -		data = ocp_reg_read(tp, OCP_PHY_STATUS);
> +		if (ocp_reg_read(tp, OCP_PHY_STATUS, &data) < 0)
> +			break;
> +

[Severity: Medium]
Previously this loop kept polling for up to 500 * 20 ms. Now one failed read
ends the wait. If that read is the first, the function returns 0, which
matches no PHY_STAT_* value. r8157_init() does:

	data = r8153_phy_status(tp, 0);
	if (data == PHY_STAT_EXT_INIT) {
		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
		ocp_reg_clr_bits(tp, 0xa466, BIT(0));
	}

Can a transient timeout during PHY boot skip this EXT_INIT release? The
PHY_STAT_LAN_ON wait that follows could end early the same way.

Would it be safer to keep polling on error, as before?

[ ... ]

> @@ -4587,7 +4750,8 @@ static inline void rtl_reset_ocp_base(struct r8152 *tp)
>  static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
>  {
>  	u16 check;
> -	int i;
> +	u16 ocp_data;
> +	int i, ret;
>  
>  	if (request) {
>  		ocp_reg_set_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);

[Severity: High]
This read-modify-write still discards its status, and so does the
ocp_reg_clr_bits() in the release branch. If rtl_tgphy_access() drops the
PATCH_REQUEST update on a busy timeout, what does the handshake report?

With wait == false (the power_cut path through rtl_pre_ram_code() and
rtl_post_ram_code()), it returns 0 straight away.

With request == false and wait == true, PATCH_READY stays set. So
(ocp_data & PATCH_READY) ^ check is always 0 and the loop runs all 5000
iterations. The final check only runs when request && wait, so the function
then returns 0 even though the PHY never left patch mode.

With request == true, the dropped write only shows up as -ETIME after the
full poll.

The commit message lists the PHY patch handshake among the places that now
propagate status. Should these writes be checked as well?

> @@ -4598,25 +4762,29 @@ static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
>  	}
>  
>  	for (i = 0; wait && i < 5000; i++) {
> -		u32 ocp_data;
> -
>  		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>  			return -ENODEV;
>  
>  		usleep_range(1000, 2000);
> -		ocp_data = ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
> -		if ((ocp_data & PATCH_READY) ^ check)
> +		ret = ocp_reg_read(tp, OCP_PHY_PATCH_STAT, &ocp_data);
> +		if (ret < 0)
> +			return ret;
> +		else if ((ocp_data & PATCH_READY) ^ check)
>  			break;
>  	}
>  
> -	if (request && wait &&
> -	    !(ocp_reg_read(tp, OCP_PHY_PATCH_STAT) & PATCH_READY)) {
> -		dev_err(&tp->intf->dev, "PHY patch request fail\n");
> -		rtl_phy_patch_request(tp, false, false);
> -		return -ETIME;
> -	} else {
> -		return 0;
> +	if (request && wait) {
> +		ret = ocp_reg_read(tp, OCP_PHY_PATCH_STAT, &ocp_data);
> +		if (ret < 0) {
> +			return ret;
> +		} else if (!(ocp_data & PATCH_READY)) {
> +			dev_err(&tp->intf->dev, "PHY patch request fail\n");
> +			rtl_phy_patch_request(tp, false, false);
> +			return -ETIME;
> +		}
>  	}
> +
> +	return 0;
>  }

[Severity: Medium]
When request == true, both new return ret paths run after PATCH_REQUEST has
been set. Unlike the -ETIME path, they don't call
rtl_phy_patch_request(tp, false, false).

Callers such as r8157_hw_phy_cfg(), r8159_hw_phy_cfg() and
rtl_ram_code_speed_up() do:

	if (rtl_phy_patch_request(tp, true, true))
		return;

They never release the request. Can a single TGPHY timeout on the
OCP_PHY_PATCH_STAT read leave the PHY MCU halted in patch-request mode?

In r8157_hw_phy_cfg(), this early return also skips the green, EEE and ALDPS
setup and set_bit(PHY_RESET).

[ ... ]

> @@ -6601,7 +6779,11 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
>  		if (!advertising)
>  			return -EINVAL;
>  
> -		orig = r8152_mdio_read(tp, MII_ADVERTISE);
> +		ret = r8152_mdio_read(tp, MII_ADVERTISE);
> +		if (ret < 0)
> +			goto out;
> +
> +		orig = ret;
>  		new1 = orig & ~(ADVERTISE_10HALF | ADVERTISE_10FULL |
>  				ADVERTISE_100HALF | ADVERTISE_100FULL);
>  		if (advertising & RTL_ADVERTISED_10_HALF) {

[Severity: High]
The reads are now checked, but the advertisement writes further down still
ignore the result:

		if (orig != new1) {
			r8152_mdio_write(tp, MII_ADVERTISE, new1);
			tp->mii.advertising = new1;
		}

The MII_CTRL1000 write and ocp_reg_write(tp, OCP_10GBT_CTRL, new1) do the
same.

Suppose one of these TGPHY writes times out and the later accesses succeed.
ret is overwritten and the function returns 0.
rtl8152_set_link_ksettings() then saves tp->autoneg, tp->speed, tp->duplex
and tp->advertising as applied, and tp->mii.advertising is updated, while
the PHY keeps the old advertisement.

The commit message names rtl8152_set_speed() as covered. Should these writes
be checked too?

[ ... ]

> @@ -6673,20 +6862,23 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
>  	if (test_and_clear_bit(PHY_RESET, &tp->flags))
>  		bmcr |= BMCR_RESET;
>  
> -	r8152_mdio_write(tp, MII_BMCR, bmcr);
> +	ret = r8152_mdio_write(tp, MII_BMCR, bmcr);
> +	if (ret < 0)
> +		goto out;

[Severity: Medium]
PHY_RESET is cleared before this write. r8157_hw_phy_cfg() and
r8159_hw_phy_cfg() request the reset with set_bit(PHY_RESET). If the TGPHY
write is dropped on a timeout, is that reset lost? rtl_hw_phy_work_func_t()
ignores the return value of rtl8152_set_speed(), so nothing retries it.

There is a second case. The new goto out after the MII_CTRL1000 or
OCP_10GBT_CTRL read can run after MII_ADVERTISE, tp->mii.advertising and
tp->ups_info.speed_duplex have already been updated. The cached
tp->autoneg, tp->speed, tp->duplex and tp->advertising then no longer match
the partly programmed PHY. ups_info.speed_duplex is also used by
r8156_ups_flags().

[ ... ]

> @@ -7136,7 +7328,12 @@ static bool rtl8152_in_nway(struct r8152 *tp)
>  
>  static bool rtl8153_in_nway(struct r8152 *tp)
>  {
> -	u16 phy_state = ocp_reg_read(tp, OCP_PHY_STATE) & 0xff;
> +	u16 phy_state;
> +
> +	if (ocp_reg_read(tp, OCP_PHY_STATE, &phy_state) < 0)
> +		return false;

[Severity: Medium]
delay_autosuspend() only blocks suspend when in_nway() returns true:

	if (!sw_linking && tp->rtl_ops.in_nway(tp))
		return true;

Returning false on a read failure tells delay_autosuspend() that the PHY is
not negotiating. Its own comment says that suspending during nway may miss
the link change event, and the device then won't wake when the link comes
up.

On RTL8157/8159, can a TGPHY timeout here let the device runtime-suspend in
the middle of autonegotiation? Would returning true on error be the safer
default?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008081556.47901-1-nic_swsd%40realtek.com
