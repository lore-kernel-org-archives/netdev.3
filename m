Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2809D3D16E5
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438283; cv=none; b=YnqwmXwy381ktH+icpxYRwDTGh0z3m8VmDZ1Nk0jQd7AjcUc0tIWtzflHiMZFWPK/fuNQuPrr+slix8AHnPjNpkW/XfOCMCbEKYRB9ITpw/I5qUj3s9n/4QMF8L+nfvMGtIzY46gi5BIKUmnjomUw4KCdYDUxTY9rXMsCk/JR+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438283; c=relaxed/simple;
	bh=cC60w6ACEFpj5aR/VedU68QHu9mT5ZfqBNIUVBcPmeY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kNyUA/eh1DGY5L4+D2qh292DdUvJtOWYW0Px3qg18TRnkjOteeFIP73MHYzAiHLX0Kmg8ygYs5Ts8r+/gDozIUdNm958O3xfW83fndSj2uqyt+msUPCFajhPaxlO/WsUOE2qMrSdv/WCU2OpFgSaqpeEcvSFfUJJzjp4U2X96IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEOY/4Iw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEOY/4Iw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03411F00899;
	Tue, 15 Sep 2026 02:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438281;
	bh=Ak5bgsTPqrx53uJeemk71kGkOzI4+hige7clEVyz+fc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FEOY/4IwCwS2BDogM/w0sfxKAUp55tELEmSg/iRlKZSwQlry4SqS4bZdodeh1TXgR
	 Y6IvsEaLF+aY7XhA4lTGpocytZ+9S2Ig0wvuv/9WrEzg2gBVOlZDRD8LQ7/xVJ9gH7
	 zouIjEdpoNoR4fjBzvP2EPpNv0Z74ecaYQ9dQChKB94W3JWAviV5bjKgJOYHakIKyB
	 C1lW9WKiI0iDa3a8jtmxzCkwnsL2xmErURyKqCz6UPeNhQa9eNjO7t3WAzhxqghN3D
	 n5RhQqnNv5uoCnR8Y4uzD7IxpcfuIH81EDNnoiL0l87vpmLsIqSjcxSpb34cwa1WKW
	 fi7K4ZqPASJbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A083924FFE;
	Tue, 15 Sep 2026 02:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sit: do not report an error from
 ipip6_fill_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178943821638.1315233.2580797650210209609.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 02:10:16 +0000
References: <20260912005442.1795813-1-edumazet@google.com>
In-Reply-To: <20260912005442.1795813-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Sep 2026 00:54:42 +0000 you wrote:
> ipip6_fill_info() returns -ENODEV if tunnel->sit_parms is NULL.
> 
> This can not happen yet: sit_parms is only cleared from
> ipip6_dev_free(), the priv_destructor, which runs long after
> RTM_DELLINK has been built.
> 
> Returning an error from a fill_info() handler is still a trap,
> because rtnl_dump_ifinfo() stops at the first failure and propagates
> it, letting one device hide all the remaining ones.
> 
> [...]

Here is the summary with links:
  - [net-next] sit: do not report an error from ipip6_fill_info()
    https://git.kernel.org/netdev/net-next/c/f7cd8d2dc74d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


