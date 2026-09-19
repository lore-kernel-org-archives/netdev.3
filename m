Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BAF23ABBE;
	Sat, 19 Sep 2026 22:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789858286; cv=none; b=dffYtwjKHQ5GQbdEBTVL3vzzRj2myYe4czGH6/8fCuxuBao2OAjTDzLvNgmlPKQZ07JJ/80oOrIArN1/Rv3hV4jlSuGSmwXTBs+tDpnpSoi8EQ3DrAwQ3Ejo9AgEylqGtlPQguWJ29MRusKBZdfYhqu2EfVWd8pN3SXur+LhS5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789858286; c=relaxed/simple;
	bh=kBRXeyi1c960O0fjGn+dRjGZxaOtzC69lWF1dPLPo0U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nuIS5GmgOoKayXltGh2lK0tq/gXrRR3jD6ChbF9ZUCdf0pB3qytJc74XbuQSF/9o+TTtGcYsDWGtyOuyfpFRCFYi6Wbeb3HWi7QJ9nf6U7OX+lMFIC9OhnA76NapFsMkeRQhoTW2P0PFQT3+jo+xey7kxOoID98ntuu5Cbn4Brc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hatEdKN4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hatEdKN4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7941F000FF;
	Sat, 19 Sep 2026 22:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789858284;
	bh=A18i1OW/ltxUwpqhu4EQwXsBuim28AyuTsWVQH/1Ejc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hatEdKN4mjmRS/xEAhKGTTOTXH38pFPlndVuwXK8Uw/M5rVj0KwThYVH5uiOgkCjr
	 NFPTe+Wo9OvbrZ72oWV4GWv1nA5/uOJ6si0/hkPSIgJEsXcjE1cueHCC7PhMrFwxZL
	 yRVNTWb99RsyNnNqj9p0D7wyZcR1Jbrkg15piNwKDLuY6boissZEadMZ6UEu+92SR5
	 rj9Hs+/DMECRmNNl3k3uhbMs3DLosLeVh/3HdhSMHdeaDNiCUnFwZggAIS4t0cRUbU
	 J1wzqCTA6NLcF/sY2sI/yu/WP289fScDd9gn0UjU6YGuvJXBiUvPS8gF+sBdX1EI6y
	 i/YAIoHOLYPvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56853392447D;
	Sat, 19 Sep 2026 22:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: usb: catc: bound the RX packet length in
 catc_rx_done()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178985821686.1485891.10612665362689761603.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 22:50:16 +0000
References: 
 <AS8P251MB00015FD7716F38C345619B56C8BB2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
In-Reply-To: 
 <AS8P251MB00015FD7716F38C345619B56C8BB2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, peter@korsgaard.com,
 n7l8m4@u.northwestern.edu, enelsonmoore@gmail.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 00:06:58 +0100 you wrote:
> catc_rx_done() walks a multi-packet URB, reading a two-byte length from
> each packet header. Its bound, pkt_len > urb->actual_length, ignores the
> header offset and compares against the whole transfer rather than the
> bytes left from pkt_start, so a crafted packet header makes
> skb_copy_to_linear_data() read past the buffer.
> 
> A length below ETH_HLEN is also accepted, including zero, and
> eth_type_trans() then reads a MAC header from the uninitialised tailroom
> of a shorter skb. The is_f5u011 branch takes its length straight from
> the transfer, so a zero-length URB reaches the same path.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: catc: bound the RX packet length in catc_rx_done()
    https://git.kernel.org/netdev/net/c/9d565b6b72fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


