Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794584717;
	b=qAJVjgJkQjRgYsM6XFfX4SuBH3QpXjt6YLU+pa0TGhp8YFMP8u/fl51KwZKBrpbgIVfB
	 vRqBy/PjxhaJf1VtM1O5UfLwEWttYeGLMcnAuNZ4quNMSqFUAqrOpa3L9k/q8kExyAfl6
	 eG8H14LcOaOJ+G6KUV3yBHg/HDcDkueQSs/tCMbi68ZdVfD/A+QQ1gB0zemRX5OYqQYqR
	 LsGfkBTcCO1+6F/4/fi+IQ2oXqPUUdzq6TDjqB//gd4RXAj5WEzpPSBvz7g1kUu7YaL1N
	 DcJ35Er98+U8GP49V4PsnAV677/GdylGSaUFmbvuC3ARPRK4YY01qBXPDMVA7V7xD1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=c5iW7hFGFNOx8F7eV0NOM/A0yCVzQynJGDZ1MOVXip8=;
	b=yY6G/aoGLj9c9CVf8QuFJ6Nh270mf2r0NpJxTkPDCD0yEmINjVMYhLwhp1pFpliY2Ah9
	 d8yEMUm//JK22pVOsDXMWfloT/oNccdiY7r1h2BfT+wHxK8DO/moFXOMKwjDUCNDTZ+YK
	 a3RZtlxqoqB1cEM/e3doFthwxqs5cCU6mB0RJ7rUCYLUsoDPa9g/QnQlXaf9nJZL5pnJT
	 d6bRylf6DPNZexDKXvdKMUAR5K8ewYotl++QQl5pU5ociiKbCckN1evv/sL6kFu9+MW2/
	 IgJyBzfpFeqfaRaAGXgR3jURdooveA6WplRp+UfIQS6u+MhZxX8//qYmKKMuVmnh4Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=gtoyXS8s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4360A2634
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97F4360A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=gtoyXS8s
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a07078200fso529032b3a.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:45:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794584716; cv=none;
        d=google.com; s=arc-20260327;
        b=IVZwYG8oEIOIrCAfgD7DBBtL+RN8iQtM6q+ta373CFbCk0/ncjqXLrHzGTjdVQAb6d
         LY6zK+uDy0soKxvi4GNygpLTImMGoVyYB/XLapL1L2uQbJ27U+Q85kMvt4T3+Zelmr3f
         8B7vPNtJU0Wl+d9Pb/BMnMdWf6h69WYpVZVMBX7gzN/EsuQ0AQpkx0etqy4IMcLroVa9
         YCv0QxSk4NV9n/tjCEjErvTeKLGaRhCdzyaBaaObqWr9ffYxJgvj7NqXwdhkYPa6S050
         n1SVP1wncJ1qNB+l+BpwgwzOyhoQhKqlNqJY296B/wJXPowfpl1j9534y39IVL0PiO7I
         WgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c5iW7hFGFNOx8F7eV0NOM/A0yCVzQynJGDZ1MOVXip8=;
        fh=jGP94s6/Hyd4pujaa4aFKt/3oZ83DCQDqB1wcRsL9wU=;
        b=Hd1RYRErbJcZe3zWHvnu6kpIxRF/D3Fulql1ONAdXHqlxPHTLtoN3HZmapYasmMRb2
         Z1sjtvuO+yFK/YmYu7CU/TljlNh5xuLBzI0FW5Qs5nLsGgnMQOoGdM5KaJS7gV5NRce0
         eTY6pGnIzbeTF5lGQ1HMCNESW2lkfMjGfK1tWCMudEO1UVATQSvyQ02erKEclnrEpPuW
         8mf/9/0ptHjRDsOkdqsqtpPPhouqfkAys+5BklYewNbYlNiSM3T37UcpVlox4OrwEL5r
         DulyDa5qZYwUp52yKGBDDEml7rubSETbOanEH8hOeVN/ObDjQTa5Kw1BenDgMq+2yFLI
         hPcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794584716; x=1795189516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c5iW7hFGFNOx8F7eV0NOM/A0yCVzQynJGDZ1MOVXip8=;
        b=gtoyXS8sibSv91jyE0d+glz/dkfX28fQnlRJfDZ21x/tgcZ/MQ3lgEAicEY00w1TJ4
         d6YUH6TKoCwrqnkEWH0EEtRkWkPomyRqgPjOThGDsXe0d4xgiOrdZEAJJ8AP8J+kNK/H
         WiPI4WSLx9ms4Xu9VuxmhhUYC69nUkYpxiaSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584716; x=1795189516;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c5iW7hFGFNOx8F7eV0NOM/A0yCVzQynJGDZ1MOVXip8=;
        b=s1/tBFCCyiINxR9Tp2NGK78R9wIULRWIlgWOmPToC6ypq0hKmT3n3IrGT0MWWZXmmz
         bDm5s+fXU5q1zW92juN07TfnrMAChJuqBEUi7DH6bNFTTBrv4cfNnINsmmvE/SLAFSdd
         zZ6FGrH+iPXjbeEIr87Jh5TZNLMctf5VTygjk3fQ7x9akeeyoXSTxDEuviYmdcPu3mJE
         M1jzxbK1G+BsULq4zl/PeQr5l8he0gCZ8ccv84qSqp4NamJjOT5iMylFji9VCkSnLpwQ
         Ve4nCEeEmPiJzwchaIJmbvasftnUf03f7Qs/2Ct8kkm0Gup87QLe5mk/QM6cEFG1MUd7
         IQgw==
