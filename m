Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1435A3BA;
	Thu, 12 Mar 2026 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348014; cv=none; b=ul5BK/oHmClWd2Pf9brmTEBNQEmWZbqQXlKCWy8C82udumt+0LsZks5/oEqLPQu1S+08T8TK2/f9IBYfHkic9ApKC5d07udlA+IdWV2ztG/gwReRSxXnVX+PRQtZzctnTK8DPPucjJ73wRcw8ES0fiGO1E8q5iQhLoLdw4dY2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348014; c=relaxed/simple;
	bh=vZt4PZoc19xqDusWpGughBjwOf/2j8qR1VrA18xVyH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RPck2wwrmvuSNDkdFBEuIrBUrhKJDdoNzvgw4/rwIcxnHpKsrytQysDl6C3vQwyt/qIfjpXTsQzYn1ep0j6XcLgdyDsTqR029FTFntBCN0bmS9lT05E6jU2IC+y4Cgybr29fbnVEv+7FIgWQA6uW/uLad4jVgIpWduWAWw17Rfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3lwowGz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3lwowGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7B7C2BC86;
	Thu, 12 Mar 2026 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773348014;
	bh=vZt4PZoc19xqDusWpGughBjwOf/2j8qR1VrA18xVyH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C3lwowGzG+acbpJG2HrYTOtFDaajebXU2e+4cq/BTkHCEAqd+B3XqJR4jnsWM+7Mw
	 DBsswVActKjyr8F5aaMWwlgjhns7/LrhpdSX/b0yEoibLK+9OsS98DK4HvknFRe2lc
	 UTQVRifAqpec0nA/mbhyHBMhIE1Uesrl94XFSPrLBcHPHVv9PG44M1y5cFPlqARf6C
	 +bkDm9oOAZK9Tr4gHLr4CPfLZC6hY/jN+hykVi+BvkmXUSsUYsn4CWDGxITHhwxcZz
	 PTg10C8mGoNOZpaz+U2DX/p0mKy7lu6hqLomX4cFTF/YEd7sDyqhQwD82/Zob5g7So
	 jN52nkzSZWcQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE693808200;
	Thu, 12 Mar 2026 20:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net-next] net: xgbe: use device_get_mac_addr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177334800929.549113.17311063509925018044.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 20:40:09 +0000
References: <20260310194647.3794-1-rosenp@gmail.com>
In-Reply-To: <20260310194647.3794-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Raju.Rangoju@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 12:46:46 -0700 you wrote:
> device_get_mac_addr is basically device_property_read_u8_array with an
> is_valid_ether_addr call. Allows just checking for ret.
> 
> Remove XGBE_MAC_ADDR_PROPERTY. device_get_mac_addr supports more
> properties than just "mac-address".
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> 
> [...]

Here is the summary with links:
  - [PATCHv3,net-next] net: xgbe: use device_get_mac_addr
    https://git.kernel.org/netdev/net-next/c/29ca18505d58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


