Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364808;
	b=ekgWr1INjp3EgnJ5Eq0B5P/ziSLzQ9yUjGI/gNHPp0rGy/X3SIjcC5RrOOJQleuflDoN
	 aRLHikQ9zOPXBDycla6e7Vv3jZBBH1dcHEP6AzZIvem43KYih2kREaJ5+VSazR69KZ/Aa
	 +nrJgpFebfA8FPZOqRnMNWYGiAipsY0j2tRaP62FVNYkzzjAfjrSfrl7X0/27yAPzhuiq
	 xihwedw83BBdqZdGRJyC569UwX3kkhbRgZ6OHtG5ebNhrS2BJG4JJMzChQZqpoLiM47el
	 GVRXkbyj7DSjDx1JI85L/8mUHML6rMCT+CVLVM3bw402RLXPlu5UE7b999qKxS9Hz4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364808;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pIhT0ljkt1TajfmZjuLLWTiDf7BeTdzptsYTLuEHLoc=;
	b=TKgkQMhAsTvAOXbtVuZCfXtvdqB1xji8y9hYXcnDTrIFBwSXoE8ILF+bl6tHWsxeumnX
	 VTULcqxGjvY3FQwCyLOJSJMbieZe1v/VAWT24vCD69HBOofRM40MmODR4h09QYdi44hrw
	 kTTJyNhUDsWSCQGJ7ykP57JvLbiA7g6VqqlGJeizuTv84HZmZ48RWG6DzCIlhRJbXmt1I
	 86Nb5Lhx9nxbTU6Fy8OssUhwgcC9EBFELtblQB014hTMv8ALbp7+eg7OQm1IrVzdFFNR9
	 B1qGz9v/SGGnKk4hchq0UaDq/l782lgvuQG9jo+eV6PVVCipw4LuHmQtJiJsGYaFcfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vh+9J1YM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7853606A32F
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vh+9J1YM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7087E1F00A02
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793364807;
	bh=pIhT0ljkt1TajfmZjuLLWTiDf7BeTdzptsYTLuEHLoc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Vh+9J1YM5P+5hvHufW65S5invTSpyuN383wj453uv3+3cCxPOaxAndtn2nPbM7V6J
	 Qn6xZABV8n+WMP+jnsMop9ZE/FKicOu3wMw2ATq7WESLxPRiqVycW/P3IVUz6rNdLz
	 MBf80rS9XP4s/2h8yE2kUYnc2KGaP4nGo602KQrI2qr1dwMHFbsf8A05vz1TNMD2Vd
	 DIfX5LP7Cygq+IwEn9VYgoVdNipBybRqOzW8fld5vMbzh9oHE2iEVCfjJa2HZ/mA4J
	 kzaxbWd4JWwd1830guT7a8REP+T1900T46A1u3TwjTRT9BHkGSoigqDKHHFLMA3F6B
	 /YRQQTHEVANjQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-49e1251674cso314441fac.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 05:53:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxN+FqIX00YMrow2pj722VIUXw+HxmZtz6Uxtw5z6uIqGHIY0S4pT9sdARzPQbM2aFLe/jj8Jc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHH/xcMUda+xz0CtCHoUadqImCPHc+wllOW06Si+vvJQNJ2AQz
	b3pzZKCdGaVwDhrO6K8zxvAs/RAE+nhwr2QIx6PuSCIqi/4TgGIsE4VZbVePwhF2ZdbbB9gqHcD
	6Nvm/M5MrE8+ezGY6FFUYS/yXl8GpXw8=
X-Received: by 2002:a05:6870:ab05:b0:49d:f406:92a2 with SMTP id
 586e51a60fabf-4a90770f7ccmr1264489fac.38.1793364806506; Fri, 30 Oct 2026
 05:53:26 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028141325.2103814-2-edumazet@kernel.org> <179328332814.3134.7858322712930731649@kernel.org>
