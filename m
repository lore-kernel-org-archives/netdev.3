Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3B35AC31;
	Thu,  3 Sep 2026 02:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402683; cv=none; b=CtfzqzDQitCs5wD1fu/4uTY70+x2OnkqBAvbS+cemW8meHiJ8lxmBAstdfx2bEB/r53YAFsUmm3ZJOFQCa/XmCh2IO3NfIEKNVeAFgihhpMvUbi3AepWIs1C2RvMx3kFSKuZbZUvvYTzhbBkK37/4ILJNbFd4FrPccjZWkQMaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402683; c=relaxed/simple;
	bh=oufWnAJ0wiKVDZMDfZftXsRDKMTaC954B07K57hvL54=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ghpKJqD+h85ICMbCmAV5BES6+wjPF4QLMCsmrQ5cycvchrUGXNUJeIbcLFvV3QhiTPp/Yb6tNFxtVOJIyPNsPBfRBCVo2g7DEGB3543QUl6blg+g+nfn6CALg5g5zoxeAsLKJgaedJGzB+5cWDM+m2lobZl6wq6lhn1u0l8kh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XERZNUEE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XERZNUEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0541F000E9;
	Thu,  3 Sep 2026 02:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788402669;
	bh=4Qs1ZEt1zrRKHPLsB55+Qbs4EtDUvr93hTR+5vj6rXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XERZNUEEEDG9MX/AlIb9X51wdFvmXRqK9xTfMpT7wE9BQGPt9FNkRazgri8jYUUFQ
	 JVhIxNXX20cBLVkkxNKfSBluYsc0BvwO0ex2+L5tTt798WCSkfm74PtVTNGzYPwbME
	 mzyysWTSxXbiFA334kInIjNIPTtVwOzQlVBNsAkRiL2TI/5+O9LJLo7iwG2EK7zybA
	 8frcP90FKv3YhJRDNrqLO+/sghbwLn9AOoRdrM26H3ZwsNKr7mXyt0JV/g8n+D9JDk
	 yo+1kd+N7f4gen/zrfYr9is65/61CpAY7MkvWpwqleb26kohu0xNo5Y24aoCWESxbm
	 q6SITK2HP4jaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568553927056;
	Thu,  3 Sep 2026 02:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: macb: exclude software FCS from TX byte
 statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178840261090.3050934.7632746277544559687.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 02:30:10 +0000
References: <20260831113128.1678674-1-nb@tipi-net.de>
In-Reply-To: <20260831113128.1678674-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 david.laight.linux@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 13:31:28 +0200 you wrote:
> Frames for which macb_pad_and_fcs() supplies the FCS have four FCS
> bytes appended, and TX completion then accounts the grown skb->len.
> tx_bytes is defined to exclude the FCS, so these frames are reported
> four bytes too large.
> 
> Track only the number of FCS bytes appended in software, 0 or
> ETH_FCS_LEN, and subtract that from skb->len at completion. skb->len
> already reflects the padded length by then, so there is nothing else
> to store. macb_pad_and_fcs() already returns 0 on every non-error
> path. Return the FCS length from there instead, rather than
> recomputing the same check in the caller. BQL stays on the padded
> skb->len that netdev_tx_sent_queue() saw.
> 
> [...]

Here is the summary with links:
  - [net] net: macb: exclude software FCS from TX byte statistics
    https://git.kernel.org/netdev/net/c/d85f521a9afb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


