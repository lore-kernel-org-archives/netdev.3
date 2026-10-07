Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA5263F44
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 00:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791333092; cv=pass; b=Oze6SskLnhvy3bO/gBaBUjLoS7TKA/+6GsFOtFoUzWdpKv/wWEaVoPPJJVqW12HWLJYNyPSKqB50QWO+lcJl2mBN+TGx1mussety3twXFt5Ng5OBX+PKvaFQuTrs46jOa3NHkRd53ONM5PbdY2Lydyu5lgZjG1ldQ6t4Ih47Iew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791333092; c=relaxed/simple;
	bh=niOAy71+vwLxeNDu7irEi8aD74bqAPYxK3A5TWs5LFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4ZpDp4HeJS3g5nOHoWqdlDMW+DPN/llkaLBhlKLOuMDWXbnw6eyZKjyXcd516anS4ruQ4h+uxwEb7XczpjBpcWovvlNYICam3qxUkxOKpBbyjposqvkDdFfZo9zDMjMFZ511YAzM6xIoJqjmbQVxp6uBwLjig9gw/oi5pNiNdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTrGIDcP; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTrGIDcP"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8acda240937so12900107b3.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 17:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791333090; cv=none;
        d=google.com; s=arc-20260327;
        b=ha3J/1PyAEMcG7hiA18epMkCfEcYyUft+vE7RiNUxUrTFhytchfXHzMYXmis4bMyXj
         803HJK4lyDX0QsQb6apafQLjpDhixKeRcQ19cjsU1xJrQ7MfMBFqHLYLk6iLrmE8s362
         ldCW6QNv6TXLkq2jTpMNy2VN/10ggQqIVST4Jji22j9jq2z2W0N+hLfrm2xr9bGTUYWz
         dTu4p+34krfOczOnQ4NVcp3yJa2oT8ft7RFW9Pb4QI5um6wbsWuI6tJRkE8TcFjOWAlH
         14QNQ+pf7oEttJXZvcvrw9GttQ2PcKNsxUTohlamLjg0D0y5RNc9+5zZR6SUp+6QTHvH
         MpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AXsj4IEY3ClB/Ign26yPSnLd9Ut+UmSEbaB0ddJSUPI=;
        fh=8zRtZHbmPfKVnzV1VCa8UNwoNCjx0yOj4TQZSYuRRsw=;
        b=rcp82pnA4rJhEwQoAAiVf3wSUZEhRo/8Ny+PAB49YKKpZ20AGffdwR7sQJSX0kFaVd
         xaJuiVbC+c1v7uz9ToZK5rj4fu6ttA905hOKppUpItmTKtDgjLfKEtlOMZFisnchn1D6
         Hw4dHIc6Paqyups46N99V4ydVmWcFkc3rfDXjran/wWZH5mTiRtnDV6+Sob+pyPQLPyI
         +bbOZqkGBixl6RL2OozsXqEKw/p9RVEIVky9ljIOIoz7GXr8fFnVfDq1zGKmEE8X37L4
         1j4QyM2qyt71q2cR/z1r6tqIABKEu535sraUhrdI3mzW5aGOk/OfBZBIx2f6cKmwoD6S
         rYIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791333090; x=1791937890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AXsj4IEY3ClB/Ign26yPSnLd9Ut+UmSEbaB0ddJSUPI=;
        b=fTrGIDcPqmdTkWtbbOIfKzpS9/6BtWwMlN8HoZRnzcR14sFTRJt245r8BidGvh1bTj
         DuVVB9XaTGTuWgzJpP3DI/6AUUPOqc8B0T7t2ajg0lyIBhyYmhpeiozDdJ60L+3nh/7W
         T5Im8QWVXP7BnOamNgli/qEg2HIB7WwI5cxdvWVQ18Ox9MrZ+bg0Ykf2RC6R3prDY1Ze
         476yuhiAE/87NsCDcdzDzs0xpr04Svlh8jTDj80KGisifO9MvX6YAC5ARQE+SuAHIyyP
         CDb8IM8f1OJ7eIB5jLKL7nsq2yaFr4xJ0R3LFxX7sg47Tuu795biye7S3pwYkpKEnmWA
         Kdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791333090; x=1791937890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AXsj4IEY3ClB/Ign26yPSnLd9Ut+UmSEbaB0ddJSUPI=;
        b=b+D/xJs0bweqvgL173wODxI4uWQFWF7NdKCKBV16MEJR+v2JHe6XLEIZ5YzLBRkxsl
         ssDqt+uVMC1rkGpSmXpgfACdnH/k3FLFiR1V6zHzr4eT1RLLFz+i2+21hBZqqPDLRiEc
         4jn2HIP8W/gydIFGe+XNPUoQllxzLtUDoZFF7chgny273JNKDQp+ywIeGjn/UR0mw/3h
         Y+eEikLO85gmRAx5js4iptGENoVgYk4+rR34qAPJO7891qVrBCcKS6vchacD/oOfjSOk
         aEObOLmVGGUAy619QXEMqn+X7817EVd/R9gG+6Cn2a3d4T1LHr0qcjzBLmQpCpYY8c70
         rNZw==
