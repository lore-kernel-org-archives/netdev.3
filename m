Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEADD3A2E00
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327607; cv=none; b=WTv3Ec2gZlbsm/Rddpzoby2k5W3zJbhuhFnmLb6ZYogsSwzUtZtInBxRCLowl+4ukcRJfU3S+VwempaWtpzq7W1nxn1Fy7vVXz0974yqYNsmMg0qoh9DDxdpN0Vqk18qhcdW0cVbbRlggq6tk6Rt8wxf2FB0jighznXKcQUuCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327607; c=relaxed/simple;
	bh=cAINPWjwophffOWAxmT/0tGFjmIP6i3jaFdKdHD6yEE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bCwyUBtaePYvx3PZhsxCkU4WNMTh/OkB41oXBOunnMOenO+UcMOTIuYnPpHdnCWCGXUlZ33X56k6Cx765CZ8HESDQxDXpduirjhQgNKwAewvQpqxlkepXpjH9MOQ/3jayO+5EtuhTKGEE8dFcEZbokzbzeo29ndsUDesBZ9HlGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+7K8sc8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+7K8sc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8505B1F0089B;
	Tue,  6 Oct 2026 23:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327607;
	bh=b5gpCBaf7tXp6NLAqivjemM7h4S8SEIMJIH50Afs/zA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P+7K8sc8lEkRbHOorgMZ0giBMA+E9ld5JhHUFfCTTtc99VxqVuTAABXWNxNH3UvLT
	 kzTV7LgAOn9LqkXiYDsYqhQdTSI/1sxRNXU6n/eO8tJp0WPJ+yxP6XHsXJIDqSZrXt
	 IgAIeWQvE509nU2ENqV2TtMH9aGlpl/YQzGP09nGq9zOZUDphMmm7DIwLbDOBfyDSB
	 aGhy6RDfAncrRjpbuhISTZAyqXXnKwq8ElE9HGR/Os6EFU8r0U918aAK+KR05C/6TE
	 oxltv0uyvKB+RXojMCa26Jd6DwD58KFuE39iahWc++pCYiftxph1mRIT5+B0YmQ/dD
	 RgHx/ED0Bb9Cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773C339E4DAC;
	Tue,  6 Oct 2026 23:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net 0/3] net: always dissect GSO packets in
 __virtio_net_hdr_to_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179132760628.2818285.2747071461014557312.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 23:00:06 +0000
References: <20261001191140.2818991-1-edumazet@kernel.org>
In-Reply-To: <20261001191140.2818991-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, mst@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 edumazet@google.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Oct 2026 19:11:37 +0000 you wrote:
> This series fixes a bypass of untrusted GSO flow dissection in
> __virtio_net_hdr_to_skb() when VIRTIO_NET_HDR_F_NEEDS_CSUM is not set,
> and adds a kselftest covering VLAN-tagged GSO packets without NEEDS_CSUM:
> 
> - Patch 1 fixes __skb_flow_dissect(), which computes key_control->thoff
>   with min_t(u16, ...). This truncates skb->len and returns a bogus small
>   transport offset when skb->len modulo 65536 is smaller than the
>   transport offset. Offsets that do not fit in the u16 thoff now fail the
>   dissection instead of being silently truncated.
> 
> [...]

Here is the summary with links:
  - [v3,net,1/3] flow_dissector: avoid u16 truncation of skb->len when computing thoff
    https://git.kernel.org/netdev/net/c/99bda1ecbd56
  - [v3,net,2/3] net: always dissect GSO packets in __virtio_net_hdr_to_skb()
    https://git.kernel.org/netdev/net/c/44378d02c5aa
  - [v3,net,3/3] selftests: net: tun: add test for VLAN-tagged GSO without NEEDS_CSUM
    https://git.kernel.org/netdev/net/c/ee2d4c2d7cc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


