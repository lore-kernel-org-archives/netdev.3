Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9883D35C1AD
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718680; cv=none; b=t0F+bhutw3owcF7DxyOicFKZvK7qttkcl31hja0SfgW7S2fmNx14P9RgQEqQb+YO6EofEs3ovzTOenwOQsQ3/JS+X83lbRNf7eFxoDNQJFrtQU46Xs6p42Q51QTwSaTw7Ujnt6y/5RoCOmDneITJyoJpQRdbpvFnz0LcBS/Lno4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718680; c=relaxed/simple;
	bh=I35hEtDrAXhoNI0mxRcc1f7Z9oY6fkjujWvXDnGY9Yk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rXcfVEO9/QQGGmFUua9RWqFEt1WOLUBAqjxlvCJBKZAsoK+QD2JStjvVoI+Nwn3QNQU0nyqHGy9QG1kZbdbTop4GNfAH2LGvL0psMQKF/mVsMhss2BV3NCsrAjLH7sjIVwyXfupBNKMM1JtzWyd2QalkI07GOo9mlklGlW9U6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=jtX1l+EW; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="jtX1l+EW"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51a14efe25fso34167201cf.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 00:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782718674; x=1783323474; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uk2iJJWg07hdPaXD839hIa4BGV53hv+EQb/4KoaaWM=;
        b=jtX1l+EW9DiqnexjzSYQA92HE/nesR9+tpb6xMRZdlQ6dS1ACXRwpE9KL/xqmFjmh3
         yzdl++1v1znJ+YKVZvywxYFVbAkLvqmSmkejEb4MCca4o3qdstApdDUe8Yos+otHj3FW
         ZNAqp+bW7uYDlTq5wuujMb59hxIBuCLisgyTrDLo7ug+CnZWncA5U4zoOw0vXyxnzgek
         vKdiO6FqhYiN4cfScyBpRz6/QKA0bwZZL1xjpFunqQspcNcUqB2QU4Q3CbQoOVXb2BSd
         9H2MJNbI45/2Fl6nhw1JrohxthUSq25JqCsIgkDdan8tfv3NfX+jXukLOzxhkrmWbfps
         UjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782718674; x=1783323474;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uk2iJJWg07hdPaXD839hIa4BGV53hv+EQb/4KoaaWM=;
        b=X9Q80U/7cuyBqMSczP8a53B2FtaK0DmLhr/FMkt4i5LF7YEP+JVeSW66vafiHh2tzj
         GCdauKjLs5QH7itLLj3Y1UrACh9V8UCbnjyhLsm0rUFISob8ypyUVBYu1hP+vt4dXqfp
         pcNR59ESXfAhyq13SzhrkuQLikSpQf6fgiUk2cUqyB7eLh8NHMHb5wIzwfK/ThkDZppf
         X+eIyIngUpFQ3ibZMVxPIEWjLzxO4HwruDkH/u5mvhEiOl1IgAmEepU0XkRxFVm/9Tdo
         C7Ra8aijPzXJ34usQg47p4Nx2IPaogz9y/ydLrUO9TiKVb+oYGd8qlA3sHbrMbBk0koW
         tMaQ==
X-Gm-Message-State: AOJu0YxNPFF+gxqP4F3D0oDYa3jIG7hosSQtYRvpoNyVeSGTm6YeMt/+
	JCgcr5oni1BD738/eEJ5vGj5Iqkhot1Vrt+Z+vqyxeedtN2P5WJS8Bt3HX/+YRwyXYs=
X-Gm-Gg: AfdE7clubWEeO66K8+VkfMuIIU4K/RnmTf6ItCuVXoNnP+Au5aRdsL+5WRMvNHjZWX+
	pDaFAHa54OLm0TL8n8xFDOVRoQaJHUEOnnzKa9UGVE/92p+iHkPo+iXi/Bqo/GNHetJxRYqrIuO
	swu0LJoPtF5r4XjCbP9GDE7pIEO1PaNpkkraBxA+cRT5DMNdfHHU7PT8J0IbCAPMfVzYSlXLpB+
	JSIgKLYa8zva6zZWmMbgw3mlWyIiTcQpYeu0Y0bNjLtcua0cw5Qb6Y5G/erqYKCPgeM6Sjx6RiF
	24L04btT+dlUtgDOZRgtGDBmJ3BLnqrAw9pWEJ1ixmGcW+HFMg/S1TYblXohIhJjf2YGjsi6tHr
	UiMVG2naoi8DjWAQ1/AU3mz4P0byTq64+NZD1GqrMhBhqk9BLnO944NIpT8h+/tCfnDd8Jy6STq
	2piCGyfhOBk3s=
X-Received: by 2002:ac8:5f0e:0:b0:516:de71:e216 with SMTP id d75a77b69052e-51a72763cc0mr219264161cf.1.1782718674154;
        Mon, 29 Jun 2026 00:37:54 -0700 (PDT)
