Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612406;
	b=mmPwRVw5zi0d8QpV5y2aVxHv6o14BkpHf3FMAYOWrdwCKIqodtpSNCm5niXPUnOpKAa2
	 UFRjcjSM7mmj/b/NrO9FY/iAfHjSGwco74zd2QSVZBR6JCWwR+buTPEjOyTQE0xKNap8j
	 cf000Li8Y6ddiH/E4U3BIlclFjJlwArZ2IY1z9qcJnY/kT2rNiZd9I3qN9RLf5Qr1DBAn
	 Nft+t4ck6UB+4/3bsvWj3jIxlCHMY/oe/Dzcp4nuqfN6pUOvxZ50tDYE+M55IvBS+ktcE
	 NujXJd6yA4SYbmnyl6VHLCZKUIflHHysOVc1t3Ec/dP928c4H5gZxGYvBJahRaa4P+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=koy48tw7Roi2TNVALKt7ehN7IwQ8uU25JAdoz9k07yQ=;
	b=pyYfrea+FbuxoCQgh+/1UNJadRoZVim0vczY24/FlFUUsN18zGvIKEswON5r7NBUr/fZ
	 gxeLyR9hulFYMxI7glY0tO60BLGPo86ROJu28cUdJFLnlOilIO7CGVrr4Uxsz5hQaMoEU
	 P0MBc4Z2Nyaz9LXfWsme2uAmROsLBjZJbzz0LfIQJvBK/+4G95y+7mJ1/gweO5k7ouzZb
	 VBxglBMHi3JjbEF6YHKQb+c/il5+8VllWRcSOBS+xDkUYtO6GP+n2qy1ToChPhZ1dVkHm
	 /B6Enl3IAtDv2yV1ELeMcPE47bZZaSdvLSygC0OA+KF6IX0S7a5kXX2xK5BaWw7M8vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Deyve0w4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90FB606A338;
	Mon,  2 Nov 2026 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Deyve0w4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8843A1F00919;
	Mon,  2 Nov 2026 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793612405;
	bh=koy48tw7Roi2TNVALKt7ehN7IwQ8uU25JAdoz9k07yQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Deyve0w4CNejLxWfIoQHdf8eMktTCM4micfV384QCZZEac4juxKdyq3OlzYDzcxhu
	 KguATxwaa2wKvvvqEKvCyAgcxkrtwok1FCKHDAUkZbpl+BxNXS6UZv516oZoPgVwZe
	 erYE+2EdQ0gCIAXrJx9gwPE7h9Vp60NKaOdGj2YvqHTOGRUtsjf1l/fVoB2FnwlXNj
	 LuL15cYh4LUVHZNDF/rONFx2xQ7iFzAh+aSI7gq/O8sqfCVkiclpfUSbD8d00r3pTx
	 yxyDTjW6L84tWvrRGudj/rlsRq+a2LL5C9y2Y517tuPtK7cMx8I5PnBLNTBWeH1/9T
	 etrQDgFvjdjuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D2FC380821F;
	Mon,  2 Nov 2026 09:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bnxt_en: Don't keep MSI-X vectors added before FW
 reserves them
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179361240421.3898193.10936666547810707187.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 09:40:04 +0000
References: <20261028114933.256298-1-vlad.wing@gmail.com>
In-Reply-To: <20261028114933.256298-1-vlad.wing@gmail.com>
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew.gospodarek@broadcom.com, tglx@kernel.org, maz@kernel.org,
 yangjinqian1@huawei.com, apreece@meta.com, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Wed, 28 Oct 2026 04:49:33 -0700 you wrote:
> When dynamic MSI-X is supported, bnxt_check_rings() grows the MSI-X
> vectors with bnxt_change_msix() once FW says the new rings would fit,
> and keeps them.  FW only reserves the extra IRQs later, when
> bnxt_reserve_rings() calls __bnxt_reserve_rings().  The MSI-X table
> entries beyond the function's reserved IRQs are not backed until then:
> the MSI message written when the new vectors are activated is lost, and
> the entries read back as zero.  After FW reserves them they are live but
> still zero, so the NQ rings bound to them signal address 0 and every
> completion on those rings is lost.  The next ring change (for example
> ethtool -G) then times out freeing each of those rings and the TX
> watchdog fires:
> 
> [...]

Here is the summary with links:
  - [net,v2] bnxt_en: Don't keep MSI-X vectors added before FW reserves them
    https://git.kernel.org/netdev/net/c/af449230bd8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


