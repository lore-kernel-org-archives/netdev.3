Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC9D4D7D27;
	Mon, 21 Sep 2026 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008942; cv=none; b=EPJ1kkZ1eTJvry7lYlPWqpzsKYJZuy4quuHaC36YTla9aQjvWLJ15Vil/f1QYRUBybCeOM5ghrwc2ZtBD00kESPpCjC1Q1h6M05hn+AqfWtsMr4HPdIcYnW9uXfynGHovQ+MfcdK800F1EiGgGQSrRrVw0sPp3LvUA13d0L++ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008942; c=relaxed/simple;
	bh=uVZz+TTHzglzPNRgCg8mpE8UJ48NaB06ENT/SXoFf0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJGnO/Ufx0O9zMfJ6v+V1cF9n7yRXIR3szIWDx0iGuaKQZSMFQ1SS7b/1kU+f6p5nFnJBqzOWhYrkpPCQxnbxh+L2gGWPOJsGhps+q3owm13GULtBWtDJ5iUzR96tHReGhJFBekrbApMLQsoPdCnKnDyOXvz5UulXs2olwtHbMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVbBK5XW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVbBK5XW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866611F000FF;
	Mon, 21 Sep 2026 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790008940;
	bh=xWPKJ6QSoaCyzdwpAAjhiYfi59Uk0r3ZAok41oWiLVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iVbBK5XWFuheeDEXugDa9FKJ0h90AXHXBTpMQXTtT0iDnteXeulF3cw3YJSUbqOS/
	 T0TzE6JEUpIzu9VrNU2H7MOPfBtkfe7RT/gWHR6kmPI80TfuGYxpCWD5snSD+G0qxc
	 D473i72TiJrps0P2GNwVAo3WdaoCM83a48sFS0b3OlZdcMBz2Wg+fM5mI3vW3iH2gn
	 wFvlvAXCHa7GkknBqt8iU1Yt5i7QgoXyEf9Nfud1FsbE3+o+UI8qKnJJQ+Ya6gedRS
	 lJzSIGDzh4+GE+PYWTG03M7HqfH3bnLJoal+zZrl5Yo24svHDYLvaKQN7KZx7AE7qU
	 viSqabbqx414Q==
Message-ID: <aac68697-e29f-44ae-8d57-f526ced901c4@kernel.org>
Date: Mon, 21 Sep 2026 10:42:19 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] vrf: attaching a packet tap to a VRF device corrupts
 skb->csum for packets from L3 ingress devices (Udp6InCsumErrors, packets
 dropped)
Content-Language: en-US
To: Stefano Sasso <stesasso@gmail.com>, netdev@vger.kernel.org,
 Andrea Mayer <andrea.mayer@uniroma2.it>, Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <CALtE316UtL3x7LL6uxfXzx8rW6AbzYPeDOb478hqJCr_-dj=Wg@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CALtE316UtL3x7LL6uxfXzx8rW6AbzYPeDOb478hqJCr_-dj=Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adding Andrea who modified the suspected code at fault, and Ido.

I do not have time to look into this problem for at least the next 2
weeks. Maybe one of them can look into it.


