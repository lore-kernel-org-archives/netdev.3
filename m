Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201498;
	b=G4iuYzzpEWb3/gLW3zu9SIkxTD0wWm+HR6byp2CLu8qnuIYxz8kQTyxu3Fw+dD2ane+I
	 EgVI+LPoX4w55Wvd39iEL/0AGMZTnCFvtlItvjGMyqxluX1P2OAb8oBv7SpqXZuoCWLld
	 Bl/FtlqTYIIss/Uktiue0MrIJb66qrFQNhQZRnhpueLufI9Gp8NTBx7DV9b8RAJOJfis+
	 XtXnOIQpQ0Wysk/W/sCKSs7yxmAaqsNdSnJCr8sIJkwdhkY+11mb94XmWWjYm1Os2RH7m
	 6utD+2NrbnoNsSRMc5rmZxyaiS11U5BNCF4foixWjRr5zBYsd1LIABKdfp5rSP7dhMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=rrR5tguq/NvSlADBqoxK8L/OZP4UosuurE+5SxRCUqU=;
	b=T5RExWR1fdlaKScoOt40BJgeElxy1aiacxI8L/yNQpFVwtYb7SG7RRe74QTjUFPY9Iyt
	 TIXY+kanYjANPR/3ZlfEkSu+/Q44rfu34C4c6lnb57AmSHKAtd90hwoVNzoXUzxz/N0G+
	 6hiiSMlCkgO7RUPHzZswpvlUosptgtYDYYZjOfI4fVeoHbKNz9+YjRwJQ3PpYUjyRelpz
	 f6XoFBPnicnxa/q9bqYIoQjzNPP6l0eV3WZnSA6pqPekB9Y3Hz0rqy5CKHdyEIxzfoAeb
	 OmbvJnO8BqePFq182+Ib9dL8rcVibb1iWewEUV+Dvov8KgnR5a9/O+Gfa02c5xp0IuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sxf8rSp+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C10606A323
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99C10606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sxf8rSp+
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-70059e4dab6so768053eaf.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201496; cv=none;
        d=google.com; s=arc-20260327;
        b=JLyA91Hgr0IEG/IEE7GuHC1bEg+qCYksQuv+cNQDq04PzGL6fGXBhDhi3/7tMWIF1e
         ccl1FrImI22/Fp4MSfT8ZDVRCTpc+JafBqZQuKSuKQU4cft78bZkDvDUw0DF0HpSTXT0
         btLN2Vmf94qxbn3ug+rFkPQjU3rql6LgIcG1LHFIadSAHE9daudRqasVbRHBH9aIQ5QP
         NFV8f2I1IpQ0Xtlg+Q+hXdh1rirNQ6UDboC/60sGCB5gGbdVHeYQkUwN981gnEayZTSK
         APZxhHhmr8AW/0H1cpA9uneODWB4nwjxM6KzZrGf8Fy2/dHNF9gxq2v93tqUu6UwCD1a
         vxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rrR5tguq/NvSlADBqoxK8L/OZP4UosuurE+5SxRCUqU=;
        fh=OBbQkacgZ7cYtP0T1vawJYVUlwTF+SB5luilsO0YceA=;
        b=Ccml/bMVmkBWtdD2d7pIHx5HGnraNPK28xvheBmye5bia+XJQhIbLeIb7WvxmFNp21
         KU73RVcGPE61S4UJDVwKX+pCpgHxAyhW0h3Sw2Ol5fcmDta53ZsYlzZuFhwYlyRdoFho
         MfhHfbyQnfN0sRtSwWL4CFfkHQBJGWDyn5/zDOWQvUKqCmpvsnjf5eF9ZhjX97LmEESu
         9iTyS0ljn63fnwyIMTBoqvB6fkH/Fy63+WdPxoWKNUETnuI2dhao8zKec8+LaTwqWp/O
         0wF83yU0o0c3OU0CSXywBwmV/PSwZhKMzJ6d7jF27IpIZ/Gh++9rW4gS1wwPYLEeHV+c
         +L0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793201496; x=1793806296; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rrR5tguq/NvSlADBqoxK8L/OZP4UosuurE+5SxRCUqU=;
        b=sxf8rSp+WVeGNtc6ZPLLInx/cWqJLs/0HE2OXjEcq9N9e+/QxmPk85WHsykOaoBQ4D
         2SyyRr/AK6aSUT4nQuS6R8ivZKMoaejx2gHUWAbSFcpRnukaV9Zx3aFBOQVGjIl9/A78
         3k9Sm+61uH6dJZy/kHNCft3cJ/wBXXXSvOr7i5oneuSUD4/yJP7RuS6hcEOmh1Ypvgaq
         UYFXAJi2X/Akh3c3wRRxSx0lvci9rCm8gLWNGYDwMq5Ilykxfqh2DgGqjgB1ogVTWIGW
         lRkceM4WlYbRDOFxDTxslZhUzgAY32g8DFnz8oij4INaXpemPJtOJKgFeMRNbd+f6Tzi
         2Bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201496; x=1793806296;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rrR5tguq/NvSlADBqoxK8L/OZP4UosuurE+5SxRCUqU=;
        b=tedRxg2PjPZyZ5SaNt4ALiTbhjRzdNctvuNmOX+f5/s9Y5VvDMdg4xl8MJatVN94+X
         MdtUKTdqFw554hiVH3UdaLfUFahnZYZddVFqay/bcdS8CwLzQjuSHrDA7s9hF7hWlOwM
         cvnaiH7ePGESuwnXpb6Ys3RAxrAmFWIDRL8PnW4iSZs4lvFVFCQ1pw2IPdi7Gs87o0f/
         nPMpN68s0SYosAQgdPke60pvNxWx0kfI9/PfWBG1lM7xQQCX4bBRLVXvhJ/DWH/JpQoS
         wx5MnikFK31eSWxwsxk0r+adc+4hJqdP/CuYHgEfXkdNYuJaqS1ag+lsn42KOMN/4wzR
         A7hg==
