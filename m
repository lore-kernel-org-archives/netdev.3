Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266409;
	b=hDQ28I9eQDm68ORP8GPlpXvG8jew38jsOAEbSpQMHc35R27/INKbyOizsioF5EmpWtER
	 olYTjqWozK1DHzp5qcMsbXn18iDXNqlISACULtJIl96YKeSBQzh6Is68xOsUeS78HvUTk
	 F9zaGSKII6MwgRw7yP0h3Hbdwy3uHz8T98Cgw67khNUO54BXwpQfn2xptGBdgofbuGm86
	 kpU1Tt+jZfPTfq1sST030N9BCD5v+9aoWK6vwRulwPMddhl7f/gVCt8zCm3CB4EuuuZW7
	 W3YRc9SPRx56wA9fxKIK/X9Esx/wVmAavryKmx7uvH0Ug+ektziyl1Zv+xk0mRnhncw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=RYNIz5BtdSZEKWsa7foM6BaeCgtEGgUpqaYcQSWujVM=;
	b=tBn+PLMY8lsRWeWqo3Sj/BZ897dkDx8aXBq4YMrB4JUUki1wihIv6WjnwP67WL50HKZy
	 X6WDxx4eLt59My+y68U2Is/3TT08ciVqWVF7GMSNWa//I47ndYQBZ7fjSdEb8pQKUt6dX
	 Wj99bdTkWA7hmzAy/FKQVcf5PxZjzNmC0lThpjIWamOEHl7iNRvpdYld8gSRwYdm3Avim
	 E8UvsO9oHyhi9hyxgheid+i+D5aJlthC94+yiG91zMJL0TulTaasn10G480cB1WefK6lo
	 paJ0Rpf6M0rdKIwiAiArCXFnXlvsCFcp5enCkSnFt4udEWKGFV4akZmDZu78mzZvK7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aHYWO/6I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0C606A334
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aHYWO/6I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60541F008A2;
	Mon,  9 Nov 2026 23:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794266408;
	bh=RYNIz5BtdSZEKWsa7foM6BaeCgtEGgUpqaYcQSWujVM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aHYWO/6IW6gYdOK3Oh0P76baOmO7j+nVvCHlU5ANpqvxv4BC9GULkhg+6ZQvy0YvY
	 tJ/M2k2hb+5G6gq8Y8wcSoOGVjaAlYU+De7Ahdiqx+qBw0a2aPoWbh68uTR5FpNsO9
	 8iJcGPgvX0ejNWohcl/5RK+xg5Q74DFXbZVBm6d8T+FYii0RcIY1Kq32J6Vs9Y0eZp
	 l3tdLOAGRF+kHdz6OcSHazvKVHj5XLvCUS2pev6j20/MRWhVmM4vgFfevMq4rwnJgd
	 kBT6JANT+G5bW3KkjEzvrjgdDw4l38IzpQa3Xj7XVSztpWM7/OqqWgDiv92G0WwYHg
	 pONoP5SxL22aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B14E391AF99;
	Mon,  9 Nov 2026 23:20:08 +0000 (UTC)
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
Subject: Re: [PATCH net v2 0/2] ipv4: fix fragment length accounting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179426640716.3539542.13397803141946938999.git-patchwork-notify@kernel.org>
Date: Mon, 09 Nov 2026 23:20:07 +0000
References: 
 <36C40B0A9C6336F3+ipv4.6d58afc075934322860394a26ceaa2e8.0@tencent.com>
In-Reply-To: 
 <36C40B0A9C6336F3+ipv4.6d58afc075934322860394a26ceaa2e8.0@tencent.com>
To: =?utf-8?b?dGVuY2VudG9zX3NlY3VyZShUZW5jZW50T1PlronlhajlhazlhbHpgq7nrrEpIDx0?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?b?ZW5jZW50b3Nfc2VjdXJlQHRlbmNlbnQuY29tPg==?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 pabeni@redhat.com, kuba@kernel.org, willemb@google.com,
 willemdebruijn.kernel@gmail.com, klassert@kernel.org,
 steffen.klassert@secunet.com, edumazet@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Nov 2026 15:34:36 +0800 you wrote:
> This series corrects fragment length accounting in __ip_append_data().
> Patch 1 reserves the XFRM bundle header space as headroom. Patch 2
> rejects an append when the transport header and moved tail do not fit;
> it also addresses the independently reachable ICMP Timestamp case.
> 
> Changes since the initial public posting:
> - Patch 1: correct the skb->len/fraggap explanation, clarify IPv6's
>   dst_exthdrlen terminology, and scope the layout comparison to the
>   same skb setup inputs. Add Willem's Reviewed-by.
> - Patch 2: describe the ICMP Timestamp corruption path, distinguish
>   negative copy from unsigned pagedlen wrap, update the subject and
>   Fixes tag, and remove the unrelated XFRM Reported-by.
> - No code changes in either patch.
> 
> [...]

Here is the summary with links:
  - [net,v2,2/2] net/ipv4: reject appends with negative fragment copy
    (no matching commit)
  - [net,v2,1/2] net/ipv4: reserve exthdrlen as headroom instead of counting it in skb->len
    https://git.kernel.org/netdev/net/c/0f47fce51a98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


