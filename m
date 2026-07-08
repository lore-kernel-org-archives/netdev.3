Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E647278C
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515495; cv=none; b=KkzxHEpRVPpe5jq+GVrgY5SJ3kVPKSjd2+mEoa7vECMZDQAskeQ1AR8d55Lrv2LlWYZ4xlHu1Ac0COnPf+zs2ehd78Eb6361TnjAPznma6//z4JDfpe3QzfwEUp2vAiGYSzERG2QdEpX7FyB8MmIM3fXliC7ar85AeW3i5lxeb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515495; c=relaxed/simple;
	bh=PyMUkZnvcmSh+OET/HLKeOQgPZMzxWjHDmuE3jKR6gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkIzf/9d9TsU9gnmKjSqQy+4sJeyKPnhxf1BTWoPnyqaiV3PwkCrS8KkHbtqfjZYvcc5fpXxLJOYZfb54dOi/gKiYXrUFpusYDCLUX93q5DEs1Kre1SevwOPkrA17VTE9E0S6Wo9S6fNhAlZcXYRSo/FW874d6iTc8/MRpNbvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8lItzsx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8lItzsx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783515493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BLgBgJN9EqlAOqychU5vXfjB3advBYSTj0htBbDTCPs=;
	b=a8lItzsxxHnX5uuKkL2DTzG8UjwaDjYLqDtPH/VBtxsZ9bg6YxGV1LclQv4uYQk5UjaZN1
	GD+f37b7Xjt4uPVJbeASj97fowmUobor3x4X2bwFktcLFYLyESAaQp9xktfuQwb/QIL6ku
	nO9fcn4cyJ+/OO74t41i/gBSpKnqrjg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-tnxuQ_uHPMCg4YPSlnQ5rg-1; Wed,
 08 Jul 2026 08:58:07 -0400
X-MC-Unique: tnxuQ_uHPMCg4YPSlnQ5rg-1
X-Mimecast-MFC-AGG-ID: tnxuQ_uHPMCg4YPSlnQ5rg_1783515485
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CABC3180063A;
	Wed,  8 Jul 2026 12:58:04 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.48.104])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95F981800591;
	Wed,  8 Jul 2026 12:57:58 +0000 (UTC)
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
	Alice Michael <alice.michael@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v4 0/2] ice: fix DFLT Rx rule handling for promisc and switchdev
Date: Wed,  8 Jul 2026 14:57:53 +0200
Message-ID: <20260708125755.706263-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Two fixes for the uplink default VSI Rx rule (DFLT) on E810 when the
netdev is in IFF_PROMISC.

Patch 1 drops the redundant per-VLAN promisc expansion that exhausts
the FLU pool on a wide VLAN trunk across several PFs.

Patch 2 keeps the DFLT Rx rule across a switchdev teardown instead of
clobbering the promisc state the operator asked for.

Changes since v3 (review comments from Marcin Szycik):
- Patch 1: reworded the ice_clear_promisc() and the per-VID cleanup
  comments, and flipped the ice_vsi_clear_vlan_mc_promisc() guard to an
  early return (noting the clear is best-effort). No functional change.
- Patch 2: no change, added Marcin's and Aleksandr's Reviewed-by.

Link to v3:
https://lore.kernel.org/all/20260701133601.2118382-1-poros@redhat.com/

Link to v2:
https://lore.kernel.org/all/20260622113428.2565255-1-poros@redhat.com/

Link to v1:
https://lore.kernel.org/all/cover.1781786935.git.poros@redhat.com/

Petr Oros (2):
  ice: skip per-VLAN promisc rules when default VSI Rx rule is set
  ice: preserve uplink DFLT Rx rule on switchdev release

 drivers/net/ethernet/intel/ice/ice_eswitch.c |  18 ++-
 drivers/net/ethernet/intel/ice/ice_main.c    | 109 +++++++++++++++----
 2 files changed, 102 insertions(+), 25 deletions(-)

-- 
2.54.0

