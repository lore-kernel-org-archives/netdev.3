Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793983973;
	b=NPynARzRrcZoCAhnHlA2NxW2D5KC2r+AqpEusGT04E6GDoj2q3NYQy7ryf/YieFE5ZCm
	 jHjZ8Mgtdf77Y1o5znGvTxWXKkaIlSsLzJin5u14u0f1MIBDN1mPI5CX90RDI/mFtPPDB
	 2kmWJ/i/x4M56gTssCX+hifsgdS2xlvwosANQU6bvZj8M8nDKm0uTneRlUh+6Dtv+Rfg5
	 sfgy1idCjJQRgA9rMbZeDnf94lzx+/Yg3bMHa93dgRIX6HJwKel3o6uPPjrIXuYb2BaJ9
	 jEymnhwx2W3ql22GszeZFda2YmDodaiLXe0k7x90wIeFUjeHeLKAvCshmgmF7lbR77w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YBkkwCMF7E0Jrr0hGSDv7wIrrEuUI75SMkeEZ3MS910=;
	b=YPCvIzoMlL5FVFFUcPX64d7uV9v2Z2L11uEosZYee0OOATfc8wsSBruYdcehxnXbitI5
	 3qaG1anO11LeV0eLTLEIlzA4FkK+9CXzPrLoi78yENnZSdwdovmk4mCQxKxhKePT+e8QZ
	 f/5F+I2uWKk8xrazgiy8u8TifqxMt4UPOVsvt9DKfviXTxs5eE8G3JuTeclCxs7eDPVQE
	 rGySdtT18inWh2IqwIbivW2dvR91INWc0kd8wsMe6NE03QwVVqqGKMrdayhO+fuH4JMNn
	 4yH1sSkUgHoz8GDbZ8NZXqNfeO13FlW0Pr75thqQlLRN7fU5xdbQeq5hETp+ZMEXm9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dL6TY56i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034ED606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 16:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 034ED606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dL6TY56i
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b2382bf051so394092b3a.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 08:52:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793983972; cv=none;
        d=google.com; s=arc-20260327;
        b=DUGrLfeNTY8JgbvtvN87Esml7A59CqUFQdwDgjClBx87k8RZvmjA7+aFaaUZAi2tbQ
         kFlHV1HkRo8st2/zyphXFg4cgIUP+CBXNvlcAtZmO2W5V+rI30mSFTAnOUzBg0dkmaea
         shyS4v7lSg0Plo/CtGYecPW4z0qSqd+qDftSau3/Xfz7v+jplbA8TzeU6Av9+UCWP4Gu
         rq/KUj6YHF0hcQYobUaZt2I0ndMbdPHv28tvv1pYUSBu03ObT/l06N1FImKfY73N89Xc
         DocjICRDa8UFIPzE3/btW6PN09NRlAqxncfDF7phw3kWBmEDQT9rgRyFZNsW8eAFoKA0
         WzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YBkkwCMF7E0Jrr0hGSDv7wIrrEuUI75SMkeEZ3MS910=;
        fh=jh6dO4Fw3OVKv38heGfW5wur2/p8Z9REhgwz2A3HzmU=;
        b=kZERRE21UjkYfUKi3Y0ij3yblRD/hLGC2M3ohsNWI4yTAC9squUB9j30DPsq3prOWC
         jXv3LhVxLxqJUzMeGUzy/0r+h/HeA+32DmP0pfIm7gp5torbs7zuQdLw/XqCCp7ZZHWU
         UBEhwjIUJqrD5OPPOWVlantvkRqSm1RxmM5McVxX28PLg6rcxYuad4W0Xh9esgyFLxCv
         nzBNQcUqwmZa2tIMaIItJmKL6p1YtSuNBMuauCt1ErHU3Rnec8J2ee8VbH5iH/6OiHhN
         2yaxMcMHj+d2/cZNkOwDRbbldZz1q+2Vyix313jRhCbcjPp62YooFrcJYLE/YuPDeo+5
         XJpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793983972; x=1794588772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YBkkwCMF7E0Jrr0hGSDv7wIrrEuUI75SMkeEZ3MS910=;
        b=dL6TY56iWpuzVc7nEVJB/x0qGy9+4rTnmHP0Lkj8oQQUEI4PMurPzQTMRoD1feFOac
         qkcbp8QHG0pFmzPO6oJO/ESGRQfCM/OF4Gh00a4s3z6n+5LF5c9pB8AMzWkv89YNiUYC
         IwPAKbcREGxQkfHjNo1zZZGU4oMhqcPhcA3kH5xKSzsClm8DMhTO/+1DhWoSDn1X4Iif
         B44ee27mIf9/7QzSGmLjHbtIR0PQtnOUxNu1TChGUvroDil4A1h3OCef4QNr/nnv49cY
         8IgbchaB3CAgGt/TvHeQjPttvRTgQKhNV8Wu9eF6d9e3JmAAECdlzn3vSjXLhbc2SkRQ
         0cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793983972; x=1794588772;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBkkwCMF7E0Jrr0hGSDv7wIrrEuUI75SMkeEZ3MS910=;
        b=0Hy/ELRzpboNofRtGlOS8CH/9cz3srxCvwNgpCA5qOCPRgrD1CZ7BI2PgiVoUZb6Iw
         VWBIfPTHm7K2SXpJkHr0TXDyGseEZsYsH+erhlVwqFdcZRyXFWujr3hTVmppeXkVlsdF
         6jgIQZOHYOLNBoOHZp2S+v9N1hk2YYNMKhlpmH/gK3PTasXZ1MdoGT9iY3XQtS2RXxOb
         YXz8GEwFPl72mkUVmlUd1462+odSDtiE8eR41P7hwKlTRghf3qwrkeh3FZvxc5Djs6U8
         5tBSZzd5406zkfyBSDNEBR/DtQvpyiV0kwx7/jOb2nOuzkb6dumpsvQcIbTaEJVpbADP
         6FrQ==
