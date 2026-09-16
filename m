Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39D38DC72
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564016; cv=pass; b=M2bEeRrAURLv5QzYDVXMyf/ewzEfc/ZAvB/ZtwnJJcmmtxvWbLwloXDMZiAyzCP3k9HMGePLT2p5jM5zeCgwFIO7ZWjypwdRTdtaUzyM7N7O15bsTcIt9v3OdjlNGH9GeFBHwTZFAJR+G0HHzJdFk+Gl3UTvN9qzgV0y6uswQu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564016; c=relaxed/simple;
	bh=zOTxCNq0eD0ToBFamiWBTvjKMrhzH5E6NH9yaL6muro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+ijuO8bxZ4QTHZRz2O4f7OoJeWcLahWg/xNz9wysakVEDYzTJLHh4gu/zyZrJ5aHLF2AKwpWgq2BpMPy1hwHrSOqJZkgmqP1wBe0CN85ZblpK0Y/wxu3MESa3fVFSDnaOWDB/HRkzWYEAjLL1qtEw/5EPPPoK0cGlC4gEIhRgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITsapOX7; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITsapOX7"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5309ce58730so15051661cf.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789564014; cv=none;
        d=google.com; s=arc-20260327;
        b=CatCLcr5Syl27fp967/FypNJjZtIfZCN6bw4SF9TCUO4vZZjhD91Xok16FbCKVnyxe
         dcI7sDTbG4f0YWyB6dNOFZ0oWRyqFcLGrC3FzJ8R2KbjcpPrzzhiu+L+2i+NiZIAA8a8
         RdoI+vcBs5rLsu1kvOzzkIiOaTeRnWKPcg8ien6+Buj2U/v/zTdJ379VkUjUuglCSu38
         d+8Hgt5ckt21z1Ay6+ZayHmkxAW6Nc/koEFDHgdsGW+0E3fcn7a5oGR6ISbX6q4Ejg4z
         /11KY3TbtTDV30tk+p319S9zNPUoANlz0/FHadj4AIqIv48+FTsGV/nY3pKXjPmYqFwE
         DXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZN4FHiBKKDSmMlPWEfU/UxJRMWeAnYfTUSCncWyBnV4=;
        fh=6G5TuUGUQfu0JU8p9qnjWzYPT8GVuCA/+UGIWcmux1E=;
        b=XRqcTeGf8xhqlIvCj6vh/CyDyaZIYWEIUytcZTvZn4knPF11eMPDzRpHXQR3w1Gm2P
         LWFueOuzB5gBd6bjsuj6+HrB52iRcGQVLCoXjhdVZIQycI9hkEM+na6kbF/WKpbCZzis
         2d8foedHnV2I/KIrAS0PBf0GHny5TPFyjNPfS0BLbtPSieJ0sukXOxUWOeM0/GIQNG3v
         MdQ5Xi+SM7diQvqq75CquagYhUVBnxhPZFoodgES16uBQs4KCrS3mEyktzIECFdxtEJj
         Af7FVZ9tz+qJ3A2p8c3t2FJ31oOaWojKTBL/fSfzDgNM18C05vpr3dqEspM/EGUuuOd5
         e6tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789564014; x=1790168814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZN4FHiBKKDSmMlPWEfU/UxJRMWeAnYfTUSCncWyBnV4=;
        b=ITsapOX7JeN20YRNBveUwEDsuDepa2nn/QjPsBnmDoQkg9e8qXZ0I7upZ5XZi+zQmR
         a6H116kmgQdZG2yPAaOCsQ2wbvWOCHtP6mqdPxrY7dOhxBktwoK9KoWzMFd0NhN4kxIT
         cGnn6d7QumjSTT3CSJ8YSRg64rpFlcmNK6VILBC5aevw8l+g1p76VQ24PcSElI4taOCD
         HrrirasOAuovym5F6PntKFiUW5t0v0kbS4+1w+RBXWPB/80pWSxi6mNxEIJUMDrpN833
         OCy5LzrCDuWfbZ+UDq3Qceey4sGrWaR2z0zdB8VEDg/mvGtLwI4rd9mAEIuy8gaDBGen
         C9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789564014; x=1790168814;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZN4FHiBKKDSmMlPWEfU/UxJRMWeAnYfTUSCncWyBnV4=;
        b=piBvqjVqNy/6Oy84C125KJHIRGqnj4buXs0S98Kfe5WlcgQ3J38UrHMXUHo2q5TeMU
         MlWrbd8PfFqrH8J2PTdsSiDq3auyfzsYq5O5pxEQFbxAjSl8UHtQcxPcCsReuv9uXTYS
         02/+DJ6OwMdnr+mPfcqOFcU0Wp75VgPtsS1NFSEjCue0+yfbLca7qm6jzlfd4P9YU8az
         pL6eUfvmSVTLpQHt829xoQt6dyAwJS/vFpbZSYDySG6DlliUriFUhRy2EOmPtewM3bhb
         h/3alDOwYswOz51ZLMQ2SiMBNmAzXvxHalpYmNuq997qxxg8TuinYKo4BRpjkSorRdxm
         UtPg==