X-Gm-Message-State: APuU4Z+B4oXbDeCxOWO8S4rwg5eBD664IrHtnnevWak3J2hE2b18Aq5s
	rOVeTA2hMrRDbQz7EDlk4e06gP6IA2djazQJIKy3yoKyn46kZquQFqZEFwfS9y5n0PIH1QSGBgo
	iQnJtIo8hesvZ1hqrqDif6SdlwzNnTv4qGxg/TjwJ
X-Gm-Gg: AYBFou3PZQa1yJ2oEv2vb+hcsf3LOeFg22D2RVgAdibubBfUfDxQuu4Qw+LUD5CTes+
	DfGNxgMiHg5ehohfxOw00USKTAmf+5t41/D1e3zGKpmCjlRFAy69Xh/rX6yLe9ny/74569s2uCX
	yrDz1BM9DYIKUk1dRCdF1T5cUXqCHPuSoyMMV8Ke9+9axvQvgJqluA3b32JgVqB5eFZ1EuOaCd8
	vQnJMej7Y3pSLrDOT4S5PKtseq0R7Qm0O6Lqztyu9qRx54Y8yToG1vlhqV04Onzlb/6Ahdev9fF
	7hL9l+Vf9PqZ4DeojpObvv0BuLtpFsjbfuN7jJPT2XzkOMgaAqwZH3cvtqklYGIS7PRRvmKMYS8
	mBTJnmhBgijINHvAAIDzExUC0zmPw6FPAspX/gHV2KTTHbh1VJspXrgMaffQUeEesWFxCgf5MTM
	Kg4BUwYlRiafkfoCI=
X-Received: by 2002:a05:6a00:1821:b0:89f:3f60:cd81 with SMTP id
 d2e1a72fcca58-8beb753c09fmr3091922b3a.51.1794584715692; Fri, 13 Nov 2026
 07:45:15 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-1-toddfreed@meta.com>
