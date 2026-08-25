Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0113EE1E9
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652008; cv=pass; b=eepNaePEU8B6Hvf1mJ9VmbFN3NxLnyVJe8mK8/ulnGiJ8a8U2axezcpH66Pw+IDudtgUIsDaANTPWCcxfP6ExxKOhYicjI7gdGlkhnrTx98sNwg0Q/hsULmkw76No13Tn89r3JocbxaSs4vD5HrcrsyMJOGM2x1fo4BXntpmqn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652008; c=relaxed/simple;
	bh=5ROAdHa4nzefJ9mYhwr+Ia/QmWrTRWexR+i/fU5s+nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mznu6TyI8g5z7tf0sqiKVBPRxjIaF7yYhHIagybeooyoYoyKG8iMH/vmFJTCwUy8RKwcA8e4mHPeHEYcYHvNqZZ9U6qYrPsMyhjtnbI2VXnMTiyRADj6s3B18MarCxtdoIFqBmVLQBJ02EVuy8r/+9fcSso+TgTrr50D4lldVek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fOcArFGb; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOcArFGb"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-936dfd009d1so43864885a.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 03:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787652006; cv=none;
        d=google.com; s=arc-20260327;
        b=LtRtsEUhczYyF6PlBl9MNJpdZFbhk2+6ei+fPntpvNZ+chAaGeQaqVuDhDKQVbT0jw
         OLiH8gnZ8U8RrabBG1TIOdg3kT7fyWJqDL0Zsphdiwv7YWivHX73sgCcAMUu5/Vif7fW
         LOoh6AOQUvwpopDYddRmYdtIBUtzgxm1IFjIa+tiYpMSvK+YDXbul4sRU3vm+lOeAHOo
         O746YB1eQUq8QaOnapjdBGycdhQzgfz5zx1OjgY/Bd7Zujb2stnFRpoKrEqiTBzqmKFM
         zN00qWNIGnWu+CBnd2XrGZmtC5+peVRzzlr1NnipybGI4xaQpJbuM1n/Dy9O0mHu43s+
         9pnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D6L9LKYeqLuIff+0D2Zo0By9WXhwnZquMWzgRyncd9Y=;
        fh=DXXPBA99u0iD+88CFXEaLrB2SMz+Ghn1223wCiClb44=;
        b=ca+5kpYchPCyf1dwjzVll3hIGy7bWPSyLZN9Imdyzsy7IOrLCpnvtit1RrMHB20NTW
         lZ7Yw4AZm7UCHfBH1T8siZgNHICHIZyy84MLoYae+GxDCEvURYKLsHG0FRBQsvnpTGLX
         hA2YJuvfdHLu2zSxX0OI3rSiBojFjvTVSlS4GMzqK2qOojLDg0VA4ESS1SVSh/GsP+U2
         75RmDJJcFFYXCBYQoI5TyiPoIKxHtD8rFHZpoZOEewbfXoI8sSJTgW4/ZCM3MUQkEfj/
         60yAtgPP0TfoGd4Po07RVilWJvXAAFmDlPZi4C2fv4s0Pm6LbOXynPo5vVZR1UuWNaMh
         sf8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787652006; x=1788256806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D6L9LKYeqLuIff+0D2Zo0By9WXhwnZquMWzgRyncd9Y=;
        b=fOcArFGbOv4miYN/HydsLoNTHHN5CmlmQD8fxQxzhQeLHXV2Q5g97Pdl5W/NWJDXwE
         sO9XCyvXRuQX3Rwb+ODJvxD1k2Sz3PXzufcg3etHk/FhlbZM9kGYJWiJ+PClpuqBOp/H
         gl10ov3hm9Kl8vteC2OdBnLrx+Vw8QkhTzhfZ0ww0C6GowlMJdOk1tQoPyUJcg9fkObe
         NeFnfLGMWK4M/23qsHGiY8bgGDDOcbHbWz+s6x0y3z8AdHSFlQVGlH2IwoDjkOv/ZFPF
         H2wLbPkpRGvY+LD978Za1x2JBMpl3023u3LNKuBRnJgsSQByN1ElxBVE/U1SMY+NaiKk
         vn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787652006; x=1788256806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D6L9LKYeqLuIff+0D2Zo0By9WXhwnZquMWzgRyncd9Y=;
        b=btIAwBvJJGxykdwhCpuFJk44/kIUQuHze6wVFr8sxOjx1hwnVY6Vlk2GRSJz2L548p
         FIVgQ1Dyeoq99CVacblOPrMN4EkCZIxGPJwIxQY7Lu/h0N+wZirQ3mht3Lt9YWZeWYRA
         uRwKmA3+NfqmKK+slQieQZ5eX51j4mB+tljtRL7XZz357AgFs5oftCpjVM+KUQkKVKyk
         5FqVVLt2fLknE7GA2hNJv9fezU/817LAZCGU7LlwGj44oLF17wtLt7dqwGCbtoNxJMTD
         cAmEGzhHrLVIjroMNCO8co7Bb1Ayeic1tTMV1LwwinNO1r8pdb+/i4Ku7nkLjdvEuykQ
         fUhw==
