Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB624DD3D1
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776439; cv=none; b=OiYd6iyys8urrWyjKjY0bUs4heZWtGt+J22+lZIrzzpsnyr398/RdKEWHVeMqPvpo62hHsDvpTw5HbjbgQw4r8L00+nwVOAOBXv5d/gRr1BHmRW616BHkK5Fg+yp87jp2f7ROY1Z5G7AnPuB/zfbO9isukQumwsS/kzqF9Aq68c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776439; c=relaxed/simple;
	bh=KjXuWQZuBFcE41SXEXkv/lyPB9J41IKGjZHA88nJ0N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AsDDIQ7ikppBsaKw3ej2tC8lNsIAdLsrJ/hIvAN2V6hUmej7IZGs+ITUXF3R4rLGSvaQeecYd8QXY/Hmzac+iPUZetNhbimubqQajEWIaY3DoE1RDL5tRewag8QgDRLk9ATp6EYoPhyqa0H/OAocVoQSSD8Y0X7jzPHt6s/HOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HIb1IG9H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zRZ4/nOa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UVHbRR3c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W2dMs8sd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HIb1IG9H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zRZ4/nOa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UVHbRR3c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W2dMs8sd"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABB6121D0F;
	Wed, 30 Sep 2026 13:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790776423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5uXdm33wm1mNJt4IbLxo0zfxbMlaboTgW6BXSRBy7x4=;
	b=HIb1IG9HxMfyvGVwh+NO1ACoA/Ic2e1oXc3o5MjICfVF0bOMP0SZ92mpS8/0jLbCxrzvdw
	Gq2CGu98m8V6ZWcp3mB/FI8IV6+WuLZo4jnPn4x5bOLmaKZww6qQTVnOaKky3JV0zDJJNk
	Ojfh68XOHs74/QpyawCO90no956czsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790776423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5uXdm33wm1mNJt4IbLxo0zfxbMlaboTgW6BXSRBy7x4=;
	b=zRZ4/nOaHTMX8QQeDBQRZHrC3WdFV/SMeuJSt+wX88zG8bsUn0V4V9K10U7RN2diWVhrFP
	Mmu6Ha6l00L58lCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790776419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5uXdm33wm1mNJt4IbLxo0zfxbMlaboTgW6BXSRBy7x4=;
	b=UVHbRR3cIq7muHWyJ/sv7SuNCti0fSFzRrk6czdLXZtEq1tKdGTAku6i2RYds96GWf8IOE
	M4b+GfnpAk2DXJt3lWSzIWzExkC+2mto6TJ6Nw7L0s+fqzknW4AOXqcJtyNR//Lrb7bwpF
	vL67AjMVLeoG6CwkW1fCOPLD51OyH9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790776419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5uXdm33wm1mNJt4IbLxo0zfxbMlaboTgW6BXSRBy7x4=;
	b=W2dMs8sdQx2+LaOtu61xDhyWRN+izerlYxIr0T30wQeN3OkXkmk1zOGUnXSqoRC/xs/OCm
	85Dk7icTR0lG/xDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A551213ABC;
	Wed, 30 Sep 2026 13:53:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJXpHGIUvWqUTwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 30 Sep 2026 13:53:38 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 00/16 net-next v3] Allow compiling an IPv6-only kernel network stack
Date: Wed, 30 Sep 2026 15:52:43 +0200
Message-ID: <20260930135334.4739-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

The primary goal of this patch series is to enable the compilation of an
IPv6-only kernel by decoupling the core networking infrastructure from
the IPv4 protocol.

Historically, IPv4 has been intertwined with the generic socket and
transport layers. By untangling these dependencies, this series allows
systems to be built with CONFIG_IPV4 disabled. This configuration
targets strict IPv6-only deployments, constrained environments, and
specialized appliances where removing the IPv4 subsystem reduces the
network attack surface. To provide some numbers, 0.3% (32) of the
released CVEs since 2025 were strictly related to IPv4 code. While the
number is low, it is good for users to be able to disable it if they do
not depend on it.

To achieve this, subsystems with hard dependencies on IPv4 were modified
to use conditional compilation guards. When CONFIG_IPV4 is disabled, the
affected packet manipulation routines and routing hooks evaluate to
stubs returning standard error codes. The INDIRECT_CALL_INET macros
within the transport layer were adapted to safely bypass IPv4 function
pointers without penalizing the dual-stack fast paths. In addition,
there has been several code splits for UDP, RAW, ICMP or Ping isolating
the IPv4 specific code.

Every Kconfig symbol that gained a new depends on IPV4 was audited
against the code it guards, distinguishing genuine hard link-time
dependencies from options that were only conservatively gated.  Where a
symbol never depended on CONFIG_INET before, depends on IPV4 || !INET is
used instead of a bare dependency, so pre-existing CONFIG_INET=n
configurations remain buildable as before.

