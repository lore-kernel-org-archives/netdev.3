Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852128;
	b=O7kmDW876RxlOSIVzNuoahbFpTuTq/GYJWL57VQ+RbXbUgL9CYufrWccZQwbWnqq/U/a
	 LNduDfX1oAr0NHV/b+cwzIvh25rspBYg1ORExAsSxEYy9u20IY+jILHgXokkIhiTOIg5S
	 RnqaRum4abZNmKJOZcfVmaMOhF/RJdXJoDqoFSsFIwfOaXHBqehl0xlSsTb5iK6tnzS5v
	 4Nq0zktLpFJQptrSRh3vTtqrFhwtF9Oc2XnYM/jtjvWTbqpnfl1u69kpoIvDUvseCmPAx
	 25eACYKTwEKR9yuQbOwXuo5OzBUiteL0oqhiKmgaGhQV5oCGSTQL321UcLpE3xfgKEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=T1aUxwSt8x529kwJJ1c+bF4HCux/lGTMN5DP5a7x++k=;
	b=RYMY1oLHRNWvnw1hbC95QVEaUGaSUn+1LTutjiyszkuId6vDdxJaLSysYkHdER69CFg1
	 d7SwFJYfY2ATFBIqLjG8u2aRoeGvPmStrYh+ojpeCgCKO98Tcf/YrUeaA/9WDLM8CZW1x
	 plu8omCSEjhe9nLeng3PM4AZe3+W+4HsO5ci64jT/mDZMwX4lN2dZhJcZYTD9DUj5Yktq
	 ukuvK7BXDWEZPmT+igQPXg/sHlDZJo0yPFsra1lYChj2coKNighhENXMeTjk4DFnwHy1o
	 nL3vn6lcIWtOIaQWlyG+oYga2ZOWvlnNB/8r7WDr+lWcfslt0BAzRDtudoiBF+EqShQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=C0923mnC;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2EA606A327
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 14:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B2EA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=C0923mnC
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5365f9a04c5so5534431cf.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852127; x=1793456927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T1aUxwSt8x529kwJJ1c+bF4HCux/lGTMN5DP5a7x++k=;
        b=C0923mnCILsVt8ISFT36TIipS1rOY2HeBEwluDKOvujlLf/JqqFl0pk957bgqshcuq
         UbMs0EAzTNlEBX3+pfAi7UoDEamHhJKkIHW30KpE8THBlj75FJQyDgonHfBl1Rb29Jad
         P6zDFehzf4/Pyn53F8B/AbGwlTjEVqlmwKKds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852127; x=1793456927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T1aUxwSt8x529kwJJ1c+bF4HCux/lGTMN5DP5a7x++k=;
        b=bxMz4csuI+P7TwNN7iPRxp7X69FuvdUlI/cGvVS2xC5y4pYUecwIIHWxbTc0VUun0J
         eNk0Rmx7tQXjYiurTC8ayg+zLlPk/W903ICJ2vHfRQHfBiujoZiZmbcpD8PyxZhLJ849
         1JMJKbpgLde4onULa7ECKC1h52HcviBHdVZ0ZPZeksRyD2I6x88OqKQbQL933xvwi4fM
         oOwv7dJDJCSi0LoXSUqnzU0Fe4wJw4bokHzyffTugDWIfV/cLNiL8ObRZZUSmusfGuKV
         aop/KuhzkRzB2Vx5cbUx6/woG6MDJJoukGDyg5XuEDA3MtVuReCDwt547WIK390G0WyB
         ZuMQ==
X-Gm-Message-State: AFq9FYKrTfw3AIEFt0lWV1tRqhdvKog/oVP7SiFiTlzUbNwAR1Ddcftw
	wxvJh5I0nreCGacx9gacEH+fEKCLzWGHv2IKncQM9rf0Tw895k0lDyBvDES5ABmT5o/lHsEqQ7J
	yf7w=
