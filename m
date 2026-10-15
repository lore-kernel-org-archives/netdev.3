Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFEF2EEE60
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072879; cv=none; b=X+zlR/qhQhluaAOe6fyIyUFxq+Kn9rD3nWW8WFPhAxFFtpzou48izrA+JBxIODnZy7MBaPnTKg9BC6VyfaPhgWHP1ubRjI5EFVbD4qKLqUL7/K3KT7kB5VOpOLczlh7XPrflPEvVUv5hvHZZvbwIjvutWtE9Ex/hcXb7CAPl7Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072879; c=relaxed/simple;
	bh=YQktLE2sL64L+L6hLefVhS3ZN6vkN0NFMhrUQ/ALjRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ANbwuVyrpjMBg728vSBDvp1/6B83R6N6syJNhNt1tvYmdVJZTyZytfXllbgu/WWQ9pIgQAEJmZMp7djfGH9l3QoRLcAQCILPTa19246WVWwPWoJRPqVGGQsZk7J8MbXr840Yt/lQT77rx9AZBOr8lfPbz6uCW8iMhfrz5a0Ipf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ib8x5Fqr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ib8x5Fqr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792072877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B++FRQuykLHub06est9mPbk8OIa8LmGU3lEAwNchHg8=;
	b=ib8x5Fqrck6e1sjSWA6P0O2rYNhnrEg9fEzUJpOQ5/EgQDa2sU7lez2SIEPof7goGolSOp
	abW7qK2nzxUjyXQoStPRKJTVC4x50IsH0hCYvJT4XTFZOvb8NbUhjZ73vUg8qr0rmUsk8E
	w+I1qeGXJ7j3S0kQkfwm7qupl8MIngo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-oQOLSSKhMMCpaIpLzdwliQ-1; Thu,
 15 Oct 2026 14:01:01 +0000
X-MC-Unique: oQOLSSKhMMCpaIpLzdwliQ-1
X-Mimecast-MFC-AGG-ID: oQOLSSKhMMCpaIpLzdwliQ_1792072859
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D6FE19541B1;
	Thu, 15 Oct 2026 14:00:59 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86B541800345;
	Thu, 15 Oct 2026 14:00:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.3-rc8
Date: Thu, 15 Oct 2026 16:00:51 +0200
Message-ID: <20261015140051.105229-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Linus!

The following changes since commit af32da41b0327b9c6a37856ba82b6760d6c8d10e:

  Merge tag 'net-7.3-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-10-09 06:40:28 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.3-rc8

for you to fetch changes up to aa07285705f8d5bac464eb1c5b7412f8e88b91e1:

  net: stmmac: dwmac1000: clear the RGMII status interrupt (2026-10-15 14:57:52 +0200)

----------------------------------------------------------------
This is considerably smaller than in recent history, mostly due to
reduced capacity and increased backlog. Also we actively redirected
more stuff towards next. I'm not aware of any pending regression.

Current release - regressions:

  - eth: move netops initialization to fix crash

Previous releases - regressions:

  - sched: fix use-after-free in __tcf_action_put()

  - rds: fix uninitialized trans dereference in CM event handler

Previous releases - always broken:

  - vsock: treat TCP_CLOSING as once-established

  - netlink: avoid hashing the network namespace pointer

  - eth: mlx5: HWS, release L2 to L3 tunnel reformats to their own pool

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexandre Cassen (2):
      net/mlx5: HWS, release L2 to L3 tunnel reformats to their own pool
      net/mlx5: HWS, fix flow meter offset within its bulk

Allison Henderson (1):
      net/rds: don't let the rdma_cm destroy an id RDS still owns on route failure

Aohan Mei (1):
      net: rds: fix uninitialized trans dereference in CM event handler

Breno Leitao (1):
      MAINTAINERS: add Gustavo Luiz Duarte as netconsole reviewer

Daehyeon Ko (1):
      sctp: revalidate output stream after association connect wait

David Yang (10):
      net: hisilicon: hisi_femac: Move setting of netops to fix crash
      net: hisilicon: hip04_eth: Move setting of netops to fix crash
      net: ethernet: actions: Move setting of netops to fix crash
      net: ethernet: adi: Move setting of netops to fix crash
      net: mv643xx: move setting of netops to fix crash
      net: au1000: move setting of netops to fix crash
      net: ethoc: move setting of netops to fix crash
      net: ethernet: aeroflex: move setting of netops to fix crash
      net: ti: icssm-prueth: Move setting of netops to fix crash
      microchip: lan865x: move setting of netops to fix crash

Igor Velkov (1):
      net: stmmac: dwmac1000: clear the RGMII status interrupt

Joas Antonio dos Santos (1):
      calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()

Jérémy Jean (1):
      net/sched: fix use-after-free in __tcf_action_put()

Kyle Zeng (2):
      netlink: reset skb headers before unicast and multicast filtering
      netlink: avoid hashing the network namespace pointer

Michal Luczaj (1):
      vsock: treat TCP_CLOSING as once-established

Nicolai Buchwitz (1):
      net: bcmgenet: unshare the skb before writing the control block

Paolo Abeni (3):
      Merge branch 'net-rds-rdma-cm-event-handler-fixes-for-non-ib-devices'
      Merge branch 'net-mlx5-hws-fix-reformat-release-and-meter-offset'
      Merge branch 'net-move-setting-of-netops-to-fix-crash'

 MAINTAINERS                                        |  1 +
 drivers/net/ethernet/actions/owl-emac.c            |  3 +-
 drivers/net/ethernet/adi/adin1140.c                |  3 +-
 drivers/net/ethernet/aeroflex/greth.c              |  3 +-
 drivers/net/ethernet/amd/au1000_eth.c              |  3 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 10 ++++++
 drivers/net/ethernet/ethoc.c                       |  3 +-
 drivers/net/ethernet/hisilicon/hip04_eth.c         |  3 +-
 drivers/net/ethernet/hisilicon/hisi_femac.c        |  3 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |  4 +--
 .../mellanox/mlx5/core/steering/hws/fs_hws.c       |  5 +--
 drivers/net/ethernet/microchip/lan865x/lan865x.c   |  3 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |  6 ++++
 drivers/net/ethernet/ti/icssm/icssm_prueth.c       |  3 +-
 net/ipv6/calipso.c                                 |  6 ++--
 net/netlink/af_netlink.c                           | 10 ++++--
 net/rds/rdma_transport.c                           | 38 +++++++++++++++++++---
 net/sched/act_api.c                                | 11 +++----
 net/sctp/socket.c                                  | 33 ++++++++++++-------
 net/vmw_vsock/af_vsock.c                           | 17 +++++-----
 20 files changed, 117 insertions(+), 51 deletions(-)

