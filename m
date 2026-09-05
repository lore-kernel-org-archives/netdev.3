Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218FB4A0143
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613166; cv=pass; b=ZB3gCDzsWkis1kApunbitgZphmD+siPST+gDue3TMGiYEKmyQlqGpK7yXUEgTLFO54ejCMRonoHkEUl1GbYSpcse95vSZ/x4gharR2oXhmlol7rOlzQU0VXgiHG6v6571L6H5a90dmIAItbOxhcvOuYVH+mhTbLwH/iUE0IkMik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613166; c=relaxed/simple;
	bh=zbIynxtSjPkL2GHJWmM225F3hRK13eneGatkQjrpkgo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dPK/I4In+FnOuTHXj6AqvELFhc+fSKOZCVy8amm88C6pTqp1S3oMsAyB4XufdbTXm6/t95UUJAvpnjYBv2W12ajAZzPA/oEgFnKS2OTIBxGJxFNfi23/OKruUC69pDbCiIi+4sPZHbkxi4wsOjB1pbTI7nLiX3pWH4X3gTBuONk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwhpDqj2; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwhpDqj2"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6b1b1d128a0so1790501eaf.0
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 05:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788613164; cv=none;
        d=google.com; s=arc-20260327;
        b=gzI5VDGcn0TyqVLY7XHevGOWRtfd5cjYXKRAOloebBU4L5E4TgaRctaW3ablsrDhC6
         lRVDGV5nq7BPVsGY8vxz2qIsueXKc5sQocFHQsgWvQ/6n2L6Q5sBi46VclZX+hyaYQJj
         htj+QF5jcobVmY868yFqEdLIU+IW6AaHaOh3WVS4gMyiODKCMKAwGSo1vLHi+vQOSYYe
         FKdXo9+UfOSH/7M8PZPe2Xd4weQMhHNUTnUqoRPpHjJ7p/M2RW/osq2e1fPj+xQ7zeEI
         zQBZ4GggUhT6MMuYRRzDDNtwAj9bvOSbeiA1zt1LBqHtw0sMLYblYx2egkJ2A/6Cu111
         gTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=niXvze0QrvqgbNLg9IvkY4c2pZiNeFe774xVlJIeGng=;
        fh=U+4a7sg/TWuL4BVEFfO6SUlDKzsa+b9UhsFeBUNGmSg=;
        b=CCLjHN86CwPtfuBGKqz7G4eDpuWzx5uOk/Mt+Yw620nCFtoBJdDRH9HQ4l5n/0nTLP
         TzDhJwcT/4bGYa+7OFnc2LP+IGnkhM9biB+LhJ/F0xc7Y9DW0PvQIt7fh/rDafiqjB3U
         vHHOPtjW4wZIOxKHwgsQhegrSXux4p9HQgVHPhV7VvITGf+u4h4ciC+KOKTBnv5YZGHs
         ttICDUVCntfPXEZYc79Y0spmF7jkAal19Ecv9If5BpHPTgeyZWZM8jm8X+w61y0NyfZj
         6gncHwSye5P/FbCumw3H6SxSSMkaOUlD5Uq985NKzbTezW1DQYBcAiIzrf1t+Z1yyrYO
         7/OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788613164; x=1789217964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=niXvze0QrvqgbNLg9IvkY4c2pZiNeFe774xVlJIeGng=;
        b=rwhpDqj23V1/1C9L1ZjO6yNaRLr5LL/Q9fXTHAO2ScKP90k06O6wrcaZf5QekExRDu
         IEKGoZ6brLHX5Q1bXrLhqTPiEvbkPd863ga32f//RCKfRsX94egF8K114ZkPrsgvfrDQ
         sk9xdc1nfcCgtNcsp6mqhaNpBS4GKQObmIzSda6faKgz1q1s+szMNVP/jBIhCV3xO9H2
         kDry2TLih26qQQFxcErDlUJ4IZxCWFNcTN61w1wOjnO9swh+7k+yhp/3QhSISEkjY+K3
         ZQELFTOsx0Yz/AWQwZzy0WeIG0fe1tvjt+zN0OVp+YUth8lJHpoO0cUJtConof5svvKT
         ydhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788613164; x=1789217964;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=niXvze0QrvqgbNLg9IvkY4c2pZiNeFe774xVlJIeGng=;
        b=A9rUZcsZst1SkO77xCB8Mivn+0pzB0MG5pY/1BkBzQkbEqJI5ZHdIdK3aL874QcbbC
         3qIpSYx/UwNJXOYtGNr9gt97buuJ0eOgx8I7p/8KoT/dke9YhU9Puvpjox4T3XOCVEgc
         juzg+Fqft1/h03mSAJiCgEPxpXrlST+ydLZHq1LZlT+kiuFREm3jo62Nnt6TUOCKl3Bi
         ezeJV41QJV4jtjxI2BsnfFvYDqp1aXrieiloer1ldVdCMU+1bPqIE828kR5pnV00dz+A
         SPT2jDmwfHSi1akqeTCzcEYxaV5g/7e8MzgmydE7RznbvxTCBRYKWuoNtc+ji8bnPKxb
         msOA==
