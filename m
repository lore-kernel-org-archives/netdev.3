Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBF46EF79;
	Mon,  5 Oct 2026 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194249; cv=none; b=JfeGx2i6+xzgJFxY8/ispm271Ycmvr2Jzh39/h8hOyvlUPXY/8Elmxy8py/ldljd6rlsMjeayNisagvVfm4DnTa/2BoTMceAnTXx4yZdd55pysfyB8q0WOu3N7rYAtyrs7KreE/KM3FaTDmc4LmPjQud0zpLmNR1JFgp2P3ufSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194249; c=relaxed/simple;
	bh=HYpxleanNS41hy3ucuwhaEzuDllE0uxvbwmNlZGFApU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fBbquTG81BWIwVPEvihRRvZmKnVMEECq1zNlfN2oWPTpe+pbgyvdj7C13ZfeGDDfexq7xuis1Djwoofo31j80xFkBZhvDgq402q8Z+paLrZCu4sAMse5O0WE0xLqYISLWqeoXOOBFCntcN1y2rqjubpp9lf0CEtIZ+JFSxZftr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzE790cQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzE790cQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5065F1F00899;
	Mon,  5 Oct 2026 09:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791194244;
	bh=U3fYLmiXzRnLvwFlLUeb9uBB+CuAbRdmC5rtcPN5Be4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MzE790cQKN+U6yEthYBdwszNGLChKMyTWVmQq4yrN0CmRbeRj/ixmimwY/5SFQyXc
	 5DZNaS117xG/34R1XCK6WVLmp0OAEV5GxpGJFOaWoe/M9+Wx4m3hQ5LFl6eaoQYJcn
	 wfRLxypSBLCC5nJ4thBAJaroTfBMWHReEp/ycneOeXhojzfnFRk3uC4fCNnO6sgEm7
	 7sEtWn1zi/JqXiatAxRzESgCu018MyQU9yov88NIlFJiMs+4YCgSIDLhDXtIcsRF4N
	 oUshDqicSYIghT5XO0816knoeNzATZ/Odf4zRjSOXS+V+JZ0oF+0Z1BEau8p/c8/+1
	 LrOM/YIyXOSYA==
Subject:
 Re: [PATCH net-next v5 6/9] r8152: add rtl8157_unload and rtl8157_change_mtu
From: netdev-bot+sashiko@kernel.org
To: hsu.chih.kai@realtek.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
Date: Mon, 05 Oct 2026 09:57:22 +0000
Message-ID: <179119424285.434549.10300913467934880637@kernel.org>
In-Reply-To: <20261001091144.28191-7-nic_swsd@realtek.com>
References: <20261001091144.28191-7-nic_swsd@realtek.com>
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

- [Low] The commit message for "r8152: add rtl8157_unload and
  rtl8157_change_mtu" has two Fixes: tags (fd3c7d080df5 for RTL8157,…

--

r8152: add rtl8157_unload and rtl8157_change_mtu

This adds unload and change_mtu callbacks that only RTL8157 and RTL8159
use. rtl8157_unload() calls r8157_power_cut_en() and always disables
interrupt mitigation. rtl8157_change_mtu() sets MTPS from the configured
MTU instead of using the fixed MTPS_JUMBO.

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
With two Fixes: tags, this will probably go to net and stable. The
message doesn't say what goes wrong on RTL8157/RTL8159 without the
patch, though. Could it state the user-visible symptom being fixed?

The patch changes several things.

In rtl8157_unload(), r8157_power_cut_en(tp, false) replaces
r8153_power_cut_en(tp, false). After this, unload no longer clears
PHASE2_EN in USB_POWER_CUT, and it now clears BIT(1) of USB_MISC_2:

drivers/net/usb/r8152.c:r8157_power_cut_en() {
	...
	} else {
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT, PWR_EN);
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2, BIT(1));
	}
}

drivers/net/usb/r8152.c:r8153_power_cut_en() {
	...
	else
		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
				  PWR_EN | PHASE2_EN);
	...
}

In rtl8157_change_mtu(), MTPS is no longer the fixed MTPS_JUMBO, which
is 12 * 1024 / 64 = 0xc0:

- At the default MTU of 1500, mtu_to_size() gives 1522, so MTPS drops
  from 0xc0 (12K) to 0xa0 (10K).
- Above about 12K, MTPS grows with the MTU.
- At max_mtu = size_to_mtu(16 * 1024), the value would be 0x100, so it
  is capped to 0xff.

max_mtu allows frames up to 16K. Did the fixed 12K MTPS make jumbo
frames between 12K and 16K fail? If so, could the message say that?

The subject also reads like a refactor rather than a fix. Could the
unload power-cut change and the MTPS change be sent as two separate
patches, each describing the failure it fixes?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001091144.28191-1-nic_swsd%40realtek.com
