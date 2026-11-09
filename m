Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239355;
	b=u15j7FQHR1J303Le1BI5VodI2Le+UZiStxwaqbfGGarieGod3jx+9CwSsr6sn1ZMy0yU
	 Gnebv1C3MW/hDxVDZ4Mjm/tjTrJrgjfOEXfi6C1QhG2Sjeg+WGJy3lfFTuzw/jjpNU3Mu
	 MxvJV2kY3Tbc1MLnlTzH1+k1Y3r20SfSC8MrmgbNa0tRzIXoKjJ3L43LYW5nV4tpscsSd
	 /N3jXgXk9WTNCEURN9LN1rZ1Cakd+SJZIit+DkGmI9WhhkoN+6/i4KAkr0zPWmO00+4aH
	 q2YvqnAbY4T8Es/Bn4gOSSQdArzMqic1A2uqxSDTQrrhxoF/NYRaV244T/3G29AWqJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YbLfW9U7bURTW7WWyEUs2jKzerBMtTsg+xvyertb1hc=;
	b=cmTJ6nWBrOkWVRFNG2iEeqNDz3x6SItbx46H3YH8RI3s5xy5iTxw8TpAZGW3CswfvAxn
	 UBhMV0wxq+8asy7ddMIWgS8SuMXhz1TbEH46y75foxa9L0Lt+y2J6fGk20FUroGFXMiqX
	 uDafmHZDeOTTvVr5nKjIX4TQQVlGL0CNfdlNA0lcUpMBTgbjxZ6A6UuYJjt9zNF1IdDOC
	 EU1f1aEj1r6VXHdzmySSHaIhOOk+Yok7mGLbtKKI/KhkVc8xM84R12fmmMKFSJdlIAQZ4
	 iRPHHltu5fzIVlIuH2FKfFlaUNPnOr6lu45h/AOouF26l8EztwfnyfQvZSzbYEuxD5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NgmDxAS1;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD9606A330
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 15:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDAD9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NgmDxAS1
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c247f6687dcso176756866b.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 07:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794239353; x=1794844153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YbLfW9U7bURTW7WWyEUs2jKzerBMtTsg+xvyertb1hc=;
        b=NgmDxAS1XReNTi/U/iDSh8mgdE/VoqW1kZ2zrt2gbEsPCn3AoOaYrbgL9tBQAZLMEg
         sV1TIQgRXFgzd1XPkVoMNWMz8rwtJgsCUJvrGIXSjJEsh2kAkWJWNGOMqn56aoS4OmA8
         lpwqWCOhQBlb9P7N5tlRhT4FVaxsJECMGhHakqy/9NLArjfFFim4/6V3tlgq5sWA5cwL
         xIK6pjqBvc+iI/Fxmm2zbJb8gixcmt4FLLxfXebAgJBtVqdpAQYe9yFNrmVh/GaOD0mh
         mXtE4u5A8ZUk9XtmUFwyDlF2ztOVWC3Id4wBEKb7x8CsvaLz3kNnOz5wMXICrpr/rXZk
         tahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239353; x=1794844153;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YbLfW9U7bURTW7WWyEUs2jKzerBMtTsg+xvyertb1hc=;
        b=PtiGXFfI/q/v6MpGDBUokIk5oGBJQRX4tmRlsO1YGWgtVG5RhhthDRmwte5nCMpSeE
         Dwryou2O5TzrBxUY/cmw9N9ldBw8OsYVspHjuB6b65/GilieLcr/T8oGr9NM/1UKegS4
         FHSQC32pOqZNWbSlhv5RlgJ08KTHjWyPDmMzn43fMoouHNJppvWIK2mXHdRKyZYyfnRq
         2PR8yZ/HKn71S/FTcRX7a4At29YQ1HLVlNr13KByAlL04C730lIwGgi7wASTclhKgs4b
         /gGr3HSbJjLVKol4puYYlsClBlJW+TuOuNQMP/0VsvNtOckT1u0rWiQyWtyE/j59tfi9
         ChxQ==