X-Gm-Message-State: AFuF++kAVdz7nmXQqI9mRvWWYmK+P2ni7ew401nIWl2HDyhO9noT+mmm
	OwiDBzGGBSBfhg9kFzkJkHlU7wyF5MkLJbviWWhbg6QxPH1gJS2SeI7w/ANEgFPe6g5GpncYCoX
	rrCVodygJpyk7eM75ZzAc9AgXUwmzs45H5K2Ikl4=
X-Gm-Gg: AYBFou3en/5nI3y6dSjQm7bFbOJY/kNJ1ZZYNbHZ+XeYP4YMiUQyJcYIoPX7Cp8vpSm
	KE0qqou1ZNhMF50KElBDfX0hfRnUxVIRlhE87A5Dc7gDbY8Yn8IO+RQKJsQmTEsokE4zMBtuHL/
	rERMx9TGM+Fc7UU4wIKVKVoMVEvussiFZGN8IzYBUOZ/Sa4QjNyA2mXyfQzKUBlGPL8PqaH3YdK
	i8Nrf3oP74CfBQgiyRXsi6EkHc5yHjIJ/S5UYmf12OzKFTqNUtUXFt7V78ojJf2sOtoKx61DGpo
	GIGzuPbpdpfEeK5w6fS3Mq7DIeJPV8s1DlbUOiCFQZhYeZc=
X-Received: by 2002:a05:6820:151f:b0:6b5:ec2f:356f with SMTP id
 006d021491bc7-6b5ec2f36b4mr6258270eaf.32.1788613163805; Sat, 05 Sep 2026
 05:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stefano Sasso <stesasso@gmail.com>
Date: Sat, 5 Sep 2026 14:59:13 +0200
X-Gm-Features: AcwNN1VeofIOL7o9wHomTA-WF0fasiZwcFrIl8Q8inatylGEOABj-dxxF7A5Aak
Message-ID: <CALtE316UtL3x7LL6uxfXzx8rW6AbzYPeDOb478hqJCr_-dj=Wg@mail.gmail.com>
Subject: [BUG] vrf: attaching a packet tap to a VRF device corrupts skb->csum
 for packets from L3 ingress devices (Udp6InCsumErrors, packets dropped)
To: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Up front, so you know what you are dealing with: **I am not a kernel
programmer =E2=80=94 I am a networking guy.** Please bear with me if I get =
the
terminology or the conventions wrong, and feel free to tell me bluntly if t=
his
is not the right place or the right format. I also used an AI assistant to =
help
me navigate the kernel sources and narrow this down, so please treat my sou=
rce
analysis below as a hypothesis rather than as an authoritative statement.

What I do have is a **small, deterministic, self-contained reproducer** tha=
t
triggers the problem 100% of the time on a stock kernel, plus a control tes=
t
that isolates the trigger condition. Those parts I am confident about, beca=
use I
ran them.

## Summary

Attaching a packet tap (tcpdump/dumpcap, i.e. anything that populates
`vrf_dev->ptype_all`) to a VRF device causes incoming UDP datagrams to be
dropped with `Udp6InCsumErrors`, when:

- the packet arrives on an ingress device with no `header_ops`
  (ARPHRD_NONE: tun, ip6tnl, gre, wireguard...) that is enslaved to
that VRF, and
- the skb is in `CHECKSUM_COMPLETE` state by the time it reaches
  `vrf_ip6_rcv()` (in my case because conntrack software-verified the check=
sum
  in PREROUTING).

Stop the capture and the packets are delivered again. Start it and they are
dropped again. Capturing on the enslaved ingress device instead of on the V=
RF
device is harmless.

IPv4 should be affected identically, since `vrf_ip_rcv()` uses the same hel=
per.
I only tested IPv6.

## Real-world impact

I hit this in production: a SIP proxy bound into a VRF stopped receiving la=
rge
(fragmented) REGISTER messages over IPv6/UDP, but only while we were runnin=
g a
packet capture on the VRF device to debug an unrelated issue. The capture w=
e
took to diagnose the problem was the cause of the problem.

In the capture, the reassembled datagram as seen on the VRF device has
**source MAC =3D=3D destination MAC =3D=3D the VRF device MAC**, which is w=
hat put me
on the trail of `vrf_prepare_mac_header()`.

## Suspected cause

`drivers/net/vrf.c`, `vrf_prepare_mac_header()`:

```c
__skb_push(skb, ETH_HLEN);
eth =3D (struct ethhdr *)skb->data;

skb_reset_mac_header(skb);
skb_reset_mac_len(skb);

ether_addr_copy(eth->h_dest, vrf_dev->dev_addr);
ether_addr_copy(eth->h_source, vrf_dev->dev_addr);
eth->h_proto =3D htons(proto);

skb->protocol =3D eth->h_proto;
skb->pkt_type =3D PACKET_HOST;

skb_postpush_rcsum(skb, skb->data, ETH_HLEN);

skb_pull_inline(skb, ETH_HLEN);
```

