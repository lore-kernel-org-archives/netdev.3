Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A798472780;
	Mon, 12 Oct 2026 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795973; cv=none; b=gScOGck4x37wyUbkZKwPrpd/q4k8ca5AthwIblzZZHu+dNFSy7ShvN08Du/j7lv+XOYOcteZXuLXws0uRLjPF7VmJuNLITUw/CAQP1Ws7mRu4lBXsMsm0toMl4fvGmrjNedlGrr+OSLZgy+1auuhbASiW1Y189XP84onb1AXUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795973; c=relaxed/simple;
	bh=ZGqnnFY2qciiVFVihlj//+uFTcIA00DFqe/qQmyNcGo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yir14fTPtKm/5snf6BeBStZ8uyQbSxHZCgY3GW03mAyGzqmsLZVmYZwMNbt7vPekuj2d+bRzB31FZLaVj89kkT0FcVTt+Nb+LcYhWat2oEUTtNiW9XRbOH147LYbvWiVK0Tn70MPZA0qdjEoEEoGDYAJUHvB8dv1OGlXJIfBDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGTgd5Ce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGTgd5Ce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6303B1F0089C;
	Mon, 12 Oct 2026 09:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795972;
	bh=SLsifxEEjP9I1cXYn6MV4lOLRm0spuC/lh/I/BUBTY4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DGTgd5CeikwVPIXg735QEETYhRFl3x1yo1lRxVO4cL+fxpOBQlqFePvjGA3OgOJ6I
	 OXtkRLx8P8O1r9AqBl0Hbo4jsLz3wBqLBFNYJ5IzwWP+pnctrQ5i1hPMHqXuJIg/Ur
	 74poriCge5D4LzFweaCGw3k8OLK2pgG58ja5M+vmVb7CWEbfNRtFGCAotm248ZEhjP
	 9BAyLMC5uzJGrMHd4ubSncvmRBMXRwCG0FKz7BWtGWnIMPBNyLUFAjOXYohyeZvaU9
	 80Y8Y0FVS6mc7aOHKBNZVg4DvLV9HqRwWR2XiHX0nMJCNRBuRgFvzUH4dGoWGHFU/q
	 TkAAqFd9T/Vog==
Subject: Re: [PATCH net-next v6 07/10] r8152: add rtl8157_unload and
 rtl8157_change_mtu
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch,
 mail@birger-koblitz.de
Date: Mon, 12 Oct 2026 09:06:10 +0000
Message-ID: <179179597097.434549.7414664554417897136@kernel.org>
In-Reply-To: <20261008081556.47901-8-nic_swsd@realtek.com>
References: <20261008081556.47901-8-nic_swsd@realtek.com>
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

- [Low] The commit message carries two Fixes: tags (fd3c7d080df5 for
  RTL8157 and ad2a55b63b41 for RTL8159), so it will be picked up for…

--

r8152: add rtl8157_unload and rtl8157_change_mtu

This patch adds two RTL8157/RTL8159-specific helpers. rtl8157_unload()
uses r8157_power_cut_en() and clears the 0xcf04 interrupt mitigation
bits. rtl8157_change_mtu() scales MTPS from the configured MTU instead of
writing a fixed MTPS_JUMBO. Both helpers replace the earlier
rtl8153_unload() and rtl8156_change_mtu() ops for RTL_VER_16 and
RTL_VER_17_QFN68/QFN100.

> r8152: add rtl8157_unload and rtl8157_change_mtu
>
> RTL8157 and RTL8159 used rtl8153_unload() and rtl8156_change_mtu(),
> which program power-cut and MTPS the way earlier chips require. Per
> the datasheet, RTL8157/RTL8159 need r8157_power_cut_en() (already
> used by r8157_init()/r8159_init()) instead of r8153_power_cut_en(),
> and an MTPS scaled from the configured MTU (10K-16K, max_pkt_size /
> 64 capped at 0xff) instead of a fixed MTPS_JUMBO.

[ ... ]

> Fixes: fd3c7d080df5 ("r8152: Add support for the RTL8157 hardware")
> Fixes: ad2a55b63b41 ("r8152: Add support for the RTL8159 chip")

[Severity: Low]

With two Fixes: tags this will likely be picked up for stable. The only
reason the changelog gives is "Per the datasheet". What do users actually
see go wrong on RTL8157/RTL8159 with the old unload sequence or the fixed
MTPS? Could the changelog describe that symptom?

The unload change is not just a rename. Compared with
r8153_power_cut_en(tp, false), the new path no longer clears PHASE2_EN,
and it now also clears USB_MISC_2 BIT(1):

r8157_power_cut_en() {
    ...
	} else {
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT, PWR_EN);
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2, BIT(1));
	}
}

On the MTPS side, RTL8156B (RTL_VER_12/13/15) uses the same
max_mtu = size_to_mtu(16 * 1024) as RTL_VER_16/17. It still goes through
rtl8156_change_mtu(), which writes the fixed value:

rtl8156_change_mtu() {
    ...
	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, rx_max_size);
	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, MTPS_JUMBO);
    ...
}

So the commit text alone does not show what MTPS_JUMBO breaks on
RTL8157/RTL8159.

The subject also reads like a feature addition rather than a fix.

The unload power-cut sequence and the MTPS change are independent. Would
it be better to split them into two patches, each with its own symptom
and Fixes: tags? That way each change could be backported or reverted on
its own.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008081556.47901-1-nic_swsd%40realtek.com
