Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738997;
	b=lBXEdB/tJaCCCd9Te7vGKXYQ37DFzaMbwdkVC0d0NJ4yS+EC00jENcxZsocc8nU1cDbU
	 PJugS0UcJz6RWz3gUVV6rKHdpHCkN6/iLdvQvkjZZIgkW8cXeEwT+cUi2/FTFQ3MLkguR
	 ffVOZ4AboVvaVkvw5RQa5rLLHLkGn+uW8NuZIGTGIfVPLD90repfNi+vPLCVL4atZ86BI
	 edPYPRq+Dm6zFZpGTbSyBVB0axQKMBV1N9F2edUGD0BfpB4kw1cp2DFx0a1qKSCLj+mLw
	 R2YpxoggCf/1XkNCftxkmNq//pkGY8SWeu5xtLb0un7BfaShmq1+UsXPTpE9BrcLs+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738997;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=AmfJDAjkugxPQ6TZZdNY6FdOTzwxxq33jzmqfI3RYJU=;
	b=tUUqHklSB46hzI/Q8NdL2jFw1yYZwUhDRiq4UsDGnuTsrTTxqlssAzILBuOUppaNiOwK
	 q0Q45RHquIztyBfKG9007ePkV3NrOt1nrG/xDwNhcjDBqEYksECPmilIMrrQDSrkp0sWi
	 WsiXxcGAkQlu1e/14vRbDhow0o8nGE5aRv+UkcNXZUPBRBT07JmJviTqWvjQW5U6bYIf9
	 XWpWDlWPD2VnaqQYj+11c7Oey16N+yTWnJd+RrkZOMc+cZecNGRy2UFm/lUxgTksqHM7K
	 8PFaaRtmmBmeSLlaXfUOIbhIeL7orEqge/5Y8Y3vUKZoVDTlVcxpdbtzxTXAfi7sQqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NvnXz2Eb;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E87606A321
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27E87606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NvnXz2Eb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792738996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AmfJDAjkugxPQ6TZZdNY6FdOTzwxxq33jzmqfI3RYJU=;
	b=NvnXz2EbfAxSqBv3N9McITuM/rPp0SkeV5icWsyXuMfywmcshhEsvSoEba5EkZ8QKvv19/
	tZiIsEWkNAjz7wzoBKMNJBF+9SLHS2klwYcVr01dl412ZBsm4Y2A4FGZMWpj6I0peFN4DV
	zG8mVjhh8SE+5fu6AUlr6seAxU1cvHg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-ajkdnhQkPMC7JQNKU9NkXg-1; Fri,
 23 Oct 2026 03:03:12 -0400
X-MC-Unique: ajkdnhQkPMC7JQNKU9NkXg-1
X-Mimecast-MFC-AGG-ID: ajkdnhQkPMC7JQNKU9NkXg_1792738989
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DE151956052;
	Fri, 23 Oct 2026 07:03:09 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A6101800347;
	Fri, 23 Oct 2026 07:03:03 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Rafal Rogalski <rafalx.rogalski@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH iwl-net v2 0/5] ice: fix RTNL vs auxiliary device lock inversion
Date: Fri, 23 Oct 2026 09:02:52 +0200
Message-ID: <20261023070258.730168-1-poros@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

ice takes the auxiliary device lock of its RDMA auxiliary device from
three places that run with the RTNL lock held. The RDMA auxiliary probe
takes the two in the opposite order, because __driver_attach() holds the
auxiliary device lock across ib_register_device(), which needs the RTNL
lock. The result is a hard deadlock of everything that needs the RTNL
lock, so the boot never completes:

  systemd-udevd   state:D
    really_probe                  <- holds device_lock(&adev->dev)
    icrdma_probe
    irdma_ib_register_device
    ib_register_device
    setup_device
    irdma_roce_port_immutable
    ib_query_port
    irdma_query_port
    ib_get_eth_speed              <- blocks on rtnl_lock()

  lldpad          state:D
    rtnetlink_rcv_msg             <- holds rtnl_lock()
    dcb_doit
    dcbnl_ieee_set
    ice_dcbnl_setets
    ice_pf_dcb_cfg
    ice_send_event_to_aux         <- blocks on device_lock(&adev->dev)

Lockdep cannot flag it, because device_initialize() marks dev->mutex
with lockdep_set_novalidate_class(). A PREEMPT_RT kernel with
CONFIG_DEBUG_RT_MUTEXES reports "rtmutex deadlock detected" instead.

The probe side cannot be changed, so the three ice callers use
device_trylock() and refuse the operation with -EBUSY when the driver
core holds the lock. Patches 1 and 2 are new in v2 and fix two separate
problems on the same sites, the auxiliary device pointer was tested
before pf->adev_mutex was taken, and ndo_setup_tc() took pf->adev_mutex
before pf->tc_mutex while the dcbnl handlers take them the other way
round. Patch 3 keeps the locks across the whole DCB reconfiguration so
that BEFORE_TC_CHANGE and AFTER_TC_CHANGE are either both delivered or
the request is refused before anything changes, and re-arms the service
task events. Patches 4 and 5 turn the remaining two locks into trylocks.

The proper fix is provider-owned registration as in i40e and mlx5, which
makes the inversion impossible by construction. That is a net-next change
across ice, irdma and iidc_rdma.h, this series is the backportable part.

Tested on an E810-XXV with two PFs, irdma bound to both auxiliary
devices, on net tip commit 191aa41548b2d2 ("MAINTAINERS: add Bobby
Eshleman as vsock reviewer") with and without this series. A reproducer
binds the irdma auxiliary driver while driving one of the three RTNL
held callers into the probe window:

                        without the series   with the series
  ethtool set_channels  deadlock 10/10       0/10, window entered 300x
  ndo_setup_tc mqprio   deadlock             0/10, window entered 50x
  dcbnl ets set         deadlock             0/10, window entered 30x

A window entry is a contended device_trylock(), so each one used to
close the cycle. 25 reboots on the patched kernel were clean.

Changes since v1:
- new patch 1 for the auxiliary device pointer race
- new patch 2 for the pf->tc_mutex order in ndo_setup_tc()
- patch 3 holds the auxiliary device locks across the whole DCB
  reconfiguration and sends AFTER_TC_CHANGE under them instead of
  dropping it when the lock is contended, and takes the locks before it
  consumes pf->oicr_err_reg in the service task
- patch 5 warns instead of netdev_dbg(), the qdisc teardown ignores the
  return value

Link to v1:
https://lore.kernel.org/all/20261019065301.3983537-1-poros@redhat.com/

Petr Oros (5):
  ice: check the auxiliary device pointer under adev_mutex
  ice: take tc_mutex before the auxiliary device locks in ndo_setup_tc
  ice: avoid RTNL deadlock when notifying the RDMA auxiliary driver
  ice: do not block on the aux device lock in ethtool set_channels
  ice: do not block on the aux device lock in ndo_setup_tc

 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 46 ++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 26 +++++++----
 drivers/net/ethernet/intel/ice/ice_idc.c     | 48 ++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_idc_int.h |  2 +
 drivers/net/ethernet/intel/ice/ice_main.c    | 47 +++++++++++++------
 5 files changed, 130 insertions(+), 39 deletions(-)


base-commit: 07bd391eb9572e74f073c49acef327611234f9bb
-- 
2.56.0

