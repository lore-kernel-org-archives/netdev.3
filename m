Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756768;
	b=acnYcQmJ9mWB7EW0EGuxztAFupqA0CFJX8B5pzILm4j9JW+sKmHYrL10s64SjbxFwBtO
	 SzguCfgZkKFSc06leaGSPDI5hw9pTNr5UTV2OWMtfSH1IwAJV/92cmgN4bKnRsgvGNK8N
	 whRiwYIu7H2CEVtPDtGI60kDYo8lU4QWbLz8QqVwEey6a4qUNvCDnqQnnDWbThbnjiFkN
	 TEnOR6IdOIcdKH22rs/a/U6hKZ1bzp6rKV4SymUsxX59WIjP3PaUv/yLEf7JdnLacbjlX
	 OkcM3pUtp9jd1sKtg3ZgGDBYBwT1fGJidJwv4fDICQMr53ITk+KvZH/iPIExdywyJSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tg8frWR4xSaMBN4W5XIQ/DFU/ZoK/yXicRO0bbU7JUQ=;
	b=KDnQsDRun/jlAqfsOAC0K4M7XEh50U/MZy8wYJ/fPntdN/8vs7V5aEobcI44NPeCUtE5
	 YOJreG0tFGCvKocz4zwpkfwBmmPtQmnVmZLFihlGlNrYh0cqsIBhQEgHl4vuoF3PlPCqT
	 x6t0l+SECmvFWsqb1cuqCGzvyK+6vvk3TWGy4FXE3KkwKNWu3fmdA6ofn68/TYYHUGz37
	 XpKU0tTqZDi96oOOllpibyjByiz+RZcKoPeeaZI8JDCwFbJ3RiVdR5xGbzwWg3os3ct1G
	 AnU2BvHgfIx/zczHhEoDoGxhqwfox3AxaTx+7x5VfrcjHYcQC70AmnQjdS/x/l1p9mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=y1qVsx6M;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C756E606A31E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C756E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=y1qVsx6M
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c3fd7bbdeso4146256d6.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792756767; x=1793361567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tg8frWR4xSaMBN4W5XIQ/DFU/ZoK/yXicRO0bbU7JUQ=;
        b=y1qVsx6MC2MS5/qXviXo1UIpuMKRvx6euAWQ8YkdoQrtpd5mcFR8X6POj12EZt19y2
         SPUy8aLTvufdmNuuP+v6m9R5xiMPEO4e01OwwXu8wppg1HsttgptUf/OjGndQZ3UcPIT
         9qcoJ7kqspMMemq4KL5bunaE1oBwuZzmchCFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756767; x=1793361567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tg8frWR4xSaMBN4W5XIQ/DFU/ZoK/yXicRO0bbU7JUQ=;
        b=SauyMlIpl5mMGkJG5KOVZJm1G2YUCTjXly3XBbl9NNbviuu6DddFSo7yODoqp5s1ea
         SaGQ/Op95idyqNqhrqJjNQl516ljcIUHUlO57sP7SD/X675XAL6lzFhzkNGA6z1oFJnW
         yIZWVUkYX9lFeKcYoXnEf4Z/iHBFu3PNpmbDy31uKqNM01oNYUmopDoX5neVmcExZC6p
         svy4uhWWphHP5y+S99nKuzazNuR1/FjJcb5EDFNKcUDQN6hYl3KYNbT+Zt80nzz+ipcg
         NnW6oIT/2JrMDuvRvEj1bxd8mEaE0NZqv+mQUMo1eUC4rD6sqhk4OK/VjyJJ/m5n/kUR
         fhLw==
X-Gm-Message-State: AFq9FYJP7JwJBoQRVQ5X6v9XXgSXTNF/l4QQVKvFNb9MBS/IdmugZnmQ
	mezzfxRMmjPbxk8yWnrxvwqN8guUmDhDjC4hdBYnOrkM5FcQEJ8UCsocJDSuDunnEqBbnWR63jQ
	dewc=
