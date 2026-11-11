Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438606;
	b=eMQf1tWzj7VgmNByr3PLNmev2KJWWmPJ6yzkF6ciJRyO4UXDbYY7w/QzriXBKIRyjvkT
	 dIH1YULWrozI6UZUSmVVZQ+ZDR5YoBCLonVwIRiL4m8YuG//PytiZkb3liS09vLnK+a+/
	 JjOmYYPKo1fDEdKhEzyNgMlSAESa5RVUc3IQPOr0qZqzjVkLE5jtWZbgPi9X9761ByO7M
	 vo3RntAn0QtThhAAVYziHkGqHvHGRCakjyHmNrh/6/Vma97CspZ9670PldBeJFFs8tSRD
	 a1YCv+bXwTNqarot8Tx23d7LI13Tj97NcefhxpNBRe7VbbhGrffPR0vatWu2fgatpHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=cR7TBRaoww7ekmEnRQGM5ZwwQgQZv4Vfue5Aspm+7Sw=;
	b=qg6oWB6vpyObbx5CgW0A3Odyd7Q2NE+Q/hQV29Oz5YFBBWe385zJ6/NW6YRUckdvQA2o
	 1Jpmyts0gNCaSkPl3HGmSb5SAV5VGSlaYcAUqbb+4SXjKjyMcGhQjtF26BVAHY5/TYDHP
	 wqC/EmMxrVav65yW37m404yt77CTNAaPi9qw1C84V9i61fJ1EKO/Qk+F5o84SzdCwDg2O
	 hp1X+czIw4vdENDqnJleegg0YNM5relg+zm7kar4C8TWKbXfwUgfCSIXKBZDWk8YBBYoM
	 4LRzoviDIbRtn5TmOzbMsdROmOj3eqighpMRqe06jicxnam6LiKimcwA//1NY8VId8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIkvcR3J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6066606A32A
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIkvcR3J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B8E1F00A05;
	Wed, 11 Nov 2026 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794438606;
	bh=cR7TBRaoww7ekmEnRQGM5ZwwQgQZv4Vfue5Aspm+7Sw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hIkvcR3J9xSyUSumpOeeYd08gDXkiw6zHaj9v/UyscYHW9NpDPVJMXIcW8uC9HUh+
	 UjmX94orOW5qamIQXtO9l7qeU924w8F5gVHGWUqiDsLQ14n0OA8uqCa4JhEmNJka46
	 gwq+ZN4VD2ionvkDM0ccF4bKYi+UnIo7QeXJx2OwmyDxJdaeTJFVTEyvA3YXmGeFdO
	 IjjM+c6YzsVaWc2jfhk2Xyfep0ZXeOTsbTy7ax5hY+89NkuGpkqZgGuB+5YJ9sWQJ9
	 wmhQ3MmFMUFfNozOKlo12N/odkKzNXuOYWPASVJB90fpq8uxm1cfeZbu7hfXuFtyY/
	 4GPc8vUxlntPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E0DC391AFC6;
	Wed, 11 Nov 2026 23:10:06 +0000 (UTC)
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
Subject: Re: [PATCH net] net: ena: avoid RX copybreak for multi-descriptor
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179443860518.1696522.1305639558376761681.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 23:10:05 +0000
References: <20261109141343.920187-2-thnkslprpt@gmail.com>
In-Reply-To: <20261109141343.920187-2-thnkslprpt@gmail.com>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: akiyano@amazon.com, darinzon@amazon.com, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 16:13:44 +0200 you wrote:
> ena_rx_skb() selects the copybreak path based on the first RX
> descriptor's length without checking the number of descriptors. When
> a packet spans multiple descriptors, this copies only the first
> buffer into the skb and fails to recycle the remaining request IDs,
> while RX cleanup advances by the full descriptor count.
> 
> Restrict copybreak to single-descriptor packets and apply the same
> restriction to the rx_copybreak_pkt statistic. Multi-descriptor
> packets then use the existing fragment-processing path.
> 
> [...]

Here is the summary with links:
  - [net] net: ena: avoid RX copybreak for multi-descriptor packets
    https://git.kernel.org/netdev/net/c/f3c790c34d22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


