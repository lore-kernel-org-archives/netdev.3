Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393931F9B4
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128880; cv=none; b=my7zA6M5vGb1ZHcJbG21qHR1yf6tpOSujp+mDwq9dS+sBL82pLyFAjPx2W8sZcGmQttGsZ30x+hnt7fTvMjMtDh06gA8ewJtrxYR0LjQM2GM0tPrNFMM9Zqdsas+Nok6rkC+S4bP9Gjv1jMnitwQtIHbVunoUzA0u+nXzlv5CCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128880; c=relaxed/simple;
	bh=TzT4f32ddF7Kjouff7GNwGTM6n4OuLGCetzu2SIMlnw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ib/TfNFA2Ytu18EUc9aLb6SF5aN1bNAS60ThxiDRx0dmQAiBZFa8GjcZI1E2rEPJ/tOEq3znhcrookVbRvBnYwiTQWhh6DyKh/YEBFBsXErlSH2IY7CQ1DoliUIOcoWxU5Ina+/ISm2A4O75/wHsn1aeOrOBrvPA2yxGPcimCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/bWn/qz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/bWn/qz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2071F00893;
	Wed, 23 Sep 2026 02:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128878;
	bh=9BupZzTcP26PwssABD+t1N90ZeejfkcafH4Z49fJbJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G/bWn/qzGk3YRz9hi7qVQOCYXWAxwkn81cJ1ZiwgbFnI50r5cO1AFrSbl1Ihb1gFX
	 2gcpkQMisjGDMnPxgcZG5kT6Yv0GbQiqMZa80/gdwUPXRahNliG/mtgk0aNeTvfFsi
	 DhnXMK92sUKpYuGZ2fsMrv8mouT8gq9507Me9pE0HDmURg5aR5ik5woTs8ti6oU5jW
	 rXPM3EHhT1wqPnhF2bM8C0+Ztg4wZiNWuybQ3WmWuRbx+jT7JMF5sZrYpvDY5nDsXR
	 wF5VKu3cnAYZJx7G+gLbymf+zlyW8zb4AVUlCMoZN3h/oM0Xdpv7/m70kfTYzPV5ZA
	 ZeyFC1szMCL4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B18673924472;
	Wed, 23 Sep 2026 02:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] packet: fix PACKET_TX_RING data corruption on
 skb_orphan
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012880951.173471.3930137245797954148.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 02:00:09 +0000
References: <20260919004748.1463985-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260919004748.1463985-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Sep 2026 20:47:27 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> When transmitting packets via PACKET_TX_RING, tpacket_snd links user
> ring buffer pages as skb frags and releases the slot on skb->destructor
> (tpacket_destruct_skb).
> 
> skb_orphan() invokes the destructor while the skb is still alive.
> This marks the slot as TP_STATUS_AVAILABLE prematurely, allowing
> userspace to overwrite the slot and causing data corruption.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] virtio_net: copy zerocopy frags in start_xmit without NAPI
    https://git.kernel.org/netdev/net/c/07e1a9408b6c
  - [net,v2,2/2] packet: use ubuf_info completion for TX_RING packets
    https://git.kernel.org/netdev/net/c/951840561386

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


