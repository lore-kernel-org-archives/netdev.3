Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE041E6B6;
	Mon,  5 Oct 2026 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194246; cv=none; b=Ds37BlLfPBLaGeyxO0S5eHTFZ41f5/qZK+pelOdOZr1sKycYM3LDY/MoNi2yKaiXDIcyFaKgV88HghuVNOR+k52g0BNCVKFph39ummaZ3yLvqRWX71Ra6UXLK3JYCVHD8+8/QbV5nsJmTYdbQr0tVlBa03ODWo2GJffcZD/iL0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194246; c=relaxed/simple;
	bh=BcSAU7V2BNV/2w2moHoVDTAzO65SRGTBxE4Nc5hFjX4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YOocHHvpEKBWGSiwz7G8oyaHt1qS7YbnNPJXaorPzIpou4eaoXZj9EfWOXGWwbOMOitPMnkDdhUJ7qSqDCpVo2Zu0J8ZReowU69emHDyjV5/cNzoyVslX2GwABMMtk2FIJopDXSFuD5xDWdCScUs3s1LrhSiB0EipdzoN764wTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWT8Xugx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWT8Xugx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C429B1F000FF;
	Mon,  5 Oct 2026 09:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791194240;
	bh=8MmSHBDUwLj+PzySVR8HqwmbQn13Gr0asVMdg/a5DnE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZWT8XugxGLUF40OoDSfjkMludDZjjSjo5vB092bGZQ6O+TGZC4teublevV4QL/bMe
	 ogZOTrXVRf8lImB4VwO54BYr1BDl6JUQiHuYLVK/ormOMleGqNksh0fq+00Ohdh/DJ
	 RUKgka6THOWIOOzxuSLaZ4NAFZzB98W6HjsNXsI7yk9itkD6IOpKhOJ3yH9OXovj3y
	 QjyZa/xD6nHzK4LrHhs8MI6eHEbTZ8Zavt445A0ivIbAl2q4mjrn5kRRYsMAMIAn/H
	 Bh07yHvGmhxyIuQ4VVtQ5Soty9Vfo3QM33KmA9ALiBLbXMNyhUC3q6M1I8KEA2MvFj
	 CDJ7v/xVtdtpg==
Subject: Re: [PATCH net-next v5 1/9] r8152: split r8156_init per chip and add
 missing init writes
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Mon, 05 Oct 2026 09:57:19 +0000
Message-ID: <179119423934.434549.8623262119068946046@kernel.org>
In-Reply-To: <20261001091144.28191-2-nic_swsd@realtek.com>
References: <20261001091144.28191-2-nic_swsd@realtek.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch is presented as splitting r8156_init() per chip,
  but it also changes hardware behaviour for all four chip families, and…

--

r8152: split r8156_init per chip and add missing init writes

This commit splits the shared r8156_init() into separate init functions
for RTL8156, RTL8156B, RTL8157 and RTL8159. It also moves the
AUTOLOAD_DONE polling into a new wait_autoload_done() helper. While
splitting, it adds several new register writes to the per-chip init
paths, including clearing RX_END_TRANSFER_EN on RTL8157.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index af3d7dcb2f141..4d8f0815d79d1 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -8421,73 +8444,261 @@ static void r8156_init(struct r8152 *tp)

[ ... ]

>  	set_bit(GREEN_ETHERNET, &tp->flags);
>  
> -	/* RX aggregation / 16 bytes RX descriptor
> -	 * BIT(11) is specific to RTL8159, with unknown meaning
> -	 */
> -	if (tp->version == RTL_VER_17)
> -		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
> -				  RX_AGG_DISABLE | RX_DESC_16B | BIT(11));
> -	else if (tp->version == RTL_VER_16)
> -		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_DESC_16B);
> +	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
> +			  RX_AGG_DISABLE | RX_ZERO_EN);

[ ... ]

> +static void r8157_init(struct r8152 *tp)
> +{

[ ... ]

> +	/* RX aggregation / 16 bytes RX descriptor / Bulk In End transfer */
> +	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
> +			  RX_AGG_DISABLE | RX_DESC_16B | RX_END_TRANSFER_EN);

[Severity: Medium]
Is this a functional fix for RTL8157 that should go in as its own patch
with a Fixes: tag?

Before this patch, the RTL_VER_16 branch in r8156_init() cleared only
RX_AGG_DISABLE | RX_DESC_16B. BIT(11) was cleared only for RTL_VER_17,
and the comment said its meaning was unknown. r8157_init() now clears
RX_END_TRANSFER_EN as well.

The commit message says that while this bit is set, "Bulk-in transfers
are suspended", and that "the driver must manually clear it to resume
Bulk-in transfers".

That sounds like an RX stall on RTL8157 that goes back to commit
fd3c7d080df5 ("r8152: Add support for the RTL8157 hardware"). This fix
has no Fixes: tag and is part of a refactor touching about 490 lines,
so it seems unlikely to reach net or stable.

Later patches in this series do carry Fixes: tags: "r8152: fix up and
down register settings for RTL8156/8156B/8157/8159" and "r8152: add
rtl8157_unload and rtl8157_change_mtu".

Could this change be sent as a small standalone fix ahead of the split?

The other new hardware writes raise the same question. The commit
message lists them, but it doesn't say what problem or symptom each one
fixes:

    PREBOOT_OPTION and RMT_WAKE_EN, cleared in all four init functions
    r8156b_u2phy_backup() writing 0xd3ce/0xd3d0/0xd3d4/0xd3d8/0xd3dc
    0xcf04 interrupt mitigation disable in r8157_init()/r8159_init()
    0xcd06 BIT(11) in r8157_init()/r8159_init()
    0xb9a6 BIT(0) and 0xb9a2 = 0x0448 in r8159_init()

Could these be split out, or have their purpose explained? If one of
them causes a regression, a bisect would land on this large mixed
commit.

r8156b_init() also moves the AUTO_SPEEDUP clear. It used to be part of
the USB_FW_CTRL read-modify-write that ran after usb_enable_lpm() and
the flow control setup:

    ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_CTRL);
    ...
    ocp_data &= ~AUTO_SPEEDUP;
    ocp_write_word(tp, MCU_TYPE_USB, USB_FW_CTRL, ocp_data);

Now it runs right after r8153_u2p3en():

    r8153_u2p3en(tp, false);

    /* Disable Auto Speed up */
    ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_CTRL, AUTO_SPEEDUP);

That is before the MSC timer, r8156b_u2phy_backup(), power-cut, UPS and
LPM setup. Is this reordering intended for RTL8156B? The commit message
doesn't mention it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001091144.28191-1-nic_swsd%40realtek.com
