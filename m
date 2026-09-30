Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A5A51E424
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784762; cv=pass; b=Yjz/9Pzx8En0HpqnASolbHC8QcU3Z425NRnJ/lTNKn6C5Fg/rHXIH59bmDc9dueyNIKckOlhy0148feudU/rL9GmBVY12pO6v4MuA0GGGJcaKqh2Qhq3sxL8DH7Ag/vupDIn5SCiuAKzH5wrZUSCyYW0vNlzZg88jFbPnZqVAEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784762; c=relaxed/simple;
	bh=7gqiQOM1qisNlj8JQPYTsymhakjhh1OHGQP9wdS9nLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N573hR0gdPcC65ZDOA9CQr+ZSCrjLXDtGcx1avlVaasSCC5uNu3g9gwHHZSSMULp/TCw/IYa96I5M8qh5+7SBlwRqpjUABdByGIEAY2kjy23CmH+mW4m6u5IQM7pCpTbeX5XyxN1jdQUHwh9kOiNVa7oIw0ARIjUhgQmXugSf2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bEjRPpal; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bEjRPpal"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso9124a12.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:12:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790784754; cv=none;
        d=google.com; s=arc-20260327;
        b=AnTjXXw6yAVvPm9Ny/n+px1TZ9DE7cHeUbzWD0dT3ZA6r5vzESWnju2zvKiivqZ98l
         V0m1nWd8cNHZvoayMnoDVKPRo+E7E3+y4oVPd0CN9tq7lt1ly+5q6Lxr5D5Ab+oesckk
         GmruSKrhbsupv2/MoK6G3fye9WW60eaAYw5e6uqmeQZgtnv4EOXTC02VBzQEUil/kSYS
         9BUlAqE8tt5uIqbH9kb/Q9Le5BgtDnoWX7SK47GNocK6nXry/r0Jw0Nig3E9ga9g/9j8
         Lkhbc1kF2qavBEhvPeBTor5pDTlF80Bw918zTMQe36vYcJo++eObLHVjCZsdKpBrneef
         F0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sKCqFzFBYqTrIG82wyOVYeMg1E+Z4esSyVmGkXm0A98=;
        fh=yHLT0tegnZVpBBUchfuZhVWvB1VAjHqhJm8pg0+ognU=;
        b=j+NbsWWlTTvP2tCSQtI2kfv1/u17myA7nooRObqI6c2gAAZJOdUoW3DrWMu+8Rz1PL
         rEOsId/DyQHw0eK8lZUx1f+ALDcmjGqMt+8YmEabJGgtFD1PDM5RVaQzrS6iJznIIkfn
         9RXmqpqu6CIt49AXUM+t4vTJUJKGyms+HFaPSF/dGq3VhSElJyu99VNl1wJzatCjeBiQ
         ggT+qlMToiiEHYd8Lv/mgtP+U4uaWnuMumUGBwpFcDFxNmUf9VpbBYAstGy+JLTWbPRO
         +WNgmygP28yirTvo/HDn0tYLpQ0FBdI0Gqd0QhAaaA999CHSENyy9UYK2LkC2sil1xWf
         kjvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790784754; x=1791389554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sKCqFzFBYqTrIG82wyOVYeMg1E+Z4esSyVmGkXm0A98=;
        b=bEjRPpalTxdDdMgHibqpAaNbPNBRJDrE73BGcSE29kN6dxT+muafGlzGVqWqMlWwUE
         FN4/f3/cNmb6O6jJWREkvRQUr4n6jT/MLK3JVzGORHPFt/ZYI2FsSv7UJn9CvLVod1M1
         weB2ifeAgLhGV5yFe1IGAFlxo9dPBDWMtLAviUZDsEN1IKMhOBWcMrWVQPvnY65etVI+
         YuC/fWPNBd2BK4oWH93ZDFd+HZ/MFOikJSMs0ISi1cZtmX3np4IHeClwKjMR7Uxw6Gqf
         if35Pt0LkbY7I32S1AKmZ2uhpsVVW5L9CTlpODNASMKpreDmcrEbUoUk/FDiXmNpqG/H
         b/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790784754; x=1791389554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sKCqFzFBYqTrIG82wyOVYeMg1E+Z4esSyVmGkXm0A98=;
        b=YKO9eHNVwfkq5F4WD+wQH6fU0mcpyYHI0T5Q11sCnNj0IC5KZJtt1KXFnOX7LG84s1
         iNpIKVWTQOWQqkp2tPyzkCiIQlmO78f0TAkAjTMqq7Xd1wIa9Dj3dWCtmAXFXgD7Zm/a
         eN+23Rk964JpnTtCyolt7dkE/h0dTK0PTg81xs1MuTr9lUCQr2kwWYX7LgIXnIOW9oDk
         rt2MyVHmeWSM6Lqx8dSwu29Y85eIpybp9ZkAUrTpED3twsqZ24CnTllNZeU21mCith2E
         jna+yYS+3/pqRzxDab+I5bcDfBGuTXWJNw21l9LU5KRqlm0CsQWo+ptTpPnkIMKHE3U0
         YNjg==