In-Reply-To: <20261111005533.6436-1-toddfreed@meta.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 13 Nov 2026 10:45:03 -0500
X-Gm-Features: AclHuK-0_XHEf697Be0EzhcTRZNub2trE33MmnEGFo9sAnvUacsR3JeRnWq8RJM
Message-ID: <CAM0EoMnPM54re5-WKyWgwyoz0cn1uGT6=E96OBG2-4m7M+kx7g@mail.gmail.com>
Subject: Re: [PATCH net-next v1 00/15] psp: introduce socket-less associations
To: Todd Freed <toddfreed@meta.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	John Fastabend <john.fastabend@gmail.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Wei Wang <weiwan@google.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 7:56=E2=80=AFPM Todd Freed <toddfreed@meta.com> wro=
te:
>
> psp associations today are bound to a tcp socket when created. traffic
> on that socket is encapsulated in transport-mode psp, and encrypted.
>
> this series adds associations which aren't bound to a socket, which
> allows psp encapsulation and encryption to be applied to forwarded
> traffic. you can use this to transparently apply psp tunnels to flows,
> with help from userspace to manage the tc rules and orchestrate key
> exchange.
>
> the lifecycle of socket-less associations is managed over the psp
> netlink family. socket-less associations are stored in a small registry,
> and are addressable by id. the registry does not contain socket
> associations.
>
> socket-less associations are on the device's association lists, like
> socket associations. rx ones are therefore marked stale by key rotation
> in the same way. in this series, nothing acts on socket-less rx
> associations on key rotation. instead, userspace should replace decap
> rules for a SPI before its device key has been rotated twice. a
> follow-up will bring enforcement.
>
> series structure,
>
> 1, 2/ prepares psp to work with non-tcp packets
>
> 3, 4/ adds the netlink commands for managing socket-less associations
>
> 5/ adds a METADATA_PSP dst which carries the socket-less psp association
> on an skb for tx, and the transmit checks for it
>
> 6, 7/ keep mirred and bpf from sending decrypted skbs from egress to
> ingress, since skb->decrypted depends on direction
>
> 8/ limit time-wait psp socket validator to sockets actually in
> time-wait. the new psp actions check for presence of the validator
>
> 9/ adds the act_psp tc actions, psp encap and psp decap. in software,
> encap is egress only.
>
> 10/ adds flower matches on psp header fields, for rx matching
>
> 11, 12/ add drv-net tests (netdevsim and hardware)
>
> 13/ makes tc-testing run dependsOn probes outside the test namespace,
> where they currently always fail
>
> 14/ adds tc-testing tests
>
> 15/ Documentation for socket-less psp associations
>
> a following series adds hardware offload of the psp actions and flower
> matches, psp tunnel mode (which is offload only and therefore not
> included here), encap on ingress (also offload only), and the mlx5
> implementation for switchdev mode. It's available in the tree below.
>
> relation to the psp fixes in net:
>
> this series is based on net-next, and overlaps with "psp, tls: don't
> send offloaded contents in cleartext" in net:
>

I looked at the net/sched bits also looks like the two sashikos
already caught at least two issues i would have brought up. I have
started a test run on our test system to see if anything pops up; i
dont suspect anything will show up, but if it does, I will followup to
this posting.
My suggestion is you address the issues brought up by the sashikos and
spin v2.  I will review when you post a v2 and possibly add my
reviewed-by.
In v2:
If you have, or can capture, the decapped-GSO packet shape that leaves
the L4 header non-linear (gro_cells/vnet_hdr decap bridged to the
act_psp
egress), attaching it to the v2 would be useful evidence for the GSO fix.

cheers,
jamal