X-Forwarded-Encrypted: i=1; AL+hErFzrrYjOtfpUDmYETqEaCV3GziXDHyiwaPJZLHYWWf75tZ1nUvC6V77TK0o+nuMwU2+7LHB6JA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gszRew/nn0jZQyc3LKU2kVLaZizAMN3GSV3F9nio3+thqY6lX
	aWn68kvFJ8GbHf6n07KmMrkUoYcJbVfeWR1vbnagrWSTjOoveTtz4OGpfN9V55jPBR7bENZ9L4R
	r7MOzYJE=
X-Gm-Gg: AYBFou388nUEyJ7GzXlgfYFDi99gPsGJcCvWTQr6yvQDRumTvthQXChZh9yKxKPD9Cb
	ssOrRf8+WporFEXp7d3M41cCU3uQt8EZG00eB6eRHtp5gmePqmaxDQ2hHpq9ZSyriujYxUCj/9N
	owiFDjVZAmkHXD3IBZLOsXp1g9Hv7p6om0sPcO9y5hrv3fc59EqNtZ5KTSHepylGG4VYzmjhVmf
	ooIBqs/1QCmydBqpKxlBn8pIhcymba3u+srXUL8T8N/6kb72qLS6THOJ51mKiSITZV9AntpCnJt
	td1+KPpq2y+LdL2PndTFKTknczqfcZ3DHp5horC0Ck0mKYWPBxjSD6M6QeJ19ZM3XrI/qBEp7S8
	XB1g1NQMRjBp1S78xMtvOmg47dJ505FwV8jR4vK1CY2ROgkg9mRw0WQJtBxXjQgMKGh2QlACa4A
	wEkgpGR8a0WUg9X1oGeR0W5W+KIYgg++b4fCbBqwPQlHVa5zZLrCFh/2xwmXSYRUMBps72QenzD
	IsIl/LWLrQgt01SPdvezsE80ny0TTVosn1xJzezeJPRUgpzrqJqymZ9lJ2der7HODRIOgLw1BiJ
	PLWapMQCBNqVnsQOCqyLLY2pWA2e7epfW8uGSctQX1vD/ao=
X-Received: by 2002:a17:907:e8e:b0:c2e:8eb7:53dd with SMTP id a640c23a62f3a-c4d6d82594cmr350173866b.42.1794239353250;
        Mon, 09 Nov 2026 07:49:13 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a9990besm179938866b.70.2026.11.09.07.49.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 07:49:12 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Keogh <dkeogh@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>,
	Danielle Ratson <danieller@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	nh-open-source@amazon.com
Subject: Re: [PATCH net-next 1/8] net: add tx_extra_headroom and LL_ALLOC_SPACE()
Date: Mon,  9 Nov 2026 15:49:09 +0000
Message-ID: <20261109154909.32748-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108190831.3f991a13@phoenix.local>
References: <cover.1794020868.git.tianyi@cloudflare.com> <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com> <willemdebruijn.kernel.1d64e7848503b@gmail.com> <20261107182526.69543-1-tianyi@cloudflare.com> <willemdebruijn.kernel.2c6a653eb65fa@gmail.com> <20261108190831.3f991a13@phoenix.local>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hi Stephen,

Thanks for the invaluable and detailed review.

On Sun, 8 Nov 2026 19:08:31 -0800, Stephen Hemminger wrote:
> Since the motivating case is XDP, the mechanism should let the XDP program
> ask for the padding it needs, rather than making the operator translate
> the program's requirement into a device setting by hand.

The series started from David Keogh's TC egress case, as described in
the RFC [1] and in the first paragraph of the v1 cover letter. The veth
XDP case came later, when I found that the same field also avoids the
copy for generic XDP on veth.

> Your own reply already works this out:
>
> > - XDP on a veth peer: veth_xdp_set() and generic_xdp_install() can
> >   increase the headroom of the peer to XDP_PACKET_HEADROOM on attach
> >   and reset it on detach.
>
> That is the mechanism, and it needs no uapi, no operator arithmetic, and
> no stale state. I would rather see it implemented for the cases it covers
> than add a permanent uapi that removes the incentive to do so.

