Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0971A48664A
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051796; cv=none; b=vCmtMwv2nkFWJRhhULC2tYCvK4kdxb9yZtqj0oZ5PgwRuRSJBlxx/ZQj4LFDPjRF5Lt9DyuAIAUwGZx/USQhkR0Jroj8VbzCPmTu240zWPC0CykEmpvTUpzeP4ihySX7J1WoM3NyLfBY/nH0C6yqGNjXnzwuXAoThsfSDRoeaEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051796; c=relaxed/simple;
	bh=+yJRMNvcC4IN4sL3nZkMzTwHcfwGR6nv0JHSeulh/8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+jBDcpnzVCYzLIud7pJMuTdW/g9t59IV6pRyT7M+J7NLZss4b4seshA4YL+dcQAgGhDZ6BM11MExjGMy+tuEUkQ0UiGs0dKpvfiuKMxFZsO24cwK0n7RAxqZfKm+pLOQACwwD+OfwDw1WumfgRHVyFr7RjBvEBZev85VMVapQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IEXyCYrv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FeCn1xCN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c0o+zGe8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3BSI9/hq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IEXyCYrv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FeCn1xCN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c0o+zGe8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3BSI9/hq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C207E21B64;
	Thu, 10 Sep 2026 14:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789051788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ewDA92rRPajPzk464++eraFrXGFY2rnlu76t49q5a8o=;
	b=IEXyCYrv4TC6Z0YIKQEV0OmopwKU24iMqtSqCgb8OrEgSBl7jriRqCC6tCm7bEQ5noOYNs
	bSEUgfsyKbj6htimDV39Qi4IBBvlyytvvSXfa0ZZW86A6lAfo6gtfSnd/DPy3b9eT+cDBi
	OhaGSHsqI3c0zOEej8RZAt4kSS60txo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789051788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ewDA92rRPajPzk464++eraFrXGFY2rnlu76t49q5a8o=;
	b=FeCn1xCNX3lLVgf6fcWYwP8fjF2BvBt+VgWoZYFgXDhsddue5szzrXn/NV+Gs49HTX6NXD
	svWqH25z95092aBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789051784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ewDA92rRPajPzk464++eraFrXGFY2rnlu76t49q5a8o=;
	b=c0o+zGe8fwE0SU0iWDH2AgupaAjg8puFZmNzfK8JA1/c1QbWMKqCPRYYTWWSbsANZswGHn
	qZjNhRFImN2o5qvhAthXqJuT3DlX8+mms4Bi14q6Q/ZNU2rZAwbwIde4GiH0l52TQPJOCQ
	aGUgLYli31qVjQkZrabXkQtbgvdOw7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789051784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ewDA92rRPajPzk464++eraFrXGFY2rnlu76t49q5a8o=;
	b=3BSI9/hqts8PEa5P9eYpRYDNP34a/L+gWOYEi3/HwZwVZN3HvPgomXrsxcDJFOrLPfMl22
	gKdL9exyQQeamxCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3795D13180;
	Thu, 10 Sep 2026 14:49:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H4vLCojDomogZwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 10 Sep 2026 14:49:44 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 00/13 net-next] Allow compiling an IPv6-only kernel network stack
Date: Thu, 10 Sep 2026 16:48:25 +0200
Message-ID: <20260910144914.8025-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

The primary goal of this patch series is to enable the compilation of an
IPv6-only kernel by decoupling the core networking infrastructure from the IPv4
protocol.

Historically, IPv4 has been intertwined with the generic socket and transport
layers. By untangling these dependencies, this series allows systems to be
built with CONFIG_IPV4 disabled. This configuration targets strict IPv6-only
deployments, constrained environments, and specialized appliances where
removing the IPv4 subsystem reduces the network attack surface.

To achieve this, subsystems with hard dependencies on IPv4 were modified to use
conditional compilation guards. When CONFIG_IPV4 is disabled, the affected
packet manipulation routines and routing hooks evaluate to stubs returning
standard error codes. The INDIRECT_CALL_INET macros within the transport layer
were adapted to safely bypass IPv4 function pointers without penalizing the
dual-stack fast paths. In addition, there has been several code splits for UDP,
RAW, ICMP or Ping isolating the IPv4 specific code.

Finally, CONFIG_IPV4 is exposed in Kconfig as an explicit boolean, defaulting
to 'y' to preserve existing configurations.

The bloat-o-meter diff for x86_64 with dualstack and IPv6 disabled:
   
   text    data     bss     dec     hex filename 
