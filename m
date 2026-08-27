Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73245FFD8
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838667; cv=none; b=r4xbjiU2tFpZwMPG5iJYxy3+mcdnFzMGjEEXos/A1ytbW0nIvOl8j8PxiDin7MEEDxXdhTUPWgXKLaQgrdUCHeg1hwlmqkyosxD9wti3mdmy1uC8eUEMq4l3TWPvrPzv3Go3Jzk5uZe0CzMLlZyMfJDjuxvgsjhSX3vMAVBONKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838667; c=relaxed/simple;
	bh=YHUYXpc7rCZRBrjtptqJY5x3+jRuZcNRuCOOpFutlX0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WxSt/UOdzuewZZJy1R7fWgNdlmXiA01YXEqmv2kVKbMqPQMolTSqQD3ozNjd718zeCd0iFIRKQ7x0xbleT9n/fP/qPtJaZz2/pU3JDYob5qRB3JhhmPuxnJxzIifzcmqD0/qjedyj03086uL0q3p422WuynEnUCST0plbJiN4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCQutuVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCQutuVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1C81F000E9;
	Thu, 27 Aug 2026 13:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787838665;
	bh=jMOlCYrNUgmlpJThtSV12ddBvQzmBE9djVgDRN9et0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fCQutuVaJIXo2Z/QHveYgHBx6z0wGttAcM2saYuO9DE+ggghwhY7xxpFl/k1bxWtx
	 9SqBLJ+dYgFEkmPvMTbQfJ49ygmGemaHaLy5qTMaTmNGGUx/RPkf+szqLiO7wrFwFx
	 b5Td8FrOtFlwGZCFz+rQqWb4+WNH52Q9dDULrZzqAJqj6CKq4OaZnw5ibhXlwDrujC
	 BG+pQ0b+/hAu187NObzmF9sjpDA1kj6FxH7VFMecuBgra6bjd2MASwWSqFCq73wFuw
	 uEoaM57/F9fpLKwoVlsG/AyjX+WNvIPFSx6V+GYOPrdvZ4TzDIrBzkSar+LMjjPU8x
	 9rICtrHyI+uhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A093809A24;
	Thu, 27 Aug 2026 13:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] Guard against gso_segs overflows
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178783861139.1238825.1350409132384391567.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 13:50:11 +0000
References: <20260822120117.1163423-1-alice.kernel@fastmail.im>
In-Reply-To: <20260822120117.1163423-1-alice.kernel@fastmail.im>
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 willemdebruijn.kernel@gmail.com, mst@redhat.com, jasowangio@gmail.com,
 davem@davemloft.net, horms@kernel.org, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, kerneljasonxing@gmail.com, kuniyu@google.com,
 bjorn@kernel.org, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
 alice@isovalent.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 22 Aug 2026 15:01:15 +0300 you wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> This series is a follow-up on the discussion:
> 
> https://lore.kernel.org/netdev/CAD0BsJWzSr2zduf5v3mVC4zd=Lj6ZAoC+V42-VBdg42aDY8XXw@mail.gmail.com/T/#m1e22fca273c36cc8844e516505d3251cc1418fea
> 
> skb_segment is patched to avoid possible overflows in partial GSO. The
> primary possible source of too many GSO segments is also addressed:
> virtio-net clamps gso_size to >=8 in TCP, as suggested by Eric.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] virtio-net: Ensure that TCP packets don't overflow gso_segs
    https://git.kernel.org/netdev/net/c/c27c449d455a
  - [net,v3,2/2] net: Guard for gso_segs overflow in skb_segment
    https://git.kernel.org/netdev/net/c/0b13256ce37b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


