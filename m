Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622330C361
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791247210; cv=none; b=AsUOOsxZJhQpiyLUj9oERaRkQiXw9pu6M3raNPJ14riSPCNxTQEtkGVEv1lUAwuKSe7MB0OF+wWQBbDBKYohM/iBNy1/3pBfz48p2Jfp5qO5k+h/5Ja6YXF+fK7DtYZebtZ3TzXlU3HiYizg0REE4okQjS4v8I+ntkulFFLCu8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791247210; c=relaxed/simple;
	bh=pTN4hf4qg7CvY4MRVoihj8qRN+/qN0BbXjlmgFJsd3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ebz6Ba4Xfq4NTV02FAvoxai2Jo1aDwGpyzgxl+o01eUYcj6zSNsCrgY36aTBExcEFlwVpSie+28AJOYujOLLBgKanFs6yOizMXXVN3Uw1Ne+hLeOKSCq2dvc/COp+r3wj3AQZTTvqLx9DW813TzmmXmOvVz/EouS+W0hrd7CX4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxZBpvlX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxZBpvlX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F48F1F00899;
	Tue,  6 Oct 2026 00:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791247208;
	bh=S16cAkwp6cNqdGFLLAL1Paj/sDsefiaZyy0x7oSSqgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bxZBpvlXOSw8ZKeCEPea2YEK83V7N2EwFp1FSjw8JV8yDySisutKz7G0lQ1PAoHzY
	 73S3EHR1+KLR4aGZhQS+3LVGGea96GCWCAU/B0uLl/qJOj98WXHWNxXpjkHVHpLpFq
	 HOuLpTtvQrGa6GeWTda8mWJBGFvo6e+1avt62r0Q+CBozCsN+S00Ua0wJmVtWBZRv7
	 UijoIitVbRs3HCykIz3dL/oQ+NA4PrRrDYeOxI27ZGurt/Mj5QLEdbcPz8UzASMZJe
	 6pXmUCkKSd5jO4WmoH1JEtlSCJzv3+L+4FlttOq4hSeDHM6Mq4zkVD5s9zeoaR7RxL
	 7Qm/1DZ0TKN/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7739D392667F;
	Tue,  6 Oct 2026 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: remove IPX raw 802.3 detection from
 eth_type_trans()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124720702.1957713.16297694043226585416.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 00:40:07 +0000
References: <20261002185509.17226-1-edumazet@kernel.org>
In-Reply-To: <20261002185509.17226-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Oct 2026 20:55:09 +0200 you wrote:
> eth_type_trans() and vlan_set_encap_proto() still carry a "magic hack"
> to spot Novell raw 802.3 frames (IPX directly over 802.3, without
> an 802.2 LLC header) by looking for 0xFFFF in the first two bytes
> of the payload, and report them as ETH_P_802_3.
> 
> IPX was removed in commit 7a2e838d28cf ("staging: ipx: delete it
> from the tree") and there is no in-kernel packet handler for
> ETH_P_802_3 on the Ethernet receive path anymore.
> 
> [...]

Here is the summary with links:
  - [net-next] net: remove IPX raw 802.3 detection from eth_type_trans()
    https://git.kernel.org/netdev/net-next/c/6451576b5396

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


