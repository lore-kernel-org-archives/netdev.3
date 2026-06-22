Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993502C0260
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128079; cv=none; b=u6ckHVTykUSSfHdtIjVM60A2l5EPWCmJ7HUCSBmUoTGKP/eE1eQNgFi+ndDLV3ZwHuZI58El+8sVSoEPwONV4EmmEuJZDoDlkI3V2or5MsrzPH5X72rbj31Doh8Ov1HEiLGg89v8BHiR6h7MeAqQbPBSsGcT70ZwQLvixa3sr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128079; c=relaxed/simple;
	bh=7AyaE7dlqIpv+p4UqSjjUZWRBDykwn+W0zrWfjRjJ68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g05Vy1xq2SCHN/iZ2dAs/oHbcigRda61tEUTIamKL1BE3fNpVLap2ajC4o0F9wZp9nPrgLR2WEMxdgNK3/l+gx4wsmHDjAMKIbaR3jcIyYBFMoYrTbbpgFrTqgAlXfYPJVxyNBWnpZ/OAhn4wRnE2c+a3z2UvuYpkNb9XxU8XWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhhnndO9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhhnndO9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782128077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XOFM6abGX4+5COwBd2vN6B30fcL12g1ozNGw26r98DM=;
	b=OhhnndO9x1PP7XB0EYyNtpsrdjczMg8of0iUb3HB0m1y+7+oWzZls7EMqjranKafhoa1zK
	5MRHu4t0Q7V66FRW5K3RbtED1S5KyQHNc+OmHGLRpZvinVCgl+fAm4E482R8lB+PAo+YLs
	1IPQsaUtQX0tHsfyYj73Mi3wAKAxF9w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-tBkleTrwOwOrqfiWQtDVOw-1; Mon,
 22 Jun 2026 07:34:36 -0400
X-MC-Unique: tBkleTrwOwOrqfiWQtDVOw-1
X-Mimecast-MFC-AGG-ID: tBkleTrwOwOrqfiWQtDVOw_1782128075
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FD991944CED
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:34:32 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.33.83])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79557195608D;
	Mon, 22 Jun 2026 11:34:31 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>
Subject: [PATCH iwl-net v2 0/2] ice: fix DFLT Rx rule handling for promisc and switchdev
Date: Mon, 22 Jun 2026 13:34:26 +0200
Message-ID: <20260622113428.2565255-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Two fixes for the uplink default VSI Rx rule (DFLT) on E810 when the
netdev is in IFF_PROMISC.

Patch 1 drops the redundant per-VLAN promisc expansion that exhausts
the FLU pool on a wide VLAN trunk across several PFs.

Patch 2 keeps the DFLT Rx rule across a switchdev teardown instead of
clobbering the promisc state the operator asked for.

Changes since v1:
- Patch 2: reworked to avoid the service task entirely. v1 scheduled a
  filter sync in ice_eswitch_disable_switchdev(); that work could run
  after ice_remove() freed the uplink VSI (use-after-free) and was not
  guaranteed to fire if ice_set_rx_mode() never ran again. v2 keeps or
  drops the DFLT Rx rule synchronously in ice_eswitch_release_env() by
  testing the live netdev->flags IFF_PROMISC, the same value
  ice_cfg_vlan_pruning() already keys on. No service task is scheduled
  and no symbol is exported. Dropped Aleksandr's Reviewed-by since the
  fix mechanism changed.
- Patch 1: no functional changes, collected Aleksandr's Reviewed-by.

Link to v1:
https://lore.kernel.org/all/cover.1781786935.git.poros@redhat.com/

Petr Oros (2):
  ice: skip per-VLAN promisc rules when default VSI Rx rule is set
  ice: preserve uplink DFLT Rx rule on switchdev release

 drivers/net/ethernet/intel/ice/ice_eswitch.c | 18 +++-
 drivers/net/ethernet/intel/ice/ice_main.c    | 90 +++++++++++++++-----
 2 files changed, 84 insertions(+), 24 deletions(-)

-- 
2.53.0

