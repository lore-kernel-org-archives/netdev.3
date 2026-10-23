Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792791069;
	b=rbsg5yWsS8O/gNaj7t22iF3/mdwqV9+02GOdQ4Zh/1u199LfCViPFAZZ71ZaN2rZzdkO
	 1GZLnkRx8loUjA6ERY1wzxlCOp2918cnnfcoORe2wTsr1nxQcW/J/wp+b874Prji3toUN
	 Rf1PJFykt3/6uHo+2rEiUZwVvBrIeXkrfimv/UUvtHfNH7ssPn5Sq8Jkb5s+I11O9RSMT
	 Xh+R7ot1Q38p06Bwue9OB2/myPKRsY9bR8syyDRfPssk7r77le99YXZf74omAF951CpBP
	 KahDXvHOOlZdhI5s12V4fkf3d87vD2aVCzr991vs+piuFfF0PswKm+3zHhn/hpkrB1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=PzEYTFRDtyc4C3h5BFo8qsoM3fBDf8Wp9E/Xwuh394w=;
	b=3kLTXNg7+cKR0RUjL/a3A4aK+jUMGLsIRDD4hvqV7I+Nsr13cDZOyVZrEsFO0g2ttjTj
	 MX9XwiD15i9E5hHlgfDkULQ/V0OUVJwKxO3gjQY6hL/G3DRZRipdWALDPhxYI56FV+9qX
	 iyWhuHqZsKUgOeus2wW1b65/EfZi4uq/1gjfRpYJ9uBH0A8YQHoakO+ervmqJe2kUYl0p
	 EVQcEm8bP7cHL5fqWVghmWfQFayLz2MpgNhg9uDONiLRi2rfkTgaJKR5e4AnhtgTsxfaL
	 vTmg02ByxHaaWH3KbAbj+ts+NvEEV0kvZiIYCSRZEdzg6Fpix4bU4Io94O6ZmW4EbPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Cz8UiCpP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB82606A31F
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 21:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBB82606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Cz8UiCpP
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a070755c8cso661517b3a.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 14:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792791068; cv=none;
        d=google.com; s=arc-20260327;
        b=JxzlNAZ47V7KLjYI/WqHoe/MdUiLK0ij/Pb6xxvgr/8g2wwGgeolpex+iODc1Hqieg
         fgEWpDuZ3eVsszSyKsb2EdHfIN8khCNnYRy0fuzxcjtw7K+loYlzh+yOEzVevAvURn+Y
         M2v+dXOEnZNLieRiLrrXTbAMV/G4ZZKaLsz/KQfXJF7IfcJpMPBqRMp+D8LCeqeR5iE3
         QRKDfIBact0Aq8UmStDxl5DHODqyocuqbR5UTec9NEX6LhJwqAOZXy2gik/nS2ctiUpN
         +f8XUj9B41OwYbvXk/AUKod1TFSslYjqL/RZJCjRF4P4F4HGMBgXJEkWhOuCZYyA8TsN
         LFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PzEYTFRDtyc4C3h5BFo8qsoM3fBDf8Wp9E/Xwuh394w=;
        fh=uA5+sVf7lLjWuGIYBt/ggdGLbhwFsRcXVU+U3XyFFqQ=;
        b=V6OrA3slnQqKsHd/0lAD6vyRYxHZgsSEVkyKY6KclieAc8PCrZ9Qsv+FJrRD6UWNWH
         PG/R9wPSjzLlOR3XhouC6LavVjrShFNdqOuB72QafBWWFoG9rOi+IcwW/f6cz3jSqLRs
         dbrvsdM3nGGDddNN2PDl+6URRNDIzYj7oNJNnEActg4iGHqXLzKJhopFMQzmbSg6mPg0
         pFrgJPxxVktdS4EBXwSsgoSnxz20kg5edG7h4dn0jIn6p4YnAv/KQqR9F+XABqu8+TFI
         UFaLsBYx4bAntfkrrerpP4pcG6caa8k86Y4w5NXXvgpuSz2RPyEM5z/oiEOGISXoL5dg
         xRSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792791068; x=1793395868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PzEYTFRDtyc4C3h5BFo8qsoM3fBDf8Wp9E/Xwuh394w=;
        b=Cz8UiCpPA8AGlKB1MxLsix2zKDAkQ11XDr2O4iWmC/V37vL91mBt1ynXloR898RzAn
         tk25S/OqHUsV+63Q+Jp8QgDuM80S3ybFd8ktMUW60fz6WzylowQ9XhJzSrB5NYD4CDYK
         m7P+2FHrNiAyfvowAfX2h+OkgzlbCTFI+HWdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792791068; x=1793395868;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzEYTFRDtyc4C3h5BFo8qsoM3fBDf8Wp9E/Xwuh394w=;
        b=v0IQtNIyE4DRpABUHdycTMOMv3AO0srXGP4mUCxPdZxz6H0Gcjea7kU5o9Sn0+uoo5
         Oa988DdQweYGWKGVrcbMGVFg7r3DOj9f4hYEsRHSF9XhmPn726rpmZtggrBaZuX6Vzm2
         CXg7IswxKL522jVUOM+p5iDj1lSuI1qzcQNzKhg50E0S767gsBzHi5lIAsBdhaN5axvL
         CzjOWkGY9rcP1lRS5ESRfT/tC76RQ4MF9N9CKSmXnfPHXlShhjwgQ3+Cf8kzXU55vQep
         ArWDMVmIUqkMUTbS2/Y/5txfu0Se6DI3IOU3szugiwkgEZeWAYNwhhe4AaN7+2Lz/M8Y
         l3cQ==