X-Forwarded-Encrypted: i=1; AKwUvByH5CImr2LbE0Lg6zOtD6u11wIJ6zt2Or2/ZhcnMBacEAUhge6YGY5/xl62hksn19YwR0qpRQA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOPOFTKRPNP557lDhwBk6ooauAAKrcyk6caDo9NTD3tuc3vGNq
	tTUzMaSkqSBf0OMB6bKgmdXGfV27gdHx2aWXpxqQmgeF+a5AaSNRt07y4Bnu3iwAZ6aOpXvY8NV
	EADzb5orr+mTZyMA4iRCv21hrs+Mrofg=
X-Gm-Gg: AYBFou3FQEi3FfOUu4UjbuhaLybUkbdxu9COTKGjiMujs4nq5bXl6M8FfBZ059kZRRC
	SBSgHHOv11EUbKYoYfSFGHkooxxiqM8hxCyIWuF+32/GLTROIhSVe+azX6fGThKsGs4dGb+adTk
	7fnwH0H3HwSA73O6mFIdFWYtaWP7UlMVJ9l2GPv9XnGWdvatKN377NbGOhVOZbKGbboxgsEyjgp
	/z2/ARMhKUVAymB0bhvZljcVVlPIwYI1JPewx3eUCaURajZNSQwYzXSuxWrbpU2LLsZvedMbwiO
	KyzsfwZ5ca0SPfkljbw0RKc5Dls8yVVObf3q31lUW3ZJG6txweYNbQj3AdzgwU4sgh/IbFiyfWF
	tOPUgeO8LRIKJ
X-Received: by 2002:a05:690e:1248:b0:675:34b8:78a2 with SMTP id
 956f58d0204a3-6790a3cf36bmr459923d50.92.1791333089372; Tue, 06 Oct 2026
 17:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001191140.2818991-1-edumazet@kernel.org> <20261006183410-mutt-send-email-mst@kernel.org>
 <CAF=yD-K2Lq_TAbN0=vpRZQrcp_R9Vu4E7frixWeBO2ehBQHdiw@mail.gmail.com>
 <20261006194851-mutt-send-email-mst@kernel.org> <CAF=yD-KeGZFmcb4v1PMjhTZghTQgtCwSQqejne8qad0W5KaJBQ@mail.gmail.com>
 <20261006201729-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261006201729-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 6 Oct 2026 20:30:50 -0400
X-Gm-Features: AclHuK809EveqtCiNaq5e--JTY7ihVSrHlLis1D0XWamTBEJhvTEDYYOvl1CucQ
Message-ID: <CAF=yD-Lz9KSJ8Z8Fz8EF_+nmN5ea9k00sweQvvR74HpGCGwVSA@mail.gmail.com>
Subject: Re: [PATCH v3 net 0/3] net: always dissect GSO packets in __virtio_net_hdr_to_skb()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 8:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Oct 06, 2026 at 08:13:43PM -0400, Willem de Bruijn wrote:
> > On Tue, Oct 6, 2026 at 7:50=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Tue, Oct 06, 2026 at 07:26:46PM -0400, Willem de Bruijn wrote:
> > > > On Tue, Oct 6, 2026 at 6:38=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > > >
> > > > > On Thu, Oct 01, 2026 at 07:11:37PM +0000, Eric Dumazet wrote:
> > > > > > This series fixes a bypass of untrusted GSO flow dissection in
> > > > > > __virtio_net_hdr_to_skb() when VIRTIO_NET_HDR_F_NEEDS_CSUM is n=
ot set,
> > > > > > and adds a kselftest covering VLAN-tagged GSO packets without N=
EEDS_CSUM:
> > > > > >
> > > > > > - Patch 1 fixes __skb_flow_dissect(), which computes key_contro=
l->thoff
> > > > > >   with min_t(u16, ...). This truncates skb->len and returns a b=
ogus small
> > > > > >   transport offset when skb->len modulo 65536 is smaller than t=
he
> > > > > >   transport offset. Offsets that do not fit in the u16 thoff no=
w fail the
> > > > > >   dissection instead of being silently truncated.
> > > > > >
> > > > > > - Patch 2 initializes skb->dev and skb->network_header before c=
alling
> > > > > >   virtio_net_hdr_*_to_skb() in tun_get_user(), tun_xdp_one(),
> > > > > >   virtnet_receive_done(), and raw_verify_header(), removes the
> > > > > >   '&& skb->network_header' condition and the unvalidated
> > > > > >   'else if (gso_type)' fallback in __virtio_net_hdr_to_skb(), a=
nd moves
> > > > > >   virtio_net_hdr_match_proto() after skb_flow_dissect_flow_keys=
_basic()
> > > > > >   so it validates the dissected L3 protocol (keys.basic.n_proto=
) rather
> > > > > >   than the outer L2 protocol.
> > > > > >
> > > > > > - Patch 3 adds kselftests in tools/testing/selftests/net/tun.c =
verifying
> > > > > >   that VLAN-tagged (802.1Q) TCPv4 GSO packets without NEEDS_CSU=
M (both
> > > > > >   flags =3D 0 and flags =3D VIRTIO_NET_HDR_F_DATA_VALID) are ac=
cepted on a
> > > > > >   TAP device, that mismatched GSO types and truncated TCP heade=
rs without
> > > > > >   NEEDS_CSUM are rejected with -EINVAL, and that a 65540-byte f=
rame is
> > > > > >   accepted.
> > > > > >
> > > > > > v3:
> > > > > >  - New patch 1: avoid u16 truncation of skb->len when computing=
 thoff in
