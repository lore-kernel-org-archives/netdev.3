Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6248A2BE
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634483; cv=none; b=i8PUQwj+/xVHS8iNwJpdCgmYjfrcXWea1+1lCYAeMWBEjGMf1s82yh0m55ifo3Jgdiy/gHyCQaxfKVfGUGJt4bV/li+4dc6pmGh01lPIIovTQjmT4kv9iZj3BURiIy9KdBRRoGkxs6OiFJTy6gPRH4rrq+qroczb+OgoCBmsO/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634483; c=relaxed/simple;
	bh=d3V5Hbd/KZt9N1OaPXtUgu8WevrOR6Kin5ffkNJUh/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VoH2nf1cuKE0ZhgVoKmvCgwdA0GPMQEk8q6FDPwyuMiinWAPkN+9CusqHFCPwmZU52smOXGBt4zrzOqgzHeY6KFn7diPoYVEGw2VN8wllIp5A+ALuSpmdGCts38KY5+e3WNUF2qpa/5CM8v2UWDK0DKv+cAAfiAgJwPEG8gE5jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbQSq8sv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbQSq8sv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786634480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T7qog77zbi17eAiUUuM+1tIPrWDtkLc5xZGsOWN2FLU=;
	b=BbQSq8svbxMOWBAD3rlPG5exR7AMGI80nK3of+OSpukRU7dhXc4WY6ACszLxHfO11VqKE8
	tGP8zmIGthKbVnXA8bwMHW2GoHNDMHv/E5b2SdP+A+ymyogQcIUYerZ5UKT/hHMn96mMaX
	K8bJd3AdjMuhO3atebOnoroqyjTxdJU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-pZHyJjbWOvGYEHfUtxFqeg-1; Thu,
 13 Aug 2026 11:21:14 -0400
X-MC-Unique: pZHyJjbWOvGYEHfUtxFqeg-1
X-Mimecast-MFC-AGG-ID: pZHyJjbWOvGYEHfUtxFqeg_1786634472
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA66B1800652;
	Thu, 13 Aug 2026 15:21:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D612730001A2;
	Thu, 13 Aug 2026 15:21:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.2-rc8
Date: Thu, 13 Aug 2026 17:21:04 +0200
Message-ID: <20260813152104.256382-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Linus!

The following changes since commit 315f4bd234b3b8a3ed3a71fd4c53b110cf373720:

  Merge tag 'net-7.2-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-08-06 11:39:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc8

for you to fetch changes up to 9006c116dd111d457bf5d074990210f70a4ad2c8:

  l2tp: fix tunnel and session refcount leak on seq_file release (2026-08-13 11:49:31 +0200)

----------------------------------------------------------------
There is a known WiFi/mt76 regression, waiting for a complete fix that
should land soonish.

Including fixes from netfilter.

Previous releases - regressions:

  - tcp: fix icsk_ack.ato bitfield overflow

  - af_unix: Unlink scc_entry in unix_del_edge().

  - ipv4: fix use-after-free in fib_nhc_update_mtu()

  - netfilter:
    - ipset: fix refcount race between list:set GC and swap
    - nf_tables_offload: suppress WARN_ON_ONCE for ENOMEM in abort path

  - sched: act_ct: fix sk_buff leak when the header checks reject a packet

  - sctp: clear new_transport when removing a peer

  - dibs: correct freeing of dmb_clientid_arr

  - ovpn: fix NULL dereference when killing missing key

  - eth: veth: fix queue index used to wake the peer txq in veth_poll

  - eth: ngbe: fix NULL pointer dereference in non-MSI-X interrupt enabling

  - eth: gve: fix zero-length skb frag with header-split

Previous releases - always broken:

  - core: fix skb length accounting after generic XDP frag adjustment

  - af_packet: don't send zero-byte data in tpacket_snd().

  - eth: bnxt: avoid deadlock when canceling IRQ affinity notifier

  - eth: ipvlan: inherit needed_headroom and needed_tailroom from phy_dev

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexandra Winter (1):
      net/dibs: Correct freeing of dmb_clientid_arr

Alexey Velichayshiy (1):
      netfilter: nf_tables_offload: suppress WARN_ON_ONCE for ENOMEM in abort path

Baul Lee (1):
      vxlan: do not arm the ageing timer on a device that is down

Chengfeng Ye (1):
      ipv4: fix use-after-free in fib_nhc_update_mtu()

Christoph Paasch (1):
      mailmap: add entries for Christoph Paasch

Chuck Lever (2):
      net/tls: Fail tls_sw_splice_read() after a failed async decrypt
      selftests: tls: cover splice after a failed decrypt

