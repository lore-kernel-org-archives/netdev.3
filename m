Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C367E37A486
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305312; cv=none; b=DTNLFEYZ3vhNg2f9tOxKyf6zeS1qua2G4EsvaMIsTxR64oIwjCOqFcoeETwAaz3Zm4aunS1NwY99Ez7nCyU19ep77H4AoxOKk5nGhwV5Vixlr4iAajaSQbi5FKIdUOERiwKb4z2FRX/g7eqAWKNvDK2sGNsWb3wjtd9Ve/rcX4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305312; c=relaxed/simple;
	bh=Nt9jUCfpL9SHefZJ+JX8jYz95zpvBQciVw9B/Vp2MJ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=A3yy65JoZpJlFBXT1DqLETNJ6aKxD5JP0D49F0lf/Hfo4KNchROZHsnFptwIv5fSXG7QS/a30aq/NM+gCZQp8l7GhzQPKs3mqtm7V2slyTVs0YVrKPkItrKt333E6fxIm2wjKPkAc4TTMpEnHrNioFbcNKmlvsWm/Xix5Fyw47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=PD6Dwls1; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="PD6Dwls1"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so400304a12.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 23:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785305309; x=1785910109; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sK/uHPOHKOSpL2rOWH/430U5Wo4SeZ5sprv1VG2eCss=;
        b=PD6Dwls1wCezmN6sm8uSN53WJAUFKZ6ifQTrDGx75mXl6qwoXyjH7X3XcX5FQXHxPM
         sONoVCRp3yGAcj7djnuqOUr3KsJEsKypxqy6LrsEBynHHMRp7yCXSQgZ2FIGvJdtpVbs
         zK+XfC907jjB7NYInQi8IU/ldmGPiE5BPqwcCu7pXn7Ujj/NZX9ICo/V0dL9yBVm/EA7
         5cbp+4cn8Nq1I1EmL36y52JlSIS/Yh6L++jQ15u3UIAq8t2o6CBCKE8WF5sj7EIZzot3
         EuLgUWH6HCsxGkDD7cUYbM4BF7PhCiaGIFLDeVadavpRhCp+HeNcROW1dov1NRf46USi
         UHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785305309; x=1785910109;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sK/uHPOHKOSpL2rOWH/430U5Wo4SeZ5sprv1VG2eCss=;
        b=pMYbcU/DCwlBXG+J0bGuNmC2PDUP+Xaei2B/Q4MFoQeKRrGSX+2GPDMNnHXR9EhKho
         0msVbztmzSm54MIs+NYdcIdtIjU3oaGlFx7giohwQoI9HVSRsciKQFxeXYEp6ajMCkK/
         WjI2JSJCei2Zw0ToP9pzaPCVIjps8Js/CEI6ueEpAyR0M/YHKtbkoSnqlQLvbxNBC0On
         YR2+d6jW2MvMAWA2AY7CF0Afh2Re+VEbTc0VyrkXNPKNWMr+4R39KRkVVSBIlEJJSea4
         jBy0fiQr7WM6kw71RK6LOZ48Liwf/ZV0fNibgY1GtHidGYdRXltAdMrrRE/4OG1z24Tu
         TNyw==
X-Forwarded-Encrypted: i=1; AHgh+RoLsZF4qxFgxEhuC2DI87TjRKBI9HtQiSk5DFtdh9tU/pe7lo398l0bN2d16K1ZjujBYUqb7AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ1M2Sm7NoqNhng03ub+f8apfiuWWSWWCN/DBo+MxbC6f5/xiv
	lb9t5gXQ3Vf7kwA3pqBkCEGPzlsfvGwWTjm9QMosAeDzMkikhXn4JqZ2CoapS1bpmN0=
X-Gm-Gg: AR+sD13mWLUbvFo7ztaJROMnO8MrFf8uxtWlei3GB2GEbno1Sw6DMwXOeXneswMI4cL
	tuB2oOmqRHEhrn2KASoneFaxvnkbfrAxUKxfC7s5/AYRDzB8MRpaheZTRljKnhxUNRJyV6DSEcJ
	/dEkV6t0OPCtUZQ2e6Its12RQAiIf0axcPjF/+2LgOu8MJCLfJqmFVbQdajFLtDhQL1dREGBX2T
	oTwPgVEdKEcIXG68w+YK9oVrAw6qmLZ4c/Mm8c/fkoHl5IzKY6bDqG/js26kF7YMvEfG8U4Ziua
	Yhq76MjYpdu/VHnCVs76EWMJOUGxIyoXmlyXEGRpywSSc8SAafhVH45IhEC7QJRpKwqKXJNiEwx
	vnZ57J9dOTaswY7pYy0FEgn1GnFIDwEUxvCNuHD7p3fGcgy2T24ZORPaAaJLjZqIVQiaBir1k2z
	tlYwOWNSCSguLqN5+pdTjAHC/SwFbCGcbP4FD18bPhzIavLq919yzpsArdbKwheUbxR+JnfLHem
	mFhAd5p8nroZCCN2w==
X-Received: by 2002:a05:6a21:3983:b0:3c4:4555:2c22 with SMTP id adf61e73a8af0-3c8ba5d8955mr6437918637.40.1785305309034;
        Tue, 28 Jul 2026 23:08:29 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb55c5b7bsm408196a12.0.2026.07.28.23.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 23:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 02:08:27 -0400
Message-Id: <DKATWVU2EXPJ.1QNREP4E46RY3@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Junseo Lim" <zirajs7@gmail.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Martin KaFai Lau"
 <martin.lau@kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, "Sechang Lim"
 <rhkrqnwk98@gmail.com>