In-Reply-To: <179328332814.3134.7858322712930731649@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 30 Oct 2026 13:53:15 +0100
X-Gmail-Original-Message-ID: <CAL4WiipOb++yTtQeuk21_j3zW=jgLS4TqNoBY+a8YUQwFzY5rg@mail.gmail.com>
X-Gm-Features: AclHuK-UBwdaRznRrMpkAJvp25CUBCDKgB3X0-dFnAbjn50RLqYYWU-hDLLPduc
Message-ID: <CAL4WiipOb++yTtQeuk21_j3zW=jgLS4TqNoBY+a8YUQwFzY5rg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: gro: do not undo remote checksum offload on
 merged packets
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemb@google.com, steffen.klassert@secunet.com, 
	AutonomousCodeSecurity@microsoft.com, netdev@vger.kernel.org, 
	tsgatesv@gmail.com, cenzhang@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 29 oct. 2026 =C3=A0 15:15, <netdev-bot+sashiko@kernel.org> a =C3=A9=
crit :
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] Both the commit message and the new code comment give a wrong
>   reason for skipping the cleanup in the fraglist case.
> - [Low] The new comment in skb_gro_remcsum_cleanup() (include/net/gro.h)
>   says "Once merged, skb->data was moved past the headers".
>

Both right, the code is fine but the reasons were not accurate.

In v2, the comment and changelog say that the frags or head of a
merged skb can belong to the GRO packet (skb->data is not moved then).

They also say that fraglist members keep their own inner headers:
grc->delta is only set with VXLAN_F_REMCSUM_NOPARTIAL, where
skb_remcsum_process() writes the same adjusted checksum in the non GRO
path, so keeping it is the intended result.

