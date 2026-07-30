Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2C5382374
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439939; cv=pass; b=L6uB9cGFEZDcRsf3HJgc/JvLLX2kHqLnrbPGhrWLhfzkDy0TQEMPxtIiVz53qaSAqVlvByskMAqGV0eKXwpT6/Gwlm9I7fl4u8tyXknCo4mPKtR5D8UT5H49gyRsFUi09N+BL2I5SASpcc9V+ENe97wlJ5nAMi8sTATcbzbKhj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439939; c=relaxed/simple;
	bh=DK/g9HGiwujQvga8UGjnMgDszG7rPVQXpTQFTfVRzxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpNk807Fnte5es+8ITLDkN/ze3FcO4NSGgzHq/YpGMuSo9rm0HIFSbYN5TShJF18otBKk6ERlYHc3AuleWH+Wx+8QrLHhenMSWtDAsi2QKpBdsSN3d5ePYAZzmLDDwk9e9GqGtODfWtm3IC7nU6w57qIuhHzVMOQol/+RQNLvDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iqrEPwXH; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqrEPwXH"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so138760a12.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 12:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785439937; cv=none;
        d=google.com; s=arc-20260327;
        b=TqbZuiyso//s1FZg6WbFP4TM+y22jxdLKrRamZYZomiaLnHurIN1u+PY/pIQwqDNHe
         I2sPQ1PyKo6Og/Tmn5CBChr4Z8Jl5crIy7lcvKvhHsMAHTIlKbdVoK2ZZigGg8bgMu1P
         5ik0N0rZLwIvwjyXMnMZxCJ90MFu+KAEW8kmMrHdIYzzRxpvLyHTuAtdyT4CdaX1BtQA
         rHkl9zcTaavN49ZOVWkgWDDRsGyzKR/h/xfs6jz26LmeocMCpYIwfhV+FSxlmUz+zYp9
         0jc2d2q/4Y26VtLY0V7xaOrhxSTfUWn9giEtZLJLVivwm1033u7KJD0yf8eagtyDW0Lk
         44YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=539G3MfpOQFgDBlbUA+JKO67DRjrN+PwaHPXmaEuLFc=;
        fh=HFCb8J9W81nZj9f3hlYl/51lEUAOKjTWUlJBBfcghoQ=;
        b=e9bQy+Zq3NK5DrultbYMK3BIRQE83iQzO2+noGPWJgyGV7cs5LGsRsc0EukvQzKOD9
         2vLgohhxy/LY/NfKAd5Dn1J/yAPdPaeBHto7Bp28BXMVl6ZIVR2JRyzcSXLXfsgvZyLw
         RPQ6XT3Etkg6ZN8iA9BsSUS2QZoXA+kegs83VBVOCW0rdbpmNlNqevRJCRQXP0iNb8n5
         PZpxtlpao+v4cO3zOFCIu0EEcAELhIv/YhA2YHIIquWRQoFjApRO9KbhOcjGhzJoAGni
         wpq1Ak8GaTYfJTTS0hFcUq9PWO2zp55prvd9trVB6mc+vWJOig2nJIxO4baif5yDN7yR
         RBqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785439937; x=1786044737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=539G3MfpOQFgDBlbUA+JKO67DRjrN+PwaHPXmaEuLFc=;
        b=iqrEPwXHzwZVkHi9zmHMB9eI/LgUXGsIeQKRUVYU4SaNSKruONDhzbLFQRTTZkmLzY
         twu0xDmcbLohaw9UAZssRD79fxIciZvki+CXBDDh87xKfrDZvXgdQZhmusK8AH/t8reL
         Ltd5z0Xg6scN82F+vSKHnTWF5YDMjzgidNv92Gdv2mUg/Ryc4ljuO0vrDrkAcYSvjUWw
         nWpqIsuDrDopvyNJLjgH1F0BRfDVuB0EDeKjQW/rkNXXul++wVcoviDjWjID4TP+0cu9
         jzBv7m5D4pLp8RFvO6NObQDCTZGwL2TW+K9Em8cU0UWIzf9nP1xNOPzGaXDHU02wPkOL
         Guyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785439937; x=1786044737;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=539G3MfpOQFgDBlbUA+JKO67DRjrN+PwaHPXmaEuLFc=;
        b=NtUfY91GW7LWg2HxA1gvDbERWExy3ZuIoDMbUNzkk2BawUfPrZQul5vt8fSEDEe309
         1pooJHRi1/iotq1g39IHTW1kxXDGWp0l5cyqxTO7cRbO0hT6y4xVGUqZrkf4mb1cwMrZ
         rbk6vVFdWTUC9GSwqQc8tk2upRzhPeWUE7bZkMTyT5J3N5cJMU+jIi+IUeZlLrJBDfj6
         nnH/h7m6+4s2NdXmyy0n02rd4Z7hKbSBLQzpaAGY4sV6u0iPlP0zsBX+obyoF1m4FzeI
         aChc7uSm09qKsoDMKoJCNA2Ug1l+6wUsa+RVB2dibATW4OMiCmWVR+jmDHtijVjGpRy6
         qqpA==
