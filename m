Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516058;
	b=KIRrL3/wc2B3lVgPhpGwn4lOUEDcpgBcZELp8mIwpQ1bXnvJD+Syzx48TTcHpps83XxU
	 dAHwoN7J+5HyJVoKpG0+oaAQ6zvnrh5h7OVbIaRmwRNE4Z3Dl2/ncuurC6PjsC1RvJ1T3
	 +4JBlooEE2TOo7XlzpLBX9LX96yrAq/PI2z7f0fqi48cfdCOB+tVU5A+i+sU0zXJJjZ9Z
	 DhDIB6yumc9yWQHZPqwnE/N/plO7RepQb7HfkAXvtIOEBA7+n6tYBpbfhxfodPRqUAYJt
	 nM3SAdv7v3UaOh+Pn2hJFgn1T1qJiOk9Ol81NwR6XZpBjJNeUMQ5WjKp2dWGAiMdCCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TLrth8wLEh6vpvKNPNp2R9KWAwbTv3cJENXtlUTu6CY=;
	b=4YfV85cEDxxzTgPNuvDjRt1PaM7ehHaBiIiXGB4ra0S0ODVaNrB+osmHmbaNYOChqZTP
	 I5eifE5QRs2WCfhDFbdGEHeix+tL2ViQftrDjtu0ms19SdgB7sUCeIXCkLJGBKDt9Z124
	 WwEEe+4leqml/Ba0h5l69SSl7uK1/PbpuUabMGkYR4A8QvphhQqjm8jgop+LCWE2o9dsv
	 PQrJisB5IDHBFY64gM//3eh+pftrTOH4hEk43qQms7kOAbqUGfTYLw0EbweIvn2xshKmw
	 bDXeSjk7d5GWS2GAPL9jL8ryb4utrbVeQvwh0tcX3ge0U1Us0NDWDnHD5LesDHFd/GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mbczJFVI;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD743606A332
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD743606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mbczJFVI
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53644b28706so2060481cf.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794516056; x=1795120856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TLrth8wLEh6vpvKNPNp2R9KWAwbTv3cJENXtlUTu6CY=;
        b=mbczJFVI6lxSCHSzDPA39M3ymXrEkoYc3GnzC0664YAwPder3+PBBzXgIE6dZiynSg
         VZDA6De4JxOAbqtVTkNMdPBJc7LOGvwUVoIya50ouUcJwlTIP3VC10DqdbuQFMR0yF5r
         Z3DUeB2qS7ti4pHqfgijSIB3Evw4EQTEnrmxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516056; x=1795120856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TLrth8wLEh6vpvKNPNp2R9KWAwbTv3cJENXtlUTu6CY=;
        b=1DNs4kAFw+AL6FnRW/WVfjRyJXsV7d3RLkg1n3R0VhKnyvTVpBdXBOcSZiwRACRIoz
         U0X2xXT4IEwIp0x7hnU9tuAlQqmWsQ1d3yLkc7BX0ENYUEkJTYlfrCvaxKOxppTOUJxF
         c5WrXgu1yp2FneKsNea1BsMKVVOf/VqMzbNU7efQx08J9RCSIZAWFVJdAeyVB7Wmm5BI
         iuAM5wAyd5G32xp2IiP1qszmWtUH2Zj+ss6PFOwKYgPhuxC7oewumH7rrc09JdFsCeN4
         Xkmvz6an8caQClO3y9InUbi0kQincvnursnkUiH9s6J7dGgw7YnfhYFwRZI0kh+4sM3O
         y0sA==
X-Gm-Message-State: APuU4Z8JM6WcYL0W+shtI54TVkH23X1afyu6OL9DCktU1H5E80GQNlnk
	+K4HlMNVZhpATS6Lcus3gtRaUpT55hc4nhXLZKu9rqQVNCSjoP7b23wVkyjZgaaVUCeWq6TqhUV
	DNRA=
X-Gm-Gg: AYBFou0unc+u88MD1TFes2XRi5V54jAPVUzXN8cWY5Vd+tTG3hIr3FoZntt9ZpCq/F+
	9rHwMfj+QQne44LFIycv83zkomT9XWvMYiAIAi4Bf/2itCVb5c0KnsMp45OfwZzwziDUr5R4Iht
	ybT3Llyx88TCm4EFji727UXQSjJ9Dek6e1BNV1rv51VxXjwSXok74WKVxQFOFpLi2kbqFPv/sBj
	8xmMWEC+vJ5rY0VFvO8p2oYEAb7XnffMyDwyO/iZNB3aug2vbqx56UnZxAjRWQ42lFgkJcsBgfB
	KGaLWR5zZAwtHcdWJYfLME1+7GTOoB4jbpGG9SHGtZ2NhBx+45q1n5WZgQT7VKspbPDuM5QJUUP
	gbnakSluA6NX1pvB28uH7X0ob8U1If9upf19JZ5Vcyt5RQT6kYr8zwt75P7EVrnkmFGOBv/h99C
	LACoWt6g7kQCQEognlxI7ItTNhRxqsPlLXNREdWiQxm8vlQn007tXUNYqA+zlvGIYeo9ycWip0a
	U+FTRqgHWLyLhmuLo+EdD8IKOc9Pv4BwprjCwdhohDpVx00/zkC6++3Pma3/eFxeKlwkHPphrjV
	jaHPAeJXGUtBQs6HXycHZBRdUv0OlweBEqMUyQphiU2U8zrXrJYJkh+LS+iXdMYGdnjkrOqdZVg
	=
