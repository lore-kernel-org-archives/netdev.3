Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554314AEBD2
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273491; cv=none; b=EnmlG/O0NSnPBUuwX6m6rrZ0CpO0yBYBmowMq91IHNLZbEI5zSdITO2bzKYitZJKjpHEqLofWC25DeHWCA72kVufVJqH99VMAy1BkXeDDA71guer6dPxakhIDZGEDf0LsKyCMnoTfYnKJCkt8x9Fn0nTmB96JI39C09eIikHCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273491; c=relaxed/simple;
	bh=3z0MHkJ6FE1fGJB3uA8Dosw4XdrngZhQLUMJHl8L2mM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=INj4NlXSgolGsJINLv2G5rWJ3KfRCl5b1isj27TnxvWGw7vonlU1045rB6v0lrm9lGcehaHFyks+lUAm5L9rnDnspzS+YYbZlr2JsjE8SJfhWv6Pt0hbph3wFUliaWG38V95yF8tnIErLXL0ooyj9OWJN2/jfInQZPzSaYJHgH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgeXBeLJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgeXBeLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322711F000FF;
	Thu, 24 Sep 2026 18:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790273490;
	bh=+2254aUTYGyTDmDVgzV+NEadqrbRpHzKd8/v6iEL/HQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BgeXBeLJZ9RnqLcxDAvX0CSRkg8M5fXWSyCJLmUnRxqSXk+3iTboqEcuNxJNPECk9
	 OHZoqUgVmLKAhdnfc7YPlQdffXcMrV5H8Y8SkkfYJ51nAI6RePmgwBQYlDp/r8HFCW
	 hUlHSNaBQ3PEw0faiXCfe/XnqX6o0ZFIQq6f3c5evLIUOOTUcSSr/AiQaXJI6HghkA
	 JhxF53KIUnJKAXI+VUX9yH16nSM5XhAyxiEWGG2JDmGh5Ya97A4wKDDiM+U54AxhqA
	 teznsgec3upXt1wG6G4LNiu5S5Q9aIUzTRJB5caipL6lXwVP5XWf8TcduglCZher2W
	 NDNo3viZ1lMdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A033A566DD;
	Thu, 24 Sep 2026 18:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/1] llc: reserve device headroom for allocated
 frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179027341889.1690644.11455303512227323391.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 18:10:18 +0000
References: <cover.1790141817.git.petalzu987@gmail.com>
In-Reply-To: <cover.1790141817.git.petalzu987@gmail.com>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, tim.bird@sony.com,
 opurdila@ixiacom.com, vega@nebusec.ai, petalzu987@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 09:26:04 +0800 you wrote:
> From: Zixuan Chai <petalzu987@gmail.com>
> 
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/llc/llc_sap.c.
> 
> llc_mac_hdr_init() invokes the selected Ethernet device's header_ops
> without verifying that the skb has enough headroom for the device's actual
> link-layer header. LLC2 response paths allocate frames through
> llc_alloc_frame(), which reserves only ETH_HLEN bytes for every
> ARPHRD_ETHER device. On a non-offloaded VLAN device, vlan_dev_hard_header()
> instead pushes a four-byte VLAN header followed by the lower device's
> Ethernet header. After the LLC header consumes its reservation, the
> Ethernet push crosses skb->head and invokes skb_under_panic(). With
> CONFIG_LLC2 enabled, a remote layer-2 peer can send a NULL-DSAP XID or TEST
> command through such a VLAN and make the automatic station response crash
> the kernel.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] llc: reserve device headroom for allocated frames
    https://git.kernel.org/netdev/net/c/72b5b9a28b99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


