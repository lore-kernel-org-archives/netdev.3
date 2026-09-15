Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56A8286AC;
	Tue, 15 Sep 2026 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789432870; cv=none; b=elng0Vr3HJH4Rv9sxOpScjIpMGIHgpa1GKE7rjEmq0zkfmJ7bf3wBTAPIIBlviaS9C8v1PiAOHnabJZL6g3fQx/tmIorNAzxPH+hcyqwfwOkK70Th13y47I6t87cKAQ7kXA1rVSy7/qTjBDHyWppDdOx0CrmACbIkFNYNQsRLXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789432870; c=relaxed/simple;
	bh=+ffOmU8pJln0qXFEE0zbCzHF+JNlrL9djyiI92+W4NA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HW1G8tcJB/i3UrYEQBdDVh7zO44kVOzzs33LaIZXMevN6IedCR60afhlE0uNGX5sngi7PV91NgPyMzof4IfxwN53Z+zpSC3GaSDnEMgEg8fsD6PsTtE2COErNxEGRwp6luBEA+OPf6P7ZIPWLPt+65Txg90wWG+6ClPTVMRXd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC5kDXpF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC5kDXpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C76A1F000FF;
	Tue, 15 Sep 2026 00:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789432869;
	bh=WnJW95C/FQdbC/1Nhd3fC5Apx9LohoamAjfu83Z2vKI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iC5kDXpF7FSNKEGIucSGJXbzrQtAzcbdTq8OkN42AdmBldGlvkSVe4sMt0AxylQwf
	 Z6sn9rVJFWAAOaYrKSA7z1XWnW8VQCxgl3OZ6KjWdjweaN+xGHWqAnvyBXM9EQwAF9
	 UzVpxAcz83i/tWo9ryfJty/yEp9C8f2+d7UvpE7wMvi6ThqKEkV/KxJBeG0nlAMndj
	 fCesVote0I/bxesIkyRH9UnRIIdoIzKtwQZctMvVzpFvJzkr8rFvIbwrba8dCNY+9g
	 HUbHBgSbFnJDgN1jQybdKunyHdDSy+IbfPOHnM5CsgWElhGgEQKp2Zc5QOGH3/Whuy
	 sOZDZ3weumGXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568613924FFC;
	Tue, 15 Sep 2026 00:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: dp83867: restore LED configuration after
 a
 soft reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178943280413.1286519.754745669721308122.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 00:40:04 +0000
References: <20260908235740.120112-1-donggeunyoo.kernel@gmail.com>
In-Reply-To: <20260908235740.120112-1-donggeunyoo.kernel@gmail.com>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, alexander.stein@ew.tq-group.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Sep 2026 08:57:40 +0900 you wrote:
> The LED configuration lives in LEDCR1 (the per-LED function nibble) and
> LEDCR2 (per-LED driver enable/value and polarity). The driver programs it
> through the LED class callbacks -- dp83867_led_brightness_set(),
> dp83867_led_hw_control_set() and dp83867_led_polarity_set() -- either once
> from device tree at probe, or at runtime from sysfs and the netdev trigger.
> 
> dp83867_phy_reset(), the .soft_reset callback, issues a global software
> reset (CTRL SW_RESET), which the datasheet defines as resetting all
> registers, including the extended registers, to their defaults.
> phy_init_hw() runs .soft_reset before .config_init on every attach and
> resume -- phy_attach_direct(), mdio_bus_phy_resume() and MAC drivers -- so
> the LED configuration is wiped from the first attach onward and never
> restored. A device-tree polarity is lost, a manually driven LED goes dark,
> and an LED offloaded to the netdev trigger whose link stays down after a
> resume keeps the reset-default function until the next link event.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: dp83867: restore LED configuration after a soft reset
    https://git.kernel.org/netdev/net-next/c/043777e94880

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