Eric Dumazet (4):
      ipvlan: inherit needed_headroom and needed_tailroom from phy_dev
      macvlan: inherit needed_headroom and needed_tailroom from lowerdev
      af_packet: Don't send zero-byte data in tpacket_snd().
      l2tp: fix tunnel and session refcount leak on seq_file release

Florian Westphal (3):
      netfilter: nfnetlink_log: wait for rcu grace period before freeing pernet state
      netfilter: ipset: fix list type element drift bug
      netfilter: ipset: let destroy callbacks adjust ext mem size

Hyunjung Ko (3):
      net/sched: act_gact, act_police: range check the fallback control action
      net/sched: act_ct: fix sk_buff leak when the header checks reject a packet
      selftests: tc-testing: add act_ct test for malformed header handling

Jakub Kicinski (10):
      Merge branch 'fix-skb-length-accounting-after-xdp-frag-adjustment'
      eth: bnxt: cancel IRQ notifier before freeing affinity mask
      eth: bnxt: keep the aRFS rmap updated when TPH is enabled
      eth: bnxt: decrease indent in bnxt_request_irq()
      eth: bnxt: avoid deadlock when canceling IRQ affinity notifier
      Merge branch 'eth-bnxt-fix-irq-notifier-bugs'
      net: expect instance lock in netdev_queue_get_dma_dev()
      Merge branch 'gve-bug-fixes-for-header-split-and-ptp'
      Merge tag 'nf-26-08-10' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'ovpn-net-20260809' of https://github.com/OpenVPN/ovpn-net-next

Jamal Hadi Salim (2):
      net/sched: act_api: fix TOCTOU NULL deref on a->goto_chain
      net/sched: cls_bpf: reject dev-bound programs bound to a different device

Jiawen Wu (1):
      net: ngbe: fix NULL pointer dereference in non-MSI-X interrupt enabling

Jiayuan Chen (1):
      tcp: fix icsk_ack.ato bitfield overflow

Jonas Köppeler (1):
      veth: fix queue index used to wake the peer txq in veth_poll

Jordan Rhee (2):
      gve: fix zero-length skb frag with header-split
      gve: fix NULL dereference due to missing ptp adjfine

Julian Anastasov (3):
      ipvs: add totalconns for dest
      ipvs: properly update the overload flag on dest edit
      ipvs: revalidate ihl to prevent out-of-bounds access

Jun Yang (1):
      tipc: read le->link under the node lock in tipc_node_link_down()

Jérémy Jean (2):
      sctp: validate cookie AUTH state before use
      netfilter: flowtable: publish GC-visible tuple last

Koichiro Den (1):
      NTB: ntb_netdev: Preserve RX queue depth on allocation failure

Kuniyuki Iwashima (1):
      af_unix: Unlink scc_entry in unix_del_edge().

Kyle Zeng (1):
      ipvs: clear IPv4 options after rebasing tunnel ICMP errors

Oleksij Rempel (1):
      net: phy: realtek: fix EEE advertisement write on the internal PHY MMD path

Paolo Abeni (2):
      Merge branch 'fix-wrong-transport_header-when-sending-vlan-tagged-frames'
      Merge branch 'net-tls-fail-splice-after-a-failed-async-decrypt'

Qing Ming (1):
      sctp: clear new_transport when removing a peer

Ralf Lici (4):
      ovpn: fix NULL dereference when killing missing key
      ovpn: finish crypto callback cleanup before peer release
      ovpn: run deferred work on a module-owned workqueue
      ovpn: defer key slot crypto freeing to workqueue

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix port_id extraction from SRC TAG

Sun Jian (2):
      net: fix skb length accounting after generic XDP frag adjustment
      veth: fix skb length accounting after XDP frag adjustment

Wei Fang (2):
      net: packet: fix wrong transport_header when sending VLAN-tagged frame
      net: tap: fix wrong transport_header when sending VLAN-tagged frame

Xiang Mei (Microsoft) (1):
      netfilter: ipset: fix refcount race between list:set GC and swap

Yizhou Zhao (1):
      ipvs: separate destination availability state

Yuxiang Yang (1):
      sctp: fix use-after-free of cached ASCONF chunk

Zhang Changzhong (1):
      net/sched: cls_u32: skip hash tables in u32_bind_class()

Zhiling Zou (1):
      netfilter: bridge: release template ct on non-IP path

