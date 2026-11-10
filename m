Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343209;
	b=Y5hCFk9PJR9A8yae9IFvtfpHVLT/7/madfEoESfsMx+kG+xLkcZ2GIlO0/BDS8lqCMzW
	 psK6xHZ/7dD7duxi0fKHR1C6qis5GBbsl/zwqhh1aDw2wxyhSRi1r/7f2dLzjjO9w7mDW
	 c/3x8jmJ01QhwdUMlP0L7Oe06ZvSWhY2WEFrv6z9flv8PRWvuSjNvhGQOLwuTZu9SiMRp
	 BGHcDlxHwsNS8a45IeqXveD0TKMmpn1g7Lro+WJsHM1K6GiIvMpATp6YA4C+yUTjq4uag
	 mVvdYN56lK3eohuyov2iZbvCMgCDAyZ3OKH1aVmoQET+npoZIzkVLWLbuKIc+OPrXHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343209;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=p0Hlgz4s0YMFcB6+Pv7b6JHR4+HDWjVo6ph7lC4EMU4=;
	b=DvON5aDwvQ0EdZFJa7lwO08oASBDhzAK2PeH0yItbcZgKJcA98c2p6on5jn5TU99Wm0S
	 DnbEJ/LthDCsBPYfnelmTKlnJvGKCeatyv86CG+VUkNTapw5bCfmieAcTyaYyz7UQwnjr
	 YSFI61kqWqvgw0zpN4bhy7imQxsJ+3+aE5JzlkVrWy0ROi1AXVL4+OnSEjm2ELcvtATZ4
	 X4tU1+id+HTzAntUS9fONv8WwQVVmDuKyfQeOSmHCSb67GBl5wMf0A7S+rtPyp5saNpXf
	 jQKLOQG/rpO2Mmpfc536mWZseK3jbRKdyedyFb60HGa+rQRAoF1PxIl9usDDglawnVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6q9U9kr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29512606A327
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6q9U9kr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C341F0089F;
	Tue, 10 Nov 2026 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343208;
	bh=p0Hlgz4s0YMFcB6+Pv7b6JHR4+HDWjVo6ph7lC4EMU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P6q9U9krMExtLMLHSatAYYllcHwrEEH2Lj5nDT06FGYUYbLS65Jhs2RL2luAR0Rpx
	 CUt0ajvO6bsSJ0huWSWnHkl/htzoq9zzF/4qvcCBbxLu2p5wdxC/nCqq6EwxIGr829
	 bnMZQtFpp+cZt/Z4lCaDMWobwcp4f8WSP0mHf6KzwqJjlPtzXooDeLsqsa8tvLvgVM
	 pEe1D8mK5SM5XLH730s8q7L/oUoocklhDOetMXkj5GbL5Uy7g+QBoP67Qjpp5xA5Po
	 VvpH9u/gMM/wVUDTbeTgak1TJtNQ4oylihDzOxYiL3LNpVhRUO8j1V+jcQeLd3LPjp
	 qUFR37sZxVjPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B12F39D6577;
	Tue, 10 Nov 2026 20:40:08 +0000 (UTC)
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
Subject: Re: [net PATCH 0/5] fbnic: Fix FW crash restore,
 stop path and mailbox teardown bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179434320743.48129.3556613330117457794.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 20:40:07 +0000
References: 
 <179381496288.9644.9775319757787890210.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179381496288.9644.9775319757787890210.stgit@ahduyck-xeon-server.home.arpa>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 04 Nov 2026 09:58:59 -0800 you wrote:
> Fixes for races and ordering problems in the paths that take the datapath
> down or rebuild it: the FW crash restore, ndo_stop and PM suspend/resume,
> the Tx force-flush, and the DMA flush on mailbox teardown.
> 
> Patches 1-3 were found by code review or inspection; patch 3 has not been
> seen to trigger. Patches 4 and 5 together appear to resolve a hang with a
> PTP Tx timestamp left in flight. The series was tested on fbnic hardware
> with firmware 26.09.14-017_h7ab84d2ef68f, cycling the interface through
> DPC/AER recoveries for a full day, and under QEMU with the fbnic device
> model and live firmware.
> 
> [...]

Here is the summary with links:
  - [net,1/5] fbnic: Take the instance lock to restore filters after a FW crash
    https://git.kernel.org/netdev/net/c/999431e6153d
  - [net,2/5] fbnic: Fix service task races with ndo_stop and PM suspend
    https://git.kernel.org/netdev/net/c/05ec5504ff69
  - [net,3/5] fbnic: Disable PTP completions during the Tx force-flush
    https://git.kernel.org/netdev/net/c/7d4568edce74
  - [net,4/5] fbnic: Suspend phylink after taking the datapath down in ndo_stop
    https://git.kernel.org/netdev/net/c/b45b9c6b83e7
  - [net,5/5] fbnic: Wait for the outbound flush to complete on mailbox teardown
    https://git.kernel.org/netdev/net/c/c5820a8cf59b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


