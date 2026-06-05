Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47D22EC081
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703410; cv=none; b=iax2gOymTFhJk5Yyk/22gkHHZAWIiHyJBo8Yy4/zfZpgPi2VU3IVQtsgGORc76Ld6bLK+l0nbDOyc76NGk9ZzG54a7yK9v2dKe02ZUZQsrs3uvqF0oNqd2UbS3Yq2Gp+OLu/Te8YhLGuAa+bPNyv8kcwtL9K2m3gquvTdSTPa/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703410; c=relaxed/simple;
	bh=BnwjXheBovz8lfkh7KurlEE21jpCWUzvhsW3L5LtbSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TwsddR4jiKYIhMHvxNKgZOQfxumWc3I/OkLAQ95SHx7QnRagI/hhW5LsesEVPH6NjRoE28728NX8iwb6NYUQ2thufesFeLZsKJ+wNlTllVmAqp+AOYf15WpKz7AGNNosWg4jNeGfwD7hJRwsy9dEKtxOvplt0jzlkyi8utYARMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqGKWEAD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqGKWEAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691441F00893;
	Fri,  5 Jun 2026 23:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780703409;
	bh=L61IAgYfK23ot4+ZlFBZh0c6nbjxPEXL+dDunACB0Aw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KqGKWEADRx1Qkh/jPqyCpl6L4sKhpNtGa3ERKuMhK0qTaRuk2dsPsLFlAp/KtD59S
	 WUsO11t+KQN2lgHqiey4Airn0lbmlkjewP8TvTGWwo8IDz6aiGaUCM6E1NRIjKGhaW
	 iLdr3PGVmW/nZblBcd7Fb3/8eKRvqQt3N8A47yp+TrXMga4VTrgDyIlTPiOF6hfgdL
	 6dBMyenl+HuPsgqUY0bXzVXCS59QAKe43lJzeGjw1nyxPv1PbqBcjs0zaT4Ziv6LQs
	 8pPy/9s9G0cJ1oH9wgqGjqv3pOy6HFlQ9VRXJtIFju/JWIsoNvy9U5lrDOGf8DqamV
	 AttjPVvAasnSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09633930C04;
	Fri,  5 Jun 2026 23:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2026-06-02 (i40e, ice, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178070340939.3960521.2304861352980842293.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 23:50:09 +0000
References: <20260602225513.393338-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260602225513.393338-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 15:55:08 -0700 you wrote:
> Maciej fixes i40e to keep q_vectors in sync through channel changes
> which caused issues with reconfiguration.
> 
> Petr Oros adds missing callbacks for U.FL DPLL pins on ice.
> 
> Alok Tiwari corrects copy/paste error causing incorrect reporting of PTP
> mailbox capability for idpf.
> 
> [...]

Here is the summary with links:
  - [net,1/3] i40e: keep q_vectors array in sync with channel count changes
    (no matching commit)
  - [net,2/3] ice: fix missing priority callbacks for U.FL DPLL pins
    https://git.kernel.org/netdev/net/c/f1fa677e428e
  - [net,3/3] idpf: fix mailbox capability for set device clock time
    https://git.kernel.org/netdev/net/c/85b0cbc1f38b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


