Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792545083;
	b=ZAv7QUVn5NUyINH9wCKj4dYCqJDND6veOqnu2h7VH30U56ha+scQSF5tF5VMMzDqBWg2
	 NjA8BqL7MB6GR7T43fHY09EQCMaqNQn8T3+B1B+JsEg0jp4zcHiUNbdGIXo/Rocb0yo8m
	 IQDxKpTCn4aj2wiVvbW+aX/tRAeTPgIVpJqVq5LbrKsowWiJFM7zQ7ibSbJrbKbYiYFoz
	 fWZ94NxAgt6jMB5Z/F6elqxdGq6SwBEqhj8hLmvSlGUUnmj6Qa3m86VvOcvX82MVdwHVc
	 3uG4uBOvEjReo7y2qhOrTgKNBVgJK0BF66Y/v6GPxdVh/3rGZ2LX50G2CISAv/VllPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545083;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=En/FtpZXlY/dvjdQX+68Ke8pNZRCV4qTfxUJ+5HJUPc=;
	b=RCwx+PFPM44AAVIIiuSAkml/QsfXosMFBvFsqrsc/t1V+pvQ1qT6hLbrND2WIXBD32+q
	 Vkuy+PVz2LZy4bIdPZ3JqiX1TyVOgXHXcqsvhd9/7lQVc7aAvXoUlz9E875I4T+TMoelV
	 n7xqPm8EExZ9yEl2aqYwjaizNX19RlkqMNWKJvE5P/fvHvz7hsyR5wg05FSGTaqTyDy1O
	 MiGCUYT089nGNJHkVXmUgOwN6dDeu49r45PG9QMJ9FBriTg5I6PoYAl1FzDSwEQJZjON8
	 j+rMKag9T0/1qFJvYfiQ//Hi28dorp04dy/XtfbFJihiAs3BjkqKZcO8pDsDAQVIdQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hpHJg7gG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC01606A319;
	Wed, 21 Oct 2026 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hpHJg7gG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8371F000C9;
	Wed, 21 Oct 2026 01:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792545083;
	bh=En/FtpZXlY/dvjdQX+68Ke8pNZRCV4qTfxUJ+5HJUPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hpHJg7gGT6ATRYixOYuqIzn5AFfKE/hFFf95McBshMsONyU4MM+AjV0+PWsNPf9hL
	 KG3bLo8lbn1yNRPGs8awBoaHHTt9GOkmznHIdHDOurmucTWq4NzZzEkcwwVJUpwKd0
	 2oZ2/lCfVnwDXYR6UACnA7hW1zfRSSfP6k7XnC+FBaaEEObj+GzKWSSrBsCUOAHVRA
	 NBFWhgDW1lla1jNGICydbHeE/Ye/nMs7/vbT8isoqKWnIdFMyqUOu+28/qkb8fanls
	 L1EkRbeW9DR2iYAQfvVdf1rxeZ/KQPFNblcYqAVzRCcT4n4+A7OqEnaucl1QLG2Puh
	 1hY1GdJOd0QzQ==
Date: Tue, 20 Oct 2026 18:11:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: Denis Kirjanov <kirjanov@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 deeb.rand@confident.ru, lvc-project@linuxtesting.org, shda@confident.ru
Subject: Re: [PATCH net] net: sundance: fix sign extension of the octet
 counters
Message-ID: <20261020181122.53fd0c79@kernel.org>
In-Reply-To: <20261020234434.318-1-rand.sec96@gmail.com>
References: <20261020234434.318-1-rand.sec96@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 02:44:34 +0300 Rand Deeb wrote:
> get_stats() adds the upper halves of the 32-bit TxOctets and RxOctets
> hardware counters to the byte statistics with
> 
> 	dev->stats.tx_bytes += ioread16(ioaddr + TxOctetsHigh) << 16;
> 
> On architectures that use the ioread16() from asm-generic/io.h, which
> returns u16, the value is promoted to int before the shift. When the
> high word is 0x8000 or more, the result does not fit in a positive int
> and ends up negative, and adding it to the unsigned long counter
> sign-extends it. On 64-bit kernels tx_bytes and rx_bytes then end up
> 2^32 lower than they should be. x86 and m68k are not affected, because
> their ioread16() comes from asm-generic/iomap.h and returns unsigned int.
> 
> Cast the high word to u32 before shifting, so the result is the same on
> all architectures.

We don't take LLM slop fixes for ancient hw
-- 
pw-bot: reject
