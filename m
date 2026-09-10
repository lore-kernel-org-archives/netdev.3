Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79694257845;
	Thu, 10 Sep 2026 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005067; cv=none; b=pQmOEi7VcIYPGd7KlLwj9nsO7bgyQcRd+sSVTJsKz6SP4HWS5Afpv4t+mNFxjqMeaHJFIOodQ54dnHF6THIey+4nrn7WdLsS2UcXyQUd9gLkkvlaF9NlCzXkmN/uEQ5Tfo/GedfTlhFnaEsOux+yuwY94X4d5g5qst5o5VMp5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005067; c=relaxed/simple;
	bh=LcijiIQqU6icGbgqpgAKcDWhpoyzfGooKPh6/Be2dpQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZvwYNAouVlGpnUiDZtPgRFK8Ak7XyTl/yzKCiO5lH9Z2QRmZBNAERJ8cQmgTdfNRI8ofe0CDHBlSNQgHpnRoA9gR4udzWJsRt8HipZl7+Rmeg2Vwgl1UuyMzwJh2Xu/WkHwoI+E08IT83zmOYQmo8Cwyr9f6NQ8qj3SsGmt7aEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSqY6tMO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSqY6tMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D161F000FF;
	Thu, 10 Sep 2026 01:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005066;
	bh=O5m7s+46WgS+mOztayFJPrsq1SYgBi//Br3QEwnWZr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FSqY6tMOTwykMsWTp30OCY03lvJBouMd/G/ig/r2BPxLey4g9OnemWEyxUqEv9Zgm
	 ZZbOCbmDqsUuRH6+z8WPhZJkYbrR+fJMx11hhO36vbSUuwPLeNHRd3kCPBTuqAOGQw
	 MrfVj2bMBMwW1+zppaUn10tx4kM5R2C1UVXV7oRliAxd5paQKyvYBDkqPyG6CWvmuH
	 4yslKinZvwjPDwRU263upnU+d3Sv6m3mxv0tdxuAODVpTSG0w3SGSm0g6ipMK59A+j
	 WSf9D4awEULFnYW5VReIrYKUmB8DgUXUtjeAl7J9JN0yT2332oyAI0U2JrL75YFt1F
	 /7G7Ur0YxboQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B3C380CEC7;
	Thu, 10 Sep 2026 01:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ppp_synctty: ensure a writeable skb header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900500414.1147948.3889369400868898311.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:50:04 +0000
References: <20260908072135.877364-1-qingfang.deng@linux.dev>
In-Reply-To: <20260908072135.877364-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jirislaby@kernel.org, kees@kernel.org,
 tparkin@katalix.com, linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Markus.Elfring@web.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Sep 2026 15:21:31 +0800 you wrote:
> ppp_sync_txmunge() checks headroom before prepending the address and
> control bytes, but does not ensure that the skb header is writable.
> A received skb can reach this function through PPP channel bridging
> without passing through ppp_start_xmit(), which calls skb_cow_head().
> 
> For example, a PPPoE frame may share its buffer with a clone queued to
> an AF_PACKET socket. If it is bridged to a synchronous tty channel, the
> address/control bytes can overwrite data still visible to that socket.
> 
> [...]

Here is the summary with links:
  - [net] ppp_synctty: ensure a writeable skb header
    https://git.kernel.org/netdev/net/c/8aaeb56aff2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


