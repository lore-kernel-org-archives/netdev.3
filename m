Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879669;
	b=uHfdmpBguN2xed/T+QyALDZW5/OeVcoj2n1XYnpUDT/5PpAvsf/CUbRUAVOdU+1cqmPB
	 YLFPApk5+vOUowvnyU7NTaMapT7ptnnH0fsbvh8wNDonljp5S7y4GTbiutqitPcqoZcAU
	 gBmfGNa94LnwNPIBI+8VB0JQbyVaEqJrGRjn0o/MME+NK+sGOhUq0SfCYu/Br4yv2qupt
	 KQcYkouDYdD+FeNnjnwne5tyloBWVfdg193LDwxeQTyKXPQmykVOr9W6xjhcFlCRZzEmo
	 lRTff2mZQO4USTlwwp+EOBaw7ezjByZI4nT5gFSaMuyyqybPY7iWKUkwfIF3VQNXYdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879669;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=9QbVFt2hlPhcZEm3mRTztj/H+Fc6Cn/Nf/eAUAf8Ebs=;
	b=NfgRAhPYX6kxZaSERJk/G5dxIQMbSwjnamqz7+Vq6nksHB8kyeGbNVU6sLbA3hUJnG3j
	 8IOwQKuPJ+Bv2lR4euG9WVuMjzqIEELx7YrmkM4RvbsKc0o+KUuSyS3iXXRiC1rVbyt8K
	 NhmmB8c+yr86Zm98MNxP9SLiJyvOq4xmDUxuU9/UL9wPeCfzRdxyZfTnA7PgO3S54F1b0
	 o4QozP82rlVersGyc6GRNjtBDGOyZ0iz4FmXP4+TN9dNGjfOnMsiARw+Qz86J6lqXr1q1
	 RlvIYduurUz9F6YfAezdYlXJuHHgLjrpL1CPfb0Ufp9/Pqa2klEfJy2hX+92YXEh3ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkvK9xJR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3D606A33E
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkvK9xJR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439DD1F00A02
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 11:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879668;
	bh=9QbVFt2hlPhcZEm3mRTztj/H+Fc6Cn/Nf/eAUAf8Ebs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kkvK9xJRShfJ5INlF6DkKs4ae3tUVWLFJZCWoy/ibAMHaZUQXzz+yq493D8r2NoTT
	 0x4+9ZG/PxVHLN4cl4bSX2GgRUlmvMKCY1cNjebacYfjRgvAP4fTcSeOi3yn5Hm+jR
	 JuJYTyJSeRdXOymmT1iCeHZ/2ruzphDpVXSgFlH4882gcAfWy4Tb9iqclR0Z2BhpaS
	 BW6hbBVScJJ1JljH1Aa/WmAXRiQu8G/hsC1EgABO7sI81XXprzIaGkmeZdwLvt8TMj
	 xChAJIEnR59D2COtkB/N6ElTtN6d5UFDrR7UmXrH1Bc0MZUssXIG4pIAR0OfRiGFPx
	 K/yIGsV9W7NXQ==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8479f46ecd8so786151a34.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 03:54:28 -0800 (PST)
X-Gm-Message-State: APuU4Z/gL2nNGUbpPCRt31d2oG4H8hLxHec/QX3MUt5L2NMj5txCeIB2
	+PO6hhyK80RyA8f9MQJME7GdSVXw7niJ5mCbmAKKMTKNfrAdhb7MXB+SZXP/MUJYD32gBaJQGGG
	DlfpSbfIzR9jlc7rE3GdDLEo0eHl43RE=
X-Received: by 2002:a05:6830:4424:b0:83f:f24d:fe19 with SMTP id
 46e09a7af769-85d362ea353mr15326377a34.3.1793879667558; Thu, 05 Nov 2026
 03:54:27 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104050131.629967-4-edumazet@kernel.org> <179387332145.488856.1149073246990672028@kernel.org>