X-Gm-Message-State: AFq9FYJRqWGZHlxjBXK+U06RvItzZgbHSu0oS3594sB1umBhc+9ASs4N
	lBRl7k5/uKDR7yjHGsyf5zMLBJjw9ap8UTmT+BEgC+HGaLWwyQGMSL5kFE44xC8/k9/n/dtF5Os
	Mj6hlQ714kCwllG8Zb9YIYFD79Uzz689dWpP4v9S7
X-Gm-Gg: AYBFou0M8Pt1m2ROYOo0DrxkT71mu9H07nT5zzUQGuU/i5hYpxM6Wlwkg3n92T3C4n7
	geh2/3eyPRzPHGWBQuzk7dS2glLw+DPYGAcD1Tg4oEl8YMuaaBZMAzVLiY5AUTw9pRQt0CyoZgo
	MWWvmCtozMXVAujBTa8cz69G9WMOcuWW3pv1wxI7glEYzSEsgNiSxGdAdhC9xyFpLfhUZQSkzkz
	5wmMY3NBY4y9r/S1FG6woaTBweXdLsWzakY61Y0YU8L1EDh6cbkfMQSWWChpsFISHk7HEsFdwbo
	DRFR0EXwBOTiJNiajjA9d5r/6uLVspErPRAkVwBOGQPAm9F8SrSwz7aSjuE4h30Y27bMcrdCPY/
	5sVP/Wf8CFcBHOEK8YtwrN77+QVoeXw7QBQxu3SolSwevDgBJL7tF40BJIaBF3WgN6r1zK0+Wh6
	MhNZIBbMVqWVDQihU=
X-Received: by 2002:a05:6a20:918e:b0:3e2:1656:b7c7 with SMTP id
 adf61e73a8af0-3e7cd4d7e66mr232661637.58.1792791068108; Fri, 23 Oct 2026
 14:31:08 -0700 (PDT)
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
 <CAM0EoMkaPX_He3yCExA0DG4KuQQd6JLP=6qgsXn0kzry4+P2nA@mail.gmail.com>
