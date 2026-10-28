Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163749;
	b=hbQizjKmfGTvqy4GQ5Uk/poh6gJOQK/C0BAlpN/wI03GGJgNrp6ZV9yjIgt6LdIixWeT
	 tpTEGIhzIJJehH+bcFN1DNS3+zvD1JubNN42Rt19pGlqx3JNsYMYA5p9uXFq8K+5s8gYq
	 xJs/tU22H/mvjBlyrxJUMSFw/mIJcQrHLBd+Sm20lf+XEowerltQtRENtA0I/M4TW5CuG
	 P4T6g/AraAEMvLKMmCdu3G74EQZFAubP/ege/YhnHm+rPu8i82LdrMXz9X22wp7iaKWox
	 WbZGDNerGommzVs5RbLGmNPLR/CmixBEm5xWEvkLQxPzZnaZi/UXj2295zq9vkxP9Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163749;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Nt34RCcowMXQHK8hVYxiQ02gxF79JCWr4TAQV668p4U=;
	b=r8/+sbrnnpXy+QBMrYm3gEv6/bgmgeqXtPMQw8rgk3sku4G5ujmHo+RTd2PXuI8UP9ya
	 2HI4uFzVzsrR7JuEn328eKdHB+b266DUeftWFdMC4JB6n0kcTsXz4UMHv6XTxrBxHoc2R
	 KdR6giktpg32gRT72TKNs0uAUYWXtaFkO3rMyUcqWRzxJn//7EaKC3W7fWhLEPDFWYU28
	 WFFWegMM3Z5vVBI8veK8bqBm3eoETW5y7f276o9mIW6LufHjzBrBwkkMfvsA6TPtpDgvt
	 Ycq2gz73nY1YFZQz8kGhqh8+CbphQ9xGuFgEugWCQZLvSwEV4n8wp8mQbSEgDGVF1Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nxC0C6F/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF9606A331
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 05:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxC0C6F/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049331F01829
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 05:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793163749;
	bh=Nt34RCcowMXQHK8hVYxiQ02gxF79JCWr4TAQV668p4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nxC0C6F/pxEpbxv3/Vnt7Ss4cwFC12YY+D7EOHglVLi6S9qQHHZsnxrEPcce/ILCK
	 PQ1CgXtjtSlrqYCdAIL0WQ35bD1LlG7Q/B1upnkYOJZzA6Z+Aeme5tY+iKwVSNzqi5
	 O5pZppyBWzL8Rsu2TNpzmJXMXyEDzNIqvH9dMtpJCUMuncGroXFpZtolzd0HgLsfkH
	 ytaoVfwShBx7Ip/0cPol5vIX7uRSJdFh24H+WrjvyRueMdy38Gl1xgs+DnUiOYh1RS
	 t06gJtRsl7mFRhav+56NYIifHuHbxkHVZ8xwvEemxArVsIujO7A3GA9w3ZtP9EjSK5
	 SBxaEx9wPU8WQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-49429181ce9so376928fac.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:02:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByze6UJo1h42ovNj7xePaAQ5db9YO4R1BNyB1RwWULE6f0ddVB8tBSYxoTycxQfGhtusDM6zMU=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+LNk+3j1E/qDS8Pq65ETSoM60OfTCPZebv6XXGZG4dZ7J6UId
	vr6T2LwtI5vhFschS9s6jlCBDi177wzZ+sx7ZSO6NiB+WijuH7w53wtqZy+8yad9TNAPtIQalaR
	DrLaZlkHJ/VLxQX6z/qakED6LXOd9OV4=
X-Received: by 2002:a05:6871:3412:b0:48f:e22e:7f8f with SMTP id
 586e51a60fabf-4a8bb5cdcc4mr1121009fac.48.1793163748090; Tue, 27 Oct 2026
 22:02:28 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027082604.1485903-1-edumazet@kernel.org> <20261027142511.5b00207b@kernel.org>
