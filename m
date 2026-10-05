Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF82D8379;
	Mon,  5 Oct 2026 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194246; cv=none; b=rPeF8GgWcAOvGbhOh4zfDxq3lN1ZyCgScLuvVuP+Xk3wDY60U1VHNZZ+4zWf4UkTc6iEJQjJ9wpe+DChNX6wXBS8yDC9PwSxf4eTaSlWmIGxv3Vjx5fZCvH23QG/mMTPc9z9KAHh89PMewyDhmTVqvarEQqkEbKbaAhjh2iyQAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194246; c=relaxed/simple;
	bh=pPTieTvEgtxDVou/g2rq/vQXz2Uc+SsajH/wGXJEpyo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eur22FzVELDoq5LSxZaB1DkNL2OzSSnPB1yHG0h4frfANUIuC/uNbWRf1QQ8OCrMqA27UQiThFyTToK/HjiilvE5HL4nFaxi6CU7wSAQMY1ZftXPTcePYSQArEj7tzvuHqt+tToTIXITgmaVfiwCO/82LecOVID5gxwcjl8ELAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiQFJ0Bm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiQFJ0Bm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21241F00898;
	Mon,  5 Oct 2026 09:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791194241;
	bh=ujHBDJVNz78vZ7dajK+ArwV45XyWD1dmWWG/JkYh18Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XiQFJ0Bm5bY8CUwG+qSNp+uW6l8nlwTTAcZoL0l6LIknqGYe5Y7CcgT/5PFfKgYyo
	 hQxrKZIbVuvHtVu35bqg07kxYE1Y9bmt5BJaOLevGeXgyltu78t9BCIVeFntV+eMYx
	 ZpHmLNfDQlIYVZVOaZXwbWVDlF5av2bRmCxaOR0C9+6qx577Ixc/MKi2Ba1o4++Gm1
	 JHpPTo6obmxuj5sp6vk+fglWttPrBUW5bU1FxxWZYo9ug8E+saHJ9zBmbz1cqdSJs+
	 u48HpKTgf2JP/MTse2S70FGIJ3S++IZkeEms9/XYdQA56IPCmrnxyHj17QIAMp7S2R
	 I5CPBqogqd2Ww==
Subject: Re: [PATCH net-next v5 2/9] r8152: split RTL_VER_17 into QFN68 and
 QFN100 package variants
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Mon, 05 Oct 2026 09:57:20 +0000
Message-ID: <179119424050.434549.6174729043039044928@kernel.org>
In-Reply-To: <20261001091144.28191-3-nic_swsd@realtek.com>
References: <20261001091144.28191-3-nic_swsd@realtek.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the split is needed because QFN68 and
  QFN100 "need different firmware and a package-specific u2phy backup-…
- [Medium] In __rtl_get_pkg_det() (drivers/net/usb/r8152.c), the retry
  loop `for (i = 0, ret = 0; i < 3 && ret != 4; i++) ret =…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but in
  __rtl_get_hw_ver() (drivers/net/usb/r8152.c) the buffer `tmp` is…

--

r8152: split RTL_VER_17 into QFN68 and QFN100 package variants

This commit splits RTL_VER_17 into RTL_VER_17_QFN68 and RTL_VER_17_QFN100.
The package is detected by a new __rtl_get_pkg_det() helper that reads
PLA_PKG_DET. Every RTL_VER_17 switch case now handles both variants, and
r8159_init() gains a u2phy backup restore write that only applies to QFN68.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 4d8f0815d79d1..30af6ed3a638f 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -10172,7 +10194,8 @@ static int rtl_fw_init(struct r8152 *tp)
>  	case RTL_VER_16:
>  		rtl_fw->fw_name		= FIRMWARE_8157_1;
>  		break;
> -	case RTL_VER_17:
> +	case RTL_VER_17_QFN68:
> +	case RTL_VER_17_QFN100:
>  		rtl_fw->fw_name		= FIRMWARE_8159_1;

[Severity: Medium]
The commit message says the two packages "need different firmware and a
package-specific u2phy backup-restore patch". However, rtl_fw_init() still
gives both RTL_VER_17_QFN68 and RTL_VER_17_QFN100 the same firmware,
FIRMWARE_8159_1 ("rtl_nic/rtl8159-1.fw").

The driver still has only one 8159 firmware define and one
MODULE_FIRMWARE(FIRMWARE_8159_1). The later patches in the series, up to
"r8152: enable UPS for RTL8157 and RTL8159 QFN68", do not change this
either.

Is per-package firmware selection missing from this patch? Or should the
commit message drop the claim about different firmware?

>  		break;
>  	default:
> @@ -10182,9 +10205,38 @@ static int rtl_fw_init(struct r8152 *tp)
>  	return 0;
>  }
>  
> +static u32 __rtl_get_pkg_det(struct usb_device *udev)
> +{
> +	u32 pkg_det = 0;
> +	__le32 *tmp;
> +	int ret, i;
> +
> +	tmp = kmalloc_obj(*tmp);
> +	if (!tmp)
> +		return 0;
> +
> +	for (i = 0, ret = 0; i < 3 && ret != 4; i++)
> +		ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> +				      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
> +				      PLA_PKG_DET, MCU_TYPE_PLA, tmp,
> +				      sizeof(*tmp), USB_CTRL_GET_TIMEOUT);
> +
> +	if (ret == sizeof(*tmp)) {
> +		if (i != 0)
> +			dev_warn(&udev->dev,
> +				 "Needed %d retries to read package\n", i);

[Severity: Medium]
Won't this warning fire on every successful read? The loop increments i
after the iteration that succeeds. If the first usb_control_msg() returns
4, i is already 1 when the loop exits, so the i != 0 check is always true.

The printed count is also one too high: 1 for a first-try success, 3 for a
success on the third attempt.

The version read loop in __rtl_get_hw_ver() avoids this by breaking out on
success:

	for (i = 0; i < 3; i++) {
		ret = usb_control_msg(...);
		if (ret > 0) {
			ocp_data = (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
			break;
		}
	}

	if (i != 0 && ret > 0)
		dev_warn(&udev->dev, "Needed %d retries to read version\n", i);

__rtl_get_hw_ver() runs from both the cfgselector and the probe paths, so
the false warning can appear more than once per RTL8159 plug-in. The code
is still the same at the end of the series.

> +
> +		pkg_det = __le32_to_cpu(*tmp) & PKG_MASK;
> +	}
> +
> +	kfree(tmp);
> +	return pkg_det;
> +}
> +
>  static u8 __rtl_get_hw_ver(struct usb_device *udev)
>  {
>  	u32 ocp_data = 0;
> +	u32 pkg_det = 0;
>  	__le32 *tmp;
>  	u8 version;
>  	int ret;

[Severity: Medium]
This isn't a bug introduced by this patch, but the PLA_TCR0 read in
__rtl_get_hw_ver() accepts a reply of any positive length:

	tmp = kmalloc_obj(*tmp);
	...
		if (ret > 0) {
			ocp_data = (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
			break;
		}

kmalloc_obj() does not zero the buffer. If a faulty or malicious device
sends only 1 to 3 bytes, can the upper bytes of *tmp still hold leftover
heap data that then gets decoded as the chip version?

That could misidentify the chip, or leak uninitialized heap bytes to dmesg
through the "Unknown version 0x%04x" message.

The new __rtl_get_pkg_det() helper already requires
ret == sizeof(*tmp). Would the same check make sense here?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001091144.28191-1-nic_swsd%40realtek.com
