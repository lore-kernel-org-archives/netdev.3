Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96885386C1E
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383333; cv=pass; b=dyNSF1Ix05s0WaVQ+A5KhdhoobXLL9vmMRctWrxi4Ptp30g21062mHvJgLY5h51BDT8Km7rVEr0jXL+BPcu2GXVhAarnpB/1ZQRilik2ZP0IdXrgn9KhSEL50IMThkJbxUhduwp1k1LmNvM584ivdXx9zMPCjqWroNc0s6Dbj28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383333; c=relaxed/simple;
	bh=83OM+ZzwBqa7cwrYDUl8bybUqf5wsaalrEjaBLUCVyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSeowEmOsRvTzgquCevogQVg227E5l/HUFm02rcFgo+k4IilDxoamDBrFddNzr0q7NxukMdXfmyj1YVQJYCUwFdZwKXlvG0vlBcuZ8CEdI+1O4Nw8aENTO5n1kSfUYgJz4N3U0auWuGSh00MyW4A0utp9us2fMSDLFUszoSDSyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fpg1E56S; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fpg1E56S"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cacef7d299so7385ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 10:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786383332; cv=none;
        d=google.com; s=arc-20260327;
        b=UIXKohhsZ8R5nSAspM0knrNdsyllLl9n5ebkM03KF/vCIB1IpLEMSuEiYR4ED/zc+N
         Tqj1WFWF2eHZp6NnlazjLgUvQfK4YhPnVpoNRQcAXrY4MUG+CTfvKZB745HdMuhUtYtD
         EpCo2AxWR/cj0EUaUtWvpGNO158Vb07wn7IABzwLkSTy5jSxctvN4PR4dPiZluGqygA1
         fRS8Xylq8gtr8YfcS3tlyztDNRoixqv0KKNv6XoNqlxcIACPpce0KxDD2SK3qM04lq6C
         sfmuHgs1WA/2D+9/6jVmaZj/sHvYvDZ5+QRBCfCnDC7NQQrr7Y6cw9fJcQ3cAq0Y9dul
         Btjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/YgXeISO2SBRzBurpPsKMrMG8HxjECkp46NJHBU6gTk=;
        fh=hzzKNC/K8wA1iOpmHmzqXHbSBy5E3LICNCjOjn1tYJc=;
        b=FaVShVP5H24AJA28T4x+UXQiPpyME/wgacf2n4/5vuujSklkqqhMuUZWsHKcPP9Sa+
         d9DZ4Hy5mgOGSD/3IRllUeW5PeYvuKrjU+P8sgHtFLvKiuyrYTWEfQwigeTtQkpI+K8Z
         HqWjc8v/uNXQ8LMUwuAip2KAfwUFE89TxuFcgJ8qe7E3KdEnNmCJ58HpsDuZHh+hI8Y/
         ahcWVQi2D5/vWSh+HgvQ/ohSkc1LmBuZCr0LAhgKcm5mp3P3Azo64VUsIQRi6D7UDHZB
         uJBTMoWeWC4Qh0mXTN6g1Qm2oyE+fMUiqwXWZVZ2HEXaqF7rsICBtLjtDpcMZkebfq9j
         P95Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786383332; x=1786988132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/YgXeISO2SBRzBurpPsKMrMG8HxjECkp46NJHBU6gTk=;
        b=Fpg1E56SIJuUUUF/qPjcHjm90y854v6vEBZt/RkPRRfEQ1sjiURIHtaegNMdGt5otS
         LHmwSd+nWZbZb+2jysooigZcGKxEeB8WfWdkJzfrpqhsoU6KnU1J4F3XiE++YKEc/Zyb
         3SwOF+PG2D/Ffx+XVT1MLcKp8aA1RQQwvdPqlxzPLtXo4ppvb706J4Uokck/1axpMPcW
         Aa9FMeg6juhQJQqA7SZ+kTsxdC9GJI1nl0DUfzMaGeIkVo+YNS//QOi1NisEDmhp8sHz
         xD62VPXikCADvwOCK2o6dBAjdhLPucKybVpl8KakRKmtjy5ShU3pf590j4S2f0iapnj9
         FNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786383332; x=1786988132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/YgXeISO2SBRzBurpPsKMrMG8HxjECkp46NJHBU6gTk=;
        b=DLDJSYNJW0Ycx5IctWIY0XiPe6olHvzDcu3H3Kt1nBpk4mitgol3IPoJIIICvt9dej
         0lwZYhV50zCnBBrEOHN5n+IulbbNjlOJ/I1xGRqOO8V5S0ufyHY9aACNg8Nko+5HzwrJ
         5bFMy+cMNJBt/vraJL0yowI7Mrx0i02TbJYuqbq9MGlC/Dr0dhEnoOARMamOxvHuDD46
         kF9HacpXWb8yW4PbC+8Odtk8JgFWcMu+SZcPlv/V8MxDURi0KcDrNcLEG7kNAN6dxPOA
         /8AbIRIacX01O/Ip507dEsrXTPt7PUzDKog41AVqhZxTEXkZbPDY1lgK80qeCwvq0QZg
         QK7g==
X-Forwarded-Encrypted: i=1; AHgh+RrGcxZXteZWLCchYwqITaL0bi4NDtYKLXzysLoSXVorgIIPHpsldZLnowhkZvfl3P74t8l1UuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGXZeUX1PijV5tF1fCvuHEBSDTXgKps9W7ikpDJe2QB4arFJhe
	P/2FdSLvG/6VQeAcfmxcAe95Qr+fqy5b+BRoTLBWkZFJXGtPpntzsN1qGHlvhphYgZgD+iwA0a4
	/C9YUr/nKYvG6mMRccND6BG8jh4Lll0+PQOqC76Bu