On 9/5/26 6:59 AM, Stefano Sasso wrote:
> Hi all,
> 
> Up front, so you know what you are dealing with: **I am not a kernel
> programmer — I am a networking guy.** Please bear with me if I get the
> terminology or the conventions wrong, and feel free to tell me bluntly if this
> is not the right place or the right format. I also used an AI assistant to help
> me navigate the kernel sources and narrow this down, so please treat my source
> analysis below as a hypothesis rather than as an authoritative statement.
> 
> What I do have is a **small, deterministic, self-contained reproducer** that
> triggers the problem 100% of the time on a stock kernel, plus a control test
> that isolates the trigger condition. Those parts I am confident about, because I
> ran them.
> 
> ## Summary
> 
> Attaching a packet tap (tcpdump/dumpcap, i.e. anything that populates
> `vrf_dev->ptype_all`) to a VRF device causes incoming UDP datagrams to be
> dropped with `Udp6InCsumErrors`, when:
> 
> - the packet arrives on an ingress device with no `header_ops`
>   (ARPHRD_NONE: tun, ip6tnl, gre, wireguard...) that is enslaved to
> that VRF, and
> - the skb is in `CHECKSUM_COMPLETE` state by the time it reaches
>   `vrf_ip6_rcv()` (in my case because conntrack software-verified the checksum
>   in PREROUTING).
> 
> Stop the capture and the packets are delivered again. Start it and they are
> dropped again. Capturing on the enslaved ingress device instead of on the VRF
> device is harmless.
> 
> IPv4 should be affected identically, since `vrf_ip_rcv()` uses the same helper.
> I only tested IPv6.
> 
> ## Real-world impact
> 
> I hit this in production: a SIP proxy bound into a VRF stopped receiving large
> (fragmented) REGISTER messages over IPv6/UDP, but only while we were running a
> packet capture on the VRF device to debug an unrelated issue. The capture we
> took to diagnose the problem was the cause of the problem.
> 
> In the capture, the reassembled datagram as seen on the VRF device has
> **source MAC == destination MAC == the VRF device MAC**, which is what put me
> on the trail of `vrf_prepare_mac_header()`.
> 
> ## Suspected cause
> 
> `drivers/net/vrf.c`, `vrf_prepare_mac_header()`:
> 
> ```c
> __skb_push(skb, ETH_HLEN);
> eth = (struct ethhdr *)skb->data;
> 
> skb_reset_mac_header(skb);
> skb_reset_mac_len(skb);
> 
> ether_addr_copy(eth->h_dest, vrf_dev->dev_addr);
> ether_addr_copy(eth->h_source, vrf_dev->dev_addr);
> eth->h_proto = htons(proto);
> 
> skb->protocol = eth->h_proto;
> skb->pkt_type = PACKET_HOST;
> 
> skb_postpush_rcsum(skb, skb->data, ETH_HLEN);
> 
> skb_pull_inline(skb, ETH_HLEN);
> ```
> 
> The synthetic 14-byte Ethernet header is folded into `skb->csum` by
> `skb_postpush_rcsum()`, then removed from the packet by `skb_pull_inline()` —
> but there is no matching `skb_postpull_rcsum()`. For a `CHECKSUM_COMPLETE` skb,
> `skb->csum` is left permanently off by `csum_partial(fake_eth, ETH_HLEN)`, and
> `udpv6_rcv()` subsequently rejects the datagram.
> 
> This code is only reached from `vrf_ip6_rcv()` / `vrf_ip_rcv()` inside
> 
> ```c
> if (!list_empty(&vrf_dev->ptype_all)) {
> ```
> 
> which is exactly why the behaviour depends on whether a sniffer is attached.
> 
> `vrf_add_mac_header_if_unset()` short-circuits when the ingress device has a
> real link layer (`dev_has_header(orig_dev)`), so a veth-enslaved port never
> shows the problem — only L3 devices such as tun do.
> 
> Naively, the fix looks like it should be to make the accounting symmetric:
> either drop the `skb_postpush_rcsum()` call, since the push/pull pair leaves the
> packet unchanged, or add the matching `skb_postpull_rcsum()` before
> `skb_pull_inline()`. I do not feel qualified to say which is correct, or whether
> there are other callers/paths that rely on the current behaviour, so I am not
> sending a patch.
> 
> ## Why the packet is already reassembled when the VRF taps it
> 
> `l3mdev_ip6_rcv()` is called from `ip6_rcv_finish()`, i.e. after
> `NF_INET_PRE_ROUTING`, so `nf_defrag_ipv6` (PREROUTING, prio -400) has already
> reassembled the fragments. That is why the ingress device shows two fragments
> while the VRF device shows one full datagram.
> 
> ## Why the skb is CHECKSUM_COMPLETE
> 
> A tun device hands the stack a `CHECKSUM_NONE` skb, for which
> `skb_postpush_rcsum()` is a no-op. In my setup the promotion is done by
> conntrack: `nf_conntrack_udp_packet()` -> `nf_checksum()` -> `nf_ip6_checksum()`
> -> `__skb_checksum_complete()`, which sets `CHECKSUM_COMPLETE` and stores
> `skb->csum`. This also runs at PREROUTING, before the VRF rx handler, and only
> when `net.netfilter.nf_conntrack_checksum=1` (the default).
> 
> Test 4 of the reproducer sets `net.netfilter.nf_conntrack_checksum=0` and the
> problem disappears while the capture stays attached — which I believe confirms
> that the corruption is in `skb->csum` and not in the packet data.
> 
> ## Reproducer
> 
> Tested on `6.12.0-211.49.1.el10_2.x86_64` (Red Hat Enterprise Linux 10). It
> needs root, `iproute2`, `nftables`, `tcpdump` and python3. No external network,
> no second host — everything happens in one network namespace.
> 
> Topology:
> 
> ```
> [netns kbug]
>   vrf0                 (table 100)
>     └── tun0           IFF_TUN, ARPHRD_NONE, 2001:db8:2::1/64
> ```
> 
> `inject.py` opens `/dev/net/tun`, attaches to `tun0`, and writes two hand-built
> IPv6 fragments of a single 1640-byte UDP datagram (correct UDP checksum) into
> the fd. `receiver.py` is a UDP socket bound to `[2001:db8:2::1]:5060` with
> `SO_BINDTODEVICE=vrf0`.
> 
> An nftables `ct state` rule in PREROUTING activates `nf_defrag_ipv6` and
> conntrack:
> 
> ```
> add table inet ctstate
> add chain inet ctstate prerouting { type filter hook prerouting
> priority -150; policy accept; }
> add rule inet ctstate prerouting ct state new,established,related,invalid accept
> ```
> 
> Results:
> 
> ```
> == Test 1 — no tap                                  PASS — delivered
> (Udp6InCsumErrors +0)
> == Test 2 — tcpdump on vrf0                         FAIL — dropped
> (Udp6InCsumErrors +1)
> == Test 3 — tcpdump on tun0 (ingress)               PASS — delivered
> (Udp6InCsumErrors +0)
> == Test 4 — tcpdump on vrf0, nf_conntrack_checksum=0 PASS — delivered
> (Udp6InCsumErrors +0)
> ```
> 
> The full set of scripts (`setup.sh`, `inject.py`, `receiver.py`,
> `reproduce.sh`, `teardown.sh`) is available here:
> 
>   https://gist.github.com/ssasso/c089227b116b0fa6a954a18d85639d67
> 
> They are short and have no dependencies beyond the above. I can inline them in a
> follow-up mail if you prefer not to follow links.
> 
> ## Workarounds I am using meanwhile
> 
> - Capture on the enslaved interface instead of on the VRF device.
> - `sysctl -w net.netfilter.nf_conntrack_checksum=0` in the affected netns.
> 
> Happy to run any test, apply any debug patch, or collect any additional data you
> need — just tell me exactly what to run.
> 
> Thanks for your time,
> Stefano

