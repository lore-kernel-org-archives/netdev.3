Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433517;
	b=UPx0iZmtlERh7MZa/3sgvkJ6T4hQOemtg0i6lwj1S46PrfJCEE5RnT17Fd7vcOaoseu2
	 WRGzoSdGeylhcZRYnb+26E0px1GCDHRGi/3QyU/WzwjWaiXnJ6n7z3zNgQq4UBFPxHhXo
	 JbsruDiphdlr4vrl156R5r3cDVDdQUs4iKWlNPgE3egZ4NBuH9Stu+NmyPr8dTvYh9K+l
	 FwwwWl+W0APIp0WuTqUiguvXrdMeQA55DNEgKCEaOgBsEOYujrKNkmLq0mRbGKWP/wXp8
	 PHe5bwhqQP9+nxbtqCLF7ODrwD0wWHNIAYw94PMHadqhQ2aujpoFUR3nLYRE2N7FrrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433517;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PU6pz6sAUuLlAKHMASu9K4rDUauVw+egrO8YVD24hz0=;
	b=Bdd06WT3CeBOdSyZf/Zf65YBMSNL1PAVpaF/ohnUT+kGAmeKBKMgK8+2lAm+XHUhwcfB
	 etevp+Cm9LFFG1u69PbUIWiGw3PtXVBX6obbkkfM+Heh8fJ4OAy6okKlPPGcD4Me6zwqz
	 ZxnhzB1bkuq+H9f3dDgpqACh6BcgFk2NYoijn8+XCT5kQ6ICfyzAQoeftj8ijZ4rTjKKq
	 ZbGpnKzAoHejMcGkl56t8Y/Ndocd1Mu86l8LKgc/N37tZI1KTfz/V3PDqKomNE527FzJ5
	 NVihZ7iDTQrrgS6yPgNkLh0s14i4z37RDCJA9VzNvf9A3LprsphBoPpp5qVbXOkTYbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D096606A31E
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 18:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D096606A31E
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
Subject: Re: [PATCH net-next v7 2/4] net/sched: cake: use a dedicated
 split-GSO list iterator
In-Reply-To: <QDISC-BA27.v7.r0.20261019115505-2@mojatatu.com>
References: <QDISC-BA27.v7.r0.20261019115505@mojatatu.com>
 <QDISC-BA27.v7.r0.20261019115505-2@mojatatu.com>
Date: Mon, 19 Oct 2026 20:11:48 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87tsmhwoez.fsf@toke.dk>
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