X-Received: by 2002:ac8:5a54:0:b0:530:1b1:72be with SMTP id d75a77b69052e-55ac7b55b58mr10360831cf.40.1794516056428;
        Thu, 12 Nov 2026 12:40:56 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d61888sm4452116d6.20.2026.11.12.12.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:40:55 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Sashiko <sashiko-bot@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v2 0/4] net: drop the stale dst when steering to another device
Date: Thu, 12 Nov 2026 15:40:45 -0500
Message-Id: <CORE-9NOG.v2.r0.20261112151659@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

This patchset is created to address constant whining by both sashikos
about this being an issue when fixing a UAF on a teql issue, see:
https://lore.kernel.org/netdev/QDISC-6HS9.v4.r0.20261111094338@mojatatu.com/

Two producers steer a packet to a network device of their choosing and
then hand it to the neighbour layer for link-layer resolution:

  3/4 netfilter: the neighbour variant of nft `fwd`, on the netdev egress
      hook
  4/4 bpf: `bpf_redirect_neigh()` when the program supplies the nexthop

Both rewrite `skb->dev` to the target device and leave the skb's dst
pointing at the route the packet arrived through. When the target
device's neighbour for the nexthop is incomplete the packet is parked on
that neighbour's arp_queue, and draining the queue re-looks the neighbour
up from the stale dst. The frame is therefore built with the original
device's link-layer header and then transmitted on the target device: the
packet leaves with another device's addresses, and the sender never
learns that its nexthop was unreachable.

This is explicit: the steer-to-another-device path never worked in this
respect, so there is nothing here to regress. Both producers shipped with
`skb->dev` swapped to the target device and the route's dst still
attached, and the arp_queue drain has re-derived the neighbour from that
dst for as long as either producer has existed; the invariant "the skb's
dst describes where the skb is going", which the routing path keeps when
it steers, was never established for these two entry points. With no
commit to anchor with a `Fixes:` tag and no crash, UAF or lockup
involved, the series targets net-next and does not nominate `Cc: stable`:
a backport would change long-standing redirect behaviour for no
crash-class benefit.

More context: this came out of the review of the fix for a parked skb
being resolved against the wrong device in sch_teql, posted separately and
not part of this series. The neighbour code's queue drain is doing the
right thing there, it re-derives the neighbour from the skb, so the repair
belongs with the producers rather than with the drain path. Both
producers are fixed in the same series so neither is left behind; each
patch that changes a producer carries its own reproduction recipe.

The reproduction for both arms is a pair of veth devices, one of them
with an unresolved neighbour, plus a capture on the target's peer: the
captured frame's source and destination addresses name the device whose
neighbour was used to build it.

v2 drops the dst only when it describes a route, and keeps what the route
carries (thanks to Pablo for catching this). A `DST_METADATA` dst is the
tunnel template a tunnel helper attached to the packet, not a route, and
dropping it would discard the encapsulation parameters, so it is left in
place. A route carries encapsulation parameters too when it was installed
with an ip, ip6 or xfrm encapsulation; 2/4 adds a helper that moves them
onto a metadata dst before the route is released, so a producer that
steers into an external tunnel device still finds them in
`skb_tunnel_info()`, and one that steers into a `collect_md` xfrm interface
still finds its `if_id` and underlying device. Neither case weakens the fix:
a metadata dst resolves neighbours through `dst_blackhole_ops`, whose lookup
returns NULL, so the queue drain keeps the parking (target-device) neighbour
exactly as it does with no dst at all.

1/4 is a prerequisite on the xfrm path turned up after Pablo's comment.
The interface that consumes that metadata puts the original route back on the
skb before the xfrm lookup, which needs its family, and installing a
reference counted route over a dst slot that is still occupied trips the
slot assertion; the slot is cleared first. The same overwrite is in the
tc-bpf helper that attaches the metadata, so both sites are fixed in that patch.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com
Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/QDISC-6HS9.v4.r0.20261111094338@mojatatu.com/
Link: https://lore.kernel.org/netdev/avTfQjFQYR2NNdRg@chamomile/

---
v1 -> v2:
- Do not drop a dst that is not a route: a DST_METADATA dst is the tunnel
  template a tunnel helper attached to the packet, and dropping it discards
  the encapsulation parameters (Pablo Neira Ayuso).
- Keep a route's encapsulation parameters as well: a route installed with an
  ip, ip6 or xfrm encapsulation carries them in dst->lwtstate, which a drop
  would discard before a downstream tunnel or xfrm device could use them.
  The dst release now goes through a helper that moves them onto a metadata
  dst first (new 2/4).
- Fix the dst slot the xfrm consumer restores: a collect_md xfrm interface
  puts the original route back before the xfrm lookup, and installing it
  over a dst that is still there trips the slot assertion.  New 1/4 clears
  the slot first at both that site and in the tc-bpf helper that attaches
  the metadata.

Jamal Hadi Salim (4):
  net: xfrm: interface: restore dst_orig on every xfrm interface
  net: dst: keep the LWT metadata of a dropped route
  netfilter: nft_fwd_netdev: drop the stale dst when steering to a
    device
  bpf: drop the stale dst when redirecting to an explicit nexthop

 include/net/dst_metadata.h     |  1 +
 include/net/xfrm.h             |  2 -
 net/core/dst.c                 | 72 ++++++++++++++++++++++++++++++++++
 net/core/filter.c              | 12 ++----
 net/netfilter/nft_fwd_netdev.c |  6 +++
 net/xfrm/xfrm_interface_bpf.c  | 16 +++-----
 net/xfrm/xfrm_interface_core.c | 22 ++++++-----
 7 files changed, 100 insertions(+), 31 deletions(-)

-- 
2.43.0

