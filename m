Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E9F49C4DD
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946542; cv=none; b=Jzmyn/PlCnnW6G9hwKT3yiGlaHxSaeytLdnQLSIPDx7KOyFGt0gFRl2VGzU8ItQSO5i53wPyOpbKyiOJUkHaz4AdLvIuY2pbgSIayvFyAk8LexuAJhMBYVLpXRZOlpdX8Acfum+UyfuaIydbi992SDup+1JGU5xte+1M9Aa+544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946542; c=relaxed/simple;
	bh=JZbZ1gDJTGYtB97/ftYBiUi4XE3J5NHIhXFYh5eucHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgbOwjeDV4IyvLcqcx6PsLucNLODtW5EdZECHxoL3d8XzyvWhQFB6Qlla0NdeyP3iyjHjLtqVOSFI0Qlpw/7ZRaRmfNA2SiJN+ElmfKqD2st9Jtrq0Okqoa2qetGHBenUCMoYLWob7SQC4jPvghzOz9OKUSeeHOnqiy4i2X6MK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vw/QFVo9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vw/QFVo9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790946534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVAaLUhTqMoBr0N22nVTfsPLBxCK3PYhH7rimPVG0u0=;
	b=Vw/QFVo9gJJxtNOIYN+fmhhBTMh+v/78kYV2/GGtimdsAxFnexoYDVc05jp4SOjN4823Cz
	450hrV4dRXclDzB31HVDDK675FB0Zzn0dvpuSc4BG2gKYNYIzIwXgJQDzQW512/LOCQn5q
	1T5BOgojlLlRnjGyui9QCsEOPc2ySJk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-eqv7YGLcP727CC3BAZGHdA-1; Fri,
 02 Oct 2026 09:08:47 -0400
X-MC-Unique: eqv7YGLcP727CC3BAZGHdA-1
X-Mimecast-MFC-AGG-ID: eqv7YGLcP727CC3BAZGHdA_1790946525
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3401195423D;
	Fri,  2 Oct 2026 13:08:44 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B627433;
	Fri,  2 Oct 2026 13:08:37 +0000 (UTC)
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
Subject: [PATCH iwl-net 06/10] ice: keep adding MAC filters after one that already exists
Date: Fri,  2 Oct 2026 15:07:48 +0200
Message-ID: <20261002130752.2597259-7-poros@redhat.com>
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

ice_add_mac() returns as soon as one entry of the list fails, including
-EEXIST for a filter that is already programmed for the VSI. The rest of
the list is never added. ice_vsi_sync_fltr() treats -EEXIST as success,
so the skipped addresses are considered synced and their traffic is
dropped until they are removed and added again.

In a test that adds 50 multicast addresses to a port in a burst with
the port MAC address in the middle of it, 19 of them were left without
a filter.

Continue with the next entry on -EEXIST and report it once the whole
list has been processed. Other errors still stop the loop.

There is no i40e counterpart of this fix, i40e keeps its MAC filters in
a hash with a state per filter and syncs them differently. It was found
while building a reproducer for the MAC filter overflow handling that
i40e fixed in commit e58872398684 ("i40e: fix disabling overflow
promiscuous mode") and commit 7363115efb04 ("i40e: do not force filter
failure in overflow promiscuous").

Commit bbb968e8b34c ("ice: Fix issues updating VSI MAC filters") dealt
with the same problem for the VF MAC filter requests, which are now
added one by one with -EEXIST tolerated, but left ice_add_mac() and the
PF filter sync as they were.

Fixes: 89f3e4a5b762 ("ice: Do not bail out when filter already exists")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 2ee5cb6ffdab1f..239d4d9633baa6 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3659,7 +3659,9 @@ int ice_add_mac(struct ice_hw *hw, struct list_head *m_list)
 
 		m_list_itr->status = ice_add_rule_internal(hw, ICE_SW_LKUP_MAC,
 							   m_list_itr);
-		if (m_list_itr->status)
+		if (m_list_itr->status == -EEXIST)
+			status = -EEXIST;
+		else if (m_list_itr->status)
 			return m_list_itr->status;
 	}
 
-- 
2.55.0

