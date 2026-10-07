Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741994A4407
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382933; cv=pass; b=nQi8DbfMCyUlMC8rPml3pSAEeeF4J7qb4bxo/PsehxB5AydeTRASuhzVs2HvnO54hBdXY/VvhNHA5+/YF1KL+5oo6p+BOrtrDAOIm1rM3HN6W/Dy7/i4YDUuOPuZRygWChquEFiCAFm8IutsIFMNV3opXdHxkcOhL9O4YHkTSSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382933; c=relaxed/simple;
	bh=MJsKIawVXjsmFhZJhsUaSCOnlwobYF89f5Ga0V+6nTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbNlFqjNFNYLr4eFKdHS8z2IA0/sttJiDDU7arZL770rVa5W4FJsGPM6FSdIFoOR9VLE0+YPZt76vyZUrxaPQTeM4s1knjyoBIZX/DueVxFGL99deFvnaTu8tZS58idyyHPCqQawY3J2Y8+ON0y15D0LzlQZOi1rWRLAvVKpPkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgFyidqg; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgFyidqg"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6776efd4ff1so2205016d50.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 07:22:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791382923; cv=none;
        d=google.com; s=arc-20260327;
        b=JCnGkC1pPhgapYqGp2eY7fTZRokCCtpzfoneEUMHfiof4zD077VVmpjvoamApw19Q9
         +9grTwDfKzAauXLaw8G8NxMcUD/PVXbj3BM6pZfH/ZvmHHniHe4Y1/qJBzNpN4N9SQQS
         7NhqPzK+qgTwnlvJQdnypV8tNheQ4HVnetTXYrLE51C1eqFndhJvQMtNIigfT3z5c+GE
         fmV01ADcbIRKeVDmd+6Z3z31dB/DNCAj1bPHi6Fj7eb8B4abe4wE5fHd5maAx1Wh6qUA
         uU3X966QC/c5rMXtvh7iLqdalg9YGmgZwdGGopsptiFI3uoVfhwj5OpKIaecBGdv2Uaj
         bQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2cJffw6eGB5EOl6vnbpaCrfAjHs5zJAqvpLEIF2jfeo=;
        fh=5AhT052GabHOWkkuFtzMGNrCAICacIKhsCi/CfLq/B0=;
        b=aSacUpif8qVQv08raPbeflfyVKFd+QZzfXJ2dCr5MuFSiNpAjqHkFTaHlk1X27Uzj4
         8c7YUJTcPZ/8CxbmUpNG6tcJI2zr16VD+d23wqZ9HfEfQDUvfInQaaxNmRnSKSXjFzFb
         6wErLF1b9Mc3QPKY/rt3LYfwrao/pXWNVJJ/dHuC+ip5wfEU56sbcC6eH8N9387rqTsY
         BA4nABvGyBfRxQDAWg2yR1460PF0tbxVO8LAsOk6Qxx1L83wWbRFxikLO9lDDjPG3wGp
         ETA7VhHCGK2LXvvnIjCWfG6xjGrOOGe7DpkcJoJP0v2k5gwKIDpvYrOB+bBFZpflGIrc
         YHug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791382923; x=1791987723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2cJffw6eGB5EOl6vnbpaCrfAjHs5zJAqvpLEIF2jfeo=;
        b=KgFyidqgPQ38o0gfvurwobzkQLYYheIPEuO3baPbXyZ2XUvveOhxhxFZLJjV6mFUOY
         UE2rBchkzQg7fwyrEoM5Qr2YvgB0THNrFL14sSURiMByF6AXg5SRz0CbjdRuRUyKVxkc
         SlwsE9LwovZeSJTyx7qYlY8i1Kx759Zd/y2gSTufXm2LwB/I6EdMi5/3ckUCXb6A7sSG
         rlVsUQ/3SSiB7bMPy+2bSLzABXBR6J5Wpd7T64Tw6J4rKD7LuPfvhbalBKmBSsbsTYmd
         sGy3TIPh4c0yBpm8Ro5KyVdb+vlA+3ugKpC+1bj6YN7AginKCYQfbbG+TLy5Jyw2Hyi4
         zcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791382923; x=1791987723;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cJffw6eGB5EOl6vnbpaCrfAjHs5zJAqvpLEIF2jfeo=;
        b=rzOG4xAyfDGmeMnfYtMVsyfdNGAPZ5U5+2p9e+EkGwA6pfTcaNDWoCnc4TZNY+L3oV
         fgzHV98M4znZbkXoNAUKAciZqab36htdoPsqf04nlCM5IslSVubuUZBaM4AqFAMM67rO
         zMlZ6XDHpcEN6TFT3SwT4wbhoQy0uQXDCKYQgHuBAmkJiHDF683O2guodUb++j6hPGhy
         HX5IWUzoe6GB0cDjiozMt2BbuoqGybWJ6vJxXE/E3D24rzS04qzmmMC2yt0signqI+rY
         CWSxkh2itWq7zgnW8uVdgvNZSteJMrWsriPSQomgp5DBgkiJ1yoUyA6sKdfRXgMLGUAj
         CCTw==
