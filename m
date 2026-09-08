Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E82D51E443;
	Tue,  8 Sep 2026 23:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911476; cv=none; b=BpTsafviDVuT3uQWdIF5/pGkjr/tZRadTNFhFByfQm2UQmvgz+5EJQhlsAZhRPrlbIkvmTd6QL+3uyHTaUWMn/4Ir0FAqFApCIjb4P0j1BX+CuPjx67zOaG0wiJOFTixocDWDVILw6mpDEnNc92/TSTIwAIprnHLMeNRyuzOC8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911476; c=relaxed/simple;
	bh=oF3MFnq7P1t3XWLg66ABmaY6ER5vk/9lvbIPUxdEJUQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZED5hzASGTHEegTrRPwEmQYn1J65JezyBlUX624X6DJc7TVOR7xMAUUcdFvv6Gqakzo4EdtimXOZK+EjosIVlx6Poz2NBQol1SIeZ5C64jh7ABgw0DrS9bvXx/HWk8i2q0FTPvEDxoZsJFbx2MuotYNAxiMjPshfrw3s06JImWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qr/bb1FT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr/bb1FT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D971F00A3D;
	Tue,  8 Sep 2026 23:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788911475;
	bh=+afp2QBI0IQI4iDWPrYB6W1VBSmkT73YA37rbrgk8Lc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Qr/bb1FTI/oFgVJg3Qul9C+HPQO0qzf1MMH2W8aW9rD0cmv0buYujRrlUQgbtPkmr
	 znwexraPCvi7gbNJDjXP98t6oMBvq2JQKTADVSAE4LgNNrPZZuNJRMC7piUFsPtP1N
	 9HabIw9JEc/pVCCkTwepGxBFkf8vmL5Ym/ML4Q4Mqdri0zvFRCXvPm4JrkyHeGDImi
	 exj0yKkMk8l+TaRIfA/MJ3m8bkXCmFABvprNs9NTQIZXyvWKQRMF/eqZHzI/LhszyQ
	 YCp8BQN8D4var7adi8v6e8MUUTTDVUQZ2uX6LW0Y4AudOCc6NKm0qaAKzjntnUGPh6
	 ntrX+x8p5Phrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9397B380820D;
	Tue,  8 Sep 2026 23:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: phonet: Fix the struct sockaddr_pn name in
 the
 example
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178891141313.68202.7646049308432935050.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 23:50:13 +0000
References: <20260905104123.43511-1-kmehltretter@gmail.com>
In-Reply-To: <20260905104123.43511-1-kmehltretter@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: courmisch@gmail.com, netdev@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  5 Sep 2026 12:41:23 +0200 you wrote:
> struct sockaddr_spn does not exist; the name is struct sockaddr_pn.
> 
> Use struct sockaddr_pn.
> 
> Fixes: 297edb600326 ("Phonet: support active connection without pipe controller on modem")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] docs: phonet: Fix the struct sockaddr_pn name in the example
    https://git.kernel.org/netdev/net-next/c/413999d2e588

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


