Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847544B67F
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902070; cv=none; b=BUuw2zRqpaOU9GboZLtj+GU5LBDlin3M3vR8PyLW12MUPFkgYvRvi+s824bhcdfvPmwYTfSC4h7hA8ISdrc+K7ItQ/rSiLLbqH43gK/NujACANP40T6/k7RShHBLQ4O7iz3otRM051bbsSRl7J4yrsPbN+R+UHrCH3hstUbIw5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902070; c=relaxed/simple;
	bh=+BIXR5CBbiY/1ix9BdcijOKGy3APh6R/ICYgijGbGvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKacGOy21zq45COzAM83HLsPaRE/n0pYVyx+vw1fa6/8D1HuuifCwdXHpCLWFteoB2BzzpwXPdOyrtsb12WIaXpX64N8ZiXL5OHJOVPQgu9YVcSGG9YgoxWOnN894oLnRseE0PaRjwyfRlLM2LKL6yPsFVsVGj18nrpg09Xxj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=T1n5HdcJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XcfQsts8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="T1n5HdcJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XcfQsts8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72A481400079;
	Wed, 27 May 2026 13:14:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 27 May 2026 13:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779902066; x=
	1779988466; bh=eBEkzZfSYu2TuW8YyfqX1Nwr9i7uRfimpARkDwGBRZ4=; b=T
	1n5HdcJDlF6CzMHR8LNZo7nHjZitO3moC9zSsxRDmve4jJo4nD674gJ60tH7T5JY
	vq6yCuXEsO/iqeBDdxYZ4xgaXffpmk7Ju6Qpkr85uHqteE+rYdSrrt717++vAg+p
	VpKkIZepnHuy1FkkIZH6PQxKL0CBlTVzNW/KUn+N8FlSxFEtXZ0L9XN/FJ24BqVN
	OeIetbyP1kdacVp18oEghH8Wcu+7//7S+RfH1xiFDP2DriC4XigZ9zR9uw2deflf
	aET3MrvIgBgIrf+yJOpU9vnoGBe5/pdzF0GUorbrIcnVQ3Yo0E2WPCTM9pUicOMv
	S9G3NTpxAESol6e4lZCZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779902066; x=1779988466; bh=eBEkzZfSYu2TuW8YyfqX1Nwr9i7uRfimpAR
	kDwGBRZ4=; b=XcfQsts86V2L9dbkJe0FDUP2dtsSsdqLU5Vk/NxclqDgPPanpj5
	hl6rvwM95T81xGbHYjyw00Kmqdijrg0RG2aveMoutPwQcsypZB2GDJPzUBzboQ4+
	tLDR8iy4qAK5rlJvQGp88ZzHnE++shZzV71nDx+5O7rtzaOz2KF6fFF/9Y2UcZjO
	ICVUc1Zg8fPA9h/Bmr0i1hP+7P1p98YIzGNp6qt9cstsIqtYZRTgJBBdC0qfvd8l
	YVq4NUhDAGUY8ZrSLI0ZXQ82WCTeAjy+QDEiNegJf2JfFZ8Fi1jlQ0KcZ1Eg6hlk
	ZX/uwDNPiceE1Mmuok10otDYQes+vD0CWOw==
X-ME-Sender: <xms:cSYXavIYVJCBGdnEPIs7ovIpCC1FZWFJ8E9-yaw3p82vNcxvo8nwRA>
    <xme:cSYXamMMxQ1134ch9mGAXGzUUFcGg2qqHFfbykTMxjygJLoSnTPhhAiBPjIv-FYCg
    VOz-AzhdZ_Fj9uHXDHZssGpxfIFvJFa0cEFQfFzYYUb7TcbrepF-K0>
