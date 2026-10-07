Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F154705D
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791332063; cv=pass; b=dNvOnzLKfvks7vj6kW4qOwk43PYhtwj8OVKfHb6dgDXlOEW5IFethuLFDab7PZ9LP+AtgMUmu4XVzkszbtjpTuy1Vyk8UTW7xkj3LNJdJTeeD+vlHlvxpnIiUXE1o90Kdf2LkVRbBMhR2r8ePCiyft5nvnd3b0KBb9gaZqv8mIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791332063; c=relaxed/simple;
	bh=TIgfqF9RHv6zzqxQUzEKGHD8+aRvC9KpTts+/V/IOoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gatD2343PNXaAuz2CPafEXU3BCVIgZ2YwUtSdgyhtXB0fLjpbELD2Ai3+mj5QfZYZdBTvFaQKpVteu07tQke0PsFLw7bnmIZ2iuJx0xGsTRkSphkTtJ2TN87TSn4APdHNsfSpJcmPyoVB82dS8RvwOtW8AvnaZZfXT5L4Mxqzbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuLEACjI; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuLEACjI"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-675617e81f9so1528860d50.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 17:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791332061; cv=none;
        d=google.com; s=arc-20260327;
        b=WfGzll6QmF6DB3YSn+dl8Ty3d1keNuf696H0jRLTavuDU2MsuznCWWEKJOi7qI+q4i
         HRUnkhBQxwqvDfflk+3yeENSAq+hEkcMihZYWntaJES605nK1Hd9ccB0TF0r/ZgQ3XMM
         N6AsoU4B4v9pjU2L5Y2q+Wy+Qlhhv0cH6K6tdLOmseXBK37ZAgvfXiPI4C3GxdN2Vv/4
         F+L6HVBOiiSlTSpEdQyvunTNOEKH4Lbw74e1Oeq8YiY0lExcdj0I9FO9+sZmxwDpNQAO
         On+54vOcePI4HKNpCJSZ7uIX3FKLQpYpGVqwtoA1HEleHrLJE11Gxqf2Y0QpHa+ghs1e
         dSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m/3NBPXMYRxTaowdiK5zzy3RRacEuJ3qAfDNMSuhkjg=;
        fh=iEbF8Y8s47rRO3EqhizNCsvhg9h4WIQkBdhKKt47SZ8=;
        b=bVlpZ5FxncmyC517xUeVGkNg1AhMX5haImD9z7U186m9qWRnS9jNTpkaeluNJruwPJ
         yo9ior6Hyh4Uu7y6XQvl0U/chnfvSBDTq5Cut9oO/PalWPBX8NehH9hFiXKPsWQrPnSW
         5NJaK2LiE8akHCDfSkvn4qBGHwd7bVkL1g4qSQ8fyJ15lp9Y/7NgwMLl3dFswBdx232o
         IardD5yOU8nuN75htN1xFb8yDGXJT6O/Tw03dBmnzLfppTH8W4ldxTVbdMIIfIK4Mt2Y
         UqQOX2zDpcrmkWSdLPH2e9o7+a5cxUj6Fq8AvkmqE4fmyXk0seORWaY9/yi7YlBs8d/X
         Xpzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791332061; x=1791936861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m/3NBPXMYRxTaowdiK5zzy3RRacEuJ3qAfDNMSuhkjg=;
        b=FuLEACjI6dVPRHMMknWImUEgyrlMxbINwwWas33T0U+rpO9acDIbudqrtG5PIf7tia
         OAA8Vh7UbDUN4HIrT8mu8xJWVkPBww3sYMFbFdG5Zx/w5CekdE/did5ogeCPL2EMA1w9
         QxCCD0HznLx922v8A2pME1kvCvIiqkXfUwrNWPepJTgHOQplUhjAlnQrkpRKUSiBV3JT
         IBZvMe+aGxqfT98ExHswFfJgPThw7Mo0sHMgn6ylwQpGhCaLoeC5Tkfdp69ia/sdMGic
         JufZej3byA+QcEsLd9KHn8tciiE7mguM8yfJiD1UIYyPg7NJ38qGYaHz0yjciaHaIi7n
         Kp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791332061; x=1791936861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m/3NBPXMYRxTaowdiK5zzy3RRacEuJ3qAfDNMSuhkjg=;
        b=2zwv8zaO7u7km/1Xtfl7j8KT95ZvSwnMhHlhze74I2YD29MSQFcRUDfgYzJmNZBz0m
         3Z37PNymOSqAvBtOqwkQcCxLFoqdt1WEupoA4VRBCCGAlFERmAy5D9nMNuiI/SdQCdSJ
         nibzA9MlhuX6p6HMDwSGHo4FakyfM7qJr7HDweP/B4Q1MRp3sAJZfz4VOvbjhAmMKCNC
         sU5GTDwOAcpmb0bzN9C3MzieFW3DKqNnKGKDpWtJ5JONCTLgJjeKhijZ8/Hug9+Xe4MA
         MCvRGcToxQXEybFv95W0QFRxG67B3dBqmhDozYomNHOweYfTHDsaJUosIci0AYwD76u9
         sDdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxnPBkkeqwx9ssxxTnjcZFMvPPiSUhMncsANQKuVFGQJt8aEgOUB4iEy0dSc5s5wlnDXILZ6cU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdDLPjjAdVPXEQ9HNBOO3VsKA9+RbWudK7isoAGUgPlSagV6y7
	cYJrWMCT7+6BUmqHR+ADqpEauh22QMxprUFf1fdmdxf+A3gbqchcVi1bJ0uE7o1sd6n8MnOYn+1
	CgjwVlvAkzQRZvE/EpzQ+p73ZeLo9U3ysFQ==
