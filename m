Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306614;
	b=ohaQx0Znuey3jfHD/JcYvaGzsfZkz05xo2N2F0pZTudrs0+TlVYbHWUjfm4MsMRWWxan
	 3Z4co5EWarLsmmXo+VeXkc5oqF0E0hEpAo+i0aXsdzDUoeIGXq2fY3ReB5fSxja1u60Q6
	 yn/MxvaJZTB24kPgrVj+naBZbBiWltKGjX4Z9b306Lax1giOmKpD5yq9+BZMVS0RwiajE
	 MrQEK0NaWX5ILaZiwAzCGvN7qpCCqkDRs7Sb6gqavwrgv3JV45wWMVa1PtGj2JHn1yUrB
	 gLRpG38Y31SKCrPPJcV0U/yRGYqHHA/nofI2kbDAZQPolG5aluV6ydJMzpPo2pklCFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=zi+Zsq/PpxVfP2QTeVnAcqL73Etz3B0CnzQ12J/UIHw=;
	b=U7M2B4DJxhwGw84KQAYTlB1K0mDOvWplOIMpLUkp2hRJp41akdOLyxLqOKjXv8C7DLGN
	 sP8dy7E0YSQEiUUocGTSq2mbzs61FwdWt6AOgjErw+75pUjW+wF70AgV5w78WC8ecyikR
	 u1+caf3Iua41wkB2HGzK+9s4eqEF3Ji8Vyp2t0LdvWAX4pyRfkA5ooJkGOa+e1fPIcHCn
	 Csk4MavLyzru79Z140xOCHhGDzWHLFpjmT2q148wAxnlDqOqNxRas7jPtpao0IOhPVMR0
	 P5mm0OpvZSavgFLvF/Z7JikjtLHrEKdXrk+DhxG757r48sC4zZiWHJ9D7jZwgFNIjsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kwvx5BjZ;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA09606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AA09606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kwvx5BjZ
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f3c616c84so174642185a.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794306613; x=1794911413; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zi+Zsq/PpxVfP2QTeVnAcqL73Etz3B0CnzQ12J/UIHw=;
        b=Kwvx5BjZ2evAT3Q9Yj2Ow+4dEP2dZiu3wvCKtvQz+Ysi1tT7TwtQBuZIZ3Y0/mi3Ds
         aedjON8EDZmp4KkhzGKqaUOe1fsVA5cSLBQAkOsvzw5o6pXQu3oRhOqbpw+hg9afEbY/
         pQvPgUcILsLmHMNunvW4cOzTchoaoZ2e0mrTsymAmUt5s3bf429IDtO3e/mPmY1iN0ar
         /tKkVO6T8rdJZ8wPERNAKH4ajWLt+dE87yoAoz3IL7y+ZWshNMycy+SeJusY0nfQiqin
         Z1ePlSRrmEt67Fd9Ci98ZG+6zBno9H/ZJVJ679jCeI8fkQts5wFSiqqVOfFP24Ac9HvW
         tNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794306613; x=1794911413;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zi+Zsq/PpxVfP2QTeVnAcqL73Etz3B0CnzQ12J/UIHw=;
        b=T4pviZnGQyi67U7DIotIgOScFbb6wuA00sqwiSXaZOj2UYjYvtb61OxbWjyegzXR4Z
         A+TSe5FIfrD4+twYOu5JyZY04j4ZNJTTWM4ZGLOV5o2DQlmMFjsk+rwJSP0tC94xanrg
         uH2vQP9Z8QjvLcvY09+EIrkn+1zGcL8x9wjv2SIpbLSwo2bWofbhjFvmmMTtFphg/Zvx
         8u2Y2zAHlUSU/V/p9wOlS4phmoiqkUBCnSDeuBEMQi5ER2N+hbsiMJepLFR0wh0cbxAI
         gUqqEzVCpGNmH3v6M3i0eceJ0dBf6g/qvkYbVxpcAkdIZzsBa+TkRYes5gvm7kJk9H2K
         HL+w==
X-Forwarded-Encrypted: i=1; AL+hErGdjWsXbK7m8NwD8jRhk2v253K5ZmjpISFG2Y6zPu723fImi4SbGsX5UfUkZaOvamr7YnTW73Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Z1geqkbJy91QT27WtuRTXTgu3FYOphRVF0FkT8bt3Y7NWQ6Ze
	W8MZmM1/s0oieH1sj6u53GW1e+KCjMpvXOojD1zhSOVKXV4TLajlFH3p
X-Gm-Gg: AYBFou3cmShCLbpLgXFAa4pvw/CoTKFkWIlz1waZep77O1F0RCz3sFGsy9zy+XtA+MS
	iMpe+jUWNeqQOCnUv3NzePw3DjzkMt8Oe450qcDlt0yW7JVbbhYU60L7M6ZAQksJSQ7Tp4IWjaj
	ySTIu5HyZweOB64Z+XEOB+GJR75PGVpaoj8ouH1Vvxe+/fHTaKl4y1uYD706PeoJha3/JQuvuxL
	YIoUoVFqQaymv+Cp4lmVVMXaT1sADKCiEpJvEkDGiPz+b1J5UlSuqEo5Cp8N3VfAW29eA861LRO
	wuG74l9sRHiHlHQXDduonEQZgr1Wmb4dQEH85U0KlfX7tFzD3mFiDGZoj5T1M1mHIU0UH1lG8R9
	RqSxbi+XyGOfrVFg4NB97ebQqyxO0nRlKxgMaCuQaeJ4IXXIw77g1mDKkIlb8pv8CFLwrvlvo/K
	uq6d07yBtuDjnFiPjz+njSjed95r8J4TmZnvh6uCgMvQyfchSg6RASADFiu/9pyntExZwNqMTOJ
	FpvvXMwhnFCQpZ+VPbiQ1jWVyDT1CCt0Zw4tU7jQciJDnOtmL6dzD7dkKGA5PXHQkPALmkYn2Yx
	aQFprYLQRKkrSj4CgIeWuK0iC7KEzZOlXw==
