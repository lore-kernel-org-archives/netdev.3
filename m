Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793143807;
	b=NFAsibgSpZo6teYG1/rG0U+js0sYR96enpMgwKGDpbbw3/Gpfdg073tikX1Qm761gaHy
	 GUX+lDtMh5ztmRD9BZZeBWiGSsAsOXvmRN2kzfle5XgkbX21lAaYELate4LjwN1fzdkAJ
	 IH21w0zMNo7rtnuqJ9YDScoEJ1m+0xDwAIvZTntAUZ/YJzm401pgJMpFUbWWa9qj+Qwei
	 a1AdvDB7R9D0RKAiQAfedwL4sVm7uo6IkGXwY8a4w7JDVz9epz+7NHhbqpRAlkmxu12z1
	 qac5UnLBqEmHGZ3xMmHWk+2haYusG7R9qV6BwEJNlSEbyDzmvT7x8gm5QMZEHdPbsyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793143807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=V8Czi7uwANxlfo3cwGysMdQ69o9XIhhg4pxPBjRYfls=;
	b=ghUFL8eFi7HR8EhTCg6I973IPvdZYsgy8tWsDO+zeFvb1Kw/7j3nfKc99Ak4jQ3UQu7M
	 6mu7WDhoKarRoR3c+nQ5NjJP5IzvAdfJfsYgNaFoRzseULZaHBJPSIvJe0xxJt5ETEi8N
	 0zSlZDgR2KsaPeJvl1C0XsQ8n8PqjckgqObk7CJgk1RwFxQh8Q+KRK4R7srRQdgFRgKFX
	 u58NDhs3ElDr+0iSjdYSYMXCO3cvE85IAj1N3KfnbLNxeMczeRjLheaT5hARgqRNOq+EY
	 Ap/jr+taJ4yvkkEjx2rYTd5l1VFEz4pocuR41IAhTVWfRBJCzwL91gl2yt312NC1YZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HL4p9CyQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96537606A31A;
	Tue, 27 Oct 2026 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HL4p9CyQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123BC1F01825;
	Tue, 27 Oct 2026 23:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793143806;
	bh=V8Czi7uwANxlfo3cwGysMdQ69o9XIhhg4pxPBjRYfls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HL4p9CyQYZlfbNYhjFph4R3nBesmgoNQCbGOVJfTfetprTSZUgZgTm2X11JfcgPZP
	 RxpAZ22zgrXtPaK1KznmP2rs+1u4KbgvbeRmU1I1STIfS78vt2UFWT2mvNQjAINTlN
	 Eo0BRIN15ct9tPNhbiJXAUVu+zrkYXeTioqnrigH7T7WZ4wYbae8VwE+XFEsUTDoIT
	 Ng5+MSzY2RDGKxzqtiPJKFIXbubEVbutiM+Cvfpq9ZTN3L0yoR+6YyZdyZrSCKfpwW
	 qVF9qYgvAXodKkhsxuatTqCf+o/+OXQiaKR2Uxylw5z0ekEc0y4gPCIuUzRjVk9Xx7
	 4Tbsx7YNZYMDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 073EB3AA9413;
	Tue, 27 Oct 2026 23:30:06 +0000 (UTC)
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
Subject: Re: [PATCH net v5] usbnet: fix EVENT_RX_PAUSED race in
 usbnet_skb_return()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179314380482.391437.16125664674465100963.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 23:30:04 +0000
References: <20261024084538.256596-1-omermetekaya0@gmail.com>
In-Reply-To: <20261024084538.256596-1-omermetekaya0@gmail.com>
To: =?utf-8?q?=C3=96mer_Mete_Kaya_=3Comermetekaya0=40gmail=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Oct 2026 11:42:08 +0300 you wrote:
> On SMP, usbnet_skb_return() can observe EVENT_RX_PAUSED as set on CPU0
> while usbnet_resume_rx() clears the flag and drains rxq_pause on CPU1.
> The skb can then be queued after the drain has completed and remain
> stranded until the next MTU change or device stop.
> 
> Synchronize the EVENT_RX_PAUSED state transition and paused-queue
> dequeue operations with rxq_pause.lock. In usbnet_resume_rx() splice
> the paused queue into a local queue under the lock, then drain the
> local queue lock-free. In usbnet_skb_return() use a double-check
> pattern under rxq_pause.lock on the slow path, keeping the normal
> RX fast path lock-free. Use spin_lock_irqsave() to match the lockdep
> class shared with other sk_buff_head locks taken from hardirq context
> in defer_bh().
> 
> [...]

Here is the summary with links:
  - [net,v5] usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()
    https://git.kernel.org/netdev/net/c/67ae1b80cf73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


