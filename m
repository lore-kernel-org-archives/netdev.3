Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314B32AAC6;
	Fri, 19 Jun 2026 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781832027; cv=none; b=qF33FpVrIdsIL8CJcP/OF9oHa8kMbkhO7v7d/Ps9dyWOlP8+KjVi/6B3XwBydTJh8ee5T+bquC8++aQyS66ZKQ+8b9E/Oaa9477teoMxrJxFct5TujwI6Dh9nrkl9do6KMb/tBRu9F6n3snfRmApDChiXnLJz3TSTqDyBPrlM/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781832027; c=relaxed/simple;
	bh=pxk/ejRJaUqK/WniFKkChVydpH28TzRykS2XFNcqwk4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IsoIk6f+Mu26y5oLVtRFgE3ak4nJfIRLQLw8pPnrpeXprv7YzJUI43sVSBOWV1DRcrAWX4ypu9IhPJMO+I5PEzpsZFFx0sPn8P9zTRcywhVU6+ch+lGBFv7sVRaKzwraqpOeWJDt2LCogS7LJCWaaYgaq9wUnv3XA2jcGZ1f6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrdMcgy5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrdMcgy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BB61F00A3D;
	Fri, 19 Jun 2026 01:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781832026;
	bh=dcTKW2obwENoSx8mr/V3chsp12j6X68nqPKkSJ0Tk6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DrdMcgy5zmZ8Xvn7ToOyQ2KhEw+TzFItm75VcXorEfi1hp6pthwsBJXAV3KVvVMI2
	 hCdbnZHstMYoNjisVp6K3hbkVk814sIhZRtvrpozgnkRUyXfGlRBuvtj/k5C/KHSgb
	 ifuD5Se7ocJ2W1mf65/l0H0/XHfKgIX3HZaCMfQ4bq6FVXk+gzHsSbhIFLVW7iPmEk
	 KZE/o6pm2lJhfqsT70e/b9rCLjdg7IsIToXwL8vf1ZpekPzWX5v4QlRxIEM1gMQGYy
	 HGWzCssltvpHckfU1tPdLtOHif81/aAWtwb1DwfU/DPuxCZ/8TXfBTAufOIfqMZ3sY
	 A3zWXt1/XQm6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09AF3A78A7C;
	Fri, 19 Jun 2026 01:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re:
 [PATCH net] net: thunderbolt: Fix frags[] overflow by bounding frame_count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183201938.3150917.7966403014981352981.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:20:19 +0000
References: <178163152194.2486768.14724194232649760778@maoyixie.com>
In-Reply-To: <178163152194.2486768.14724194232649760778@maoyixie.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 01:38:41 +0800 you wrote:
> tbnet_poll() assembles a multi-frame ThunderboltIP packet into one skb. The
> first frame goes into the skb linear area and every further frame is added as
> a page fragment.
> 
> 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> 			page, hdr_size, frame_size,
> 			TBNET_RX_PAGE_SIZE - hdr_size);
> 
> [...]

Here is the summary with links:
  - [net] net: thunderbolt: Fix frags[] overflow by bounding frame_count
    https://git.kernel.org/netdev/net/c/55d9895f8997

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


