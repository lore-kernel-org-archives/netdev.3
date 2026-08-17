Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A734A797;
	Mon, 17 Aug 2026 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787008855; cv=none; b=sgHQLpbbN8lUy9CgHa27GgaORVFDIcknYM15Pl6UDXV4Bec2uksUZg7Eq72vKBnasOLdzSyLLjRZAsUngFrPg2aMa1tLqVHMBqwiWXRG9e5gToEy5jwIRrLgwAGZdexd7Ef1lwv/KpdRC9wXwlwKi6GS4yy9UrkDjtC+rAtuQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787008855; c=relaxed/simple;
	bh=AmZWOyublIrW1rcSoxdFY1m7qFly9By7UFIBWohh6Ac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=skHfkoYG4tyVz2X5wraUI7ErGGeVinKOHLaEj6JVXd7usScW3me4e46zcPutj0ouRrLnmqRqka9pAkH8Qg9ibZv85TCPgLXmSHyGQjJii1u6x8niNyQMfVgOcavjRTlNJesccO43NDMaHrF8v6wcSs1/+lugciKy2M87Kho4vo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK3M6w58; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK3M6w58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136121F000E9;
	Mon, 17 Aug 2026 23:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787008854;
	bh=5MPF511eWQQT2SD5xC2wsOY+rKSzf6TbN4VDVb1RJjU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JK3M6w58/krqa+rubdeOYckxCZABYx0oOxvhPq+CIBmzT2RD+HdWrhVoOyANyp1KT
	 mmVJxZ4mKh5H4UG7DO0ehTdV7+yh9g3rANo4qLqiOY/jMsEl19FQuMTUsXYiRMpG4f
	 +QPLQrakIR1ExL8q/FCAM7yDCTs+EIu/hSYZyWL1+DhDMVVP/y6CccQfcNNnsptYRF
	 6OnfLor3x6VCXCy4nTKzfo4kswddnlk5OU0OvJw5BGoN8DI1W9f48QcuH0Ui2v7wvh
	 wmsRHc/cao/DPAAJM/ijW/ioSlJZ2hFbPYvgLsqwh+ENJUrEG+7tna/u8rZpW83HNB
	 D6nARrf71zNxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568B33926276;
	Mon, 17 Aug 2026 23:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net RESEND] vxlan: vnifilter: enforce exact length of
 GROUP/GROUP6 attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178700880590.1786107.954670748778708008.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 23:20:05 +0000
References: <20260812215341.763123-1-xmei5@asu.edu>
In-Reply-To: <20260812215341.763123-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: kuba@kernel.org, idosch@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 roopa@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 petrm@nvidia.com, aroulin@nvidia.com, mmyangfl@gmail.com, kees@kernel.org,
 bestswngs@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 14:53:41 -0700 you wrote:
> The VXLAN VNI filter entry policy declares the GROUP/GROUP6 address
> attributes as NLA_BINARY with only a maximum length, so validate_nla()
> accepts a payload shorter than the address. The GROUP consumer reads it
> with nla_get_in_addr(), an unconditional 4-byte load, so a short
> attribute over-reads up to 3 bytes of uninitialised slab data, which are
> stored into remote_ip and echoed back via RTM_GETTUNNEL, disclosing
> kernel memory.
> 
> [...]

Here is the summary with links:
  - [net,RESEND] vxlan: vnifilter: enforce exact length of GROUP/GROUP6 attributes
    https://git.kernel.org/netdev/net/c/984f831dda31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


