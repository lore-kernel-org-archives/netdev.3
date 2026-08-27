Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A0472F7B
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838294; cv=pass; b=uA/Xe6q/zJ/bwOMJAx2WhYxDI29Eo182+8FHL6k0Z/7fxqKY4FsD+f5vq0E5KSRB+CMWSpDemi0Yj6QX25Jc63j8zgQo1DB3Ct2lNyx+R6FMoweEgojXWzps262N2qbjgMhx+X0Q7OY5BMqUjV/OzJdAvKchV64Mj9zYNNDKqsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838294; c=relaxed/simple;
	bh=Mzu4lSA71TnUpIkFlRqeJimp6Rqi1HOQl6MU/Vy3sxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6OEHQK7Fcs+SC97lYR6CnOZqZEvnOYzMrcqS3f2aYQ3d0gQKwg/Uy235HbcAAbu02utZqMzRAlXACUebpwC2anbbdo8bUTGqYXbEW1LPKSraWLXCFjQKhuUxeUdgQCHGybH8wB6HJDsmMrqZbaE2dGiDuZGYkqHvyz+pgtzM2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpV24GdT; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpV24GdT"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52f9fc510e1so5986281cf.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 06:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787838289; cv=none;
        d=google.com; s=arc-20260327;
        b=ZwivxcOHJEnvIhosqnoOyxEbTlHRdgly7dIsaSjOG8HslAB9BulsTcTIqgIaKXvMPG
         3TIZ1UTmUUI3+O8LF7iS/OYhfHPxDy0oezssukeGMAAHCFukuDjgqFUjPLNhNLqdCSoW
         JX6jjnyk0gDFVcieri5qieQVsR945ZypWr/LdcoS2LJOQQH6UBeN5mGEeJ1VrD19yLIA
         BAKYqkqGdrxX8sT0dDrOVQadfDk/c2lEXEHsigFBigX3pi2PHL30lvxqGtAyQNf410uw
         P1yzgdxKK8cHhgIoP9y7YqKBa0iJHOdBncA/iWNwIxM/UM522EKp1ghTybcBucc1xhUw
         hDoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TiarfUjA5o3AcHVmQi+rQTGlDx3EfO+y+iS+w99lDxU=;
        fh=LT1yjlr21M89Z1nxULb1h63cK/MpgbviXwPeWJh4p3Y=;
        b=SNgOzLcZaIU2JLobklcK73Jj2iOtvXkMrA/dDIGGYoD0vM0jiTqR3SYuQOy8NizApD
         eyZMSeQjjUcAkv0E9jerJRQlyodeJM6e5Bdaxsi8DCpjGTKiKxocZKDp7YrqHs2aa+BI
         swoOY6tgoO1B6mMdJOUoP77lB6c3XQilNDcEFjo/T9LfWO2fnQEmhOf3oO4NEjZOex2A
         gYvcD7R3T1NEww5CseGSmlyS6yuo07eYxVEa3GXcUaH4W9DSTptiYm7PHNLhIWZwb8Mf
         f+uJfsCaRrpGbl6U4Wo8u7gyxOMnhiNjpJezXk1zGWurVStivHLr0n3SQJLOrEL6tds4
         MhGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787838289; x=1788443089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TiarfUjA5o3AcHVmQi+rQTGlDx3EfO+y+iS+w99lDxU=;
        b=bpV24GdTMFBEm6u82o+JoRDDkfAlcFUN4HBmtPkCRmU2qQrPiEKqf1ct3XU5w1TVsI
         6aA9pwgm0sV7SlYAmWfovTRchDMJVO9F/ea6o989B1wZzoDJ0bhPCBTsy6PKm3P/QaJD
         QomcPu+ygzVVzi37+KYo9S0cASPmYbVL1uUoJmvB/1VyV2oYcj8ZnBx5a7jtEqgkklyJ
         wXIbKGjP0124LsLVtoTIXnxzq0kse3a4Mtk6g2ANjSdR4KXdr3cwVb5/55GGOnapdtco
         MvynFb2gv0qbfIi847uq7EtJoMI2SEixevEZrYFtyAvR1Xegz4RoDRKnOlOEvj6HdK4h
         e1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787838289; x=1788443089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TiarfUjA5o3AcHVmQi+rQTGlDx3EfO+y+iS+w99lDxU=;
        b=c0qLgQK/w9IPvVb/7lx9JDKjnmAhHP+vdN7O90fzFOrMXo9dRouUBttjEHFCpv1lfv
         TihcNcQR/s5XO9LuydvYIDunpIsQGXiVnyRmfzCNqrsmd6AJKi/GGiNZkx/ENK3NMfVF
         W52byN6hQTsq9rx3Cur+LICIsm2/zmLi5NOslF5txTDdjh8z0ahRCXcBPgUx3nkFmcWP
         AxvND2MaH0z0ak3FUA2ecb3uaeim4rQI871/e5ncXUsQfF/zHcnu96O4az6fE+BL5ad5
         zoaBCdIzJs0HQ/zLUGuzwJnduaMKm72lxKzz52nWlnkuMu8OMFoI4SIAaMTQq7qbbG8P
         qVdg==