X-Forwarded-Encrypted: i=1; AKwUvBzzicMyKEmO0WabQ3C4Go0Bd9NSjUZthlUWS2pDYcb2SQGu3toHprA6PKR70Pl3z+GvyC6w7hA=@vger.kernel.org
X-Gm-Message-State: AFuF++k/v7YnnI9eU3V+lsggz5IK5N51BwT2wbqqbBOhPQ4DyzPqlsNJ
	gbMD+cCqEPOjoCLg8w2f3cwWpeRfVDQygCqL31g+fixbL/v9a3aKzzw/hI7n52hwP4Hp3UjvpaU
	RD9HDDA16MyC1uel2ZxJN1V1+HCTFIOk3kw68i0/M
X-Gm-Gg: AYBFou1+9ixRJRD9jvyhus/0yfCu7pem25IedgC2NiIZSD2GUOaKGPn1XHih98sMaxJ
	T6IrjZAsi/U1k6jnGC88h3lzntxfaQ8ZIEYpBHQoR54i0L1KTFkUwzKe8pnggT8Pl6QiJ0JzgjR
	qau+0tjUYiPc5eVQuPaC1zAnJuNEyQtQTZuC5D0zL8DnrAavgfB2cmYzNbZByGtvfE935QrcNx9
	hgIbKjuagitwnQ9sHUeqtmoesW0EqHBQXlzdaTYOTOYTPANI4+Kfo/HTLgF5CoGOPRIhFM1GgxT
	fg5iX6CtnpzwvshTpwUkUZsPuisTU5zDn19E4RUWHkOcHy9CcxyUrnv/ZRSUBn6VoRL0KRyiy4A
	dSevPTGNWUgI9R1n7mCdHRBFcKQgQ2tj7D9JDz3iK+jVzlq+MsLV8o9kRprEEyEeadZc=
X-Received: by 2002:a05:622a:2518:b0:530:aae3:2421 with SMTP id
 d75a77b69052e-5327f20587cmr43715441cf.1.1789564013084; Wed, 16 Sep 2026
 06:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916124153.43457-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260916124153.43457-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 16 Sep 2026 06:06:41 -0700
X-Gm-Features: AcwNN1UsdGW_E1ootYDWVE9QOLHhtDqBzL52GTg_uZ9bvWIX2ch5Pq3aVNfeVX8
Message-ID: <CANn89iLB9pRvcz_u+YCDdEzt5G=bgq5=Jk7P_xjgUfF7En-ghA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: preserve timestamps across receive queue collapse
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemb@google.com, kuniyu@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 5:42=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> When tcp_collapse() rebuilds skbs under memory pressure, the copy
> process doesn't include the right tstamp and hwtstamp from the
> old skb.
>

Good catch, the problem is real: memcpy(nskb->cb, skb->cb, ...) copies
has_rxtstamp, but nskb->tstamp and hwtstamps are left at zero, so
tcp_recv_timestamp() ends up emitting no cmsg at all.


> In net timestamping case, if such an skb happens to be the last
> one consumed in a recvmsg() call, the application receives no RX
> timestamp for that call.
>
> Fix this by copying both tstamp and hwtstamp to the new skb right
> after the initialization.
>
> Fixes: 98aaa913b4ed ("tcp: Extend SOF_TIMESTAMPING_RX_SOFTWARE to TCP rec=
vmsg")
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 0f60a1dbf927..c5756db892f2 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5835,6 +5835,8 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *=
list, struct rb_root *root,
>
>                 memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
>                 skb_copy_decrypted(nskb, skb);
> +               nskb->tstamp =3D skb->tstamp;
> +               skb_hwtstamps(nskb)->hwtstamp =3D skb_hwtstamps(skb)->hwt=
stamp;
>                 TCP_SKB_CB(nskb)->seq =3D TCP_SKB_CB(nskb)->end_seq =3D s=
tart;
>                 if (list)
>                         __skb_queue_before(list, skb, nskb);

However this samples the wrong skb. nskb aggregates data from several
skbs in the loop below, and you are copying the timestamp of the first
one, while 98aaa913b4ed (the commit you are fixing) established the
opposite invariant:

  "When skbs are coalesced either in the sk_receive_queue or the
   out_of_order_queue always choose the timestamp of the appended skb
   to maintain the invariant of returning the timestamp of the last
   byte in the recvmsg buffer."

tcp_try_coalesce() and tcp_add_backlog() both implement "last one
wins", please do the same here, something like:

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0f60a1dbf927..81d587654d3d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5854,6 +5854,12 @@ tcp_collapse(struct sock *sk, struct
sk_buff_head *list, struct rb_root *root,
                                if (skb_copy_bits(skb, offset,
skb_put(nskb, size), size))
                                        BUG();
                                TCP_SKB_CB(nskb)->end_seq +=3D size;
+                               if (TCP_SKB_CB(skb)->has_rxtstamp) {
+                                       TCP_SKB_CB(nskb)->has_rxtstamp =3D =
true;
+                                       nskb->tstamp =3D skb->tstamp;
+                                       skb_hwtstamps(nskb)->hwtstamp =3D
+                                               skb_hwtstamps(skb)->hwtstam=
p;
+                               }
                                copy -=3D size;
                                start +=3D size;
                        }

This would be the fourth copy of these lines, but let's keep the fix
minimal for net, a helper shared by the three call sites can come
later in net-next.

This is testable from user space (small SO_RCVBUF + many small
segments + delayed read hits tcp_prune_queue(), see
LINUX_MIB_TCPRCVCOLLAPSED); a selftest addition to
tools/testing/selftests/net/rxtimestamp.c would be welcome.

Thanks.

pw-bot: cr