X-Forwarded-Encrypted: i=1; AHgh+RrFSBSgvRqjcBfiJ9h8INgjCm8yR2AEfPo7dtL6036MlLPsTbcrqwq2QnnWALcR4SXaEYQjrA8=@vger.kernel.org
X-Gm-Message-State: AFuF++kx0O57g95VmiUzri820tvXeVnE2NszScoNLL28d2jFFOkX7UWw
	zViWWuwGMsju4vQGS7k3CYqJ58b4eXvPKKh/l44hlSPZSmLgpWZSBLco/v8z6jlqUgctlvfaqA2
	LbDscYDe3t1yzN4B74XaElAp0d14RIN0Cj4zDcTbH
X-Gm-Gg: AR+sD11VR4DESxl6Sa8ypwDA1fI4YTM8Tb5ADiRn3N39Svvk4rHOhWapHFUtf7cUw/E
	Te0OnBFHcABWWD6G/v/Q/hWfRB+YNnB0SD0rVdTvfMZk8yTnW8iefrR8kh5Hzza2Nl8DB7aWm38
	dWw0934QTi7KfNeBDW16iw9YoanPvwa+e0tDP9V98a8GXjVciLUvsS3i5uKCr41pVT9WzIWJwv/
	1XgkQ3vdXfOf9o03Qzys3aJV9m79E1RzCdEBvtgrDhFFzkB8UeYH9ID74/8Hbagd/QWj9Gm9TLR
	JhznpuYP9JF0HHQJ65qWbxYkuEwp+5KuNAyP2Qz3jb0sonFtcXg5X+H4dy0KRZb7TDNsKnCk+AQ
	HLuoVcTuSK425Hap77oI8iDssfokl5TA+hZZGH4mC/5tA1Fy403tP6/TVkhs6FrGnLMQ=
X-Received: by 2002:ac8:594b:0:b0:517:6fc2:4760 with SMTP id
 d75a77b69052e-52e2ec51d8emr50698261cf.9.1787652005170; Tue, 25 Aug 2026
 03:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825095000.1461124-1-dongchenchen2@huawei.com>
In-Reply-To: <20260825095000.1461124-1-dongchenchen2@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Aug 2026 11:59:53 +0200
X-Gm-Features: AcwNN1V-EzXrRmRaWmO_0qe4nSLjbdvGCIYz9Uef9t0_vVUJEyYq_ib2BfxP0Sw
Message-ID: <CANn89iJwWL9NdC19XbSFq7sf_tsZS96PTXWgO3oUMGJRkA0g-w@mail.gmail.com>
Subject: Re: [PATCH net v2] net: iptunnel: fix stale transport header during
 tunnel decapsulation
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, kees@kernel.org, netdev@vger.kernel.org, 
	osmocom-net-gprs@lists.osmocom.org, zhangchangzhong@huawei.com, 
	syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 11:41=E2=80=AFAM Dong Chenchen <dongchenchen2@huawe=
i.com> wrote:
>
> Syzbot reported a crash in qdisc_pkt_len_segs_init() caused by a stale
> transport_header offset after tunnel decapsulation.
>
>
> The issue is completely latent until qdisc read transport header in
> commit 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()").
> The crash requires four conditions to line up:
>
> 1. The incoming packet is encapsulated and carries GSO metadata. The oute=
r
>    transport header offset is stored in skb->transport_header while the
>    packet is still in the outer tunnel context.
> 2. The tunnel receiver strips the outer headers. skb->data is advanced to
>    the inner frame, but skb->transport_header is left pointing to the
>    now-removed outer L4 header, so it becomes a negative offset relative =
to
>    the new data.
> 3. The inner frame is not delivered to the local IP stack. Instead, it
>    is forwarded at L2 by a bridge or HSR, so ip_rcv_core() never runs and
>    the transport header is not reset to the inner L4 offset.
> 4. The forwarding path calls __dev_queue_xmit(), which enters
>    qdisc_pkt_len_segs_init(). That function computes the GSO header lengt=
h
>    from skb_transport_offset(skb). Because the offset is negative, the
>    unsigned cast overflows and pskb_may_pull(skb, hdr_len +
>    sizeof(struct tcphdr)) reads past the end of the skb, triggering a
>    KASAN fault or page fault.
>
> The issue specifically requires GSO packets (shinfo->gso_size !=3D 0), wh=
ich
> are processed/aggregated through gro_cells. Fix this by clearing
> transport_header to the ~0U sentinel in gro_cell for all tunnnel driver.
> GTP does not support GRO/GSO, drop the evil GSO packets in GTP directly.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69de2bee.a00a0220.475f0.0041.GAE@goog=
le.com/T/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> ---
>  drivers/net/gtp.c      | 5 +++++
>  include/linux/skbuff.h | 5 +++++
>  net/core/gro_cells.c   | 2 ++
>  3 files changed, 12 insertions(+)
>
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 9a12cc53da00..fbf617b1acc9 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -312,6 +312,11 @@ static int gtp_inner_proto(struct sk_buff *skb, unsi=
gned int hdrlen,
>  static int gtp_rx(struct pdp_ctx *pctx, struct sk_buff *skb,
>                   unsigned int hdrlen, unsigned int role, __u16 inner_pro=
to)
>  {
> +       if (skb_is_gso(skb)) {
> +               netdev_dbg(pctx->dev, "GSO is not support in GTP\n");

Patch looks good to me but there is a small typo here.

                    netdev_dbg(pctx->dev, "GSO is not supported in GTP\n");

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
