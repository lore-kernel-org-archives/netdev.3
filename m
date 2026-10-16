Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D24429803
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792192089; cv=pass; b=EARnUZTBKbOxeCAdy0hJhU63aVzKQdh4KTa81+1yXJ2h6wpT677TXP4MUizzyYH7dTMyHi4XV7TbSgvvSOsRc+mIaP+boonnzmsWpQNGMzzuSIErTlFaBFDkIPOSxETGmTcHpKhef5j/MD0LYTPhwTBkMSs8Qi+TcyXBSWGtx4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792192089; c=relaxed/simple;
	bh=2NjshnJdz7PKbETyDmjjEXesZOcAOKBqj5v8ODPbgDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNw+bzsOv6mEwz+YJtn1XNBF0IbSeANKERa6HxeEN1oSDyXeewvTyqdrxRkkzvh8Pe7nvM9wCAQJcWC8IxkWXGFNotBWZl3JbmoYTQG5ZFZbqt3Fpyl1CSCHL5/GFUiY2dqzGFQ2qV8zUj6lJO39jPojfCTL50vaCnkRCcrH4G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JWkDk78u; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWkDk78u"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a018493d57so24255e9.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 16:08:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792192086; cv=none;
        d=google.com; s=arc-20260327;
        b=nMfa8YyGoF99LgVChbgaojMQxKyBE6rb8FmHqjGbzxhwRHBhl+qDDwlkMhxoDv31BO
         QjV+sGKKbsFF+TudC6TvyfAG9lP7WNS0no2g6DZApPIlSHIs6WRzMacgNOfcGAwzcJkQ
         IkUQELj4fmSRGQHZ/YKxQoFGfiTd5cJ/8GigmgOjkUElap/hxziKCCWAdC3G3HBJwnzI
         mdxZrANn5TrSLSvfXpS4VEZ21gVtrImYZNUdhDG6gY2r5C4NuupUGQgS7hTBAZ6Wm0OC
         /MXazs3HjiDYwZLhz+MtdE9xKp1fDM13eHLRvVPUwj1DEHjLn8m13Z8EsKH5ztsef+D/
         ulrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=30+GVqJjgouGthJZITUYh5UpY5UVzDnV78N0mcBLInk=;
        fh=BCM++SHHV77QzP/iKt+IguAigydDQgKUNgL/gtU7RI0=;
        b=m3l/4S3UHSyhsz0PGcaGhhD1O8ULfHEmF0ArRxli7d0erRKoqm/pD229wBCxi6bnH9
         Qyumug2NXnPaDpt5Zk8qGWSsDLiXBNVXagotw/k27BfEKtoMtok5qPSQm0daTsfUHx21
         VZ5Vp8dN60C+JPpLpfSj7WylYaNe+fPWaopbgg4ODJ3wrZq7fE4oMeyf4pYLqsFju2k1
         MzFpEj4KBYNA1qE7k0GNed17rqFWg6UQyFpxELDowaJrssOgmz4Za7GDfISbXoijPFqF
         Tavj+4o3Uh6tVq0TjH8jbsmUtgMcAU60hDYm858s7raI7kyqBYlX3EePxUC3kOSzTBXU
         HxRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792192086; x=1792796886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=30+GVqJjgouGthJZITUYh5UpY5UVzDnV78N0mcBLInk=;
        b=JWkDk78uAs5f/YLe6gNnANK2p9fl7LDZPIjhDBLZ8LostQUF4YTFtHFl8HmjGuaxME
         tzpq+1Je3bP1aK4Pef3Vli7B2OLYmftyLN4e1rcDZv8l2cUsSnDi7noLvIQeryKsM3+Z
         XWE4OJLCT6S991eIHNqxid/db/3bp4g4GG2ET0GQw2l1pSFQl9DvnzTak9VuGT2+2kPa
         VVJFBdnU2Vp8bE9A5d5Ynj0N62refWkgSlyjdWTQ5wfHKq2EzqrRWGxHBgv7JxUWHyrD
         IKP08gRWR80M1uq53SZxCHtrC3WHCTi0YCF5bkBHZw8creX7qfXSvC9TYgp5lEzXcKHj
         CpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792192086; x=1792796886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=30+GVqJjgouGthJZITUYh5UpY5UVzDnV78N0mcBLInk=;
        b=OmDKdF5ShMTUkNvhhas9DS9P0irXydQsaPMW5svD6iFGGKyljk++x42WY0qDgDnsfX
         Rzn4AbivQGvGL9kTIRMEAKXNm+7G65PVP3ZqcCTq4I8HaGbMHR6yiqYXc9sZ2UBBjJXJ
         ZZhBZYVXB/Te5MRWYP/Bd4oVxGHzTRQmCoS99eNz+1+uV0D+NjpRJ6efohdIjtHoaw2g
         fRyTGJIzLtpG3qxmGtE/5uSEHd6QhCV8B/ccMhO7HlTu8yg061f2o97IO+ISOmOR+bYU
         N43qkbs1VyjvjMSqGksnOb6/J5n0cQwCBTDFJHBQl6TNERaASf0C8g7v5PCd/lne/7uR
         sIjA==
X-Gm-Message-State: AFq9FYJgc0C0L/FK98IY1573lzbkgdBsAdH5Nr9y5FUWvY6A7TsKxwCp
	g8Zlhu9UiIONRuxtYoEkdSBFcb2fvq9p3GI6jAM9Oyf+a4L2THPnUtUgnS7pFLjNf0HmZlJE2/x
	GYCUuXpZ6DnDQPJo6Mx1fnOUmIV4s3GZlIImaaAKW