31211950        8946390 1121076 41279416        275dfb8 vmlinux.dual 
27464679        8008670 1069040 36542389        22d97b5 vmlinux.ipv6

add/remove: 52/25057 grow/shrink: 58/565 up/down: 937258/-4632671 (-3695413)

Performance testing:

Basic TCP performance validation was conducted using iperf3 on an AMD Ryzen 9
9950X between two bridged virtual machines. These benchmarks verify that there
are no obvious performance regressions.

Kernel / Configuration            Traffic Type    Offloads ON     Offloads OFF
-------------------------------------------------------------------------------
net-next (Dual-Stack Baseline)     IPv4            20.8 Gbps       7.22 Gbps
net-next (Dual-Stack Baseline)     IPv6            20.4 Gbps       7.55 Gbps
net-next (IPv4-Only Baseline)      IPv4            20.9 Gbps       7.86 Gbps

Patched (Dual-Stack)               IPv4            21.8 Gbps       7.77 Gbps
Patched (Dual-Stack)               IPv6            21.7 Gbps       7.35 Gbps
Patched (IPv4-Only)                IPv4            20.9 Gbps       7.91 Gbps
Patched (IPv6-Only)                IPv6            21.1 Gbps       8.06 Gbps

Follow-up for this series:

Future work decoupled from this initial series includes expanding Kconfig
adaptations across remaining kernel subsystems to support an IPv6-only
environment. This includes patches for network bonding modes that assume
dual-stack availability and analyze Netfilter nftables expressions and
connection tracking to ensure pure IPv6 operations are fully independent.

The main burden the series introduce is the noise in git which will be
cumbersome when trying to identify breaking commits or blames and the
risks of regressions.

