Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B6A511E98
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569713; cv=none; b=ikV5RMG1SP9euvpjsG0gT36m0at7x4tXhuLQGGERfqyNkee7bMQ8+YkajTEsXzFduMSKty/CiYFEcFNuxp77nQ+G8XwUJKWZvcVVbRSu98MlZryi4DdvSiY0spIywyIIixSk5GWCtwosTcoWONJDexp+90g4uk7Dk0zd19Jm4wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569713; c=relaxed/simple;
	bh=moiy6+YWVQ+AXviR1SUHeLMd5bSq2uR3B4JfAWdZleA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SH2yRn1aF5zn5AHqajwGRDHj5CO9gTQ+avOPix0e0vl9n+WlQ9qnrN2WJYv2cT9XoJjlbIeq8XgeyGwwtYvq3Z8tJp4hSYVZjeozDqH7M2+j44wQ7F2Rl+Ctlc9Su3HR1U1XcJyGMSC+nZQQwyOGwkpMbCiEmYuuTMuYhuiS7Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COIf5n1r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COIf5n1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789569711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sFlWEYEuFEzStzCucMbgaPBHMyfR9qMQvTp/sk32Kd8=;
	b=COIf5n1rifinEEFK/KvSV9/Px2nrHWapRooB7UgIdN7T9jkjKhYA8N43Wjn1D97PGGECFJ
	fcopwnwQOvB75/ya9Sp+Grc+gALTPF3fcy7Tbs2tK+gNTaHzI3i/WPkUkvjFrLmT1oVfgW
	A7buAdncwNVptZaUdUJ2IIuDVLkeLG0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-ntJ2QdPXNYyZFbfPHfBWfw-1; Wed,
 16 Sep 2026 10:41:47 -0400
X-MC-Unique: ntJ2QdPXNYyZFbfPHfBWfw-1
X-Mimecast-MFC-AGG-ID: ntJ2QdPXNYyZFbfPHfBWfw_1789569705
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA89E18A6962;
	Wed, 16 Sep 2026 14:41:44 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.1])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 425E819560AB;
	Wed, 16 Sep 2026 14:41:38 +0000 (UTC)
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
	Priyalee Kushwaha <priyalee.kushwaha@intel.com>,
	Kiran Patil <kiran.patil@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 0/2] ice: fix TC flower filter priority violations
Date: Wed, 16 Sep 2026 16:41:28 +0200
Message-ID: <20260916144130.2699902-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Two fixes for TC flower offload in the legacy switch mode. Both
address the same user visible failure, all traffic on a port silently
disappears after installing a filter chain that mixes offloadable and
non offloadable filters.

The first fix covers filters matching on ip_proto alone. The driver
never programmed the protocol lookup, so a filter like "ip_proto udp
action drop" was installed in hardware as a match on eth_type ipv4 and
dropped every IPv4 packet.

The second fix covers the interaction between software only filters and
offloaded drop filters. The E810 switch gives drop rules absolute
precedence over forwarding rules regardless of recipe priority, so a
lower priority drop offloaded into hardware overrides any higher
priority filter that stayed in software. The driver now tracks filters
it could not offload and refuses to offload a drop filter that would
bypass one of them, keeping the drop functional in software instead.

Tested on E810 with the OS default and comms DDP packages, including
the original reproducer from the report, L2TPv3 pass and drop chains
with and without session ID matching, and a shared block bound to two
PF ports.

---
v2:
- track one entry per cookie and filter_dev pair so a shared block
  bound to multiple devices is protected on every binding, and the
  delete path drops one entry per DESTROY invocation (sashiko review
  via Simon Horman)
- collect Reviewed-by from Aleksandr Loktionov on patch 1

v1: https://lore.kernel.org/all/20260910154824.3603687-1-poros@redhat.com/

Petr Oros (2):
  ice: fix TC flower filters matching more than the ip_proto key
  ice: don't offload drop filters that bypass higher priority filters

 drivers/net/ethernet/intel/ice/ice.h        |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_repr.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 196 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_tc_lib.h |  24 ++-
 5 files changed, 212 insertions(+), 13 deletions(-)

-- 
2.55.0