X-Forwarded-Encrypted: i=1; AHgh+RquQNVk5AL/4xoygqxXzzY1o9LurE0FZnrARPWjrLwrPPSg5Moe+cKZ5E3QBXVNiPhrkBapIoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAxg7XN09i0MZJPI7zdZ3QlKsiR/RZchqMLqGYMMaXVO9eWVHg
	n7U8VFPSbsXVc2FTd3ZnuWRd9iJP+XZkUPhW3J3YjRu5SpBcrlgSJPjksiYfd9RGeikIruLAGP9
	DePRD/HE6c4LRd46ROlKA/sL10jeva8xZxy3iPUWg
X-Gm-Gg: AR+sD12E2pD1JypxZmi4xz30nKa355SkgdZAv0aBoiUffmsW9Z6rC86kko4nmVCo6RR
	gZmcl8EVr0OW2sg4dEDGi4WhurLMOHarQw5yeJe6ZVh2Gls1XgzHVkIomEPz5zS2uJ0OYVlzzPq
	ysrJTVKa+8wRl5TaadIY7ToZA3X4lGfCGTGXLyC4XaMptL/F89yPtyb+oUnRYQtfhfam1d/Dzsg
	dgTa6H/7dvxGrXBO8N0cuvV9m5WqI8Zx/Z4koYrgfv9nSBL5GgrjiC07LyyfJc2LvMDtUtNP6/R
	4ZQT/TPwfUXxrVwXj1EXv72JRi4tdSqkshfc6fYJRepV4ypw9Uu5492V0aRogHplleVvJyfFxJH
	hiu0Cs0RM0vg7a53JqICzuPX/edAClPLMzFSL4mENUxWxulzmoMIXBT9itQ==
X-Received: by 2002:a05:6a20:430b:b0:3bf:82c5:ed13 with SMTP id
 adf61e73a8af0-3c9008ccb8cmr3209498637.38.1785439936000; Thu, 30 Jul 2026
 12:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717-bpf-iter-tcp-refcnt-v2-1-8e81f0ac6f3e@linux.dev>
In-Reply-To: <20260717-bpf-iter-tcp-refcnt-v2-1-8e81f0ac6f3e@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 30 Jul 2026 21:31:58 +0200
X-Gm-Features: AUfX_mzHgCmfHLQq6ZHn9xe7HlXcHqZtAH2pGA_WKTRq5Th0ZTgkIMtXbrbpp84
Message-ID: <CAAVpQUBhTZWg-ZSzmj-Ld7mXBaven=qsF+2Om6q1ueCwLb-NgQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 4:34=E2=80=AFAM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> reqsk_queue_hash_req() publishes a TCP_NEW_SYN_RECV request_sock onto
> the ehash chain, drops the bucket lock, and only afterwards sets
> rsk_refcnt to 3.
>
> Lockless readers such as __inet_lookup_established() handle this with
> refcount_inc_not_zero(), but bpf_iter_tcp_established_batch() uses plain
> sock_hold() while holding the bucket lock, on the assumption that the
> lock guarantees sk_refcnt > 0. That assumption does not hold for
> request_sock:
>
>   CPU 0                                CPU 1
>   -----                                -----
>   tcp_conn_request()
>    reqsk_queue_hash_req()
>     inet_ehash_insert(req)
>      spin_lock(bucket)
>      __sk_nulls_add_node_rcu(req)      // rsk_refcnt =3D=3D 0
>      spin_unlock(bucket)
>                                        bpf_iter_tcp_established_batch()
>                                         spin_lock(bucket)
>                                         sock_hold(req)   <-- addition on =
0
>                                         spin_unlock(bucket)
>     refcount_set(&req->rsk_refcnt, 3)  // clobbers saturated value
>
> which surfaces as:
>
>   refcount_t: addition on 0; use-after-free.
>   WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x48/0x90, CPU#1
>   Call Trace:
>    bpf_iter_tcp_established_batch+0x14e/0x170
>    bpf_iter_tcp_batch+0x53/0x200
>    bpf_iter_tcp_seq_next+0x27/0x70
>    bpf_seq_read+0x107/0x410
>    vfs_read+0xb9/0x380
>
> The iterator's stolen reference is lost when the publishing CPU's
> refcount_set() overwrites the count, leaving the socket one reference
> short. When the last legitimate owner drops its reference the reqsk is
> freed while still reachable, leading to use-after-free.
>
> This reproduces in seconds with tcp_syncookies=3D0, a handful of threads
> doing connect()/close() to a local listener while others read an
> iter/tcp link in a tight loop.
>
> Use refcount_inc_not_zero() and skip the socket on failure. A skipped
> socket is still part of the bucket, so keep counting it in expected.
> The reallocations are sized from expected, and a request sock whose
> refcount gets published while the lock is held across the last realloc
> must already have room.
>
> A skipped socket is counted in expected but never batched, so end_sk
> can be short of expected on a batch that is actually complete. Decide
> completeness by whether the walk left any socket behind instead. The
> WARN after the locked realloc checks the same, replacing an
> end_sk =3D=3D expected check that could not hold on that path since
> cdec67a489d4.

