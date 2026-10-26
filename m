Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029989;
	b=mno6QXxqkuBM1BPTKnxgyAOqqRM6CG3jc9W7Y5EcHaoyYmvaPVY9xr2rKJP88UM853MB
	 dRsB63MZaZZzSaIZrydV/0PMh4eq1f9BYDRMh6ScqnNZfxL8WgAYAcakBWuw+e55CMq7a
	 5wx335QX3isisp6q8e0/6TIkdmdM9Lm3Xvtcc3Mke3Z+UvlwwSx43vUpwKQphjbwdOjor
	 atd6MFVLY1IIIoFe89Cbw/PMsamkq8f/5o4i/R+wzpRdTYJXGeTNHcDFj4tsdP2pbFebw
	 lu0Nwdip2af3i/eEVPlmP0ObP/YQA9PFkcgkDhfRAICfhg3f77niMKnLH9EUFM9/4yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029989;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=bBoElw9ysLsJQUI5C4w63KN4DXiE3vbiLtAf+efL9h4=;
	b=r5qLh6stDb+RhSXEr0ba49L0pIceCPx8FJT3s/t4G5QC9YJwxeo3EDAhl/KAc5/jlqvK
	 f4rxd7xDeRtefKy9x1jylfGr1+yBA7ibyFEpjVb3FWapZexdqj6Ui+8g8hRqk8NU4+KJJ
	 MP6VrTal036Iod/BLhCfzVlkmeeRWujtEKKEG3P89suKHfWpoLW800mJOkIBLgJ7yLbJc
	 /Os20mgt33Uto74ObIZTJa2FLC8MFthEUgEWQS8hDSus9jrmN5VAziAezFR8xKKOZb2U1
	 tm/5cZvQAq9eQwBCVy+5DBQF900YmKPUuHkqSRGVrFyipQAHMzI2qnMU5n3L4QLlnUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTdinQVJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D080B606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTdinQVJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7574E1F031E6
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793029988;
	bh=bBoElw9ysLsJQUI5C4w63KN4DXiE3vbiLtAf+efL9h4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jTdinQVJ6Y/zy7EOvUPX92o7sAFic0UzNWh5zy2glqPkYzkVh3Mc/rzKkgivWTJgz
	 n2kioSaFNnRWT1912/50vIAmCwUtoQlQf8ZW7nnaWs3b1BnV4S+at/FQaGbnRKR3Tg
	 0I97p72cKWGIgupJzxJzrcrvzYzdxTa8SplXNF+jQR8Ca4SOiElW3Dew83xM0EnGwJ
	 4sRUwGEORnH0t84ne6SnJ/cMuPa8PcWRXY3L0Gvg0muwGaiPwCv/hlMKghav9l2vM3
	 72rkolUxi97UkeuZ0krOpd7fVW6HsRv93YPqfpEVWvvCmZgskCfCW/x0r2288lTpbp
	 i+J05wTD6AoaA==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4af173320f9so1832046b6e.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:53:08 -0700 (PDT)
X-Gm-Message-State: AFq9FYK4sxOnZHNQ41xHuTQZDtFHr0c1bsV+BJ5DOZqJoPbIgIZsDfZu
	VSOKUByn1shxC3Meq4IJNQc/ZQ6hAgGZgUBZHOnbQPhMOh2cCHoU0xEjPqSHr38W1Ra/tWLlyAz
	pxgY1YHh0k81CVllGfLHXCFvu+5e1J5k=
X-Received: by 2002:a05:6808:6f97:b0:53c:af69:84dd with SMTP id
 5614622812f47-55c0023cd9bmr4694423b6e.12.1793029987656; Mon, 26 Oct 2026
 08:53:07 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026153113.3275494-1-antonio@mandelbit.com>
In-Reply-To: <20261026153113.3275494-1-antonio@mandelbit.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 26 Oct 2026 16:52:56 +0100
X-Gmail-Original-Message-ID: <CAL4WiioW-1AcvoL6OxOJK3RiKCUumhprte=hBeLRT6gY4QhENQ@mail.gmail.com>
X-Gm-Features: AclHuK-WozjKfrhLn3dLLvjqv4oI1SvuaLyn7JbhC-t-dDZ906WiZQoSv-YDBKA
Message-ID: <CAL4WiioW-1AcvoL6OxOJK3RiKCUumhprte=hBeLRT6gY4QhENQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix packet reordering on requeue
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 oct. 2026 =C3=A0 16:31, Antonio Quartulli
<antonio@mandelbit.com> a =C3=A9crit :
>
> dev_requeue_skb() appends requeued skbs to the tail of q->gso_skb, while
> dequeue_skb() takes them back one at a time from the head. If the driver
> returns NETDEV_TX_BUSY again for the first of them, it moves behind the
> skbs still parked there and is sent after them.
>
> This showed up as heavy TCP reordering while benchmarking over veth,
> which returns NETDEV_TX_BUSY whenever its ring is full since
> commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to =
reduce TX drops").
>
> Requeue the skbs at the head of gso_skb, keeping their order. With 4 TCP
> streams over a veth pair with a pfifo qdisc, this removes about 1.3M
> out-of-order segments and 15-37k retransmits per 15 seconds, and raises
> throughput from about 40 to 76 Gbit/s.
>
> Fixes: a53851e2c321 ("net: sched: explicit locking in gso_cpu fallback")
> Fixes: 9540d977618c ("net: sched: fix skb leak in dev_requeue_skb()")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
> Notes:
>
> - Setup: 8-vCPU VM, veth pair; sender with a pfifo qdisc and TSO off,
>   receiver with GRO and threaded NAPI; iperf3, 15 s runs.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
