Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE9F463B96;
	Thu, 24 Sep 2026 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244091; cv=none; b=IBvS+cQjCX295/uWsI26JdHNSMc5GIFMAhCvSiW9ITGOwBYG9ls52jX+E+wH2SAFMZMgjEW/N3HOgzlMLl4lPVElx9TsD994C4SuTWConKG1sedQJPa3bUxk8lhbNDSJNT04U29oNeuO3HDWe8Ps5JS1rbJ+JAW4yfSLXdVeOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244091; c=relaxed/simple;
	bh=GnBLPbpLbuJpdd7NwANHhNOiKjmXgENvztX0vlWAt88=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mniE76XBLNR6I0rICRha0sea1rWq/nEYYCe89F07RvRDwoQen5fn0rsO7Zcx7LseKz1ymI8fjXD/XaY3qevQOnhKv5x46kBJhW3MpRhVM8dX2wy7zvXB0j5U1mQjVIjUq2Okvk5O6gE7FoBjqI0BV+d08xbF5DQsAMO6wobVMV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxCG1eBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxCG1eBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6396A1F0089E;
	Thu, 24 Sep 2026 10:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790244076;
	bh=AaNmCCGjtxVta56btTIKLxRKWOenItpDwWHn5aWGFxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gxCG1eBprXXQ8lfTsjVbEYr2h+8xdFAtrm2+yMf7iORGrNegFgLEx5zrvqgbUGYWc
	 R5MLvAfxy3Qptq5k6TYeZFyXY1E1MVJwpvyVQaprIpTMMMo3RZ/yE8/Dvz/dZDzM4K
	 0L17DLNTAGbwZ6nWPrgEOMHogr3b3dK4bnZs4/tkC6PNFGGWFLxgm8dqvSVaWBnnOe
	 2iNM5IBxR45pkW40Ls4Wz6iNsDyQUxho9jvf/7IvOD/pZcOuD8aiTwoJUU868JrLd9
	 swSwdYmQ78mimXRLmebXXqNp/wa4f8RwXd/aEEMWkR89v8OJb3G5IBxCmaR9bleQOb
	 CvedeVsDoy3jA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AEB39EB06A;
	Thu, 24 Sep 2026 10:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] bonding: crypto offload enabled,
 non-offload slave failover, rekey failed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179024400545.1442619.2930959931801538685.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 10:00:05 +0000
References: <20260918211155.1664493-1-zdai@linux.ibm.com>
In-Reply-To: <20260918211155.1664493-1-zdai@linux.ibm.com>
To: David Dai <zdai@linux.ibm.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jarod@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hangbin.liu@linux.dev,
 pradeeps@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Sep 2026 16:11:55 -0500 you wrote:
> Create a bonding device (i.e. bond0) in active-backup mode, 2 slaves.
> Active slave: offload capable interface (i.e. eth1), primary interface.
> Backup slave: non-offload capable interface(i.e. eth2).
> Configure strongswan service swantl.conf child SA "hw_offload = crypto"
> Start strongswan service
> IPSec Crytpo Offload is enabled on top of bond0. i.e.
> ip xfrm state |grep offload
>         crypto offload parameters: dev bond0 dir out mode crypto
> 	crypto offload parameters: dev bond0 dir in mode crypto
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] bonding: crypto offload enabled, non-offload slave failover, rekey failed
    https://git.kernel.org/netdev/net/c/00efbbd40bd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


