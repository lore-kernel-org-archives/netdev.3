Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793147152;
	b=WHRW2mm9mnX8smhhE3qEbZ+owyKL3RSxICRYdDkl97oDhDh/TIQ8XOIYrlnJW6G00ERa
	 XPjFBlmsxnUAIh1RcxN67anhW6gk5VrCfh3nucUWeya5tBj0UpqjhF3s3n1mP0iFyQfak
	 XtfP/rHoJyurhxIuudYRLedH2k0EFGl+Bje6sJv7TGRzIe2tvHMvmsFkNlZzhgGsaHqdi
	 2IjpzjWYnw89Vo4iVdbDYwAqi/Kmuni4m+wCT0bU7G066RN1fhNv9juJ/yXLJ5l8iEcDF
	 Rn6IAqwqSIjQ4wtHFwTqBxWJUdPs8lEw4AW9TLpcQvURYa2LRHKiv+ORjqD/vapYxzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793147152;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=DSUDuleFtEdjXo6DVz2LKAGdoX0A00zbIPJT/D7AoE0=;
	b=jQWLIM4iYxGzzTXvKgTI9uKtXT4CDpyHF0v3EWmpoDz3VV99OBPvGEZwJKE3dFfNqgv4
	 WwsDkfYk8mouHAC2fLZBrm868CCq45tCAxLJbo2oLk6sYCvmNwkYHyDMszK6+vYDFkWQo
	 c3Xsz53b5oIQZhWw9UC2bZ3r58lH1d8YzMaGsKbebdm98M+xkD067V8k6xaomkzgro1Ge
	 yd9lZMwArgpe6/AvhhIKkQCu+kUsk4Elq1xnHN3k2Y7qGzdl344DQmmFuASyMVSz7jNNf
	 6/B0TWNnSvxqwJV06IgjvAw97qC9P/cXWaqBIo7t3JfMoLXmovFxhGjZNUl/Tdm7lPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeconstruct.com.au;
	spf=pass smtp.mailfrom=codeconstruct.com.au;
	dkim=pass header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=dfie2cWD;
	arc=none smtp.remote-ip=203.29.241.158
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE39606A31A;
	Wed, 28 Oct 2026 00:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE39606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=dfie2cWD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793147148;
	bh=DSUDuleFtEdjXo6DVz2LKAGdoX0A00zbIPJT/D7AoE0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dfie2cWDnjq5LPPx0ZMunW0tKvlZTFYktNe1S+UPBJn6zvmVjsuU4EPLLpwwLcTL5
	 quSXOONbSHNKZkBArYmF1wQgK6+f3ZZ0QGTki2LK3HtS14BqGQKP40hDnimQ/SL+lY
	 pBzXomcQYIjct5t+gQfyQa+EJWAgjq98lGhqjZUF8JaN9nHQEPxsyTrNNvDYNP1A2+
	 B8erZZWtVSdXlmzVIEeMfKS2jVt5rwjBJYN4TerAleBJBkBrGsTOc3DZBe4FveH3Yz
	 wWD7YNQgCzYiBi0BH/fSMIal53Rf1bXvi6iaOlo+3H3od4XyN+Q2sV15rJsd/rqXSh
	 hPd7H0JffRKWA==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7724164C75;
	Wed, 28 Oct 2026 08:25:47 +0800 (AWST)
Message-ID: <8610ff0f3852f68c935f5234ea0236f89f7c0131.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] net: mctp: free reassembly head skb when key_add
 fails on SOM
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Matt Johnston <matt@codeconstruct.com.au>, Guikun Yang
 <yangguikun19@qq.com>,  "David S.Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 28 Oct 2026 08:25:47 +0800
In-Reply-To: <179301733329.91976.14585535037608378942@gmail.com>
References: <179287946888.17431.11219154409333681184@gmail.com>
	 <426ef7428413b8d05b6cc3ac22e24b1927ab5aca.camel@codeconstruct.com.au>
	 <179301733329.91976.14585535037608378942@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Joas,

> > We could just defer setting skb to NULL until the mctp_key_add() has
> > succeeded; there's already the common error path that cleans up any
> > remaining skb.
>=20
> I think that one needs care. For the first fragment, mctp_frag_queue()
> stores skb_unclone_full(skb) in key->reasm_head, and if skb is a clone,
> skb_unclone_full() frees it and returns a copy. The kfree_skb(skb) at
> out: would then free the original a second time, and the copy in
> reasm_head would still leak. Taking skb back from key->reasm_head on
> failure would work, but the explicit free looked simpler to me.

OK, yep, that makes sense!

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy
