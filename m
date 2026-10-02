Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72021DF98F;
	Fri,  2 Oct 2026 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934791; cv=none; b=HyU4no6QW3oouUkRSQ1M7WkPD/koos+OUfK2vGXrL3mWYGsiNATj4n9MFCpPZJvHkBtfc7D/I9s0HsMp3oakMcIHRg90KGJW756zaV/Stjcd8PTk+Irr5zD4EV3nVK4oL4iIbi4jL19CxqJ33qYEFB7Kfv6i/xKk4a0x2+EnQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934791; c=relaxed/simple;
	bh=j6ufI30XP0VX3ADFXEvx2M44Ybov1qKKga0vR8vUHbA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Ygq1XuhaLyEydB5sMEuF1xHjgBzbL/O6FSKjqsBowt8/PoifIs9nlwrLMtDd9Io8r8mJs4VOZVtmo/8lwDCmDOoapv8aZdACmCj58SAYGvOUafi9GWWJQlV5uWzPYRDD7qk0zPZC7aXxx73KaE7T3DI5B8sIGxE9DUIW6Lw/fgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=SYsHTNE8; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="SYsHTNE8"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4DD44A4A3E;
	Fri,  2 Oct 2026 11:53:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790934783; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=d8dVxb/4SjaiiBhdK3qGSBfU3WzGwhFu3UnFjFCUSlY=;
	b=SYsHTNE8bBR9uAbWt2qtMnw5Z9IYDzoODh6vRysAfaQO1hhdcwSHVWFtQWE+/Dy2bk4RLv
	JKlPhSSNSLOagQbUGaNJF+VW5ns2xzPciezwItX6Gatw47/4LFLwQ09puS8VkKRc9U/coQ
	4emwAIrLaQxWFcc0njJnZPN/sznlo5wPNpTp3OtzcQjo7mc6MLasuohP9gDy2lj5zSQxwQ
	zamEUMbjlicF4MzDDTud8dHkf4NfhHhEktBrxlsxwjObXUXYh5Cu6uQgHgwH5/bZYxWwv8
	wiRdPfboqztCwTGrnaspDg6eBFio5UI6OwWk/1+Obyeo9DZBAE6m8vj3BI7BGw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 11:53:01 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next] net: macb: move printk() calls out of bp->lock
 critical section
In-Reply-To: <20260930-macb-irq-v1-1-8994a4c8f3bb@bootlin.com>
References: <20260930-macb-irq-v1-1-8994a4c8f3bb@bootlin.com>
Message-ID: <c5df780e33d1b642a138070f5ff0c300@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 30.9.2026 20:35, Théo Lebrun wrote:
> printk() call while bp->lock is acquired might be a bad idea:
> 
>  - It grows the spinlock atomic section.
> 
>  - If netconsole is active on the same interface (and we run on the
>    queue's CPU), we risk a deadlock because macb_poll_controller()
>    calls macb_interrupt() which grab bp->lock if an IRQ is pending.
> 
> Three messages are changed:
> 
>  - In macb_tx_error_task(), defer netdev_err("halt tx timed out") call
>    to after the critical section. Update the message to highlight it
>    occurred in the past. Inherit the buffer exhaustion boolean variable
>    name from the old code comment.
> 
>  - In macb_tx_error_task(), defer the netdev_err("TX buffers exhausted
>    mid-frame") call out of the loop. This also means it goes from
>    1-per-error to 1-per-task-invocation.
> 
>  - In IRQ handling, move HRESP error printing out of
>    macb_interrupt_misc() into macb_interrupt(). Again, it means we
>    dedup error reporting if status is read multiple times in a row with
>    HRESP bit set. This is fine as from past instances I've seen, this
>    message spams our log if it occurs.
> 
> Notice we *ignore* debug printks; if you are debugging MACB maybe don't
> use netconsole...
> 
> The netconsole deadlock is theoretical & never reproduced.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
> This patch used to be part of context swapping V9.
> It got moved out as there aren't any dependency or relationship.
> 
> Technically it is a fix, in practice I'm happy for it to go through
> net-next/main for more testing and it is a theoretical bugfix (as usual
> nowadays). Decided after seeing Jakub taking a similar patch into
> net-next this morning:
> 
>> Since Linus is pushing back on our number of Fixes let's go for
>> net-next with similar fixes until the merge window
> https://lore.kernel.org/netdev/20260929184531.36ac3dc3@kernel.org/
> 
> Changes since context swapping v9:
> - Rebase onto latest net-next/main (47a144672573).
> - Send patch standalone.
> - Simplify the commit message (it was a long and partially wrong
>   rambling before). Also mention that it is a theoretical bugfix.
> - Link to v9: 
> https://patch.msgid.link/20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
