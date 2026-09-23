Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26462F3C18
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790131810; cv=pass; b=kp9Ohu85oRgO94QT4KdRYuGZX73GIaIwS/3m/QqfxmKR1nh+tECh0z/0PDN528W5Tuh4t0duspvQgroeujIGA4jhcyOjZg9TzyupIX142tMZMa3zy0jX/pBo9gfHhr+Y0Ii8aOjWWcxy6jaEQE7fGp7RBwHBfm6Yj+WBVyU5qig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790131810; c=relaxed/simple;
	bh=IQ0cWZy/746zABNsy89D7JUk8iViS8IpcEBRF9VtPgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oq+lgy2kFNskFRThRA+/rRf92MScDbKeAfJxZmqJyIaC5N2MRYcQ5PfMj4RupArqQJ3nVK0/PwmDlHKF4yqEEeeaFZ+Nf41VeD5fTve8v5lN7a0bVH6jQ6nfsp19PpqTudPVyzsjVZGy/WSGvC+PqZX2V5IsQgAf37VXbG+hayo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lVmftrtf; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVmftrtf"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ca5aa7so50413785a.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790131803; cv=none;
        d=google.com; s=arc-20260327;
        b=NPDIJhM2GeyoGivrhNx6/YZBJ/WEgo6m5DfS+EYPqWL2SSs+uyr8BkmkakyuHUEdUK
         qc9YpIyhJxZisf6gLtJf9zQMfbr5S2Poj7+OSrWX72KjBuJ1+bfIVHEM98OMfYTwesEV
         qDy3w39/lqCuJA/cHDqnBhg+o6RVJQzTz0xcpUoHZFtQcVGFS7/R+iq6ou9dTeTpt6PW
         ukmT2kcQGGyqrZdNXqNNJe445w64hl5c6WQWOHQwL0A3l9JCZ2rWGCk35UI8UEX2iV7U
         x9rj+GfvOhkYEKup4u7TADAfoCb3CJwkyEdqd2w5YxWnk5blDVlIs0colcs+eKKxuMHi
         RRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ahITcPEdMmOc3JJPiaBSyLZY2TFXiiI2wkSsmdMgbb8=;
        fh=tW2FEzyvKIoDJOjdgv4CXsPuh6kvX0gZfvMeZLbccjc=;
        b=s5PJ2qrhpA/LoIn0EHumADdndXwKGad7bJpJwUzVuY1svAbJ8f2RmzNZd26X7EzyWu
         yE2vDsjTgv1bER30hBlmgFthDt8UhuwZSXG98VtTKydSu42khppnzw2z0QTfNUggilmz
         kS9wBCadR5S/auwWYsqPDCDB00ummflPWOGE6+iEb39sKS48+9sVog7Yfk3Io3GYPGk9
         KxAXFkR+wLCbOgTGlMnONZiTusH8+2QSHt5Td2pUYRPtLsEc+09mV+AcTKlD8VpCE8/3
         0RDr9b4qB4Hj3SIL7XnDdFJt30JAWCKibMn1pzG9Mu1wcHWSbDooMnHHEVGIk2ncmWVk
         abfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790131803; x=1790736603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ahITcPEdMmOc3JJPiaBSyLZY2TFXiiI2wkSsmdMgbb8=;
        b=lVmftrtfC4InQbSKF0dKG6HT6gdetPWktq6q6x63Fo2HmmkRjvOChE5fr7HlTEiCe6
         Wfp82L4bhyigwGqpNCix4wgJ8lz1n5odhA3mDVvUYFaykXf9NAZJ1NEfD0OI6vB9Gw3X
         xejTLYsG+sIxyOYQc/8Cn39/gG7zCrc3nCid5AvTEo914xDbqpD8KUNrvbE+NFoHuirB
         r7zXQ95YQ6+OoAPPguRmOQ2gcrlOI+yYN1f4RzCg4h3l/fWqoyFOcXDS55WqP1SN3aSo
         HkdgiWxItYDKh5J85fZYIfwMhznCjC6v17lYyEzwk5nnysZCAcCkHrweGwyaAbF8/Xx3
         /NhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790131803; x=1790736603;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ahITcPEdMmOc3JJPiaBSyLZY2TFXiiI2wkSsmdMgbb8=;
        b=wxE1BJkXi1Yrnp4qT4aJrl7TORPB/2SEFqLGgUd6T6H6xCFnkkXXfVHrTz7ZTiP+ao
         E/4owMKNUVJahhN98Z4PQwAGCZLiJOMExFJayusNi+e+Rj9acKrQqBIMIOa9aqjUET1V
         BF0wd7/9GIbbmKY7z2+ffZU7pF7YbPOjBQDR/Qy8eQi5dAemXPJSnsYJKbSGGF7GOjkm
         zwV0aErh70XOAJfb40kwKW+uLGG0M7RQ+mLmS7kpNDDLu78aemSzNlGPnUgFepjzr+cn
         mOdyBPIKTxJVyQLGckxIgDVKwGWFQjkA3N0vXn6kfOSYpVUK/GjxKe2kKK9yfH2Qx0TY
         c3oQ==
X-Forwarded-Encrypted: i=1; AKwUvBw0gua62vcLjhBsK26zbRSu3dcRLRRuHr52kkb9VrhVw9V/Do3K3rGMa0iKvog+dx8NSlV3uLY=@vger.kernel.org
X-Gm-Message-State: AFuF++m4Rp5j3O+7ODSqWNgmdX9ylC0bgA5NQE91nFPnd9T1vPKpyrhN
	kuQ6ZL7/uTZMFXOHLeiMdW3/kDOmrnS5qiFvlLQV3m35hiFktDx27r0DN6iPgRMzo+NAfUpg+Ca
	LFSWlZfDa2xid4ZcHeJRrpn9DMf6PQCcyjTsgx5oi
