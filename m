Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C832A488213
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475221; cv=none; b=nl6dW9bY/+yj/vcPEHLjdw7KT+4e2FJwmLUVGDOOuRijbg+PVyEerfdkhcATGeJSkMMIkQkM2yym0r+/+KbMUBfj6r3OF2YYye8mnPwi0G4EllFhWl0TdxN5ditUwv2NMKTZQZi6HIPROjaHYQYS4BGd5p7hmCgUYbACvbCTcGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475221; c=relaxed/simple;
	bh=TwEBITxsjqDNfr67b1FnkWbtZJvna7apEgcotdHSFX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4ianhBYiciSOI/KXi7XvO9MeLZbxeGKCXgiD75htRyg50rQGuNzGBWJ9RLYX60HqCTSmnYjopH954X6VmXuUYmoljx4dYmVIwS49MWjRYIPNuVrMyu8mqfQVr85+NlBCplad1ApB/tpbAvc2lsEWswUOfyA4yu+gPsbKXVNhD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DBkHkjjm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBkHkjjm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789475218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owXpxkdaiz3FjoIP3af9pZnf5S2SeMbdOA3eIgSOhpI=;
	b=DBkHkjjmhXUEHxovENqFkit+yc8v3ZSjIerXoWtNfbzfPCyi3YN3PE1nk6ceHRERJ1lNIy
	ijLEA/58lBGvtk0+TzYykJc13Pt0onUnT38HGxS+P4XYUoPfpCOHaDMxvqDMVkvpK790u2
	YizjuTTvISQAYW7HVRbYswutEpeREvk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-AOyTse_KPj22WjctNb7Zzw-1; Tue,
 15 Sep 2026 08:26:55 -0400
X-MC-Unique: AOyTse_KPj22WjctNb7Zzw-1
X-Mimecast-MFC-AGG-ID: AOyTse_KPj22WjctNb7Zzw_1789475213
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5099185FDA2;
	Tue, 15 Sep 2026 12:26:53 +0000 (UTC)
Received: from fballuch-thinkpadx1carbongen13.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C73D93003EEE;
	Tue, 15 Sep 2026 12:26:50 +0000 (UTC)
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
Date: Tue, 15 Sep 2026 14:26:39 +0200
Message-ID: <20260915122639.64936-2-fballuch@redhat.com>
In-Reply-To: <20260915122639.64936-1-fballuch@redhat.com>
References: <20260915122639.64936-1-fballuch@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

