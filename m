Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793703667;
	b=lAMdW93LIuUKtY7mheJoDCyigwQjGiH4BwzoaCdTzJ+fSD5zdYN97rQ2rT+tcT5ZVvgd
	 0y0+kZQX4oqhRMRG9vkgNLbgdgGGhopE4e1Pv330Bqw/4uiNnTr1uzWFKGvEbk/3vtJdL
	 xEEYqE9GyzUmU0xsNva7VG+HGZxLvd34WJHrnTtKbgkW1buEsJieOM3SRbl2ZdpHpx6vg
	 KgiLFk8lASSV+zXvuVAnZc4cPGH4r4hdp4+yKmGW7GgRLW2vpSgpBU4KiXkWj/JN4MY3p
	 7DiipnnzzG6miCjsWM9iniK5Py72H79Gp/PxAnpfL197cyEm605udaqqNJhc1LCeN4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=TmVfvTR81IST7Xj5rUGxeZIFqpc6YuhM88NFz7MYCz8=;
	b=l+uo3qo3rMKhNjPJ3O0UT3mNptZ26vZryTMQyQ4XInlV/FcSFCVAYigiR3Ra+NIoWH4z
	 mp0qTrHbTFJouBGAosfofys+2Pd/tBia7jzlcG/8UzbZaAzrderxIye8dRfz1bGIP3QFH
	 PE5iZQ1ZIQrfUNH+10HT44WmUi4huRbuDjRsUYruuoU1nOz3KubVKhPvXDS6weQ4oMvKN
	 0wv6Ry3qkr5GJiDDC2ccYfyQraybjhqqhEfLuSvgpl6C5tWReKYCEqFW87ZJh5Ci6DsDT
	 LG7Axgqy1iXq3QiH10XfUW/D7imFCNONGtjtuNjQH2l2/Qkf5dN7byeD94Tiec4+4MQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=OEkkSti7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E5606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 11:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D2E5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=OEkkSti7
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06c60065fso2815132b3a.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 03:01:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793703666; cv=none;
        d=google.com; s=arc-20260327;
        b=oPnJvIC2b4YQjoIjCXzujge0Xwljjoy70R9matmz1PvsMKdtkY4d7tTDGYQqIjZjY+
         aMjk2ChCClun9eqoDsK6dYcbhSNRx113GRi5Pp/qlQgPikWpX/GS37s+s5T+CQsGWVXP
         A5BjWJ+SpXivn2K3EaOfxjvD+BrtQmvjiHsKIZmok4ojgLIduttG11IdJZl8M1W/LD1J
         6Z2agJpOTlEybJubqXZzYAm9fL/LmPIUNz51jKNB+AwfUscz1VU9WWRya4EG91yhhYDW
         4fRKWyHLsiZs7IJCpeErkW2rKf9zVLV6CRnJ2/hbbZ8xw7Mu3dL0rZut9BMK8qOTkkla
         pMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TmVfvTR81IST7Xj5rUGxeZIFqpc6YuhM88NFz7MYCz8=;
        fh=XmUWgqJbvhJpv7tDAvIzyBZ4Yh4j+/sGDSMETYCK/80=;
        b=D53Q3Plgvrs2CQpPQweiqpHYVkk5SSnqZmLc7JFHF0LqUHqjFp0qN0OfpdVNDtutxc
         tArjUm3onF77IPbe2VvqhZQGDIzf5on965WBry5LvXxLkUwm2Qtv+R+9KW+zYL+l8Uas
         /7MpClJDaQPFKtXaCbZC/2PwGFxmy8U44UAX61+s10FYDuBXzJZtSC58bXC0aJl4lgWI
         oZKiLfssbt1nnTbr68E/mm12Lz88D+i+wpPV5mQS4amLpC1ODoJasrhOzMtJrWOIfrNN
         DcRhBgzNmD/BIxrJ5WBmoiTur+3TTV1GYf+wg5gxDGeuXfLzXXhwi1e4noYUQ2XgQ3R8
         zBiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793703666; x=1794308466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TmVfvTR81IST7Xj5rUGxeZIFqpc6YuhM88NFz7MYCz8=;
        b=OEkkSti7REBckSR4eLqMDcEmZU7+49vy1OjjFuVu9gdVSy3vhVTS+/FGN5ZrDv/HHN
         G5T+ozYvOEspZ9ZS2/MoffilRmdSgOPSo8IDbwsIKiybL6xyhNBDWg2vGNMYXKR1JOn9
         TcXJFB4Hzd7tchUQOEnhAMPMa75W+HGThgn2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703666; x=1794308466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TmVfvTR81IST7Xj5rUGxeZIFqpc6YuhM88NFz7MYCz8=;
        b=AN+Cswzc214w2kE+pH7LTquvwnfPub906NdgXVHOKFBW21oJu4OZXriWBNjUFbrwHK
         jTp3UB3zJK3N9zVndsBiKYxWt5SLW3t+XPebmQ/LDe9Jw4r6a+iymQ9EjEmqGjW77GBV
         DTNlbS50PxaLjK2eAa8GRcfvw8XLXpT8SuMAyWii7iMRUs8uKOaPxzfmtmbLZlxmMrJK
         vYdFbs0XhP0jhxzZclPlXkP31F79W4ibML+aHQXYDm5HYVnfNBeYd18y0jnGmf/zhUtr
         WDOV4XRSBiJbEDMR5ysAlE7BwRYk7OAyf84q2ArI0TUU4RHddrJtGnCF9gNiknwTMdje
         C1UA==
