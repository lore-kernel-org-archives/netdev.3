Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A74B7A52
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 23:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329251; cv=pass; b=mM0cNAIaY6J+mDe+5y+7Yq7xC1O6WL0Mr53yNkfzTEfPd8xId/dXVM9yJ/pfsbSvCdPFStIeuJSgtZAqDy2WG+Dd6nT43AZbkzXgF/vzoGkSwgItPH7ok3YxAPxWY0r/3MMPmfH12FTWTeF4NZq8Y0UiWOAWw6bLAJPi9EV1eec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329251; c=relaxed/simple;
	bh=yFXd7y5fWOpsVfsjEQZmWtKsL+pbn9blBAj7HJb2WJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIB8SqFdMVIEJXeT7YHS/HPCSju/7OSHdAB0ZDH7CMfNzRnU1zY7+yqzewJmM51rvG55i5ZAiWk1xk60qY+1Prp32fDYLGHnPBxfmYHzns7lr/dqFUKfbeUBnFwzFvAPwodCqL4WOE0GkQXaxnwwBVn/DEVXVhIJfn+gWwmkfHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sh1b6Lp9; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sh1b6Lp9"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8aca54b75d4so11685117b3.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 16:27:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791329243; cv=none;
        d=google.com; s=arc-20260327;
        b=Hq4jKDihXXTVHPoqdEWdyNsoM9w7aJEHOk1gab7MBsifWwi8EHyEpl3fGQcmjs5ATA
         6mdqTwr5CUmFx5QxksiC2z/f1R1qOZIAqJJlO0KxPFACxuSvOp0RqosZNYl46TnfRBVW
         4yKQP3o2rRjh4RHVUiOZAaTD87ImTo31k+1nsl2U25x3ks7rE24Vd8m8i4PASG1Ek+wY
         uPcJ9+9NYGyjf69YTuOyxsbccA85xYEx2mZMXgfWtem10v7vM1xGcphTpoOU0IIhw02S
         8rU4C2TWlYHg5QF8frJbRnjUcwX8Cv96VUxAg2zFtYsR7T1trDwyyIO849Ffhfs8NZ8h
         EspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5dtcxLvFNFqTBtQd4pS5TzyOMmn2NIfGNdmPDJIhuQ0=;
        fh=eoccCxUos7VH1O2J0l0M403xbisfVe9bvKygQYBY+s0=;
        b=iGmIvUGI1SG8zEQt+lv/OiJrfTgN5JKVx3WSAmMtDhOUdrNHtdPCRkfFh76uGWB6g5
         sj3KTTvi1tUXXJ4wm5FHKs3JLYEV1OVrvinskTM8ce/mynAQQEPUacFfw/pcnv1+uyu8
         JUZSGObDqPaWjtUhzs32wMXETT7pXyROsW3M0+4zRED0uITqXol1Lpb04zgSeMuxGuT0
         loECKJruG4m43NL15NNAqc5LP4CF5vmaL5eBwzIx9enTogENZvUk7ud7vXTSrs7+GPMx
         V12GLIdAbHs04BQ5xDoESLkmAeWluFIaJ8ge4tTBvxrTkntfuvUZqPAMTLjWrGdN6Lwx
         lUhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791329243; x=1791934043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5dtcxLvFNFqTBtQd4pS5TzyOMmn2NIfGNdmPDJIhuQ0=;
        b=Sh1b6Lp9axyd9HqQX5FlVkHn15d6oyf26aFajSYdVX1a3Tz5z84pVCPghbhY72iW0j
         fDvvclOrjENEgxpHl5gtp/0tubK/w3z/02/7gzlGpqCVxTwQ1ZleeU7oH87zX5faDdg1
         awoM9P7LjpOwO5Jsvsa/aXRwb2K8RYdc2B6Ey96cnA2bpWz6+HWC7L+66bVF3eC9hjMA
         sPSNwGbhQ/Lxm3igf+7Szzox5i2h5HqKazdiZ1ZSP8YXm89Bi88ntFJvPn3xM0fc6JE5
         FoeEw+EPlr8rBB0kifCDEOOxcxY7m8YrJI6QnRQ68lCua84xwNAmzr7iKGsV/lYrrdf8
         G66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791329243; x=1791934043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5dtcxLvFNFqTBtQd4pS5TzyOMmn2NIfGNdmPDJIhuQ0=;
        b=hJPPnzU4QnQ6wu8Y/IiE5Zwmt0ja391UxU2BRcKTm5LlHLLfvaRvDYcOOGvEP6xh8N
         5Sw9QP4qqmMDzRb4Jn6FGsK5V/eJ3OnhF7/SdlBrDrtEKow/fr7go4bG/ZnhU5rGBceG
         WCKbptYdxekxqin/dqm7VZMdmKxH3R2/zkfvOaZjS5ErQru2ICBKHZqIZiao2TXwS2/0
         GWi3g0lYf6XFgJqnE4Ws75XmZ2OZ1V/NvoBMrOrETd/5j1UV2GOKuanR4AjSY3xSnOcc
         Ii2L4k9XINXQgodJEx1u61Zz4NoK5V7Rz5GI9LgnI4pmw8AbMMC2gm8jn+dfz73e9/Sw
         VG8A==