X-Forwarded-Encrypted: i=1; AKwUvBy+QCP09HtbyPEjF/sSCyeXRsWPdk/i/iItW7FB9E5/XOvF1GzvDYKlRtK5UrHt0VBZAcsWfRo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2BeQ8tYW8XN9nbQpH3ICknqblWzcPU+imDr6plOUJ5/c/jgE7
	imT+ivIyWfrDLZ0Qmtj0UDpZLxFQ+wY0ACzoDJioedduHOQJ4oAUKFFV+51/cvUfEh+7PQsYm/x
	C+RzSOv5d+kOGDNgb/Y6NbDMJPjaLCvs=
X-Gm-Gg: AYBFou25tvs1BDzrzHE+S/DaOdDsmg6cVxWRgf8f2PJ/cNT3DvaNVuWUPvDKq5vkfQk
	lpZ/ym6lLL1ijyjJZ0UJYriI9UhvmYCeRcTgl/+gNYU/SAU6mcvNarkvCKGQjCRhotG88gqQ9rx
	+TmHdUwoR16WhXUrDh1H30lGu40ujk9nBvkiBaNhb6yDySqj39Jm91NmDNnqJobc18aNxK77Rwl
	L48YwMhpjJCM0UiUJWPLfp+IZkfydudj3KLBEC0tLX/GQL0RLY8d8tuFNc3bZfLHHWCfPE4LEKZ
	fhBf+l+AahVOKOhrOoFlY1LMKh6UcxCmunI6/6aD2SsFNnjvQNd+VrdZwBV5T6p1CJwU0ZHwMUb
	WwXL3941tuX4PqDl+UCte3Ypg2yWPaR8FEIpB9dkVjk6W2g01BL2Yqs8nZ8Pb72ZB+gendLMQnj
	u+
X-Received: by 2002:a53:acc8:0:20b0:676:8c21:8a85 with SMTP id
 956f58d0204a3-6790a0f6a33mr1186320d50.3.1791382922957; Wed, 07 Oct 2026
 07:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001191140.2818991-1-edumazet@kernel.org> <20261006183410-mutt-send-email-mst@kernel.org>
 <CAF=yD-K2Lq_TAbN0=vpRZQrcp_R9Vu4E7frixWeBO2ehBQHdiw@mail.gmail.com>
 <20261006194851-mutt-send-email-mst@kernel.org> <CAF=yD-KeGZFmcb4v1PMjhTZghTQgtCwSQqejne8qad0W5KaJBQ@mail.gmail.com>
 <20261006201729-mutt-send-email-mst@kernel.org> <CAF=yD-Lz9KSJ8Z8Fz8EF_+nmN5ea9k00sweQvvR74HpGCGwVSA@mail.gmail.com>
 <20261007035758-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261007035758-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 7 Oct 2026 10:21:25 -0400