X-Gm-Gg: AYBFou0LPPJxb1G4nsDbzK2s/SajmfhbHXUByNFtC9O7grg4XITf1y2phk8ydcL+qSV
	6Qy/YDcuKVuVnpKyKYronLwKQ3cNi6uQXVSvMDecxFXWCmOjBPZmmYakFGnfhXHD2RfxxDQcgXV
	FUUaBrIVY8m+I7wVfHDGUUtPY9dn2ImQx3K3m6fHbksEZJuZoLBheaHXlvU1Bk8R0sVqUrQCQDl
	H3N4XBOyhcnbzuVKy4+F+BLvpChm/Lcr2HBQ162k8tKNwFpOBrnar7g/rk/hBjp3FqdMcqzyb7G
	9b9Key2/7qQrQwDP2VDX/P6xUO+1wxELZtXN99AJGsQCUlPO2xLXVp1CVxXtIPhxjYMqah1M4sA
	J4YOe6emPsLGA
X-Received: by 2002:a05:600c:2d15:b0:49c:ff18:79bd with SMTP id
 5b1f17b1804b1-4a1d995b10fmr99205e9.9.1792192085761; Fri, 16 Oct 2026 16:08:05
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791899747.git.zhilinz@nebusec.ai> <b966eb102e98f299e45be59ada033a8766e4c6df.1791899747.git.zhilinz@nebusec.ai>
In-Reply-To: <b966eb102e98f299e45be59ada033a8766e4c6df.1791899747.git.zhilinz@nebusec.ai>
From: Naman Gulati <namangulati@google.com>
Date: Fri, 16 Oct 2026 16:07:53 -0700
X-Gm-Features: AclHuK_Cs-LCO-Fpjyrt8_o87Y2boQExMs4aJ4LJMhWfAXPkCWszJUis1O-l6No
Message-ID: <CAMP57yVW-ODgQoRyZte-KDHaXrjFKXA3NheYcnUAU3w1YU1g1g@mail.gmail.com>
Subject: Re: [PATCH net 1/1] ipmr: validate VIF indexes before offload lookup
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 8:35=E2=80=AFAM Zhiling Zou <zhilinz@nebusec.ai> wr=
ote:
>
> ipmr_find_vif() can return -1 when a packet races with VIF publication.
> ipmr_forward_offloaded() forms pointers into mrt->vif_table before
> checking the packet's offload mark, so a negative index is out of bounds.
>
> Validate both VIF indexes before forming pointers into vif_table. Invalid
> indexes fall back to the regular software forwarding path.
>
> Fixes: 4eadb88244d1 ("ipmr: do not acquire mrt_lock while calling ip_mr_f=
orward()")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
>  net/ipv4/ipmr.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index b9c544d48c45..bc3263d15a44 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1879,11 +1879,16 @@ static inline int ipmr_forward_finish(struct net =
*net, struct sock *sk,
>  static bool ipmr_forward_offloaded(struct sk_buff *skb, struct mr_table =
*mrt,
>                                    int in_vifi, int out_vifi)
>  {
> -       struct vif_device *out_vif =3D &mrt->vif_table[out_vifi];
> -       struct vif_device *in_vif =3D &mrt->vif_table[in_vifi];
> +       struct vif_device *out_vif, *in_vif;
>
>         if (!skb->offload_l3_fwd_mark)
>                 return false;
> +       if (in_vifi < 0 || in_vifi >=3D MAXVIFS ||
> +           out_vifi < 0 || out_vifi >=3D MAXVIFS)
> +               return false;

It might be cleaner to move this check higher into the stack at
ip_mr_forward() where the ipmr_find_vif lookup is done (and
ip6_mr_forward(), which has the same race but no OOB access since
commit 9b1c21d898fd ("ip6mr: do not acquire mrt_lock while calling
ip6_mr_forward()")).

Before mrt_lock was removed, true_vifi < 0 in ip_mr_forward() always
implied mrt->vif_table[vif].dev !=3D dev, so the packet entered the
wrong-interface branch and was dropped. Without this early check in
ip_mr_forward(), the outgoing-interface loop check (ct !=3D true_vifi)
for (*,G) entries will also fail to prevent hairpining the packet back
out the ingress VIF when true_vifi =3D -1. Something like this maybe:

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index b9c544d48c45..de869a6ac011 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2064,7 +2064,8 @@ static void ip_mr_forward(struct net *net,
struct mr_table *mrt,
        }

        /* Wrong interface: drop packet and (maybe) send PIM assert. */
-       if (rcu_access_pointer(mrt->vif_table[vif].dev) !=3D dev) {
+       if (true_vifi < 0 ||
+           rcu_access_pointer(mrt->vif_table[vif].dev) !=3D dev) {
                if (rt_is_output_route(skb_rtable(skb))) {
                        /* It is our own packet, looped back.
                         * Very complicated situation...
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 9d8116b5edb1..faaf04f5c4f3 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2218,7 +2218,8 @@ static void ip6_mr_forward(struct net *net,
struct mr_table *mrt,
        /*
         * Wrong interface: drop packet and (maybe) send PIM assert.
         */
-       if (rcu_access_pointer(mrt->vif_table[vif].dev) !=3D dev) {
+       if (true_vifi < 0 ||
+           rcu_access_pointer(mrt->vif_table[vif].dev) !=3D dev) {
                atomic_long_inc(&c->_c.mfc_un.res.wrong_if);

                if (true_vifi >=3D 0 && READ_ONCE(mrt->mroute_do_assert) &&

> +
> +       out_vif =3D &mrt->vif_table[out_vifi];
> +       in_vif =3D &mrt->vif_table[in_vifi];
>         if (!out_vif->dev_parent_id.id_len || !in_vif->dev_parent_id.id_l=
en)
>                 return false;
>         return netdev_phys_item_id_same(&out_vif->dev_parent_id,
> --
> 2.55.0
>
>