X-Forwarded-Encrypted: i=1; AKwUvBybLFtiO8c7lmLGP/jwhQeBRKjJViXkUo9wXy+ja4lhdDQIUa+/MB7LkBIVarbGcONDy7VjGqM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4blH9cB9D4Rzmw0258phqnMXXaLJg4GfbxcxMS3JG3tT8X97Q
	W/UPGpFHjGKkd8+zg5a886BY9jblTDT5H/AE5y4wkraDJ4FlRPN18hV1nqlO5lfeQWBjdIolkRW
	o+FHMXljvA8aJuRRZr/ZOe5SAfUHYg4H5lQ==
X-Gm-Gg: AYBFou3WFSdyDNdZfuRq8d4d2s/Va+4YbU5yZ6r9zxKNhAR+gwCkUQysWRuy1jeZFz8
	Vdduid0kY5+Ku9HPjC9MKANT5wY2mpUp1nzQYxWLX/Ian5g91kb8P9VtCRzsputgEdB1l1w12A4
	FCNmZC0HZSDUzOYAYlDrJjrKHgUbvZ6LaZq1rblKMSRMf982GmJhZvKYasVAmorPZVNToMu/zzw
	cS6B1B8V+9M54kM/cinp0PSn4xuje5SZBYDQDSkdd1MtnmcIM25GO85U0nZNiz8vlldF9+hING+
	bQr8zsE8lAmUXy93RUFwFGtNWuXYkzwY9LPdwxsBH0h2UCXYfy3oMBf6+2/U6HT4vJ2a8VpqMmZ
	SSZdjhwa0jxijv3tVdu1bX08=
X-Received: by 2002:a05:690e:1908:b0:677:df02:fce with SMTP id
 956f58d0204a3-67909dd0bccmr483126d50.5.1791329243358; Tue, 06 Oct 2026
 16:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001191140.2818991-1-edumazet@kernel.org> <20261006183410-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261006183410-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 6 Oct 2026 19:26:46 -0400