X-Gm-Features: AclHuK9ZIYNAUWORHw9JTzctI_z7hbwCtdAmEM8ci8H3DknDZtTfg2-kziMuSYw
Message-ID: <CAF=yD-+Dy7vueCqdsLEkcibopXHaxTZ6D0cRek6KeFu4_s-hLQ@mail.gmail.com>
Subject: Re: [PATCH v3 net 0/3] net: always dissect GSO packets in __virtio_net_hdr_to_skb()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 4:04=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Oct 06, 2026 at 08:30:50PM -0400, Willem de Bruijn wrote:
> > On Tue, Oct 6, 2026 at 8:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Tue, Oct 06, 2026 at 08:13:43PM -0400, Willem de Bruijn wrote:
> > > > On Tue, Oct 6, 2026 at 7:50=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > > >
> > > > > On Tue, Oct 06, 2026 at 07:26:46PM -0400, Willem de Bruijn wrote:
> > > > > > On Tue, Oct 6, 2026 at 6:38=E2=80=AFPM Michael S. Tsirkin <mst@=
redhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 01, 2026 at 07:11:37PM +0000, Eric Dumazet wrote:
> > > > > > > > This series fixes a bypass of untrusted GSO flow dissection=
 in
> > > > > > > > __virtio_net_hdr_to_skb() when VIRTIO_NET_HDR_F_NEEDS_CSUM =
is not set,
> > > > > > > > and adds a kselftest covering VLAN-tagged GSO packets witho=
ut NEEDS_CSUM:
> > > > > > > >
> > > > > > > > - Patch 1 fixes __skb_flow_dissect(), which computes key_co=
ntrol->thoff
> > > > > > > >   with min_t(u16, ...). This truncates skb->len and returns=
 a bogus small
