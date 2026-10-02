Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3149E5CF
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946557; cv=none; b=DbjZncv4Sp2FCFTwQq0QkX+HKPS9wi5yDIz3jkpnDN80Q2UEY5vIl8k9VyBd8xTdS7u62G5ajtEIeXXBKQR/1KPZaYBVuO5L+2mR1M5K/F5VagzhIGPqgYawHkRq5KU/jz2aGyjXwZuD/kNhodKC4CoHx/PAoz9aNu2FKpZ5P7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946557; c=relaxed/simple;
	bh=5hN9I3d8osWGPWiJY0ECo+kf/9PAeFMiY5hRNomZptU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSKQPS8mVLBbpkUQ1EMT+Bs9feML6gO8wWniojGfGnER+/K/PsmbNPa53XXBiBP0PbsMP1k03pYbKKCTex6+e4s9jUPJnQPQpDXAmalTl9JXBdM+eIeBOO2iq89WGKUaWymvbuYdZA4ZdUbiwcJIw9TZL1wAjCIxKM6XBQGTI6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLRLMOTk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLRLMOTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790946552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQtzdWNTV0tMfsyTkPk+NOiHXf+br2RgeU5G2y5qWNg=;
	b=iLRLMOTkqGOCfvtim+uE1gyFYaxyTiR0Ij7ZLT9PkexLXQrAE1qK6OpgrqHvfKu15rO+hL
	6zHM40WRQNoFftmgKw46IZGea3WLc87l4XpDsMmzeSvwF1t3lfNSnp9I6VhS8eCo44vxmI
	IjNrVqoEMV7DJJc+uGGa1+lpDyOcYGM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-ax1nOW4_OsmLAF3LTgxXcg-1; Fri,
 02 Oct 2026 09:09:08 -0400
X-MC-Unique: ax1nOW4_OsmLAF3LTgxXcg-1
X-Mimecast-MFC-AGG-ID: ax1nOW4_OsmLAF3LTgxXcg_1790946544
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06DA618F5292;
	Fri,  2 Oct 2026 13:09:04 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4825433;
	Fri,  2 Oct 2026 13:08:57 +0000 (UTC)
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
Subject: [PATCH iwl-net 09/10] ice: program multicast magic wake before tearing down the main VSI
Date: Fri,  2 Oct 2026 15:07:51 +0200
Message-ID: <20261002130752.2597259-10-poros@redhat.com>
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

Since commit 5b246e533d01 ("ice: split probe into smaller functions")
ice_remove() calls ice_setup_mc_magic_wake() after ice_deinit(), which
frees pf->vsi. ice_get_main_vsi() then returns NULL and the function
returns before it sends the Manage MAC Write command, so multicast magic
packet wake and keeping a locally administered address across the PF
reset are never set up on shutdown with WoL enabled.

Program it before the netdev and the VSIs are torn down, as it was done
before that commit, so the current netdev address is used again.

i40e had a similar problem, where the multicast magic wake setup ran
after the admin queue had already been shut down, and fixed it in
commit e661414c98df ("i40e: Remove duplicated prepare call in
i40e_shutdown").

Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ceb9fec2af21e7..a885b3e0baaa5d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5456,6 +5456,8 @@ static void ice_remove(struct pci_dev *pdev)
 	if (!ice_is_safe_mode(pf))
 		ice_remove_arfs(pf);
 
+	ice_setup_mc_magic_wake(pf);
+
 	devl_lock(priv_to_devlink(pf));
 	ice_dealloc_all_dynamic_ports(pf);
 	ice_deinit_devlink(pf);
@@ -5466,7 +5468,6 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_deinit(pf);
 	ice_vsi_release_all(pf);
 
-	ice_setup_mc_magic_wake(pf);
 	ice_set_wake(pf);
 
 	ice_adapter_put(pdev);
-- 
2.55.0

