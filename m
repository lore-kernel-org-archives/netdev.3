Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93E74DF4AE
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789553998; cv=none; b=awRaMQVSDxDy/Qkzynh4emCqb+H2kGxbuZ7WaNx/reCeBDiwps3uqLvlaDMVZF59XUFy04cPnqxEnrmbGXLJ2/GmheiI8l+eAoHWpj1axo4GhXC3Cv5S2RKh+0LWmnbGxvxo7fyupaNaF01j4PZeR9UDRto8ASbb6Q9MiyjkcL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789553998; c=relaxed/simple;
	bh=N7ONTTfEaKCvWqhntNZZwHfHT7b6KJc2pzlYrgeairg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sBKfUufNwI2n5QucfiWhIw5N2cIfdeCpE3qdjCNSY7ftdT4ML8gmmp7/4+JUN10n9COcI0aS4TXrSBGgtYUWkH2PGx0gjIjJXmz6uANLdsELDVU4wp1VNS8gyog/2xycZs6G0oJAqXWbPVOF29y4uZ2VHc5fCGIWeYGRAXwvkok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=qFkGw+3/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="qFkGw+3/"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B79B92085B;
	Wed, 16 Sep 2026 12:19:49 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id InH1-3v-jBm2; Wed, 16 Sep 2026 12:19:49 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 08ED4207E4;
	Wed, 16 Sep 2026 12:19:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 08ED4207E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789553989;
	bh=z6rVarM926PlihBoNQWXlNn3vDr/fhh9Y/R0L7aB+8k=;
	h=From:To:CC:Subject:Date:From;
	b=qFkGw+3/7ZkfNwwPF32WIfqJv5PvVka5cZYOfYxO7ftowVWeZODZ3rIdaNfckPBkd
	 40+byVmZWp5BylgOGxVHacHb3vGXbLPB8wv5swqPwcuzAGBAZEa+LDgDCPDppMnPhL
	 itLsfQvV1N8EEJSo0Vaa2X3VpbUN78MD/gY3s1z5WpLL0ebsQemOs8+XRNkrHuHV94
	 lxs2tjpQN+UVp6TdOXtbIr/QXNFaXKLdgPTuJQ6GOGiAxwSWkLhqW9x9QWwQu2iIM1
	 Pn039UMoZ3hOi5ERu3W9X71xA3aGFenL3Hm2vVpNhP1TGHgRRWlLhH2e8hIrHTWxd/
	 BJU6MMgrUH0+A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 16 Sep
 2026 12:19:48 +0200
Received: (nullmailer pid 118888 invoked by uid 1000);
	Wed, 16 Sep 2026 10:19:47 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: pull request (net): ipsec 2026-09-16
Date: Wed, 16 Sep 2026 12:19:29 +0200
Message-ID: <20260916101938.118628-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

1) xfrm: iptfs: fix stack OOB read in iptfs_skb_reset_frag_walk()
   Add the up-front nr_frags guard iptfs_skb_add_frags() already has,
   so an out-of-range offset can't walk past the on-stack frags[] array.

2) xfrm: serialize state GC with device state flush
   Serialize xfrm_state destruction against the deferred-device pass
   with a dedicated mutex, since the device GC list doesn't hold a state
   reference and the two paths could free the same state.

3) xfrm: add missing RCU read lock in xfrm_send_migrate_state()
   Hold the RCU read lock around xfrm_nlmsg_multicast() so the
   rcu_dereference() of net->xfrm.nlsk doesn't warn.

4) xfrm: iptfs: fix runt reassembly panic from short inner tot_len
   Require the runt length to cover at least the minimum IP header,
   so a tot_len in [6, 19] (IPv4) can't write past the declared length
   and trip skb_over_panic().

5) ipv6: xfrm: use full sockets in local error paths
   Use skb_to_full_sk() in xfrm6_local_rxpmtu() and xfrm6_local_error()
   and bail out without a full socket, so a TCP_NEW_SYN_RECV request_sock
   isn't miscast as a full inet/IPv6 socket.

