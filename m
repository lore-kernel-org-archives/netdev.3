Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB423806CA
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473593; cv=none; b=AUrBwlQdj/SK8++EIVqlDJrVV4a6u0p/Te2DvFetXfqf8ZSnSFuHS6g/TVpPoqzzflfWxbieuJQ5fLOdeMz3iJ+qj+O/Tv/xIRmvGK/eID9rolniC9vNH7W1hKuS8eBBOKIF3BF/oHbX8KQ14MMwNFYNcueLF1J7TnHtq8vO/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473593; c=relaxed/simple;
	bh=TwEBITxsjqDNfr67b1FnkWbtZJvna7apEgcotdHSFX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+NvixwGkOKr+ZWV2G+PXcAdyYNJh3/Ov3DudlK0lvQVhkjadslfONvY7MQu6RwMeNFHM38+CbFT4pvQn7Ur6faA/z+t1CNxYCZxa0tNHu6ws+MCQ0Mx7rjGvLVjgFL6GsMJ0llkQt+heCjviQS4m0fr+NYn4gIWx+FGozcIj5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaE9sCuq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaE9sCuq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789473591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=owXpxkdaiz3FjoIP3af9pZnf5S2SeMbdOA3eIgSOhpI=;
	b=JaE9sCuqgxKtHIUsdyuVuM8C3QbcXl7BECnvLdqfl8vCyb6B9h642t6Zq9Xy/Zc/j/OxLN
	vAvY64IF3LZiGroVBNNsAoBdC64b8K5Mg9BhSJIfKdXvbeQ2OQe4mAXPXTk9DblrIZb5UL
	U1ffkuxq9nrIkijvQA0t70wB2M62eY0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-w7d3T18TPyOItpXF1_D_bA-1; Tue,
 15 Sep 2026 07:59:48 -0400
X-MC-Unique: w7d3T18TPyOItpXF1_D_bA-1
X-Mimecast-MFC-AGG-ID: w7d3T18TPyOItpXF1_D_bA_1789473586
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 586601944B32;
	Tue, 15 Sep 2026 11:59:46 +0000 (UTC)
Received: from fballuch-thinkpadx1carbongen13.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B59D1956045;
	Tue, 15 Sep 2026 11:59:43 +0000 (UTC)
From: Filip Balluch <fballuch@redhat.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Filip Balluch <fballuch@redhat.com>
Subject: [PATCH] i40e: fix freeing of TX rings on RX allocation failure
Date: Tue, 15 Sep 2026 13:59:39 +0200
Message-ID: <20260915115939.56716-1-fballuch@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When ethtool -G is used to change ring buffer sizes while the interface is up, i40e_set_ringparam()
allocates temporary TX and RX rings. If the RX ring allocation fails, the error path at the
free_tx label incorrectly calls i40e_free_tx_resources(vsi->tx_rings[i]), freeing the live TX rings
instead of the temporary tx_rings[i].

Since the interface is still up, the next TX completion interrupt causes i40e_clean_tx_irq() to dereference
the freed ring descriptors, resulting in a NULL pointer dereference in IRQ context and a kernel panic.

This can be reproduced on systems with Intel X710 NICs under memory pressure, where
the second port's DMA allocation fails after the first port succeeds.

Fix by freeing the temporary tx_rings[i] in the error path instead of
the live vsi->tx_rings[i].

Signed-off-by: Filip Balluch <fballuch@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 3da9ec49cc74..6d2b076049f7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2249,7 +2249,7 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	if (tx_rings) {
 		for (i = 0; i < tx_alloc_queue_pairs; i++) {
 			if (i40e_active_tx_ring_index(vsi, i))
-				i40e_free_tx_resources(vsi->tx_rings[i]);
+				i40e_free_tx_resources(&tx_rings[i]);
 		}
 		kfree(tx_rings);
 		tx_rings = NULL;
-- 
2.55.0