X-ME-Received: <xmr:cSYXaiUQaYfVHB_DM1MqwIBPnPv_Vyv3OMoyb8Lp7EKgHdXM6Z9fxueIVcesvVe9as82NZuMAsfztYuCPh8q_V4>
X-ME-Proxy-Cause: dmFkZTGX4AiuWMYOC6g+JirA2WvScnCdx4HepEW820539ObOUAH7sHgTGv+1BTWVOqKaFs
    dfXqv0mS7WqX6JgE70P3QseKLgiGqHJN2V72aKqinxqnaGoCpyiw+Um2+eWkvLfX/64nM5
    mXwSod9WO17ZCd+owgrCzSx8LdIyB++9m/XzdLzM8SSNORWILb+ErIz95nzYovf9PTT8Ok
    6uYxtvK6fdhR/BwZELQRY8jojMSZeVmdoXmN86ZY/9Ti7WDWkgQT2PJBifFitVVwtxQZqe
    MKvFSsKrc+6ToDbckgWPojEvNmhzbwc9voQIGbeg7X8s5/vAbS6R/0+FX/QieSoA8Jkjiz
    s5VUsDPOpBFNIvCM2pL5QzpPsNp6vH5dWNNfNG4O5iMZLS368v55i770omDNJJCACQZEFi
    hvfBaqZ+XqWu1WscAyukhM2/BA9V0oxfFKliNBV+dOjpNR1gAG+IL/d1CB9AoXpMyveSHZ
    OUOp6u9Mj5cFErKvO75lRWFCeM/LCZgHufGSFyN/vtv7imcyDx05jBXIIkboKZNw680muu
    3VxIw+lQaIRBFXsR86XJjQDBWF9VxhTKkCl8CHM/GfxA4BOs/e4ogP0Bo1/JLe5vHGGv1c
    AIWZk2MxFwNF9EDacfWOzBVAV9PTDbpaklsCdRZAJfjStp4FBJ9eBgiXLWSQ
X-ME-Proxy: <xmx:cSYXakmVW90s4KGAfsEGxlSrz4tjyPoSdpoeI8m5LmLku7jhdxNmKw>
    <xmx:cSYXahOPKgkh0x9tECYwa9gWyDcho-KZpO2id1onS8SqR3EaH-lK1g>
    <xmx:cSYXasINoEUDdUbFLInprWNOb0JG3r8UwnpwVuENFTSvzFpB8STGpA>
    <xmx:cSYXar3p1OX6h8Ze05ih-u3WOgYAVYCWnFrJANgrqsIoBtq6xHoNRQ>
    <xmx:ciYXajf_5s74wsq98zD6VjUueNhGvJf54duloNzK5OfClfXls5CB0o6l>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 13:14:25 -0400 (EDT)
Date: Wed, 27 May 2026 19:14:23 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH net-next v11 2/6] tls: Re-present partially-consumed
 records in tls_sw_read_sock()
Message-ID: <ahcmbwpSmdeV_UZb@krikkit>
References: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
 <20260526-tls-read-sock-v11-2-244fe1dc4abd@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526-tls-read-sock-v11-2-244fe1dc4abd@oracle.com>

2026-05-26, 10:21:32 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The tls_sw_read_sock() loop releases the current skb whether
> read_actor() consumed the full record or only a prefix. When
> the actor takes only part of the record and leaves desc->count
> non-zero, the remainder is lost: skb is neither requeued nor
> freed, and the next iteration overwrites it during dequeue or
> tls_rx_rec_wait().
> 
> No mainline consumer reaches this path today. The only
> in-tree TLS read_sock user is nvme/tcp, whose actor
> nvme_tcp_recv_skb() loops until the input length is exhausted
> and returns either the full length or a negative error.
> 
> The path becomes reachable with the upcoming NFSD svcsock
> receive built on read_sock_cmsg. Its data actor,
> svc_tcp_recv_actor(), parses an RPC fragment stream
> incrementally and returns at fragment boundaries. When a TLS
> record carries the tail of one RPC fragment plus the head of
> the next, the actor returns fewer bytes than offered while
> leaving desc->count non-zero, and without re-presentation the
> trailing fragment header vanishes.
> 
> __tcp_read_sock() handles the equivalent case for plain TCP
> by leaving the unread bytes available for the next iteration
> to re-present, via sequence-number re-lookup. Adopt the same
> loop-level behavior: when read_actor() consumes only part of
> the record, update rxm->offset and rxm->full_len and requeue
> the skb to the head of rx_list so the next iteration
> re-presents the unread bytes. Switch the open-ended for-loop
> to "while (desc->count)" so the partial- and full-consume
> arms share a single exit check and read_actor() is not
> re-invoked once desc->count is exhausted.
> 
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/tls/tls_sw.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina
