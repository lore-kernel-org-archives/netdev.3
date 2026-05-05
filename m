Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CB836308A;
	Tue,  5 May 2026 02:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946464; cv=none; b=fCjpFm6CxQzvJv4Jnn/BcrelKfay6Au/jqRFjkSl7dasiGr5CHYP3YJAgbDMuwzM1ozJ+kUFQNfH6uplC47HEGpAI68dHyb209XNf8vX+Koc772LecQU7sGNWxMR3oaHHZM6NExbWyjdivOyCNY0dCfjkf0obV/9+KzSJqVxf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946464; c=relaxed/simple;
	bh=aNAWxBo4mva8lkZhbXzumzlkowIF8ZnoUCCRY3Z7LX0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GQ1OaJsLfVb3djtKnhSg1jknSNuTUc9khfZNUxqiOKDg1TGPluqDuZCPX9J5NTli6aj5EpqzJLML0xA4Fuu1fD7beyJzLBH7okVFjOxmROvgkD1jVOkB3T2NctD6y/bj7JoicSewsQ4Imx0H5e2w+pyPeE8LDkksra0yRG0Ug04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyzF+S+n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyzF+S+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A31C2BCB8;
	Tue,  5 May 2026 02:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777946464;
	bh=aNAWxBo4mva8lkZhbXzumzlkowIF8ZnoUCCRY3Z7LX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eyzF+S+njcyWxH71/4wCMc+qmzAlGcdVFav5RvXc5C72nBQ3LYTGgPL9sCMzLrtzG
	 FGqdKmCADOfzqQe900APQU2diOazBd5+Yv89HpwtuWtfehXsPsMhdY2brLsPiHGKpw
	 Y6jx/sjsNaAZlTLXwCJbh29h0hwZzwnsOLilLPfgvLZ7U/b5i3SbS1fd+qUMDVdbaS
	 mXh6i+eE0lHRHmyO74duSqJ1bcf8ot0N17XlGavcsgbKwKb9O61PNfBZkaDPo63KbI
	 a2JgNnzbxu/eupDQ6nS/OW20bQeGncQsbTdhDABzDKRXiKFWzD20k9TITNzjbOI+Pj
	 R/jB8+2tPHwPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EAC3930197;
	Tue,  5 May 2026 02:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/1] net: phy: realtek: Add support for PHY LEDs on
 RTL8221B
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794641554.1386640.11256426332704981497.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:00:15 +0000
References: <20260501100002.755672-1-amadeus@jmu.edu.cn>
In-Reply-To: <20260501100002.755672-1-amadeus@jmu.edu.cn>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: davem@davemloft.net, andrew@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, linux@armlinux.org.uk, daniel@makrotopia.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 May 2026 18:00:02 +0800 you wrote:
> Realtek RTL8221B Ethernet PHY supports three LED pins which are used to
> indicate link status and activity. Add netdev trigger support for them.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
> Changes in v3:
> - In led_hw_control_set, reset the LED polarity to default.
> - Link to v2: https://lore.kernel.org/all/20260420100800.2435204-1-amadeus@jmu.edu.cn/
> Changes in v2:
> - Invert the LED polarity in led_brightness_set to achieve LED_ON.
> - Link to v1: https://lore.kernel.org/all/20260401100010.3079700-1-amadeus@jmu.edu.cn/
> 
> [...]

Here is the summary with links:
  - [v3,1/1] net: phy: realtek: Add support for PHY LEDs on RTL8221B
    https://git.kernel.org/netdev/net-next/c/d3aae4d954f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