X-Gm-Features: AclHuK8JPPhdp9hwzrXyEwzpMv5YNvMxDnavUZ-Mg0DDyytUJ178OYsz567Ajc0
Message-ID: <CAF=yD-K2Lq_TAbN0=vpRZQrcp_R9Vu4E7frixWeBO2ehBQHdiw@mail.gmail.com>
Subject: Re: [PATCH v3 net 0/3] net: always dissect GSO packets in __virtio_net_hdr_to_skb()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 6:38=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Oct 01, 2026 at 07:11:37PM +0000, Eric Dumazet wrote:
> > This series fixes a bypass of untrusted GSO flow dissection in
> > __virtio_net_hdr_to_skb() when VIRTIO_NET_HDR_F_NEEDS_CSUM is not set,
> > and adds a kselftest covering VLAN-tagged GSO packets without NEEDS_CSU=
M:
> >
> > - Patch 1 fixes __skb_flow_dissect(), which computes key_control->thoff
> >   with min_t(u16, ...). This truncates skb->len and returns a bogus sma=
ll
> >   transport offset when skb->len modulo 65536 is smaller than the
> >   transport offset. Offsets that do not fit in the u16 thoff now fail t=
he
> >   dissection instead of being silently truncated.
> >
> > - Patch 2 initializes skb->dev and skb->network_header before calling
> >   virtio_net_hdr_*_to_skb() in tun_get_user(), tun_xdp_one(),
> >   virtnet_receive_done(), and raw_verify_header(), removes the
> >   '&& skb->network_header' condition and the unvalidated
> >   'else if (gso_type)' fallback in __virtio_net_hdr_to_skb(), and moves
> >   virtio_net_hdr_match_proto() after skb_flow_dissect_flow_keys_basic()
> >   so it validates the dissected L3 protocol (keys.basic.n_proto) rather
> >   than the outer L2 protocol.
> >
> > - Patch 3 adds kselftests in tools/testing/selftests/net/tun.c verifyin=
g
> >   that VLAN-tagged (802.1Q) TCPv4 GSO packets without NEEDS_CSUM (both
> >   flags =3D 0 and flags =3D VIRTIO_NET_HDR_F_DATA_VALID) are accepted o=
n a
> >   TAP device, that mismatched GSO types and truncated TCP headers witho=
ut
> >   NEEDS_CSUM are rejected with -EINVAL, and that a 65540-byte frame is
> >   accepted.
> >
> > v3:
> >  - New patch 1: avoid u16 truncation of skb->len when computing thoff i=
n
> >    __skb_flow_dissect(). Patch 2 makes tun_get_user() dissect IFF_TAP
> >    frames before eth_type_trans(), with skb->len up to 65549 for a GSO
> >    frame carrying a maximal IPv4 packet (Sashiko).
> >  - Patch 3: truncate the TCP header after 10 bytes so that the test
> >    requires the transport offset found by flow dissection, and add a
> >    65540-byte frame test (Sashiko).
> >  - Link to v2: https://lore.kernel.org/netdev/20260928144254.3361044-1-=
edumazet@kernel.org/
> >
> > v2:
> >  - Patch 2: drop the pre-dissection virtio_net_hdr_match_proto() check
> >    inside 'if (!skb->protocol)' so VLAN-tagged GSO frames without
> >    NEEDS_CSUM are not rejected before flow dissection (Michael S. Tsirk=
in).
> >  - Patch 2: clarify the changelog regarding why skb->network_header was=
 0
> >    in those callers and why skb_reset_mac_header() is dropped in
> >    tun_get_user() for IFF_TUN (Michael S. Tsirkin).
> >  - Patch 3: add selftest in tools/testing/selftests/net/tun.c based on
> >    Michael's reproducer.
> >  - Link to v1: https://lore.kernel.org/netdev/20260927195536.2489079-1-=
edumazet@google.com/
>
>
> Not without trepidation about the amount of stuff we are shoving
> into virtio_net_hdr_to_skb which, believe me or not, used to be 50 LOC
> of trivial code in 2019:

Unfortunately that let through many bad packets and unintentional
(ab)uses of the API.

The current state is the result of numerous fixes we had to apply
since then to protect the kernel. Generally there are two approaches:

1. make every reachable path in the kernel robust against unexpected
input. Frequently that means checks in the hot path that penalizes all
normal traffic, only to catch a bad actor or fuzzer. And it's not
straightforward to prove that all reachable paths are protected.
2. strict input validation.

With strict input validation from the start the checks could have been
simpler (hindsight is 20/20). Unfortunately, now we are stuck with
weird input (GSO without NEEDS_CSUM, skb protocol 0, encapsulation
headers, ..) that we now have to work around and try to not break,
that may or may not have real users.

This patch actually makes the function simpler. By reducing the
differences between the various callers of the function. This is great.

It sucks how complex this function has become, hopefully we can
find more such ways of making it simpler. The strict validation itself
is a good thing imho.