In-Reply-To: <20261027142511.5b00207b@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 28 Oct 2026 06:02:16 +0100
X-Gmail-Original-Message-ID: <CAL4Wiirw8fnHKHr_8aHXHYjVhn_oWGKb68Fn18r=Z33_wqRjXA@mail.gmail.com>
X-Gm-Features: AclHuK9l-peX4PnFvI2owYlL4NyQELkpKZWgOU4jsut03usjMi_vZyVhidgdh3s
Message-ID: <CAL4Wiirw8fnHKHr_8aHXHYjVhn_oWGKb68Fn18r=Z33_wqRjXA@mail.gmail.com>
Subject: Re: [PATCH net 0/5] net: fix eth_type_trans() crashes on skbs coming
 from the stack
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, dev@openvswitch.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Ren Wei <weir@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 oct. 2026 =C3=A0 22:25, Jakub Kicinski <kuba@kernel.org> a =C3=
=A9crit :
>
> On Tue, 27 Oct 2026 09:25:59 +0100 Eric Dumazet wrote:
> > eth_type_trans() assumes ETH_HLEN bytes are present in skb->head.
> > NIC drivers always provide this, and they should keep using the fast
> > version, without an extra pskb_may_pull().
> >
> > Devices looping skbs from their transmit path back to their receive
> > path get skbs built by the stack instead. tc actions (act_vlan pop_eth,
> > act_ife decode), BPF helpers (bpf_skb_change_head() before a redirect)
> > or OVS actions (pop_eth followed by pop_mpls/pop_nsh) can leave fewer
> > than ETH_HLEN bytes in the linear part, and eth_type_trans() then hits
> > the BUG() in __skb_pull().
> >
> > Instead of fixing every producer, or adding a check to all
> > eth_type_trans() users, fix the few consumers exposed to this:
>
> Bot says:
>
> BPF CI (bpf-ci) is reporting a consistent regression with this patch
> applied: every single job variant (x86-64/aarch64/s390x, gcc/llvm,
> no-alu32/cpuv4/ASAN) fails the exact same selftest subtest:
>
>   #135 empty_skb
>
> Specifically, the "veth ETH_HLEN+1 packet ingress [redirect_ingress]"
> case in tools/testing/selftests/bpf/prog_tests/empty_skb.c now fails:
>
>   test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress [redirect_ingre=
ss]
>   unexpected ret: actual 1 !=3D expected 0
>
> That test redirects a minimal (ETH_HLEN+1-byte) skb to a veth's RX path
> via bpf_clone_redirect(..., BPF_F_INGRESS), which goes through
> dev_forward_skb() -> __dev_forward_skb2(). Before this change the skb
> was forwarded successfully (ret =3D=3D 0); after switching to
> eth_type_trans_careful() it is now dropped (actual =3D=3D 1, i.e.
> NET_RX_DROP).
>
> Could you take a look at whether the new drop-on-failure behavior in
> __dev_forward_skb2() is intentional for this previously-accepted
> ETH_HLEN+1 packet, and if so, update the empty_skb selftest's expected
> return value alongside this change? Right now the selftest and the new
> kernel behavior disagree, and it's failing 100% of the time in CI on
> every arch/toolchain/config combination we run.

This test needs an update.

The failing program is the lwt_xmit one (redirect_ingress), not the tc
one. For lwt, BPF_PROG_TEST_RUN strips the 14-byte Ethernet header, so
the program sees a 1-byte skb, with skb->data at the network header.
bpf_clone_redirect(veth, BPF_F_INGRESS) then calls
eth_type_trans() on a 1-byte skb.

Before this patch, eth_type_trans() did not pull anything because
skb->len < ETH_HLEN, read the Ethernet header 13 bytes past skb->tail,
and sent a 1-byte "frame" up the stack. Now __dev_forward_skb2() drops
it and returns NET_RX_DROP (1).

