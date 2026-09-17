Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373533ACEF4
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671793; cv=none; b=fgY+FzY20e5XDqA6jtlYo2VD2e//Kw2bMH1jwOaNrvCwYKVlWXP74LEkeBhGtM2zbE4FpeVNVz2RiOdgGGLxLpyWRKrxGr5BHATmXPxMxFJjtQpKp9HvG/9wgD8DB51tkWD77bXc5v/lRUmLmBFXRedxIWmwrMogCpMwibClawM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671793; c=relaxed/simple;
	bh=2S0rVWQJ8oNV8WkWJmofi0bh5dxuvKW8egcOQQ0xvnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q6wXREAFbmL+fWH5fz6zmriO8I2rqwGwsL18gv1vG0fRFYbbVsHd3MdSKRC2SADuewwlGrfIBEowmfMJoFQStgyhB4/p+T0WDTFFwuYLgVpoRxsdcClr7XNvn+GQVtGcEodcU4k8idbPmPeo5vSLcWznkeNEtLg7D9LIJey8npY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5yT60Cg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5yT60Cg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789671790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vEpKdM9UdqRPamiH0lpl9OzTLcWcwBrdEdoeLPKinHQ=;
	b=J5yT60Cgq/obZ1SyABx9UiSL6gfr2AdowAhMEC+w7fl43ZDUlKK3bQsnvshcp2gEGRrn05
	8P5IKLQSkmF8Y65+Lx8hqQgYtL0IgU8y/UyNoy8FmtB9QTwScjaYFfTJDpOevc7Z3E8nvc
	UC8qGRVh0JzFeEKI9V7TsVUTp89guWI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-t0X3_cFXNpamsqq4JUK0PA-1; Thu,
 17 Sep 2026 15:03:06 -0400
X-MC-Unique: t0X3_cFXNpamsqq4JUK0PA-1
X-Mimecast-MFC-AGG-ID: t0X3_cFXNpamsqq4JUK0PA_1789671784
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DE8E197759D;
	Thu, 17 Sep 2026 19:03:04 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.1])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E6F719AC048;
	Thu, 17 Sep 2026 19:03:00 +0000 (UTC)
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
	Simon Horman <horms@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net 0/2] ice: DPLL init fixes for E810 timing boards
Date: Thu, 17 Sep 2026 21:02:56 +0200
Message-ID: <20260917190258.3239282-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Two fixes for E810-C timing boards the driver's static pin tables were
not written for, seen on a board whose netlist has no PCA9575 clock mux
and whose CGU reports more pins than the tables describe. The first
layout is a reference design of its own, Intel ships it as the
E810_C827_SyncE_SFP_SEC NVM configuration.

Patch 1 keeps the DPLL registration alive when the PCA9575 clock mux is
missing. Today the lookup fails and the driver gives up on the whole
DPLL, so userspace loses both devices and every pin.

Patch 2 stops the SMA and U.FL wrapper setup from indexing the input
and output arrays at fixed positions when the driver has already fallen
back to generic pins, where those positions can lie past the end of the
arrays.

Both are tested on an E810-T with the mux present, with the mux hidden
from the driver, and with the generic pin path forced, and on the board
above, where both DPLLs now lock.

A follow-up for iwl-next derives the generic pin names from the pin
classification the firmware reports, so such boards get addressable
pins instead of ambiguous numbers.

Petr Oros (2):
  ice: fix DPLL registration on boards without the SMA clock mux
  ice: skip the SW pin description on boards with generic DPLL pins

 drivers/net/ethernet/intel/ice/ice_dpll.c | 33 +++++++++++++++++------
 1 file changed, 25 insertions(+), 8 deletions(-)

-- 
2.55.0