The synthetic 14-byte Ethernet header is folded into `skb->csum` by
`skb_postpush_rcsum()`, then removed from the packet by `skb_pull_inline()`=
 =E2=80=94
but there is no matching `skb_postpull_rcsum()`. For a `CHECKSUM_COMPLETE` =
skb,
`skb->csum` is left permanently off by `csum_partial(fake_eth, ETH_HLEN)`, =
and
`udpv6_rcv()` subsequently rejects the datagram.

This code is only reached from `vrf_ip6_rcv()` / `vrf_ip_rcv()` inside

```c
if (!list_empty(&vrf_dev->ptype_all)) {
```

which is exactly why the behaviour depends on whether a sniffer is attached=
.

`vrf_add_mac_header_if_unset()` short-circuits when the ingress device has =
a
real link layer (`dev_has_header(orig_dev)`), so a veth-enslaved port never
shows the problem =E2=80=94 only L3 devices such as tun do.

Naively, the fix looks like it should be to make the accounting symmetric:
either drop the `skb_postpush_rcsum()` call, since the push/pull pair leave=
s the
packet unchanged, or add the matching `skb_postpull_rcsum()` before
`skb_pull_inline()`. I do not feel qualified to say which is correct, or wh=
ether
there are other callers/paths that rely on the current behaviour, so I am n=
ot
sending a patch.

## Why the packet is already reassembled when the VRF taps it

`l3mdev_ip6_rcv()` is called from `ip6_rcv_finish()`, i.e. after
`NF_INET_PRE_ROUTING`, so `nf_defrag_ipv6` (PREROUTING, prio -400) has alre=
ady
reassembled the fragments. That is why the ingress device shows two fragmen=
ts
while the VRF device shows one full datagram.

## Why the skb is CHECKSUM_COMPLETE

A tun device hands the stack a `CHECKSUM_NONE` skb, for which
`skb_postpush_rcsum()` is a no-op. In my setup the promotion is done by
conntrack: `nf_conntrack_udp_packet()` -> `nf_checksum()` -> `nf_ip6_checks=
um()`
-> `__skb_checksum_complete()`, which sets `CHECKSUM_COMPLETE` and stores
`skb->csum`. This also runs at PREROUTING, before the VRF rx handler, and o=
nly
when `net.netfilter.nf_conntrack_checksum=3D1` (the default).

Test 4 of the reproducer sets `net.netfilter.nf_conntrack_checksum=3D0` and=
 the
problem disappears while the capture stays attached =E2=80=94 which I belie=
ve confirms
that the corruption is in `skb->csum` and not in the packet data.

## Reproducer

Tested on `6.12.0-211.49.1.el10_2.x86_64` (Red Hat Enterprise Linux 10). It
needs root, `iproute2`, `nftables`, `tcpdump` and python3. No external netw=
ork,
no second host =E2=80=94 everything happens in one network namespace.

Topology:

```
[netns kbug]
  vrf0                 (table 100)
    =E2=94=94=E2=94=80=E2=94=80 tun0           IFF_TUN, ARPHRD_NONE, 2001:d=
b8:2::1/64
```

`inject.py` opens `/dev/net/tun`, attaches to `tun0`, and writes two hand-b=
uilt
IPv6 fragments of a single 1640-byte UDP datagram (correct UDP checksum) in=
to
the fd. `receiver.py` is a UDP socket bound to `[2001:db8:2::1]:5060` with
`SO_BINDTODEVICE=3Dvrf0`.

An nftables `ct state` rule in PREROUTING activates `nf_defrag_ipv6` and
conntrack:

```
add table inet ctstate
add chain inet ctstate prerouting { type filter hook prerouting
priority -150; policy accept; }
add rule inet ctstate prerouting ct state new,established,related,invalid a=
ccept
```

Results:

```
=3D=3D Test 1 =E2=80=94 no tap                                  PASS =E2=80=
=94 delivered
(Udp6InCsumErrors +0)
=3D=3D Test 2 =E2=80=94 tcpdump on vrf0                         FAIL =E2=80=
=94 dropped
(Udp6InCsumErrors +1)
=3D=3D Test 3 =E2=80=94 tcpdump on tun0 (ingress)               PASS =E2=80=
=94 delivered
(Udp6InCsumErrors +0)
=3D=3D Test 4 =E2=80=94 tcpdump on vrf0, nf_conntrack_checksum=3D0 PASS =E2=
=80=94 delivered
(Udp6InCsumErrors +0)
```

The full set of scripts (`setup.sh`, `inject.py`, `receiver.py`,
`reproduce.sh`, `teardown.sh`) is available here:

  https://gist.github.com/ssasso/c089227b116b0fa6a954a18d85639d67

They are short and have no dependencies beyond the above. I can inline them=
 in a
follow-up mail if you prefer not to follow links.

## Workarounds I am using meanwhile

- Capture on the enslaved interface instead of on the VRF device.
- `sysctl -w net.netfilter.nf_conntrack_checksum=3D0` in the affected netns=
.

Happy to run any test, apply any debug patch, or collect any additional dat=
a you
need =E2=80=94 just tell me exactly what to run.

Thanks for your time,
Stefano
