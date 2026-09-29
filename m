Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC62D781B;
	Tue, 29 Sep 2026 00:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640085; cv=none; b=m1uhwXOOf6AXC5s+8021VGK1hhlD5nG/upLfTtc328MDY6wxtkF32WMTGBUG7+c0Zi0aMhnoA7MngvyAsgo6YyhmHiaqvhbPr4nF9qXhUtFhCY9+HtL0LXYDxv1/ngz52N+d3b5iIBHy4zKNox/M41askMJls6scYH58Efo66bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640085; c=relaxed/simple;
	bh=Qkbgu2Q8f2wYfiX4fZdPyjSzjhDiNhQUOhA1vvaO8rg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FbRwXe85jjWG5SGkptA5brzf0N4AzttMLzZhxgZSAuHHODtk4Gmn6ETI0hie39IlIqdgx7Umz16nw54bXhOX2222ViXtCGsNCgca5yprFLTCgpeOlTApI3DkDKjoiWNG9m6qtemLYBjCm0ckQtti7PDJYIerIkcqljaPWM7ZlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtYq8brY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtYq8brY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16F21F000FF;
	Tue, 29 Sep 2026 00:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790640083;
	bh=zx2JZFL3ZzV9KnmbgSdyoKzQoQrDvpf8ZQDAWyEyi5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PtYq8brYpM74RB/9UtCXZDt9d39Eg0t5+X/ioNhGDzrQiXUpG6F9QMsVQy+zUf2d/
	 /AlNs9udLL5TipSmHm7jkkyz6YEl2UgSufkGxzIsAlAR5feKVa435QJBT/c2VPb19x
	 zvgT/DkGhva5Ha8KxyJ3ZYNHUtD0TSk21q4Z7hIZKa8ftCrWmzJaPdBkYLOfM3x1nj
	 NJuvTdbpGdSWoFHB20dzDaA/svZHeM8oKa3sPYq9fRVFMDLvpuiB1f+hd9HCbMhorh
	 A3YDyWCu/TacEYylB11WFZ3CCRUslw45FkUHycoDtoQkrSWmr9OA4lRGs5Z5C80OEK
	 sJSvW1kMc1CxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569A13924FE4;
	Tue, 29 Sep 2026 00:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Documentation: dsa: b53: fix stale tagging-support
 section
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064000790.182825.4518808867717683923.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 00:00:07 +0000
References: <20260922211439.369917-1-chrismelnu@gmail.com>
In-Reply-To: <20260922211439.369917-1-chrismelnu@gmail.com>
To: Christian Melendez <chrismelnu@gmail.com>
Cc: florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 corbet@lwn.net, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 23:14:38 +0200 you wrote:
> 5325/5365 were listed under "Configuration without tagging support".
> b53_get_tag_protocol() assigns them DSA_TAG_PROTO_BRCM_LEGACY_FCS
> (commit c3cf059a4d41), implemented in net/dsa/tag_brcm.c. Move them to
> the tagging-supported section.
> 
> 539x/531x5, the only chips left in that section, get no special case
> in b53_get_tag_protocol() either. The section and its config examples
> no longer apply to any b53 switch, so remove them.
> 
> [...]

Here is the summary with links:
  - [1/2] Documentation: dsa: b53: fix stale tagging-support section
    (no matching commit)
  - [2/2] MAINTAINERS: add missing entry for b53.rst
    https://git.kernel.org/netdev/net/c/6b2462f07cb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


