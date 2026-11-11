Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410257;
	b=Qp+bfFMIfTIqEupOYHRYN/WW4rRGa17X+snt4Cd3qYwqConv11H8GceHRNaF/sLQQoi2
	 VN+1727s91NwrV0djfPd+LfNM305KLQzA+nkmcOpVavkdoWxPSE8hiadTucP6YrrG0fKT
	 +cJt11GKk/dkQa6VsLS95sCWs9g05qo3Ev0ErHwWI/41ZXtxtqACYxt6EjVM5WV7G+0qj
	 iUnPMRjaRtOyDN9HWpy2HWRxvaBXgc7XShCnbVPxjFfMAUPz4fZsMNGNyxuQk6YSpEij+
	 5ZtpOwsgXOI9QC0+BcYUBz/fgTgtIA0+ah1fvvDtAMz93CyRKoNsbCAfCuHQ3ipKGcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sbLdhSc5U9J/jxHyWnd4AxLJmzxGq1Euqj3lOEEmTkg=;
	b=Iy64g2Xuf4O9wPrpJBwjiNDeDr4gYMV5+1VOyx6cT2jtvqPEz5K83xiG2ilYnX0Tx4i3
	 zGNnwXpWNKZZU+3jA4ufbWMml74x7zv9qWDBVhrmwFdSCCQ9HUlxEiCs62e2YwE11ktcX
	 fiKG8Y20tiO46E0t3KxzZ+56wItugc801MAVOctIHtRi+4YVfMuXsNUgfW+kMHJ3DrFpL
	 byJprQYCI/2brZfRYyT030RWJOAa4+I3O7fiddAkHW/2kFHSF4ulHMQLBaZk1MFo9jqY8
	 hot1vspDD+6eqgklRXFO2BnGZsfcC9dg3nLIl0F3NHGjh+nwVC9SAyeIMVPGksDYhQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xHafV8Qv;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA2606A32E
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24DA2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xHafV8Qv
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b3541bb1a2so20575587b3.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 07:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794410255; x=1795015055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sbLdhSc5U9J/jxHyWnd4AxLJmzxGq1Euqj3lOEEmTkg=;
        b=xHafV8QvPAPS0wmqNcRvcX4vJ2/brD72r6SyMudAQpf6u8hDjeTktS2nrreEE/jbal
         NcnWc1ZNJKWf1PaG+jvqJalk+nZcKfSFO7GhSyWm5pv+I90fwTb/zJiCa654A7x6SIhd
         GfvppRqTWeQoRyIj4mp2JG3M5BbtamXSG+jkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410255; x=1795015055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sbLdhSc5U9J/jxHyWnd4AxLJmzxGq1Euqj3lOEEmTkg=;
        b=a6AtPLDT1M780b7up+SZcOLELjd/JHhxqHn60Eydf3AijUmJvmljQXeqOY+GNlhRGZ
         CxpM7b1ratllfcylHsJn4YATr0KRXDqwPkXtOOcg3kVl9iriJYgjByzUw3cAQL7DNXQY
         TjjzoiBhbsaf1vapLIjiWVTrTJbdqjCXKn7T90qFl2aRpqRBi6Q0TRTMqFHCR/uHQ2yi
         6NwfwpARHOnqGhmQeWl8+TbnQiyaNMvEtvHFeKwBRIeajlAvsN+9folNbScLccKJjvYU
         dzBrbw91GQ1oDTr10KXQLk8Kkxn+IJu2SX4acJRAAgETlLtoVbuG1F/W0sDXeO9xxoSk
         MvHA==
X-Gm-Message-State: APuU4Z9LlghacuLKnopgw6WVS8H/+/yfW3aHx/hkq+OmMiIDblHFyM7w
	nWDhmcrx5eIgtiKho5XNdGO2reAUylaY6GraVy9JpyVs/cOHfa8sCJZ/3WWuRZmz0UczbLvza4k
	+6cc=
X-Gm-Gg: AYBFou26YqJTDWDwJr7UmPH03VEJZEwE1AVjS8Et9bhF0TEVa66FvgH4b0oDay+yDST
	26r/Z3NwTk5M/gfTLSvdEr1jZEoSrVa8UiC6FcGmWlg/FQVJmOO2FyGLi/M5I7Q0g8BBYKkTl3Z
	mudgOY9aw29G7+HfyyyAxqCrejjViX6RJSY+qUOD1T4sAW7KEq0L+NP0MFm/XCPF34xAUG0pY6H
	4aYnjGAXo03GHT/lGrd09S6htSkRdnPjcm60BLSU0DR+QvYpJUKadzj1OlF7QfIBupwv1cMuGNH
	WMMh0XmsjPgfV+karHD4A576ujSQvFhQSycg4Hu3sbmOhOOCd0jwgsni1txPs9fNo+Sa0hpn3sF
	gbuiJu0QfYEUjX6X1wZqLEbrQuAegpWZsdJFD1HHoxZCxPH5TIypG1XlWwnwh9QEgtH43f+OBTq
	9++VqkYWzF7RB5z+hnV6QBUSLH9BoUlTCXN7hSGipk8gP92pJop5hByYqXZZyoE9ps2KJasgrcd
	R+/2uSzqi5MQtT+jh2aLGCXp7MyATo3qz+kMRkPRvHjvAAi2lInrtb8FcV7TXM0DKqQSNKrf4Gi
	8aAWHGLa5BtVNWB8MZJ/I+JKWq7QqLWIhAp8EMKVDSk3eHtTZWouuDXrmIKcjJ0bF6EVfAP5nuf
	3j1hT/vkXw5NMxw==
