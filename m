Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792526957;
	b=rClCAVR++3r5/0gjZtFPTyTjSCsXCNIENv0UC7/MFXChM6rnuKFz69+PZYgVlktmOESL
	 mKsh4X+fnnFluUzQtM4ZoTN7usGtA7beNhL+acLNCobB37/Exkj51aYPhxYCS6E5LIJb4
	 IpB4bPYZHZuHzwzXJKHLF3gctUhxuwsGP63l3ozFKalkdTWYZFiS33A9c2vXzrTJhoTfv
	 wXrNuIZVteDg0inpei81ZWHZHgeZM/0aJiJlCrR6fAlAhrn8a55XZZEANeRjmAFdJsRrM
	 Ir2ziJr2zOtzm7HQn23n75NcEpX/0tYCX6RdBhX/QEpCA2+MW54+3CdqWUTnuKka1UA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=J0sEQuq2WSA3/+q03WHM3L1hFGc4SlZPZSOZimdY9nA=;
	b=sRVoVYIrg3rWYojCas3lZnKW+zqYnwnZ+ZRMOhvTDWCZBK5FNvf4+h6rASMBgugSQxQM
	 +POfb6BHvhl0p4onvwyZIc/frn/5nRMhzS6bFUaPfOf6WKQ6H+aZqudTDGrUAXsgrLPWY
	 4flryVUydqmywimSMni7Om0FsgrCoetf6DdbklpxKXad3mpd4zIBkKH1oxcYlFaortphf
	 3Y/WqA6bVC2IC95g/J0+zfZ31VlTujT78oqJf2igPAEinLs6Pq6ViZjDhNNvRfUBD7wlz
	 XoH4p6JgBhVrBNzarxo81GUVhCJfmp30vKpwelIKD0pMSfaq/TxOUl1Tv5MF5ZB/SCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=ztE0j914;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8CA606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A8CA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=ztE0j914
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eadea8f0edso19075e0c.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792526955; cv=none;
        d=google.com; s=arc-20260327;
        b=eJ1DB4uTcq1f2TpAYqXbDtompUzo0JsQotu8JcKXBsLc4T1suL9faX9rj1sN1OagLe
         fkk9KGxv1KNMyClfdhSeL1zkh++gTM5SFzPuaOVnRUWU1IgOhX7faZI4mL4PIRzM9Vwe
         d3sX0SAX6+cNk1hYSqMXOUrSocM0NVstcCuXEEmL3lvttOfi2zKEndVix5ZcSLMJn38k
         h+6dR1aF+cIy8pg8eCv/dcVjWTSlxMHH42GMVX3PTQx8nqkJ8WphJ4kTUNjQ6LmTy9fy
         PnAIJM5AP5dh9Xjm3IRxZuFaKR7tEU5TtviSmRB45ISPsHcFdfP9UCxkZ46btNrJSP5q
         KDRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J0sEQuq2WSA3/+q03WHM3L1hFGc4SlZPZSOZimdY9nA=;
        fh=4dtbUZ+xFXREKLUtdQyIMpefUnpsrAgjGaWrAVnw4gc=;
        b=sPkI3baeI1ztIH+09a0OeMbH/OVbe7XiyLRMHJp2f2aT7s1YtT1M2lnLOiBCuv3+hf
         mlUOdJpHPBBLkcGWevFonJd6RYsdj3bxXEOnQv7NXaF2mhT/WJKYP3DYX00Fy2WsB3gX
         Mo3zIi9DWSRIO6YeZzVIEmtuASIQqDiHIXKjrN/MXnbGX9FxqSbPSoQhex+JdC9+6Zzr
         kWye0ZGoOph83o5uffXzm7Q7EuF1oCxvnsXQBJPIFAvg0LbFMghBW3syIIjDfrnVsZgZ
         yct15IPj9lr4q6rumYW1s7MvepC/ha4Oug4vFgXg1bugyDexthOoA16oexzWCbWblj/0
         ofgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1792526955; x=1793131755; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J0sEQuq2WSA3/+q03WHM3L1hFGc4SlZPZSOZimdY9nA=;
        b=ztE0j914/maeegcqplIjKMyekk4u4olIdJQEQY4We5lLjcKFsgEtRixR0jBWDAE/UO
         iZUSQkUBpl1PyMjg9Bs30JLB3geIzLQnS7xO4efB/xY1neSiD5TWWba6NHH9Bg03t5AK
         7aa5DTZJZWxNcBaa3EDAMrRTG+WDCAXsL6gxLP0KvBA+GygiBZerPQGYACeiz3nfnbt7
         OJnON+WuX8bYPimtlzhTT7sxR88uXAhqroSZpUNxNVXLxpkXiDw3/pk1lPCDX63xQG2H
         hfqWSmc7vkXfy2S5n55k2pc0w2ipNUbw3uVBuBKgR4LQAUK77F9e5JzaT90WN6o5Q7s+
         A+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792526955; x=1793131755;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0sEQuq2WSA3/+q03WHM3L1hFGc4SlZPZSOZimdY9nA=;
        b=ltwv+JKaJP5ETaSDB0SIt0loVgtm9bHV80qMLRa1JgXAD3i9lD3sODLIEh2q7aiFOL
         LKcHR/ILcH2o0H4uqLskcbMtYgXrSHWsDhHnSI9x7LODXDeKp//jb1d4UlTBJXAcLKc/
         jv3SkshEwiqXnoJbjBNzoml2pxALHsM1BNFwYMe1OY8aOKTcVMQYSnvMPpSzc5S05P6F
         8llKItH7fbp8axVGxcCtQDIn3t7osyfyKM30QC3mC3o6UwoP98tD87FJitP9p2u2Kna8
         pvJVBlW/uUoJA0ESNCYsLF280jP9VHKz8ZCViNSWXZkjEX0qlag5r3+NQQG3f/+7VR+6
         4s4g==
