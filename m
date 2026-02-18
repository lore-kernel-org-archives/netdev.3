Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E867155326
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771377624; cv=none; b=YHUYIdRI+559zYw/r711Cu7H7TfpR6c5igGKmDdf11EjRV3bPs1/7mbJyREOCucnjG+q3GVNQWSgVw284BOPC9SURQKgZilqZ7gCVSDZSPIQ4LpIzyxJK2ATK/s3aKeapUhm/dtcL7kOIAG/NvXTKCAbXqDTQeYsDIuxBQ0p/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771377624; c=relaxed/simple;
	bh=I0GtwqHJ8QMz2Jkw/APQloNWThwma1wOJ86habJxsWw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=usKt5dgg2pIQ30GZ7igXWJe1doe4F9wRNzwY2IMNKlH6fdBiwbrc9G6LDgkmvC4ypyhVQvBRg/E011rp6WM3LC4VG/VUN7/TT1edhSefmRDPR7l9ACuUTaGy3sCtQxo860DYxkR1S+qPPijzqnR+hGZyjJ1b6kuZiLnBLO+nMP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv3THNiI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv3THNiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1098BC4CEF7;
	Wed, 18 Feb 2026 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771377624;
	bh=I0GtwqHJ8QMz2Jkw/APQloNWThwma1wOJ86habJxsWw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dv3THNiIb14uSkbOmCG2nIvdYC6AbWE8djKPNda85Yo5sGz2JpfkW7z2hVf9/oFJs
	 A7KQhS5c/T4epVqiObb8msXPRLZvU6MsPSmrHxqgj1NOZzrUDXst9sxb9fau76+0bw
	 bVmLnoWTH02O4T5Vh5RztFg2yUJf+W+9HT+Q5iyHskxYvhCAUzFQs5Lt4/lfXHeTFS
	 3OcLFCpYooc29yoP/c7djqPZvhIRk707sWJoF8FPj4FTLWloXWqxz99mTHV9vBhH+U
	 FCsu8wgqvpmoO2+2oeuP+bREIgxkD6q4no4flPe0nYa1P47mg665nc5KTjtgt2ib/d
	 pJiQBK5enPd2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B09E3806667;
	Wed, 18 Feb 2026 01:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] macvlan: observe an RCU grace period in
 macvlan_common_newlink() error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137761558.765825.17298600822935264186.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:20:15 +0000
References: <20260213142557.3059043-1-edumazet@google.com>
In-Reply-To: <20260213142557.3059043-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, sec@valis.email

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Feb 2026 14:25:57 +0000 you wrote:
> valis reported that a race condition still happens after my prior patch.
> 
> macvlan_common_newlink() might have made @dev visible before
> detecting an error, and its caller will directly call free_netdev(dev).
> 
> We must respect an RCU period, either in macvlan or the core networking
> stack.
> 
> [...]

Here is the summary with links:
  - [net] macvlan: observe an RCU grace period in macvlan_common_newlink() error path
    https://git.kernel.org/netdev/net/c/e3f000f0dee1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