X-Received: by 2002:a05:690c:4484:b0:8b1:3606:65f6 with SMTP id 00721157ae682-8b3a81469bfmr17915477b3.64.1794410254970;
        Wed, 11 Nov 2026 07:17:34 -0800 (PST)
Received: from localhost.localdomain ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393409120sm46499187b3.27.2026.11.11.07.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:17:34 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net v4 0/3] net/sched: sch_teql: keep the transmit path's skb geometry and device lifetime intact
Date: Wed, 11 Nov 2026 10:17:27 -0500
Message-Id: <QDISC-6HS9.v4.r0.20261111094338@mojatatu.com>
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

Three pre-existing defects on the teql transmit path, all around
teql_master_xmit() -> teql_resolve(), plus the core helper they depend on
all derived from sashiko reports.

Patch 1 makes the headroom private before the slave's header write and
pulls back only the header that slave added, so a header-cloned skb is not
corrupted and a userspace-supplied link header survives a retry.

Patch 2 restores skb->dev at the arp-queue reinjection point when the
neighbour's device builds no link header. It is the neighbour half of the
version 3 patch 2, split out on review so it gets its own commit
log and its own Cc set; requested by Jakub.

Patch 3 moves skb->dev = slave ahead of teql_resolve() so a skb parked on a
slave's neighbour arp_queue names the device whose neighbour took it, and
so cannot outlive the master it came from.  With patch 2 in place it is
reinjected through the master and leaves with a link header.  Its commit
log carries the KASAN report the unfixed kernel prints when that queue is
drained.

Patch 3 is a follow-up to commit dc4b95b8fee9 ("net/sched: sch_teql:
restore skb->dev on the slave failure path") by Victor. Patch 1 is the
same commit's sibling on the successful-transmit path.

To prempt the sashikos:
- The pre-existing teql issues reported alongside this series are fixed
separately. For "the lower-qdisc drop use-after-free" see:
https://lore.kernel.org/netdev/QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com/

- For the pre-existing consumer nft/bpf complaint see:
https://lore.kernel.org/netdev/CORE-9NOG.v1.r0.20261111073528@mojatatu.com/
Note: nft/bpf combination _has never worked_: it is a producer-side
mismatch on two separate entry points, not a regression of anything here -
hence the net-next target.

Hope the sashikos read these and dont complain again about those issues.

Note also: part of the testing of patch 2 runs for packets that reach
neigh_xmit() from nft's `fwd ... neigh` statement, or from
bpf_redirect_neigh() with explicit nexthop parameters. Both keep the
route's dst attached while replacing skb->dev, so the neighbour that
queues the packet is not the one the dst names.

Changes v3 -> v4:
- patch 1, no code changes. Reviewed-by from Simon Horman stays, and a
  Link to the review of the v3 posting is added.
- patch 2 is new: the net/core/neighbour.c hunk of the v3 patch 2 is split
  out into its own fix, with the neighbour maintainers Cc'd.  Asked for on
  the v3 posting by Jakub.
- patch 3 is the v3 patch 2 with that hunk removed; the sch_teql change is
  unchanged in approach. Reviewed-by from Simon Horman stays.

Changes v2 -> v3:
- patch 1, no code changes.
- patch 2 corrects the conditions to recreate the bug: reaching a freed
  master needs sch_teql built as a module, the slave qdisc removed and the
  module unloaded while the skb still waits.  The message now says which
  part of it reproduces without the unload, and names the neighbour failure
  path that drains the same parked skb.  Considered comments from
  Sashiko (nipa).

Changes v1 -> v2:
- patch 1, no code changes.
- patch 2 limits the reinjection restore to a top-level neighbour whose
  device has no header_ops, the shaper/eql/sch_teql class.  Commit message
  also describes how a master is freed.  Considered comments from
  Sashiko (nipa) and Sashiko (gemini).

Jamal Hadi Salim (3):
  net/sched: sch_teql: unshare the header before writing and fix retry
    strip
  net: neighbour: reinject a parked skb through a headerless output
    device
  net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

 net/core/neighbour.c |  3 +++
 net/sched/sch_teql.c | 26 ++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
-- 
2.43.0