The same packet sent with redirect_egress is already expected to fail
with 1, because veth_xmit() does pskb_may_pull(skb, ETH_HLEN) and drops it.
Ingress and egress now behave the same way. The tc variants (skb->len=3D15)
and the ipip variant (no MAC header, __bpf_rx_skb_no_mac()) are unchanged.

In v2, patch 3 will also update the selftest, renaming lwt_egress_ret
to lwt_ret so that it applies to both lwt programs. empty_skb passes
with it.

Thanks.

# ./test_progs -t empty_skb
[   50.888061] bpf_testmod: loading out-of-tree module taints kernel.
#115     empty_skb:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0/0 FAILED

diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c
b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
index c9fcb70cbafbce571d7826e233920193625dead1..a3938c16557b140e3ee5c116139=
cf8b636f85e35
100644
--- a/tools/testing/selftests/bpf/prog_tests/empty_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
@@ -24,7 +24,7 @@ void test_empty_skb(void)
                int *ifindex;
                int err;
                int ret;
-               int lwt_egress_ret; /* expected retval at lwt/egress */
+               int lwt_ret; /* expected retval at lwt */
                __be16 h_proto;
                bool success_on_tc;
                bool adjust_room;
@@ -82,7 +82,7 @@ void test_empty_skb(void)
                        .data_size_in =3D sizeof(eth_hlen),
                        .ifindex =3D &veth_ifindex,
                        .ret =3D -ERANGE,
-                       .lwt_egress_ret =3D -ERANGE,
+                       .lwt_ret =3D -ERANGE,
                        .success_on_tc =3D true,
                },
                {
@@ -96,17 +96,23 @@ void test_empty_skb(void)
                        .data_size_in =3D sizeof(eth_hlen),
                        .ifindex =3D &ipip_ifindex,
                        .ret =3D -ERANGE,
-                       .lwt_egress_ret =3D -ERANGE,
+                       .lwt_ret =3D -ERANGE,
                },

-               /* ETH_HLEN+1-sized packet should be redirected. */
+               /* ETH_HLEN+1-sized packet should be redirected at TC.
+                * At LWT, the Ethernet header is not part of the skb, and
+                * a 1-byte packet is too short for an Ethernet device.
+                */

                {
                        .msg =3D "veth ETH_HLEN+1 packet ingress",
                        .data_in =3D eth_hlen_pp,
                        .data_size_in =3D sizeof(eth_hlen_pp),
                        .ifindex =3D &veth_ifindex,
-                       .lwt_egress_ret =3D 1, /* veth_xmit NET_XMIT_DROP *=
/
+                       /* lwt: skb->len=3D1, dropped by veth_xmit() at egr=
ess
+                        * and by __dev_forward_skb2() at ingress.
+                        */
+                       .lwt_ret =3D 1, /* NET_XMIT_DROP / NET_RX_DROP */
                },
                {
                        .msg =3D "ipip ETH_HLEN+1 packet ingress",
@@ -144,7 +150,6 @@ void test_empty_skb(void)
                        eth_hlen.h_proto =3D tests[i].h_proto;

                bpf_object__for_each_program(prog, bpf_obj->obj) {
-                       bool at_egress =3D
strstr(bpf_program__name(prog), "egress") !=3D NULL;
                        bool at_tc =3D
!strncmp(bpf_program__section_name(prog), "tc", 2);
                        bool is_adjust_room =3D
!strcmp(bpf_program__name(prog), "tc_adjust_room");
                        int expected_ret;
@@ -153,7 +158,7 @@ void test_empty_skb(void)
                        if (tests[i].adjust_room !=3D is_adjust_room)
                                continue;

-                       expected_ret =3D at_egress && !at_tc ?
tests[i].lwt_egress_ret : tests[i].ret;
+                       expected_ret =3D at_tc ? tests[i].ret : tests[i].lw=
t_ret;

                        tattr.data_in =3D tests[i].data_in;
                        tattr.data_size_in =3D tests[i].data_size_in;

Thanks.
