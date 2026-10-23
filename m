Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739025;
	b=4xfXu2/JpiQWjKTnkZkywKBBafTeTFllMjOI7o+kCrHfn5YdlNmIGaseKpx9Jgm1v9MA
	 KDVCgzLoU304HW1+n9RsYKxDhNs4nAhQw4JQdYrSvpdk6KPcFWzsQjUfQ5ENOGhEUnvmo
	 ajii50xkHKBKDOepIhPiYXZ5U88Mqbb6ol/ibMkW9yVaUi8O9ssUYZocQsDNUfHkc4Plr
	 IDGQxmmfk8+ns/IRAblBH+OrulmBhYCeaj1A/oNqxDjRc+5O/xjt86bZOd3cGNT7Lhi++
	 jn+1DZHrtdX6223iOlbft2u9R4JUbveX6IiivK8zE8VnU4iY6eT4h1AvLxA/JrA/rOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739025;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=5VmmDXq4OzoNj3hj8BcuC3rJKucr2wP7gcadVhT2RHM=;
	b=Wwsp5V3hUqK/O1rtQt2MkzsgkEVKpNMeKUFCp4hpMur0ptmBU+GesrHRtYKSFvMSNNAB
	 NTpcDNQczvjRmH7T6PxTZNoFTmrzPB0NNCCDkvQgnGFHB2pHelUSuuiwQm7do8iuetPby
	 sxcfowPDVXycyJoILSeUcJcWFi52XUZMMhsvLMxtFA9TwLwRnC8RU8uIl2k56vuLJTaQ4
	 JcP4cBKiSIZRh0w9Dj7pxE/qWIxCZC2TMvVmt3mzFVCjPyexj7kV1NwgImVkW8rjnVhJc
	 RGvmTRNy1JMe/S44UcRl1a9NStyncBXzzIIFIjAg1jPKKrW9OXt6U8CZ0io56bwOcWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iGjziGyK;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D02060A3829
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D02060A3829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iGjziGyK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792739023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VmmDXq4OzoNj3hj8BcuC3rJKucr2wP7gcadVhT2RHM=;
	b=iGjziGyKUFxh66gavdRUrUofUWN2w1zfHj4UKr2hsSz6s3J+7mqa/oEK3sH/RDvrLQ1pOz
	nWEcDaaRuqJyZhHAAjtZtdkn9PG7z/kX8O351LbKUKXY1NKHwKjt0OyO1P2xDJ+LMiXFpN
	G4FXfu3ZtLS1mTI1A+8m3OlI44QPa7w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-6dwtmr-BPEaaGiperbAeJA-1; Fri,
 23 Oct 2026 03:03:39 -0400
X-MC-Unique: 6dwtmr-BPEaaGiperbAeJA-1
X-Mimecast-MFC-AGG-ID: 6dwtmr-BPEaaGiperbAeJA_1792739017
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1631A1956053;
	Fri, 23 Oct 2026 07:03:37 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4BB11800347;
	Fri, 23 Oct 2026 07:03:31 +0000 (UTC)
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
Subject: [PATCH iwl-net v2 5/5] ice: do not block on the aux device lock in ndo_setup_tc
Date: Fri, 23 Oct 2026 09:02:57 +0200
Message-ID: <20261023070258.730168-6-poros@redhat.com>
In-Reply-To: <20261023070258.730168-1-poros@redhat.com>
References: <20261023070258.730168-1-poros@redhat.com>
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

The TC_SETUP_QDISC_MQPRIO path of ice_setup_tc() takes the auxiliary
device lock to test whether the RDMA driver is bound, and ndo_setup_tc()
runs with the RTNL lock held. This closes the same cycle against the
RDMA auxiliary probe as the two preceding patches.

Use device_trylock() and report the device as busy when it fails. When
the qdisc is added, userspace gets -EBUSY and can retry. When it is
deleted, mqprio_disable_offload() ignores the return value, so the
hardware traffic classes and the channel VSIs stay in place until a
later qdisc teardown gets through, the same as the existing -EBUSY for
a bound RDMA driver. The message is a netdev_warn() because of that
second case, nothing else reports it.

Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- rebased on the new patches 1 and 2
- netdev_warn() instead of netdev_dbg(), the qdisc teardown cannot
  retry and ignores the return value

v1: https://lore.kernel.org/all/20261019065301.3983537-4-poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9de375f5c4deb5..7eb653a7ebacd5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9451,7 +9451,12 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			mutex_lock(&pf->adev_mutex);
 			adev = cdev->adev;
 			if (adev) {
-				device_lock(&adev->dev);
+				if (!device_trylock(&adev->dev)) {
+					mutex_unlock(&pf->adev_mutex);
+					netdev_warn(netdev, "RDMA auxiliary device is busy, qdisc not changed\n");
+					err = -EBUSY;
+					goto tc_unlock;
+				}
 				locked = true;
 				if (adev->dev.driver) {
 					netdev_err(netdev, "Cannot change qdisc when RDMA is active\n");
@@ -9471,6 +9476,7 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 			device_unlock(&adev->dev);
 			mutex_unlock(&pf->adev_mutex);
 		}
+tc_unlock:
 		mutex_unlock(&pf->tc_mutex);
 		return err;
 	case TC_SETUP_QDISC_ETF:
-- 
2.56.0

