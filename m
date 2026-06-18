Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B43FBB47
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795383; cv=none; b=NELwNTMRvlkIapJCVVriD6V3ERskTaWu2a6VGpbOiaTg07RARggCAruHCsGUCRwjRwrDTXZqkyt+Z516Uo3tFEg2yyn9GV7nCpqjWja+Udxxa3GCmXBPZjn7c8iGgXtiVh8jx2y+LaJYLaS8nIi2PmGgvZPWWiDQ6C0Bcn0slhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795383; c=relaxed/simple;
	bh=P4a5L+pxLj9M6no31bX83R77apuWeXqglYwceEj3k0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNW5LxlZIDtQ/Us1rogbPdnNgjh+3e50mRnPIS3qxCLtDkj78aHXZgxhcmYyJ8oAqWP18wszgm4LY6ctWkQpzU8bL+ARux+wuJWZtQAab88Q3+ds02RyfhPJZvO6sky5lzN0MzrHRLqlPM4vfKCBABGvK6pVSVYZQtblQfoaxPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHxTbuLq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHxTbuLq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781795380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8kwvym+FwOGhsUuGGMnEIFmKIYJtNtuISVIci+MTjJ8=;
	b=LHxTbuLqtmCg+oEWs+mWuqjCJy5zYHly0JNPyizYQ4S+Et/59ccoqoWwOHQ4pB8XW2AKYj
	ecX9psZp/WWD7a331Wka23nM/5qV2W/Mn98KHYNXhAicAKHfGLnRrB5rVUa5T4Z9vqZ3Lb
	tjewLRl8uXe64FaSnjW/W80QSuHGiDs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-m3J3Hl3jPxeOh9tBvIrBbQ-1; Thu,
 18 Jun 2026 11:09:31 -0400
X-MC-Unique: m3J3Hl3jPxeOh9tBvIrBbQ-1
X-Mimecast-MFC-AGG-ID: m3J3Hl3jPxeOh9tBvIrBbQ_1781795360
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A5011800595;
	Thu, 18 Jun 2026 15:09:19 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.243])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1ED91800664;
	Thu, 18 Jun 2026 15:09:14 +0000 (UTC)
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net 0/2] ice: fix DFLT Rx rule handling for promisc and switchdev
Date: Thu, 18 Jun 2026 17:09:09 +0200
Message-ID: <cover.1781786935.git.poros@redhat.com>
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

Lab tested on E810-C: functional, VLAN isolation, IFF_ALLMULTI
regression, stress/flap and switchdev-toggle suites pass with no AQ
errors, and the FLU pool stays under its ceiling with all four PFs
loaded.

Petr Oros (2):
  ice: skip per-VLAN promisc rules when default VSI Rx rule is set
  ice: preserve uplink DFLT Rx rule on switchdev release

 drivers/net/ethernet/intel/ice/ice_eswitch.c | 32 ++++++-
 drivers/net/ethernet/intel/ice/ice_main.c    | 90 +++++++++++++++-----
 2 files changed, 98 insertions(+), 24 deletions(-)

-- 
2.53.0

