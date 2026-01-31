Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B3331A41;
	Sat, 31 Jan 2026 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769827827; cv=none; b=Zx1STQawN8tUHxc0ZqZJSi7sme0owANcYf0q/do0EnFMoHFcNh/J2l1VVc/i19xVOJ4cqEzVcFAB3KjEIJ+6f/XyqZ4mq2eIDN/nyNfnQxyDlN7G7bhAYOXdd19rB0qtWAqtu7PQT1S6tSoHhR7b5mFLHjiw/Arw+jzDcAklUG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769827827; c=relaxed/simple;
	bh=76sIaFtoigFD7xcIJlnJzZeN22fctlS9ENtNuuQDizc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TQ6ijrJTu9oRCYquLtbE+Mx9mJBUlk9GZA+sMHWV3pJcksRfZIYp/BCLCCUwF639WuAebmp4s/1i0Hm0OE5vtJr4mnSsq6StuHkrOXCQqvo5mrjUYNZSKJ3g3gb2BgzUOpjMfcUHU5lR/oh8iYsKZTdmz+4/QElHR8w0uvxI+Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6vj9wQ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6vj9wQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2520EC4CEF7;
	Sat, 31 Jan 2026 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769827827;
	bh=76sIaFtoigFD7xcIJlnJzZeN22fctlS9ENtNuuQDizc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V6vj9wQ/TBSxcEPPClnElnBAJCzEc9wVwPlppkxpbAY+KBXYDl4vR1wdBOQZyxVii
	 /si+SUiOIdKbG94vDHLaUuLkmEaGySHKf4J3BfqeL01bGBjJsc1/OOeVgJyJHjylzx
	 ZVK/HVRIjGaLByeJJVsljL+G1/hVHcxTTIeMfbS505I2j0CxyRmVVGZZuG85+oDc5j
	 M6xwLbRvpLGi6JR/7m6FDlkoW4jTdbxKQE9mK9uUThF7YE6Nn5jR9g0ODsPohaVKcE
	 ekeOIiqsYecgN0KHv7g4HEPtUjROEIvlSQ5rDf+SKpgfXKC7hFfNxGRiEeVVyToFLb
	 R3G2uacZiL+Mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBC8380CFFF;
	Sat, 31 Jan 2026 02:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v8 0/8] net: wwan: add NMEA port type support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176982781910.3974876.10187738923673671133.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 02:50:19 +0000
References: <20260126062158.308598-1-slark_xiao@163.com>
In-Reply-To: <20260126062158.308598-1-slark_xiao@163.com>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mani@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Jan 2026 14:21:50 +0800 you wrote:
> The series introduces a long discussed NMEA port type support for the
> WWAN subsystem. There are two goals. From the WWAN driver perspective,
> NMEA exported as any other port type (e.g. AT, MBIM, QMI, etc.). From
> user space software perspective, the exported chardev belongs to the
> GNSS class what makes it easy to distinguish desired port and the WWAN
> device common to both NMEA and control (AT, MBIM, etc.) ports makes it
> easy to locate a control port for the GNSS receiver activation.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/8] net: wwan: core: remove unused port_id field
    https://git.kernel.org/netdev/net-next/c/d95c5aa45231
  - [net-next,v8,2/8] net: wwan: core: explicit WWAN device reference counting
    https://git.kernel.org/netdev/net-next/c/b9879ba78dca
  - [net-next,v8,3/8] net: wwan: core: split port creation and registration
    https://git.kernel.org/netdev/net-next/c/dccd23a673ca
  - [net-next,v8,4/8] net: wwan: core: split port unregister and stop
    https://git.kernel.org/netdev/net-next/c/0868ea347110
  - [net-next,v8,5/8] net: wwan: add NMEA port support
    https://git.kernel.org/netdev/net-next/c/5b2e294e0cd1
  - [net-next,v8,6/8] net: wwan: hwsim: refactor to support more port types
    https://git.kernel.org/netdev/net-next/c/f5b8065e1f1b
  - [net-next,v8,7/8] net: wwan: hwsim: support NMEA port emulation
    https://git.kernel.org/netdev/net-next/c/193985d1e447
  - [net-next,v8,8/8] net: wwan: mhi_wwan_ctrl: Add NMEA channel support
    https://git.kernel.org/netdev/net-next/c/209111d694dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


