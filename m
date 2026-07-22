Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22B4399DB
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743846; cv=none; b=clmE4pqK8m8qcn9vDrlxqLK66xHCDqVEQ6SJXmh4BhWy+DSVksII5c7veqOI+v1gjxSp5MDZ3UhyDi1+SoZzNavcEZA1wG8pkYTRLgy3d5vr+WWlkTc306osBIm73S/oXbXH18stKqtAqcICAJvdUH/f276pW7eqx7VVY/Wb0kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743846; c=relaxed/simple;
	bh=4Pi+ppNudEeAePghMrHJA9wnlREIc6keNSOfItmDgiM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bz2MNOp4U23CnqZhVgtwXvZXPc+C8NXOFS/2MgLLVenMXfL/YbxFDi5JD8ujArz329CH25a6YBQXz9oMPdd/FkNlkfqwQ+F3iMUTGniJzgRu3ELJMAS0q7dJY0rbCFyjztv1PYfhV6x4SDnYD0Uv7mhztYnRdzzwUBeUnIwyMiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf0AcGy3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf0AcGy3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A1F1F000E9;
	Wed, 22 Jul 2026 18:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784743845;
	bh=cE2X+C5BghhXLiHIployyaMVL0bqCkrDQCq/TmQ7wjg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nf0AcGy357HK3G451lOLAe+LDmK7bifM5LfK01ZnijghOdRjsf68uTDcl40ps7gvq
	 UqB1hzvr/j932xVZrDbuXlGHPa8cEjHmVm2xF/0VlcCMWXWljDO/ygcc0xn3QtCMML
	 wOQAvzD4stqIOn5vffXh4/CnbzD/zzDpganh1vQyZ8o4SU1fMT89diwSdtVn5klJex
	 u4kLplXssAZMFz28PL2I1E2EcZcYPa0NuCgngpyken9gGIRKorCTckFIgzgPxCEmt6
	 0v+nGqYTtHmACaaQuXOw3qblxqly+7su9IEywD4+IX/ePJ4wHvIaD9tHgtdYR2SjfJ
	 IULjyTLdBOreQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A6D380CECD;
	Wed, 22 Jul 2026 18:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: hsr: fix memory leak on slave unregistration
 by
 removing synced VLANs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178474381415.1967992.12199829895234095220.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 18:10:14 +0000
References: <20260721101240.995597-1-edumazet@google.com>
In-Reply-To: <20260721101240.995597-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+456957213f32970c0762@syzkaller.appspotmail.com, fmaurer@redhat.com,
 fmancera@suse.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Jul 2026 10:12:40 +0000 you wrote:
> When an HSR master device is brought UP, it auto-adds VLAN 0 via
> vlan_vid0_add(), which propagates VID 0 to its slave devices (slave A and B).
> 
> If a slave device is later unregistered while HSR is active (e.g., during
> netns cleanup or interface destruction), hsr_del_port() is called to
> detach the slave port from the HSR master. However, hsr_del_port() currently
> does not delete the VLAN IDs that were synced to the slave device by HSR.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: hsr: fix memory leak on slave unregistration by removing synced VLANs
    https://git.kernel.org/netdev/net/c/dcf15eaf5641

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


