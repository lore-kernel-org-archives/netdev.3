Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B89649D5B8;
	Mon, 12 Oct 2026 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818804; cv=none; b=WH1W5BHWVhBIz9xLFNGyp6NEs8pZG+ULr1fM/z+bx/Ht0/9nCeIw5yaj3EeZyDcH1x1TQHkpIRiqQooHYP47yNiyz1sFlztder9YdxBCmnUpxVmRAUDlc9Tozkp7rULv3NgY02lkq7u95kgIwMti0Ln7ta0j4CLtRaTLJkBq2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818804; c=relaxed/simple;
	bh=jba6O2iJvdsyyhGegzm9juTaIFjCBHqZsWi/0/nuRng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=maQA0RAyicfjPYmjjjTiqnEhMwtOTIda5J9CGr699fgBaZiOoePtRfOP2BDkuMwxOZl9gBLT0ro5IJnSAC5Yz9wHizqzVji2S3VJ2KAZzV4srZM33m+J971iEVhcXe3SdFkvWehwXrCiZIXgVz3Qj4/f8bLRBcKgqAh6n5A9fpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDcrsVcQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDcrsVcQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B39B1F0089C;
	Mon, 12 Oct 2026 15:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791818802;
	bh=E80nuRDCCDHbPtCHARlcSoYUnV2HMctcMo5RHmYnRrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NDcrsVcQ+sc2NbjZxysVV3F/MXvby1sjueGFZMIxAPUdtzy3n2DySPbww61kPN+ht
	 ysOrrK/FR6gkgpSQ7Z5qI912IjJ/6nneHX4J8CKi8BVpuzr7LXub2jVQUZeTFTSHmV
	 mGKnS472gdwVgHEYw6UQ/sQmPG9GvtfiXb5zglzGcYT6yoRoeGgljOoFUUayKPEZ/5
	 WJcICc3LVXV4Ck4oTgQSjGAMzAxOYa/PydZNcUjLoMjizQL7MQmtdmJeeR2YSMknjF
	 9gjXCTk8kjY6xmtpMFFURlnZ1+L/TypfgoOVhSvj8EyDNG6Z/l9XNP41zDg9nYQ+BY
	 wYl4e7D7eNGVw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Carolina Jubran <cjubran@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net] net: skbuff: don't copy alloc_cpu in skb header copies
In-Reply-To: <20261012124544.2018007-1-cjubran@nvidia.com>
References: <20261012124544.2018007-1-cjubran@nvidia.com>
Date: Mon, 12 Oct 2026 17:26:39 +0200
Message-ID: <87mrsjaqj4.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Carolina Jubran <cjubran@nvidia.com> writes:

> Commit 68822bdf76f1 ("net: generalize skb freeing deferral to
> per-cpu lists") added alloc_cpu to struct sk_buff and placed it in the
> headers group copied by __copy_skb_header().
>
> This is wrong for newly allocated skbs. For example, skb_segment()
> allocates a new skb and records the current CPU in alloc_cpu, but
> __copy_skb_header() overwrites it with the value from the original skb.
>
> If the original skb was allocated on another CPU, the segment may later
> be treated as remotely allocated and unnecessarily deferred there when
> it is freed.
>
> Move alloc_cpu out of the headers group so it is preserved across
> header copies. Initialize it explicitly in skb_clone(), which allocates
> the skb object directly instead of going through __alloc_skb().
>
> This was discovered while investigating a throughput regression with
> software IPsec. The load used 512 IPsec tunnels carrying traffic over
> VXLAN, with 512 parallel iperf3 flows and an MTU of 4500.
>
> Before the fix:
>
>   16.09%  queued_spin_lock_slowpath
>              |
>              --15.90%--_raw_spin_lock_irqsave
>                        |
>                        --9.37%--__slab_free
>                                  kfree
>                                  skb_release_data
>                                  napi_consume_skb
>                                  mlx5e_poll_tx_cq
>
> After the fix:
>
>    6.84%  queued_spin_lock_slowpath
>              |
>              --6.57%--_raw_spin_lock_irqsave
>                       |
>                       --5.00%--__slab_free
>                                 kfree
>                                 skb_release_data
>                                 napi_consume_skb
>                                 mlx5e_poll_tx_cq
>
> Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lis=
ts")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
