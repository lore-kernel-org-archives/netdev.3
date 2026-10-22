Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671371;
	b=owY+Zxs3I1XnXlaSJmvwpyX6lsBIKQaFJMbs3bqz8SR8b3gCkOHKKe0YQ5AbqZ41M0n1
	 lEWsHcCPX1+dsjfeRkf4KkL6NZaKemt1+gG8q8z642wcwqxGbDmI8H1n5M+/gzSn9i0hu
	 SxYQ3tA0YmZ+iH6mtpVyRGbVqLg35ZbgRJHz3/HchjwKJc2eA5WvzW8GkLZ7C9RMNt8QC
	 7kUU55+n98V21HFtSmpO/hn5qVTzkLSFOg88GUNYfNFtS5jmaUp8Mhe2Kv7+05nvhdMeC
	 OF0533wkN52qAO3/Zyc374LZx/3E1Y3Ul02AdmXqsC/zGkMV2iqAU5HzadRcIo0AdzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=j6uPJ6VC2ModrnPXwPHdeD89DPffzFAA7izVfws4xNk=;
	b=EZq0L87ArC2w431Kra0QIvAk2bqiDuRM2J2xIH7cIsu+UFD4DKeUohy3ZeCp1+armUst
	 Ymt0K8MQp0ya2s4oAw8ppB1vKGojzZ+IHXhmPtx8GmKR3qmlfqdoQc2CT9gPnPxEtsy08
	 xR0wlWcrOmmZvGoagDMUxXwtsqZh3lE+BHpqTyP9b6+blAdjV8dy2dRKWqQYgDFwPiLk4
	 MkrTBu0AVQs6V9iNwwmfUmN2A/s9aErVCSZPRX8CG/CaRO2vuZlrZyLEN6Ikfl5jtCaIg
	 qfmLDYLEMVqOrMAeifhKd2TTm8Gc2bh0z4RG5amYsF/kummWIQK3zinreF+DR6+5dLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=d4Qx1NxN;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00581606A326
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00581606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=d4Qx1NxN
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso3968555e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1792671369; x=1793276169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j6uPJ6VC2ModrnPXwPHdeD89DPffzFAA7izVfws4xNk=;
        b=d4Qx1NxNw7xA/iXtClX7DpbI9qfD6mZRSyMBjJYi1eMXDOspdOCskimCA+rLO3hacU
         gWJ0O7nmZJ1hFo2B+/NEzRS+OHgWRluem4GnsClrxPA35JX5VSTi++7oITklvaLYn+Qr
         rA+aLvSXCUDClbu4XVv1s1KZQgGG2ri69w41eWMOJCeqpySpG29B8IofEphpEtyQy+qs
         eej+I41jh7qn8dN7mbWzv9vUiiyvb8CtXpEK8X+e0WTq7uVFPW1QjsHx7afHtdnV8wBJ
         XHIfhx7OFNNWI331+kf+5SH/o5s2TEdGedaGSpvl9ZxUW9H/Df8GM9umKCwcD0Q1Kvt5
         DK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671369; x=1793276169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j6uPJ6VC2ModrnPXwPHdeD89DPffzFAA7izVfws4xNk=;
        b=fl4m/EOUhOSFRK4er0kdyNU/XcR8ADQ7g+Q/IJC21vVSexJy4mZFegL0CGEuxKjtf/
         hwSxpCfQOdTNbw4Z3jeumM47XULx2yT9va+mN7Xcr6iO+SoXn502QM5SMvWybZjwjYJI
         pnqmj5tkDJ11hQeoFgc7+y9T56dSHjJ4XoMmrO6S3t5iOuH0CioWUVRVPscCKSo1wnao
         6aH2auURI08B5urQ8aBQiJE3lsm7E0DhiST1T1cwGaEOAiNDpxypXag4UtBiJ7NpDp5j
         N0mdOrubG5Av1z+LWs9sGxvI0lp0wI5PzmhaxCWkJQWXpEwCc3mNZykzPccZwr7QsdT5
         qxFg==
X-Gm-Message-State: AFq9FYLzWQm/v3vGiIVDY+HVknZktIdpmugawvgGqiYBIU0x4XaPyKp2
	F1p6hHSff406ale9ivSHGaQ/aW6gzg508N2Cmy+TgYXULHMs+LLmyqbstQgosixWhF5dop3uyM+
	9iGDjL1TzdFwW613WnzGxqtoVkBlCFz9/LSOrogM9YlXhdDotjua5qxeacp4TrnWcQqU=
X-Gm-Gg: AYBFou1ef0IBMnIFr33jcmFZ4E+DruvHVKX3/AUt6FbKrhaUzSWlm5mJvLEohsnDDUL
	2AY64jHKbGCOF7nK/QDu+hUM0/yqp6bVKHKK6bdJ1QqpEGDtHxHCw/dsV7cWyGsN8TyBQR4j1I+
	xdahpDMZa7gwtXUZAmIw/j9jImqaPqE7iboUDdJkZOV7WR5csHf+Lu0ORu8MarDNagYiPT9RAOh
	soOLhezuTVbmqNQpWR2LdQnKhWmb/KXdmzYCZye1nmkQ0gYyVkNPWBnVpbkM7G3kr9deW6wbWTz
	N0v0DiGKivCaTKMkic49lX44jkcBSeMtOwk8sNJX9o6fkzJVOupQMSY7EoUj4blXPP+WjQVJTjk
	BivleNSKcNQ79xnrzkMZ3MN6dYu2rq0AqTFfqz8AvBTFgrp5MIbXH2m9kQ3nA5A5XOBHJTqK7aE
	RG3U80D2djET2m+eQIhsmrVCt84jyMzqteZmtdLnIpzA8EzEmlnbVguf65hW04vE3VFmEvzlvZq
	lsjOAzzrOipR9wWgX+gD4LsgoqZC1HpxX0VRQhkzrGbf9GDtUlcYHeO96SQCuas03w=
