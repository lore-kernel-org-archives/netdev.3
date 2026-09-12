Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2901447A0A9;
	Sat, 12 Sep 2026 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244397; cv=none; b=GtH9eMulqT0BS3pM6POV9CxGs0kxK2WMKLmmuF+j4G1JUU1DuK33mqKA/aGQ9FHVDeRTkj4Vhlf1D5OAC7Z6Ontjt3M4n9H17h9nCbcCNCsJ/V3f5wtMJSnfqSClLng/N1P5MXFXj/AhfGb9o9e9YS6lMpxbm+wAxPsSVJOqy7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244397; c=relaxed/simple;
	bh=0gDanJxUvbp6KtFtK1YykqVXD888cVUBvBT7MTWFrl8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Igm4c7INoTXsvPJWSXav+PtThpf6XNyJ7IALczHP1Ms4zGm2fKbsLj6h6v/WTxTJwNWnSigRT4s6sMv8h2dpe9RFKpOuOtFA6Laq6HfNQORwzKQXKUjzz13q4+a4irmkhsHqhsKAA47bm8oD99ZP4Rv9F8+EWyUwJABDUfL2n+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpuOjEhW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpuOjEhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718E71F000FF;
	Sat, 12 Sep 2026 20:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244395;
	bh=A2igHhAP4WaDZcRmTt1O0ng9ZDmSGqneKUhMa+hojZ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jpuOjEhWMakyzNwsFh8EXDMeHR5MBVL3BfAX1MJFDB4SnSAGdNWglh/aUpveR9pdZ
	 hEjS5EZO5CoYMFysk2mm0VzwUisVNr9Q0l64ZWz9XgOJnXKXysYwTXbQSHPBcNBnbz
	 zSthtYytqlarBw2VA5xsjbPqDRRYTeZUgfI8oHCb2h3sUMJsR1KEhxNfG8BPhl5ljN
	 OfdGK56k0by8P6mGDUlLrW6YSIv7UyYtiOAf5SkEy6b/Jpw3QVaG/3mibQUErghJo1
	 D1PSCXMSkNALkWLfBwc0tFD5DWO/LKBT3MKVGN2FBp2LqfsUeN2gl16TEARjSgt1Im
	 o6OykpVpFklig==
Subject: Re: [PATCH net-next v3 6/8] r8152: add TGPHY access support
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Sat, 12 Sep 2026 20:19:54 +0000
Message-ID: <178924439400.3125.6156948273116550773@kernel.org>
In-Reply-To: <20260908075634.23740-7-nic_swsd@realtek.com>
References: <20260908075634.23740-7-nic_swsd@realtek.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 0

- [Medium] r8157_phy_read() (drivers/net/usb/r8152.c:2086) and
  r8157_phy_write() (:2095) discard rtl_tgphy_access()'s return value.
- [Medium] wait_tgphy_cmd_ready() (drivers/net/usb/r8152.c:2045) makes
  its loop-exit decision on the value returned by ocp_read_word(), which…

--

r8152: add TGPHY access support

This adds a TGPHY register access path for RTL8157/RTL8159 using
USB_TGPHY_CMD/ADDR/DATA, so PHY registers can be reached without
reprogramming the PLA OCP base. It also introduces phy_read/phy_write
function pointers in struct rtl_ops so each chip gets the right access
method, with ocp_reg_read()/ocp_reg_write() becoming thin dispatchers.

A couple of questions about error propagation in the new path below.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 06fad895fce09..1fcb1cc5b4a18 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -959,6 +966,8 @@ struct r8152 {
>  		void (*hw_phy_cfg)(struct r8152 *tp);
>  		void (*autosuspend_en)(struct r8152 *tp, bool enable);
>  		void (*change_mtu)(struct r8152 *tp);
> +		u16 (*phy_read)(struct r8152 *tp, u16 addr);
> +		void (*phy_write)(struct r8152 *tp, u16 addr, u16 data);
>  	} rtl_ops;

[ ... ]

> @@ -1687,6 +1696,16 @@ static void ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
>  	ocp_write_word(tp, MCU_TYPE_PLA, ocp_index, data);
>  }
>  
> +static u16 ocp_reg_read(struct r8152 *tp, u16 addr)
> +{
> +	return tp->rtl_ops.phy_read(tp, addr);
> +}
> +
> +static void ocp_reg_write(struct r8152 *tp, u16 addr, u16 data)
> +{
> +	tp->rtl_ops.phy_write(tp, addr, data);
> +}
> +

[ ... ]

