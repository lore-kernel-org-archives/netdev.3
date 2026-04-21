Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90BA3B2FEA
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765600; cv=none; b=dBNboKwGSo1k8lPgATYPB/yNsm5pLunWwz76/ZyF8waxgffqDTFKlMcMSuZscy1gkpO0H0ah9B7tlliDIssXKntOC+/cpfeNJ8o057rQhHS48DnH8GKbePlu0LjaLBUinb5F+7+IuV7vvZnaX0veJwVRmhfItXG4xLl1O6vj+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765600; c=relaxed/simple;
	bh=AeEBe+t+OP3P95UbQpDjqb185e+eP4ju+831DPit47M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DkkFBxQF+AZSVi380UWgoAQKtKlrxKAp8ATAwUC325A10fmoy33123NUX/xIJ9Jz/qbSh8+e0QtSYFQixXQphLlzOlsEQ/ykYSkjF6XILHpehbGqYxkS0Lq4qEVmznN0dDyY3uU05pb7C9c6fYII0aUkSk0ZvpWNRLSZnvLBlT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAyMyu1x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAyMyu1x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776765597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DWNXyDIMPuVotJ3+gZWIDAoJFU9UkOtO5UaUXhqiC/c=;
	b=OAyMyu1xDkuEdLBZr1t0OrboF7J9noOwxm6IgMEYeEd73jSL7pi8JB/FZa0CVFwToCyhFK
	Wv2EcSbrAS807XZo4wS3giBeO32maP7s3fcSUpvqqNxVvl19o2cBxVgnccdy+myOG4uVn9
	YKwVX88DWLYs6SVdhXlZUtN93mqCupA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-MrF2qeuWNAixSeo9jOGlUQ-1; Tue,
 21 Apr 2026 05:59:51 -0400
X-MC-Unique: MrF2qeuWNAixSeo9jOGlUQ-1
X-Mimecast-MFC-AGG-ID: MrF2qeuWNAixSeo9jOGlUQ_1776765590
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FF29180059B;
	Tue, 21 Apr 2026 09:59:50 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.44.32.45])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48C353000C15;
	Tue, 21 Apr 2026 09:59:50 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D56AAA80C62; Tue, 21 Apr 2026 11:59:47 +0200 (CEST)
From: Corinna Vinschen <vinschen@redhat.com>
To: intel-wired-lan@osuosl.org,
	netdev@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Corinna Vinschen <vinschen@redhat.com>
Subject: [PATCH net] iavf: iavf_virtchnl_completion: drop duplicate ether_addr_equal() test
Date: Tue, 21 Apr 2026 11:59:47 +0200
Message-ID: <20260421095947.868695-1-vinschen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is just a simple cleanup fix.  Commit 35a2443d0910f ("iavf: Add
waiting for response from PF in set mac") introduced a duplicate
ether_addr_equal() check, so the current code tests the new MAC twice
against the former MAC.

Remove the outer ether_addr_equal() test, remnant of commit c5c922b3e09b
("iavf: fix MAC address setting for VFs when filter is rejected")

Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
Fixes: 35a2443d0910f ("iavf: Add waiting for response from PF in set mac")
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index a52c100dcbc5..9b8e7e4376c2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2579,13 +2579,11 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 	case VIRTCHNL_OP_ADD_ETH_ADDR:
 		if (!v_retval)
 			iavf_mac_add_ok(adapter);
-		if (!ether_addr_equal(netdev->dev_addr, adapter->hw.mac.addr))
-			if (!ether_addr_equal(netdev->dev_addr,
-					      adapter->hw.mac.addr)) {
-				netif_addr_lock_bh(netdev);
-				eth_hw_addr_set(netdev, adapter->hw.mac.addr);
-				netif_addr_unlock_bh(netdev);
-			}
+		if (!ether_addr_equal(netdev->dev_addr, adapter->hw.mac.addr)) {
+			netif_addr_lock_bh(netdev);
+			eth_hw_addr_set(netdev, adapter->hw.mac.addr);
+			netif_addr_unlock_bh(netdev);
+		}
 		wake_up(&adapter->vc_waitqueue);
 		break;
 	case VIRTCHNL_OP_GET_STATS: {
-- 
2.53.0

