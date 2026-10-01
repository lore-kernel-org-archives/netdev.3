Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF723CEB99
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874664; cv=none; b=WGWjPr7IdvrSrjMQHB3gQ+x5tA5xv8pX/6+skukkCvAUP09PLfC7XE9bpTbXtxDWoMHoc/Bjhd7YKb6FbYjJEdcxGg+e0R1VcJkxaaDBGU191Fa0gtKt4iQZr03/T+nkCU0+57XAl3anbr5DmU7HTRveCPq/WJrkfUSODW+yexg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874664; c=relaxed/simple;
	bh=oUETVrVJExWdhW13tm5MBBnCnu7Z5z65PJsfBBSuQfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f900pM+ZPBbQK3WRe9oxFSqsPRaqkSZeypKGlRmtFPz/DQ99cuE1bcUBI9gqdqd2j75ojvSn6pd1Z1x2rzNAsuZIA7nfF4ldZUR3MvFpbXxHIQ85HBcc86LxUA3vf5FipS4lECX6I99DPGfg6QLpqbys/ZIo9KXt30xRnNWPIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSmCohpT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSmCohpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CE11F00899
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790874658;
	bh=IA/am7YNVkxu5vpwQaw1YqVXm2VnBSzLpG9L9GfghwA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iSmCohpTxQYBwU1lBDXrCLI+n88ZM9RdfJ9c1ux+hgEORDqJFicuBjfJp8hv3yNbD
	 UQFKDfF+4EboJGsWygV3nWRhmr2uEKcOLB2XJ9xsfEqCczFIcX8MAi+pd1uAq0DaG8
	 n/5h5wxEmg2D5BXDKASsKPNjKK8FkX9wmXQeAk2GRTFCTDOwYfk5Ihl758hnkOFs31
	 pszsv0WX/VSPP1yUlmWw1OKf1/AhTap3P1y+VPqhWE1mS2m5EgvZwaNtfp3wbsW0kP
	 fn9YBL9mpgl/xcDa2EUE0RE7c4cBWU7iX3MAKPM89MdnwuT6bUjw+IGXeVPCchFR4T
	 SjSzaLm/yDQ+w==
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-47b5043f191so3497091fac.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 10:10:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxHt2VWV29FRkWRqWuuQuvYCnUN2VNurj1vgLxke02X6u5fSeiTH/ds9/0UASeZbF9MRF3AZ7M=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8h6IzgYZeC2Q8KDG9r9Q52tZHOTl20BXfYmBSZ0Z26codmsLi
	33nlDBOFUcABIabEJA6SQ9upWwszodBYnTME9i1g46ZshVJGBUbWTjN+piwmX1uIFcXxtRQ3Hlx
	Wq+4375k/LYBmePjS6WcQq5Xil+neNRo=
X-Received: by 2002:a05:6870:9a06:b0:457:494b:1548 with SMTP id
 586e51a60fabf-49e15a22f16mr168481fac.5.1790874657391; Thu, 01 Oct 2026
 10:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930172957.897342-1-edumazet@kernel.org> <d6170c1d-d8cf-4fd5-b0f2-361b89902fe7@intel.com>
