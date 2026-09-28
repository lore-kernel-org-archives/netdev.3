Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B6D3ACF02
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577126; cv=none; b=peqxO3r/JTeVWuIIAL5iXsw/t2tJFP5Z8uYgU3axx0yPwi+07mBE2LN+Qu9L9cS5MYWlhY+rYD7U1LNRYnSHi3mtUlxQJDNbHmpdORtHreex0DU8vnLsjo6YnwD281gNrpsE6Yx7i9Tc16/jzoitr4IzTrgZsHQ0kUYnCfRy3lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577126; c=relaxed/simple;
	bh=RmomwUPDKd96ikbhLblsui1bL0lSJDGXpIlo2YQmnAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UClBbycMaUTNxecvGJKIab+W/Zs5uFXtW4rg7iyv+0XfUjs4XDJP14pkOipgEjuoxa8bMFpJgxKAGpSX3V3+q3CXBY1p6csrI0tuNKZ9Srk7YMzHAX/8wTpuOSCALve8ZmSsyhgH8QIqI7e0Qrtlo2PcZMYUz4QvYhXoVec/omQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwP1yUrW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwP1yUrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0311F0089C
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790577125;
	bh=yuBk2325yH7HdBHpbTnzqmIoNbAzHs3sLQzwFJdRbow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cwP1yUrW1sv8gRbzKprMzm4HWBUG4/BGfk6oQMDAA0n5ypSu2uKczUVgnPI5knL8+
	 A7ytPzm7QrFoxDZZLPgMUG0zb9TkrGK+g2+8FUA1AsgHNrtDdsUpzS4ZGDdyv/1HWD
	 JCR62Ca1//V1IZF6ANkiJH5NtjC9kucZw+FA6SZmePWwjHr8W4xLNV0MCB6CJj3vm/
	 YYZ9SZzsWsDhJnEQoA2XcPVIJ08OnSf5Gja2+lBcyZOgspyKDxvLlp6wingb7SdsYA
	 /pRI2TtW+wKCwEDF90RrGfnksym+cmt0PiwEZO89DExVhdwquv3G3qC/ro+mtXvERK
	 nXW06k3yrkIPw==
Received: by mail-oa2-f34.google.com with SMTP id 586e51a60fabf-49499f845edso292170fac.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:32:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz0u6zEW7FSMA42tjOWFzakT+6Zs2YZgu7we6i1q/ESbeOfXRgSSG8pOAjnq5ZD9uYFM76iYlQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nRj2ukhtTZYKh7cgm2BdPisKys6lIYA+pxWLFPqHBtGQ5HNcnz
	MlRk7cTNfFfiyP7YFpc4mTktN5YEGe+Bl06L6hUiVenK1IZ5b42u2GPpey91qQu8iXHYoIA7STx
	sZEm/rTTvUpTNDLTrjd+p/jGPm+rJvX0=
X-Received: by 2002:a05:6870:d0c8:b0:475:e0a7:9f2e with SMTP id
 586e51a60fabf-49357ced2ccmr8072193fac.28.1790577124686; Sun, 27 Sep 2026
 23:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927195536.2489079-1-edumazet@google.com> <20260927212942-mutt-send-email-mst@kernel.org>
 <CAL4Wiio9juqXbKZ7gsv8G=siXsdCwHtn0pYRpx-74akkamJvdA@mail.gmail.com>
