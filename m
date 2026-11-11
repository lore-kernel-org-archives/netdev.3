Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397061;
	b=DNFzvhnx4xJTBaLc8Sl9CHbXC6FQI90pFfqzbSJVLD9clbo+oTIxcgFtWSytQsrKGz2G
	 0PVeXz08aON2T/RRDg6YG8PyyuEmT/bXIV3dEFvhOTTGu7sgo5H/3PZ8D4/TyqmzaS2X3
	 n+Q1ghSBUXeRPF7KGGwiES9eFbyEilfjtgR+dhfj1jI8XKm2o+KB2KeQG5PIVxLjLjWo7
	 gqfJFMjnqO7IZST40ZwOHjRgjyxWwX3RGfDmsBgDtKhwXMG/CL54oaChuJMeRp8TuJInu
	 lh5STFxYrhBKoEOLSNmot0QGdr5PiOhkiCb/3x4sAfjHXDDYX1JD29qZJ5fdN9VJL9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=GWmJbLCR3Z0PWF883WQy0SlXPcx6C4wxGpgsQpGnChg=;
	b=zDW5yr/kuKmS9NjL7/nYcE5XYDqSC/UtFxWuzaPCPtrvEQuHAUY14cfvk/kqP51Ir1b5
	 8D+qABd1ghVUVmoLnlFhchMnjhDNr+Z0Y2/Dk75O2D7DKaUCgAtFydpPhDmnIkQpAuR3u
	 Qdxv5+QGWyzdWyKFafahYvJ45fF2t7hXUYeuzTxq8BfJ1vOptq9TC2feDUw7DJ4GK7XFX
	 eUsZZ1mzxZmek1Qf5QDoTlkd5bpWp1U3ZlUvdZRCFrerOZMwXSagkU4+Cb573fscyjxSQ
	 cFONd07eyrJ5gXMUSAAtiRycOtd+BB45GV0gXxWzx+lt/a4C7nD7uL1JXiqkiofQWsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BlC5Gblx;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1AF606A32A
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F1AF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BlC5Gblx
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-943e8d35f74so266067185a.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 03:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794397060; x=1795001860; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GWmJbLCR3Z0PWF883WQy0SlXPcx6C4wxGpgsQpGnChg=;
        b=BlC5GblxeuC6mh7E5mlcHWaa6FbwL7M5zsHQyzNo0ElWDR1HAb/10OXHf4NPTjJrYZ
         28qVLgXYI0cEYMl1lacrKBU6nz6AUicANfMZJzE7tO5nUNNb/YLGhvSTEHQIGzEOAuHd
         nVuqyNnNQTSTYCKjeMB9T9GmTGazkGf9pwsNZ07qbwteqNGC2d7g3SsUnHMTDJ/U9yLA
         UNk/kC7bqqiC/S3ciUXpdExCDcSYSMdftZTBSKD4owXddH4eUYyHOmIyppHH6JwIk37s
         OAcw2gv8gQOn9dcZudYcQ7SMmXcsyH1a+VEFKbwnhezz+4FwBTNzgzrVoz9I0rpjutiu
         fZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794397060; x=1795001860;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWmJbLCR3Z0PWF883WQy0SlXPcx6C4wxGpgsQpGnChg=;
        b=IFw+H5roRBE5w80j3CLVAymCV3U3ErA4hHrOAgIG3FmH1oF/5+qHWFfhgwT7YO/Zhx
         9eVuQKZN7ip5EsUfL9nAOYRPZjXkyZZFfzO+ubsDCusbH3Oz0UDYjnqy/bP9Q0rSeKQA
         ZWtoYKv6QI9wtAPqtW8khKPQ1FdMmytZXQu4dUF6ZUjqYWVJ94e3sLsvaBRixPqjFkf4
         /yVmO0Y5uWOgCJLJtVkUwPegHLqiq63jkgtF0CZyJ/XfSbJ2FlK5VQY5SReB5dccmPKF
         xJOum5O34KOMlgBoB1+8l1ytpRF3dy8gcWUmEnRHVeLIHtxA1nxpb+A/EDRZtmC5Gn4a
         Yy8g==
X-Forwarded-Encrypted: i=1; AL+hErGWDLzNNwMGRUHjuFW8xSIrJ3OKgtUFYb6JUTQaYlIIY/0Fsyu88sFE68THhoHNu0CmaNr52fU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZgnfTBAkMWdzuD2vsIMomjx1nEYNE9R8DpX+AFDqxmNnle7oz
	OjxDtvKkBHnnOTl3eHzCEim1vTDQovbZWrdKUESOmQG/MJxId7O/7PcE
