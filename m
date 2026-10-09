Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C10449B0B;
	Fri,  9 Oct 2026 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528770; cv=none; b=rruL09pJVHdrpHz+Q8OOf/uclMuVGmv1ivQ5Vv58Dp/TwnVTr+yTLL9bHErqLhyUfPjor1bytManU7DbyRni68buFdPQpYdqp70cynS+nWSAfJ4Fhf2sSy7fUhqpyvHWqVKr/2I7R5SIIsqOHv8zPRv4EXcVbR3hXN5/qo36k74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528770; c=relaxed/simple;
	bh=OHnagsKSc5pJHV/T3Hz4IWrEPkWe/SGywir2UlZh7pI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oh0IXDcoBcjZrMyyF87vLdPELikEo3sZUtm24hEhdvqGxHXJSrJqUS20jCrGo5VFZQugL9bMrski9zymsuQSOs4iLEsXZgPo/wHUMXLKFHsEasx/YmrUDEn20yPph/ApAAjvuugdRu9gVXMUVd4KwnGkVNwta1j1N+n4CWXUS5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWELuXtU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWELuXtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5003C1F000FF;
	Fri,  9 Oct 2026 06:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791528768;
	bh=HxhqS7KWFvgkkzT+tjSnQJnl/ACGgyIv2zEycuxVd1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NWELuXtUopvGNhwPDV2cVD96iICqS0r5K3Xh6iI+rUn87cP9JouteZzTln4Vxc3Lv
	 09PwntmjoJ+AdGW4K/RZTfmkXrnAUzzayiUXrH+D2133poNReg/Q5XtwFnD0uwtF4U
	 3yeDfjP/FkpQz7w7vHLmz5+tv6tSSgEgv7rTwGGGnWrH2aaHsKS0BvCKLUdwqlo/hI
	 owoCTwwtDvep14fAPVAKBmyVZQibx2jeTpLs7V8ZPmDpwniJgzJI+xBB7oZbLU4sbk
	 nmMUVYJ5Z003mv8uJKpy4n9vjjpHtgDQZaWMYqTL9qrqfYOYqAswuQ5CoO+3Qe1mx/
	 CeIFOE/iOczCA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Toshiaki Makita <toshiaki.makita1@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] veth: clear rx queue hint in veth_xmit
In-Reply-To: <20261009040412.14571-1-jiayuan.chen@linux.dev>
References: <20261009040412.14571-1-jiayuan.chen@linux.dev>
Date: Fri, 09 Oct 2026 08:52:45 +0200
Message-ID: <874ievs6v6.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jiayuan Chen <jiayuan.chen@linux.dev> writes:

> With more tx queues on one end of a veth pair than rx queues on the
> other, and RPS or generic XDP enabled on the receiving end, we get:
>
>     veth1 received packet on queue 2, but number of RX queues is 2
>     WARNING: net/core/dev.c:5212 at get_rps_cpu+0x560/0x1360
>     Call Trace:
>      <TASK>
>      netif_rx_internal+0x1af/0x4c0
>      __netif_rx+0x99/0x350
>      veth_xmit+0x713/0xca0
>      dev_hard_start_xmit+0x166/0x5f0
>      __dev_queue_xmit+0x1797/0x42d0
>      ip_finish_output2+0xa34/0x1f40
>      __ip_finish_output+0x510/0x7e0
>      ip_finish_output+0x2f/0x320
>      ip_output+0x17a/0x3f0
>      ip_send_skb+0x1bc/0x220
>      ......
>
> Easy to hit with "ethtool -L veth0 tx 4", "ethtool -L veth1 rx 2",
> rps_cpus set on veth1 and a few flows sent over the pair [1].
>
> veth_xmit() uses skb->queue_mapping to pick the peer rq, but never
> clears it before veth_forward_skb(), so the rx side still sees the tx
> queue index. Everything on the rx side that goes through
> skb_get_rx_queue(), like get_rps_cpu() and netif_get_rxqueue() for
> generic XDP, takes it as a recorded rx queue and warns once it is out
> of range.
>
> Clear it before handing the skb to the peer:
>
> - It is the tx queue index of this device, it says nothing about the
>   rx queue of the peer.
>
> - The two sides don't even agree on the encoding. The tx side stores
>   the index as is, the rx side stores index + 1 so that 0 can mean
>   "not recorded". So tx queue k is read back as rx queue k - 1, and
>   tx queue 0 as "not recorded".
>
> - Commit 710ad98c363a ("veth: Do not record rx queue hint in
>   veth_xmit") already decided that veth should not pass any queue
>   hint to the peer. There is no tx->rx queue mapping to preserve, so
>   nothing is lost by clearing it.
>
> On NETDEV_TX_BUSY the skb goes back to the qdisc, which looks up the
> txq from skb->queue_mapping to decide when to retry, so restore it
> there, next to the existing __skb_push().
>
> [1]: https://lore.kernel.org/netdev/156834bb-8e40-496e-9443-9d515fa18eab@=
linux.dev/
>
> Fixes: 710ad98c363a ("veth: Do not record rx queue hint in veth_xmit")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

...should probably still target net, and let the maintainers decide
route?

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