>  https://lore.kernel.org/netdev/20261111001831.3710881-1-toddfreed@meta.c=
om
>
> when net is merged into net-next:
>
>  - net/psp/psp_main.c conflicts around psp_dev_encap_ok(), which both
>    add: net's only allows tcp, this series' (patch 2) takes any l4
>    protocol. keep this series' version of the function, and its
>    comments above it and above psp_dev_encapsulate().
>  - tools/testing/selftests/drivers/net/psp.py and
>    tools/testing/selftests/drivers/net/config conflict: keep both sides
>    (imports, constants, the list of test cases; the NET_ACT_* options).
>
> relation to the netfilter fixes in nf-next:
>
> packets which a psp device decrypted don't have to end in a local psp
> socket. they can already be forwarded or bridged today, but with
> socket-less associations that is the intended use, e.g. a router that
> decaps and forwards. netfilter handles two cases itself, outside the ip
> stack paths which the net series fixes, and would send such a packet's
> decrypted contents in clear text:
>
>  - the bridge refragments packets which bridge conntrack reassembled
>    (br_ip6_fragment(), nf_br_ip_fragment()), without the check of "net:
>    don't fragment decrypted skbs".
>  - the reject code builds its own icmp errors and tcp resets
>    (nf_reject_skb_v4_unreach() and friends), without icmp_send() and
>    icmpv6_send(), which the net series' icmp patches cover.
>
> a separate series to nf-next applies the net series' rules to both:
>
>   "netfilter: bridge: don't refragment decrypted skbs"
>   "netfilter: reject: don't reply to decrypted skbs"
>
>   https://lore.kernel.org/netfilter-devel/20261111003111.3826942-1-toddfr=
eed@meta.com
>
> it doesn't depend on this series, and the two don't conflict.
>
> trees:
>
> the full tree, with the net fixes, the nf-next series, this series and
> the mlx5 offload series, and the conflicts above resolved, is at:
>
>  https://github.com/toddfreed/psptc branch psptc
>
> iproute2 tree, with support for the psp action and the psp flower
> matches, based on iproute2-next. the selftests need it:
>
>  https://github.com/toddfreed/iproute2-psptc branch tc-psp
>
> testing:
>
>  - netdevsim: drivers/net psp.py passes (57 tests), and tc-testing
>    psp.json (17 tests).
>  - mlx5 (ConnectX-7, FW 28.48), two hosts: drivers/net psp.py passes:
>    46 pass, 8 skip (GMAC versions not supported by the device),
>    3 xfail (netdevsim only).
>  - each patch builds without warnings with gcc and clang, allmodconfig,
>    W=3D1.
> Todd Freed (15):
>   psp: get netns from net_device instead of sock
>   psp: take the psp nexthdr from the packet on encap
>   psp: declare psp_assoc_set_tx() in psp.h
>   psp: add support for socket-less psp associations
>   net: add METADATA_PSP dst to carry a psp association on an skb
>   net/sched: act_mirred: don't send decrypted skbs from egress to
>     ingress
>   bpf: don't redirect decrypted skbs from egress to ingress
>   psp: only give time-wait sockets of psp connections a validator
>   net/sched: add act_psp for psp transport mode
>   net/sched: flower: add psp_spi, psp_ver, and psp_dev matches
>   selftests: drv-net: psp: test socket-less associations and the tc psp
>     action
>   selftests: drv-net: psp: test that software encap on ingress drops
>   selftests: tc-testing: run dependsOn probes outside the test namespace
>   selftests: tc-testing: add tests for the psp action
>   Documentation: networking: psp: document socket-less associations
>
>  Documentation/netlink/specs/psp.yaml          |  98 ++-
>  Documentation/netlink/specs/tc.yaml           |  14 +
>  Documentation/networking/psp.rst              | 139 +++-
>  MAINTAINERS                                   |   3 +
>  .../mellanox/mlx5/core/en_accel/psp_rxtx.c    |   2 +-
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |  33 +
>  drivers/net/netdevsim/psp.c                   |   2 +-
>  include/linux/skbuff.h                        |   4 +
>  include/net/dst_metadata.h                    |  19 +
>  include/net/flow_dissector.h                  |  18 +
>  include/net/psp/functions.h                   |  91 ++-
>  include/net/psp/types.h                       |   1 +
>  include/net/tc_act/tc_psp.h                   |  23 +
>  include/uapi/linux/pkt_cls.h                  |   6 +
>  include/uapi/linux/psp.h                      |   6 +
>  include/uapi/linux/tc_act/tc_psp.h            |  28 +
>  net/core/dev.c                                |  48 +-
>  net/core/dst.c                                |   5 +
>  net/core/filter.c                             |   9 +
>  net/core/flow_dissector.c                     |  27 +
>  net/psp/Makefile                              |   2 +-
>  net/psp/psp-nl-gen.c                          |  60 ++
>  net/psp/psp-nl-gen.h                          |   8 +
>  net/psp/psp.h                                 |   7 +
>  net/psp/psp_assoc.c                           | 120 +++
>  net/psp/psp_main.c                            |  54 +-
>  net/psp/psp_nl.c                              | 261 ++++++
>  net/psp/psp_sock.c                            |  32 +-
>  net/sched/Kconfig                             |  13 +
>  net/sched/Makefile                            |   1 +
>  net/sched/act_mirred.c                        |   6 +
>  net/sched/act_psp.c                           | 439 ++++++++++
>  net/sched/cls_flower.c                        |  64 ++
>  tools/testing/selftests/drivers/net/config    |   5 +
>  tools/testing/selftests/drivers/net/psp.py    | 750 +++++++++++++++++-
>  tools/testing/selftests/tc-testing/config     |   2 +
>  .../tc-testing/tc-tests/actions/psp.json      | 459 +++++++++++
>  tools/testing/selftests/tc-testing/tdc.py     |   2 +-
>  tools/testing/selftests/tc-testing/tdc.sh     |   1 +
>  39 files changed, 2812 insertions(+), 50 deletions(-)
>  create mode 100644 include/net/tc_act/tc_psp.h
>  create mode 100644 include/uapi/linux/tc_act/tc_psp.h
>  create mode 100644 net/psp/psp_assoc.c
>  create mode 100644 net/sched/act_psp.c
>  create mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/p=
sp.json
>
>
> base-commit: ed04b202027249e2769420893220f54a56e0c59a
> --
> 2.53.0-Meta
>