nit: please use the cacnonical format

commit cdec67a489d4 ("bpf: tcp: Make sure iter->batch always
contains a full bucket snapshot")


>
> If every matching socket in a bucket is mid-init (refcount 0), end_sk
> stays 0. Advance to the next bucket rather than returning a batch entry
> that was never filled this round.
>
> Fixes: 04c7820b776f ("bpf: tcp: Bpf iter batching and lock_sock")
> Assisted-by: Claude:unspecified
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
> ---
> Changes in v2:
> - Count expected right after seq_sk_match() so the batch reallocations
>   are sized for the whole bucket, including request socks whose
>   refcount is not yet published (Kuniyuki)
> - Signal batch completeness by the walk leaving no leftover socket
>   instead of end_sk =3D=3D expected, and check the same condition in the
>   WARN after the locked reallocation
> - Drop the Reviewed-by tags given the code changes
> - Rebase onto bpf/master
> - Link to v1: https://lore.kernel.org/bpf/20260620-bpf-iter-tcp-refcnt-v1=
-1-883bf9e69495@linux.dev
>
> The pre-existing double-put on the realloc failure path (raised in the
> v1 thread) will be addressed in a separate follow-up patch.
> ---
>  net/ipv4/tcp_ipv4.c | 44 +++++++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 209ef7522508..d8640d114c0d 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3073,24 +3073,24 @@ static unsigned int bpf_iter_tcp_established_batc=
h(struct seq_file *seq,
>  {
>         struct bpf_tcp_iter_state *iter =3D seq->private;
>         struct hlist_nulls_node *node;
> -       unsigned int expected =3D 1;
> -       struct sock *sk;
> +       unsigned int expected =3D 0;
> +       struct sock *sk =3D *start_sk;

nit: please keep the reverse xmas tree order.

see: Documentation/process/maintainer-netdev.rst



>
> -       sock_hold(*start_sk);
> -       iter->batch[iter->end_sk++].sk =3D *start_sk;
> -
> -       sk =3D sk_nulls_next(*start_sk);
>         *start_sk =3D NULL;
>         sk_nulls_for_each_from(sk, node) {
> -               if (seq_sk_match(seq, sk)) {
> -                       if (iter->end_sk < iter->max_sk) {
> -                               sock_hold(sk);
> -                               iter->batch[iter->end_sk++].sk =3D sk;
> -                       } else if (!*start_sk) {
> -                               /* Remember where we left off. */
> -                               *start_sk =3D sk;
> -                       }
> -                       expected++;
> +               if (!seq_sk_match(seq, sk))
> +                       continue;
> +               expected++;
> +               if (iter->end_sk < iter->max_sk) {
> +                       /* reqsk_queue_hash_req() inserts with sk_refcnt =
=3D=3D 0
> +                        * and refcount_set()s it after the bucket lock d=
rops.
> +                        */
> +                       if (unlikely(!refcount_inc_not_zero(&sk->sk_refcn=
t)))
> +                               continue;
> +                       iter->batch[iter->end_sk++].sk =3D sk;
> +               } else if (!*start_sk) {
> +                       /* Remember where we left off. */
> +                       *start_sk =3D sk;
>                 }
>         }
>
> @@ -3128,12 +3128,14 @@ static struct sock *bpf_iter_tcp_batch(struct seq=
_file *seq)
>         struct sock *sk;
>         int err;
>
> +again:
>         sk =3D bpf_iter_tcp_resume(seq);
>         if (!sk)
>                 return NULL; /* Done */
>
>         expected =3D bpf_iter_fill_batch(seq, &sk);
> -       if (likely(iter->end_sk =3D=3D expected))
> +       /* sk carries the first socket that did not fit in the batch. */

nit: please remove this comment since this is not always true,
e.g. resume function does not find the old sk and moves to the
next bucket.

The change itself looks good.

Thanks !