Finally, CONFIG_IPV4 is exposed in Kconfig as an explicit boolean,
defaulting to 'y' to preserve existing configurations.

The bloat-o-meter diff and size output for x86_64 with dualstack and
IPv6 disabled:

   text	   data	    bss	    dec	    hex	filename
31608053	8913174	1145484	41666711	27bc897	vmlinux.dual
28809691	8183494	1101724	38094909	245483d	vmlinux.ipv6

add/remove: 53/19751 grow/shrink: 65/601 up/down: 740100/-3490467 (-2750367)

Performance testing:

Basic TCP performance validation was conducted using iperf3 on an AMD
Ryzen 9 9950X between two bridged virtual machines. These benchmarks
verify that there are no obvious performance regressions.

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

Future work decoupled from this initial series includes expanding
Kconfig adaptations across remaining kernel subsystems to support an
IPv6-only environment. This includes patches for network bonding modes
that assume dual-stack availability and analyze Netfilter nftables
expressions and connection tracking to ensure pure IPv6 operations are
fully independent.

The main structural cost of this series is the code movement from
splitting IPv4-specific logic into new files, which will make git blame
and bisection across the affected files more cumbersome than a purely
additive change. Where possible, IPv4-only branches were expressed as
runtime IS_ENABLED() checks relying on dead-code elimination rather than
ifdef blocks, to keep the preprocessor-guard footprint as small as
possible.

Changes:
  v3:
    Patch 1: Mark SMC as depends on IPV4 too
    Patch 3: Make sure inetsw isn't accessible from other modules when
             IPV4=n by using runtime checks
    Patch 5: Included missing <linux/compat.h>
    Patch 6: Fixed wrong removal of udp_get_len() due to a wrong rebase.
    Patch 13: Fixed building with INET=n

  v2: https://lore.kernel.org/netdev/20260928193046.6698-1-fmancera@suse.de/