> @@ -2023,6 +2042,61 @@ static int r8152_mdio_test_and_clr_bit(struct r8152 *tp, u16 addr, u16 clear)
>  	return data & clear;
>  }
>  
> +static int wait_tgphy_cmd_ready(struct r8152 *tp)
> +{
> +	u16 ocp_data;
> +
> +	return poll_timeout_us(ocp_data = ocp_read_word(tp, MCU_TYPE_USB,
> +							USB_TGPHY_CMD),
> +			       !(ocp_data & TGPHY_CMD_BUSY), 2000, 20000,
> +			       false);
> +}

[Severity: Medium]

wait_tgphy_cmd_ready() makes its loop-exit decision purely on the value
returned by ocp_read_word(), which is indeterminate if the underlying
transfer never happens:

  ocp_read_word() {
	u32 data;
	__le32 tmp;
	...
	generic_ocp_read(tp, index, sizeof(tmp), &tmp, type | byen);
	data = __le32_to_cpu(tmp);
	...
  }

generic_ocp_read() starts with:

	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
		return -ENODEV;

so tmp is left untouched and the u16 handed to the poll loop is stale
stack content.  If bit 0 happens to be set, does this helper then sleep
for its whole 20 ms budget instead of returning right away?

The USB-error case looks deterministic rather than random, since
get_registers() does:

	if (ret < 0)
		memset(data, 0xff, size);

USB_TGPHY_CMD then reads back as 0xffff, TGPHY_CMD_BUSY always appears
asserted, and every TGPHY access consumes the full timeout.

Since every PHY register access on RTL8157/RTL8159 now funnels through
rtl_tgphy_access() (one wait per write, two per read), would a device
marked inaccessible mid-sequence make r8157_hw_phy_cfg()/hw_phy_work, the
up/down paths and the mdio ioctl sleep 20-40 ms per register while holding
tp->control?  Would an is-accessible check in the helper be preferable to
polling a value that may never have been read?

> +
> +static int rtl_tgphy_access(struct r8152 *tp, u16 addr, u16 *data, bool write)
> +{
> +	u16 cmd = 0;
> +	int ret;
> +
> +	ret = wait_tgphy_cmd_ready(tp);
> +	if (ret < 0)
> +		goto out;
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
> +
> +static u16 r8157_phy_read(struct r8152 *tp, u16 addr)
> +{
> +	u16 data = 0;
> +
> +	rtl_tgphy_access(tp, addr, &data, false);
> +
> +	return data;
> +}
> +
> +static void r8157_phy_write(struct r8152 *tp, u16 addr, u16 data)
> +{
> +	rtl_tgphy_access(tp, addr, &data, true);
> +}

[Severity: Medium]

Both wrappers discard rtl_tgphy_access()'s status.  On a
wait_tgphy_cmd_ready() timeout, r8157_phy_read() returns the
pre-initialised 0, which is indistinguishable from real register content.

Can that fabricated 0 get written back to the PHY?  ocp_reg_read() now
dispatches to r8157_phy_read() for RTL8157/RTL8159, and the
read-modify-write helpers use it directly:

  ocp_reg_w0w1() {
	u16 data;

	data = ocp_reg_read(tp, addr);
	data = (data & ~clear) | set;
	ocp_reg_write(tp, addr, data);
  }

so a timed-out read makes the driver write (0 & ~clear) | set, dropping
every other bit of the MII/PHY register (advertisement, EEE, PLL/ALDPS).
r8152_mdio_set_bit(), r8152_mdio_test_and_clr_bit() and sram_write_w0w1()
have the same shape.

For the write direction, a first-wait timeout jumps to out before any of
the ADDR/DATA/CMD writes are issued, so the PHY write is dropped
entirely.  With the void signature there is no way for the caller to
notice, and no dev_err()/dev_warn() is emitted, so should this at least
be logged?

Note that the existing global mitigation does not cover a plain BUSY
timeout: rtl_set_inaccessible() is only reached when a USB control
transfer fails in r8152_control_msg(), so here the control transfers
succeed and generic_ocp_write() still pushes the clobbered value to the
chip.

The sibling ADV interface in the same file returns int for exactly this
reason:

  static int ocp_adv_read(struct r8152 *tp, u16 cmd, u16 addr, u32 *data)
  ...
  static int rtl_bmu_w0w1(struct r8152 *tp, u16 addr, u32 clear, u32 set)
  {
	ret = rtl_bmu_read(tp, addr, &bmu);
	if (ret < 0)
		goto out;
	...
  }

and wait_tgphy_cmd_ready() duplicates wait_cmd_ready() almost verbatim.
Would it make sense for the new phy_read/phy_write ops in struct rtl_ops
to carry a status back, or to reuse the existing wait_cmd_ready() helper,
so the TGPHY timeout can stop the read-modify-write sequence instead of
being swallowed?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908075634.23740-1-nic_swsd%40realtek.com