In-Reply-To: <d6170c1d-d8cf-4fd5-b0f2-361b89902fe7@intel.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 1 Oct 2026 19:10:46 +0200
X-Gmail-Original-Message-ID: <CAL4Wiipep_WhfWBGov3vbOCLNKd0oQzFkX413AMU6V5DNN5Pmw@mail.gmail.com>
X-Gm-Features: AclHuK9iM7NCupkbSfyKzxtwHTuNZNzk8CuZvISYHDcZ2p5_y7TUsi_mQ-WN1pY
Message-ID: <CAL4Wiipep_WhfWBGov3vbOCLNKd0oQzFkX413AMU6V5DNN5Pmw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: inline eth_type_trans() fast path
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 5:58=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Edumazet@kernel.org <edumazet@kernel.org>
> Date: Wed, 30 Sep 2026 19:29:57 +0200
>
> > eth_type_trans() is called once per received packet by most
> > Ethernet drivers, and by core helpers (napi_gro_frags(),
> > xdp_build_skb_from_*(), veth, tun, tunnels, loopback...).
> >
> > With CONFIG_MITIGATION_RETHUNK / SRSO, the call and return
> > are not free anymore.
> >
> > Add eth_type_trans_inline(), handling the common case inline:
> > unicast frame sent to dev->dev_addr, with a real ethertype,
> > on a device which is not a DSA conduit. All other frames
> > (multicast, broadcast, otherhost, 802.2, runts, DSA)
> > are handled by the out-of-line eth_type_trans().
> >
> > eth_type_trans() is now a macro calling eth_type_trans_inline(),
> > so that all existing callers get the fast path. The out-of-line
> > version remains exported, and can be called with
> > (eth_type_trans)(skb, dev). bpf_prog_test_run_skb() uses this
>
> Shouldn't it get renamed to e.g. eth_type_trans_slow() to avoid this
> confusion?

This was my initial idea, but this would make the patch a bit more
invasive and touch bpf selftests, something like:

Let me know if I should send a V2 and CC bpf maintainers, thanks!

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 513354e928cb58f837fdc93a77f2e896de1ef916..8f4e9dd18001a4c32455fefd74f=
e38db270756d1
100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1165,7 +1165,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog,
const union bpf_attr *kattr,
                        goto out;
                }
        }
-       skb->protocol =3D eth_type_trans(skb, dev);
+       /* Always call the out-of-line version, for fentry/fexit selftests.=
 */
+       skb->protocol =3D eth_type_trans_slow(skb, dev);
        skb_reset_network_header(skb);

        switch (skb->protocol) {
diff --git a/tools/testing/selftests/bpf/progs/core_kern.c
b/tools/testing/selftests/bpf/progs/core_kern.c
index 004f2acef2eb0b0d80184423a3e8ba399feee1f3..fca26af98a7b92898a4adfde19f=
63b342f29db74
100644
--- a/tools/testing/selftests/bpf/progs/core_kern.c
+++ b/tools/testing/selftests/bpf/progs/core_kern.c
@@ -47,14 +47,14 @@ int BPF_PROG(tp_xdp_devmap_xmit_multi, const
struct net_device
        return randmap(from_dev->ifindex, from_dev);
 }

-SEC("fentry/eth_type_trans")
+SEC("fentry/eth_type_trans_slow")
 int BPF_PROG(fentry_eth_type_trans, struct sk_buff *skb,
             struct net_device *dev, unsigned short protocol)
 {
        return randmap(dev->ifindex + skb->len, dev);
 }

-SEC("fexit/eth_type_trans")
+SEC("fexit/eth_type_trans_slow")
 int BPF_PROG(fexit_eth_type_trans, struct sk_buff *skb,
             struct net_device *dev, unsigned short protocol)
 {
diff --git a/tools/testing/selftests/bpf/progs/kfree_skb.c
b/tools/testing/selftests/bpf/progs/kfree_skb.c
index 7236da72ce8055f9a0165d3b4334a04d17d110b8..678c15c151944b44e276cf1280c=
77cb436ff7b10
100644
--- a/tools/testing/selftests/bpf/progs/kfree_skb.c
+++ b/tools/testing/selftests/bpf/progs/kfree_skb.c
@@ -114,7 +114,7 @@ struct {
        bool fexit_test_ok;
 } result =3D {};

-SEC("fentry/eth_type_trans")
+SEC("fentry/eth_type_trans_slow")
 int BPF_PROG(fentry_eth_type_trans, struct sk_buff *skb, struct
net_device *dev,
             unsigned short protocol)
 {
@@ -132,7 +132,7 @@ int BPF_PROG(fentry_eth_type_trans, struct sk_buff
*skb, struct net_device *dev,
        return 0;
 }

-SEC("fexit/eth_type_trans")
+SEC("fexit/eth_type_trans_slow")
 int BPF_PROG(fexit_eth_type_trans, struct sk_buff *skb, struct net_device =
*dev,
             unsigned short protocol)
 {
