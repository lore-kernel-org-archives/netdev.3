Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9256B332EBB
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772247007; cv=none; b=r5Q2RNjfpTQx85GKt1U3YRHNgypmc1pU28gkzlQjDC0kR7rOS89CnHyCAuicUZTjHy1XUZOMx09nG5S0+8SNyzOfnUjc+TRDrGuo5PqrOmDtolqD6mEzyCvT4n6403NHI3df4dQ8D5lwWkoRhPhiiEE6CIH1nPbieG4uGiUirAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772247007; c=relaxed/simple;
	bh=HjxKTgPu4OQesumovcE8A+gEzjsakWeAxAeBGGn2m+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FxLGRiYWd4DQJkK8JLx6oPKYkg+o9trGe6CKnMFIoqZc8etxmmC3tdYqq08kwOlhq0/axXkZErmm4e9SEBbcHHjGHkeBZAlmhDkWnBCEyupQqegh2jkSVHyKprdM9CiU48hvHH1xz7fAwTi3tPtUu4xdQiw3uO9FXFOEQ3Kh2nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPHUJNAK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPHUJNAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA5DC19422;
	Sat, 28 Feb 2026 02:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772247007;
	bh=HjxKTgPu4OQesumovcE8A+gEzjsakWeAxAeBGGn2m+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sPHUJNAKMTjA0xk99KpmB5ekb+HLQbVUmpb2ZOvOaHAovvW/jGvFUaT5KzXyQpgb4
	 w8GnT9XThclyixDDzHKMzqYk6iaGdnhxpRAA74atyq8PRLiWqJrHEXovP5YnUz4KCo
	 3uBkSFF2mSWod44taWEhHf0b1i42sJkxbBu53WCGYKMyGlAjQDS38dpdPVxBQlSvvy
	 Re4k76kJdDg55OCOhKVZXjZXUkQ5HwS9Wob2gOPHwKQgTD44KM/bfwdfUul/xupA14
	 h6DB3VSOZV7/eZiCXYFwPTruINR6bnIJ+HZqiFAxITPXXBI43Vq6OHMId1MrHAW3Gr
	 rqA6tUfD2Kt7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F3339EF96C;
	Sat, 28 Feb 2026 02:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tls: don't select STREAM_PARSER
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224701054.2846847.13399809793828006242.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 02:50:10 +0000
References: 
 <cb41e513a30eeaac0b419284cc87433f049b2ee0.1771871995.git.sd@queasysnail.net>
In-Reply-To: 
 <cb41e513a30eeaac0b419284cc87433f049b2ee0.1771871995.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 15:26:27 +0100 you wrote:
> ktls was converted to its own stream parser in commit
> 84c61fe1a75b ("tls: rx: do not use the standard strparser"), but the
> Kconfig dependency was left. The only part of the original strparser
> that's shared with ktls are a few structs (strp_msg, sk_skb_cb) and
> the strp_msg helper, those don't require building the net/strparser
> code.
> 
> [...]

Here is the summary with links:
  - [net-next] tls: don't select STREAM_PARSER
    https://git.kernel.org/netdev/net-next/c/da89f2e31215

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