X-Forwarded-Encrypted: i=1; AKwUvBycPxKp5g32bxSBGnHCvOyE9WWW6V0y72Nsg+6djDxUUXowrc3v5r6gEi/EdaEdCZTUYSpFFiM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XBqKJqtRD/iuW5jk/1eouwv8I2n28d8wfqZDmxVzrnnOs+lDI
	MaCIuiFUuYMESFIom/L9dedrrUtbHq1GGw4vG3TzCjMzDehp5A277+CDauFqS51p5okv5NQt3Ox
	REhPABdS1I5PI0hSEX47/bEHqoolNfmo=
X-Gm-Gg: AYBFou2a/wypjsoVrGZ4wEDmnL5u/qH4EN+BwB9kNHrKtY8fAgluSk+TKySHNJkI/Eg
	v8ATNCF+WqsjM9kqUfxLj8g9zpUP4JuK2x1rM7bCkRQpn7yylFXw+wqC4Tcvlp31iryCA6RKEj7
	B0OTeS0inNj/YGBj0JYbIXRaUpBoAnKiaWz3XSJpaf4jQHOn5cLQ1lPbQZey6+ue3k/fIFVhSpd
	qQgm6i+Br+pKD7jZE8c+DkcuBNI170z3hfTkzDmLzV0O/50Qu+mjEmNI/U3CJGbu+IEO5Ntxt4J
	QDob6nzI/pl4cprtpInewL271ldEdrpXpOhfR3R0PFT5SmiMFGlO+mtDhgX9WZIeBbaiGdhUWYB
	SWwEzLcefwo8pVjh6BxMI2jYX/sRzZP+k/XeQGYNpQhsOSwEvU8iBqmYRHpFvzbcIeBsY28Dk5D
	G7B3YA1o4VEv1wcOIzi+mF4eGshvOOPZlcNFw=
X-Received: by 2002:a05:6a00:2e9a:b0:89e:261c:447a with SMTP id
 d2e1a72fcca58-8b377f7fbedmr3041044b3a.7.1793983972138; Fri, 06 Nov 2026
 08:52:52 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104105507.62743-1-juny24602@gmail.com>
In-Reply-To: <20261104105507.62743-1-juny24602@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 6 Nov 2026 11:52:40 -0500
X-Gm-Features: AclHuK_1KtwGRGoHNYyrNVGPMWykc4PtFpxqqos5XP8fO0mNLCVDVrBCDTDX7UE
Message-ID: <CADvbK_eH6jY2GmpDKH-1+KtHHG_wERJtBezYCn83nPQ6Pm3mTA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: preserve stream scheduler across outq teardown
To: Jun Yang <juny24602@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	Jun Yang <junvyyang@tencent.com>, stable@kernel.org, 
	TencentOS Corvus AI <corvus@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 5:55=E2=80=AFAM Jun Yang <juny24602@gmail.com> wrote=
:
>
> From: Jun Yang <junvyyang@tencent.com>
>
> sctp_outq_teardown() reinitializes a live outqueue with sctp_outq_init(),
> which clears q->sched before calling sctp_sched_set_sched(). This makes
> sctp_sched_set_sched() skip sctp_sched_free_sched(), although the
> association's streams still retain their scheduler-private state. If the
> socket's default scheduler differs from the installed one, the new
> scheduler interprets that stale state through the shared union in
> struct sctp_stream_out_ext.
>
> Preserve q->sched across the reset so sctp_sched_set_sched() can free the
> old scheduler's per-stream state and clear the union before installing
> a different scheduler.
>
> Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
> Cc: stable@kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
> A KASAN reproducer for this issue is available if requested.
>
>  net/sctp/outqueue.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
> index e92fb9da4647..6cb4b4339d8b 100644
> --- a/net/sctp/outqueue.c
> +++ b/net/sctp/outqueue.c
> @@ -190,9 +190,13 @@ static inline int sctp_cacc_skip(struct sctp_transpo=
rt *primary,
>   */
>  void sctp_outq_init(struct sctp_association *asoc, struct sctp_outq *q)
>  {
> +       const struct sctp_sched_ops *sched =3D q->sched;
> +
>         memset(q, 0, sizeof(struct sctp_outq));
>
>         q->asoc =3D asoc;
> +       /* Retain the scheduler to allow freeing its per-stream state. */
> +       q->sched =3D sched;
>         INIT_LIST_HEAD(&q->out_chunk_list);
>         INIT_LIST_HEAD(&q->control_chunk_list);
>         INIT_LIST_HEAD(&q->retransmit);

This doesn't look nice.
Can you try initializing the necessary members one by one instead of
memset(q, 0, sizeof(struct sctp_outq));? like:

          q->out_qlen =3D 0;
          q->error =3D 0;
          q->outstanding_bytes =3D 0;
          q->fast_rtx =3D 0;
          q->cork =3D 0;

Thanks.