In-Reply-To: <CAL4Wiio9juqXbKZ7gsv8G=siXsdCwHtn0pYRpx-74akkamJvdA@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 28 Sep 2026 08:31:53 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqLV8GFDiUak5i8DyGR9b6PN3yy81iLcdmZAbkJxAHM1w@mail.gmail.com>
X-Gm-Features: AclHuK91kmOOHFLPFqKxqNv_axpM_S9RQHBHF19JlIzaZbj2nIF6Ap2_PRYHzsg
Message-ID: <CAL4WiiqLV8GFDiUak5i8DyGR9b6PN3yy81iLcdmZAbkJxAHM1w@mail.gmail.com>
Subject: Re: [PATCH net] net: always dissect GSO packets in __virtio_net_hdr_to_skb()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Weiming Shi <bestswngs@gmail.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:22=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> On Mon, Sep 28, 2026 at 3:31=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Sun, Sep 27, 2026 at 07:55:36PM +0000, Eric Dumazet wrote:
> > > Commit 9e8db5913264 ("net: avoid false positives in untrusted gso
> > > validation") added a '&& skb->network_header' check before flow-disse=
cting
> > > GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM in
> > > __virtio_net_hdr_to_skb(), because some callers (such as tun_get_user=
(),
> > > tun_xdp_one(), virtnet_receive_done(), and raw_verify_header()) calle=
d
> > > virtio_net_hdr_*_to_skb() before initializing skb->network_header and
> > > skb->dev.
> > >
> > > However, skb->network_header is an offset from skb->head, not a boole=
an
> > > flag. When skb_headroom(skb) is 0 on a device without L2 headers (for
> > > instance packet_snd() or tpacket_snd() on a tunnel/pure-L3 device whe=
re
> > > LL_RESERVED_SPACE_EX(dev, 0) =3D=3D 0),
> >
> > Hmm. I have:
> >
> > LL_RESERVED_SPACE_EX(dev, 0)
> >         ((((hlen) + READ_ONCE((dev)->needed_headroom)) \
> >           & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
> >
> > #define HH_DATA_MOD     16
> >
> > So how can LL_RESERVED_SPACE_EX(dev, 0) =3D=3D 0 ?
> >
> >
>
> In practice, skb->network_header was 0 on tun_get_user() (including the
> reported reproducer), tun_xdp_one(), virtnet_receive_done(), and
> raw_verify_header() because __alloc_skb() / __build_skb_around()
> zero-initializes skb->network_header to 0 (unlike mac_header and
> transport_header which are initialized to ~0U), and those callers invoked
> virtio_net_hdr_*_to_skb() before setting skb->network_header.
>
> More generally, because 0 is both the initial value from alloc_skb() and =
a
> valid offset whenever skb_headroom(skb) =3D=3D 0, skb->network_header can=
not
> be used as a boolean to test whether the network header was initialized.
>
> I can send a v2 with the corrected commit message if preferred, the
> patch stays the same.

Revised changelog would look like this, let me know if it looks ok this tim=
e.

net: always dissect GSO packets in __virtio_net_hdr_to_skb()

Commit 9e8db5913264 ("net: avoid false positives in untrusted gso
validation") added a '&& skb->network_header' check before flow-dissecting
GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM in
__virtio_net_hdr_to_skb(), because some callers (such as tun_get_user(),
tun_xdp_one(), virtnet_receive_done(), and raw_verify_header()) called
virtio_net_hdr_*_to_skb() before initializing skb->network_header and
skb->dev.

Because __alloc_skb() and __build_skb_around() zero-initialize
skb->network_header to 0 (unlike mac_header and transport_header which
are initialized to ~0U), those four callers always had
skb->network_header =3D=3D 0 and bypassed flow dissection in
__virtio_net_hdr_to_skb(). More generally, skb->network_header is an
offset from skb->head (where 0 is also a valid offset whenever
skb_headroom(skb) is 0), not a boolean flag.

Whenever the 'if (gso_type && skb->network_header)' branch was skipped,
the fallback 'else if (gso_type)' only pulled nh_min_len + thlen (40 bytes
for TCPv4) without dissecting the packet, without validating ip_proto or
n_proto, and without setting skb->transport_header.

If the packet has a malformed network header, it is not rejected and a
subsequent skb_probe_transport_header() also fails, leaving
skb->transport_header at ~0U (0xffff). Similarly, if an IPv4 packet
carries IP options (ihl > 5) or an IPv6 packet carries extension headers,
pulling only nh_min_len + thlen can leave the TCP header outside
skb->head. In both cases, tcp_hdrlen(skb) in skb_gso_transport_seglen()
reads out-of-bounds:

  BUG: KASAN: slab-out-of-bounds in skb_gso_transport_seglen
  Read of size 2 by task poc/133
  skb_gso_transport_seglen (net/core/gso.c:155)
  skb_gso_validate_mac_len (net/core/gso.c:270)
  tbf_enqueue (net/sched/sch_tbf.c:260)
  dev_qdisc_enqueue (net/core/dev.c:4227)
  __dev_queue_xmit (net/core/dev.c:4884)

In addition, when skb->protocol is pre-set by a caller before
__virtio_net_hdr_to_skb(), 'if (!skb->protocol)' is skipped and
virtio_net_hdr_match_proto() was not checked.

Fix this by:
1. Initializing skb->dev and skb->network_header (plus skb->protocol for
   IFF_TUN) before virtio_net_hdr_*_to_skb() in tun_get_user(),
   tun_xdp_one(), virtnet_receive_done(), and raw_verify_header(). In
   tun_get_user(), drop the redundant skb_reset_mac_header(skb) in the
   IFF_TUN case since __virtio_net_hdr_to_skb() unconditionally resets
   mac_header.
2. Removing '&& skb->network_header' and the unvalidated
   'else if (gso_type)' fallback in __virtio_net_hdr_to_skb() so all GSO
   packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are flow-dissected, have
   their transport header pulled into linear data, and have
   skb->transport_header set.
3. Validating virtio_net_hdr_match_proto(keys.basic.n_proto, hdr_gso_type)
   after skb_flow_dissect_flow_keys_basic().
