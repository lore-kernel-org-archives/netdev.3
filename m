Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792788556;
	b=TBdTcwuTwH6hyPbApPCoA+a6+pQABiah9+qNZomeNHovdX8PNg2KgEtecOYDGjnV3j1t
	 iztAYwqlL9VBkmBABchETUWNDqK30mmF7pC/0AwtAcGUNvnkuHoLt6DZTUHtyQwaIMuOq
	 Btbb+6051UYozwlzrK2fV5LwZuIJVGApDQNpcHk03vRSLx/d436ovEp3rF1Yzdo6lAP5u
	 SPXmrM+T0UFaeYNSnPNhynwBHWpZQAZxdjjMeodH7HiMV7zhOAHpLqIKnLNLG6Qz95ncl
	 a1WXXrv9WaGiCnUxRevD3fEsdBgPpxYEBMfZNBrRWSzdBv29eToUvuGGsQIqGCwBDSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=1e8ZPE4kmMbmXtCl0yrab04f315W635erPEBqteGcDk=;
	b=mr0QGVuGU9RAX5HB1drKnKhMuZsprby2+ac+uNnZlLP7et+jZJgMp5BqZFrY3hs+jrli
	 hXibMEGU7gaFlI/aT/QqmzsZ/Ae7WNJ1JLiavnfYS8YiFgr9LF9jOA8BqtlIgD38mo1Op
	 jvW6aDU2MLvjcH63mUjNWff+Pd6z+otL+SIOcu8L19PhlNbIMTdiZmxN7v/9kHwwh7fLu
	 bHrwwS3O4R1WSkVxJy78VSH9HkDc5q7stbs3TNFd+/zovZU2cQwqGW5uRjW1KyD4GvjP4
	 JoqzjGCWQpfz/AMUV5Ida4tyt1wMfR9AgHBFK+IIUMyFXLq12ecC2g89bxNFlvtwJtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=AEOv6u6v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC6D606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCC6D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=AEOv6u6v
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a058f74a54so550611b3a.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792788555; cv=none;
        d=google.com; s=arc-20260327;
        b=aVx6KnSHignQJiXK0iT9iNrVE5rHeX4m/XRyWzF9zzbfnd42teaEV+2vQeGFpniG2u
         6OHfQWpzq8gV+sZHMGXjpkVvspLtwozBoPFlpZILHaY6uxrPEEWOwJE6+sdxv6tvXQg8
         sHGg4A9Wv28RpJIkwHQ7Gb6R7EZk/wLCTHHjbCK5vkIILgg1UMLRQHxuAHpqYzFCl7b0
         hdNBoTN39DmQLIo6oCbHYlINOkt3UFLmfOHwR0sSIeQy1SHT93BrFDyT8o9FPLUlaaLZ
         gRxiueS7CvJfEDqhOzASvk3NrkbO3C/3TcEKitocMqEslFjuv3v662dhAMrlpKpj98pS
         DEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1e8ZPE4kmMbmXtCl0yrab04f315W635erPEBqteGcDk=;
        fh=uA5+sVf7lLjWuGIYBt/ggdGLbhwFsRcXVU+U3XyFFqQ=;
        b=Uinhq4TBdqw8CCP+rBCCzs4Jc2VDlN8PRW/wsm3hSc4KO6vd89q/bw7QdCHCwbJuHG
         OiXODgqfZjPYLK66eZk9AYkwq671E0+GUA30VX9W4+VAyKkRal/6j/lcEuLSZwHxI1sY
         CmV/Av6NCbbBzCl7pgo3KhV4pk4RdHpvOM2oLqO+DSG9Sp8zqRTLso7uWR8EWkVLOs6S
         ZC8bvLcdBFuhTLzTxOheoxth+Z9IaqXZS68LfEBFyA3P0rntLRBo1UFjhtl2X648dst5
         YHLN7D2FrrJirsPGIK35Q2Wqfn/+U0N7mLwFX3B1he7ENRBu+1Vq/nY7bC9+5dnnSMqd
         XUGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792788555; x=1793393355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1e8ZPE4kmMbmXtCl0yrab04f315W635erPEBqteGcDk=;
        b=AEOv6u6vIlh8bMLqubdAOCo2ZaWZPNBwX8q7K4RISlY1OQ+6TfhPudRb7ZZc+IEyDI
         Jl2uepJHcQXGgiZ/AEcTgVkS04Z5KXSWGM74zhXnh5lM5SpvjZCAsHZ3wjM8rVT6Nmmm
         OBYpe4OZu+KBfwxchSCixguS+yxodzVQfsm04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792788555; x=1793393355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1e8ZPE4kmMbmXtCl0yrab04f315W635erPEBqteGcDk=;
        b=Jm1fb2ZMZz8fO/j2Od5rPdgFmBpWOJ8C8fxd2k4/FxA40mgX656+EeQx1rwu7rKzOh
         smQynvXkpfv0oQptLjn4F0AVLaHL1rjIg3h4V3fLns4sRtWPQ7mVEmpWxO/RT1KewR3X
         ul8xJuZZFB7YB2E3bxuBbH/+sspp/Izvrl83Qp4gVXx01Sq45xUUmtoTzw9jUSXprxOX
         lDRpTqvShp/rME6hjXDu4Ms/VT24ENmqQKM2PpAGciL7y56TT427FVr7BobugyZrQOTL
         Z5riISlPpUPkMJDP16DVHSxIjdw82OR9RbSaEIRTN+ffKTHeKHpIcEzJ0yi0vM8ubC3Q
         PKDw==