X-Forwarded-Encrypted: i=1; AKwUvBwTm1aPwU8u4ix3EN9I1tMQxC0cyweNfJmYLdjTU7/AoC3kDXSGcS8/yQY0nSkWzW1ADmmYgXE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRmyfV1wcdQfQFbAoL6Jc4rbOKsIRebD5HR0FjMgWOCjVGT2j/
	Li8udH8nMJrzGJEeQXIvAq3oa47Xgkm7rpxdJAldjm25WfDo9w3y+k8LNcCt05+XSsAztemPgen
	SllWFYUmunXK679GRjhVmgqD6/xh010eS5rpVhU6j
X-Gm-Gg: AYBFou2V+2ByCbQlgZLp7GHmqz0d6LH+5pcpvJaQarA1B9dm4y6VW/8GLpo6g6qvMn5
	+xLQ9dJuxZdOxOI2hT3ttyi+26s2o92HRbapp/LDR043aZW/SeQh5rrModj64pBDaPJkqBaMYub
	84foAbTo7MxhkEK1L2IVJYYM9S8MkzE8EKb0b3Wc4ZBQtzIT0f8woGlIgxqgKYtZqFttF5dW85R
	ysGNUZuTguNRBmnp8ZiOCYPa+MIZzT67QRrqF4pMXFENGmQ7T2eMGtlJXlUnE9CLfMy03zg0goB
	wXKBqtdGd8ijfiDUCDfa9suIFMi6TmVdeVPwzR3UzvCd3S88piwYVK/mN3VU13yA3Ty/5sJNrzE
	XcYYY5kIs5A==
X-Received: by 2002:a05:6402:a4ed:b0:6a1:4eba:f09e with SMTP id
 4fb4d7f45d1cf-6ad59eff06amr46096a12.7.1790784753356; Wed, 30 Sep 2026
 09:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930102524.1659847-1-4ncienth@gmail.com>
In-Reply-To: <20260930102524.1659847-1-4ncienth@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 30 Sep 2026 09:12:21 -0700
X-Gm-Features: AclHuK8sXEfV_wKW4FGBJSbi9it2y76uzkVZaA-s7FwS1OnJPEJwdDQqQ9SxoiU
Message-ID: <CAHS8izPpY0F4nnvOdq-ijsa27oiLxNViBXXyS54HJuHOO8rkGQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: reject net_iov in zerocopy receive mapping hints
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 3:25=E2=80=AFAM Daehyeon Ko <4ncienth@gmail.com> wr=
ote:
>
> After copying a readable prefix, receive_fallback_to_copy() asks
> tcp_zerocopy_set_hint_for_skb() where page mapping can resume. If the
> next skb is unreadable, find_next_mappable_frag() passes its net_iov
> fragment to can_map_frag().
>
> skb_frag_page() returns NULL for a net_iov, but can_map_frag()
> dereferences it in PageCompound(). A v7.2 KASAN run on a connected TCP
> socket with 64 readable bytes followed by a 4096-byte NET_IOV_DMABUF
> fragment reported:
>
>   BUG: KASAN: null-ptr-deref in can_map_frag
>   tcp_zerocopy_receive -> can_map_frag
>   Kernel panic - not syncing: KASAN: panic_on_warn set
>
> The diagnostic inserted the net_iov directly because the test host has
> no devmem-capable NIC. Hardware end-to-end reachability remains untested
> and requires CONFIG_NET_DEVMEM plus a supported DMA-buf-bound RX queue.
>
> Reject all net_iov fragments before skb_frag_page(). This covers both
> DMABUF and IOURING net_iov types while leaving page-backed checks
> unchanged. With the guard, the same queue copied the readable prefix,
> returned a 4096-byte skip hint, and completed without a fault.
>
> Fixes: 9f6b619edf2e ("net: support non paged skb frags")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
> Affected since v6.12-rc1; present in v7.2 and the pinned 2026-09-30
> Torvalds, net, net-next and linux-next snapshots.
>
> The existing combined fixed v7.2 build was warning-free. No isolated
> kernel build was run. Tested config SHA-256:
> f992c9fdb881ca95c467896791c52554719f6204cf06268cd92ac37c14c14f83
>
> The reproducer is available privately on request and is omitted from
> this public AI-assisted report.
> ---
>  net/ipv4/tcp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 562752352afe..87ef6d5cbfeb 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1908,6 +1908,8 @@ static bool can_map_frag(const skb_frag_t *frag)
>
>         if (skb_frag_size(frag) !=3D PAGE_SIZE || skb_frag_off(frag))
>                 return false;
> +       if (skb_frag_is_net_iov(frag))
> +               return false;

I think this should use skb_is_readable(). But you don't need this
helper for frags. I wonder if we should add a readable helper for
frags? I'm still holding out that in the future someone will add a
net_iov type that is actually kmappable and readable.

But this is good enough.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
