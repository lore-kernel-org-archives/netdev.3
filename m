Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58885EEBB;
	Sun, 29 Mar 2026 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774812905; cv=none; b=d0m5LpSkLF9wDDUCeV/vOVDBpZBeNZkDU6m+8FX53l6aRyPnerVEZRH19TCl4haldsIGWbTfKDwHLIsRXJiSIbhxPNxwHDFo++JgxK81X7X8Yhc9HkpmAyesIWr4wjqxtCVhhkVz/l4t68MyXj32mIs3TVBEp4y/GZireLmoQx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774812905; c=relaxed/simple;
	bh=XQkUIWVsukd2jBCyqb0nVppdak+jFRU6N91Zevt00dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYFNYssdCw6rxIWtwBxjXNnorXejGiJG6Ms+bNTI1zJAGkGd0VtxyWX/8XKxUH3C7k9C42utPLl/KFlQM8HdZpXu8wnJtkZgDEfrMn6RLQkYO2tn+2hzlT2JvqtHFyCOJBn6tFWJkRgSndb1bvtYhy2RDXrwI3SjZ+Y+u5KFFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWeIaT3t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWeIaT3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F358C116C6;
	Sun, 29 Mar 2026 19:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774812904;
	bh=XQkUIWVsukd2jBCyqb0nVppdak+jFRU6N91Zevt00dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rWeIaT3tNCZpU0n47rci5u2TtOotxCkpIbDjKRy5XyufiPQZ3bTIx8F1T7ne59T69
	 Y0SmnxUXdiwZZVUhYogZU1Br0ENXB4Lv7jCYQ7QQxYxcC3pGgxXlYUP74b0AD933fo
	 hWOOVKzR77KbE5pamjB/jN+YEO0z0eEEXjucmvh9NZpd2uPBriv1dk6+Yvc1vntkBh
	 Yu7qRr51Hd7+7xl92AdsWkvSbg8UkRZVfA94mJ9o6Mn66g9awrwzMdStReeJZqTzts
	 ZzP3Y87FDokjrq0qu2BqDy8zPfoYwLrWsGEMrw1dr09OSABVFIq9/o6WhxZ3NhxFvy
	 PihgOQ1JpwcIA==
From: Jakub Kicinski <kuba@kernel.org>
To: mail@birger-koblitz.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] r8152: Add support for the RTL8157 hardware
Date: Sun, 29 Mar 2026 12:34:58 -0700
Message-ID: <20260329193457.2764549-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324-rtl8157_next-v4-2-034312b12de5@birger-koblitz.de>
References: <20260324-rtl8157_next-v4-2-034312b12de5@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8152: Add support for the RTL8157 hardware

This commit adds support for the RTL8157 chip, including its new 16-byte
descriptor format, SRAM/ADV interfaces, and PHY setup. It reuses existing
initialization functions where possible while branching for chip-specific
logic.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index bab8e10e5f99..010126e6dae4 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -1629,6 +1862,28 @@ static u16 sram_read(struct r8152 *tp, u16 addr)
>  	return ocp_reg_read(tp, OCP_SRAM_DATA);
>  }
>  
> +static void sram_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
> +{
> +	u16 data = sram_read(tp, addr);
> +
> +	data = (data & ~clear) | set;
> +	ocp_reg_write(tp, OCP_SRAM_DATA, data);
> +}

Does this sequence write the modified data back to the wrong address?

Indirect SRAM access ports typically auto-increment their internal address
pointer upon read. Since sram_read() reads OCP_SRAM_DATA, the address
pointer likely advances, causing the subsequent ocp_reg_write() to corrupt
the adjacent register instead of the intended one. Should this use
sram_write(tp, addr, data) to reset the address before writing?

> +static u16 sram2_read(struct r8152 *tp, u16 addr)
> +{
> +	ocp_reg_write(tp, OCP_SRAM2_ADDR, addr);
> +	return ocp_reg_read(tp, OCP_SRAM2_DATA);
> +}
> +
> +static void sram2_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
> +{
> +	u16 data = sram2_read(tp, addr);
> +
> +	data = (data & ~clear) | set;
> +	ocp_reg_write(tp, OCP_SRAM2_DATA, data);
> +}

Is the same auto-increment issue present here with OCP_SRAM2_DATA?