X-Gm-Gg: AYBFou0mt8PgNXdSuCVX74rJKLDvwVaQR+Aouzps3jiet2WCITld9d7WmHmG5X3QMeD
	3I3FC8TsxpWpWt4QBVHI2VXgc//gNGD2aS5SVM+tOZ+TRzBCcz8WlokaHXtxjoXyyhk76awod0T
	qNVc2P59lE5pQjvhxSfGGFzbdjkaGP0hdUnzW7aGxWwxzgwHiPxMQbz0jySt6x3yKylKN4h6nnV
	ET//Gu4lbTUtBZfrkGb4OsDGb8WhHs2DzgpxAWm3BmfPtxQdu8wCweLFJs3fvn4AolTGgABuMIm
	xu+OVJ3viKOigKdSfI14jUhJXPvMgi665VX+uPKxSIhXsaZEFiMO+XX/uChc1zidNZ5+/zau5hk
	XY6nU++QIjIeWY/poi/uioDpk8lGzWCcIMrqCwnqfeQYxZwkUXnQZExPoW1euL+VrXzD4ChWMu8
	neeK0vxT+TGNDKHPzSKxDmvBmGyiJJqKB0LhQ3+pQgAclzwZF04KO5LoE8z4SVH1EN/RcAkX5W6
	fiSg2RdH/fE1Vh6J4W1bid+YkKklqP1bJ+jFX0Dm0nIu48V6NO5ZRk8Pt7Ooru0FLvndMrrm0Z3
	YyyCZ5SzXILv69axLqqcf8tTZXziQho2M2Bo/cIbv45G5UaTOcN1PD3T1poxEONb
X-Received: by 2002:ad4:5f4a:0:b0:91b:5d3b:4acd with SMTP id 6a1803df08f44-91c3acb8119mr23988026d6.54.1792756766537;
        Fri, 23 Oct 2026 04:59:26 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396af493sm18358246d6.9.2026.10.23.04.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:25 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	stable@vger.kernel.org,
	Martin Varghese <martin.varghese@nokia.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Shmulik Ladkani <sladkani@proofpoint.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Jiri Benc <jbenc@redhat.com>
Subject: [PATCH net v2 0/6] net: pull short linear Ethernet headers before eth_type_trans()
Date: Fri, 23 Oct 2026 07:59:15 -0400
Message-Id: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
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

This series fixes a class of producer/consumer bugs in which an outer
header is popped and the packet is then handed to a consumer with fewer
than ETH_HLEN bytes in the linear area.  eth_type_trans() pulls ETH_HLEN
from that area and can BUG in __skb_pull() when the inner Ethernet header
is not linear.  The affected producers are act_vlan POP_ETH, act_mpls POP,
act_ife egress decode, and the Open vSwitch MPLS/TEB and NSH pops.  A
consumer-side guard in act_mirred rejects redirecting a headerless packet
to a device that expects a link-layer header.

Patch 1 makes act_vlan POP_ETH pull the inner Ethernet header after the
pop and drop only when the packet is genuinely shorter than ETH_HLEN.
Patch 2 does the same for act_mpls, gated on the pre-pop MAC length.
Patch 3 adds the act_mirred guard at the redirect boundary.  Patch 4
keeps act_ife egress decode from consuming the inner Ethernet header and
restores the header metadata.

Patches 5 and 6 establish the same linear-header invariant for the OVS
MPLS/TEB and NSH pops before restoring MAC_PROTO_ETHERNET.

Changes in v2:
  - Pull the inner header with pskb_may_pull(skb, ETH_HLEN) and drop only
    on failure, instead of dropping on the post-pop skb_headlen() check
    which may drop frags (Eric/Willem).
  - act_mpls: gate the pull on the pre-pop mac_len and remove the separate
    was_mpls state.
  - Drop the v1 TUN patch; add the act_mirred consumer-side guard.
  - Add the act_ife egress decode fix; decode is receive-side, and the
    egress path restores the frame for loopback-style transmit paths.
  - Keep the OVS TEB and NSH patches unchanged and restore their v1
    Reviewed-by trailers.
  - Drop two bouncing Cc addresses.

Jamal Hadi Salim (6):
  net/sched: act_vlan: pull the inner Ethernet header after POP_ETH
  net/sched: act_mpls: pull the inner Ethernet header after POP
  net/sched: act_mirred: reject redirects without a link-layer header
  net/sched: act_ife: do not consume the inner header on egress
  net: openvswitch: ensure a linear inner Ethernet header on TEB pop
  net: openvswitch: ensure a linear inner Ethernet header on NSH pop

 net/openvswitch/actions.c | 12 +++++++++---
 net/sched/act_ife.c       |  4 ++++
 net/sched/act_mirred.c    |  7 +++++++
 net/sched/act_mpls.c      |  2 ++
 net/sched/act_vlan.c      |  2 ++
 5 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.43.0

