Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDC03AF65A
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281132; cv=none; b=i5BB3U8bVF1ySNuI12L5btLfaQQZbcvp5LSZQUlHnIDT51bvfpY6ps8LHdEDtxgBbrdncQWhwrbqFRJzCzEUJ+f58a9Nt78dwE0nDrcpVjemhEZnMf1P0Atjq3Pj7NtXJbMBUUpomLDXlKBjwEtSJvRlwCx/qLuKAhsfijJOOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281132; c=relaxed/simple;
	bh=rvvF+yzBzAxhDu5LH1UHGg3bCe4nQ0sXGgcT7zH03N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryHBYLlqrgCQ4VmusnZoH+vpb0LfxP7iivKyJBFVcFNzrcbX3TawXbS+8IKXUAR0bQPbvOQh4EcQn+LVzZDNOw1Z/hYfAOU4rENKbivPJ1TdFc0GeD3SeFpo5rLXmUYmGmIwHycze2/gd84T17x87gWo1HcNu99LZG+iKERsuOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmlunCwL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmlunCwL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777281128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nxu8EEl/NSWtPFSsHpu2gcxuc2ncIwFUJimar90n8NA=;
	b=ZmlunCwL3XabfOsUXGV8hfFsDqmG/bVhfd9P1ho0oJ4YY7TOVReNytrvXAZraV6vCSJLTQ
	AZ2ML23P35gtpcQTIYlzKN/GBZtgcdwMdXYLM+14jnVs4VPuWR4WEKNprOwOtrba8vUp3U
	IA87od7HNlNJpR3gJ248RZr11/EALys=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-8kmpqUAEPUmG_aAUQJJJGA-1; Mon,
 27 Apr 2026 05:12:04 -0400
X-MC-Unique: 8kmpqUAEPUmG_aAUQJJJGA-1
X-Mimecast-MFC-AGG-ID: 8kmpqUAEPUmG_aAUQJJJGA_1777281123
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 724431800609;
	Mon, 27 Apr 2026 09:12:03 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.44.33.10])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3137E1800446;
	Mon, 27 Apr 2026 09:11:59 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	pabeni@redhat.com,
	Adrian Moreno <amorenoz@redhat.com>,
	dev@openvswitch.org (open list:OPENVSWITCH),
	linux-kernel@vger.kernel.org (open list),
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 0/2] Decouple flow operations from RTNL
Date: Mon, 27 Apr 2026 11:11:46 +0200
Message-ID: <20260427091153.3210301-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When RTNL is contended, network-related control-plane operations can be
delayed.

In such scenario, if OVS control-plane operations (such as vport
creation) take a bit longer, it's acceptable. However, flow installation
operations happen as part of upcall processing, executed in the context
of of handler threads. If they get delayed, it affects the data-plane
and can even result in packet drops.

Because flow operations also use ovs_mutex for concurrency protection and
given RTNL can nest under ovs_mutex, contention can be easily transferred
from RTNL to ovs_mutex, causing delay in flow operations.

In order to protect flow operations from RTNL delays, this series
decouples them from ovs_mutex. First, the flow_table is converted into an
rcu-protected pointer. Then two locking mechanisms are introduced: a
per-table mutex and a refcount.

The mutex protects the flow_table against concurrent modifications,
while the refcount is used to extend the lifetime of the flow_table
beyond the rcu read-protected region used to dereference it.

v3:
- Split in 2 patches (Paolo)
- Improve locking in get_dp_stats (Paolo and Sashiko)
- Use __always_unused in lockdep stubs (Paolo)
- Use READ_ONCE/WRITE_ONCE for table->count (Aaron)
- Take a reference in ovs_dp_masks_rebalance (Aaron) 

v2: Fix argument in ovs_flow_tbl_put (sparse)
    Remove rcu checks in ovs_dp_masks_rebalance

Adrian Moreno (2):
  net: openvswitch: make flow_table an rcu pointer
  net: openvswitch: decouple flow_table from ovs_mutex

 net/openvswitch/datapath.c   | 293 ++++++++++++++++++++++++-----------
 net/openvswitch/datapath.h   |   2 +-
 net/openvswitch/flow.c       |  13 +-
 net/openvswitch/flow.h       |   9 +-
 net/openvswitch/flow_table.c | 194 ++++++++++++++---------
 net/openvswitch/flow_table.h |  56 ++++++-
 6 files changed, 396 insertions(+), 171 deletions(-)

-- 
2.53.0