[ ... ]

> @@ -4080,6 +4473,14 @@ static void rtl8156_runtime_enable(struct r8152 *tp, bool enable)
>  	}
>  }
>  
> +static void rtl8157_runtime_enable(struct r8152 *tp, bool enable)
> +{
> +	r8153_queue_wake(tp, enable);
> +	r8153b_u1u2en(tp, false);
> +	r8157_u2p3en(tp, false);
> +	rtl_runtime_suspend_enable(tp, enable);
> +}

Does this function break power management upon the first suspend and resume
cycle? Unlike rtl8156_runtime_enable() which checks the enable parameter,
this implementation unconditionally calls r8153b_u1u2en(tp, false) and
r8157_u2p3en(tp, false) even when resuming.

[ ... ]

> @@ -6693,7 +7052,7 @@ static void rtl8156_up(struct r8152 *tp)
>  	r8153_aldps_en(tp, true);
>  	r8153_u2p3en(tp, true);
>  
> -	if (tp->udev->speed >= USB_SPEED_SUPER)
> +	if (tp->version != RTL_VER_16 && tp->udev->speed >= USB_SPEED_SUPER)
>  		r8153b_u1u2en(tp, true);
>  }

Because r8153_u2p3en(tp, true) is called unconditionally just before the
modified lines, will RTL8157 incorrectly write to the legacy USB_U2P3_CTRL
register instead of using its specific r8157_u2p3en() function?

[ ... ]

> @@ -6706,13 +7065,13 @@ static void rtl8156_down(struct r8152 *tp)
>  		return;
>  	}
>  
> -	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
> -	ocp_data |= PLA_MCU_SPDWN_EN;
> -	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
> +	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
>  
>  	r8153b_u1u2en(tp, false);
> -	r8153_u2p3en(tp, false);
> -	r8153b_power_cut_en(tp, false);
> +	if (tp->version != RTL_VER_16) {
> +		r8153_u2p3en(tp, false);
> +		r8153b_power_cut_en(tp, false);
> +	}
>  	r8153_aldps_en(tp, false);

While the legacy registers are correctly avoided for RTL_VER_16 here, are we
missing calls to r8157_u2p3en(tp, false) and r8157_power_cut_en(tp, false)?
If omitted, these power states might remain permanently enabled when the
interface goes down.

[ ... ]

> @@ -8362,10 +8825,21 @@ static void r8156b_init(struct r8152 *tp)
>  
>  	set_bit(GREEN_ETHERNET, &tp->flags);
>  
> -	/* rx aggregation */
> -	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
> -	ocp_data &= ~(RX_AGG_DISABLE | RX_ZERO_EN);
> -	ocp_write_word(tp, MCU_TYPE_USB, USB_USB_CTRL, ocp_data);
> +	/* rx aggregation / 16 bytes Rx descriptor */
> +	if (tp->version == RTL_VER_16)
> +		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_DESC_16B);

Is it intended to clear the RX_DESC_16B bit for RTL_VER_16? The driver uses
sizeof(struct rx_desc_v2) which is a 16-byte descriptor for RTL8157.
Clearing this bit might configure the hardware to send 8-byte descriptors
instead, leading to packet parsing corruption in rx_bottom().

[ ... ]

> @@ -9647,6 +10158,29 @@ static int rtl_ops_init(struct r8152 *tp)
>  		tp->rx_buf_sz		= 32 * 1024;
>  		tp->eee_en		= true;
>  		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
> +		r8152_desc_init(tp);
> +		break;
> +
> +	case RTL_VER_16:
> +		tp->eee_en		= true;
> +		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
> +		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
> +		ops->init		= r8156_init;
> +		ops->enable		= rtl8156_enable;
> +		ops->disable		= rtl8153_disable;
> +		ops->up			= rtl8156_up;
> +		ops->down		= rtl8156_down;
> +		ops->unload		= rtl8153_unload;

Will using rtl8153_unload for RTL_VER_16 result in incorrect power cut
teardown? rtl8153_unload calls the legacy r8153_power_cut_en(tp, false).
RTL8157 seems to require r8157_power_cut_en(tp, false) to properly clear
USB_MISC_2 bit 1 and PCUT_STATUS on module unload.
