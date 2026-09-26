Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458342D97BA
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790382683; cv=none; b=t++Nmf2y8o4fnjOQz0sBAl2cFsFfKpVCPIDOKO3VzkFNhOxi1DVi/Qx10xi+ifqC1JZz6Yr1Tih5GIBUM44qMh+Wh9Zav16JA0UGriAw2vt6SdcDQGzVFkV1zJ//yJJK0gHSZWe+s4dGnzT8Jt7QwcL5RdueQva77gkgib1825A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790382683; c=relaxed/simple;
	bh=begpTl3duwxdw3dO6EsfgEH4KbsajsY8shrJVjGcGFA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bwRgw5txehgDqPegmJcCjschNtwMHqPjRBQgQ9prbku8oe9qu7C6i4QwMriOqM4pCOpFOoanGn247CVR290n122b0DTI7JvTwzcI4hu6wmFNjkociyg8YLUtndz5gMHROoYZEY6CWRAYDky679f4d6pEwLCZ5jTrZ+y2whcUOgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1kpUEen; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1kpUEen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDADB1F00893;
	Sat, 26 Sep 2026 00:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790382681;
	bh=WDPDJa8LyGwzwcez+HlghHgceBw/486nj+VQP746xIM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H1kpUEenSaSef9WAtyJJCLUeOgG6CysdoZxL3+ownaF15VPGvjgfw3Jry3mrKXhcT
	 2/BNkTl3uaNhAFyrQTSrwNUMPRvXQlQ+z0TqgMrgziQmurgXoROgw0TpK37xidAJ6v
	 ek/bA3AV8kmaiZdvJx+Aua+PcpjOCWeC26DNsHim5xiFvSuWZsUvE9570awf3QZk6D
	 JmKYFxVQpD+sJ9kTQGdp7tZ8Hqmm0LzOofMUG2Lh4KjeegCgW/81Ju3+MZw4RSPLE2
	 gm7fIS24qp4XRNuhfs88yEdPQEhhHnIRtELQqoaAXE7hSKCXi+TFPiDpJFIa058pRV
	 4x19KjXAKIyzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9396F3809A04;
	Sat, 26 Sep 2026 00:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sfp: ignore LOS also on Hisense GPON
 modules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038260914.3219877.11986922079975708619.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 00:30:09 +0000
References: <20260924115055.196631-1-kabel@kernel.org>
In-Reply-To: <20260924115055.196631-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk,
 marcin.nita@leolabs.pl, jspavlick@posteo.net, andrew@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 13:50:55 +0200 you wrote:
> Similar to commit 87d126852158467a ("net: sfp: improve Huawei MA5671a
> fixup"), in order to be able to communicate with the module for
> configuration even if the fiber is not connected, apply also the
> sfp_fixup_ignore_los() fixup to the following SFP modules:
> 
>   Hisense-Leox LXT-010S-H
>   Hisense ZNID-GPON-2311NA
>   HSGQ HSGQ-XPON-Stick
> 
> [...]

Here is the summary with links:
  - [net-next] net: sfp: ignore LOS also on Hisense GPON modules
    https://git.kernel.org/netdev/net-next/c/0fd5dfa99cfc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