X-Gm-Message-State: AFq9FYILPOGMjc6V0cq8aV3Zsbcb7XZ2jE6duxuV47DDo2A2BwVZQPBe
	rqJI5HuSHoCyLkFlkdu5HYXoHrXlP29VWia9pZb3GpiEBrOrVwz42SSLnO3NQ+kD90d2Zv+okTs
	80ILX9dffJvh/s/3uuaFp/bCPJtPMDMu2U3xqgDyOtZL3quY7XhTjAQ==
X-Gm-Gg: AYBFou0boTf7+MqkAAW0aDRlr2UPNavRyrCvbDrkt3V+9KiuTVmAO7OV1OBMfJRkijE
	Rb8kjA2kC+n9COyMTHKvWAg7hieeKiqpzAecVwA6oM3+/fNWWNIP3Ed+TE1P+9gVUTWYQssaphu
	nGixEXccyqMRijMfeYuB8HiwqbjY4MUhk+5dOcb4VyXGEClz7gotk+cQJXsj9WRwHXWhFEyZX+l
	NklKQ4QJ6ir+qARAhFCLjan2xhyL6CEGxPg74g1dW398dK51APlPxxcQXwHgARdxXrjpE5QNENf
	cDojQOqFixIuBXPjSXtyfZaZggBHPChBU2Gu75G3qLwtjeVWuZgachQ2I9Eb73BXVDmGnlhlmtj
	jvRjF5n/AzYNBwk0IiSlHDuaBCctMllJ+5Waraxjw6F4OgIqWKJJ5HS41X6/7eCSS62E8xYV5xx
	9aS4UGp6ZGrz4O/NMym0TpdMkC15DwjR+cbFP5
X-Received: by 2002:a05:6a00:f92:b0:899:55e9:880b with SMTP id
 d2e1a72fcca58-8a3661c509fmr328289b3a.14.1792788555119; Fri, 23 Oct 2026
 13:49:15 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <20261023122819.5e48ea9e@kernel.org>
