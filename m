Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577305;
	b=f1YoHeGSnFUVg1aKa1ksbvew77xACz+2kZ5pWQqymXb6hwoBdw+X612iQohRXJ4ZbHKf
	 efsyBLfn4cmAXV4+JkuSIauBIdQGQnGEp5f2yN8Xag+ikLgINBNxoSZbPw8cU4j/Vkg5+
	 H38LOD9g50QyvLtcoeCJHe2mPF26OW9BEkPchATUPq0+Qgluxk4MChZZxApBXABxGD2qF
	 JRUCSNNn3sOYIsZn9rp41bphHY0AoaPLPJ4inUGo2XN7DvVnzN2En7FFgw8mKRHY36Ppb
	 RpIW09yuSjHv0jF8m/+QRsbR/tHt4K3mqwZIZzzvSSTtKZIeVjTGLDZODpMGQ7o8LRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577305;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 X-Debian-User;
	bh=2/YHWXloHM6NRG40BpIM23KsyPGTOxBBteru1wPX7WI=;
	b=snpBPKImDY5CsqIzAzepTUCHWdfANm6OFwpDvfJSLsJtWu3nOnqL4jkXBvY3brUo7w2h
	 w2nYXXhMX1PzJ71nJr2Cwssq539gOARWctg5yeEP/i4lx9nfjRdjU5n9h0Il7dZ1NuoHl
	 MsZr4BaBXMzmdaCktjQHwC4OZHJOr1991Eesm01eesYsyFBGVwlRGD8c/uY2+Ze1z1hqz
	 2v+zAgoa5zo6g2xF3WTbuv7WDsx4mJ7AXBiDfYWJNw4yLj2yesKPrCgJ/kNHdP5TiCwrX
	 Uw3YMeQNf0lrsnWTynB83k14KVnACv2j4fH3H/cGV6VI1IAn+KSWxp7/zRNoXJ6x0og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=gkTm0r4m;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F185606A323;
	Fri, 13 Nov 2026 13:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F185606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=gkTm0r4m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=2/YHWXloHM6NRG40BpIM23KsyPGTOxBBteru1wPX7WI=; b=gkTm0r4m04jVkuRPR2BXolPhBG
	HPCULuqlhawqnijke2K7d96Dd4AI0QtCSLfw4aDrfFgHTJbNKwPvzfyDCNOaBfqEmBDflV/5+VoUl
	TfMvlvPHdAHFLiMtqPEe+Tww/0LpCDaK55JDao6nQCQN3U7TnI4Q1o17Kp1fVjjdRgTu5xYhFQK4M
	XIOqMArye+JmaTJfFlznDK51WLr1QcEUusYcq74At0SlM8iNZT/03L/XOUJibUYaXj8Ir1cv8LmHy
	gpMy72jigkg+HCA9D7rqwUqoLEuEnxBuhOE7Sk2+xga196nyjAgKQX2mZeek4G7vVXejYrJ0Ig4pf
	Snx7nwRw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRrXA-00EnAK-0S;
	Fri, 13 Nov 2026 13:41:40 +0000
Date: Fri, 13 Nov 2026 05:41:35 -0800
From: Breno Leitao <leitao@debian.org>
To: john.ogness@linutronix.de, pmladek@suse.com, kuba@kernel.org, 
	gustavold@gmail.com
Cc: linux-kernel@vger.kernel.org, printk@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: [RFC] netconsole: plan for a safe atomic write
Message-ID: <avcI9gVR7brRHQSQ@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Debian-User: leitao

Hello,

netconsole is CON_NBCON_ATOMIC_UNSAFE, so write_atomic() only runs at
the very end of panic. There is a desired to have called safe atomic
printing[1].

This is the plan I would like to agree on before posting patches:

1. Now that we have one console per target, use one lock per
   console/target.
   - printk holds the target's device_lock around write_thread(),
     write_atomic() runs under the console ownership, and stopping
     a target takes both. target_list_lock and the cleanup list go away:
     the list changes under dynamic_netconsole_mutex and RTNL, and is
     walked under either.

2. A per-target field to track atomic writes.
   - In that mode, skbs come only from a pool popped without a lock and
     refilled through irq_work.

3. A try-once netpoll transmit, as Jakub outlined [2]:
   - One HARD_TX_TRYLOCK, then busy, with no polling, freeing or
     wakeups, which can deadlock under rq->lock[3].
   - It refuses when this CPU owns the queue (netif_tx_owned()), is in
     the device's NAPI poll (netpoll_owner_active()), or is in NMI on
     PREEMPT_RT.

This does not make ndo_start_xmit() safe, so the flag stays until
drivers can opt in to atomic transmit.

It is still unclear to me whether write_atomic() should depend on the
context (regular NMI/panic): 
 * For regular NMI use the try lock as best effort
 * Ignore the locks only in the final panic flush. (unclear if this is
   an option)

Is this a reasonable plan, or, there are some missing parts I am not
seeing?

Thanks,
--breno

[1] https://lore.kernel.org/all/874ie4y5mw.fsf@jogness.linutronix.de/
[2] https://lore.kernel.org/all/20260617132127.645534d1@kernel.org/
[3] https://lore.kernel.org/all/20260610183621.3915271-1-vlad.wing@gmail.com/