Zihan Xi (1):
      netfilter: nf_conntrack: defer invalid log until after unlock

 .mailmap                                           |   4 +
 drivers/dibs/dibs_loopback.c                       |   1 -
 drivers/dibs/dibs_main.c                           |  14 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 131 +++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   3 +
 drivers/net/ethernet/google/gve/gve_ptp.c          |   6 +
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |   5 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |   4 +-
 drivers/net/ipvlan/ipvlan_main.c                   |   4 +
 drivers/net/macvlan.c                              |   4 +
 drivers/net/ntb_netdev.c                           |  15 +--
 drivers/net/ovpn/crypto.c                          |  26 ++--
 drivers/net/ovpn/crypto.h                          |   4 +-
 drivers/net/ovpn/crypto_aead.c                     |  19 ++-
 drivers/net/ovpn/crypto_aead.h                     |   1 -
 drivers/net/ovpn/io.c                              |  10 +-
 drivers/net/ovpn/main.c                            |  19 ++-
 drivers/net/ovpn/ovpnpriv.h                        |   4 +
 drivers/net/ovpn/peer.c                            |   8 +-
 drivers/net/ovpn/tcp.c                             |   9 +-
 drivers/net/phy/realtek/realtek_main.c             |   2 +-
 drivers/net/tap.c                                  |   3 +-
 drivers/net/veth.c                                 |  24 ++--
 drivers/net/vxlan/vxlan_core.c                     |   2 +-
 include/net/act_api.h                              |  19 +++
 include/net/ip_vs.h                                |  29 ++++-
 include/net/route.h                                |   2 +
 include/net/sctp/auth.h                            |   3 +
 include/uapi/linux/ip_vs.h                         |   6 -
 net/bridge/netfilter/nf_conntrack_bridge.c         |   1 +
 net/core/dev.c                                     |  10 +-
 net/core/netdev_queues.c                           |   2 +-
 net/ipv4/fib_semantics.c                           |  34 ++----
 net/ipv4/route.c                                   |  29 +++++
 net/ipv4/tcp_input.c                               |   6 +-
 net/ipv4/tcp_timer.c                               |   4 +-
 net/l2tp/l2tp_debugfs.c                            |   4 +
 net/l2tp/l2tp_ppp.c                                |  56 ++++++++-
 net/netfilter/ipset/ip_set_bitmap_gen.h            |   2 +-
 net/netfilter/ipset/ip_set_core.c                  |  19 ++-
 net/netfilter/ipset/ip_set_list_set.c              |  10 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |  45 +++----
 net/netfilter/ipvs/ip_vs_core.c                    |  18 ++-
 net/netfilter/ipvs/ip_vs_ctl.c                     |  81 ++++++++++---
 net/netfilter/ipvs/ip_vs_dh.c                      |   4 +-
 net/netfilter/ipvs/ip_vs_lblc.c                    |   2 +-
 net/netfilter/ipvs/ip_vs_lblcr.c                   |   8 +-
 net/netfilter/ipvs/ip_vs_lc.c                      |   4 +-
 net/netfilter/ipvs/ip_vs_proto_sctp.c              |   2 -
 net/netfilter/ipvs/ip_vs_proto_tcp.c               |   2 -
 net/netfilter/ipvs/ip_vs_sync.c                    |   7 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |   7 +-
 net/netfilter/nf_conntrack_proto.c                 |   6 +
 net/netfilter/nf_conntrack_proto_sctp.c            |  12 +-
 net/netfilter/nf_conntrack_proto_tcp.c             | 132 ++++++++++++++-------
 net/netfilter/nf_flow_table_core.c                 |   7 +-
 net/netfilter/nf_log_syslog.c                      |   4 +-
 net/netfilter/nf_tables_offload.c                  |   2 +-
 net/netfilter/nfnetlink_log.c                      |  13 +-
 net/packet/af_packet.c                             |   7 +-
 net/sched/act_api.c                                |  10 +-
 net/sched/act_ct.c                                 |  29 ++++-
 net/sched/act_gact.c                               |   5 +
 net/sched/act_police.c                             |   6 +
 net/sched/cls_bpf.c                                |  18 ++-
 net/sched/cls_u32.c                                |   3 +
 net/sctp/associola.c                               |   7 +-
 net/sctp/auth.c                                    |  75 ++++++++++++
 net/sctp/sm_make_chunk.c                           |   3 +
 net/sctp/sm_statefuns.c                            |   6 +-
 net/tipc/node.c                                    |  15 ++-
 net/tls/tls_sw.c                                   |   5 +
 net/unix/garbage.c                                 |   1 +
 tools/testing/selftests/net/tls.c                  |  75 ++++++++++--
 .../selftests/tc-testing/tc-tests/actions/ct.json  |  40 +++++++
 76 files changed, 894 insertions(+), 327 deletions(-)