X-Gm-Gg: AR+sD10P7ExDOmWBMQmWhow4U/sJrjyX9vF3yOJxm8E3TApcgqD4OoFsoT2JjMKxF0R
	4isIK8UzRSj2tydR6maAZVuOn/Y85mUvVnYKTkM5vCOvhtd2K1NvLZKBi3vutRO+GEchNiIYho6
	Bs6poSxJheldOMH/t04+24Twq4oRe6l/HuzUZi0IIyCJ6WQkjoidkKaSMRcJnf9JWsHOB2UNEhZ
	untPwa/moV7kpWUS6SCxebcgD8lQN2b3vm/bNh3xfPwAL/ZrRH+abbDvXoaeXxENZzwIKvOGu47
	nJIyU7Kmf0fqfsByqvwCtn6qDBBbm6Z3Y+3R/vG3V5ZARXbKuFcfRXq/IOTItauh+33fhyP7TOo
	=
X-Received: by 2002:a17:902:db03:b0:2ca:4bb4:4bd with SMTP id
 d9443c01a7336-2d3108232b4mr346535ad.5.1786383331114; Mon, 10 Aug 2026
 10:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786108672.git.asml.silence@gmail.com> <f769116a3f5267f06cb9a9a819d482ddea2e0852.1786108672.git.asml.silence@gmail.com>
In-Reply-To: <f769116a3f5267f06cb9a9a819d482ddea2e0852.1786108672.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 10 Aug 2026 10:35:18 -0700
X-Gm-Features: AUfX_mzuy_QSJjW1U_c3IkRCXmj6khIsaNUIONuibsGj5y0tANytNqlwlv2Nwqs
Message-ID: <CAHS8izN4SAUCUQySd+VTbdayX-Stj+eYOqAof+Vhi=EsRb93_w@mail.gmail.com>
Subject: Re: [PATCH io_uring 02/16] io_uring/zcrx: move RQ head/tail to
 separate cache lines
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 6:25=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> RQ head and tail are currently put into the same cache line, which can
> cause false sharing problems when refill is run on another CPU. Put them
> into separate cache lines.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  io_uring/query.c | 2 +-
>  io_uring/zcrx.c  | 8 ++++----
>  io_uring/zcrx.h  | 7 ++++++-
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/io_uring/query.c b/io_uring/query.c
> index 88a325736992..4321f0b94b4b 100644
> --- a/io_uring/query.c
> +++ b/io_uring/query.c
> @@ -38,7 +38,7 @@ static ssize_t io_query_zcrx(union io_query_data *data)
>         e->register_flags =3D ZCRX_SUPPORTED_REG_FLAGS;
>         e->area_flags =3D IORING_ZCRX_AREA_DMABUF;
>         e->nr_ctrl_opcodes =3D __ZCRX_CTRL_LAST;
> -       e->rq_hdr_size =3D sizeof(struct io_uring);
> +       e->rq_hdr_size =3D sizeof(struct zcrx_rq_hdr);
>         e->rq_hdr_alignment =3D L1_CACHE_BYTES;
>         e->features =3D ZCRX_FEATURES;
>         e->__resv2 =3D 0;
> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index a096d44f7b52..fbc190075e2f 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -379,9 +379,9 @@ static void io_zcrx_get_niov_uref(struct net_iov *nio=
v)
>
>  static void io_fill_zcrx_offsets(struct io_uring_zcrx_offsets *offsets)
>  {
> -       offsets->head =3D offsetof(struct io_uring, head);
> -       offsets->tail =3D offsetof(struct io_uring, tail);
> -       offsets->rqes =3D ALIGN(sizeof(struct io_uring), L1_CACHE_BYTES);
> +       offsets->head =3D offsetof(struct zcrx_rq_hdr, head);
> +       offsets->tail =3D offsetof(struct zcrx_rq_hdr, tail);
> +       offsets->rqes =3D ALIGN(sizeof(struct zcrx_rq_hdr), L1_CACHE_BYTE=
S);
>  }
>
>  static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
> @@ -409,7 +409,7 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *=
ctx,
>                 return ret;
>
>         ptr =3D io_region_get_ptr(&ifq->rq_region);
> -       ifq->rq.ring =3D (struct io_uring *)ptr;
> +       ifq->rq.ring =3D (struct zcrx_rq_hdr *)ptr;
>         ifq->rq.rqes =3D (struct io_uring_zcrx_rqe *)(ptr + off);
>
>         memset(ifq->rq.ring, 0, sizeof(*ifq->rq.ring));
> diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
> index c1005f23caff..9ae0bf1c632f 100644
> --- a/io_uring/zcrx.h
> +++ b/io_uring/zcrx.h
> @@ -44,9 +44,14 @@ struct io_zcrx_area {
>         struct io_zcrx_mem      mem;
>  };
>
> +struct zcrx_rq_hdr {
> +       u32             head ____cacheline_aligned_in_smp;
> +       u32             tail ____cacheline_aligned_in_smp;
> +};
> +
>  struct zcrx_rq {
>         spinlock_t                      lock;
> -       struct io_uring                 *ring;
> +       struct zcrx_rq_hdr              *ring;

Is this not a problem in general for everything/most/a lot of using
struct io_uring? Should you make this change to struct io_uring
itself?

--=20
Thanks,
Mina
