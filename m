Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC93C4572
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599685; cv=none; b=nbQla4hzXFUzmjpi7L4KMemKvwFHKxv+hYJKKbFe+B5gnUyXPqJrqEO2Rce0rlNGubPb/Rf/3TDKQeD6ggrI1WjOXqF/ArUXkhprv+eByqDCgdWM0kokge8nbWOSESi+pkaV1c9/RHbep7GYVwU+B8h0QIRZuh26uD8Hi0SaA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599685; c=relaxed/simple;
	bh=76/lAHX9fZiDt6+tOf6rc5pavmfUytWxhHY/CQgHLiM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rFVn2SJs11oBctI+2VR1YEiVObM5UzsmL3YuEQZzSvgG96zkWT2/+tkNPpQDyVzU+ZyR4WS4D0FtC98QNyTP8KdtKnV0ce8NSLPmEmj3DCWdo5aoZ7q/qlUv6xnJgAeZ6t66DDXQ3a2gCZeUyT7z6uzi3MUklfmeXagZBXIaN10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agxnaBtu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agxnaBtu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309591F00893;
	Wed, 16 Sep 2026 23:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789599679;
	bh=jHjwllJjTXBgX79PdUzQjJHNwins48e73OZgev3bq70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=agxnaBtufFsPnjyDZN97OQsXmx4X4ziEvSxjKQV98toM7tgmqPX3T2hso2AtqY84r
	 ET6Zobc55gpfQ+G3/jqfL3z6z5y0J6G0wrNNtnG4QM9vqS2TuSj+9K+Z1k9qG3EWns
	 5ivBUMTLZvVwIJHEWasp92oLhp3yq8Ahy4gawPzTKIRLrQw3k5IYGWq0jAuDkEmyl+
	 C2CHg0RKAG+gAcY0sDW5OkFhAxZiglPi7L35UQOBKzbmVy/szJRrKGQmakhwbK0ntP
	 7LVRi4Mg/pnWiiMScPH3Xtfk6CtABRNwteVYkWmMdJgtfd+o/xu8QzG6ly2P7N104W
	 sqDmgfwE97U1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5697D39E8A7E;
	Wed, 16 Sep 2026 23:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request (net): ipsec 2026-09-16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178959961299.3323142.12502008775092350264.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 23:00:12 +0000
References: <20260916101938.118628-1-steffen.klassert@secunet.com>
In-Reply-To: <20260916101938.118628-1-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 12:19:29 +0200 you wrote:
> 1) xfrm: iptfs: fix stack OOB read in iptfs_skb_reset_frag_walk()
>    Add the up-front nr_frags guard iptfs_skb_add_frags() already has,
>    so an out-of-range offset can't walk past the on-stack frags[] array.
> 
> 2) xfrm: serialize state GC with device state flush
>    Serialize xfrm_state destruction against the deferred-device pass
>    with a dedicated mutex, since the device GC list doesn't hold a state
>    reference and the two paths could free the same state.
> 
> [...]

Here is the summary with links:
  - pull request (net): ipsec 2026-09-16
    https://git.kernel.org/netdev/net/c/7c7d5e9d7e39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