X-Gm-Gg: AYBFou2JfSmnKleJHmO2VIF9rFR9f9EeERGikph2rfa4oUCFFawnz6Fhc5xMqWvvTi8
	ZdfFLxE2NNLZTCTJs5FoW7tpzmUGmV57SF2UXyeCweQ1W0mbh+3XjM8goHmZLFEZaEuZaCpEajM
	z9YgVqBFDq8TFk4MBRdchZMxOjWGstcERBL2bOS+56ZDGaxeUAWUhr93phdD/kHQWZEMB0m+Dpt
	3Cj6PIIhuBl4lYy8un3vU76NdYnwsI2bSg7J/Kfcrp+gkN3MKYEKEflmy9SZwpk7A6PkwMzl1ke
	G552tCHXtLL6YjfpFj1VV9Ov2SicegJ3PYR9G1aHdFsEXzSncutmhO4UgVyJ4USiZp3DhafuR2S
	SayJFfC7JuOGW
X-Received: by 2002:a05:690e:4085:b0:677:cf0d:dfc3 with SMTP id
 956f58d0204a3-6790a4f71admr526003d50.98.1791332060714; Tue, 06 Oct 2026
 17:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001191140.2818991-1-edumazet@kernel.org> <20261006183410-mutt-send-email-mst@kernel.org>
 <CAF=yD-K2Lq_TAbN0=vpRZQrcp_R9Vu4E7frixWeBO2ehBQHdiw@mail.gmail.com> <20261006194851-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261006194851-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 6 Oct 2026 20:13:43 -0400
X-Gm-Features: AclHuK8LD-b8VxM-jTUU_kh3ZQ88gEJqdJcMmPBY4k3wjYZlOT1rCSX4y-Xk0nE
Message-ID: <CAF=yD-KeGZFmcb4v1PMjhTZghTQgtCwSQqejne8qad0W5KaJBQ@mail.gmail.com>
Subject: Re: [PATCH v3 net 0/3] net: always dissect GSO packets in __virtio_net_hdr_to_skb()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 7:50=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Oct 06, 2026 at 07:26:46PM -0400, Willem de Bruijn wrote:
> > On Tue, Oct 6, 2026 at 6:38=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Thu, Oct 01, 2026 at 07:11:37PM +0000, Eric Dumazet wrote:
> > > > This series fixes a bypass of untrusted GSO flow dissection in
> > > > __virtio_net_hdr_to_skb() when VIRTIO_NET_HDR_F_NEEDS_CSUM is not s=
et,
> > > > and adds a kselftest covering VLAN-tagged GSO packets without NEEDS=
_CSUM:
> > > >
> > > > - Patch 1 fixes __skb_flow_dissect(), which computes key_control->t=
hoff
> > > >   with min_t(u16, ...). This truncates skb->len and returns a bogus=
 small