Agreed. For this case, I plan to move to this in v2. When an XDP program
is attached to a veth device, tx_extra_headroom of the peer is set to
XDP_PACKET_HEADROOM.

> On the argument that program-side declaration is itself new uapi, and that
> the labeled device is often not the device the skb was allocated on:
> granted for the general TC egress case.

For TC egress, the kernel does not know at attach time how many bytes
the program pushes. Only the program, or the software that loads it,
knows. Attach-time propagation works for XDP because XDP_PACKET_HEADROOM
is a fixed value.

Since we both agree that auto-tuning has real problems, a narrow UAPI,
such as a BPF-side declaration, seems unavoidable for TC egress. The
program declares the headroom that it needs through this UAPI. The
initial plan is a BTF decl_tag, as Dragos Tatulea suggested on the RFC
[2]. On attach, the kernel increases tx_extra_headroom of the device
that the program is attached to.

> Which leaves the genuinely hard case, the one you describe at Cloudflare: a
> service in a netns sends through a veth pair, the host forwards to the
> uplink, and a TC egress program there encapsulates, after ip_rcv_core()
> has orphaned the skb so the allocating device cannot be identified. If
> that is the real residue, make it the problem being solved and argue for
> the narrowest mechanism that solves it.

This case only came up after I started to look at in-kernel approaches,
because the general IFLA_TX_EXTRA_HEADROOM UAPI already solves it. It is
not a new case, and it is not uncommon. Cilium, Flannel and Calico use a
tunnel by default [3][4][5], so the device that encapsulates is not the
device that allocated the skb.

netkit already has a similar UAPI. Commit b9ed315d3c4c ("netkit: Allow
for configuring needed_{head,tail}room") [6] by Daniel Borkmann added
IFLA_NETKIT_HEADROOM for Cilium in VXLAN or Geneve tunneling mode. As
you point out, the value can go stale. But the CNI plugin sets it when
it creates the device, as Cilium does for netkit.

As far as I can see, a narrow UAPI, such as a veth attribute
VETH_INFO_TX_EXTRA_HEADROOM, is unavoidable for this case.

> As posted, the series leads with
> cases that in-kernel propagation handles and uses them to justify an
> interface sized for the case it does not.

Based on what I have learned from both of you, this is my plan for v2:

- Drop IFLA_TX_EXTRA_HEADROOM.
- Keep 1/8 and 2/8, i.e. tx_extra_headroom, as an in-kernel field. It is
  needed to avoid a perf regression if we just use needed_headroom. It
  is needed in all three cases below.
- veth XDP: set on attach as described above.
- TC egress on the device that allocates the skb: the BTF decl_tag UAPI
  described above.
- Cross-device encapsulation: the veth attribute
  VETH_INFO_TX_EXTRA_HEADROOM UAPI described above. I will rework the
  existing iproute2 series [7] to set this attribute, and post it
  together with v2.

This would introduce two narrow UAPIs instead of one generic UAPI.
Please let me know if everyone is happy with this new plan. If there are
no objections, I will proceed with v2 following this plan. I am happy to
change it if there is a better solution for these cases.

To David Keogh: this plan drops the generic device attribute UAPI that
your RFC proposed. Your TC egress use case stays in v2, with a BPF-side
declaration instead of the device attribute. Before I proceed, please
let me know if you are unhappy with this plan.

Thanks,
Tianyi

[1] https://lore.kernel.org/all/20261015235335.4162993-1-dkeogh@amazon.com/
[2] https://lore.kernel.org/all/bba453eb-769e-458b-88f7-8cc9bcafc1db@nvidia.com/
[3] Cilium, veth with VXLAN by default:
    https://github.com/cilium/cilium/blob/main/pkg/defaults/defaults.go
[4] Flannel, VXLAN by default:
    https://github.com/flannel-io/flannel/blob/master/Documentation/kube-flannel.yml
[5] Calico, IPIP by default:
    https://github.com/projectcalico/calico/blob/master/manifests/calico.yaml
[6] https://git.kernel.org/torvalds/c/b9ed315d3c4c
[7] https://lore.kernel.org/all/cover.1794022936.git.tianyi@cloudflare.com/
