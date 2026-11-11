Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406606;
	b=4mcSh5gKjLsh77p3XQIcHcysRjWNCDezmaymzRAvVB128y/5L/EeS1MfKJGThVgTUyB+
	 j4hgoH01j83+d+tk/BvY3GwuiOtCIJm0Uf6aslQaLlURoaZ0KpcPAUfPzJgqijIhKWSt3
	 ehjxx/UNji7Pry0AI/q61vkzBbKN6R5HMtE7yRRyl8JFaTnQ3k4M4bwrLQ1ETKihvpKoZ
	 iXbtMircZRRZJHO20NmO+eG6WrfwvDY0Qk6qBslfK1Z70aXlJQ5vPhJP7Qacm047SZxE9
	 O2TpkO1Ctz9a59lENAQaQeghsH1H5mRKQboMktG/GcrTBvxOvGXncQ54lHZw1gW+QsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PNaQ6Q4vGpSRfUWx0yC1mdo3/cj4HJ9kzAYecFEBLvE=;
	b=xSagpAKHFuiv3Z2swGgMoToaNMpbZSX+xf7ZP5kw0Lc4oSF0L/ckZfFAbL2aM/7p7PJz
	 htICLVAVDNr7wlQX5e8xY4JAC9160jwXv18ydiYTnqVe9f8KfAvsH22LfgmP8YylGVnni
	 HrdTvEGRcVI4QwBRB9EcqDjwOyFzINDhCkzMZ5HKAFv70kd3BP79tfHQz+ZhBvUW3yPry
	 In8rQ+M0YMagidSnPLV9sz9jgGBIJ8vL4wQ4uoq35Bhl656plu/jQnS21Ro0Hfi8Lzs07
	 wuUcO+kJK5U3Aq7yfNv8GLP3mWQPNrNmFtKeWCRz0HX3qyVmBSFz9ocR1U9SzdkHlGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=vaqSbvOo;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9BA606A327
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F9BA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=vaqSbvOo
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53cd0c8614eso22221561cf.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794406605; x=1795011405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PNaQ6Q4vGpSRfUWx0yC1mdo3/cj4HJ9kzAYecFEBLvE=;
        b=vaqSbvOodam9Lh8sl6hGWYWFmFqegHb/nVrcQAs002a9RBJ1hp32LLzLGA+NPmLazp
         T0v3UjOHN3+PYiSnZxQkbO9WsJbpZnEuGuT0bGEqnE8G0eMtzFsrbmoW4kPoQlKKGDl6
         5kpahpb7WhJyfZMPmYEZ9g2LQfyxfPpf4n238=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794406605; x=1795011405;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PNaQ6Q4vGpSRfUWx0yC1mdo3/cj4HJ9kzAYecFEBLvE=;
        b=XPtz0OfnCTXE4c5s/Bv+Wd38Zh15ogZiOnpH3K/v6nC0D+WZnmglUxhOdvScW0DVke
         siaDdTyI1SO0xkAS2uhqa0wL7qSywFeyAfCth9/3Qb5wc6BRxXMuRMHXHWrg+Hntksbz
         EpdZLol1Z6MHMD31obRkr7kNWza6PnsTH9wTjkgAabkmpzu1Vk89HgqFsHj4z7QAyZzq
         EWQN0tPkAlBagb2l9OLjM1Co9IxqvK3m6A6IJgRxU23sNpQl6r75UM5LljeY39uVK78C
         asYnkQ8s1NTtBRvjgABTSsHx0MDjQRiOIEbdLYza0Pz7HNEdWk5gsG261Hsz50EzdI0J
         G2oQ==
X-Gm-Message-State: APuU4Z+3Lpd6wp5KqT/fgwUohBgqcWdcgwY3t6K+pIz6El0kt8acqSvh
	1fnEtMus/t1o1I4sgQeoiaEnyu5dYQopjEo0IAx8PjzTVv6cOkdP5s0iBvY0sK2+mzAuPT3x1Is
	bxZ0=
X-Gm-Gg: AYBFou05pDO8WdYjhYZcSLNnme57nPYegJ3lFgNhV7G14mPwk54MCAi6pOU7B+djczj
	i+THcI5idey0Xl6ZjQBGqmXJDCgihq+1bIREEANnkL3QAcmV0t+ijiGU0Ci1EsuR1ALNLGFj0En
	eputw+6yWK4TPNU/pADQAH29kRhmUKS0cotendk4nKuozsiiS372BXp8f2dI2flk97PED0+xzj8
	nJLBMDQoIyN91qBHRLVhKrL5gmnvaGIYi6UL0AskdRUsctxWRzrWnCRLO77kBJ+PdDMNJH03Ktn
	5IbPIuVdNV+pzpV4Ir1+7KjE0dDVVyObxlbMF/M0DP3Y5Os4LPSEoOZgwbUptUg+W38ZxDfYp6t
	qUZe8It4KBEexIpOGlFBCZ/EqXmbCcbFLoJ0uOamsjlcxEU1Egnwzxglh3rM8ZbZ3QbCj4olpOB
	N+Rtpe+cG5quGWzFhp97cA4TKhUepFO9pY4roqGOb+tCiN6jibc61+/izWXggRpl8RwqVKsQKd+
	PNSzGyZ213uoMIQ801VYBhbbeNWYPdap5rug1xgUuu2CcvELkOnAYcSUp3eNq1S0gVPwe2qPRxo
	QqBtJ6mKdpF0nmOxkyViJ1OQ3hzYRCpTdlzcxbIKRL1Ei3hv1ArDJnKWsm6XpU81B0aasS1bsMp
	mzC9EnTB2sGrIGg==
X-Received: by 2002:a05:622a:1b1d:b0:550:fe12:22da with SMTP id d75a77b69052e-556bd708e0bmr35644631cf.6.1794406604915;
        Wed, 11 Nov 2026 06:16:44 -0800 (PST)
Received: from localhost.localdomain ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550be2e592sm51505041cf.24.2026.11.11.06.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:16:42 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	sashiko-bot@kernel.org
Subject: [PATCH net-next 0/2] net: drop the stale dst when steering to another device
Date: Wed, 11 Nov 2026 09:16:36 -0500
Message-Id: <CORE-9NOG.v1.r0.20261111073528@mojatatu.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset is created to address constant whining by both sashikos
about this being an issue when fixing a UAF on a teql issue (entering
v4 now), see the v3 here fixing the teql consumer:
https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com/

Two producers steer a packet to a network device of their choosing and
then hand it to the neighbour layer for link-layer resolution:

  1/2 netfilter: the neighbour variant of nft `fwd`, on the netdev egress
      hook
  2/2 bpf: `bpf_redirect_neigh()` when the program supplies the nexthop

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
patch stands on its own and carries its own reproduction recipe.

The reproduction for both arms is a pair of veth devices, one of them
with an unresolved neighbour, plus a capture on the target's peer: the
captured frame's source and destination addresses name the device whose
neighbour was used to build it.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com
Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com/

Jamal Hadi Salim (2):
  netfilter: nft_fwd_netdev: drop the stale dst when steering to a
    device
  bpf: drop the stale dst when redirecting to an explicit nexthop

 net/core/filter.c              | 4 ++++
 net/netfilter/nft_fwd_netdev.c | 1 +
 2 files changed, 5 insertions(+)

-- 
2.43.0

