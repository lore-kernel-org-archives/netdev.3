Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D8B4FC8F7
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898808; cv=none; b=kSAlwy5OS1Wsq/QeSly52P9XDzNKn1m5COvYHb1nwtRGuw08DEfX6QsFHBWNPBQO9ogkVrdowqHhQ24e7XgB5PO00jzl939TK1kNkXXQNFQxbhfJ935gySIy8J7YXmne5Z8slL37vMyXKOrO4vnRUPWD2DPzXTD1r9zJCenIPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898808; c=relaxed/simple;
	bh=f4cQw0l+ySXHVRDxG1wqzrpGoMRNHxEINYfwfjnMXrc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OB2wvQxGvEIgbVKON0Csk0mTXcwyAuwUpDsfWbPvqe7OusHFgoGGlnKxpf/zyh7HVnDZczNW9FwwZzCGceddJL17xssbKCkqp7lHexz+JFfJVXigAsLzRkV2pAuBR2FWonaGTgOnRqmvttomQ9bMlBPPpmUc6Vu6NvW2LMCWaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adlpAdQK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adlpAdQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091731F00893;
	Tue, 13 Oct 2026 13:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791898807;
	bh=G/xivSEwTQfyoDl/deKvmHZaSjZWOZYh7L1d+tvbPZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=adlpAdQKxQEQNmbgkjsbFUwnmvMhPdsMu7zsdU3FY398wA+UqEHIZVhHt3CtmbmOi
	 RwPpbQH47tSTgNe5Ar+DYcAmT8eWviWlj62+3yPm+CuDXu5tbwp0Qk+pOpvek3PnuA
	 hYXD07vWP8IITju2u4q179Ogla61dew34tP1c3KsOiVXYv23r1eSuPX+jjFegyAkQ5
	 FJrvqaDNPYa2MQ+aV0v5I/0fOXQtwLt++yNDxUpOPaEWHiA4uIoSyZmWkyBSdoHqQN
	 23JRwCiacKp6d+9mgD1ZUuxIPx5ihnVXN8IgdN+Z+RKzEVl+UEYM+GLHWm4W45DwTu
	 lxcMdK5PzqIAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F196739D237A;
	Tue, 13 Oct 2026 13:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/6] net: re-segment oversized TCP GSO skbs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179189880587.311420.10716275190356671758.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 13:40:05 +0000
References: <20261008100651.2534957-1-wang.zhan@smartx.com>
In-Reply-To: <20261008100651.2534957-1-wang.zhan@smartx.com>
To: Wang Zhan <wang.zhan@smartx.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com,
 willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, andrew+netdev@lunn.ch,
 aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 dev@openvswitch.org, daniel@iogearbox.net, ncardwell@google.com,
 kuniyu@google.com, alice@isovalent.com, david.laight.linux@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  8 Oct 2026 18:06:45 +0800 you wrote:
> BIG TCP is negotiated per netdevice, so BIG TCP and non-BIG TCP ports can
> coexist in one path.  When an skb exceeds the GSO limits of the port it is
> sent to, it loses its GSO feature mask and is segmented into individual MSS
> sized packets, which that port then sends without TSO.
> 
> This series cuts such a TCP GSO skb into GSO skbs which fit the device
> limits instead, so the rest of the path keeps using TSO.  On a
> veth -> bridge -> TAP -> guest virtio-net path, with BIG TCP enabled on the
> veth endpoints and left off in the guest, a single iperf3 TCP flow, six
> alternating runs per state (-t 15 -O 5, fixed CPU affinity and port tuple):
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/6] net: core: use the packet's L3 protocol for the GSO size limit
    https://git.kernel.org/netdev/net-next/c/cc9dcb0e7a42
  - [net-next,v5,2/6] net: core: factor out the GSO device limit check
    https://git.kernel.org/netdev/net-next/c/0bba48256b0a
  - [net-next,v5,3/6] net: gso: support re-segmentation of TCP GSO skbs
    https://git.kernel.org/netdev/net-next/c/c4076626ba52
  - [net-next,v5,4/6] net: gso: clear the GSO state of the last output segment
    https://git.kernel.org/netdev/net-next/c/335a0378a755
  - [net-next,v5,5/6] net: core: re-segment oversized TCP GSO skbs
    https://git.kernel.org/netdev/net-next/c/32bfd220cd6f
  - [net-next,v5,6/6] net: net_test: add tests for TCP re-segmentation
    https://git.kernel.org/netdev/net-next/c/a374c5bb41d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