X-Gm-Message-State: APuU4Z/w1oxGxnJemJFqiUbKQKoVUN9JXEcLcrnMTkWuIVJbKH4uaMYD
	4BGKVeFIdB0Fw7EfKO65/PbMO8UTz9bwQKHOVxn/bl8JQADfynDip9ONQcYo/kFEm6SthQYNvUs
	93w6HQ7Q/PtzP7uisvvcbe24Wp7j2NyBt7sIv4nxl
X-Gm-Gg: AYBFou2J0yf9CC8u1ZkcCT7oNq6eK501mdCk8Pu8aDTCBJ/6/0fkMZG/Pn+ii3r5vOd
	csvJpL6RWReK6vKsfRPFY/dJGcdy58uPfLRJfABQQqg4gh2NN41BtWP30bnhm7U/NMI8T2VTCcI
	nw90vp9vKU9is78tjC28WBo9VHF55aThSskaXZkbd6TfM1H/UFWYzgwUUP+H+RB45Ix7aQbktXd
	yRGHxeuaAy3T30GBleZUg/HQo10NjCQRQT9GvtX78MoKDv6pY5fXlZpURPDD2XpYF5+1+faXkvK
	q07km+uPUVggLTvBlTgpIAukUEqcntS/47GxHv0XbyUmtoAU9np+YHOhuJlO4P8j1hXs3p05OoM
	NVV4xGFwkXZtQvGDtaYiIkGINNq82Jr5XXQsaEot4/8JXvgx1UXkthxp2/SBg4g3LI7qIujoviG
	mlIs1ORIoz295JvN0e
X-Received: by 2002:a05:6a21:7988:b0:3e1:9071:acdd with SMTP id
 adf61e73a8af0-3e928dc3cc9mr8644686637.35.1793703666263; Tue, 03 Nov 2026
 03:01:06 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <bpf_redirect_neigh_short_linear.v2.r0.20261028080316-1@mojatatu.com>
 <179361314430.3131.5109011406127069679@kernel.org>