X-Received: by 2002:a05:600c:4713:b0:4a1:9663:7633 with SMTP id 5b1f17b1804b1-4a1fdaf738dmr106347945e9.11.1792671369303;
        Thu, 22 Oct 2026 05:16:09 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:8826:77b9:4cd:7631])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm112485135e9.3.2026.10.22.05.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:16:08 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 0/7] pull request: fixes for ovpn 2026-10-22
Date: Thu, 22 Oct 2026 14:15:43 +0200
Message-ID: <20261022121606.732029-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

First of all, this PR includes fixes for older releases.

Given Linus' statements on our recent set of fixes, I have
not understood if this kind of fixes are supposed to still go through
net or rather via net-next (so they don't land in an -rc).

As you see I am targeting net, as I always did, but feel free to let me
know if I should do otherwise.

And this is the PR cover:

Here is a batch of seven ovpn fixes for net. Six are about hardening 
how ovpn deals with the userspace-provided transport socket, plus a
selftest fix for a NULL deref crash with musl.

The most important ones close two potential crashes, both reachable by
a CAP_NET_ADMIN user configuring a peer via netlink:

* NULL pointer dereference on TX: an IPv6 remote endpoint was accepted
  on an AF_INET UDP socket. The first packet sent to such a peer goes
  through ovpn_udp6_output() and ip6_dst_lookup_flow(), which
  dereferences inet6_sk(sk), but the latter is NULL for IPv4 sockets.
  Such remotes are now rejected via netlink and the socket family is
  rechecked on TX.

* Out-of-bounds access: the transport socket type was selected by
  sk_protocol only, therefore a raw socket with IPPROTO_UDP could be
  attached and then accessed as a struct udp_sock. Only real UDP
  datagram or TCP stream sockets are now accepted.

The remaining fixes prevent sending UDP packets with source port 0
(e.g. after connect(AF_UNSPEC) on the socket), and correct the TX
accounting for both transports: UDP byte counters did not include the
OpenVPN header and auth tag, while packets dropped locally were
accounted as sent and refreshed the keepalive timer.

The last patch fixes ovpn-cli crashing on musl, because
freeaddrinfo() was being called on NULL.


Regarding Linus' email commenting our last net PR, I think
he complained that we did not CC stable on any patch.
My (long-lasting) understanding is that for patches to net
we're not supposed to do that.
Let me know if I should do otherwise.


Please pull or let me know of any issue!

Thanks a lot,
	Antonio

The following changes since commit f4377bf85887f57b59abb5479f7660a81ffe4449:

  tipc: fix broadcast sender hang on last acker departure (2026-10-22 11:05:31 +0200)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-20261022

for you to fetch changes up to a402a88c1d53ec649c57da6d947a72154f9a6de7:

  selftests: ovpn: avoid calling freeaddrinfo() on NULL (2026-10-22 14:07:59 +0200)

----------------------------------------------------------------
Included fixes:
* fix selftest tool segfault on musl caused by calling freeaddrinfo()
  on NULL
* fix TCP TX accounting, which counted packets dropped locally as sent
  and refreshed the keepalive timer for them
* fix UDP TX byte accounting, which left out the OpenVPN data channel
  header and authentication tag
* recheck the UDP socket family on TX, since userspace can still change
  it via IPV6_ADDRFORM or IPV6_V6ONLY, and tear the peer down on
  mismatch, ensuring the IPv6 TX path never sees a socket without IPv6
  state
* reject UDP remotes incompatible with the socket family, fixing a NULL
  pointer dereference on TX when an IPv6 remote is configured on an
  IPv4 UDP socket
* reject sockets that are not real UDP or TCP sockets, preventing e.g.
  a raw socket with IPPROTO_UDP from being treated as a udp_sock and
  accessed out of bounds
* avoid sending UDP packets with source port 0, and do not account
  locally dropped UDP packets as sent

----------------------------------------------------------------
Antonio Quartulli (1):
      selftests: ovpn: avoid calling freeaddrinfo() on NULL

Ralf Lici (6):
      ovpn: avoid sending UDP packets with source port 0
      ovpn: validate sockets before attaching peer transports
      ovpn: reject UDP remotes incompatible with socket family
      ovpn: recheck UDP socket family before transmit
      ovpn: fix UDP TX byte accounting
      ovpn: fix TCP TX accounting for locally dropped packets

 drivers/net/ovpn/io.c                       |   8 +-
 drivers/net/ovpn/netlink.c                  | 129 +++++++++++++++++++++-------
 drivers/net/ovpn/peer.c                     |  19 ++++
 drivers/net/ovpn/peer.h                     |   5 +-
 drivers/net/ovpn/socket.c                   |  16 ++--
 drivers/net/ovpn/tcp.c                      |  78 +++++++++--------
 drivers/net/ovpn/tcp.h                      |  10 +--
 drivers/net/ovpn/udp.c                      |  51 ++++++++---
 drivers/net/ovpn/udp.h                      |   4 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c |   3 +-
 10 files changed, 224 insertions(+), 99 deletions(-)
