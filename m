Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB24745198C
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773438; cv=none; b=d+MIqmeIHAdCQl2wfqBJPgZTzgydNW5uz+SgQdPa5i+Oko9jFJDWwSCBYDUap+Ubva5+rS7Sj1NWE3ww//4V/zZVcVEc3XbSnZTqfAXU8H4YB+L9GmEWEvGXRPeXpmQ8Dn+hzleec9YIHLS8tN3BGWXELwsaZaJCoS/PpfSIeGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773438; c=relaxed/simple;
	bh=rsjuVEE10oQziZ/1SjWUNM86nZzk9xidpVknTMFunJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eRof+RNAboa30w0djXyxoD+b+4rnwQFXft0XI7MZ3sYoQiVBXWzCJ8uR9WCLO+j9ChTsCJq0W1DaGNmtXunuzE218awg1A/iwd5r4UufNoyksB6+FFpixqvi2WSUHpSSVCbZMSBLBnr7C/2ZxrLi6ySN2VUx2OEu3qw+EFuP3DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=JQwxBmn/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="JQwxBmn/"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 37FA02074F;
	Mon,  7 Sep 2026 11:30:27 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VbFrNWB8z9Cp; Mon,  7 Sep 2026 11:30:26 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 777E820719;
	Mon,  7 Sep 2026 11:30:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 777E820719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788773426;
	bh=r+D5lZPWAfdWMliIuNeIQ1M3oW0umr9EM12aVRzTlt4=;
	h=From:To:CC:Subject:Date:From;
	b=JQwxBmn/Akp2btN4B1lHHChByi7y6u0B2J+t5UnXrpSrHtYzNq4VsehLYDpbbDe//
	 NA8ZD4G0+AJB8tWYwz0IBKFxkzf/UJ3G7AnD/mY1XDIaDRUFGhKd6OhDyZg55/JXJE
	 DxkXJNH1/abMl+XGpdW/f1YB0Wo/7sNcbZ0L92pn7HyR5EzoLq3o6z182/B8ad6WqH
	 TJJW7LnKrQAVB18IjhnJEztfMINtXoNgQegZHt1K5UQ63S9uB/GrwUI91SIW+mjCns
	 Bxn8rB1SQqi6xIhpRFdkQUiQQY2wZ/lMFlViHCQvOE2kaPxZfD+vzkE3d0DTfJ9lXw
	 859VXg4PKR2kA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 7 Sep
 2026 11:30:25 +0200
Received: (nullmailer pid 2228798 invoked by uid 1000);
	Mon, 07 Sep 2026 09:30:24 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/12] pull request (net): ipsec 2026-09-07
Date: Mon, 7 Sep 2026 11:29:43 +0200
Message-ID: <20260907093020.2228346-1-steffen.klassert@secunet.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2026-09-07

for you to fetch changes up to 96f01b53c2d05e003b040892256de54a586e8529:

  net: xfrm: reject unrepresentable espintcp transport headers (2026-09-01 12:24:11 +0200)

----------------------------------------------------------------
ipsec-2026-09-07

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
