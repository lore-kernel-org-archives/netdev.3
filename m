Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3366C3C276D
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983281; cv=none; b=rM5r7W9JmfVF29i1uCEuT73yU2Vmr26vtWSuxAOcBIXwM7A1an2FBC5eK0uFK7LmumXBZ7axJqheAN9uPVdVwCRw3FV5UDxHkBQWYEN+PW0WPVDfANywlGPP2toCXPMmwEFnADVUIVGvY/rgrI91lVChMcktKWdZFcOVqc83kB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983281; c=relaxed/simple;
	bh=XOsrgetCiIuTO55k7XJ7PgwRSMN1IDTEyvKJl/tnhww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q9GPTYrsJJSGRMDhZqM4B35vz6ug6CN3bDraekz1b8mtEppyOQBmyNfjyOMtBHpehKVBFZx5Gd99Td8SBBz5WcdVRkAQD7u2PmL+wnfXdhnaDe8XIxhzUtho/Vi+wHo9HTAlOUWTnn2NPT2TE6eq5CB27cUsLAuqm6IOirf3uUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQ/0klcM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQ/0klcM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790983279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tu0YjfYqphuGAh+50piZI1qOn7Z5QsrurgPTQUPjYjM=;
	b=UQ/0klcMiSAxHYES3taPRvrZmcRw2+GNf3N+DYpgcDtoqBgBdB4WR3ZlTK4ZEHH4LjbJSh
	a40AGJbMvDBPuGuIIJ08GLRE2G8I67XiVtlz+jnTkhevxmL4ljsvZrzxPNWOmDoB/wuZtx
	WHuu9r0UDHhrtcVTYhB6AxECrjiUnBU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636--aDTHupaMxWd-SLi81gM0w-1; Fri,
 02 Oct 2026 19:21:15 -0400
X-MC-Unique: -aDTHupaMxWd-SLi81gM0w-1
X-Mimecast-MFC-AGG-ID: -aDTHupaMxWd-SLi81gM0w_1790983274
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B7E4180036E;
	Fri,  2 Oct 2026 23:21:14 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5825A756;
	Fri,  2 Oct 2026 23:21:13 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: edumazet@kernel.org
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC 0/2] dlm: fix socket hang on send buffer limitation with socket error
Date: Fri,  2 Oct 2026 19:21:05 -0400
Message-ID: <20261002232107.1578646-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Hi,

This patch series is based on Eric Dumazet's series [0] cleaning up
and fixing kernel users of SOCK_NOSPACE handling. His series pointed out
that DLM socket handling can get stuck when the socket send buffer limit
is reached and a socket error occurs simultaneously.

This patch series provides a fix for this behavior. I was able to reproduce
the scenario and trigger the hang locally. With these patches applied on
top of Eric's series, I can no longer reproduce the issue.

Please feel free to review and take these patches if they look reasonable.

- Alex

[0] https://lore.kernel.org/netdev/20260929071743.23624-1-edumazet@kernel.org/

Alexander Aring (2):
  dlm: drop setting SOCK_NOSPACE
  dlm: fix socket hang on send buffer limitation with socket error

 fs/dlm/lowcomms.c | 50 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 14 deletions(-)

-- 
2.43.0

