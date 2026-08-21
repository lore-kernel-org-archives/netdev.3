Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF439EF1C
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347867; cv=none; b=jXlYaDzO0Qs9vPGjKmJdmZftH2LS2weXcpLdX8NdIZpV3lpNK8P2h/cI37/H/B+WTh5yZSn+yJrJGpCRm4PP3TJ1EFl9EWYf10m4mHtH3toHsEMIhZiejBfoc9l+gjI/N2hiFdUk/cDx7G+TbdTXJYm0PZmtNnKr6dr1HPPOR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347867; c=relaxed/simple;
	bh=wKnVjk7D3CWFpZyxOtWg9bT42pneiIWFmtCrDJuEmUg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OKbbZjcZo1axIKSqa3MJuZsLLViS/UVAq3yZmqb04YvOexXXqW8mj36q9+UTTpF1UL3b4BWN/ruw3wY4esQ9eOB4sgDOmBXYKhCHSE7jU+ew2Eed2GFTbOH9PwBbieWzzwD9ERbkB7dm2vYvI65i3oFHyLjgiIthID3sneUsCqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvjYZppi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvjYZppi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A8E1F000E9;
	Fri, 21 Aug 2026 21:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347863;
	bh=rRqbcegCSPyeqTLKs/6aR9/i6fFlourhx4KmyNj0Gls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LvjYZppiUr8ifNTdBK1fYQU9kO7MvzGKzg7ZaD6rmiBt+v9l5sGGxV9OXlJb7Owwa
	 e7N8sI4V7E+SKFHN89vpNqN6u7BK15P5JBgPs50QICk4nB1yo4zGvhyue9oGl7yAHf
	 Ol/BJDGjWWXd1OmpRckl+M3EbH+Q0U9PpS01RapzLz44tycEA40TciNtSxTuk/8CNF
	 B9sHpJH4RKn1T1OoV4R8kw/4qSP/lCEheUNurYJ13XmZyQgu1PfmgQcjhGLhNLBBGN
	 TwhnI+fIu0fpmcQM1g1RGIcC+/EuxxQ/8Jvyg8YxUGzM6xJBqcTkn2KEbTwnIMzwnu
	 B2y9JOMjb530g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197A5380CED0;
	Fri, 21 Aug 2026 21:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v6] ip/bond: add lacp_strict support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178734781256.1491177.16610625029555097734.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 21:30:12 +0000
References: <20260820164352.1933916-1-louis.scalbert@6wind.com>
In-Reply-To: <20260820164352.1933916-1-louis.scalbert@6wind.com>
To: Louis Scalbert <louis.scalbert@6wind.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, jv@jvosburgh.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
 andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com,
 jonas.gorski@gmail.com, horms@kernel.org, stephen@networkplumber.org,
 matttbe@kernel.org, dsahern@kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 20 Aug 2026 18:43:52 +0200 you wrote:
> lacp_strict defines the behavior of a LACP bonding interface
> when no slaves are in Collecting_Distributing state while at least
> 'min_links' slaves have carrier.
> 
> In the default (off) mode, the bonding master remains up and a
> single slave is selected for TX/RX, while traffic received on other
> slaves is dropped. This preserves the existing behavior.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v6] ip/bond: add lacp_strict support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=30365d0967bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