X-Gm-Message-State: AFuF++nMfL6Mpguz+Rz5elXxbXorQYdYG7fCx7DaxJYg1zGvSjtrsFCb
	hHHl0bXihIJwpP8J80Mk1+EwbKDD2juToTmXuaM5vrhLNygaoNb9nrWKIrvkfQ8H8WpJJLlLlJO
	z0lgaXJcAA9oblQPXBhMKt5NxhIprDXrteGkML+L2
X-Gm-Gg: AR+sD12N2IO6CxbiFK3fjA3/Ebj1kGjVSv3oZbHPEEgvZK9491nfZvmBriWTPfQE0Sl
	MkHQnW39oecI0r8IahCjxXqUfSfUNvIqgC/6z3uH7uh2okegcUaEa3A8VZMdTeSH7WfYJoRciR0
	7oIgQlNIK5Qvsv+lTVxeZOUT31i8FJS+sOxEgfuzrL2fVfJUwInkKH7YVLq0dj2uTrZcR+mBIAf
	NARZuAIMFz9j6aA+78D/aF20VaioCacUkoTp4Kb8bv9ddCYTDLczWZk3+gfg16XWglq8Lkq0oE0
	bVlSWOLm/n4hi8OzIDL2YCzTpRM+n/DcgdsiAJxd2mvejpKlnm3RYIJi7icy0I6gxg+tcDgZruf
	LFrnnYMC0WJmwUL7iHYhRKj1AU5LuSoGaho24HVH1WshmZ6s7fSG1grdIoe2oFRBNf+SIOg==
X-Received: by 2002:a05:622a:1aa9:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-52fa1def2bamr71264701cf.22.1787838287984; Thu, 27 Aug 2026
 06:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827132820.11815-1-2045gemini@gmail.com>