X-Received: by 2002:a05:620a:4047:b0:947:826d:15e4 with SMTP id af79cd13be357-9479f4317a3mr342618985a.76.1794306612793;
        Tue, 10 Nov 2026 02:30:12 -0800 (PST)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef43519a0sm9282416d6.3.2026.11.10.02.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 02:30:12 -0800 (PST)
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
Date: Tue, 10 Nov 2026 05:30:11 -0500
Message-Id: <DMRGLXRN47F0.EPQ8KQQ531FL@gmail.com>
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <pabeni@redhat.com>, <dimitri.daskalakis1@gmail.com>,
 <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/6] eth: mpnic: Rx checksum offload
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261106-mpnic-lso-v1-2-e943ff1493e4@gmail.com>
 <179426706505.994134.14903670095120167303@kernel.org>
In-Reply-To: <179426706505.994134.14903670095120167303@kernel.org>

On Mon Nov 9, 2026 at 6:31 PM EST, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The CHECKSUM_COMPLETE value in mpnic_rx_csum() is only right
>   on hosts of one byte order.
> - [Low] mpnic_rx_csum() (drivers/net/ethernet/meta/mpnic/mpnic_txrx.c)
>   sets skb->ip_summed =3D CHECKSUM_UNNECESSARY and ignores the full-frame=
=E2=80=A6
>
> --
>
> eth: mpnic: Rx checksum offload
>
> This commit adds Rx checksum offload to the mpnic driver. When the
> completion descriptor's l4_csum_unnecessary bit is set, the driver report=
s
> CHECKSUM_UNNECESSARY; otherwise it reports the l2_csum field as
> CHECKSUM_COMPLETE. It also exports csum none/complete/unnecessary counter=
s
> through the netdev qstats API.
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/=
ethernet/meta/mpnic/mpnic_txrx.c
>> index edb087b12a1e2..680625810ec03 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
>> @@ -655,9 +655,34 @@ static void mpnic_put_pkt_buff(struct mpnic_pkt_ctx=
t *ctxt, bool napi)
>>  	page_pool_put_full_page(page->pp, page, napi);
>>  }
>> =20
>> +static void mpnic_rx_csum(u64 rcd, struct sk_buff *skb,
>> +			  unsigned int *csum_complete,
>> +			  unsigned int *csum_unnecessary,
>> +			  unsigned int *csum_none)
>> +{
>> +	skb_checksum_none_assert(skb);
>> +
>> +	if (!(skb->dev->features & NETIF_F_RXCSUM)) {
>> +		(*csum_none)++;
>> +		return;
>> +	}
>> +
>> +	if (FIELD_GET(MPNIC_RCD_META_L4_CSUM_UNNECESSARY, rcd)) {
>> +		skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>> +		(*csum_unnecessary)++;
>
> [Severity: Low]
> This isn't a bug, but should mpnic_rx_csum() prefer CHECKSUM_COMPLETE her=
e,
> since the same descriptor also carries MPNIC_RCD_META_L2_CSUM?
>
> The commit message says l2_csum is reported for every frame, and
> mpnic_csr.h doesn't define a validity bit for it. The comment in
> include/linux/skbuff.h says:
>
>  *   - Even if device supports only some protocols, but is able to produc=
e
>  *     skb->csum, it MUST use CHECKSUM_COMPLETE, not CHECKSUM_UNNECESSARY=
.
>
> With the current ordering, every TCP/UDP packet that the device validates
> goes up the stack without skb->csum. Anything the hardware L4 engine did
> not check then needs a software checksum. One example is the inner
> payload of a UDP tunnel when the checksum conversion path doesn't apply.
>
> The in-tree fbnic driver uses the same pattern in fbnic_rx_csum(), so
> this may be intentional. It still doesn't match the documented contract.
>
>> +	} else {
>> +		u16 csum =3D FIELD_GET(MPNIC_RCD_META_L2_CSUM, rcd);
>> +
>> +		skb->ip_summed =3D CHECKSUM_COMPLETE;
>> +		skb->csum =3D (__force __wsum)csum;
>
> [Severity: Medium]
> Is this skb->csum value correct on big-endian hosts?
>
> mpnic_clean_rcq() converts the descriptor to host order first:
>
> 	rcd =3D le64_to_cpu(*raw_rcd);
>
> So the u16 that FIELD_GET() extracts from bits 47:32 is the same number o=
n
> every host. A __wsum, however, is computed by csum_partial() using
> host-order 16-bit loads. The correct value therefore differs by a byte
> swap between little-endian and big-endian hosts, and storing the raw
> field can only be right on one of them.
>
> The MPNIC Kconfig entry only has:
>
> 	depends on 64BIT || COMPILE_TEST
> 	depends on !S390
>
> That still allows ppc64 BE, sparc64 and mips64 BE builds with PCI_MSI.
>
> On such a host, would every good packet reported as CHECKSUM_COMPLETE fai=
l
> validation in __skb_checksum_complete()? That would end in
> netdev_rx_csum_fault() and "hw csum failure" messages. Decap paths such a=
s
> skb_postpull_rcsum() and pskb_trim_rcsum() would also adjust from a wrong
> base.
>
> Would a conversion that keeps the device's byte layout help here, for
> example (__force __wsum)(__force u16)cpu_to_le16(csum)? Alternatively, th=
e
> driver could be restricted to little-endian hosts in Kconfig.
>
>> +		(*csum_complete)++;
>> +	}
>> +}
>
> [ ... ]

pw-bot: cr