> Pre-existing issues:
> - [Critical] This only applies to this commit taken on its own.
>
> --
>
> net: gro: do not undo remote checksum offload on merged packets
>
> This patch makes skb_gro_remcsum_cleanup() return early when
> NAPI_GRO_CB(skb)->same_flow is set. A merged skb may have had skb->data
> pulled past its headers, so the 2-byte undo at grc->offset could land in
> payload or in memory freed by a fraglist pull. The commit message says th=
e
> non-merged frag0 case is handled in the following patch.
>
> > diff --git a/include/net/gro.h b/include/net/gro.h
> > index 2300b6da05b27..b560e866683b0 100644
> > --- a/include/net/gro.h
> > +++ b/include/net/gro.h
> > @@ -351,7 +351,10 @@ static inline void skb_gro_remcsum_cleanup(struct =
sk_buff *skb,
> >       void *ptr;
> >       size_t plen =3D grc->offset + sizeof(u16);
> >
> > -     if (!grc->delta)
> > +     /* Once merged, skb->data was moved past the headers, and
>
> [Severity: Low]
> Is this true for every merge path? In skb_gro_receive(), only the merge:
> frag_list path calls __skb_pull(skb, offset). The frag-steal and head-ste=
al
> branches set same_flow without moving skb->data:
>
> net/core/gro.c:skb_gro_receive() {
>     ...
>         if (headlen <=3D offset) {
>                 ...
>                 skbinfo->nr_frags =3D 0;
>                 ...
>                 NAPI_GRO_CB(skb)->free =3D NAPI_GRO_FREE;
>                 goto done;
>         } else if (skb->head_frag) {
>                 ...
>                 NAPI_GRO_CB(skb)->free =3D NAPI_GRO_FREE_STOLEN_HEAD;
>                 goto done;
>         }
>     ...
> done:
>     ...
>         NAPI_GRO_CB(skb)->same_flow =3D 1;
> }
>
> On those paths the cleanup is skipped for a different reason: the skb's
> frags or head now belong to p, and the skb is about to be freed.
>
> The commit message says skb->data "might have been moved", but the commen=
t
> says it always was. Could the comment describe both cases?
>
> > +      * the headers of this skb will not be used anymore.
> > +      */
>
> [Severity: Low]
> Is this accurate for fraglist members? The commit message has a similar
> claim:
>
>   Headers of a merged skb are not used anymore: the skb is either freed,
>   or its headers are rebuilt from the head skb in skb_segment() or
>   skb_segment_list().
>
> Before calling skb_gro_receive_list(), udp_gro_receive_segment() sets the
> member's network header to the inner network offset:
>
>         skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
>
> skb_segment_list() then copies only the link-layer and tunnel headers fro=
m
> the head skb:
>
> net/core/skbuff.c:skb_segment_list() {
>     ...
>                 skb_push(nskb, -skb_network_offset(nskb) + offset);
>     ...
>                 nskb->transport_header +=3D len_diff;
>                 skb_copy_from_linear_data_offset(skb, -tnl_hlen,
>                                                  nskb->data - tnl_hlen,
>                                                  offset + tnl_hlen);
>     ...
> }
>
> The member keeps its own inner IP and UDP headers. When addresses and
> ports match, __udpv4_gso_segment_list_csum() returns early without touchi=
ng
> them. So the inner checksum written by skb_gro_remcsum_process() is what
> gets sent for those segments.
>
> The behavior still looks correct. The retained value is the full
> remote-checksum result, the same value the non-GRO skb_remcsum_process()
> path would write. Only the stated reason seems wrong.
>
> Could the comment and commit message say that fraglist members keep their
> adjusted inner headers, and that this adjusted checksum is the intended
> value?
>
> > +     if (!grc->delta || NAPI_GRO_CB(skb)->same_flow)
> >               return;
> >
> >       ptr =3D skb_gro_header(skb, plen, grc->offset);
>
> [Severity: Critical]
> This isn't a bug introduced by this patch, but the same_flow check does n=
ot
> cover a non-merged skb whose frag0 has gone stale. In
> udp_gro_receive_segment(), the is_flist branch pulls first and can then
> still reject the packet:
>
> net/ipv4/udp_offload.c:udp_gro_receive_segment() {
>     ...
>                         if (NAPI_GRO_CB(skb)->is_flist) {
>                                 if (!pskb_may_pull(skb, skb_gro_offset(sk=
b))) {
>                                         NAPI_GRO_CB(skb)->flush =3D 1;
>                                         return NULL;
>                                 }
>                                 if ((skb->ip_summed !=3D p->ip_summed) ||
>                                     (skb->csum_level !=3D p->csum_level))=
 {
>                                         NAPI_GRO_CB(skb)->flush =3D 1;
>                                         return NULL;
>                                 }
>     ...
> }
>
> pskb_may_pull() can drop frags[0] if it holds only headers. If headlen is
> non-zero, pskb_expand_head() can instead free the old head that frag0
> points to. Neither NAPI_GRO_CB(skb)->frag0 nor frag0_len is updated.
>
> If the checksum-state check then fails, or skb_gro_receive_list() returns
> -E2BIG, same_flow stays 0. vxlan_gro_receive(), vxlan_gpe_gro_receive() a=
nd
> gue_gro_receive() then call:
>
> skb_gro_flush_final_remcsum()
>   skb_gro_remcsum_cleanup()
>     skb_gro_header()   <- frag0 fast path, stale frag0_len >=3D plen
>     remcsum_unadjust() <- 2-byte read-modify-write
>
> Can that write land in a page or head the skb no longer holds a reference
> on?
>
> The commit message says this case is handled in the following patch, "net=
:
> gro: invalidate frag0 after a pull". In the final series state, that patc=
h
> adds skb_gro_frag0_invalidate() after this pskb_may_pull(), after the pul=
l
> in skb_gro_receive_list(), and inside skb_gro_header_slow(). So the issue=
 is
> gone by the end of the series.
>
> The two patches carry different Fixes: tags. Should they be marked so tha=
t
> stable backports take both together?

This is what patch 2/2 fixes, both patches should be backported
together.

In v2, patch 2/2 also gets:

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")

so that it reaches the same stable trees as the UDP fraglist pull.
Patch 2/2 also now invalidates frag0 before the pull, as you pointed
out in your other reply.

pw-bot: cr
