Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5D497B83
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946516; cv=none; b=CUUZKKEV96EESC9qNbnDJe5DHc89aQm5xReXzggXm4esT1pf98eAfmjhCHuUsZjr7OSddT4OUMLz8bgEQeEi106bVIGCPdN7mWUmJCuTylTvlz7vocKTvQf+gyuY5OCGxNoqrSGrnpkYmEGp1oNgfQNMfi6CLmXJ8oTAS753Mj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946516; c=relaxed/simple;
	bh=n2rKkg1lmyo2UXxYDRrre3pvWle2qeWhsouk8b/xGL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CC3Zry6ucwWgKQVMf6Up7cnGF9ulbrfLbQus4OEXBbbuA0n9QozjzbLqcRWnW/ktU+9h33qMarUK1qrJKdrXIO15kj1594OnaC0wicHGvoG/d1gYnLg8MC6G5kg93rmMO2v0JG2WGDhJ6L515kJ9z+o9A8mFpPnSXBUnudWIjbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODgrpEgI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODgrpEgI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790946506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W76JwHWwSP5UMXZ3360bvlY9alCmFcEj7PuZV/VZQ+k=;
	b=ODgrpEgIaxUYEGfBKN2ws5xEUBegAYYcVYqLHqEhXUXlr9jLJnTjMTqT/xFNpghuCglJvC
	87P08863f56385+6KAh8xqjnFoo4H5ih26F7QulLVXX4gWAs8p3gnyEd0Jesn17USj3nCB
	gx41CjOEbelHCBo+KFRCH5GbxGoIg1w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-DjAbGEWVPKWUXFJf5YJa2w-1; Fri,
 02 Oct 2026 09:08:21 -0400
X-MC-Unique: DjAbGEWVPKWUXFJf5YJa2w-1
X-Mimecast-MFC-AGG-ID: DjAbGEWVPKWUXFJf5YJa2w_1790946498
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 191BD195423D;
	Fri,  2 Oct 2026 13:08:18 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA267756;
	Fri,  2 Oct 2026 13:08:11 +0000 (UTC)
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
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Henry Tieman <henry.w.tieman@intel.com>,
	Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>,
	Preethi Banala <preethi.banala@intel.com>,
	Kiran Patil <kiran.patil@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-net 02/10] ice: fix IRQ freeing in ice_vsi_req_irq_msix() error path
Date: Fri,  2 Oct 2026 15:07:44 +0200
Message-ID: <20261002130752.2597259-3-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-1-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The vectors are requested with the q_vector as dev_id, but the error
path frees them with &vsi->q_vectors[vector], which is the address of
the array slot. devm_free_irq() finds no matching devres entry, warns
and leaves the IRQ requested. The unwind also tries to free vectors that
the request loop skipped because they have no rings.

Forcing request_irq to fail on the fourth vector during ndo_open gives:

  ice 0000:04:00.2 enp4s0f2np2: MSIX request_irq failed, error: -16
  WARNING: kernel/irq/devres.c:191 at devm_free_irq+0x30/0x40
  WARNING: kernel/irq/devres.c:191 at devm_free_irq+0x30/0x40
  WARNING: kernel/irq/devres.c:191 at devm_free_irq+0x30/0x40

and the three IRQs stay registered in /proc/interrupts while the
interface is down.

Pass the q_vector as dev_id and skip the vectors without rings, which
the request loop never requested.

i40e fixed the same mistake in commit 915470e1b44e ("i40e: fix IRQ
freeing in i40e_vsi_request_irq_msix error path").

Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f2121e79fca993..d246cde36ae726 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2582,8 +2582,12 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 
 free_q_irqs:
 	while (vector--) {
-		irq_num = vsi->q_vectors[vector]->irq.virq;
-		devm_free_irq(dev, irq_num, &vsi->q_vectors[vector]);
+		struct ice_q_vector *q_vector = vsi->q_vectors[vector];
+
+		if (!q_vector->tx.tx_ring && !q_vector->rx.rx_ring)
+			continue;
+
+		devm_free_irq(dev, q_vector->irq.virq, q_vector);
 	}
 	return err;
 }
-- 
2.55.0