Subject: Re: [PATCH bpf] bpf, sockmap: fix page_counter underflow in
 strparser SK_PASS
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260723065244.186916-1-zirajs7@gmail.com>
In-Reply-To: <20260723065244.186916-1-zirajs7@gmail.com>

On Thu Jul 23, 2026 at 2:52 AM EDT, Junseo Lim wrote:
> tcp_bpf_strp_read_sock() delays cleanup of SK_PASS bytes by
> subtracting psock->ingress_bytes from the amount passed to
> __tcp_cleanup_rbuf(). But when sk_psock_verdict_apply() queues the skb
> directly through sk_psock_skb_ingress_self(), skb_set_owner_r() is called
> unconditionally and charges the skb again.

Can you specify in the commit that this is about sk_forward_alloc (AFAICT)?
The eventual page_counter underflow is a second-order effect even if it's
what eventually causes the crash.

>
> The duplicated charge is later released independently and can trigger a
> page_counter underflow.
>
> Add a charge_skb argument to sk_psock_skb_ingress_self() and skip
> skb_set_owner_r() only for the direct strparser SK_PASS path. Keep existi=
ng
> accounting for the other self-ingress caller and for non-strparser SK_PAS=
S.
>
> Fixes: 36b62df5683c ("bpf: Fix wrong copied_seq calculation")
> Signed-off-by: Junseo Lim <zirajs7@gmail.com>
> ---
> Crash reproduced on Linux tree 94515f3a7d4256a5062176b7d6ed0471938cd51a
> with KASAN, MEMCG, panic_on_warn=3D1, and oops=3Dpanic.

Can you make a selftest out of the reproducer?

>
> Reproducer/log/config: https://gist.github.com/ZirAjs/16c95c89972ace73910=
d9b5ac78a5807
>
> The reproducer drives the strparser SK_PASS path until teardown reports:
>
>   page_counter underflow
>   Workqueue: events sk_psock_destroy
>   Kernel panic - not syncing: kernel: panic_on_warn set ...
>
>  net/core/skmsg.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2521b643fa05..17260681479a 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -586,7 +586,8 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buf=
f *skb,
>  }
> =20
>  static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_b=
uff *skb,
> -				     u32 off, u32 len, bool take_ref);
> +				     u32 off, u32 len, bool take_ref,
> +				     bool charge_skb);
> =20
>  static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *=
skb,
>  				u32 off, u32 len)
> @@ -595,12 +596,9 @@ static int sk_psock_skb_ingress(struct sk_psock *pso=
ck, struct sk_buff *skb,
>  	struct sk_msg *msg;
>  	int err;
> =20
> -	/* If we are receiving on the same sock skb->sk is already assigned,
> -	 * skip memory accounting and owner transition seeing it already set
> -	 * correctly.
> -	 */
>  	if (unlikely(skb->sk =3D=3D sk))
> -		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
> +		return sk_psock_skb_ingress_self(psock, skb, off, len, true,
> +						 true);
>  	msg =3D sk_psock_create_ingress_msg(sk, skb);
>  	if (!msg)
>  		return -EAGAIN;
> @@ -618,12 +616,14 @@ static int sk_psock_skb_ingress(struct sk_psock *ps=
ock, struct sk_buff *skb,
>  	return err;
>  }
> =20
> -/* Puts an skb on the ingress queue of the socket already assigned to th=
e
> - * skb. In this case we do not need to check memory limits or skb_set_ow=
ner_r
> - * because the skb is already accounted for here.
> +/* Puts an skb on the ingress queue for psock->sk.
> + *
> + * When charge_skb is false, the direct strparser SK_PASS path keeps the=
 TCP
> + * receive queue accounting in place and must not call skb_set_owner_r()=
.
>   */
>  static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_b=
uff *skb,
> -				     u32 off, u32 len, bool take_ref)
> +				     u32 off, u32 len, bool take_ref,
> +				     bool charge_skb)
>  {
>  	struct sk_msg *msg =3D alloc_sk_msg(GFP_ATOMIC);
>  	struct sock *sk =3D psock->sk;
> @@ -631,7 +631,8 @@ static int sk_psock_skb_ingress_self(struct sk_psock =
*psock, struct sk_buff *skb
> =20
>  	if (unlikely(!msg))
>  		return -EAGAIN;
> -	skb_set_owner_r(skb, sk);
> +	if (charge_skb)
> +		skb_set_owner_r(skb, sk);
Sashiko's right that skipping this leaves the skb half-configured. Since
the point is to not double-count sk_forward_alloc but we still have
to account truesize, can you try something like:

if (!skb_charge)
	sk_rmem_schedule(sk, skb, 0);

skb_set_owner_r(skb, sk);

to just ajust the sk_forward_alloc?

pw-bot: cr
> =20
>  	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
>  	 * data originates from the socket's own protocol stack. No need to
> @@ -1017,6 +1018,8 @@ static int sk_psock_verdict_apply(struct sk_psock *=
psock, struct sk_buff *skb,
>  		 * retrying later from workqueue.
>  		 */
>  		if (skb_queue_empty(&psock->ingress_skb)) {
> +			bool charge_skb =3D true;
> +
>  			len =3D skb->len;
>  			off =3D 0;
>  			if (skb_bpf_strparser(skb)) {
> @@ -1024,8 +1027,10 @@ static int sk_psock_verdict_apply(struct sk_psock =
*psock, struct sk_buff *skb,
> =20
>  				off =3D stm->offset;
>  				len =3D stm->full_len;
> +				charge_skb =3D false;
>  			}
> -			err =3D sk_psock_skb_ingress_self(psock, skb, off, len, false);
> +			err =3D sk_psock_skb_ingress_self(psock, skb, off, len,
> +							false, charge_skb);
>  		}
>  		if (err < 0) {
>  			spin_lock_bh(&psock->ingress_lock);

