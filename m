Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691247;
	b=meYH4HmksPlmzQmRB61cbYQN0/bFZGbzhfXloxkFZMg5rkV0Aru0BY7S7QiqDL+TWiCG
	 fVKa4EzoMDnJdGuh+MOiBuKB+Ddovzaws9MXXWWeCHKI3c3CPq1TwwUVcdf9hCI0rBcmx
	 84vtShpI/YAV7CyJA8NCpAMALtrX7NQP2Zgz4OrWw2IG8fdyjJ3OdREO1o+qR6K04CVSI
	 2gpbIz//uTbRwA7fN4NmbxyAsA1uHvdt7RKasVKoLJ7dA9j0jXe0+7BWCdlPorBEi9/xv
	 85IekLwajOmzaMj9Mc5TLxItP8M/0EA2BnG/ZTTFv/BFSChZsNfdsZWsBO69pM1jl6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691247;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=K9Hb+3tFHqiNZnvx+AmgZckWtXWfwUcWzjWNrOSq04g=;
	b=rI43Mchbumppaby4mcRwj8dH2uzCpTGdvdJsKvhmPg8mhtsYgNi1k8ZxowxiKmqSxXd7
	 xyGQx00fzeiZAOO3kvp+4UZabAZ2KRAXBdG3lAfZb1i7/h0efyh8C2SY4T7WnqfmR28oI
	 Im7zTZpfPe4g7rKOWIsRdK9+kpQVN+ZNeF/7ala0Zg4cXViK/GgOG9zjb+YrxtHGIwnxh
	 KLG1ooFHWmSXqvk/OfT+uG6VO1aQgwnpr8L2F4D4HLMr8RKOIYdRM/P6RgGJSdWPxcld9
	 mi6OKWTaeNb9MRqB+Q1z6YnlDwJrIS0bZw727s/A2jtZUX5aG6ACSKDSYkyBPLVj/VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNTtSjx7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05392606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNTtSjx7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A011A1F031E0
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792691246;
	bh=K9Hb+3tFHqiNZnvx+AmgZckWtXWfwUcWzjWNrOSq04g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bNTtSjx7tH7I0gFWJ876CO/rUgqbfMs+LcJfcy8C98/+mDmSxIw/Qbr/9Q6Ri+tFX
	 +hZk6nJ9YX+zH+KcWFau9Cy10iq8OrruiOqyFqq0It+jQNT9Bvm73dxOs3/Td+o6jh
	 vdgOqTf7Cmpa3+1oFzQFIy8NgIWdpKnjwtdd45zkHxWHROz6/CLOYuVOlsFDAXY/zc
	 n7xXWbw6rB9RdCt1j5K+GZd2AF2hIUsrj3iC0zza4huw6CtzT92zx5fC3a7VMV1Zmh
	 8flUiHJwLEH5tzSgGsAcA6SGWyfUjoCon3G6Jim1a8rHmhHdj9zeOFS/0hmtVPj9lr
	 3dsyNvBKtQ5kQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3aae7df0971so17747691fa.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:47:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwk38+3d5dKQFtrvswgnF1prgAJlJY+uXRPCt/c7zKRvaZz+o0Ch2R7ZEkpQaB/A8VyXO4LibM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTLw81mCop7kBBJDA9NR5M4HTh8jWAEMFkr3XDkpzz87o5SwNd
	rd68KjhqHXZJ2CnZjiBTsjk6TWGj3mnDTcxSircrh65CEO/WxFE+AqdZKnbSOoItdxaEu6YfrMV
	Lam3s4fEZSwl1e62R2S8PNbxH5ScJYvA=
X-Received: by 2002:a2e:a98b:0:b0:3ac:4da3:864f with SMTP id
 38308e7fff4ca-3ac4da386b4mr11295731fa.4.1792691245380; Thu, 22 Oct 2026
 10:47:25 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
 <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com>
 <ACT-N6N4.v1.r0.20261022051412-4@mojatatu.com> <372c6019-2ee1-46ec-bf5f-ccbf9b4d8659@ovn.org>
