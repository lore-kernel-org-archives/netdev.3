Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308624718DC;
	Mon, 12 Oct 2026 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795972; cv=none; b=KNLbK9n2faszjlqq2HqobifYwcqF0yrWkmGcEVPrGcKr7kT90h6ZrSyXR1MV/Ag27NAFXLRQeuoz+BONDja1geWETVsUk/w1HfZM868pPjt+yY6YlKbEDZm+rokRX5Z6csOaXMW7ZDXSQ6AWAHvov7pe9WJO/DTNuLCLaSiNdDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795972; c=relaxed/simple;
	bh=Rg9k11PI6ANXVeJhl2Qom17DQcEZHRpf0nc+KISuIpM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ulxaSQMiO8xYaZf+8UNHG4XUoPY6vk+wUcAWIDUigWVacArER2jX/bPgqCkXmxBkmt2FrL3Qyuc7uVV7BNjFcQCrjikqh696Bwkl/LMMGy3oRgthVxdH3iRu3UbuLj2ltLai/jxwzMmbace2IdAPs0pJADzj2ZBhSQNyAtQ7A0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOoONOuC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOoONOuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9AA1F0089B;
	Mon, 12 Oct 2026 09:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795970;
	bh=kiRst8VrOSUVDEdv0FkjcfIgg69NK0SOd3kRjtqelyc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hOoONOuCGmcQs+MINDlkk/mF1C0rRncqrhsOaDEzZb08EJ9zcxuyzkfbDJS6gr5HI
	 n2Kb/efUZGEyTrEiiW+kA7Qrr/AFTsAHywm9XmrReHyZw0jj7qSpxDPR0Fw05zmRiI
	 zKieRdoUBosIP68RRw8pztzfketR8OK9V8KePYFgRj4gqwKQ/ZPwngplfJeGXnlqOp
	 GEfjZQzAOMPi2LBUU5gkRplqpJsdPfiosSZ8S1yks/zmkYgEHqo6zuzUADNz2XMPwT
	 E4ZKO4SgeQfojICWBAq9PclvSs4BVuYY6D+HbXHBRsgNxQWQeVNZ9BZ11Os//YAbDw
	 NmU6bCxdoS/6g==
Subject: Re: [PATCH net-next v6 03/10] r8152: split RTL_VER_17 into QFN68 and
 QFN100 package variants
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch,
 mail@birger-koblitz.de
Date: Mon, 12 Oct 2026 09:06:09 +0000
Message-ID: <179179596974.434549.7242394414003313759@kernel.org>
In-Reply-To: <20261008081556.47901-4-nic_swsd@realtek.com>
References: <20261008081556.47901-4-nic_swsd@realtek.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The retry count printed by __rtl_get_pkg_det() is one too high.

--

r8152: split RTL_VER_17 into QFN68 and QFN100 package variants

This patch splits RTL_VER_17 into RTL_VER_17_QFN68 and RTL_VER_17_QFN100.
It tells them apart at probe time by reading the new PLA_PKG_DET register
through a new __rtl_get_pkg_det() helper. r8159_init() also gets a
QFN68-only write that enables the u2phy backup restore patch.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index f62bfa659a985..eae76be4fad50 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -10180,9 +10202,38 @@ static int rtl_fw_init(struct r8152 *tp)
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
> +		if (i != 1)
> +			dev_warn(&udev->dev,
> +				 "Needed %d retries to read package\n", i);

[Severity: Low]
Is the count printed here one higher than the real number of retries?

The loop increments i before it checks ret in the for condition, so when
the loop exits, i holds the number of attempts. If the first read fails
and the second one returns 4 bytes, i is 2. The message then says "Needed
2 retries" when only one retry was done.

The loop in __rtl_get_hw_ver() breaks before i++, so the same message
there shows the actual retry count:

	for (i = 0; i < 3; i++) {
		ret = usb_control_msg(...);
		if (ret > 0) {
			...
			break;
		}
	}

	if (i != 0 && ret > 0)
		dev_warn(&udev->dev, "Needed %d retries to read version\n", i);

Could this print i - 1, or use the same loop shape as __rtl_get_hw_ver(),
so both helpers report retries the same way?

> +
> +		pkg_det = __le32_to_cpu(*tmp) & PKG_MASK;
> +	}
> +
> +	kfree(tmp);
> +	return pkg_det;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008081556.47901-1-nic_swsd%40realtek.com
