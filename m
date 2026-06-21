Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31115175A66;
	Sun, 21 Jun 2026 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782077420; cv=none; b=CdMg+obgAgnPClVRy/amUfGxv4BBg/oLyr0DUxzf23iu+8ZycFdB0IbqgeRsK3xQf2nK55Pmoz2+ksMOKSckLIXbtZL7g4oPurhj8q41tyR2WTBWVHliymBpSAzYvV61ONtkGjDvQ+Sak3TP61wF8dyD+jVMa0EzaxKW/Y36utw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782077420; c=relaxed/simple;
	bh=Ce3LWIsT2in72S84ZAgtqzZC5+ngDOfVLXvlG+/obCo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QX/19o61WUW+gCLFeJ2vztVeDy1d3IGWoK7rMZG4OnLk1jX9LoOsaoGtH5Ra5GKm4GSvioD9yBM4YRHKvCJkNbKrylox8QTr4vruyn4LeplO/HYcQmhY6+MYcAdN+KtXxIWzmCYiu0SXhP0dGWGemNmLEHeLMwXAC8cCrnZkZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGWgGBey; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGWgGBey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82E51F000E9;
	Sun, 21 Jun 2026 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782077418;
	bh=zvlsAMznLvW7UgQPOBoCcZT0bB1JwaG5p6hPN99HFJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZGWgGBeyfWrHs3M5R7uQeCvcFRUk9SCaVd1U/FIh1atHSaW0p3BSOv1fHReStrYAS
	 KGuSRyKTxcXlrBJunJSc2QvfLvjVl/zP9X2DO6hfoRG8RYANx5L9+tBSQa2/tgThX6
	 R4pdmfVXM2XanIjqC6D0RPcbShqiVLhmziiUhqdvzhX2EplUi7xxNNOPkzDhIymtLe
	 +Qv02xv5uxZVhdBRamkRpIkrfUQGmw/YvqSyafwSJVf+sbW4PWIudMZ7Su3OhnSnGB
	 hwd0lMazoWHrMZ6l1MQUac8djIUcl5q7Z8NS/44XzgZy7p9USjfONKF6QRu+hlPtbo
	 ZsXjLTUHJzHJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5690F3AAA6E4;
	Sun, 21 Jun 2026 21:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: marvell: prestera: initialize err in
 prestera_port_sfp_bind
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178207741003.507333.17224738747581277452.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 21:30:10 +0000
References: <20260617193228.1653582-1-ruoyuw560@gmail.com>
In-Reply-To: <20260617193228.1653582-1-ruoyuw560@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: taras.chornyi@plvision.eu, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, oleksandr.mazur@plvision.eu, yevhen.orlov@plvision.eu,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jun 2026 03:32:28 +0800 you wrote:
> prestera_port_sfp_bind() returns err after walking the ports node. If no
> child node matches the port's front-panel id, err is never assigned.
> 
> Initialize err to 0 because absence of a matching optional port device
> tree node is not an error. In that case no phylink is created and port
> creation should continue with port->phy_link left NULL. Errors from
> malformed matched nodes and phylink_create() still propagate.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: marvell: prestera: initialize err in prestera_port_sfp_bind
    https://git.kernel.org/netdev/net/c/62b01f72d93c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


