Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77623B71CC;
	Mon, 10 Aug 2026 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404067; cv=none; b=ElBe/3kgCUrYnh+2WWttTxuAG0KjC7EiM4mOFPXtfUJnu4FNehViMEJU5W9uOhQcoSZJq97eaekgbQlWHvzaMwuAqmH8e5Gja4DPRJYEnWO7cQHvfJ5ayjuska7IktU1S1zVyNa3OgYBdGGoZ5+YpdQapQ8OljcX0+vTEHRfTa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404067; c=relaxed/simple;
	bh=mONMEpnHauLOozsP8yTwn04cLW/xmPYMrSQ52fUKuiA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n02vJ+ZhYA03MqP1jtPz12r6ygY4HnQnijvvKFLWXbfsPJqUPXdxn6g4RxTQDz8CFmGMBTDNC+79qFvI5jedfhlpN1alIk+UHmzttdHAoTV19LfU4j70y6dGen4D6lEgwqmu8QExhD+PXDM9RCAdg/xMD6ttcRQ52z4Fd+IjXkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzaXXbTQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzaXXbTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3F41F000E9;
	Mon, 10 Aug 2026 23:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786404063;
	bh=H+8rMZmtG1e/zVULgVV2F9KIO20rN1afMwmKkIwLDqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JzaXXbTQakaNgUWYE1bAtLRuvLaa8R24Vt0F7EHU4sX7WSQI+8uPEDbkiRK1uYg1y
	 RlO+S6uu40y7Ddx7LlP38Ho1SBpuLcRqv7jRQnRf2tsSu7WjJhS65e1N8eKpPCwR29
	 jWHftWgZcugeiC29HSQ3sNlwmeDaDvXJxEVqUcssJW5zae0pbZ5nF3YrOHwycyBONC
	 DfJFPiHN2pFZ3BXYaakmCry3PdBnHvBN3h3me3jMgRrlMURFi4/1fEYq7+Vo/X5fub
	 XMNPJJ0RGoSA3QWfWBUCPCUd0iU0naPGvLWebMDZZiFid9YwrKVxSHN6GRTBivd+bX
	 1TOphD/Wm9v/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A15392626C;
	Mon, 10 Aug 2026 23:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/1] net: phy: realtek: fix EEE advertisement write
 on
 the internal PHY MMD path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640402010.250217.10215829928456153307.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 23:20:20 +0000
References: <20260806134716.3511821-1-o.rempel@pengutronix.de>
In-Reply-To: <20260806134716.3511821-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Aug 2026 15:47:16 +0200 you wrote:
> In rtlgen_write_mmd(), the MDIO_AN_EEE_ADV case swaps the arguments to
> rtlgen_write_vend2(): it passes the MMD register number as the OCP address
> and the OCP address constant as the value. The caller's value is discarded
> and the write lands on the wrong register, so the EEE advertisement cannot
> be configured on the affected PHYs.
> 
> Mirror rtlgen_read_mmd() and write the value to RTL_MDIO_AN_EEE_ADV.
> 
> [...]

Here is the summary with links:
  - [net,v1,1/1] net: phy: realtek: fix EEE advertisement write on the internal PHY MMD path
    https://git.kernel.org/netdev/net/c/202fef9bbbf5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


