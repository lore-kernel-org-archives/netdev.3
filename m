Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1243739280C;
	Tue, 25 Aug 2026 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644265; cv=none; b=F3DZS7i0cnIUm5tWiHAa1yaOcyt0YN53DOFShE9zFu0pW8OA1zB6YGMimR4lP4KkWez0Y92rLRP0PQ+BVUwR8sqJ5++Y40eIbNxmbTSvt5DAZ0wqcH645aMLZVXKDB7BVOuNzpGqIPoOH0w/RjtNBAHUyGrogzLRKbbs9VSoK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644265; c=relaxed/simple;
	bh=k3Y7VZAX+DqxqpPSewDh6gLt9tlZw3s4Zs6buhXnftI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q+hIeYJpAK7pkwlQ4mWEcCKyJSjRclWdk5VaLHoUf89rHFZFKaK2lbEz7ePPEhpd4jNVR0Pn1lrzoVR/Yru5I5CTDy3SK/fmLqhf7wPvtJgFZx0wmexUrObbl1Fhi+7w1a4ZQoCcC/c65BaLT4lORlm9W8GapKWIBQwD9I4yVR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3+3iiSl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3+3iiSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6721F000E9;
	Tue, 25 Aug 2026 07:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787644263;
	bh=MJuUMmf3EDJeYGcofNKIuYrT+lP9mVkuM9Y75QNSlwI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I3+3iiSlqLVoBNncRD1Yr9b0L4XxSIkoR1ap/4COxaBbgLGtXysAYdRTOnsEazh60
	 UfV85z95oGuT2EqPop32YSA3U3G9qlj3npuKILgQ1M/xG0Y49c8cV1tgMAhrx3AZcK
	 +tUvKtZaI9Q9+XHzFy+0cAF25fjZXhfMhyks6i+Ru9AsVNNO2kGS4o4g99sxEjtsMq
	 2BBiGknOTp7s9ZyKy0reh/ThG3p0UjAazJtSTy5MUGaBrnQ1jErKRmnlUFmG/np1/4
	 OQc2oyfJjvVgjkFy1AgDSo6W1xoiJtYOUfR2AdO4r+JeOeKMWcp5dmninC1COzpGcT
	 mWYBQGtJWaAoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1F963924A68;
	Tue, 25 Aug 2026 07:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/3] net: don't strip zerocopy frag markers from a
 forwarded skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178764421064.3303464.13962539676309417319.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 07:50:10 +0000
References: <4B5CCA6E-2C49-4F86-8C4E-E1BE15C16C0A@doyensec.com>
In-Reply-To: <4B5CCA6E-2C49-4F86-8C4E-E1BE15C16C0A@doyensec.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, steffen.klassert@secunet.com,
 h3xrabbit@gmail.com, mst@redhat.com, willemb@google.com,
 linux-kernel@vger.kernel.org, dev@openvswitch.org, payload.jang@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 22 Aug 2026 11:10:09 +0200 you wrote:
> queue_userspace_packet() calls skb_tx_error() on the packet skb in its
> error path, but it only borrows that skb: on the OVS_ACTION_ATTR_USERSPACE
> action path do_execute_actions() ignores output_userspace()'s return value
> and keeps forwarding the same skb through the flow's remaining actions.
> skb_tx_error() completes the zerocopy uarg and clears SKBFL_ALL_ZEROCOPY,
> and with it SKBFL_SHARED_FRAG.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] openvswitch: only skb_tx_error() a packet we are about to drop
    https://git.kernel.org/netdev/net/c/0dbc2398fca3
  - [net,v4,2/3] net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
    https://git.kernel.org/netdev/net/c/8ece90615012
  - [net,v4,3/3] net: skbuff: don't touch shared zerocopy state in skb_tx_error()
    https://git.kernel.org/netdev/net/c/f66bdb1cc0fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


