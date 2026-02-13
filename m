Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4A23182D
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 02:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770951019; cv=none; b=GMga2BfvsU/LgFDAGW5UL6XI8yApr5D7613qahWcoNfEVgN/1gw5iffkUAh1lH6Z/ECPEtaF6DTAfym3vyVCObQPc0MAArrK4czgNAN/yfE/GMD+ySB8UwVMwZps69jLAiyMHNPGlsryDOQCemd4O7ML0Zl363FLFyTySsb8hjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770951019; c=relaxed/simple;
	bh=FwFCwt0yboh28o5pYBM2lKaV+SuSffxENgsX4kZVOJs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FEiiHcSvh1HDnpjvJQouN6DGdNS7cJJjud3fHgPnnkMXEm4zZefGMMi/NmK86mKRtVuY0lTfXiugmbKN4D2oPVzxJeqbrcWNc7kwZ5eU6fponza9Lsb4Ahtplljcvjvu7fvdvEVkY0uuE8zjl24dJshWhkkecZ//BA5fxoELBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3JfeKXL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3JfeKXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A122AC19421;
	Fri, 13 Feb 2026 02:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770951019;
	bh=FwFCwt0yboh28o5pYBM2lKaV+SuSffxENgsX4kZVOJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P3JfeKXLEfXwMTgcZfEqyjv61cUA2JY8ns8mAd1xD2UmSFhRoO5Y7ASQhGQTjSC0O
	 XsvjgRJDRrqGXWd0LCoOYWyfheJQNYXoTC0OEIhBnpZeFLaft0Zeo6qtDeraXuXsYw
	 +0GX0NDjXvavOprNrhZEIldQWWjlp9V2EovKT5iix4UMKpSWJjfy8TubNxIDql6Hst
	 fUOPFNOPNZ80a5Tf/xixVfzOJ3L9Fb5pK6gBoLGiWSNCBc108DBRTQaE+tahgpfnWj
	 PfVl+YQ3aVsfqwzuHZBX6blPjIBQCPvnHsZ7KPnJN4XCNdxCaFFz6M3j/G4xQSxuzQ
	 N3SIWJ4qi+koA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B1243931093;
	Fri, 13 Feb 2026 02:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: mlxsw: tc_restrictions: Fix test failure
 with
 new iproute2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177095101382.1819996.13537683853933427074.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 02:50:13 +0000
References: 
 <88b00c6e85188aa6a065dc240206119b328c46e1.1770643998.git.petrm@nvidia.com>
In-Reply-To: 
 <88b00c6e85188aa6a065dc240206119b328c46e1.1770643998.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 idosch@nvidia.com, mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 9 Feb 2026 14:53:53 +0100 you wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> As explained in [1], iproute2 started rejecting tc-police burst sizes
> that result in an overflow. This can happen when the burst size is high
> enough and the rate is low enough.
> 
> A couple of test cases specify such configurations, resulting in
> iproute2 errors and test failure.
> 
> [...]

Here is the summary with links:
  - [net] selftests: mlxsw: tc_restrictions: Fix test failure with new iproute2
    https://git.kernel.org/netdev/net/c/a2646773a005

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


