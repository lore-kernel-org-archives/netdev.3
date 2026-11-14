Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617406;
	b=4xrCYLwpEQSiDSO0sauEbVzOSKrlWC5DaAl1xlTnjeEWU8Y3POZVTYetVLoDrnYpv3KH
	 CkUezuyd5ggdwL7HbZdGK2NFubGOI9pxS8xid3TZ2RRzNqjTs1pxd1wjhwb2Z0se56I44
	 bzAp/bDO1R20WMXfxXTweQaDQBzbKCRsAyfM11hHov0pWycjpFlW+d460oQf15umcNMKm
	 MRBvcvsgtCMzohLEkgOqmXEwkxxYU8Enb5jRBwwBcvMPW+AFBsx4RKsssZ7AYbg1Yf6eK
	 XgOyrgy6iY3fJ7tp5Jlfn/JbcKjCJc4dF3dgMmg22PMl9CYKL1ZWKlpL59SWt97TTcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=krgEQzCkQPTxCESL2Fj+P00Ja5AOl6zwVzAKWjLVZdY=;
	b=oD6KxEhCbulR8VhVD+DLvH7QXQKYCauArvr3CI9YbNm3Up0D7e5I/ldjYxGbMF8brWxV
	 MFQ+1bA9A14QK2YKXKQrlkbOZzJCxl8oPmrRBJusbn3HjPfj+p+P1aJR5q5kclk1XKVHF
	 qj3BXqYI5FTM/NQmXed3t12qZSezt/F1WUqNVI+HIWKng1mXILyGTjLdotjzK8vBfrzP6
	 iIJJmpsAb5o+9sanQmSEnESOSVNb0u7cxsVqwVddWAZOvpt44zn1/7L62PdX2h+amYIyl
	 5LkaBO4bixcauJ5D9EwDaoUO2nnG3r8SgyEYf+vqmKBEr73t1t4kccC/bxYqf69F08Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fx+MH0Nv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B028606A336
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fx+MH0Nv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4572F1F000C5;
	Sat, 14 Nov 2026 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794617406;
	bh=krgEQzCkQPTxCESL2Fj+P00Ja5AOl6zwVzAKWjLVZdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Fx+MH0Nv6daqYCHXuCuNMXiXQrYyT/BOrXso4NYQQghlaQsAP3B8GQuuhkjR0MxpQ
	 D8QPqvL4iKAPymJzhHVESDOFdEZdTBSURcjTMsavCGlmlcjW7dKK2Cc3pAtn2+gnVr
	 Xsh/LFRgYlrk6IOGhnPOYOyx3nvzfgI1v2UimUNN3ziW3XJpw4sPN4BZhU8onSDmZ/
	 rdlLgvDaHbsMj+Kh6uRJ9j5PyFuqCBW04O+oOlQKCQZaPMxa/CBDThy+UXxnbb2IUe
	 JTrP2NLiv/RpTHe6cu2H/jUeUemwEkdnE0tGULAHOsxBPt4sVM+brWV+79JcRV/HmH
	 autAh9lmJi/9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4FA380821F;
	Sat, 14 Nov 2026 00:50:06 +0000 (UTC)
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
Subject: Re: [PATCH net v2] tcp: fix NULL pointer dereference when restarting
 a
 Fast Open listener
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179461740503.1921910.16398134935524697394.git-patchwork-notify@kernel.org>
Date: Sat, 14 Nov 2026 00:50:05 +0000
References: <avMkfJrXhCFXn8M_@v4bel>
In-Reply-To: <avMkfJrXhCFXn8M_@v4bel>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 23:04:44 +0900 you wrote:
> When a valid RST is received for a Fast Open child accepted before the
> three-way handshake completes, reqsk_fastopen_remove() adds the
> request_sock to the listener's RST list if the listener is in TCP_LISTEN.
> 
> An application can call shutdown(SHUT_RD) on a listener socket.
> inet_csk_listen_stop() checks rskq_rst_head without holding
> fastopenq.lock. If rskq_rst_head is NULL, it does not acquire the lock
> and therefore does not synchronize with an insertion by
> reqsk_fastopen_remove() after that function has passed the TCP_LISTEN
> check.
> 
> [...]

Here is the summary with links:
  - [net,v2] tcp: fix NULL pointer dereference when restarting a Fast Open listener
    https://git.kernel.org/netdev/net/c/aa40afa831eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