X-Gm-Message-State: AFq9FYLtVDYh/M9XlBcYEB5G1VdBZ7ts/Gk/0GUEh1myYy2NCfs51O8y
	pRAWBgrH1bk8E3WmnOjlj35jE1NNkhEwLhdDvVxMdbBjeUsbEKaAEUXD2I0L3ZfJ3pz/FGLZkon
	NWpoxpCzkWLDerz48bSXzJgtjgPelX7mWnpGVsHZuog==
X-Gm-Gg: AYBFou2lhb2XaPrJZ3Ka1snkpZQLbt254p98FufQAu7Ftzd5mDikzZ2C0Lrws68/AZ3
	bHaFYoDr5IrH+wnElEKxXjGCIoovppN/hH2JIkbr8UQUNB/3og7cIBnshR149XEI8zBF654Bdpk
	b3K3kwa7wvdZlSvWR7oqbfIhv8O55dKSt0sfWLPzzQ+MZ26PdJ03fYwK1V9Sv2AYpMJ9RzBHLcz
	W9ZaqHIlrLS5OVrUh+0SeSjxXUzAhg0ZbENoXb9aWd/cmWV2Te4TRD8WixoOulUB9N4Snv5uC5k
	ANSVh4nm+xsPhbSlxsG+s4G7I//PbyxmotP3/HXYR3C+9oIYnbQByJlPBFfQ3NVvlbPWGuEZf4k
	HplTgP/YLjXFbmWKfvEJulBesFp9pCA3xzC3/KDasnfDi/VUIuxlBl5ZUHqxXiZ0sVOQy1iMlPg
	kVXm2jN4uamWrvMHLwoE35cZ06gRRkl5eYmLJBTWXd
X-Received: by 2002:a05:6122:25d5:b0:5ce:fc2e:d0e9 with SMTP id
 71dfb90a1353d-5eadcc47e3dmr541274e0c.13.1792526955052; Tue, 20 Oct 2026
 13:09:15 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016025059.289202-1-rjethwani@purestorage.com> <3108e934-ec00-458b-8720-450554b35b55@linux.dev>
