Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9EE2931CD
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055328; cv=none; b=fPkE70zOCkSt5L7Lxqq1DQosktMFSHixB7IhRlhRiqs3bDr8NFRv2ndbpmGondQDcEWAxGovRrtfLlWksk47wCsyaXl9w3PODtITU0KgYCeMnS9mB53xLMiIfgI2WJeVTIhDh8iEFKMn7DARooXmze9n0fTt27M5M+hLuyCw6ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055328; c=relaxed/simple;
	bh=DXjORYLqn6FS4x2xLqWwEhTG3mVnr+1SpW4c17iwBWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8JP44hL73qHw3BnA7/zO1kRQc3FkQ0zO6xUTSUzUFoGc023bLfjbbogn1xqeMv9/+pSzV+SUwdwBsQy3ZjUnuA0PiKS9IQiYT8KM4NQxHFqB6icCpOj5TF/FFNdkCSLSgWmTwvabdhj8jxXHRpa+UIjclXzWaGCEUChlf+Wrng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fh6hsRgK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fh6hsRgK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789055325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N7iZuQ/VHezjeP6B3/ktGKZlj30gnrnmze20SvvRGoc=;
	b=Fh6hsRgK6ZE9IxLwaHJmP1w6q0cGRpOvyhmZkKQV276Voapk9fgVoQrMzIWeadLakI8CWR
	kJzDizNHFjSmiNL4kNAsHvWmJ9lJL+9KurH8ZcoViT4EuK6ibkI8ZIRWTnSivYIcGqGBKi
	+w/N5QuADXUr0iwn3LsnGkrvmrRR0k8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-ksM_xiT-PjaO0lTE5395mA-1; Thu,
 10 Sep 2026 11:48:42 -0400
X-MC-Unique: ksM_xiT-PjaO0lTE5395mA-1
X-Mimecast-MFC-AGG-ID: ksM_xiT-PjaO0lTE5395mA_1789055319
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D756C1954AF0;
	Thu, 10 Sep 2026 15:48:38 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.48.140])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7821C433;
	Thu, 10 Sep 2026 15:48:34 +0000 (UTC)
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
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 0/2] ice: fix TC flower filter priority violations
Date: Thu, 10 Sep 2026 17:48:22 +0200
Message-ID: <20260910154824.3603687-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

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
with and without session ID matching.

Petr Oros (2):
  ice: fix TC flower filters matching more than the ip_proto key
  ice: don't offload drop filters that bypass higher priority filters

 drivers/net/ethernet/intel/ice/ice.h        |   1 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 187 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_tc_lib.h |  22 +++
 3 files changed, 201 insertions(+), 9 deletions(-)

-- 
2.55.0