> > > >   transport offset when skb->len modulo 65536 is smaller than the
> > > >   transport offset. Offsets that do not fit in the u16 thoff now fa=
il the
> > > >   dissection instead of being silently truncated.
> > > >
> > > > - Patch 2 initializes skb->dev and skb->network_header before calli=
ng
> > > >   virtio_net_hdr_*_to_skb() in tun_get_user(), tun_xdp_one(),
> > > >   virtnet_receive_done(), and raw_verify_header(), removes the
> > > >   '&& skb->network_header' condition and the unvalidated
> > > >   'else if (gso_type)' fallback in __virtio_net_hdr_to_skb(), and m=
oves
> > > >   virtio_net_hdr_match_proto() after skb_flow_dissect_flow_keys_bas=
ic()
> > > >   so it validates the dissected L3 protocol (keys.basic.n_proto) ra=
ther
> > > >   than the outer L2 protocol.
> > > >
> > > > - Patch 3 adds kselftests in tools/testing/selftests/net/tun.c veri=
fying
> > > >   that VLAN-tagged (802.1Q) TCPv4 GSO packets without NEEDS_CSUM (b=
oth
> > > >   flags =3D 0 and flags =3D VIRTIO_NET_HDR_F_DATA_VALID) are accept=
ed on a
> > > >   TAP device, that mismatched GSO types and truncated TCP headers w=
ithout
> > > >   NEEDS_CSUM are rejected with -EINVAL, and that a 65540-byte frame=
 is
> > > >   accepted.
> > > >
> > > > v3:
> > > >  - New patch 1: avoid u16 truncation of skb->len when computing tho=
ff in
> > > >    __skb_flow_dissect(). Patch 2 makes tun_get_user() dissect IFF_T=
AP
> > > >    frames before eth_type_trans(), with skb->len up to 65549 for a =
GSO
> > > >    frame carrying a maximal IPv4 packet (Sashiko).
> > > >  - Patch 3: truncate the TCP header after 10 bytes so that the test
> > > >    requires the transport offset found by flow dissection, and add =
a
> > > >    65540-byte frame test (Sashiko).
> > > >  - Link to v2: https://lore.kernel.org/netdev/20260928144254.336104=
4-1-edumazet@kernel.org/
> > > >
> > > > v2:
> > > >  - Patch 2: drop the pre-dissection virtio_net_hdr_match_proto() ch=
eck
> > > >    inside 'if (!skb->protocol)' so VLAN-tagged GSO frames without
> > > >    NEEDS_CSUM are not rejected before flow dissection (Michael S. T=
sirkin).
> > > >  - Patch 2: clarify the changelog regarding why skb->network_header=
 was 0
> > > >    in those callers and why skb_reset_mac_header() is dropped in
> > > >    tun_get_user() for IFF_TUN (Michael S. Tsirkin).
> > > >  - Patch 3: add selftest in tools/testing/selftests/net/tun.c based=
 on
> > > >    Michael's reproducer.
> > > >  - Link to v1: https://lore.kernel.org/netdev/20260927195536.248907=
9-1-edumazet@google.com/
> > >
> > >
> > > Not without trepidation about the amount of stuff we are shoving
> > > into virtio_net_hdr_to_skb which, believe me or not, used to be 50 LO=
C
> > > of trivial code in 2019:
> >
> > Unfortunately that let through many bad packets and unintentional
> > (ab)uses of the API.
> >
> > The current state is the result of numerous fixes we had to apply
> > since then to protect the kernel. Generally there are two approaches:
> >
> > 1. make every reachable path in the kernel robust against unexpected
> > input. Frequently that means checks in the hot path that penalizes all
> > normal traffic, only to catch a bad actor or fuzzer. And it's not
> > straightforward to prove that all reachable paths are protected.
> > 2. strict input validation.
> >
> > With strict input validation from the start the checks could have been
> > simpler (hindsight is 20/20). Unfortunately, now we are stuck with
> > weird input (GSO without NEEDS_CSUM, skb protocol 0, encapsulation
> > headers, ..) that we now have to work around and try to not break,
> > that may or may not have real users.
> >
> > This patch actually makes the function simpler. By reducing the
> > differences between the various callers of the function. This is great.
> >
> > It sucks how complex this function has become, hopefully we can
> > find more such ways of making it simpler. The strict validation itself
> > is a good thing imho.
>
>
> Yes indeed. I have a vague idea how to do it: check some
> performance-critical types of packets and for the rest just calculate
> the checksum then and there.

That sounds promising.

Checksumming is only one of the risks. Segmentation is another.

Perhaps the general idea can be extended: harden the kernel to the
small set of well known types, strict validation and even processing
for the long tail of other traffic.

I'd even (optionally, maybe behind a sysctl/static-branch) run
flow_dissection to ensure the packets are what they claim. When
only unencapsulated TCP/IP is expected, this is cheap enough. And
it avoids the manual sort-of parser code that we have now.