In-Reply-To: <3108e934-ec00-458b-8720-450554b35b55@linux.dev>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 20 Oct 2026 13:09:04 -0700
X-Gm-Features: AclHuK8wnC269jiQtdHoh97Mv9qX5bOgGe6w0-A6U_TD1XQivzQNEwF-QBdhAP0
Message-ID: <CAKaoeS3Q3GE7om9ACy1e+Z5_ketb16Hn4W8+uBB3a+cAYRfGjQ@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] kcm: don't sleep in softirq when the lower
 socket uses kTLS
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 3:13=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 10/16/26 10:44 AM, Rishikesh Jethwani wrote:
> > When a TCP socket with software kTLS RX is attached to a KCM mux,
>
>
> Can we just reject such combo ?
>

Yes, we can reject this combination. Unless there are known applications
relying on it, I=E2=80=99ll update the fix to cover both attaching a TLS RX
socket to KCM
and enabling TLS RX after KCM attachment. Hardware TLS RX uses the same
read_sock path, so the restriction should cover that too. This would remove=
 the
need for the parsing deferral and workqueue changes in this fix.

> > psock_data_ready() calls strp_data_ready() from softirq, which calls th=
e
> > socket's read_sock(). For kTLS that is tls_sw_read_sock(), which can
> > sleep, and CONFIG_DEBUG_ATOMIC_SLEEP reports it on every run of a
> > loopback reproducer.
> >
> > Patch 1 is the fix: KCM parses inline only when read_sock is
> > tcp_read_sock() and otherwise defers to the strparser work, which runs
> > under lock_sock(). It applies and builds on its own, including on
> > stable kernels.
> >
> > Patch 2 addresses review feedback on v1 and is needed by patch 1.
> > kstrp, the workqueue that deferred work runs on, is an ordered
> > workqueue shared by every strparser user (KCM, sockmap, espintcp,
> > ovpn). With patch 1 alone, a KCM psock decrypting kTLS records in
> > software on kstrp would delay parsing and message timeouts for every
> > other strparser socket on the system. Patch 2 makes kstrp per-CPU. It
> > has no Fixes tag: the ordered workqueue is as old as strparser, and it
> > only becomes a real problem for KCM over kTLS with patch 1.
> >
> > Other strparser users are not affected by the bug fixed in patch 1:
> > espintcp is itself a TCP ULP and cannot be combined with kTLS, ovpn
> > installs its own ops built from inet_stream_ops, and sockmap reads
> > through tcp_bpf_strp_read_sock() and is mutually exclusive with kTLS
> > RX (do_tls_setsockopt_conf() rejects sockets with a psock).
> >
> > Testing: with patch 1, 5/5 runs of the reproducer produce no splat and
> > full datagram delivery; without it every run hits "BUG: sleeping
> > function called from invalid context" in strp_data_ready ->
> > tls_sw_read_sock. Multi-record messages (>16 KiB each) also deliver
> > completely with kTLS RX installed before the KCM attach and the whole
> > stream queued before the reader starts. With patch 2, test_sockmap and =
the ovpn TCP selftests
> > pass, strparser work runs concurrently across sockets, and dmesg shows
> > no warnings.
> >
> > v2:
> >   - add patch 2 (kstrp per-CPU), per review
> >   - read sock->ops with READ_ONCE(), pairing with update_sk_prot()
> >
> > v1: https://lore.kernel.org/netdev/20261013033920.2069285-1-rjethwani@p=
urestorage.com/
> >
> > Rishikesh Jethwani (2):
> >    kcm: defer receive parsing when the lower socket's read_sock may sle=
ep
> >    strparser: don't serialize all parser work on one ordered workqueue
> >
> >   net/kcm/kcmsock.c         | 33 +++++++++++++++++++++++++++++++--
> >   net/strparser/strparser.c |  2 +-
> >   2 files changed, 32 insertions(+), 3 deletions(-)
> >
