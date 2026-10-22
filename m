Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792629024;
	b=hiNCsLT5TYzdAKGlzhGAEHgP84efU6IKgL4+yxeyPuZXWVg3jCpWvn0A1VbCRcc161ja
	 ktzvVk2fu4ktEtJjwDhY9JdsRSwN/9OyvVNcUzHSNUokjcHyG4wvLM+yl7FUPXmeB4kde
	 na8CimsyhgL405baBleAkbw5NLdkKI0D0VwgDYdTyCjk8tTJV5pQQuqwJdwLYPlW7yE5z
	 qK1odOhYInWqfuPFW6vUkpMHe8KBx3w/oBwYOXx+CDf6vEbbTT2FC28GuNAbIT8GHImVS
	 SHsoLWh4mjHiMvaZvUPLNbjMXPCU9GqSqvpsqsPuA5IYoMqYhdhFfyFqGZ9wcbQxXpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792629024;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=em8Yw734Aiee0fgKvAc61E0pqQSrkUSzNQGy5AB+nfQ=;
	b=qGLJ7HhYY9FGxtACNPQRVOsiFWoe9DD+d3+ysvRjE79eZkU4p+I3zeBJcc7AbYsFJpbu
	 BZE8dLbT29wg6Z9OOUUSqdftqZqsw8SLM035ZHpe3/7y2+zDBF1L3UOPcQJzpIFhBWU5h
	 k502tkcYG2fqi9q70hJaazX6QtSB6d1suIqVd2hKCPcxk3FRqfERQC+stJnQy5u3Af7BT
	 x5lmkjSL0o15BU4PFu7VEW5IvqLOKrdytKl3jMbQBjCICHpgt16NtoETbBnm8TqZVVPnu
	 CH8Jxnu6UOYC4ues+0EDDT3yrRjuBzeMovSnaBCll4NEkK4FVpZc1+M+lzwAPNGePVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYcJ1ZpF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628A9606A326
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYcJ1ZpF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B8B1F000C5;
	Thu, 22 Oct 2026 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792629024;
	bh=em8Yw734Aiee0fgKvAc61E0pqQSrkUSzNQGy5AB+nfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XYcJ1ZpFIKflKFDHxFJYgFXTZb/gSpe1c/YAwBK1TqO7FzRGZOl6zIP+Czh1DpHQh
	 N+6f6jt2s7XR9/nRY6SbbrQ6H/DptdXFMe6DpEBpzxGE7b3IcQXsBD1JsAd8XlKX+V
	 36ZY2CVZWPjl93bVHA57D4paMyFohzodn9xdXA75bdXHSwSsk8921svw/qwEj0of6h
	 WFL7c3RtnzROkKx2sm9WdTI9YXgGjaXH48QGr1vDd4w6dCg646QFyV4zlfjYToS1AV
	 EZwVEE7AoSEXAfn/yFL/uB1PNPl3CedgR4ABYrI12vqWsKvsBSwXG2iBSf6j+rTe7i
	 FXLw8fp2FPArw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13F4380A963;
	Thu, 22 Oct 2026 00:30:23 +0000 (UTC)
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
Subject: Re: [PATCH net v2 0/2] ionic: fix port_info lifetime bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179262902262.1378903.17959804366477138316.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 00:30:22 +0000
References: <20261015-ionic-port-info-lifetime-v2-0-57232013fd79@amd.com>
In-Reply-To: <20261015-ionic-port-info-lifetime-v2-0-57232013fd79@amd.com>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 nikhil.rao@amd.com, vadim.fedorenko@linux.dev, edumazet@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Oct 2026 16:03:29 -0700 you wrote:
> Two fixes for the lifetime of the ionic port_info DMA buffer.
> 
> Patch 1 fixes a use-after-free. ionic_port_init() allocates port_info
> only when the pointer is NULL, but its error path frees the buffer
> unconditionally. On the firmware recovery paths,
> ionic_lif_handle_fw_up() and ionic_reset_done(), the buffer belongs to
> an earlier successful init, so a failed PORT_INIT frees it under any
> ethtool op that is already reading it. The error path now frees only
> what the same call allocated.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] ionic: fix port_info use-after-free on firmware recovery
    https://git.kernel.org/netdev/net-next/c/d90d1a768b3b
  - [net,v2,2/2] ionic: free port_info when probe fails after the port is set up
    https://git.kernel.org/netdev/net-next/c/4e15e0a941ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