In-Reply-To: <20260827132820.11815-1-2045gemini@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Aug 2026 15:44:36 +0200
X-Gm-Features: AcwNN1VTeP4O74Z9FZNjuIihE6nD92fIGVkcW9WBbJsfoH-8owf1Wfnzar0YN5c
Message-ID: <CANn89iL_6foOEX5_bhDq5i9yXBFMyeyPy=uZHSxhsw8q_71B4g@mail.gmail.com>
Subject: Re: [PATCH net] net: gso: always scan dodgy frag_list for linear heads
To: Guidong Han <2045gemini@gmail.com>, Xinyang Ge <xinyang@anthropic.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Shmulik Ladkani <shmulik@metanetworks.com>, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, Cen Zhang <zzzccc427@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:28=E2=80=AFPM Guidong Han <2045gemini@gmail.com> =
wrote:
>
> skb_segment() moves frag_list data into the segments either by sharing
> page frags (zero-copy, requires the source memory to be page backed)
> or by copying. Sharing into a linear kmalloc head is invalid, so for
> SKB_GSO_DODGY skbs (untrusted GSO metadata, e.g. from a virtio net
> header supplied by a VM guest or an AF_PACKET/TUN user) the frag_list
> gets a defensive scan: if any member has a linear head without
> head_frag set, NETIF_F_SG is cleared to force the copying fallback.
> Without it, segmentation dies at BUG_ON(!list_skb->head_frag).
>
> The scan is skipped when mss =3D=3D skb_headlen(head_skb), on the
> assumption that the frag_list members then terminate on exact mss
> boundaries, so segments never cut into the middle of a member and
> page sharing stays safe. That assumption comes from GRO-built lists,
> where every member holds exactly one received segment. It does not
> hold in general: the first segment also contains head_skb's paged
> frags, so even with mss =3D=3D skb_headlen(head_skb) a frag_list member
> need not start on an mss boundary.
>
> Such a layout is reachable from a guest: it sends two IPv4 fragments
> through virtio-net, the first with a forged gso_size equal to the
> reassembled linear head length, and conntrack defrag appends the
> second, kmalloc-backed fragment to the frag_list. Forwarding then
> forces software GSO (gso_size > egress MTU, or the egress lacks
> NETIF_F_FRAGLIST) and panics the host: an unprivileged guest can take
> down the host and all co-located VMs. The same layout is reachable
> from host userspace via AF_PACKET PACKET_VNET_HDR or TUN with
> IFF_VNET_HDR, given any conntrack user.
>
> Drop the mss !=3D skb_headlen(head_skb) test so the scan runs for all
> dodgy frag_list skbs.
>
> Fixes: 3dcbdb134f32 ("net: gso: Fix skb_segment splat when splitting gso_=
size mangled skb having linear-headed frag_list")
> Cc: stable@vger.kernel.org
> Co-developed-by: Cen Zhang <zzzccc427@gmail.com>
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> Signed-off-by: Guidong Han <2045gemini@gmail.com>
> ---
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ba3dbac80fb4..e97b27ec13fd 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4796,7 +4796,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_sk=
b,
>         int nfrags, pos;
>
>         if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
> -           mss !=3D GSO_BY_FRAGS && mss !=3D skb_headlen(head_skb)) {
> +           mss !=3D GSO_BY_FRAGS) {
>                 struct sk_buff *check_skb;
>
>                 for (check_skb =3D list_skb; check_skb; check_skb =3D che=
ck_skb->next) {
> @@ -4804,11 +4804,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_=
skb,
>                                 /* gso_size is untrusted, and we have a f=
rag_list with
>                                  * a linear non head_frag item.
>                                  *
> -                                * If head_skb's headlen does not fit req=
uested gso_size,
> -                                * it means that the frag_list members do=
 NOT terminate
> -                                * on exact gso_size boundaries. Hence we=
 cannot perform
> -                                * skb_frag_t page sharing. Therefore we =
must fallback to
> -                                * copying the frag_list skbs; we do so b=
y disabling SG.
> +                                * The frag_list members cannot be truste=
d to terminate
> +                                * on exact gso_size boundaries: head_skb=
's paged frags
> +                                * take part in the first segment, so eve=
n
> +                                * mss =3D=3D skb_headlen(head_skb) does =
not guarantee the
> +                                * alignment. Hence we cannot perform skb=
_frag_t page
> +                                * sharing. Therefore we must fallback to=
 copying the
> +                                * frag_list skbs; we do so by disabling =
SG.
>                                  */
>                                 features &=3D ~NETIF_F_SG;
>                                 break;

This is not enough.

We have a better fix coming from Xinyang Ge soon.

pw-bot: rejected

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index fc0cb993959f9b6506063a4118078abde12521d9..c17e57ec7d5cdb6aac4b26777ab=
96254940b1945
100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -435,6 +435,13 @@ int inet_frag_queue_insert(struct inet_frag_queue
*q, struct sk_buff *skb,
 {
        struct sk_buff *last =3D q->fragments_tail;

+       /* An IP fragment is never a GSO packet, but an untrusted source
+        * (virtio_net_hdr) may have attached GSO metadata to it. Do not le=
t
+        * that reach the reassembled skb, whose head keeps the first
+        * fragment's shinfo and whose frag_list is not GRO-shaped.
+        */
+       skb_gso_reset(skb);
+
        /* RFC5722, Section 4, amended by Errata ID : 3089
         *                          When reassembling an IPv6 datagram, if
         *   one or more its constituent fragments is determined to be an
