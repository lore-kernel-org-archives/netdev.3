Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D956F3D9DDB;
	Thu, 30 Jul 2026 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450653; cv=none; b=LSymTkeJVYIsWPmO/W0qiwKIH8YBJOUqZJSwtT5tQ5cLak8Uq7APmr7YGCrjO5mYonXvipNEMOvB2UsE1FJuBuz/TPvauzD7KUOnhVVhWDeDy1RlRvTInngrx01hFJ5dG/O++0G8hSJLof4ZIcZMczBnER9XotuFppSB0nO8wyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450653; c=relaxed/simple;
	bh=aRdRNwfVzv+pWeZfpzuXmidWHQrToLQvGvxf4PWC9j4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YnBnM1Wtx50cyu8qmHBB38wC9W/QyCbg80bhJZMWDvYIb63da32y/++Lnbn6cIhbiFcL5humBvpMgazMWqD4eHmUE4rie8xk56tzNA1jOobWBd/6fvv8dQC0euZo7EGxADgHF2UZ/l/Da59Ymztsn/hhEWQylIZY1QtQ15RV+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfxdUyAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfxdUyAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5CC1F000E9;
	Thu, 30 Jul 2026 22:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785450651;
	bh=3GdfQsE7M2CiRlwBe33ozH0LAWPA4ZyF88hgKGRIcW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nfxdUyAl9PjaRwQDzZh2oatn8D7DJ/vHAd3pbxb/XxS36oXwZt4K9rncB9gvVaA56
	 aw+Rjl6fZNAVDTMUAacRw9SZb56LKcbf0WoqiSNBcU61yt3X4hKrgbf0oi1TnAqrB2
	 ZbYxESlQWG8O4LoPNHWUSo8YUyHJeLfChazoJvLgwVFamA5HxDuNocxOc8wVvPg50p
	 10tUwfTyf975YY8V8zciMFm/6hXLxsc3iNb4mvpQqh7D+Teb+TlpK1i/dLCOAUCh+Q
	 OXLeSJSVCi9TWrzqz9ZtUdLmIj5Yp18V+CrejXSbUXcdBkM1h694ZBn0uhzrCa3eOh
	 tLVqjvezdv5KQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198563924459;
	Thu, 30 Jul 2026 22:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dt-bindings: net: microchip: fix entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178545061463.16570.1712327331541284719.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 22:30:14 +0000
References: <20260722093259.3109588-2-manuelebnerli@mailbox.org>
In-Reply-To: <20260722093259.3109588-2-manuelebnerli@mailbox.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, o.rempel@pengutronix.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 11:32:59 +0200 you wrote:
> Remove needless '  ID)'
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
> [v2]
>  Remove ')' -> Remove '  ID)' as suggested by Jakub Kicinski
> 
> [...]

Here is the summary with links:
  - [v2] dt-bindings: net: microchip: fix entry
    https://git.kernel.org/netdev/net-next/c/61a878bafdf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