X-Gm-Gg: AYBFou3mHsoChZCOh+7jBCXU6UtTMHja9Rvi0jZj58E8dAmhO0BZFCEcs2/4qenDwHK
	DVhpD0xAOK7ThwR1iFuRPU6P480UVOaQf1/lOlNuU9de3+7bb/+KoWZXFnqb8zLNaln7mXJLIxi
	7+efpn/XhpnUDBe6Hu2gH+HHJN/jGKzeFpnpORRRJVhbtfkESmFb2uYoCv+rspxs4SAKvRaveB6
	pbZPBRY/aFkeuGwAZ6Xu3opJonNE+ux4vj+06yCocLSmpLBzrm0lk1T2q/CTHOEMuuOX6ILbX7F
	MS8Ilhc3Oun5DskzAasyGl8+QzbZTE6dl3a8eaa5aITNPxVNDWQws7OeHBcvDSbxX19Ze9c5pT0
	QpADfBKwr7iMe2vZh+bE9Mg6NutvYkeKMRf8mewaaLIFjibe5cj232cd/+Ep1xkJDzmR89Rk1cH
	fTELd8
X-Received: by 2002:a05:620a:4611:b0:93b:d79b:9a5d with SMTP id
 af79cd13be357-93c25244abdmr218707985a.62.1790131802567; Tue, 22 Sep 2026
 19:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920063419.3587332-1-yilinzhang@moonshot.ai>
In-Reply-To: <20260920063419.3587332-1-yilinzhang@moonshot.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Sep 2026 04:49:51 +0200
X-Gm-Features: AcwNN1XCmdXbebRsKWuOBAvRsGS1KJ9niS--Fs8T9NLqOwSIKM7sw4SwcUvumuY
Message-ID: <CANn89iLUNiEjX4U98=SsQWg5BSV7=cV6ZzwPBiDC4Hu-6US6Lw@mail.gmail.com>
Subject: Re: [PATCH] tcp: fix use-after-free of retransmit_skb_hint in tcp_send_synack()
To: Yilin Zhang <yilinzhang@moonshot.ai>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kimi Security Team <bug-report@moonshot.ai>, 
	Weiming Shi <shiweiming@moonshot.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 8:34=E2=80=AFAM Yilin Zhang <yilinzhang@moonshot.ai=
> wrote:
>
> When tcp_send_synack() replaces the cloned SYN skb at the head of the
> retransmit queue with a copy, it frees the original with
> tcp_rtx_queue_unlink_and_free() and only repairs tp->highest_sack.
> tp->retransmit_skb_hint keeps pointing at the freed
> skbuff_fclone_cache object.
>
> The dangling hint is read in tcp_verify_retransmit_hint() and used as
> the root of the rbtree walk in tcp_xmit_retransmit_queue().  An
> unprivileged TFO client (sendmsg(MSG_FASTOPEN)) can arm the hint with
> an attacker-supplied ICMP fragmentation-needed message, after which a
> simultaneous open frees the armed SYN skb:
>
>   BUG: KASAN: slab-use-after-free in tcp_mark_skb_lost (net/ipv4/tcp_inpu=
t.c:1316)
>   Read of size 4 at addr ffff88800604d928 by task swapper/1/0
>   Call Trace:
>    tcp_mark_skb_lost (net/ipv4/tcp_input.c:1316)
>    tcp_simple_retransmit (net/ipv4/tcp_input.c:3158)
>    tcp_v4_err (net/ipv4/tcp_ipv4.c:587)

Make sure to rebase your patches to latest net tree, not an old or
in-house kernel?
The context shows void tcp_send_active_reset(struct sock *sk, gfp_t
priority, at line 3694
rather than current net (line 3887, where tcp_send_active_reset()
takes enum sk_rst_reason reason).

>
> Sync the hint to the copy.
>
> Fixes: 75c119afe14f ("tcp: implement rb-tree based retransmit queue")

Seems not the right Fixes: tag to me?

c31b70c9968f (and 006f582c73f4 for the original omission) is more
historically accurate than 75c119afe14f.

> Reported-by: Kimi Security Team <bug-report@moonshot.ai>
> Tested-by: Weiming Shi <shiweiming@moonshot.ai>
> Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
> ---
>  net/ipv4/tcp_output.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 3b320ee77..498c9819a 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3694,6 +3694,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t p=
riority,
>  int tcp_send_synack(struct sock *sk)
>  {
>         struct sk_buff *skb;
> +       struct tcp_sock *tp =3D tcp_sk(sk);

RCT (Reverse Christmas Tree) violation.

>
>         skb =3D tcp_rtx_queue_head(sk);
>         if (!skb || !(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
> @@ -3710,6 +3711,8 @@ int tcp_send_synack(struct sock *sk)
>                         if (!nskb)
>                                 return -ENOMEM;
>                         INIT_LIST_HEAD(&nskb->tcp_tsorted_anchor);
> +                       if (skb =3D=3D tp->retransmit_skb_hint)
> +                               tp->retransmit_skb_hint =3D nskb;
>                         tcp_highest_sack_replace(sk, skb, nskb);
>                         tcp_rtx_queue_unlink_and_free(skb, sk);
> --
> 2.43.0

Patch seems legit, please make sure to CC Kuniyuki Iwashima
<kuniyu@google.com> in V2

Thanks.
