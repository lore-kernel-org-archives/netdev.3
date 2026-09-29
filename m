Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8132B13E;
	Tue, 29 Sep 2026 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641626; cv=none; b=cKMEcorhWLI9oXPJKgjDblk/P22Vn3tAyZjFHy4FIE1yW7JYI3JJVLh6vtjkrh2oQlEAsU6wwbrrvDeK5EqPoB/J+aj1ZtAnqArHHpZHwEZjoY354lW6tQtkDadzNS2zhxoCvI1WyUhNsS9p8d/DOZ+n5+bZ19K/mZIRFr6chIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641626; c=relaxed/simple;
	bh=TzCfhL3JGHc+iVOkoS2oZ9emmFsXD8BxHA0KGNXawes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki1jHtQSXJeUEYxZLNGgKjw3lvIHDpT0/Gcu7KavBdMBQWZKr/9w7KirK3ClVNN61Co1a/0WAPlYoyd54o+UtXA99qqakFYG9tfhouyfy/xS9WFK732CvkDuTcfWmKGDVKZh1+8c7neaxALsp1vxfpUoTBBu1/Ez9vygYQAb8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NDjf4paR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NDjf4paR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RhbH7v8YXxkNfYLoWgUSB3jLYRqHg4/xEj0uHEulYlw=; b=NDjf4paRDQiGiHI9OHEAdQ89mo
	wc7J0xhw60Hcl49tlXxzRNftCsytCyq8e4fJzwfyEAocb5YXBV+1GbnXZqlEQtuGPMZj8PlGq96qV
	GSmlp4SM+b4vfwwuf32tINUYd8l2FMCJ0ERVLyDtlb7CVr+wgIGgkM1qS9joiE0Fp548=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBLgN-007pPX-BB; Tue, 29 Sep 2026 02:26:55 +0200
Date: Tue, 29 Sep 2026 02:26:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	George Moussalem <george.moussalem@outlook.com>,
	Ziyang Huang <hzyitc@outlook.com>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: phy: qcom: at803x: Apply IPQ5018 analog
 settings at probe
Message-ID: <f8e1f642-8250-4c1f-be1c-713a0026282e@lunn.ch>
References: <20260928220717.939-1-yongzhao.derek@gmail.com>
 <20260928220717.939-3-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928220717.939-3-yongzhao.derek@gmail.com>

On Tue, Sep 29, 2026 at 12:07:17AM +0200, Yongzhao Chen wrote:
> ipq5018_probe() pulses the PHY reset, and the IPQ5018 internal GE PHY
> then starts autonegotiation on its own with its reset-default analog
> settings. The LDO, EEE timer, MSE threshold and optional short-cable
> DAC values are only written by ipq5018_config_init(), which runs when
> the MAC attaches the PHY, usually when the interface is opened.
> 
> On a Redmi AX5400 board, the IPQ5018 PHY is connected without a cable
> to PHY4 of a QCA8337 switch, and "qcom,dac-preset-short-cable" is set.
> Between probe and attach, about 39 s in these boots, both PHYs
> resolved 1000BASE-T every 2.5 to 3 s, but the link did not come up.
> After about five attempts, SmartSpeed downshifted on both sides at the
> same time: the IPQ5018 PHY stopped advertising 1000BASE-T (CTRL1000
> 0x0200 -> 0x0000), and so did the QCA8337 PHY (0x0600 -> 0x0400). The
> soft reset at attach restores the IPQ5018 advertisement, but nothing
> restores the QCA8337 side, and the link stayed down, also after
> taking the interface down and up again.
> 
> Apply the analog settings in probe right after the reset and restart
> autonegotiation, so that negotiation runs with them from the start.
> Factor the settings into a helper that is also used by
> ipq5018_config_init(), and return MDIO errors from it instead of
> ignoring them. Probe fails with the error; config_init() returns it.
> 
> genphy_restart_aneg() sets ANENABLE and ANRESTART and clears ISOLATE.
> With the reset-default BMCR value of 0x1140 read on this board, this
> is the same write that was tested (BMCR | BMCR_ANRESTART).
> 
> The same values are written on every board with this PHY; only the
> time of the write changes. On boards without the DAC property, no
> DAC register is written.
> 
> The same writes and the autonegotiation restart were tested in probe
> on that board, in OpenWrt's Linux 6.18.52 kernel, over 3 warm boots
> with and 3 without them. Without them, the link did not come up in
> any boot, with both sides downshifted as described above. With them,
> 1000BASE-T came up in every boot less than 3 s after the QCA8337 PHY
> was reset, before the interface was opened, and the QCA8337 PHY kept
> advertising 1000BASE-T with SmartSpeed enabled. The DAC values written
> in probe were still in place after the BMCR soft reset at attach.
> 
> This patch, backported to the same kernel without the downstream
> SmartSpeed workaround, then kept the link at 1000BASE-T with SmartSpeed
> enabled on that board over a first boot, a power cycle, three reboots,
> three interface down/up cycles, three autonegotiation restarts, a
> network restart and 10 minutes of operation.

The usual problem with AI generated commit messages. They are too
verbose. 

  ipq5018_probe() pulses the PHY reset, and the IPQ5018 internal GE
  PHY then starts autonegotiation on its own with its reset-default
  analog settings. Refactor the config_init the pull the setting of
  the analogue front into a helper, and call it at probe, so the
  updated values are used, not the reset values.

Patch 0/X should contain the big picture, and there is no need to
repeat it in the individual patches. It will get included in the text
of the merge commit.

    Andrew

---
pw-bot: cr
