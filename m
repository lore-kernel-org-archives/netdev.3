Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13343394EBA;
	Fri, 16 Oct 2026 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116614; cv=none; b=jhy3ZfgeC1eyFjqbR941/54NA6dcksZ6ikQXBLuWHeOzDE2X8IhBr2ICvQhejuJt8SqexDag6JgppiGcF/V2sGb1a4pUX4Rz58XvoVZu8PITkq4DaHDaP1JzSVrx/vMYWufetNhsKTbaqR5u3sx9Kpch50xfrKQ4JqHKo+V83ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116614; c=relaxed/simple;
	bh=Vbq+nIfvuXAHEGaCWMw6OuUtvpj5xdK34qHFRq5GAzs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sO6WsA8Z1b0v2gpP/Eq/4p6Pj6njmuvSOyejo9SBSIKcXeJDbYKqjJNcYAm6YHIOQpLeniCdP8cLYidpUQfTy54sEBBaIBSRYLrWP4pmJXFlTRo2XvXZFq0085blN7cKpqKoj2ILy8b/d6MsSZiXH7BDTBLOlA6wt98vyWikoZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtptI2Ah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtptI2Ah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26531F000C4;
	Fri, 16 Oct 2026 02:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792116612;
	bh=cfuqk0NOUTZR7kJZoa5ayZpirJaB0F0MO7/UmzzPWWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YtptI2AhcTV9PmYKVtquXaCJo7dcmmjghLASb8B4VmqD+iiN1g4k1rLVc+s/k62QW
	 sE2tjP8qcqZfZrOaFDeY7i/L+o91I8rZ+ZvaM0sjnhTUtGbwHcihFDmyml7qxCr26l
	 f4B/p8isPxu5G+iVTsC0Z1nkol3STpucQcDeOlwkotXh+Ajpl1y1hmFl0PrFnidon1
	 f6oWcNIS/e0qhPJPhuts1F1eMrwOScOeDTfPdVeGzlh2jkpN+UlgaB8bjq5nFovF85
	 iNy+y95tE2bvWY5Vn1556X2uNzmVlERPW8F0CWsWjYq4INoxJ1UQb4zRRO8JorCF7t
	 TfYt70XxrbcQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B52BE3808209;
	Fri, 16 Oct 2026 02:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ncsi: Fix use-after-free in the VLAN id list
 removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211661127.15365.13625604077891022766.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 02:10:11 +0000
References: <20261010030820.91563-1-18983559317@163.com>
In-Reply-To: <20261010030820.91563-1-18983559317@163.com>
To: Binbin Deng <18983559317@163.com>
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, fercerpav@gmail.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Oct 2026 11:08:20 +0800 you wrote:
> ncsi_vlan_rx_kill_vid() removes an entry from the NCSI VLAN list with:
> 
> 	list_for_each_entry_safe(vlan, tmp, &ndp->vlan_vids, list)
> 		if (vlan->vid == vid) {
> 			list_del_rcu(&vlan->list);
> 			found = true;
> 			kfree(vlan);
> 		}
> 
> [...]

Here is the summary with links:
  - [net,v2] ncsi: Fix use-after-free in the VLAN id list removal
    https://git.kernel.org/netdev/net-next/c/9c7e89fc1b68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


