Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F11A073F
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897810; cv=none; b=a9loUEUBZ9b9veR8MDbQPFiNfA2lm4OwrIfBESkk8OXEaheHqP3QthyQLrqloAIZo1vQnGGWUbftJcqfbfvCN+rcW+lUmSeBHqyP9Mpx3yxkJMOya0V5ZgKNjx5DbVNQFt0TUBvC/wIBN0XgmFrmtwWEGMC0/ExmQ2nkbvgJfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897810; c=relaxed/simple;
	bh=iSSBYag+Ia0G5kcMQ68qgo4sSE9p7e0YDlzgzUdz7wc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uDXFNCnnV3eC2wPPwkYLMPv06Er5iGsBEr5fmeFXjAC+mM8GJ9G1ktcu49PV+cxC362CuLpkLUFnMPmYG5Qirp8366YzR8tfQVKMkMxpoITsDSiCInM63UxsLIPkBwpET4dns0sgNgU8+wPaz1TbO1l+brxwOBdBiPyIEKJyCGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afQEeL63; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afQEeL63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D93C116C6;
	Tue, 24 Feb 2026 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771897810;
	bh=iSSBYag+Ia0G5kcMQ68qgo4sSE9p7e0YDlzgzUdz7wc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=afQEeL63wh7QjdlB/r8H10SSDfXBPL8T7uzYFmsYvOyricf3Bp06vZqKtx9iVqsh9
	 yYXIpFvpRtYE9ID+Muy0k1CS2dB7E+gx+6GTq9QgoZiwvVrPpn69wSi34BVyb7TUd5
	 VDeUdz84yD5nmMLkAbBQsfZUEDIF3BA44DWsOitaiAB+A/cZa484AYzJ1N0JTlsyyi
	 ZmIiNYwuuvmLO7NMfj1fcxdZITVzq0x1i18PWLkBr3wy6z1T7/zOtw5EmXzHcd8pMs
	 rgQSc231rCSvr1I2ZY/42vbE7pCRRr9O3oE4tm7MH0ONx0+YghZWm48sM4GgwbgHlE
	 tPKiv/bNAxYSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF3B3808200;
	Tue, 24 Feb 2026 01:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: fix duplicate publication key in
 tipc_service_insert_publ()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177189781629.3271663.1500511190271606977.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 01:50:16 +0000
References: <20260220050541.237962-1-tung.quang.nguyen@est.tech>
In-Reply-To: <20260220050541.237962-1-tung.quang.nguyen@est.tech>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, jmaloy@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Feb 2026 05:05:41 +0000 you wrote:
> TIPC uses named table to store TIPC services represented by type and
> instance. Each time an application calls TIPC API bind() to bind a
> type/instance to a socket, an entry is created and inserted into the
> named table. It looks like this:
> 
> named table:
> key1, entry1 (type, instance ...)
> key2, entry2 (type, instance ...)
> 
> [...]

Here is the summary with links:
  - [net] tipc: fix duplicate publication key in tipc_service_insert_publ()
    https://git.kernel.org/netdev/net/c/3aa677625c8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


