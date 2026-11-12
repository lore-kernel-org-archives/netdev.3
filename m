Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496423;
	b=mVrf513OZpjRZvF3Wz+xUFWYlmUteQ6SmM1MX/NYLLrexCHWWUcW+yvrE42KkPXARyde
	 ucV8vNOxtZNNfOAystnPVtXFWVdwmp0JDA8CKAEA+6gwIIhpMb2mCrOChJcFDph0zov8W
	 CW75p8sRe0Sz+2gmc4UO2mBQ6/+U6UkVuOMVc7Oc9UARQAyQgfZVUbDL4zSvgG6GReM4q
	 D4+NVDjhT523eQcWAqtWoVevUrc05/Pq+H5PA5duhjbCoSlyA4+2Dm9mG0nxcY67Yvz65
	 KGYlDkncoYkBO4pD2alcSKRUPl/FxJu5975g/wB9ZebwRF33Z6E3181SSefuaUwDUdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496423;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PU6pz6sAUuLlAKHMASu9K4rDUauVw+egrO8YVD24hz0=;
	b=pWv05tNNuVsdpxPKaT+Fil7YMu9MMQhO/a7cyOdBjlpGRjyc/J6dbpNt3/qCyouSemIy
	 Ql/oVRFYtq9gL8tKfXGT0U4qQLsqzVAhVm0vJ/2isNtpWcyDCQGoV+0pVHmR3uKFhZ7bY
	 OYc4j2y0kGXgHWon1vc9lgOwJI4ft16kBPyg8RE4AX+ZLqf0UzoqknEv380Mah+3qANzs
	 ybIqK/gGZD4bObAcQKG7rvN4wcw4vPQzHVMVdor3jNC9RKEmif5rwtEu8Gu2xLwc+paHq
	 mjGMYjDo2U//mVYXtdi5tQVhgoiQj9AMvYt0QcwGdKjASxMtJ0L7Qh9ORfnL8UDxuBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C860A2601
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 767C860A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Victor Nogueira
 <victor@mojatatu.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 cake@lists.bufferbloat.net, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v9 2/4] net/sched: cake: use a dedicated
 split-GSO list iterator
In-Reply-To: <QDISC-BA27.v9.r0.20261108195325-2@mojatatu.com>
References: <QDISC-BA27.v9.r0.20261108195325@mojatatu.com>
 <QDISC-BA27.v9.r0.20261108195325-2@mojatatu.com>
Date: Thu, 12 Nov 2026 16:13:31 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87o6buozfo.fsf@toke.dk>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> skb_list_walk_safe(segs, segs, nskb) reuses the list head as the walk
> cursor, so segs no longer names the segment list once the walk finishes.
> Use a separate seg cursor to keep the head and the walker distinct. No
> behaviour change.
>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
