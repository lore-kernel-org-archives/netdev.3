Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021404718CD;
	Mon, 12 Oct 2026 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795971; cv=none; b=ewelWOGETi0FGC1XodMGX0ixdktzp0hre6Xx4WIrirVXCPvbeB7pMEcZTVKMJbBDwcDJqxbP6eWiXrJ4fS+pWiStqGZWwAIdIt255uMnb0CzMpQBCJHb9dJGs031sYyrAPv6VlkIEKkFb1kVvliKE1fl64siymUgdi9QJhVAC0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795971; c=relaxed/simple;
	bh=fdODk147uKvfexPqzNJoo7LmCAd6OhiwGOB+AD2dfiE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EQvLF03yENaOwBGem8lfmfUP6JB9bc2liluVMEq9JASM9dta2JcUE2TLUax7PBpG7HvPKTkcbKpGXaDWNGigmJ5g7HlBytaEs3mFqA0hwBOhV2AfTfNz4sgP7KSbjGETa1ELU5Nllxakt+QgvFOLT/Nz/PiJahZR5k2xrNGJ1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDzSMCLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDzSMCLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06B81F0089D;
	Mon, 12 Oct 2026 09:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795969;
	bh=1CUky8K5fZyI/nFfSG8VjBYptTlpbZjyLQYpDWDWlDE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lDzSMCLyG37+QMx1xusgmbwGGrQr6mgjrVTXIlkXi57WGE+Q+HbYuCFqFNLq+5csO
	 zcNp0EYEIyYP0X2GNmG2l6d5FSGWCGDVFWADyARVFFfIpizAzhegNMMTslK2EC5WgI
	 9QsXaTD/r6zYWPvy6WQOGu3cNQQzPuj7lhzAT+5P/KFc4WUa6iO0z+xd8ru7WcsmDF
	 ETqfJ52zrYrCPo/AbIzcFGnjcxm5s/4Opu5mTOOBl0/Daxf7NwRMBh1I90yUxWQubv
	 0YucqEcKihcMNiCJvm+IBXVrXheh2QnVfhjDUJMzxxSgCuR4CHVaiSvH989cxmgvFL
	 D7KkXBJPylgCA==
Subject: Re: [PATCH net-next v6 02/10] r8152: add new init writes for
 RTL8156B/8157/8159
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch,
 mail@birger-koblitz.de
Date: Mon, 12 Oct 2026 09:06:08 +0000
Message-ID: <179179596844.434549.4859424794231631979@kernel.org>
In-Reply-To: <20261008081556.47901-3-nic_swsd@realtek.com>
References: <20261008081556.47901-3-nic_swsd@realtek.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch defines PLA_RMT_WAKE (0xe0c8) with RMT_WAKE_EN =
  BIT(0) and clears that bit on every init.
- [Low] The subject says 'add new init writes for RTL8156B/8157/8159',
  but the patch also changes r8156_init().

--

r8152: add new init writes for RTL8156B/8157/8159

This patch brings the per-chip init functions closer to the vendor init
sequence. It clears PREBOOT_OPTION and RMT_WAKE_EN in all four init
functions and adds a u2phy backup for RTL8156B. On RTL8157/8159 it also
disables auto speedup and interrupt mitigation, clears reset event flags
and clears RX_END_TRANSFER_EN.

> r8152: add new init writes for RTL8156B/8157/8159

[Severity: Low]
Should the subject also name RTL8156? The patch changes r8156_init() too.
rtl_ops_init() uses that function for RTL_VER_10/11, which is the original
RTL8156, not the RTL8156B path:

	case RTL_VER_10:
		ops->init		= r8156_init;

The body says "all four init functions", but the subject lists only
RTL8156B/8157/8159. Anyone searching history or picking backports by
subject could miss that RTL8156 (non-B) devices are affected.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 30543c5799232..f62bfa659a985 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -8344,6 +8350,10 @@ static void r8156_init(struct r8152 *tp)
>  	r8153_queue_wake(tp, false);
>  	rtl_runtime_suspend_enable(tp, false);
>  
> +	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG, PREBOOT_OPTION);
> +
> +	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_RMT_WAKE, RMT_WAKE_EN);
> +

[Severity: Medium]
Can clearing RMT_WAKE_EN here stop wake-on-LAN or runtime PM remote wakeup
from working?

The same clear is added to r8156_init(), r8156b_init(), r8157_init() and
r8159_init(). The only uses of PLA_RMT_WAKE and RMT_WAKE_EN in the driver
are the define and these four clears. Nothing sets the bit again.

tp->rtl_ops.init() runs from both rtl8152_probe_once() and
rtl8152_reset_resume(), so the bit is cleared on every probe and every
reset-resume. Neither wake setup path writes 0xe0c8:

  __rtl_set_wol() only programs PLA_CONFIG34, PLA_CONFIG5 and PLA_CFG_WOL,
  then calls device_set_wakeup_enable().

  rtl_runtime_suspend_enable() and r8153_queue_wake() handle runtime
  suspend, and probe sets intf->needs_remote_wakeup = 1.

UPCOMING_RUNTIME_D3 behaves differently. Init clears it, and
rtl_runtime_suspend_enable(tp, true) sets it again. RMT_WAKE_EN is only
ever cleared.

Suppose the bit is the MAC-side remote wake enable that its name
suggests. Then after probe or reset_resume, RTL8156/8156B/8157/8159
devices would still report WoL as armed but could not wake the host.
Runtime autosuspend wake on link change could fail as well.

It may instead be a flag left over from pre-boot firmware, like the
PREBOOT_OPTION bit cleared next to it. In that case clearing it would be
harmless. Neither the code nor the commit message says which. The message
only says "Clear PREBOOT_OPTION and RMT_WAKE_EN in all four init
functions".

Could the commit message explain what PREBOOT_OPTION and RMT_WAKE_EN
control and why clearing them unconditionally is safe for WoL and runtime
PM? It already does this for RX_END_TRANSFER_EN.

>  	if (tp->udev->speed >= USB_SPEED_SUPER)
>  		r8153b_u1u2en(tp, true);
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008081556.47901-1-nic_swsd%40realtek.com
