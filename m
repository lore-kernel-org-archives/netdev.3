Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793155916;
	b=H5g9YSrC1wbLbyaBtsQZXdbrJUlg3ewf5jxv7lAxHOU+tacgLJrJuX0YHCJoqL+3Fr0X
	 LyG802RrKghVQG8o81TSBZQjmyHHYUqXybn22GwQLS0fuz9hZuNZuKUhz6tHTqq64a9+J
	 yX0GfFfe3nsGRtd7Ur0lE8LhlF6WYjCNBTqgQbMuK7kaNKRbVKkphxUeKNgHeZvH1+jAp
	 izO0RzOQ5DTjC1WHm3z13Uez0EhmsEm5odqHuLyLNS7Z2kuXGva4VyL/dCepes/875RNJ
	 6pzqvv55Z7IPH+2GaOqG5ZE1F0EbdlFAHSWr0tqibOnk2ZdqUMdf4+WqxxPC9GfPg/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 Received:Received:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=T5bJSIKcRblh1n/DNQPJ9kq7nzFmBPGiz7ZQXcqwIO4=;
	b=NhCAnAxiNLUWGwkFIKCYxOl21i+qFJ4MnKkcJMDn9lquHbjOA5XCJHzhIE4o84u+8mxe
	 Cke5LbQ4vXmN4Hl0S6+KUHS3bnJAuejBt0mhXSXL1hvvnDknkV4NhTh7IL3L7h5yPE5N3
	 2RqkDRRt7MqVOlIPf+ZGPdobq0IpUbNHrwCUgti1IaLHPYG7A3xqMz/F9Ruarwl2Wcg3+
	 mJ6OEA3tp7ngws3VwYvN+p/Kv8s4HkTWgKe25R5iYXu0PbjgiuYMELJqioUQmipHaiAsS
	 lUmqgWleKJ3N0qzGV9K67YYBtZb8Q4IPS2Ad1tXBjxwKDGzpNPTu+a4T4MyKZE+no7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sz5bTcKg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A3606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C3A3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sz5bTcKg
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c315869241fso72682066b.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 19:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793155914; cv=none;
        d=google.com; s=arc-20260327;
        b=gBLFC91eo5UMZ29rqz0kcspWV1QC8pH+pQeb+CyC/ymWawuGe2FhDnKvEK9qQDiRNj
         ktDotxC303So5A9tv6SPZ23J9+Tz0UXP6zKtyMit93zf8lAYYG3qdMbAGLbrtIXZl8Oa
         qhAuqU3RN8hzPSKanxLBBaJ1VEXQoT14dnvGZ98Vp5mmvVtn4dwmmTl47/X9aphisawK
         DK4fk4b73ttdsWzkxFmBDID4UYP3kPbHqY72rkzjQRJ1JdMLwOG+/wuAZR71PuhToKei
         cdOCArAgSba/d+ttD8tHPjLSQXtmhLWwRogsDPPKu30ig+q6JZWEn4b6zUmZOOsSzyXI
         iEMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=T5bJSIKcRblh1n/DNQPJ9kq7nzFmBPGiz7ZQXcqwIO4=;
        fh=fT7kxOvnpWqPLCQrbKowFS+mFxLB9Ph0paWgozJmdq4=;
        b=meH6m3qYZ24xEex+2obmpnW97yV7JJZTQCwVwEd1q5CjoesnoNXBGel+YRJwJLwOsc
         eDX0nYF2xfAp+qcTlVc/BYwByzquZvXWzjcL0WvUNkk+GrHxDvHiii7mICSGXgC0q3rr
         pZ2huI/V+0+Wr0UlGwInqd/fviby6pbigkZxc7TTm3pRYLC/7w5Xe6cU7fZouW7hHKzp
         chQ3TQKDJAQHAU4XaqEEjCFIX2Nm3IZa2YYK4CVZBh0SW1TEM3zwNiznGolnJ+eMXVnG
         +0EXN6waFRNun2ESd1zxUoy7FtCxOtR+K4k6WIYr0j2sw2hhwhLCYDDX+NKMWpSZcUY8
         OgDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793155914; x=1793760714; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T5bJSIKcRblh1n/DNQPJ9kq7nzFmBPGiz7ZQXcqwIO4=;
        b=Sz5bTcKg98yj6giv1/os9QvXpflEh9/gf6LE+Ytfa5GwQEc320BTyiieI6N9vRbc8z
         kSGeqLxdLuESpH3S9h1Fof9V2RXUssuHgpK3FR7nUWlYUl7YlJwAljsF8VIAGwqwgfha
         Lzm52IeeUReLWzBcYjzk6zbhr6doqJThLazxGWqgL9OPCcixPEOltBkVyMLymyEtRMc7
         1t0Fhocmt5waN6EQA/nLXLXCuEWbda+lRDtMxrR3LI4kr7L2M+Xyg0/NbrW1Gfrrmn95
         Z9DIHHNxEBMj5x/0P1lL2VNrw2OeFNNBq9kTCcv1DatTwjH4Fc+7Rdg8OiiulzZ4zEwq
         d4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793155914; x=1793760714;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T5bJSIKcRblh1n/DNQPJ9kq7nzFmBPGiz7ZQXcqwIO4=;
        b=jgFb21cGcBEBOee9q83og1tIIursJLsdRjZLU0cah6CXGfTn+00FdIcwMdk3u4oSS/
         iUMzkpU8NUF9yAMNU3ZJ9EfSEzVTGevF5+UmG4HM/xhDQUys4Zcxk+gqm16dmuGIjzlK
         CfkgLjXKVgkwi96tk5NtGbq/Je5889ayKE3jqzq3/q/D3WWu5ASv4KzTBkwsogQOosNb
         WSrs3aH2jXC3NVsHDQ9vPB4cwvh3M4za3lQsiWWbuTKN97nohVKAkyi91FpMcADmJ+0U
         sQEwLUSCQokkTNoGvhybg6bwzq2ADYFi9FzKFwP6cW8Tn7eDyIVhPNXj+XZIEmMVITxK
         xn7w==