X-Gm-Gg: AYBFou2FFYJsz1nvQVAwL9/cyscA4qaLPlhQqZBIHG76YVBDaXP2JLJ6+wBo3iZh6oE
	KsIJecBB5RCp+NLqptLJOKNmMZ+fWkOUFWSeDRBoixNqE8IwsQra5/8L/ibrB2hzJEyepyWEcfM
	JyFcJGINaJlGtC3ZLVZniyVEeoorPllbB7JOxnOvREPS6mPAZXiJNbOzCcB//CeEUFImuwwNwOn
	V2lq7bkDBN/lsy/eAVW8iE3lOy/gMFwp+G835FLSBCblaFjDtZu+ZdSuyt40z7P2oQGLceyEfJX
	ADQWN8KfFyfDeP0gkdvLz+zDvFnUmxtcpDKFhweoJLIQ9J+I4htIFfTH2Lcdc9lP+POAcyuHqPs
	o6jTmmSosrtJP2MyJ+FvLsC2ph4CV4vOi45taW6ZYwU7nArTuBQY/WH3hWVoUScCE+TgQyTqFdQ
	xWAiJSWKaGe4BVotnAfkcW8zlQwRVTuKnney+S/GyyZC6+V2l9PbqW2nBNWQ8zJRXnk+EC7tBMJ
	A6P+sJBJZdcCBoqqNHeMa2i02xt2cbOB4rqMOA1YNsZK4ughael/KB+6+MhoEpFxLhK1mCviAxf
	uE4X62zFS3V+UCgIfc0tel9koYoOVizA/qu15yHrHQ==
X-Received: by 2002:a05:622a:387:b0:535:f9dd:cb9b with SMTP id d75a77b69052e-5383b4cc284mr29729391cf.26.1792852127084;
        Sat, 24 Oct 2026 07:28:47 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a7cd7esm22349976d6.2.2026.10.24.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:28:45 -0700 (PDT)
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
Subject: [PATCH net v3 0/6] net: pull short linear Ethernet headers before eth_type_trans()
Date: Sat, 24 Oct 2026 10:28:35 -0400
Message-Id: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com>
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
consumer-side guard in act_mirred ensures a pullable link-layer header at
the redirect boundary.

Patch 1 makes act_vlan POP_ETH pull the inner Ethernet header after the
pop and drop only when the packet is genuinely shorter than ETH_HLEN.
Patch 2 does the same for act_mpls when the configured inner protocol is
ETH_P_TEB.  Other inner protocols are not required to carry an Ethernet
header.  Patch 3 ensures a pullable link-layer header at the redirect
boundary.  Patch 4 keeps act_ife egress
decode from consuming the inner Ethernet header and restores the header
metadata.

Patches 5 and 6 establish the same linear-header invariant for the OVS
MPLS/TEB and NSH pops before restoring MAC_PROTO_ETHERNET.

Changes in v3:
  - act_vlan: keep the unconditional post-pop pskb_may_pull(ETH_HLEN).
    After discussion with Willem I considered vetting it on ETH_P_TEB,
    but was hesitant because i felt checking TEB in act_vlan was
    in bad taste: POP_ETH has no inner-protocol parameter. Eyeballing
    also showed the TEB test is not needed for the eth_type_trans()
    failure this series fixes (of course sashikos will have something
    to say;->).
  - act_mpls: drop the pre-pop mac_len gate and pull ETH_HLEN only for
    ETH_P_TEB.  Other act_mpls inner protocols are not required to carry
    an Ethernet header (Willem de Bruijn).
  - act_mirred: drop the skb_network_offset() condition and keep only
    pskb_may_pull(dev->min_header_len).  The offset check rejected valid
    MPLS L2VPN redirects (Eric Dumazet; tc_mpls_l2vpn.sh).
  - act_vlan and act_ife: no code change; add Eric Dumazet's Reviewed-by.
  - OVS TEB and NSH: no code change; add Aaron Conole's Reviewed-by.

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
  net/sched: act_mirred: ensure a pullable link-layer header before redirect
  net/sched: act_ife: do not consume the inner header on egress
  net: openvswitch: ensure a linear inner Ethernet header on TEB pop
  net: openvswitch: ensure a linear inner Ethernet header on NSH pop

 net/openvswitch/actions.c | 12 +++++++++---
 net/sched/act_ife.c       |  4 ++++
 net/sched/act_mirred.c    |  6 ++++++
 net/sched/act_mpls.c      |  3 +++
 net/sched/act_vlan.c      |  2 ++
 5 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.43.0