In-Reply-To: <CAM0EoMkaPX_He3yCExA0DG4KuQQd6JLP=6qgsXn0kzry4+P2nA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 17:30:57 -0400
X-Gm-Features: AclHuK8KFEdBienchfGQ8aWKEmTXYn0IoyZR8uNBb9I_76trZTMsow8k34a8Nw4
Message-ID: <CAM0EoMmKEvDD6YSu-CXxE39AhfF9MA7GA2HTho3+_etCx6ArcQ@mail.gmail.com>
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

On Fri, Oct 23, 2026 at 4:49=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Fri, Oct 23, 2026 at 3:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Fri, 23 Oct 2026 07:59:15 -0400 Jamal Hadi Salim wrote:
> > > This series fixes a class of producer/consumer bugs in which an outer
> > > header is popped and the packet is then handed to a consumer with few=
er
> > > than ETH_HLEN bytes in the linear area.  eth_type_trans() pulls ETH_H=
LEN
> > > from that area and can BUG in __skb_pull() when the inner Ethernet he=
ader
> > > is not linear.  The affected producers are act_vlan POP_ETH, act_mpls=
 POP,
> > > act_ife egress decode, and the Open vSwitch MPLS/TEB and NSH pops.  A
> > > consumer-side guard in act_mirred rejects redirecting a headerless pa=
cket
> > > to a device that expects a link-layer header.
> > >
> > > Patch 1 makes act_vlan POP_ETH pull the inner Ethernet header after t=
he
> > > pop and drop only when the packet is genuinely shorter than ETH_HLEN.
> > > Patch 2 does the same for act_mpls, gated on the pre-pop MAC length.
> > > Patch 3 adds the act_mirred guard at the redirect boundary.  Patch 4
> > > keeps act_ife egress decode from consuming the inner Ethernet header =
and
> > > restores the header metadata.
> > >
> > > Patches 5 and 6 establish the same linear-header invariant for the OV=
S
> > > MPLS/TEB and NSH pops before restoring MAC_PROTO_ETHERNET.
> >
> > NIPA CI flagged a regression that appears to be introduced by this patc=
h
> > (or one of the closely related act_vlan/act_mirred patches in the same
> > series).
> >
> > The selftest tools/testing/selftests/net/forwarding/tc_mpls_l2vpn.sh no=
w
> > fails reliably (both the "ping" and "ping6" sub-tests, on both the
> > regular and debug forwarding test configs, consistently on retry as
> > well):
> >
> >   # TEST: ping    [FAIL]
> >   # TEST: ping6   [FAIL]
> >
> > The test builds an Ethernet-over-MPLS L2VPN using exactly the tc action
> > sequence this series touches:
> >
> >   - ingress: mpls mac_push + vlan push_eth + mirred egress redirect
> >   - ingress: vlan pop_eth + mpls pop protocol teb + mirred egress redir=
ect
> >
> > dmesg on the test run shows mirred failing to redirect the traffic:
> >
> >   tc mirred to Houston: device veth2 is down
> >   tc mirred to Houston: device veth3 is down
> >
> > This is the same "vlan pop_eth followed by mpls pop" chain described in
> > this patch's own commit message as the bug reproduction scenario, so it
> > looks like the mac_len/pskb_may_pull bookkeeping added here may not be
> > correctly handling the ingress case used by this test, causing otherwis=
e
> > valid packets built by this chain to be mishandled and the redirect to
> > fail.
> >
> > Could you take a look at whether the new POP header-pull logic correctl=
y
> > handles the "vlan pop_eth -> mpls pop protocol teb -> mirred redirect"
> > chain on ingress? It would also be worth double-checking this alongside
> > the companion act_vlan POP_ETH and act_mirred link-layer-header patches
> > from the same series, since they touch the same pipeline.
>
> Victor monitors NIPA but is currently away for a few days. I will take
> a look. Eric pointed out this broke:
> tools/testing/selftests/net/forwarding/tc_mpls_l2vpn.sh
> I'm working on updating that and will try to fix this as well..

ok, the new update fixes this. I was planning to wait for the
obligatory 24 hours (so tommorow my AM)- unless you say otherwise..


cheers,
jamal

> cheers,
> jamal