Fernando Fernandez Mancera (13):
  net: ipv4: introduce CONFIG_IPV4 to decouple the IPv4 stack
  net: core: add IPv4 fallback stubs and guards for CONFIG_IPV4=n
  net: inet: relocate ip_generic_getfrag and guard IPv4 socket logic
  net: tcp: move protocol agnostic TCP functions out of tcp_ipv4.c
  net: raw: split IPv4 specific logic into raw_ipv4.c
  net: udp: split IPv4 specific logic into udp_ipv4.c
  net: icmp: split IPv4 specific logic into icmp_ipv4.c
  net: ping: split IPv4 specific logic into ping_ipv4.c
  net: fib: split common nexthop logic to fib_core.c
  net: tunnel: guard IPv4 tunnel functions with CONFIG_IPV4
  netfilter: ipv4: guard ip_route_me_harder() with CONFIG_IPV4
  net: ipv4: disable IPv4-only sysctls when CONFIG_IPV4=n
  net: ipv4: make CONFIG_IPV4 boolean

 drivers/infiniband/Kconfig                    |    2 +-
 drivers/net/Kconfig                           |   24 +-
 drivers/net/ethernet/broadcom/Kconfig         |    2 +
 drivers/net/ethernet/chelsio/Kconfig          |    2 +-
 drivers/net/ethernet/intel/Kconfig            |    2 +
 drivers/net/ethernet/marvell/prestera/Kconfig |    1 +
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |    3 +-
 drivers/net/ethernet/mellanox/mlxsw/Kconfig   |    1 +
 drivers/net/ethernet/netronome/Kconfig        |    1 +
 drivers/net/ethernet/qlogic/Kconfig           |    2 +
 drivers/net/ethernet/sfc/Kconfig              |    1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |    1 +
 drivers/net/ethernet/via/Kconfig              |    1 +
 drivers/net/ppp/Kconfig                       |    1 +
 .../broadcom/brcm80211/brcmfmac/Kconfig       |    1 +
 drivers/net/wireless/intel/iwlwifi/Kconfig    |    1 +
 drivers/nvme/host/Kconfig                     |    2 +-
 drivers/nvme/target/Kconfig                   |    2 +-
 drivers/scsi/bnx2fc/Kconfig                   |    1 +
 drivers/scsi/bnx2i/Kconfig                    |    1 +
 drivers/scsi/cxgbi/cxgb3i/Kconfig             |    2 +-
 drivers/scsi/cxgbi/cxgb4i/Kconfig             |    2 +-
 drivers/target/iscsi/Kconfig                  |    2 +-
 fs/Kconfig                                    |    1 +
 fs/afs/Kconfig                                |    2 +-
 fs/nfs/Kconfig                                |    2 +-
 fs/nfsd/Kconfig                               |    2 +-
 include/linux/indirect_call_wrapper.h         |    8 +-
 include/net/icmp.h                            |    1 +
 include/net/ip.h                              |  104 +-
 include/net/ip_fib.h                          |   27 +-
 include/net/route.h                           |   14 +
 include/net/tcp.h                             |   16 +-
 net/Kconfig                                   |   11 +-
 net/batman-adv/Kconfig                        |    1 +
 net/bridge/Kconfig                            |    3 +-
 net/bridge/netfilter/Kconfig                  |    6 +-
 net/core/Makefile                             |    2 +-
 net/core/dev_ioctl.c                          |    4 +
 net/core/fib_core.c                           |  307 +++
 net/core/filter.c                             |   24 +-
 net/core/neighbour.c                          |    5 +
 net/ipv4/Kconfig                              |   29 +-
 net/ipv4/Makefile                             |   24 +-
 net/ipv4/af_inet.c                            |  124 +-
 net/ipv4/fib_frontend.c                       |   96 -
 net/ipv4/fib_semantics.c                      |  205 --
 net/ipv4/icmp.c                               | 1419 +------------
 net/ipv4/icmp_ipv4.c                          | 1445 +++++++++++++
 net/ipv4/inet_connection_sock.c               |    2 +-
 net/ipv4/inet_hashtables.c                    |    4 +
 net/ipv4/ip_output.c                          |   18 -
 net/ipv4/ip_tunnel_core.c                     |   11 +
 net/ipv4/netfilter.c                          |    4 +
 net/ipv4/netfilter/Kconfig                    |    2 +-
 net/ipv4/netlink.c                            |    2 +
 net/ipv4/nexthop.c                            |    9 +-
 net/ipv4/ping.c                               |  215 +-
 net/ipv4/ping_ipv4.c                          |  228 +++
 net/ipv4/proc.c                               |   38 +-
 net/ipv4/raw.c                                |  853 --------
 net/ipv4/raw_diag.c                           |    4 +
 net/ipv4/raw_ipv4.c                           |  883 ++++++++
 net/ipv4/sysctl_net_ipv4.c                    |   32 +-
 net/ipv4/tcp.c                                | 1299 ++++++++++++
 net/ipv4/tcp_bpf.c                            |    2 +
 net/ipv4/tcp_ipv4.c                           | 1307 +-----------
 net/ipv4/udp.c                                | 1781 +---------------
 net/ipv4/udp_bpf.c                            |    6 +
 net/ipv4/udp_diag.c                           |   12 +
 net/ipv4/udp_ipv4.c                           | 1790 +++++++++++++++++
 net/ipv4/udp_offload.c                        |   10 +
 net/ipv6/Kconfig                              |   17 +-
 net/ipv6/af_inet6.c                           |    5 +
 net/ipv6/datagram.c                           |   14 +
 net/ipv6/netfilter/Kconfig                    |    2 +-
 net/ipv6/tcp_ipv6.c                           |   25 +-
 net/ipv6/udp.c                                |   18 +
 net/l2tp/Kconfig                              |    2 +-
 net/mac80211/Kconfig                          |    2 +-
 net/mpls/Kconfig                              |    1 +
 net/mptcp/Kconfig                             |    2 +-
 net/netfilter/Kconfig                         |    2 +-
 net/netfilter/ipset/Kconfig                   |    2 +-
 net/netfilter/ipvs/Kconfig                    |    2 +-
 net/openvswitch/Kconfig                       |    2 +-
 net/packet/Kconfig                            |    1 +
 net/rds/Kconfig                               |    2 +-
 net/rxrpc/Kconfig                             |    2 +-
 net/sched/Kconfig                             |    2 +-
 net/sctp/Kconfig                              |    2 +-
 net/smc/Kconfig                               |    2 +-
 net/sunrpc/Kconfig                            |    2 +-
 net/tipc/Kconfig                              |    2 +-
 net/xfrm/Kconfig                              |   12 +-
 security/smack/Kconfig                        |    1 +
 96 files changed, 6585 insertions(+), 5991 deletions(-)
 create mode 100644 net/core/fib_core.c
 create mode 100644 net/ipv4/icmp_ipv4.c
 create mode 100644 net/ipv4/ping_ipv4.c
 create mode 100644 net/ipv4/raw_ipv4.c
 create mode 100644 net/ipv4/udp_ipv4.c

-- 
2.55.0

