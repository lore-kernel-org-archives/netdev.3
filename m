Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E1344D8B;
	Sat, 26 Sep 2026 01:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790387480; cv=none; b=RxQwVhqhG2OmWfnkQL58ue/9qMYTskTQdp2ZHbrcnMrtQWmHiEUFOiyYwBCC5ygt05WJHLHxn1q3mkzQFYOcH/Wp1XZOIv8ubyBUdlLi5egpRA+gIWdQtvjGvXWoa3pddF2qFKOiFbUTgG3VRLPgnrfFUDpVKsi3VBG71VVXbNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790387480; c=relaxed/simple;
	bh=3n29PCSBZoN+nsXmJd3S2MBOCKkZkKUhG0mUeIqrm9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kt/nFhWRrCrIZKGpB23pl8Iaa6wX3sT0Z8zdW6GBqYDkQHr4KZvh3l4Pv7HQG41aN4HzxALnKBr/oGv4uXswzyl+nV3tG0/k3oHsNxTysgZ3y13bXrLVGug3J7MrIESGs7R41u1Fmw2/8CV8lt7gs8cJsqH1H3DRRCsynEX9n5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZQYV8k9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZQYV8k9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644361F000FF;
	Sat, 26 Sep 2026 01:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790387479;
	bh=+VFT6xlGHxpC3kv25rw/bPdlgDq5bUdmZOCy6ObteTw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cZQYV8k9RIgZ70YxU298VqmdSLXwPUIOnfLTb5tz046zpmFAeJDf6KfWOJ+ugslO0
	 8dtSipey73QdOPJ46PIfKEsQWR7FWIBRQyYvXi64sI615kQMoncUpkfRH3glRt7Yv8
	 MgmDCzN+n7CWj0kZSS3O48pEG34SZPc3+Sc5vtYQ0lUZD0fX+b5qnwtFQL9xgAaTFO
	 6UDQ9G/I3mKYPoBKd82O7X49IpEtakxkNB2eNpYQrgWkCJsvjGKK6US+2AcGamOImx
	 aP0bB13IcN764QA9Y3zHKuz3d746ks2n0pec46xnPehMmwyGRkW4zKULz7GX3SzLb4
	 inzXGQCc+s0Qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 196D63809A08;
	Sat, 26 Sep 2026 01:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] idpf: fix kernel-doc parameter descriptions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038740665.3239957.9582197756741743570.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 01:50:06 +0000
References: <20260925000244.72480-1-ayush37735@gmail.com>
In-Reply-To: <20260925000244.72480-1-ayush37735@gmail.com>
To: Ayush Yaduvanshi <ayush37735@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 skhan@linuxfoundation.org, jkoolstra@xs4all.nl, me@brighamcampbell.com,
 linux-kernel-mentees@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 05:32:44 +0530 you wrote:
> Remove stale @vport parameter descriptions from
> 
> idpf_rx_desc_rel_all() and idpf_vport_queue_grp_rel_all().
> 
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] idpf: fix kernel-doc parameter descriptions
    https://git.kernel.org/netdev/net-next/c/014d795c7383

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