X-Gm-Message-State: AFq9FYJFLHYs9jbGsBduIzKcS65dUcfiZcwGgpFxAF8wfiqsRUfja6Bi
	Z+Qb1TIx1SL4uDchBRuFCCXnRbbXuu9JWt0Rqw1bOCKEpmqooGc0bS5O4MNCwWB+JZL6DPUhE55
	hj2ru1G5CWxL1a9Owc1auy+byUaxBZQSW8ZSf
X-Gm-Gg: AYBFou3e4HRg31DrURogusmwBbuzwKCUkAAMN7aiAkUxOavLlfC61o7FdMdLo+AxJkN
	2IM1TdH1kUtfA2UhlqHL/3ZsMV4mvUAm9t9gMcq1z46f/jcEnkLGiAiS71JSPP0iPMjcxz+8jpV
	FhQKJpqeMKcRSfS6htaX6J3pmUJUNjxBFxdZW0GODYlRYCCq8M4Hxd1k8830X+DfnTpcBnwQLNI
	s6hxzTMxisgNXsOluBSw5x//ZUymHUxYU0FHi3R0z9zNgRaHwgOdqAHGBiCoxECT1UZYUPSGnE7
	ZSe7E6bE28qD2/oEbPkj0Mw7Ju6pnu9CAjqvj0n/9YpkYnxxi7MQbRcu7lnvADg50ZfW4HceYRl
	Lkd7c+7NjN/TQxxMHj6rzridN49X9/dGMEFQ=
X-Received: by 2002:a17:907:843:b0:c40:19dc:a24d with SMTP id
 a640c23a62f3a-c49bdf2572bmr85850666b.9.1793155913845; Tue, 27 Oct 2026
 19:51:53 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 28 Oct 2026 11:51:53 +0900
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 28 Oct 2026 11:50:45 +0900
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Wed, 28 Oct 2026 11:40:24 +0900
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Wed, 28 Oct 2026 11:25:16 +0900
From: John Macias <dencity7@gmail.com>
Date: Wed, 28 Oct 2026 11:51:53 +0900
X-Gm-Features: AclHuK_A2rY_Ata835sL5hsQUpNXEsBloeRCfhOTL6a9CPGznDPVJe_mmj9uw7g
Message-ID: <CA+KzPspNN14ZEyxisGrOSpgfTqajJfZTXG_iHBRMYd2su1dRKQ@mail.gmail.com>
Subject: [PATCH net v2] net: dsa: clear the conduit RX queue on receive
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A multi-queue conduit records its RX queue in skb->queue_mapping with
skb_record_rx_queue(), as stmmac, mtk_eth_soc, fec and dpaa2 do.
dsa_switch_rcv() passes the skb on with that index unchanged, although
it counts the conduit's queues, not those of skb->dev. A user port has
a single RX queue. For a packet from conduit queue 1 or above,
get_rps_cpu() finds the index past the port's real_num_rx_queues and
returns without steering, and its WARN_ONCE() stays silent because the
port has only one queue. So rps_cpus on a user port only takes effect
for packets from conduit queue 0.

Trunk-tagged frames go straight to a bond or team (tag_dsa), through
the netif_rx() branch for devices that are not user ports. That device
has its own RX queue count, so the conduit's index there selects the
RPS map of an unrelated rx-N queue, skips RPS, or, when the device has
more than one queue and an index at or above that count, triggers
the WARN_ONCE().

Clear the queue mapping once the tagger has chosen skb->dev, before
that branch, so both paths are covered.

This leaves no RX queue recorded, rather than recording queue 0. Both
make get_rps_cpu() use the first RX queue's map. They differ for code
that reads the recorded queue later:

- skb_tx_hash() picks the TX queue from a recorded RX queue when no
  socket mapping or XPS map decides. A flow forwarded from a DSA port
  to a multi-queue device now gets its TX queue from the flow hash
  instead of the conduit's RX queue number. Recording queue 0 would
  instead put every such flow on the first TX queue of its traffic
  class. The selected TX queue is also an input to several taggers:
  tag_brcm encodes it directly, while tag_ksz, tag_sja1105,
  tag_ocelot_8021q, tag_netc and tag_vsc73xx_8021q derive a traffic
  class or PCP from it. A different queue within the same traffic
  class need not change that encoded class.
- With CONFIG_SOCK_RX_QUEUE_MAPPING, packets received through DSA ports
  no longer update sk_rx_queue_mapping, so XPS by RX queue (xps_rxqs)
  stops following the conduit's queue number for those sockets. A
  mapping the socket already holds is left as it is.

Found on an IPQ8074 board (OpenWrt, Linux 6.18, conduit with four RX
rings): with rps_cpus set on the LAN and WAN user ports,
/proc/net/softnet_stat showed RPS only for traffic hashed to conduit
ring 0.

Claude and Codex assisted with diagnosing the queue-metadata issue,
preparing the change and its explanation, and checking source and test
results.

Fixes: 91da11f870f0 ("net: Distributed Switch Architecture protocol support")
Signed-off-by: John Macias <dencity7@gmail.com>
---
Changes in v2:
- Clear the queue mapping before the branch for devices that are not
  user ports, so trunk-tagged frames delivered to a bond or team are
  covered too (Sashiko review).
- Replace the claim that TX queue selection is unaffected. The changelog
  now describes the effect on skb_tx_hash(), taggers that consume the
  selected TX queue, and sk_rx_queue_mapping and
  xps_rxqs, and says why no queue is recorded instead of queue 0.
- Subject: "on user port receive" -> "on receive".
v1: https://lore.kernel.org/all/20261025072203.1519561-1-dencity7@gmail.com/

Claude assisted with diagnosis, the patch and runtime harness. Codex
independently reviewed the code, claims and raw results, and corrected
the test descriptions.

Testing on net/main (5d7f3375c), x86_64 under QEMU: a 4-queue virtio-net
conduit with dsa_loop, which for this test only was changed to use the
Marvell DSA tagger and to accept LAG offload (lan2 + lan3 in a
balance-xor bond with 2 RX queues). The host injects DSA-tagged UDP on
chosen conduit RX queues; rps_cpus on lan1 and on bond0 rx-0 points to
an otherwise idle CPU. 200 datagrams per queue and path. The RPS columns
say on which conduit queues the receiving socket saw the RPS CPU
(SO_INCOMING_CPU, which holds the socket's latest receive CPU, so this
is a per-socket observation rather than a per-packet one):

                       lan1 RPS     bond0 RPS    WARN_ONCE   eth1 TX
                       (q0-q3)      (q0-q3)                  per queue
  unpatched            q0 only      q0 only      yes         800/0/1/0
  v1                   all          q0 only      yes         201/100/150/350
  v2                   all          all          no          201/100/350/150
  skb_record_rx_queue  all          all          no          800/0/0/1
  (skb, 0) instead

(Queue 2's NAPI happened to run on the RPS CPU, so q2 does not tell the
cases apart; q1 and q3 do.) The last column is the eth1 TX packet delta
per queue while 16 UDP flows (800 datagrams), all from conduit RX
queue 0, were routed out a 4-queue virtio-net with XPS cleared; each
total is 801 because one other packet was also sent. The aggregate
counters are consistent with fallback TX selection favoring queue 0
when RX queue 0 is recorded, and flow-hash distribution
when none is recorded; the unclassified extra packet is not attributed
to a test flow. W=1 build of net/dsa is clean.

On the original hardware (Netgear RAX120 v1, IPQ8074, OpenWrt Linux
6.18, four-ring conduit), v1 was tested as described in v1. v2 has not
run there yet, and I have no switch with LAG offload to test the trunk
path on real hardware.

 net/dsa/tag.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/dsa/tag.c b/net/dsa/tag.c
index 6a5aa7fc3..e53dc3f3c 100644
--- a/net/dsa/tag.c
+++ b/net/dsa/tag.c
@@ -95,6 +95,13 @@ static int dsa_switch_rcv(struct sk_buff *skb,
struct net_device *dev,
 	skb->pkt_type = PACKET_HOST;
 	skb->protocol = eth_type_trans(skb, skb->dev);

+	/* The RX queue the conduit recorded is an index into the conduit's
+	 * queues. It means nothing on skb->dev, a user port with a single RX
+	 * queue or a bond/team with its own queue count, and get_rps_cpu()
+	 * would check it against that device. Leave no queue recorded.
+	 */
+	skb_set_queue_mapping(skb, 0);
+
 	if (unlikely(!dsa_user_dev_check(skb->dev))) {
 		/* Packet is to be injected directly on an upper
 		 * device, e.g. a team/bond, so skip all DSA-port
-- 
2.47.3
