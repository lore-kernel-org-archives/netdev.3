Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706006;
	b=KLttXWi6i/rIE3lAur7MBLQ6JG1DrUgvXrM56Jb5kGFS5aZq49tekfn4ZUKjC/7D4zZN
	 1JjyvzRX9+QT1GgfHDjuAxEyXnvUQ8nsBy0l5ZTbDdpEuGEgqoH32V03gitqvdQRnpghr
	 8HSRm1pksIVG88IorN8/yAzgj8ZYyeQ3OYpGk8dE8PAV9VV9gKhLjckffH8D6dqrPCSNc
	 B3blTv9BfNsdx/wcE8TfOl7uVtFW6Pr3jd9oNrJirmIK7bfWZULba2vS7tUMqq7ThrEQl
	 MrV8wt1T1DJitfBKE4UKnPXw/TSt+kH0+gT2vwOightZ6SjjyvZgFUFKIb1dG+TrL8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=12/jhcEx6vED9AmFZRyKz8cy7wUlxnleRPH/iIHyTao=;
	b=m4ZsRnfD+Tibz0nuws4ecR+8vPjE08JM+V8joQK+7RmspuNvNEzUy+CAusxSHop82jX9
	 TJNE3eEl3aeJxdFuBcL3V72VAY2+QWGejSq6Jb9vUeLiJocuiy0sYZALDQaVTKTpB/mqQ
	 FTO1nNDLg7olHCJRf8Eu53TGXDWp1iQY6gD0O+LqYvMXfRlGKt4ZPRG3l5vPnJXqXHtVU
	 ErIAkeuBkO4XFN1IBnJ50ZGzUPOW0+oqRqf5wqyiVvYY/5jIyrbDlq5xdM4rAr3p37n/0
	 E/dmcISCU2acweXcgzu8sa9+IEXYMH04uTI9dwvvGXzNKt1Dj9sOI42OuhvQWu7CzRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOvYdDQ+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7C9606D82C
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOvYdDQ+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8811F000C1;
	Tue,  3 Nov 2026 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793706005;
	bh=12/jhcEx6vED9AmFZRyKz8cy7wUlxnleRPH/iIHyTao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UOvYdDQ+xSQoCmjqBq7LrmWPCaxQeQS0VfPDnfbh9mGQabx8lllq5F8qhTWuTzOnj
	 eT7P4SrSeVCzlW/XOaYqCTd3vVHcMzMuMc6ZtCtw/HEr7mkdlFKi0uaschHkN9A2ez
	 wmmYox3UWhje9DzwHXAyLQHG4AVOBlR9BkOEUT9gHBhvRCxPXS5XaQOLGn7E2fTMd0
	 19JTnCnj7vd45a4NY1RbSTY306SiYT7WJmYcGXlGGDOvIEl4zzBSi8a3IiC6KzyfB6
	 bB1DJJf1xZmvfHRVHVctMTywuHimTu9n8f/oTUBi14KJzUPkMifNMG9bbdU4YRaIYE
	 cF/RLo55sAKbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401B13805CDA;
	Tue,  3 Nov 2026 11:40:05 +0000 (UTC)
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
Subject: Re: [PATCH net] xfrm: iptfs: fix skb leak on error in
 __input_process_payload()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179370600414.1068298.8102080811315201623.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 11:40:04 +0000
References: <20261030083358.2653599-1-edumazet@kernel.org>
In-Reply-To: <20261030083358.2653599-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org,
 syzbot+a3f21220cbbb6e14ee2e@syzkaller.appspotmail.com,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Oct 2026 09:33:58 +0100 you wrote:
> syzbot reported a memory leak of the received skb (and its sec_path
> extension) in the IP-TFS receive path.
> 
> __input_process_payload() parses the inner packets of an IP-TFS payload
> and queues them on @sublist, which is only sent after the parsing loop.
> Three error paths inside the loop (skb_copy_seq_read() failure, invalid
> inner IPv4 header length, unknown IP version) jump to the "done" label,
> which is placed after the code sending @sublist.
> 
> [...]

Here is the summary with links:
  - [net] xfrm: iptfs: fix skb leak on error in __input_process_payload()
    https://git.kernel.org/netdev/net/c/64e45ed926cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


