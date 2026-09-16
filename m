Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFBC13A258
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789517475; cv=none; b=tDyXxe1LSPX5e8qjfxZBDO0a/K5V00AsTDSrfDDnCLv3K0E+2WIriTKDpKD2ZYN8XokDZHRd1TArikrM7Uj42LvB1BEpDxSXdehTJkbjK6dtHNM6E3BE1WpfrsaLP45GgORdbrsia2XYA+X2iSV517ulMq6+F9uEQ7q6tyA0/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789517475; c=relaxed/simple;
	bh=JyX2jFMc3vSKsl/U6/u1m1dwjSt2Mo/sRY62Q3Sl6aU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JmNELzKkNRBiyXDJIR1BZZt5eG3OnYUZAaGSquY+pXwHjVQ5jg8A/Kjkxn/0XQJ9grZJN4uNRVD3RwmKlji6n9CH7cA8DZYZFn46qUAaWSm144J5odZgBT0vWlnUJSffUI/JHCXQkhKzOzdq/UKWBCGERU+Vao0pfCqrbbblJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1nxqZ5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1nxqZ5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D8A1F000FF;
	Wed, 16 Sep 2026 00:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789517473;
	bh=D5jMq3f2Yy/ZDSkoech/7qYqbpoi0CVkKz7eZOPEjNo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f1nxqZ5OJejye4FJv1CW3ZTjBy7aKDLNK7m62FZ26wGRT2h2zOdg/MvexjEfzGSfa
	 G63Va+gHCDwi/LK4EM9HFlibyfVDmp6h9yiN9fTXASRocW0hFrX8jDER9V2bARCvpq
	 OR+zqIL7e3b2mtrRQllwiEBhvPBRx68mJvZ9E3FTcBwNFY9Yilga7aNt6bJWvGlORU
	 NsQRDgAZMC6aoJqYYqzWEe/t9jQulBNf+KFT/t6wVhs509L8PLXLy6RDGx+Eou7aQV
	 l+c3WEjLVEK1ycPYZfnQsCofHzfvOLmY3vjKFGM29yo6HLjUhu0cCI3gO/jgG9Xp8p
	 Rkn00IJJW/nrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198DB392706C;
	Wed, 16 Sep 2026 00:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: fix TSO header length truncation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178951740763.2328807.9767514074293530178.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 00:10:07 +0000
References: 
 <20260911-stmmac-fix-header-length-v1-1-8fc103334327@oss.qualcomm.com>
In-Reply-To: 
 <20260911-stmmac-fix-header-length-v1-1-8fc103334327@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 niklas.cassel@axis.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Sep 2026 11:20:15 +0200 you wrote:
> stmmac_tso_xmit() stores the protocol header length returned by
> stmmac_tso_header_size() in a u8. stmmac_tso_valid_packet() admits
> headers up to 1023 bytes, so a header longer than 255 bytes wraps modulo
> 256 (486 becomes 230, 256 becomes 0).
> 
> A TCP over IPv6 socket carrying a few hundred bytes of sticky
> destination/hop-by-hop options makes skb_tcp_all_headers() exceed 255
> while staying below the 1023-byte limit, so such an skb reaches
> stmmac_tso_xmit().
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: fix TSO header length truncation
    https://git.kernel.org/netdev/net/c/15989abd74f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