6) xfrm: fix compat ALLOCSPI request use-after-free
   Drop the redundant alloc_compat() in xfrm_alloc_userspi() so the
   compat translator no longer reads past the payload and publishes a
   child a multicast clone can still see after xfrm_user_rcv_msg() frees.

7) xfrm: add missing rcu_read_lock(), skb_dst_force() and dev_hold() for xfrm_trans_reinject()
   Force the dst before queuing, hold dev across the workqueue deferral,
   and take rcu_read_lock() around the finish() loop, so transport-mode
   reinjection doesn't deref non-refcounted dst/dev under workqueue.

8) xfrm: use hlist_del_init_rcu for state_cache and state_cache_input
   Switch to hlist_del_init_rcu() so a second __xfrm_state_delete() is
   a no-op instead of writing through LIST_POISON2, closing the UAFs.

9) esp: downgrade zerocopy managed frags before mutating skb frags
   Call skb_zcopy_downgrade_managed() before ESP rewrites the skb frag
   array, so per-frag unrefs in esp_ssg_unref() and skb_release_data()
   stay balanced for ubuf-owned managed frags.

10) xfrm: hold net_device reference under RCU in bundle creation
    Read dst->dev via dst_dev_rcu() and keep RCU active through
    xfrm_fill_dst(), so a concurrent RTM_DELLINK can't free dev
    under bundle creation.

11) xfrm: save input state data before secpath resets
    Save the state protocol on the stack while it's still valid and
    use the saved address family for transport_finish(), so post-reset
    dereferences (VTI, XFRM if, MAX_DEPTH error) can't UAF the state.

12) net: xfrm: reject unrepresentable espintcp transport headers
    Use the careful transport-header helper and drop the skb through
    the XFRM error path when the offset can't be represented, instead
    of silently truncating it.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 4e9442ce551ebd84b52ad649df721e2dc28af95a:

  xfrm: bound nat keepalive state collection (2026-08-18 07:35:01 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2026-09-16

for you to fetch changes up to 96f01b53c2d05e003b040892256de54a586e8529:

  net: xfrm: reject unrepresentable espintcp transport headers (2026-09-01 12:24:11 +0200)

----------------------------------------------------------------
ipsec-2026-09-16

----------------------------------------------------------------
Aleksandr Nogikh (1):
      xfrm: add missing RCU read lock in xfrm_send_migrate_state()

Cen Zhang (Microsoft Security FORGE Labs) (1):
      xfrm: hold net_device reference under RCU in bundle creation

Chengfeng Ye (1):
      xfrm: serialize state GC with device state flush

Eric Dumazet (1):
      xfrm: add missing rcu_read_lock(), skb_dst_force() and dev_hold() for xfrm_trans_reinject()

Henry Martin (1):
      xfrm: iptfs: fix runt reassembly panic from short inner tot_len

Kyle Zeng (1):
      xfrm: fix compat ALLOCSPI request use-after-free

Maher Azzouzi (1):
      esp: downgrade zerocopy managed frags before mutating skb frags

Roshan Kumar (1):
      xfrm: iptfs: fix stack OOB read in iptfs_skb_reset_frag_walk()

Siwei Zhang (1):
      xfrm: use hlist_del_init_rcu for state_cache and state_cache_input

Wyatt Feng (1):
      net: xfrm: reject unrepresentable espintcp transport headers

Zhiling Zou (2):
      ipv6: xfrm: use full sockets in local error paths
      xfrm: save input state data before secpath resets

 net/ipv4/esp4.c         |  6 ++++++
 net/ipv6/esp6.c         |  6 ++++++
 net/ipv6/xfrm6_output.c | 10 ++++++++--
 net/xfrm/espintcp.c     |  6 +++++-
 net/xfrm/xfrm_input.c   | 22 +++++++++++++++++++---
 net/xfrm/xfrm_iptfs.c   | 12 ++++++++++--
 net/xfrm/xfrm_policy.c  | 20 +++++++++++++++-----
 net/xfrm/xfrm_state.c   |  9 +++++++--
 net/xfrm/xfrm_user.c    | 18 +++++-------------
 9 files changed, 81 insertions(+), 28 deletions(-)