In-Reply-To: <20261023122819.5e48ea9e@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 16:49:04 -0400
X-Gm-Features: AclHuK_KBBLqzVNTj_l61CA0L2zWjhSKF-P73rB5NHPry570bVn5gVtl8tS4o34
Message-ID: <CAM0EoMkaPX_He3yCExA0DG4KuQQd6JLP=6qgsXn0kzry4+P2nA@mail.gmail.com>
Subject: Re: [PATCH net v2 0/6] net: pull short linear Ethernet headers before eth_type_trans()
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Guillaume Nault <gnault@redhat.com>, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, 
	Ren Wei <n05ec@lzu.edu.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jason Wang <jasowangio@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org, Martin Varghese <martin.varghese@nokia.com>, 
	Pravin B Shelar <pshelar@ovn.org>, Shmulik Ladkani <sladkani@proofpoint.com>, 
	Yotam Gigi <yotam.gi@gmail.com>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, dev@openvswitch.org, 
	Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 3:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 23 Oct 2026 07:59:15 -0400 Jamal Hadi Salim wrote:
> > This series fixes a class of producer/consumer bugs in which an outer
> > header is popped and the packet is then handed to a consumer with fewer
> > than ETH_HLEN bytes in the linear area.  eth_type_trans() pulls ETH_HLE=
N
> > from that area and can BUG in __skb_pull() when the inner Ethernet head=
er
> > is not linear.  The affected producers are act_vlan POP_ETH, act_mpls P=
OP,
> > act_ife egress decode, and the Open vSwitch MPLS/TEB and NSH pops.  A
> > consumer-side guard in act_mirred rejects redirecting a headerless pack=
et
> > to a device that expects a link-layer header.
> >
> > Patch 1 makes act_vlan POP_ETH pull the inner Ethernet header after the
> > pop and drop only when the packet is genuinely shorter than ETH_HLEN.
> > Patch 2 does the same for act_mpls, gated on the pre-pop MAC length.
> > Patch 3 adds the act_mirred guard at the redirect boundary.  Patch 4
> > keeps act_ife egress decode from consuming the inner Ethernet header an=
d
> > restores the header metadata.
> >
> > Patches 5 and 6 establish the same linear-header invariant for the OVS
> > MPLS/TEB and NSH pops before restoring MAC_PROTO_ETHERNET.
>
> NIPA CI flagged a regression that appears to be introduced by this patch
> (or one of the closely related act_vlan/act_mirred patches in the same
> series).
>
> The selftest tools/testing/selftests/net/forwarding/tc_mpls_l2vpn.sh now
> fails reliably (both the "ping" and "ping6" sub-tests, on both the
> regular and debug forwarding test configs, consistently on retry as
> well):
>
>   # TEST: ping    [FAIL]
>   # TEST: ping6   [FAIL]
>
> The test builds an Ethernet-over-MPLS L2VPN using exactly the tc action
> sequence this series touches:
>
>   - ingress: mpls mac_push + vlan push_eth + mirred egress redirect
>   - ingress: vlan pop_eth + mpls pop protocol teb + mirred egress redirec=
t
>
> dmesg on the test run shows mirred failing to redirect the traffic:
>
>   tc mirred to Houston: device veth2 is down
>   tc mirred to Houston: device veth3 is down
>
> This is the same "vlan pop_eth followed by mpls pop" chain described in
> this patch's own commit message as the bug reproduction scenario, so it
> looks like the mac_len/pskb_may_pull bookkeeping added here may not be
> correctly handling the ingress case used by this test, causing otherwise
> valid packets built by this chain to be mishandled and the redirect to
> fail.
>
> Could you take a look at whether the new POP header-pull logic correctly
> handles the "vlan pop_eth -> mpls pop protocol teb -> mirred redirect"
> chain on ingress? It would also be worth double-checking this alongside
> the companion act_vlan POP_ETH and act_mirred link-layer-header patches
> from the same series, since they touch the same pipeline.

Victor monitors NIPA but is currently away for a few days. I will take
a look. Eric pointed out this broke:
tools/testing/selftests/net/forwarding/tc_mpls_l2vpn.sh
I'm working on updating that and will try to fix this as well..

cheers,
jamal
