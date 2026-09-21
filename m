Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2B4453A2F;
	Mon, 21 Sep 2026 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979446; cv=none; b=V62z3W12mj7msY9As38faCWU6L7Rs2bQfjda8wbSAIYUa8eEy2AmnQZ6AcpgxtuhgfUWLnec6JY1nHYEH2XfFcc/ZxBW3KXsaMI95KeWn2qo6X2hBbQwmOuwg0eZ1kM7tH6CaMDTdGqgHlmOgKt3mL6R3NqacHfW6LLFqZZhiGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979446; c=relaxed/simple;
	bh=RK6ekJ6RYk+jOsW6T22ETMBAI5mboe6JTEcxV9zUmVU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SV0SFJTtEDGvRGtg9eKK24OS9pEzp8hrpDuROtOpxBQPlJFBsQWJUMpWllgNOZ3L2FqxUzm4GTa1yCSJAxcfI3F79wl70FDgKtra6ptTSSCOevBJ3hBq4M+SQnqCaepwIfFeLCWH38xxzIMToZBNfxIgBhutmcIW9Klz4+ZTpMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLCAwYwU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLCAwYwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02851F00893;
	Mon, 21 Sep 2026 08:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789979438;
	bh=i1D8yAaeTtOslmLi0oth/RFqLIwU3sJKJOb/Sj5Z2Bc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RLCAwYwUq8Vt675G8TW+leaXM/ix/CI60+qSBdmSijpVte9gxRWp+XF1aXy74s9sc
	 Y7/MVlHeK+81IbTwaVYmfaBAUo3tse1k3MjBegmDFwMwnruju9LnOnK6yjT+UqQT4v
	 GRFbeaTjpuW2FLb72s0CzePcOHPC5nkmLhuMG+6HyXs1ab9vTiriephP6ZWHMbN3fk
	 fzGQk80l9kGtg3d0T2Y2CXgMVINZ76JGsr4n6XRCfN2Fzk4wE1RtZKEj0cNqHaWkVA
	 KnAtSFvZONPyNCKt9xptfuGRHA6wSd8qg+0qWbeXmxydMsf8NFxJhJ5wE+IIbnncNK
	 Yy4iWL0v2oTtg==