X-Gm-Gg: AYBFou3NSnEveiYt1OKBhCDFneLK5hwpp7tfnnMLuVAZ4yokfRgbDswoiZRqBfkVRE8
	ncGO4h3meyPZWiQHT75CNwUFKvJfEW30tnVk+/jREFJTFygIxWLsx4fauH6jywsNTU6E9MyNNjA
	j3rHqZO8fs2NuYdQKZzBZ3hJGTfaw7MlKKw6mB4qlPn+WPQkE6cwMB1qBSSkJc63GBM9llwepin
	4kYpPZT9QawuIElB76tOLFxalO72+BdnU51C/gKQUMhsbw2nUSFjEztv7abNNOBQvb5//7FEN3G
	ygOdAS7ySwsTtklwZmnievW8pNt77JCEHCwz0ydeW46o/xBUH8PUHHFAcQs709DEbMVl72vjBAb
	ZLF1jb33DYI0/f1HNhmruJe2EF0DNa11H9JPmJSQChsXTNcHJslUb8Be4GRamdK+j0VrNnzwRLt
	sAoaXrB0eEbKeJwg7bWLxHJJc8dR8BMeEYvW4C5yHoMbT+8Vm9GZashnveJzMHh68ZQhdx2Mlj4
	TQwoZeIIUYIif9h9I0mkUz+8ab4P34vFFGxBJjs6/qUteb/eBXTKzI6QvXIsWgtksNi3Ob+cdS3
	lsnHBcKa5prY1q9otMdzhR4Pf0x3wQ0fx/szwyxYkSmkQ77yv9ExVrk=
X-Received: by 2002:a05:620a:4444:b0:93f:3e45:a419 with SMTP id af79cd13be357-947b002af5bmr318209785a.38.1794397060199;
        Wed, 11 Nov 2026 03:37:40 -0800 (PST)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7dc398sm462686385a.35.2026.11.11.03.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 03:37:39 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 06:37:38 -0500
Message-Id: <DMSCO4I434TK.15MMEZI0V4UZR@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?=
 <bjorn@kernel.org>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Daniel Zahka" <daniel.zahka@gmail.com>, "Donald
 Hunter" <donald.hunter@gmail.com>, "Eric Dumazet" <edumazet@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Jamal Hadi Salim" <jhs@mojatatu.com>,
 "Jiri Pirko" <jiri@resnulli.us>, "John Fastabend"
 <john.fastabend@gmail.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Paolo Abeni" <pabeni@redhat.com>, "Saeed Mahameed" <saeedm@nvidia.com>,
 "Simon Horman" <horms@kernel.org>, "Tariq Toukan" <tariqt@nvidia.com>, "Wei
 Wang" <weiwan@google.com>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v1 08/15] psp: only give time-wait sockets of
 psp connections a validator
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Todd Freed" <toddfreed@meta.com>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261111005533.6436-1-toddfreed@meta.com>
 <20261111005533.6436-9-toddfreed@meta.com>
In-Reply-To: <20261111005533.6436-9-toddfreed@meta.com>

On Tue Nov 10, 2026 at 7:55 PM EST, Todd Freed wrote:
> psp_twsk_init() sets tw_validate_xmit_skb on tcp time-wait sockets.
> today, that becomes set whether or not the socket has psp offload, which
> is not needed but is harmless. psp_validate_xmit() passes such packets.
>

This can get sent as a standalone patch. I would probably tag it as a
fix too, even though it is benign. I can't remember why we (I) didn't
put the validation hook under the branch, but looking at it now, it just
looks like a bug.

> but a validator makes a socket look like it has an encryption offload of
> its own, and the tc psp action, added in the next patch, relies on that:
> encap refuses the packets of such a socket, and sk_validate_xmit_skb()
> drops a packet with a psp association whose socket has a validator.
>
> set the validator only when the socket has a psp association.
>
> Signed-off-by: Todd Freed <toddfreed@meta.com>
> ---
>  net/psp/psp_sock.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
> index 609b06c7af65..664955bfb4fd 100644
> --- a/net/psp/psp_sock.c
> +++ b/net/psp/psp_sock.c
> @@ -330,10 +330,14 @@ void psp_twsk_init(struct inet_timewait_sock *tw, c=
onst struct sock *sk)
>  {
>  	struct psp_assoc *pas =3D psp_sk_assoc(sk);
> =20
> -	if (pas)
> +	if (pas) {
>  		refcount_inc(&pas->refcnt);
> +		/* Only for PSP connections: a validator makes the socket
> +		 * look like it has an encryption offload of its own
> +		 */

comment nit: for my taste, having a comment that starts with "Only for
PSP connections:" two lines under an if (pas) branch feels unnecessary.

> +		tw->tw_validate_xmit_skb =3D psp_validate_xmit;
> +	}
>  	rcu_assign_pointer(tw->psp_assoc, pas);
> -	tw->tw_validate_xmit_skb =3D psp_validate_xmit;
>  }
> =20
>  void psp_twsk_assoc_free(struct inet_timewait_sock *tw)