X-Gm-Message-State: AFq9FYLWAUzIyLgnzOh9i7c6KHD3cZJA5MawC3k2PxzdTSA+NDhhcw2k
	d7Ko4ZIMiLHNyJzRJBgcv2lUD/9D95U8csHB1br8VFv5N4h+N3GtQ2mm8z6h8V3vw/lh1iCK+XZ
	arcbpkDq6fRYxmylZKao+UB5+SCG3Dt8g7wxX2p9TRBsu
X-Gm-Gg: AYBFou2OuNK+CBUfBumguUfoTLf3TmZPg+W9q0R1iVWeZ1Dq5p8BIHGLIyIA/1w0T1A
	/Swrjo7WH7VKOc9nVTzx4779PaaPjBii41jfiJSh9DXOavkppiXkaJ4st5UlQb9Lhz7JShU+jOZ
	Y/fKokCIap/Es8cCpanp7ggW1yz++vVvdbJNTmEyLBx2Hf89NDJ5vJ+lntqwevkf1d0N9g1Y/JX
	zhWW6zWi8wLew1ImmWmhQplTPHM8FGI8Wx946bRqJve5umT749abdmTg9ASvHNCFXzZ19Z+/21z
	OjJ9RdtRsLNQphA6dI8V4PNHhFDppoYIWtL81nuukjDBo/FXLXXJtia6YA6HWdxGEkoQoKErpxy
	MzbULPxUmMG3XU54PUQMzS0o3F2iHouQa2OLH
X-Received: by 2002:a05:6820:351c:10b0:708:ec28:6fd1 with SMTP id
 006d021491bc7-713f213ef01mr994177eaf.66.1793201496013; Wed, 28 Oct 2026
 08:31:36 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Wed, 28 Oct 2026 23:31:24 +0800
X-Gm-Features: AclHuK8PkpktUmhP09tfw9w0U0d0kSDJPluECqdPibL4nEqwoy4aGFpA88sGgwQ
Message-ID: <CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com>
Subject: [BUG] tcp: cross-family IPv4 option echo stack overwrite
To: netdev@vger.kernel.org, edumazet@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, dsahern@kernel.org, idosch@nvidia.com, brauner@kernel.org, 
	dhowells@redhat.com, security@kernel.org
Cc: lyutoon@gmail.com, tpluszz77@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Linux Kernel Developers and Maintainers,

We found a TCP address-family mismatch that lets an IPv6 packet reach an IPv4
reply path. The IPv4 path interprets IPv6 skb control-block fields as IPv4
options and copies a packet-controlled length into a 40-byte stack buffer. We
used it as the write primitive in a demonstrated unprivileged uid-to-root
chain.

The complete path is present in v7.3
(c03c1a14507dfaf8b856c2608f9ac216021fc222), where we reproduced the
privilege escalation with KASLR, STACKPROTECTOR_STRONG, PTI and IBT enabled.
It is also present by inspection in v6.12.95. CONFIG_IPV6 is required.

Current mainline d135ab453a7400a34930bdda1ef4bdc8acfac80e contains
8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash and
lhash2."), which rejects the exact socket transition used by our reproducer.
We therefore do not claim that the complete chain works at that mainline
revision. The unsafe cross-family option handling and unbounded option echo
remain relevant to maintained trees without that transition restriction.

Root cause:

tcp_v6_connect() changes icsk_af_ops and sk_backlog_rcv to the mapped-IPv4
implementations after a successful v4-mapped connect. On affected kernels,
connect(AF_UNSPEC) returns the socket to TCP_CLOSE without restoring those
pointers, and listen() reuses it. A pure-IPv6 accepted child can consequently
have IPv6 lookup state but tcp_v4_do_rcv as its backlog callback.

For an [IPv6][DSTOPTS][TCP] packet, tcp_v6_fill_cb() stores inet6_skb_parm in
TCP_SKB_CB(skb)->header.h6. If the packet is drained through tcp_v4_do_rcv(),
tcp_v4_send_reset() passes the same union bytes as header.h4.opt. The aliased
metadata directs __ip_options_echo() to read a packet-controlled option length
and copy it into the 40-byte dopt->__data buffer. Our trigger produces a
254-byte overwrite across the canary and return address in
ip_send_unicast_reply().

The receiving process runs as uid 65534 without capabilities or a user
namespace. A root helper is used only to inject the crafted IPv6 packet with
a raw socket inside our single-VM test; the packet may instead arrive from an
IPv6 peer.

This is the memory-corruption half of the demonstrated privilege-escalation
chain. A separately reported watch_queue disclosure supplies the same task's
stack canary and KASLR slide. We will reply with that report's Message-ID as
soon as it has been posted.

Reproduction and fix:

We have a source reproducer, exact config, QEMU instructions and a full-chain
exploit. In accordance with the kernel policy, we are not posting them publicly.
We can provide the source-only reproducer privately if a maintainer requests it.

Our build- and QEMU-tested fix has two layers: the IPv4 TCP reset and ACK paths
only pass IPv4 option state for ETH_P_IP skbs, and __ip_options_echo() validates
each option against the declared source area, the actual skb header area and
the remaining destination space. We will post it separately as a mergeable
[PATCH net] email and link that thread here.

AI-agent tooling assisted in identifying and analyzing the issue, developing
the reproducer, and preparing the initial fix. The reporters reviewed the
affected paths and reproduced the issue and the fixed result in QEMU.

Reported-by: Tong Liu <lyutoon@gmail.com>
Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>

Best regards,
Zhiyu Zhang