In-Reply-To: <179361314430.3131.5109011406127069679@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 3 Nov 2026 06:00:53 -0500
X-Gm-Features: AclHuK9G_adbeCGQMxvU47Uy5oZQf1wBAndJ2KfzBpSyXTQDKW5ekQnv2o6iOPY
Message-ID: <CAM0EoMkngAjZCZ9TKhn+bpC7zDJi3Vue1u-iYO2aCtE+bz++=A@mail.gmail.com>
Subject: Re: [PATCH net v2] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, edumazet@kernel.org, bpf@vger.kernel.org, 
	bot+bpf-ci@kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	dsahern@gmail.com, kafai@fb.com, martin.lau@linux.dev, 
	john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	jiri@resnulli.us, victor@mojatatu.com, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 4:52=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 (1) =C2=B7 Medium: 1 (1) =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The new netns_load_egress_bpf() calls inside
>   test_tc_redirect_neigh() leave the test thread in the test runner's=E2=
=80=A6
> - [Low] No selftest runs the new rejection branch in
>   __bpf_redirect_neigh() (skb_mac_header_len(skb) < ETH_HLEN ||=E2=80=A6
>
> Pre-existing issues:
> - [High] The patch closes the ETH_HLEN pull BUG only in
>   __bpf_redirect_neigh().
> - [Medium] __bpf_redirect_neigh() now linearizes only ETH_HLEN bytes,
>   then does skb_pull(ETH_HLEN) and skb_reset_network_header(), and=E2=80=
=A6
>

Most of this is stale material that the BPF Sashiko review already
exposed and we fixed it in a patch that has already been merged in the
bpf tree.
One of the follow-ups hadn't been captured yet until you pointed it
out; hank you for your service

cheers,
jamal
> --
>
> bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
>
> This commit hardens __bpf_redirect_neigh() before it reads and pulls the
> Ethernet header. The MAC header length (network_header - mac_header) must
> now be at least ETH_HLEN, and pskb_may_pull() must make the header linear=
.
> It also adds tc egress coverage to the tc_redirect_neigh selftest.
>
> Link: https://lore.kernel.org/all/2a0f5ff1d8db81b07fc4b344b8e68e3505fcbf3=
6f72a471d1678b2f1cecd881b@mail.kernel.org/
> Link: https://lore.kernel.org/netdev/20261027082604.1485903-1-edumazet@ke=
rnel.org/
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 70dc621672f2e..4925f3e355d46 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2432,10 +2432,14 @@ static int __bpf_redirect_neigh_v4(struct sk_bu=
ff *skb, struct net_device *dev,
> >  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device=
 *dev,
> >                               struct bpf_nh_params *nh)
> >  {
> > -     struct ethhdr *ethh =3D eth_hdr(skb);
> > +     struct ethhdr *ethh;
> >
> >       if (unlikely(skb->mac_header >=3D skb->network_header))
> >               goto out;
> > +     if (unlikely(skb_mac_header_len(skb) < ETH_HLEN ||
> > +                  !pskb_may_pull(skb, ETH_HLEN)))
> > +             goto out;
>
> [Severity: High]
> This is a pre-existing issue and was not introduced by this patch. Still,
> the skb from the commit message's own reproducer looks like it can BUG
> through the sibling redirect paths. Is that expected?
>
> After vlan pop_eth and bpf_skb_change_head(skb, 1, 0) on the nonlinear
> AF_PACKET skb, len is 8193, data_len is 8192, and one L2 byte is linear.
> __bpf_redirect_common() only checks:
>
> net/core/filter.c:__bpf_redirect_common() {
>     ...
>         if (unlikely(skb->mac_header >=3D skb->network_header || skb->len=
 =3D=3D 0)) {
>     ...
> }
>
> so the 1-byte MAC header gets through there. With BPF_F_INGRESS:
>
> bpf_redirect(BPF_F_INGRESS)
>   __bpf_rx_skb()
>     dev_forward_skb_nomtu()
>       __dev_forward_skb2()
>         eth_type_trans()
>           eth_skb_pull_mac()
>             skb_pull_inline(skb, ETH_HLEN)
>               __skb_pull() -> BUG()
>
> Without BPF_F_INGRESS the path is:
>
> __bpf_tx_skb()
>   dev_queue_xmit(lo)
>     loopback_xmit()
>       eth_type_trans()
>
> veth goes through __dev_forward_skb() and ends the same way.
> bpf_clone_redirect() takes the same __bpf_redirect() path. On lo, a plain
> TC_ACT_OK instead of bpf_redirect_neigh() also reaches
> loopback_xmit()->eth_type_trans().
>
> In each case the 14 <=3D 8193 length check passes. __skb_pull() then leav=
es
> len at 8179, which is below data_len (8192), and hits BUG().
>
> The commit message calls this a follow-up to Eric's short link-layer
> header fixes. This tree has no pskb_may_pull() in eth_type_trans() or
> eth_skb_pull_mac(), and bpf_skb_change_head() still accepts a header
> shorter than ETH_HLEN.
>
> Should one of those two places be hardened as well? Otherwise stable
> backporters may assume this change fully closes the reproducer.
>
> > +     ethh =3D eth_hdr(skb);
> >       bpf_push_mac_rcsum(skb);
> >       if (is_multicast_ether_addr(ethh->h_dest))
> >               goto out;
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but only ETH_HLEN bytes are
> made linear here. After skb_pull(skb, sizeof(*ethh)) and
> skb_reset_network_header(), can the L3 header sit entirely in frags?
>
> __bpf_redirect_neigh_v4() reads the header directly from skb->data:
>
> net/core/filter.c:__bpf_redirect_neigh_v4() {
>         const struct iphdr *ip4h =3D ip_hdr(skb);
>     ...
>                         .flowi4_dscp  =3D ip4h_dscp(ip4h),
>                         .flowi4_oif   =3D dev->ifindex,
>                         .flowi4_proto =3D ip4h->protocol,
>                         .daddr        =3D ip4h->daddr,
>                         .saddr        =3D ip4h->saddr,
>     ...
> }
>
> __bpf_redirect_neigh_v6() does the same with ipv6_hdr(skb) for flowinfo,
> nexthdr, saddr and daddr. When the route has no gateway,
> bpf_out_neigh_v4()->ip_neigh_for_gw() reads ip_hdr(skb)->daddr again.
>
> Take an AF_PACKET SOCK_RAW frame where prepad + len >=3D PAGE_SIZE.
> packet_snd() and packet_alloc_skb() make only hard_header_len (14) bytes
> linear. The frame passes both new checks, and skb_pull(14) leaves
> skb_headlen() =3D=3D 0.
>
> Wouldn't the 20 or 40 byte L3 reads then come from past skb->tail, from
> the tailroom or skb_shared_info? Those bytes would become the flowi4 or
> flowi6 keys and drive the neighbour lookup. No pop_eth or change_head is
> needed, just bpf_redirect_neigh() on such a packet.
>
> Would a pskb_may_pull() of sizeof(struct iphdr) or sizeof(struct ipv6hdr)
> before calling the v4/v6 helpers be appropriate?
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/too=
ls/testing/selftests/bpf/prog_tests/tc_redirect.c
> > index af8968b89ad7c..829f84fb64a30 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> > @@ -407,6 +407,26 @@ static int netns_load_bpf(const struct bpf_program=
 *src_prog,
> >       return -1;
> >  }
> >
> > +static int netns_load_egress_bpf(const struct bpf_program *prog,
> > +                              const char *ns, int ifindex)
> > +{
> > +     LIBBPF_OPTS(bpf_tc_hook, qdisc);
> > +     struct nstoken *nstoken;
> > +     int err;
> > +
> > +     nstoken =3D open_netns(ns);
> > +     if (!ASSERT_OK_PTR(nstoken, "setns egress"))
> > +             return -1;
> > +
> > +     QDISC_CLSACT_CREATE(&qdisc, ifindex);
> > +     XGRESS_FILTER_ADD(&qdisc, BPF_TC_EGRESS, prog, 0);
> > +     close_netns(nstoken);
> > +     return 0;
>
> [ ... ]
>
> > @@ -1055,6 +1075,12 @@ static void test_tc_redirect_neigh(struct netns_=
setup_result *setup_result)
> >                          skel->progs.tc_chk, setup_result))
> >               goto done;
> >
> > +     if (netns_load_egress_bpf(skel->progs.tc_egress, NS_SRC,
> > +                               setup_result->ifindex_src) ||
> > +         netns_load_egress_bpf(skel->progs.tc_egress, NS_DST,
> > +                               setup_result->ifindex_dst))
> > +             goto done;
> > +
> >       if (!ASSERT_OK(set_forwarding(false), "disable forwarding"))
> >               goto done;
>
> [Severity: Medium]
> Is the test thread still in NS_FWD when set_forwarding(false) runs here?
>
> test_tc_redirect() runs the tests in a separate pthread. open_netns()
> saves the original namespace with:
>
> tools/testing/selftests/bpf/network_helpers.c:open_netns() {
>     ...
>         token->orig_netns_fd =3D open("/proc/self/ns/net", O_RDONLY);
>     ...
> }
>
> /proc/self resolves to the thread-group leader. So the saved fd points to
> the runner's root netns, not NS_FWD, which the worker entered at the top
> of test_tc_redirect_neigh().
>
> The close_netns() calls in netns_load_egress_bpf() therefore setns() the
> worker back into the root netns. set_forwarding(false) then writes the
> ipv4 and ipv6 forwarding sysctls, and those resolve through
> current->nsproxy->net_ns.
>
> Would this turn off forwarding in the host namespace and leave NS_FWD
> unchanged? Nothing restores the setting afterwards. The test would also n=
o
> longer check redirect_neigh with forwarding disabled in NS_FWD.
>
> test_tc_redirect_peer_ing() already has the same pattern via
> netns_attach_nk(). Any of these would avoid it:
>
> - attach the egress programs before entering NS_FWD
> - re-enter NS_FWD before calling set_forwarding()
> - have open_netns() save /proc/thread-self/ns/net
>
> > diff --git a/tools/testing/selftests/bpf/progs/test_tc_neigh.c b/tools/=
testing/selftests/bpf/progs/test_tc_neigh.c
> > index de15155f2609f..e0b6c14a3935e 100644
> > --- a/tools/testing/selftests/bpf/progs/test_tc_neigh.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tc_neigh.c
> > @@ -133,4 +133,14 @@ int tc_src(struct __sk_buff *skb)
> >       return bpf_redirect_neigh(IFINDEX_DST, NULL, 0, 0);
> >  }
> >
> > +SEC("tc")
> > +int tc_egress(struct __sk_buff *skb)
> > +{
> > +     if (skb->mark)
> > +             return TC_ACT_OK;
> > +
> > +     skb->mark =3D 1;
> > +     return bpf_redirect_neigh(skb->ifindex, NULL, 0, 0);
> > +}
>
> [Severity: Low]
> This isn't a bug, but does any packet in this test reach the new rejectio=
n
> branch in __bpf_redirect_neigh()?
>
> This program sees ordinary locally generated TCP/ICMP packets at veth
> egress. __dev_queue_xmit() has already reset mac_header there, so
> skb_mac_header_len() is 14 and the header is linear. These packets pass
> both the old and the new checks, so removing the new check would go
> unnoticed.
>
> tc_redirect_neigh is also registered only for veth:
>
>         RUN_TEST(tc_redirect_neigh, MODE_VETH);
>
> so the netkit case mentioned in the changelog is not exercised.
>
> Would a negative test be worth adding? For example,
> bpf_skb_change_head(skb, 1, 0) on a nonlinear skb followed by
> bpf_redirect_neigh(), expecting a drop.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/bpf_redirect_neigh_short_linear.v2.r0.20261028080316-1%40mojatatu.com
