Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801479;
	b=PZJIvqugh8UD+8hcXLfJIq+MAxB6qxRNpLtxxaS+uWt9xlyVJfeK789i1NQnvQfxZdJK
	 GGHl2tJcas1EddCLXBZUdHpGABqRv9hNSP5JdO3W2m3HrAyXxgfuQM2uf2xiT/pc/AZO6
	 /dZrqbFkVJ8y6CS6G6PT3DnAPcNkGsm3rjtH2NCKRih/7k8EfpJkFS7uXMrwYHwgK7CRr
	 fHOb4prtpSMY+veZtmE7WRMwRmNQB2Lsdl6Wat/+i84QQaRIS8kc6t3K/RRCl6g/Hzwgm
	 Wx8aK63ekKgygqmDKcQj2sUtA9Ew6xhBrAEFPLHJ6Xkn/bmfCPDyqTgtSEvrwQ+eVWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801479;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=0IzRZI1EYcAR+rnJDb9O7CuuunEacG6iwjyH3nTpCUg=;
	b=f0nk42l7vkYyqdbf9xZBeNbZl88cI7PY5plGbDuRu5D8OTzVMbpr/SiOrrpsfWQezl4K
	 F1WGMbTo8WBPUDIm3lzBqQ3NGQ6uS9nCWg4e4pEB3/Ayv9Z6j/Svks3BOXdI4szel6uP4
	 KRDn6tYoLj2h1nMwSyML40t80Ot9wlBWo4SWQ/RmAlKWmWZ9ghSbiVh2DE+heJN2IqTLZ
	 VKH/zk0edGk2lI2S3gnmCgugs+7zHOirHkELiqwwmD1/NL4sIhfulhTBoGQfs/A5UAKwf
	 6zQqb300WFHavVPnf2RCY9S1XiCRVwgk5dgG4yn+V1vNK/lGCrYa4t/EwZKq9kdsIHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=cSsCNJem;
	arc=none smtp.remote-ip=220.197.31.9
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E898606A333
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 14:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E898606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=cSsCNJem
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=0IzRZI1EYcAR+rnJDb9O7CuuunEacG6iwjyH3nTpCUg=;
	b=cSsCNJemmiKANx65mI09gC4jemYNAiF52pkbghI2Lo+UZUIIJRqdZTyfJY6pws
	ivJgmGW6CU/M/QPVwCBPEWT5TyGxls4nj7kIm0yncmUCwztOG4OrGTUn5xoO6puw
	fszGpqhTe/lgquyaRpCTU/2kvj41eVKFjAKuPg9GZRDng=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3PxzEPOtqyHU0Cg--.5199S2;
	Wed, 04 Nov 2026 22:10:13 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: edumazet@kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@google.com,
	horms@kernel.org,
	sashiko-bot@kernel.org,
	liuhangbin@kylinos.cn,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH net] tcp: ipv6: free ireq->ipv6_opt after an RCU grace period
Date: Wed,  4 Nov 2026 22:10:10 +0800
Message-Id: <20261104141010.2290568-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103090011.4128420-1-edumazet@kernel.org>
References: <20261103090011.4128420-1-edumazet@kernel.org>
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
X-CM-TRANSID:_____wD3PxzEPOtqyHU0Cg--.5199S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyrXF1UJF1fJr1DJrWrXwb_yoW5Kw18pF
	Zaqry2vrWDJ34UGr4xZa18C3s3Z3WSyFW7Cry8tr12yw1rWr1xtFW2q3W09FWYgrWrGFW3
	Jrs0g343Ar1DAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEEfO3UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqAXVrGrrPMX3gQAA3a

From: Linkui Xiao <xiaolinkui@kylinos.cn>

Hi Eric,

I wrote a reproducer for this and ran it on both sides of your patch.

Setup
-----
v7.4-rc1 (6628e7d4c6b) on an x86_64 VMware guest with 2 vCPUs,
CONFIG_KASAN=y (generic), CONFIG_SLUB_DEBUG=y, PREEMPT_LAZY. The working
tree only carries the instrumentation described below and your patch (it
reports itself as 7.4.0-rc1-dirty); nothing else differs between the two
runs.

ireq->ipv6_opt has a single in-tree producer (calipso_req_setattr()),
which needs CALIPSO + NetLabel + an MLS SELinux policy, so to keep the
test self-contained I added a debug-only patch, never meant for upstream,
that

  - allocates a fake ipv6_txoptions in tcp_v6_route_req() and stores it
    in ireq->ipv6_opt, i.e. exactly the slot calipso_req_setattr() fills;
  - does an mdelay() inside the rcu_read_lock() section of
    tcp_v6_send_synack(), right after "opt = ireq->ipv6_opt;".

The trigger is a SO_REUSEPORT listener group on ::1 with
net.ipv4.tcp_migrate_req=1: a crafted SYN from a raw socket, a second
listener joining the group, the first one closing so that the request
socket migrates and the clone takes over ipv6_opt, the second listener
closing, and a retransmitted SYN then handled on the other CPU while that
CPU sits in the (deliberately widened) RCU section.

The instrumentation also makes the two sides measurable, which is what
the timestamps below come from: the reader is parked for 3.2s with the
pointer already in a local variable, and the destructor runs in the
middle of that window.

Without your patch
------------------
  t+0.30s  SYNACK #2 on CPU1: rcu_read_lock(), opt = ireq->ipv6_opt,
           then stalled for 3.2s
  t+1.00s  reqsk_timer_handler(): oreq is migrated to the second
           listener, inet_reqsk_clone() makes the clone share ipv6_opt,
           reqsk_migrate_reset(oreq) clears oreq's pointer
  t+3.09s  the clone's timer fires with no listener left to migrate to:
           __reqsk_free() -> tcp_v6_reqsk_destructor() -> kfree()
  t+3.51s  CPU1 resumes and ip6_xmit() reads the options

  BUG: KASAN: slab-use-after-free in ip6_xmit+0x1301/0x19a0
  Read of size 2 at addr ffff88801497908a by task poc/5786
  CPU: 1 UID: 0 PID: 5786 Comm: poc
  Call Trace:
   <IRQ>
   ip6_xmit+0x1301/0x19a0
   tcp_v6_send_synack+0x631/0xbe0
   tcp_rtx_synack+0x116/0x4a0
   tcp_check_req+0xb37/0x23c0
   tcp_v6_rcv+0xfff/0x34a0
  ...
  Freed by task 0 on cpu 0:
   kfree+0x1b1/0x510
   tcp_v6_reqsk_destructor+0x37/0x70
   __reqsk_free+0xd4/0x230
   reqsk_timer_handler+0x83a/0xe10
  ...
  The buggy address belongs to the cache kmalloc-96 of size 96

The dereference lands 416 ms after the free here, which is what makes the
ordering unambiguous; in a real deployment the window is a few
instructions wide, but nothing else changes.

With your patch
---------------
Same parameters, two rounds: the timeline does not move at all (the
destructor still runs at t+3.09s, the reader still dereferences the
pointer at t+3.51s) and there is no report whatsoever. kfree_rcu()
cannot complete a grace period while CPU1 is inside rcu_read_lock(),
which is what the changelog says.

(Note that KASAN reports only once per boot unless kasan_multi_shot is
set, so on the unpatched kernel the second round is silent by
construction. The fixed kernel being silent from the very first round is
the part that matters.)

If you end up respinning for the pktopts issue Sashiko raised, I can
re-run this on the new version. The reproducer and the debug-only patch
are easy to share if anyone wants to look at them.

Tested-by: Linkui Xiao <xiaolinkui@kylinos.cn>