Received: from localhost ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51a9b10esm159580571cf.15.2026.06.29.00.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 00:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 03:37:51 -0400
Message-Id: <DJLD0ZG9V0D8.HLAXEIVG8HSP@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, "Ben Cressey" <ben@cressey.dev>
Subject: Re: [PATCH bpf] bpf: tcp: Fix use-after-free in
 bpf_iter_tcp_established_batch()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>, "Eric Dumazet"
 <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Martin KaFai Lau"
 <martin.lau@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260620-bpf-iter-tcp-refcnt-v1-1-883bf9e69495@linux.dev>
In-Reply-To: <20260620-bpf-iter-tcp-refcnt-v1-1-883bf9e69495@linux.dev>

On Fri Jun 19, 2026 at 8:32 PM EDT, Jose Fernandez (Anthropic) wrote:
> reqsk_queue_hash_req() publishes a TCP_NEW_SYN_RECV request_sock onto
> the ehash chain (via inet_ehash_insert(), which drops the bucket lock on
> return) and only afterwards refcount_set()s rsk_refcnt to 3.
>
> Lockless readers such as __inet_lookup_established() account for this by
> using refcount_inc_not_zero(), but bpf_iter_tcp_established_batch() uses
> plain sock_hold() while holding the bucket lock, on the assumption that
> the lock guarantees sk_refcnt > 0. That assumption does not hold for
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
> refcount_warn_saturate() then saturates the count, the publishing CPU's
> refcount_set() clobbers it, and the socket is left one reference short.
> When the last legitimate owner drops its reference the reqsk is freed
> while still reachable, leading to use-after-free panics in e.g.
> inet_csk_accept() or inet_csk_listen_stop().
>
> This reproduces in seconds with tcp_syncookies=3D0, a handful of threads
> doing connect()/close() to a local listener while others read an
> iter/tcp link in a tight loop.
>
> Use refcount_inc_not_zero() and skip the socket on failure, the same way
> every other ehash walker does. The listening hash is unaffected as
> listeners are always inserted into lhash2 with sk_refcnt >=3D 1, so
> bpf_iter_tcp_listening_batch() is left as-is.
>
> If every matching socket in a bucket is mid-init, end_sk can stay at 0;
> advance to the next bucket in that case rather than terminating the
> whole iteration on a stale batch[0].
>
> Fixes: 04c7820b776f ("bpf: tcp: Bpf iter batching and lock_sock")
> Reviewed-by: Ben Cressey <ben@cressey.dev>
> Assisted-by: Claude:unspecified
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  net/ipv4/tcp_ipv4.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fdc81150ff6c..92342dcc6892 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3074,25 +3074,25 @@ static unsigned int bpf_iter_tcp_established_batc=
h(struct seq_file *seq,
>  {
>  	struct bpf_tcp_iter_state *iter =3D seq->private;
>  	struct hlist_nulls_node *node;
> -	unsigned int expected =3D 1;
> -	struct sock *sk;
> +	unsigned int expected =3D 0;
> +	struct sock *sk =3D *start_sk;
> =20
> -	sock_hold(*start_sk);
> -	iter->batch[iter->end_sk++].sk =3D *start_sk;
> -
> -	sk =3D sk_nulls_next(*start_sk);
>  	*start_sk =3D NULL;
>  	sk_nulls_for_each_from(sk, node) {
> -		if (seq_sk_match(seq, sk)) {
> -			if (iter->end_sk < iter->max_sk) {
> -				sock_hold(sk);
> -				iter->batch[iter->end_sk++].sk =3D sk;
> -			} else if (!*start_sk) {
> -				/* Remember where we left off. */
> -				*start_sk =3D sk;
> -			}
> -			expected++;
> +		if (!seq_sk_match(seq, sk))
> +			continue;
> +		if (iter->end_sk < iter->max_sk) {
> +			/* reqsk_queue_hash_req() inserts with sk_refcnt =3D=3D 0
> +			 * and refcount_set()s it after the bucket lock drops.
> +			 */
> +			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> +				continue;
> +			iter->batch[iter->end_sk++].sk =3D sk;
> +		} else if (!*start_sk) {
> +			/* Remember where we left off. */
> +			*start_sk =3D sk;
>  		}
> +		expected++;
>  	}
> =20
>  	return expected;
> @@ -3129,6 +3129,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_f=
ile *seq)
>  	struct sock *sk;
>  	int err;
> =20
> +again:
>  	sk =3D bpf_iter_tcp_resume(seq);
>  	if (!sk)
>  		return NULL; /* Done */
> @@ -3167,6 +3168,10 @@ static struct sock *bpf_iter_tcp_batch(struct seq_=
file *seq)
>  	WARN_ON_ONCE(iter->end_sk !=3D expected);
>  done:
>  	bpf_iter_tcp_unlock_bucket(seq);
> +	if (unlikely(!iter->end_sk)) {
> +		++iter->state.bucket;
> +		goto again;
> +	}
>  	return iter->batch[0].sk;
>  }
> =20
>
> ---
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> change-id: 20260619-bpf-iter-tcp-refcnt-107d52b238da
>
> Best regards,
> -- =20
> Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