> > > > > > > >   transport offset when skb->len modulo 65536 is smaller th=
an the
> > > > > > > >   transport offset. Offsets that do not fit in the u16 thof=
f now fail the
> > > > > > > >   dissection instead of being silently truncated.
> > > > > > > >
> > > > > > > > - Patch 2 initializes skb->dev and skb->network_header befo=
re calling
> > > > > > > >   virtio_net_hdr_*_to_skb() in tun_get_user(), tun_xdp_one(=
),
> > > > > > > >   virtnet_receive_done(), and raw_verify_header(), removes =
the
> > > > > > > >   '&& skb->network_header' condition and the unvalidated
> > > > > > > >   'else if (gso_type)' fallback in __virtio_net_hdr_to_skb(=
), and moves
> > > > > > > >   virtio_net_hdr_match_proto() after skb_flow_dissect_flow_=
keys_basic()
> > > > > > > >   so it validates the dissected L3 protocol (keys.basic.n_p=
roto) rather
> > > > > > > >   than the outer L2 protocol.
> > > > > > > >
> > > > > > > > - Patch 3 adds kselftests in tools/testing/selftests/net/tu=
n.c verifying
> > > > > > > >   that VLAN-tagged (802.1Q) TCPv4 GSO packets without NEEDS=
_CSUM (both
> > > > > > > >   flags =3D 0 and flags =3D VIRTIO_NET_HDR_F_DATA_VALID) ar=
e accepted on a
> > > > > > > >   TAP device, that mismatched GSO types and truncated TCP h=
eaders without
> > > > > > > >   NEEDS_CSUM are rejected with -EINVAL, and that a 65540-by=
te frame is
> > > > > > > >   accepted.
> > > > > > > >
> > > > > > > > v3:
> > > > > > > >  - New patch 1: avoid u16 truncation of skb->len when compu=
ting thoff in
> > > > > > > >    __skb_flow_dissect(). Patch 2 makes tun_get_user() disse=
ct IFF_TAP
> > > > > > > >    frames before eth_type_trans(), with skb->len up to 6554=
9 for a GSO
> > > > > > > >    frame carrying a maximal IPv4 packet (Sashiko).
> > > > > > > >  - Patch 3: truncate the TCP header after 10 bytes so that =
the test
> > > > > > > >    requires the transport offset found by flow dissection, =
and add a
> > > > > > > >    65540-byte frame test (Sashiko).
> > > > > > > >  - Link to v2: https://lore.kernel.org/netdev/2026092814425=
4.3361044-1-edumazet@kernel.org/
> > > > > > > >
> > > > > > > > v2:
> > > > > > > >  - Patch 2: drop the pre-dissection virtio_net_hdr_match_pr=
oto() check
> > > > > > > >    inside 'if (!skb->protocol)' so VLAN-tagged GSO frames w=
ithout
> > > > > > > >    NEEDS_CSUM are not rejected before flow dissection (Mich=
ael S. Tsirkin).
> > > > > > > >  - Patch 2: clarify the changelog regarding why skb->networ=
k_header was 0
> > > > > > > >    in those callers and why skb_reset_mac_header() is dropp=
ed in
> > > > > > > >    tun_get_user() for IFF_TUN (Michael S. Tsirkin).
> > > > > > > >  - Patch 3: add selftest in tools/testing/selftests/net/tun=
.c based on
> > > > > > > >    Michael's reproducer.
> > > > > > > >  - Link to v1: https://lore.kernel.org/netdev/2026092719553=
6.2489079-1-edumazet@google.com/
> > > > > > >
> > > > > > >
> > > > > > > Not without trepidation about the amount of stuff we are shov=
ing
> > > > > > > into virtio_net_hdr_to_skb which, believe me or not, used to =
be 50 LOC
> > > > > > > of trivial code in 2019:
> > > > > >
> > > > > > Unfortunately that let through many bad packets and unintention=
al
> > > > > > (ab)uses of the API.
> > > > > >
> > > > > > The current state is the result of numerous fixes we had to app=
ly
> > > > > > since then to protect the kernel. Generally there are two appro=
aches:
> > > > > >
> > > > > > 1. make every reachable path in the kernel robust against unexp=
ected
> > > > > > input. Frequently that means checks in the hot path that penali=
zes all
> > > > > > normal traffic, only to catch a bad actor or fuzzer. And it's n=
ot
> > > > > > straightforward to prove that all reachable paths are protected=
.
> > > > > > 2. strict input validation.
> > > > > >
> > > > > > With strict input validation from the start the checks could ha=
ve been
> > > > > > simpler (hindsight is 20/20). Unfortunately, now we are stuck w=
ith
> > > > > > weird input (GSO without NEEDS_CSUM, skb protocol 0, encapsulat=
ion
> > > > > > headers, ..) that we now have to work around and try to not bre=
ak,
> > > > > > that may or may not have real users.
> > > > > >
> > > > > > This patch actually makes the function simpler. By reducing the
> > > > > > differences between the various callers of the function. This i=
s great.
> > > > > >
> > > > > > It sucks how complex this function has become, hopefully we can
> > > > > > find more such ways of making it simpler. The strict validation=
 itself
> > > > > > is a good thing imho.
> > > > >
> > > > >
> > > > > Yes indeed. I have a vague idea how to do it: check some
> > > > > performance-critical types of packets and for the rest just calcu=
late
> > > > > the checksum then and there.
> > > >
> > > > That sounds promising.
> > > >
> > > > Checksumming is only one of the risks. Segmentation is another.
> > >
> > > Same approach for segmentation would be great but how do we know how =
to
> > > segment at input?
> >
> > gso_type?
> >
> > The main issue I see is that we do not have a way to then process the
> > chain of segs. So maybe we cannot realistically do it at this stage.
>
> I mean, there are what, 8 callers of this? That's much less of
> a brain surgery than carefully calculating offsets within packets
> as far as I am concerned.

We can definitely take a stab.

Another option is to convert from an untrusted GSO packet
(SKB_GSO_DODGY) into a GSO packet that has been validated
through the software segmentation check. The

```
        if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
                /* Packet is from an untrusted source, reset gso_segs. */

                skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(skb->len, mss);

                segs =3D NULL;
                goto out;
        }
```

Path in tcp_gso_segment (and similar for USO). Packets still only
go through software segmentation once, which all these untrusted
packets do (__virtio_net_hdr_to_skb always sets SKB_GSO_DODGY).

A variant of that is to convert from untrusted GSO to trusted chain
of segments that are very cheap to segment later, SKB_GSO_FRAGLIST.

But just changing the callers to loop over segs[] can certainly be
done too.