In-Reply-To: <372c6019-2ee1-46ec-bf5f-ccbf9b4d8659@ovn.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 19:47:11 +0200
X-Gmail-Original-Message-ID: <CAL4WiiorJUG=pXc4kKa68qFcrNfKUA0CJB5NiZRr6oXjn_fzPw@mail.gmail.com>
X-Gm-Features: AclHuK_3dax7s3y99xzrNpjL0T6a8qGSUewPq2Lr_WKQe2E8h3vXFm7qwrBoFHA
Message-ID: <CAL4WiiorJUG=pXc4kKa68qFcrNfKUA0CJB5NiZRr6oXjn_fzPw@mail.gmail.com>
Subject: Re: [PATCH net 4/5] net: openvswitch: ensure a linear inner Ethernet
 header on TEB pop
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Martin Varghese <martin.varghese@nokia.com>, 
	Jiri Pirko <jiri@resnulli.us>, Victor Nogueira <victor@mojatatu.com>, dev@openvswitch.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 14:42, Ilya Maximets <i.maximets@ovn.org> a =C3=
=A9crit :
>
> On 10/22/26 11:22 AM, Jamal Hadi Salim wrote:
> > The issue:
> > pop_mpls() restores MAC_PROTO_ETHERNET when the popped ethertype is
> > ETH_P_TEB, but skb_mpls_pop() only guarantees that the MPLS shim is in
> > the linear area.  When the inner Ethernet header sits in a page
> > fragment, the datapath now claims an Ethernet header it cannot access
> > linearly.
> >
> > Output to an OVS internal vport then calls eth_type_trans(), which
> > pulls ETH_HLEN from an empty linear area and triggers the BUG in
> > __skb_pull():
> >
> >   kernel BUG at ./include/linux/skbuff.h:2830!
> >   RIP: 0010:eth_type_trans+0x335/0x500
> >   internal_dev_recv
> >   ovs_vport_send
> >   do_output
> >   do_execute_actions
> >   ovs_execute_actions
> >   ovs_dp_process_packet
> >   ovs_vport_receive
> >   internal_dev_xmit
> >
> > Conditions to recreate the bug:
> > On a system with 4 KiB pages and CONFIG_OPENVSWITCH and CONFIG_PACKET
> > enabled, use CAP_NET_ADMIN to create an OVS datapath and bring its loca=
l
> > internal port up with MTU 9000.  Install a flow matching an Ethernet/MP=
LS
> > packet with one bottom-of-stack label and actions pop_eth,
> > pop_mpls(0x6558), output to the local port.  With CAP_NET_RAW, send a
> > 4128-byte AF_PACKET/SOCK_RAW frame containing outer Ethernet, the MPLS
> > label, inner Ethernet and 4096 payload bytes.  The two pops consume the
> > linear headers and expose the inner Ethernet header in page fragments.
> >
> > The Fix:
> > Pull the inner Ethernet header into the linear area before restoring
> > MAC_PROTO_ETHERNET.
> >
> > Fixes: f66b53fdbb22 ("openvswitch: New MPLS actions for layer 2 tunnell=
ing")
> > Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200=
ea@kernel.org/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/openvswitch/actions.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> > index 27152bca8a8c..03b31e33e880 100644
> > --- a/net/openvswitch/actions.c
> > +++ b/net/openvswitch/actions.c
> > @@ -153,8 +153,11 @@ static int pop_mpls(struct sk_buff *skb, struct sw=
_flow_key *key,
> >       if (err)
> >               return err;
> >
> > -     if (ethertype =3D=3D htons(ETH_P_TEB))
> > +     if (ethertype =3D=3D htons(ETH_P_TEB)) {
> > +             if (!pskb_may_pull(skb, ETH_HLEN))
> > +                     return -ENOMEM;
> >               key->mac_proto =3D MAC_PROTO_ETHERNET;
> > +     }
> >
> >       invalidate_flow_key(key);
> >       return 0;
>
> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