> > > > > >    __skb_flow_dissect(). Patch 2 makes tun_get_user() dissect I=
FF_TAP
> > > > > >    frames before eth_type_trans(), with skb->len up to 65549 fo=
r a GSO
> > > > > >    frame carrying a maximal IPv4 packet (Sashiko).
> > > > > >  - Patch 3: truncate the TCP header after 10 bytes so that the =
test
> > > > > >    requires the transport offset found by flow dissection, and =
add a
> > > > > >    65540-byte frame test (Sashiko).
> > > > > >  - Link to v2: https://lore.kernel.org/netdev/20260928144254.33=
61044-1-edumazet@kernel.org/
> > > > > >
> > > > > > v2:
> > > > > >  - Patch 2: drop the pre-dissection virtio_net_hdr_match_proto(=
) check
> > > > > >    inside 'if (!skb->protocol)' so VLAN-tagged GSO frames witho=
ut
> > > > > >    NEEDS_CSUM are not rejected before flow dissection (Michael =
S. Tsirkin).
> > > > > >  - Patch 2: clarify the changelog regarding why skb->network_he=
ader was 0
> > > > > >    in those callers and why skb_reset_mac_header() is dropped i=
n
> > > > > >    tun_get_user() for IFF_TUN (Michael S. Tsirkin).
> > > > > >  - Patch 3: add selftest in tools/testing/selftests/net/tun.c b=
ased on
> > > > > >    Michael's reproducer.
> > > > > >  - Link to v1: https://lore.kernel.org/netdev/20260927195536.24=
89079-1-edumazet@google.com/
> > > > >
> > > > >
> > > > > Not without trepidation about the amount of stuff we are shoving
> > > > > into virtio_net_hdr_to_skb which, believe me or not, used to be 5=
0 LOC
> > > > > of trivial code in 2019:
> > > >
> > > > Unfortunately that let through many bad packets and unintentional
> > > > (ab)uses of the API.
> > > >
> > > > The current state is the result of numerous fixes we had to apply
> > > > since then to protect the kernel. Generally there are two approache=
s:
> > > >
> > > > 1. make every reachable path in the kernel robust against unexpecte=
d
> > > > input. Frequently that means checks in the hot path that penalizes =
all
> > > > normal traffic, only to catch a bad actor or fuzzer. And it's not
> > > > straightforward to prove that all reachable paths are protected.
> > > > 2. strict input validation.
> > > >
> > > > With strict input validation from the start the checks could have b=
een
> > > > simpler (hindsight is 20/20). Unfortunately, now we are stuck with
> > > > weird input (GSO without NEEDS_CSUM, skb protocol 0, encapsulation
> > > > headers, ..) that we now have to work around and try to not break,
> > > > that may or may not have real users.
> > > >
> > > > This patch actually makes the function simpler. By reducing the
> > > > differences between the various callers of the function. This is gr=
eat.
> > > >
> > > > It sucks how complex this function has become, hopefully we can
> > > > find more such ways of making it simpler. The strict validation its=
elf
> > > > is a good thing imho.
> > >
> > >
> > > Yes indeed. I have a vague idea how to do it: check some
> > > performance-critical types of packets and for the rest just calculate
> > > the checksum then and there.
> >
> > That sounds promising.
> >
> > Checksumming is only one of the risks. Segmentation is another.
>
> Same approach for segmentation would be great but how do we know how to
> segment at input?

gso_type?

The main issue I see is that we do not have a way to then process the
chain of segs. So maybe we cannot realistically do it at this stage.

Come to think of it, I previously considered this and ended up with
commit 121d57af308d ("gso: validate gso_type in GSO handlers")
instead.
