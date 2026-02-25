Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395912DA749
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013730; cv=none; b=FzLelr5jYrUSN24uNYmBC79Aa3TmdGYHfYs9H6jw/zd4X/g/l/sFCMlXakza8bvtdg0tkupysdYhBbPdjzddyF+7wnmJ+jLwsstPzyTfLZnoZwr7bqdrX+skwEd1JLJYdM75t0cqJvyXhX+mSSzV06EZwOwrwmSjg0lTbFFPymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013730; c=relaxed/simple;
	bh=IhVt4phoj1lYkoSFK3OYPIsDBh/FpkWOM7axoUMASqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnZHWvaDeesslFofiRizPcj138ZG1BEbd00FVwN6qi7yIjpZlAikdO1+fAQply6ISTyDDxgomFNNqKZTAl1ZY7DrVcGYjWZIeXFv6eIopFR6Erf8BVixWb40XzJAVcEMVPIYlllt5MH/68jRhWdrPzEpbhzen0O3sL1TKOe4h9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4G9fJdC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4G9fJdC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772013728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cg5Gjl2amw0T9d2qORAIX+1bQ59fHlgumxxtVuZFhPM=;
	b=g4G9fJdCR6UmP05cWln5du9bQKq+iNtg1gNee+5wl0kGpUdDupPfR3or5Jac0N/8tv1IUc
	Kjp4TKMyWCc5ts7sGlYIvr9OUwmN1peKsn+dLY1xChIU/cmBsnUsv7JQEXYD4nm6J1LxEG
	nx9SJzt1rWTI0LJYZ8r8XLRaV3mX1+4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-Xc32Keg6NpmMeZ1XcMuGJw-1; Wed,
 25 Feb 2026 05:02:04 -0500
X-MC-Unique: Xc32Keg6NpmMeZ1XcMuGJw-1
X-Mimecast-MFC-AGG-ID: Xc32Keg6NpmMeZ1XcMuGJw_1772013722
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82D53195609F;
	Wed, 25 Feb 2026 10:02:01 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.225.132])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6067E3003D8C;
	Wed, 25 Feb 2026 10:01:58 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] iavf: fix VLAN filter lost on add/delete race
Date: Wed, 25 Feb 2026 11:01:37 +0100
Message-ID: <20260225100137.383527-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When iavf_add_vlan() finds an existing filter in IAVF_VLAN_REMOVE
state, it transitions the filter to IAVF_VLAN_ACTIVE assuming the
pending delete can simply be cancelled. However, there is no guarantee
that iavf_del_vlans() has not already processed the delete AQ request
and removed the filter from the PF. In that case the filter remains in
the driver's list as IAVF_VLAN_ACTIVE but is no longer programmed on
the NIC. Since iavf_add_vlans() only picks up filters in
IAVF_VLAN_ADD state, the filter is never re-added, and spoof checking
drops all traffic for that VLAN.

  CPU0                       CPU1                     Workqueue
  ----                       ----                     ---------
  iavf_del_vlan(vlan 100)
    f->state = REMOVE
    schedule AQ_DEL_VLAN
                             iavf_add_vlan(vlan 100)
                               f->state = ACTIVE
                                                      iavf_del_vlans()
                                                        f is ACTIVE, skip
                                                      iavf_add_vlans()
                                                        f is ACTIVE, skip

  Filter is ACTIVE in driver but absent from NIC.

Transition to IAVF_VLAN_ADD instead and schedule
IAVF_FLAG_AQ_ADD_VLAN_FILTER so iavf_add_vlans() re-programs the
filter.  A duplicate add is idempotent on the PF.

Fixes: 0c0da0e95105 ("iavf: refactor VLAN filter states")

Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 4b0fc8f354bc90..6046b93c7f3472 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -782,10 +782,13 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter,
 		adapter->num_vlan_filters++;
 		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_VLAN_FILTER);
 	} else if (f->state == IAVF_VLAN_REMOVE) {
-		/* IAVF_VLAN_REMOVE means that VLAN wasn't yet removed.
-		 * We can safely only change the state here.
+		/* Re-add the filter since we cannot tell whether the
+		 * pending delete has already been processed by the PF.
+		 * A duplicate add is harmless.
 		 */
-		f->state = IAVF_VLAN_ACTIVE;
+		f->state = IAVF_VLAN_ADD;
+		iavf_schedule_aq_request(adapter,
+					 IAVF_FLAG_AQ_ADD_VLAN_FILTER);
 	}
 
 clearout:
-- 
2.52.0

