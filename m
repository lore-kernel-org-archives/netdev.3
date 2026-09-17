Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF6342539;
	Thu, 17 Sep 2026 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605673; cv=none; b=Lk7cvWNb1MvAw9YSkHVuh8W/o2cm3ai4XzBwbegbwkduV2BTUgYV22mvs/Cype/CQXhc+gJqwOJquOOqWMrBhlVBqYkj3iNbZg8rsDVm492PfeOJUQDlIS3Be8WxUIMYrmMbTn4e52owM1YRATj7wgAJ/tp/iU7fvtYwNZH/qMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605673; c=relaxed/simple;
	bh=WJmCZVmUP01170XWtW+ZChynspRVxYk6HFIttXEjgCA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=noNOpYLCTOgFyCkSLxmDry9+CNIIfS7phkc3346yXaOuDaxnN7SJ7m479fCOF6THg3Mi9NAayT7l5kyL+/2PYkGvaY/K2ktYzaq8IcyETNUNz0zOH46Ftkpi9T3Mt+oG1EHCAJiF/cQD/cZgalOYbnHGM+7SEo5Jaqltzf+e8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWsxF6Ca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWsxF6Ca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8091F000FF;
	Thu, 17 Sep 2026 00:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605672;
	bh=dNXysOxSmVJYQ33J+8ShLVFwRjRGNA+xVHf2PBpgYzc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nWsxF6Cauiu7pvSSr/rl0X9t5vFIeZ8IGqdK1cxdQ5jRd+sobNju1ER8hgazIZCtS
	 jUxgauRdekflQqu9F2QFk3EAAfDhNSgtVUMA9IdAJVlKfdHheIeaU78rv1nqy2i7kg
	 cPUQ72NH5dczWgOgbFpCu4IGGDfxYEW2kRj3uViyMlGeOwRgFbtpp2ZMgTNZfqzDsw
	 MfBnpCGB54bjsv2ZfGhdtFVDS0yKx/lBi6THa9Tgi+aD3XjyfjUz4M4Uofc89ee3gi
	 tCyu3LIlMX3EeIgU5/XegrwHNr2wXBkifq5pWcNXyjEZf4Il0+xoSnhMqvyJVNwM8U
	 NURPSSjkpoA8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567B039E9601;
	Thu, 17 Sep 2026 00:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/packet: avoid truncating TPACKET_V3 private size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178960560613.3354472.16356176819516193928.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 00:40:06 +0000
References: <20260913-b4-send-packet-private-v1-1-925eab2cd388@gmail.com>
In-Reply-To: <20260913-b4-send-packet-private-v1-1-925eab2cd388@gmail.com>
To: Mark Amirkan <markdamirkan@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, loke.chetan@gmail.com, kuba@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Sep 2026 10:31:08 +0000 you wrote:
> From: Mark Amirkan <markdamirkan@gmail.com>
> 
> tpacket_req3.tp_sizeof_priv is an unsigned int, and packet_set_ring()
> validates the full value against the block size.  init_prb_bdqc() then
> stores it in the unsigned short blk_sizeof_priv field.
> 
> Commit 2b6867c2ce76 ("net/packet: fix overflow in check for priv area
> size") fixed the validation arithmetic, but an accepted value above
> USHRT_MAX still narrows when it is stored.
> 
> [...]

Here is the summary with links:
  - [net] net/packet: avoid truncating TPACKET_V3 private size
    https://git.kernel.org/netdev/net/c/37213e611202

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