Fernando Fernandez Mancera (16):
  ipv4: introduce CONFIG_IPV4 to decouple the IPv4 stack
  net: core: add IPv4 fallback stubs and guards for CONFIG_IPV4=n
  net: inet: relocate ip_generic_getfrag and guard IPv4 socket logic
  tcp: move protocol agnostic TCP functions out of tcp_ipv4.c
  ipv4: raw: split IPv4 specific logic into raw_ipv4.c
  ipv4: udp: split IPv4 specific logic into udp_ipv4.c
  ipv4: icmp: split IPv4 specific logic into icmp_ipv4.c
  ipv4: ping: split IPv4 specific logic into ping_ipv4.c
  ipv4: fib: split common nexthop logic to fib_core.c
  tunnels: guard IPv4 tunnel functions with CONFIG_IPV4
  ipv4: disable IPv4-only sysctls when CONFIG_IPV4=n
  netfilter: ipv4: guard ip_route_me_harder() with CONFIG_IPV4
  net: bridge: guard ARP/RARP proxy and suppression with CONFIG_IPV4
  wifi: mac80211: replace CONFIG_INET with CONFIG_IPV4 guards
  netlabel: cipso: introduce CONFIG_CIPSO to decouple IPv4 dependency
  ipv4: make CONFIG_IPV4 boolean

 drivers/infiniband/Kconfig                    |    2 +-
 drivers/infiniband/sw/rxe/Kconfig             |    2 +-
 drivers/net/Kconfig                           |   23 +-
 drivers/net/ethernet/chelsio/Kconfig          |    2 +-
 drivers/net/ethernet/intel/Kconfig            |    2 +
 drivers/net/ethernet/marvell/prestera/Kconfig |    1 +
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |    3 +-
 drivers/net/ethernet/mellanox/mlxsw/Kconfig   |    1 +
 drivers/net/ethernet/qlogic/Kconfig           |    2 +
 drivers/net/ethernet/rocker/Kconfig           |    1 +
 drivers/net/ethernet/sfc/Kconfig              |    1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |    1 +
 drivers/net/ethernet/via/Kconfig              |    1 +
 drivers/net/ppp/Kconfig                       |    1 +
 .../broadcom/brcm80211/brcmfmac/Kconfig       |    1 +
 drivers/net/wireless/intel/iwlwifi/Kconfig    |    1 +
 drivers/nvme/host/Kconfig                     |    2 +-
 drivers/nvme/target/Kconfig                   |    2 +-
 drivers/scsi/cxgbi/cxgb3i/Kconfig             |    2 +-
 drivers/scsi/cxgbi/cxgb4i/Kconfig             |    2 +-
 drivers/target/iscsi/Kconfig                  |    2 +-
 drivers/target/iscsi/cxgbit/Kconfig           |    2 +-
 fs/Kconfig                                    |    1 +
 fs/afs/Kconfig                                |    2 +-
 fs/nfs/Kconfig                                |    2 +-
 fs/nfsd/Kconfig                               |    2 +-
 include/linux/indirect_call_wrapper.h         |    8 +-
 include/net/cipso_ipv4.h                      |   18 +-
 include/net/icmp.h                            |    1 +
 include/net/ip.h                              |  111 +-
 include/net/ip_fib.h                          |   27 +-
 include/net/route.h                           |   14 +
 include/net/tcp.h                             |   16 +-
 include/net/udp.h                             |   11 +
 net/Kconfig                                   |    9 +-
 net/batman-adv/Kconfig                        |    6 +-
 net/bridge/Kconfig                            |    2 +-
 net/bridge/br_arp_nd_proxy.c                  |    2 +
 net/bridge/br_device.c                        |    2 +-
 net/bridge/br_input.c                         |    2 +-
 net/bridge/netfilter/Kconfig                  |    3 +-
 net/core/Makefile                             |    2 +-
 net/core/dev_ioctl.c                          |    3 +
 net/core/fib_core.c                           |  307 +++
 net/core/filter.c                             |   20 +-
 net/core/neighbour.c                          |    4 +
 net/ipv4/Kconfig                              |   29 +-
 net/ipv4/Makefile                             |   24 +-
 net/ipv4/af_inet.c                            |  132 +-
 net/ipv4/fib_frontend.c                       |   96 -
 net/ipv4/fib_semantics.c                      |  205 --
 net/ipv4/icmp.c                               | 1418 +------------
 net/ipv4/icmp_ipv4.c                          | 1448 +++++++++++++
 net/ipv4/inet_connection_sock.c               |    2 +-
 net/ipv4/inet_hashtables.c                    |    3 +
 net/ipv4/ip_output.c                          |   18 -
 net/ipv4/ip_tunnel_core.c                     |   11 +
 net/ipv4/netfilter.c                          |    3 +
 net/ipv4/netfilter/Kconfig                    |    2 +-
 net/ipv4/nexthop.c                            |    5 +-
 net/ipv4/ping.c                               |  210 +-
 net/ipv4/ping_ipv4.c                          |  228 +++
 net/ipv4/proc.c                               |   45 +-
 net/ipv4/raw.c                                |  853 --------
 net/ipv4/raw_diag.c                           |    3 +-
 net/ipv4/raw_ipv4.c                           |  884 ++++++++
 net/ipv4/sysctl_net_ipv4.c                    |  413 ++--
 net/ipv4/tcp.c                                | 1300 +++++++++++-
 net/ipv4/tcp_bpf.c                            |    3 +-
 net/ipv4/tcp_ipv4.c                           | 1307 +-----------
 net/ipv4/udp.c                                | 1817 +----------------
 net/ipv4/udp_bpf.c                            |    5 +-
 net/ipv4/udp_ipv4.c                           | 1790 ++++++++++++++++
 net/ipv4/udp_offload.c                        |    3 +
 net/ipv6/Kconfig                              |   17 +-
 net/ipv6/af_inet6.c                           |    5 +
 net/ipv6/datagram.c                           |    4 +-
 net/ipv6/netfilter/Kconfig                    |    2 +-
 net/ipv6/tcp_ipv6.c                           |   23 +-
 net/ipv6/udp.c                                |   11 +-
 net/l2tp/Kconfig                              |    2 +-
 net/mac80211/main.c                           |   10 +-
 net/mptcp/Kconfig                             |    2 +-
 net/netfilter/Kconfig                         |    2 +-
 net/netfilter/ipset/Kconfig                   |    2 +-
 net/netfilter/ipvs/Kconfig                    |    2 +-
 net/netlabel/Kconfig                          |    4 +
 net/netlabel/Makefile                         |    2 +-
 net/netlabel/netlabel_cipso_v4.h              |    7 +
 net/netlabel/netlabel_kapi.c                  |    3 +
 net/rds/Kconfig                               |    1 +
 net/rxrpc/Kconfig                             |    2 +-
 net/sched/Kconfig                             |    2 +-
 net/sctp/Kconfig                              |    2 +-
 net/smc/Kconfig                               |    2 +-
 net/sunrpc/Kconfig                            |    2 +-
 net/tipc/Kconfig                              |    1 +
 net/xfrm/Kconfig                              |   10 +-
 98 files changed, 6747 insertions(+), 6262 deletions(-)
 create mode 100644 net/core/fib_core.c
 create mode 100644 net/ipv4/icmp_ipv4.c
 create mode 100644 net/ipv4/ping_ipv4.c
 create mode 100644 net/ipv4/raw_ipv4.c
 create mode 100644 net/ipv4/udp_ipv4.c

-- 
2.55.0