Subject: Re: [PATCH net-next v4 6/8] r8152: add TGPHY register access for
 RTL8157 and RTL8159
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Mon, 21 Sep 2026 08:30:37 +0000
Message-ID: <178997943745.2160803.11487917322772287006@kernel.org>
In-Reply-To: <20260917070637.62827-7-nic_swsd@realtek.com>
References: <20260917070637.62827-7-nic_swsd@realtek.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 12 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 8 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] r8152_mdio_read() now returns negative errno values (`return ret
  < 0 ?
- [Medium] The commit message presents the TGPHY path as infrastructure
  needed for chip support ("Support for these chips needs a second PHY…
- [Medium] The changelog claims that "every helper built on top of
  [ocp_reg_read/write] ... [is] propagating the failure to callers…
- [Medium] The RTL8157/RTL8159 PHY configuration routines and the PHY
  firmware appliers issue long dependent indirect-access sequences…
- [Medium] rtl8152_set_speed() and rtl8152_set_pauseparam() add read-
  error exits but leave the PHY writes unchecked, so configuration is…
- [Medium] r8153_phy_status() now breaks out of its poll loop when
  ocp_reg_read(OCP_PHY_STATUS, &data) fails and returns the untouched…
- [Medium] rtl_phy_patch_request() implements the driver<->PHY-MCU
  mutual-exclusion handshake (PATCH_REQUEST / PATCH_READY), but the two…
- [Medium] rtl_tgphy_access() builds the new PHY transaction out of
  status-less accessors, so bus-level failures become 'successful' PHY…
- [Medium] r8156_eee_en() gained `if (ocp_reg_read(tp, OCP_EEE_ADV2,
  &config) < 0) return;` after r8153_eee_en(tp, enable) has already…
- [Low] sram_write() is converted to return int but only captures the
  status of the address-phase write; the data-phase ocp_reg_write(tp,…
- [Low] rtl_phy_patch_request() now performs an unconditional
  ocp_reg_read(OCP_PHY_PATCH_STAT) after the wait loop.
- [Low] rtl_ram_code_speed_up() and rtl8152_fw_phy_ver() ignore
  sram_read()'s new error return while pre-initialising the version…

--

r8152: add TGPHY register access for RTL8157 and RTL8159

This turns ocp_reg_read()/ocp_reg_write() into dispatch wrappers over new
tp->rtl_ops.phy_read/phy_write pointers and adds a TGPHY mailbox
implementation (USB_TGPHY_ADDR/DATA/CMD) for RTL8157 and RTL8159.  Because
the new path can time out, the PHY helper layer is converted from
void/raw-value returns to int.

A few questions below about the new error paths and about the changelog.

[Severity: Medium]

> Since ocp_reg_read()/ocp_reg_write() can now fail on a TGPHY timeout,
> every helper built on top of them (sram_read/write, sram2_read/write,
> the ocp_reg_*_bits and MDIO bit helpers) is converted from void/raw-
> value returns to int, propagating the failure to callers instead of
> silently operating on stale data.

Is "propagating the failure to callers" accurate for all of these?  A few
places still swallow or fabricate:

  - sram_write() returns the status of the OCP_SRAM_ADDR write only, the
    OCP_SRAM_DATA write status is dropped.

  - r8153_phy_status() and r8152_mmd_read() return a zero-initialised u16
    on failure, which callers cannot distinguish from a real value.

  - rtl_ram_code_speed_up() and rtl8152_fw_phy_ver() ignore sram_read()
    entirely.

  - the chips that can actually fail here, RTL_VER_16 and RTL_VER_17, run
    r8157_hw_phy_cfg()/r8159_hw_phy_cfg(), which ignore every return
    value.

  - rtl8152_set_speed(), rtl8152_set_pauseparam() and rtl8152_ioctl()
    ignore the write errors and, for SIOCGMIIREG, the read error.

Would it be clearer to scope the sentence to the helpers that were
actually converted?

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index f44dcb88b5c6a..3473061af129a 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -1664,16 +1675,33 @@ static void ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
>  
>  	ocp_index = (addr & 0x0fff) | 0xb000;
>  	ocp_write_word(tp, MCU_TYPE_PLA, ocp_index, data);
> +
> +	return 0;
> +}
> +
> +static int ocp_reg_read(struct r8152 *tp, u16 addr, u16 *data)
> +{
> +	return tp->rtl_ops.phy_read(tp, addr, data);
> +}
> +
> +static int ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
> +{
> +	return tp->rtl_ops.phy_write(tp, addr, data);
>  }
>  
> -static inline void r8152_mdio_write(struct r8152 *tp, u32 reg_addr, u32 value)
> +static inline int r8152_mdio_write(struct r8152 *tp, u32 reg_addr, u32 value)
>  {
> -	ocp_reg_write(tp, OCP_BASE_MII + reg_addr * 2, value);
> +	return ocp_reg_write(tp, OCP_BASE_MII + reg_addr * 2, value);
>  }
>  
>  static inline int r8152_mdio_read(struct r8152 *tp, u32 reg_addr)
>  {
> -	return ocp_reg_read(tp, OCP_BASE_MII + reg_addr * 2);
> +	u16 data;
> +	int ret;
> +
> +	ret = ocp_reg_read(tp, OCP_BASE_MII + reg_addr * 2, &data);
> +
> +	return ret < 0 ? ret : data;
>  }

[Severity: High]

r8152_mdio_read() now mixes errno values and register contents in the same
int, but the consumers still decode the result as PHY register bits.
read_mii_word() is wired up as tp->mii.mdio_read, and the mii library has
no error channel:

drivers/net/mii.c:mii_nway_restart() {
	bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);

	if (bmcr & BMCR_ANENABLE) {
		bmcr |= BMCR_ANRESTART;
		mii->mdio_write(mii->dev, mii->phy_id, MII_BMCR, bmcr);
	...
}

On a TGPHY busy timeout bmcr becomes 0xff92, which has BMCR_ANENABLE set,
so 0xff92 gets written back into MII_BMCR.  That value also carries
BMCR_RESET, BMCR_LOOPBACK, BMCR_PDOWN and BMCR_ISOLATE.

Can this power down or isolate the PHY?  The path is reachable from
rtl8152_nway_reset() and rtl8152_set_eee().  mii_ethtool_get_link_ksettings()
similarly stores the callback results in u16 bmcr/bmsr and decodes their
bits with no error check.

In rtl8152_ioctl(), SIOCGMIIREG requires no capability and does:

	data->val_out = r8152_mdio_read(tp, data->reg_num);

with res left at 0, so userspace receives the truncated errno (-110 ->
0xff92) as a PHY register value; SIOCSMIIREG drops r8152_mdio_write()'s
new error the same way.  rtl8152_get_pauseparam() puts the three reads
into u16 locals and bit-tests them, so 0xff92 reports autoneg as enabled.

And in rtl8152_set_speed() the reset poll:

		if ((r8152_mdio_read(tp, MII_BMCR) & BMCR_RESET) == 0)
			break;

can never break early, since every negative return has bit 15 set, so it
spins 50 * 20 ms with tp->control held.  Should these callers be taught
about the negative return in the same patch?

>  
>  static int wait_cmd_ready(struct r8152 *tp, u16 cmd)
> @@ -1792,16 +1820,32 @@ static int rtl_ip_set_bits(struct r8152 *tp, u16 addr, u32 set)
>  	return rtl_ip_w0w1(tp, addr, 0, set);
>  }
>  
> -static void sram_write(struct r8152 *tp, u16 addr, u16 data)
> +static int sram_write(struct r8152 *tp, u16 addr, u16 data)
>  {
> -	ocp_reg_write(tp, OCP_SRAM_ADDR, addr);
> +	int ret;
> +
> +	ret = ocp_reg_write(tp, OCP_SRAM_ADDR, addr);
> +	if (ret < 0)
> +		goto out;
> +
>  	ocp_reg_write(tp, OCP_SRAM_DATA, data);
> +
> +out:
> +	return ret;
>  }

[Severity: Low]

Is dropping the OCP_SRAM_DATA write status here intentional?  sram_write()
returns the (successful) OCP_SRAM_ADDR status, so a TGPHY timeout on the
data phase is reported to callers as success.  sram2_write(), converted in
this same patch, does capture it:

	ret = ocp_reg_write(tp, OCP_SRAM2_ADDR, addr);
	if (ret < 0)
		goto out;

	ret = ocp_reg_write(tp, OCP_SRAM2_DATA, data);

No current caller looks at sram_write()'s return value, so there is no
visible effect today.

>  
> -static u16 sram_read(struct r8152 *tp, u16 addr)
> +static int sram_read(struct r8152 *tp, u16 addr, u16 *data)
>  {
> -	ocp_reg_write(tp, OCP_SRAM_ADDR, addr);
> -	return ocp_reg_read(tp, OCP_SRAM_DATA);
> +	int ret;
> +
> +	ret = ocp_reg_write(tp, OCP_SRAM_ADDR, addr);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = ocp_reg_read(tp, OCP_SRAM_DATA, data);
> +
> +out:
> +	return ret;
>  }

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

When this busy-wait aborts, the requested access is skipped but the
indirect SRAM programming state is left as it was.  The RTL8157/RTL8159
configuration routines then keep issuing data writes against whatever
address was latched last.  For example r8157_hw_phy_cfg() does:

	ocp_reg_write(tp, OCP_SRAM_ADDR, 0x8f9c);
	ocp_reg_write(tp, OCP_SRAM_DATA, 0x0005);
	ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
	...

and r8159_hw_phy_cfg() the same for 0x81c4, while the firmware appliers do:

	ocp_reg_write(tp, OCP_SRAM_ADDR, __le16_to_cpu(phy->fw_reg));
	for (i = 0; i < num; i++)
		ocp_reg_write(tp, OCP_SRAM_DATA, __le16_to_cpu(data[i]));

If the address write aborts on a busy timeout but a data write a few
microseconds later finds the mailbox free, can these words land on the
previously latched SRAM address?  And since successful data writes
auto-advance the destination, would a skipped word shift every following
word of the image?  Both functions continue on to the breakpoint writes,
update the cached ups_info state and finally assert PHY_RESET as if the
whole sequence had been programmed.

> +
> +	if (write) {
> +		cmd |= TGPHY_CMD_WR;
> +		ocp_write_word(tp, MCU_TYPE_USB, USB_TGPHY_DATA, *data);
> +	}
> +
> +	ocp_write_word(tp, MCU_TYPE_USB, USB_TGPHY_ADDR, addr);
> +
> +	cmd |= TGPHY_CMD_BUSY;
> +	ocp_write_word(tp, MCU_TYPE_USB, USB_TGPHY_CMD, cmd);
> +
> +	if (!write) {
> +		ret = wait_tgphy_cmd_ready(tp);
> +		if (ret < 0)
> +			goto out;
> +
> +		*data = ocp_read_word(tp, MCU_TYPE_USB, USB_TGPHY_DATA);
> +	}
> +
> +out:
> +	return ret;
> +}

[Severity: Medium]

The four accesses that make up the transaction all use the status-less
accessors, so bus-level failures come back as successful PHY accesses.
Two cases:

If the USB_TGPHY_DATA or USB_TGPHY_ADDR control transfer fails,
r8152_control_msg() sets RTL8152_INACCESSIBLE and the remaining writes
become -ENODEV no-ops, yet rtl_tgphy_access() still returns 0.  Should the
success path re-check RTL8152_INACCESSIBLE before returning?

set_registers() and get_registers() can also return early, before
r8152_control_msg() runs at all:

	tmp = kmemdup(data, size, GFP_KERNEL);
	if (!tmp)
		return -ENOMEM;

In that case RTL8152_INACCESSIBLE is not set, so the USB_TGPHY_CMD write
can launch a command whose operands were never delivered.

On the read side, get_registers() does:

	if (ret < 0)
		memset(data, 0xff, size);
	else
		memcpy(data, tmp, size);

so *data becomes 0xffff after a failed transfer, and on its -ENOMEM path
ocp_read_word()'s local tmp is never written at all.  Does the read then
publish that value with the success status of the preceding busy poll?

> +
> +static int r8157_phy_read(struct r8152 *tp, u16 addr, u16 *data)
> +{
> +	return rtl_tgphy_access(tp, addr, data, false);
> +}
> +
> +static int r8157_phy_write(struct r8152 *tp, u16 addr, u16 data)
> +{
> +	return rtl_tgphy_access(tp, addr, &data, true);
>  }
>  
>  static int
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
>  		data &= PHY_STAT_MASK;
>  		if (desired) {
>  			if (data == desired)

[Severity: Medium]

Since rtl_tgphy_access() leaves *data untouched on a busy-wait failure,
this break returns the initial 0 as an ordinary PHY status, and the u16
signature gives callers no way to tell the difference.  0 matches none of
PHY_STAT_LAN_ON, PHY_STAT_PWRDN or PHY_STAT_EXT_INIT, so in
r8156_hw_phy_cfg(), r8157_hw_phy_cfg() and r8159_hw_phy_cfg():

	data = r8153_phy_status(tp, 0);
	switch (data) {
	...
	default:
		rtl8152_apply_firmware(tp, false);

the whole PHY patch sequence runs against a PHY that is known to be
unreachable.  A little later the same functions do:

	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
	WARN_ON_ONCE(data != PHY_STAT_LAN_ON);

Would a plain TGPHY timeout now produce a WARN_ON_ONCE splat here?  Should
r8153_phy_status() gain an error return instead?

[ ... ]

> @@ -4587,7 +4750,8 @@ static inline void rtl_reset_ocp_base(struct r8152 *tp)
>  static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
>  {
>  	u16 check;
> -	int i;
> +	u16 ocp_data = 0;
> +	int i, ret;
>  
>  	if (request) {
>  		ocp_reg_set_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);

[Severity: Medium]

These two calls are the ones that actually take and drop the driver/PHY-MCU
handshake bit, and they still discard the newly added error return:

	if (request) {
		ocp_reg_set_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
		check = 0;
	} else {
		ocp_reg_clr_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
		check = PATCH_READY;
	}

With wait == false the polling loop is skipped and the function reaches
"return 0" unconditionally, so a failed acquire is indistinguishable from
success.  That path is reachable via rtl8152_apply_firmware(tp, true) ->
rtl_pre_ram_code(..., wait = !power_cut = false), and the callers use the
zero as permission to proceed:

	if (rtl_phy_patch_request(tp, true, wait))
		return -ETIME;

	rtl_patch_key_set(tp, key_addr, patch_key);

Can PHY RAM code then be streamed while the PHY MCU still owns the PHY?
Symmetrically, a timed-out release leaves PATCH_REQUEST asserted while 0 is
returned.

>  
> @@ -4598,25 +4762,23 @@ static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
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
> +		if (ret < 0 || (ocp_data & PATCH_READY) ^ check)
>  			break;
>  	}
>  
> -	if (request && wait &&
> -	    !(ocp_reg_read(tp, OCP_PHY_PATCH_STAT) & PATCH_READY)) {
> +	ret = ocp_reg_read(tp, OCP_PHY_PATCH_STAT, &ocp_data);
> +	if (request && wait && (ret < 0 || !(ocp_data & PATCH_READY))) {
>  		dev_err(&tp->intf->dev, "PHY patch request fail\n");
>  		rtl_phy_patch_request(tp, false, false);
>  		return -ETIME;
> -	} else {
> -		return 0;
>  	}
> +
> +	return 0;
>  }

[Severity: Low]

Hoisting the read out of the condition makes it unconditional.  Previously
the short-circuit meant no register access at all when request == false
(rtl_post_ram_code(), the release in rtl_ram_code_speed_up(), and the
internal rtl_phy_patch_request(tp, false, false) rollback) or when
wait == false.  Now every one of those calls costs an extra PHY read, which
on the TGPHY chips is a busy poll plus a command round trip.  Was that
intended?

Also, a read failure is now folded into -ETIME with the "PHY patch request
fail" message rather than reporting the underlying -ENODEV or -ETIMEDOUT.
Should ret be returned directly in that case?

>  
>  static void rtl_patch_key_set(struct r8152 *tp, u16 key_addr, u16 patch_key)
> @@ -5331,10 +5493,12 @@ static void rtl_ram_code_speed_up(struct r8152 *tp, struct fw_phy_speed_up *phy,
>  {
>  	u32 len;
>  	u8 *data;
> +	u16 ver = 0;
>  
>  	rtl_reset_ocp_base(tp);
>  
> -	if (sram_read(tp, SRAM_GPHY_FW_VER) >= __le16_to_cpu(phy->version)) {
> +	sram_read(tp, SRAM_GPHY_FW_VER, &ver);
> +	if (ver >= __le16_to_cpu(phy->version)) {
>  		dev_dbg(&tp->intf->dev, "PHY firmware has been the newest\n");
>  		return;
>  	}

[Severity: Low]

With sram_read()'s return value ignored and ver pre-set to 0, a TGPHY read
failure looks identical to "the running PHY firmware is older", so the
update branch is taken.  Before this change a failed read produced 0xffff
from the 0xff fill in get_registers(), which took the skip path, so the
zero initialisation inverts the outcome.  rtl8152_fw_phy_ver() has the same
shape with cur_ver = 0, and there it also decides patch_phy for the rest of
the image.  Would checking sram_read() and bailing out be preferable?

[ ... ]

> @@ -5389,14 +5555,15 @@ static void rtl_ram_code_speed_up(struct r8152 *tp, struct fw_phy_speed_up *phy,
>  
>  static int rtl8152_fw_phy_ver(struct r8152 *tp, struct fw_phy_ver *phy_ver)
>  {
> -	u16 ver_addr, ver;
> +	u16 ver_addr, ver, cur_ver = 0;
>  
>  	ver_addr = __le16_to_cpu(phy_ver->ver.addr);
>  	ver = __le16_to_cpu(phy_ver->ver.data);
>  
>  	rtl_reset_ocp_base(tp);
>  
> -	if (sram_read(tp, ver_addr) >= ver) {
> +	sram_read(tp, ver_addr, &cur_ver);
> +	if (cur_ver >= ver) {
>  		dev_dbg(&tp->intf->dev, "PHY firmware has been the newest\n");
>  		return 0;
>  	}

[ ... ]

> @@ -5787,7 +5955,8 @@ static void r8156_eee_en(struct r8152 *tp, bool enable)
>  
>  	r8153_eee_en(tp, enable);
>  
> -	config = ocp_reg_read(tp, OCP_EEE_ADV2);
> +	if (ocp_reg_read(tp, OCP_EEE_ADV2, &config) < 0)
> +		return;
>  
>  	if (enable && (tp->eee_adv2 & MDIO_EEE_2_5GT))
>  		config |= MDIO_EEE_2_5GT;

[Severity: Medium]

This early return lands after r8153_eee_en() has already toggled
PLA_EEE_CR EEE_RX_EN/EEE_TX_EN and OCP_EEE_CFG EEE10_EN and set
tp->ups_info.eee, so OCP_EEE_ADV2 keeps its previous 2.5G/5G advertisement
with no rollback.  Since r8156_eee_en() is void, rtl_eee_enable() cannot
see the failure and still writes OCP_EEE_ADV:

	case RTL_VER_16:
	case RTL_VER_17_QFN68:
	case RTL_VER_17_QFN100:
		if (enable) {
			r8156_eee_en(tp, true);
			ocp_reg_write(tp, OCP_EEE_ADV, tp->eee_adv);

Those are exactly the versions whose phy_read is r8157_phy_read(), so can
the MAC/PHY enables, tp->ups_info.eee (which feeds USB_UPS_FLAGS) and the
multi-gig advertisement end up describing different EEE configurations?

[ ... ]

> @@ -6601,7 +6770,11 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
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
> @@ -6628,7 +6801,11 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
>  		}
>  
>  		if (tp->mii.supports_gmii) {
> -			orig = r8152_mdio_read(tp, MII_CTRL1000);
> +			ret = r8152_mdio_read(tp, MII_CTRL1000);
> +			if (ret < 0)
> +				goto out;
> +
> +			orig = ret;
>  			new1 = orig & ~(ADVERTISE_1000FULL |
>  					ADVERTISE_1000HALF);
>  

[Severity: Medium]

By the time this MII_CTRL1000 read can fail, MII_ADVERTISE has already been
rewritten just above:

		if (orig != new1) {
			r8152_mdio_write(tp, MII_ADVERTISE, new1);
			tp->mii.advertising = new1;
		}

The goto out skips the MII_BMCR write, so does the PHY end up advertising
new 10/100 capabilities mixed with the old 1000/2.5G/5G/10G ones and no
ANRESTART, while tp->mii.advertising and tp->ups_info.speed_duplex have
already been updated?  The same applies to the OCP_10GBT_CTRL read below.

>  @@ -6642,7 +6819,10 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
>  		}
>  
>  		if (tp->support_2500full || tp->support_5000full || tp->support_10000full) {
> -			orig = ocp_reg_read(tp, OCP_10GBT_CTRL);
> +			ret = ocp_reg_read(tp, OCP_10GBT_CTRL, &orig);
> +			if (ret < 0)
> +				goto out;
> +
>  			new1 = orig & ~(MDIO_AN_10GBT_CTRL_ADV2_5G | MDIO_AN_10GBT_CTRL_ADV5G
>  					| MDIO_AN_10GBT_CTRL_ADV10G);
>  
> @@ -6686,7 +6866,7 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
>  	}
>  
>  out:
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }

[Severity: Medium]

The final r8152_mdio_write(tp, MII_BMCR, bmcr) result is not captured, and
this normalisation turns the last successful read into 0.  If the BMCR
write times out, does the function report success even though
autonegotiation was never restarted and a requested BMCR_RESET was already
consumed by test_and_clear_bit(PHY_RESET)?  rtl8152_set_link_ksettings()
then caches the request as applied:

	ret = rtl8152_set_speed(tp, cmd->base.autoneg, cmd->base.speed,
				cmd->base.duplex, advertising);
	if (!ret) {
		tp->autoneg = cmd->base.autoneg;

[ ... ]

> @@ -10002,7 +10216,11 @@ static int rtl8152_set_pauseparam(struct net_device *netdev, struct ethtool_paus
>  
>  	mutex_lock(&tp->control);
>  
> -	if (pause->autoneg && !(r8152_mdio_read(tp, MII_BMCR) & BMCR_ANENABLE)) {
> +	ret = r8152_mdio_read(tp, MII_BMCR);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (pause->autoneg && !(ret & BMCR_ANENABLE)) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -10013,7 +10231,11 @@ static int rtl8152_set_pauseparam(struct net_device *netdev, struct ethtool_paus
>  	if (pause->tx_pause)
>  		cap |= FLOW_CTRL_TX;
>  
> -	old = r8152_mdio_read(tp, MII_ADVERTISE);
> +	ret = r8152_mdio_read(tp, MII_ADVERTISE);
> +	if (ret < 0)
> +		goto out;
> +
> +	old = ret;
>  	new1 = (old & ~(ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM)) | mii_advertise_flowctrl(cap);
>  	if (old != new1)
>  		r8152_mdio_write(tp, MII_ADVERTISE, new1);
> @@ -10022,7 +10244,7 @@ static int rtl8152_set_pauseparam(struct net_device *netdev, struct ethtool_paus
>  	mutex_unlock(&tp->control);
>  	usb_autopm_put_interface(tp->intf);
>  
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }

[Severity: Medium]

Here the reads are checked but the MII_ADVERTISE write status is dropped
and then normalised to 0, so ethtool -A reports success for a pause
advertisement that was never programmed.  Would assigning the write result
to ret before the out label match the set_pauseparam contract better?

[ ... ]

> @@ -10378,6 +10612,8 @@ static int rtl_ops_init(struct r8152 *tp)
>  		ops->hw_phy_cfg		= r8157_hw_phy_cfg;
>  		ops->autosuspend_en	= rtl8157_runtime_enable;
>  		ops->change_mtu		= rtl8157_change_mtu;
> +		ops->phy_read		= r8157_phy_read;
> +		ops->phy_write		= r8157_phy_write;
>  		tp->rx_buf_sz		= 32 * 1024;
>  		tp->support_2500full	= 1;
>  		tp->support_5000full	= 1;

[Severity: Medium]

The changelog says "Support for these chips needs a second PHY access
path", but RTL_VER_16 (RTL8157) has been supported in-tree since
fd3c7d080df5 ("r8152: Add support for the RTL8157 hardware") and RTL_VER_17
since the RTL8159 support commit, and both already ran their PHY accesses
through the OCP-base-switching path.

If the premise is right and these chips only reach their PHY through
USB_TGPHY_ADDR/DATA/CMD, then every PHY access on shipping hardware since
those commits used the wrong interface: the ocp_reg_write() parameter
writes in r8157_hw_phy_cfg()/r8159_hw_phy_cfg(), r8153_phy_status()
polling, the EEE and 10GBT reporting in rtl8152_get_link_ksettings() and
r8153_get_eee(), the advertisement programming in rtl8152_set_speed(),
SIOCGMIIREG/SIOCSMIIREG and rtl8153_in_nway().

That would make this a user-visible fix for released hardware, but there is
no Fixes: tag, no stable Cc and no description of the observed symptom.  If
instead the PLA_OCP_GPHY_BASE window did work on these chips, could the
justification for the second path be restated?  As written it is hard to
tell which case applies for backporting.

>  
[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917070637.62827-1-nic_swsd%40realtek.com