In-Reply-To: <179387332145.488856.1149073246990672028@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 5 Nov 2026 12:54:15 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqNYh-FQziPMhg0jeAZ+tCGEwr49mtypAz+QoVfNzPtNA@mail.gmail.com>
X-Gm-Features: AclHuK-Uaf0JVD2MbKUpokQNMNsj34pabP7ciYh30gRs4WUQbUX3FXhmYMX5luA
Message-ID: <CAL4WiiqNYh-FQziPMhg0jeAZ+tCGEwr49mtypAz+QoVfNzPtNA@mail.gmail.com>
Subject: Re: [PATCH net v2 3/3] selftests: net: tun: test outer protocol of
 UDP tunnel GSO packets
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, mst@redhat.com, 
	eperezma@redhat.com, hassansultan@google.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 5 nov. 2026 =C3=A0 11:08, <netdev-bot+sashiko@kernel.org> a =C3=A9c=
rit :
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The new tun_vnet_udptnl_proto and tun_vnet_udptnl_proto_l3
>   tests do not work on big-endian hosts.
> - [Low] The new comment in virtio_net_l4_start()
>   (include/linux/virtio_net.h) says the code does something it does not.
>
> --
>
> selftests: net: tun: test outer protocol of UDP tunnel GSO packets
>
> This adds tun selftests that write single 4in4 Geneve GSO frames to tap
> and IFF_TUN devices with UDP tunnel offloads enabled. They check that
> frames with a matching outer IPv4 header are accepted. They also check
> that a mismatched outer ethertype, tun_pi protocol or IP version is
> rejected with EINVAL.
>
> > diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftest=
s/net/tun.c
> > index 34de2580e32ec..81410afbbcc8d 100644
> > --- a/tools/testing/selftests/net/tun.c
> > +++ b/tools/testing/selftests/net/tun.c
> > @@ -683,6 +683,275 @@ TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum_64k)
>
> [ ... ]
>
> > +static int build_udptnl_frame(uint8_t *buf, bool vlan, uint16_t l3prot=
o,
> > +                           int payload_len)
> > +{
> > +     struct virtio_net_hdr_v1_hash_tunnel *vh =3D (void *)buf;
> > +     int vlan_len =3D vlan ? 4 : 0;
> > +     int hlen =3D ETH_HLEN + vlan_len + UDP_TUNNEL_GENEVE_4IN4_HDRLEN;
> > +     uint8_t *outer_udph, *cur =3D buf;
> > +     int pktlen;
> > +
> > +     /* The buffer is reused: do not leave bytes from a previous frame=
. */
> > +     memset(buf, 0, TUN_VNET_TNL_SIZE + hlen + payload_len);
> > +
> > +     cur +=3D build_virtio_net_hdr_v1_hash_tunnel(cur, true, hlen, 140=
0,
> > +                                                AF_INET, AF_INET);
> > +     vh->outer_th_offset +=3D vlan_len;
> > +     vh->inner_nh_offset +=3D vlan_len;
> > +     vh->hash_hdr.hdr.csum_start +=3D vlan_len;
>
> [Severity: Medium]
> Do these new tests work on big-endian hosts? In struct
> virtio_net_hdr_v1_hash_tunnel, outer_th_offset and inner_nh_offset are
> __le16. Here they get native-endian arithmetic, applied on top of the
> host-order values that build_virtio_net_hdr_v1_hash_tunnel() in
> tuntap_helpers.h already wrote:
>
>     vh_tunnel->outer_th_offset =3D eth_hlen + outer_iphlen;
>     vh_tunnel->inner_nh_offset =3D vh_tunnel->outer_th_offset + ETH_HLEN =
+
>                                  GENEVE_HLEN + sizeof(struct udphdr);
>
> The kernel always decodes the tunnel offsets as little-endian. csum_start=
,
> on the other hand, follows the tun vnet endianness:
>
> include/linux/virtio_net.h:virtio_net_hdr_tnl_to_skb() {
>     ...
>     inner_th =3D __virtio16_to_cpu(little_endian, hdr->csum_start);
>     inner_nh =3D le16_to_cpu(vhdr->inner_nh_offset);
>     outer_th =3D le16_to_cpu(vhdr->outer_th_offset);
>     if (outer_th < outer_l3min ||
>         inner_nh < outer_th + sizeof(struct udphdr) ||
>         inner_th < inner_nh + inner_l3min)
>         return -EINVAL;
>     ...
> }
>
> tun_open() never issues TUNSETVNETLE. On s390x or BE ppc64, csum_start is
> therefore read in host order, but outer_th 34 is read as 0x2200 and
> inner_nh 64 as 0x4000. The offset check above then returns -EINVAL before
> virtio_net_tnl_offsets_ok() is reached.
>
> Wouldn't outer_proto_ok then fail on BE? And wouldn't outer_proto_bad
> pass there without ever reaching the new outer protocol validation?
>
> build_udptnl_l3_frame() does the same:
>
>     vh->outer_th_offset +=3D IPV4_OPT_LEN;
>     vh->inner_nh_offset +=3D IPV4_OPT_LEN;
>
> The helper's host-order writes predate this patch, and the existing
> tun_vnet_udptnl tests share the problem. Could these fields be converted
> with htole16()/le16toh() here and in the helper?


Right. build_virtio_net_hdr_v1_hash_tunnel() writes the tunnel offsets
in host order since commit a942fcd72e97 ("selftest: tun: Introduce
tuntap_helpers.h header for TUN/TAP testing"), so all UDP tunnel tests
in tun.c are broken on big-endian hosts, not only the new ones.

v3 adds a patch converting the offsets with htole16() in the helper,
and le16toh()/htole16() where the tests adjust them.


>
> > +
> > +     if (vlan) {
> > +             uint16_t vlan_tag[2] =3D { htons(100), htons(l3proto) };
>
> [ ... ]
>
> The following is about the first patch in this series, commit
> fca58b5faf90 ("net: virtio: validate outer protocol of UDP tunnel GSO
> packets"), which adds the code that the outer_proto_bad tests exercise.
>
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index d6466f96cdd00..b9c8babb1fd73 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
>
> [ ... ]
>
> > +     if (proto =3D=3D htons(ETH_P_IPV6)) {
> > +             const struct ipv6hdr *iph;
> > +             int flags =3D IP6_FH_F_AUTH;
> > +
> > +             if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> > +                     return false;
> > +             iph =3D (const void *)(skb->data + nhoff);
> > +             if (iph->version !=3D 6)
> > +                     return false;
> > +             *thoff =3D nhoff + sizeof(*iph);
> > +             *ip_proto =3D iph->nexthdr;
> > +             if (*ip_proto !=3D IPPROTO_TCP && *ip_proto !=3D IPPROTO_=
UDP) {
> > +                     *thoff =3D nhoff;
> > +                     /* Find the transport header behind any
> > +                      * extension headers, AH included.
> > +                      */
> > +                     *ip_proto =3D ipv6_find_hdr(skb, thoff, -1, NULL,
> > +                                               &flags);
>
> [Severity: Low]
> This isn't a bug, but does this comment in virtio_net_l4_start() match
> what ipv6_find_hdr() does with these arguments?

Same as for patch 1: the comment is wrong, I will fix it in v3.


>With flags =3D IP6_FH_F_AUTH
> and target =3D -1, it stops at the AH header instead of walking past it:
>
> net/ipv6/exthdrs_core.c:ipv6_find_hdr() {
>     ...
>     } else if (nexthdr =3D=3D NEXTHDR_AUTH) {
>         if (flags && (*flags & IP6_FH_F_AUTH) && (target < 0))
>             break;
>     ...
> }
>
> So for an outer IPv6 header followed by AH, ip_proto comes back as
> NEXTHDR_AUTH and virtio_net_tnl_offsets_ok() rejects the frame. The commi=
t
> message says this is intended:
>
>   Unlike the original helpers, ipv6_find_hdr() stops at an AH header,
>   as Willem suggested in the review of that series.
>
> Could the comment say that the walk stops at AH?
>
> > +                     if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> > +                             return false;
> > +             }
> > +             return true;
> > +     }
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261104050131.629967-1-edumazet%40kernel.org
