Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADAF41D13C
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885198; cv=none; b=fJIu4hxt2tS3uaV5PuW6MROK+oEmCwhoPQzLgE1ntkzePS4PnGo5GR3EKWVHGT60g7ZutP7rYYkYu7hnl/u0xosYdIw23qkXQVr8OAuma8UJSXGn2MjBDlPKME6/LXTDc11NDhkNICDZ/ZN3xOzVVSEZYUg4Er2htAXOJhL5a+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885198; c=relaxed/simple;
	bh=7D3aHK04wE6sXvlfxosjlV8ZOdypr4FirZ0Kpf2s0S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oookjPZnUvkDOXB9hTgOzIpwiKrXPK2Nv8IVPNpPOafg6mpUnK/CYT7nOirWRrg12WdSmlWdFpmiDJfb7uKyUpVWNu7AMZrhYltYitnPpSfeI1XNJU05sfe07rB01M7csySSVBWvmDsUr/+SaJw1FhWwK/uGpJkhtbpduIbVwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HX4Uxe6k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HX4Uxe6k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784885187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYnK0Xi5alH57XoYD4HGzgtJQBqdkxv67V6iZR7b2FY=;
	b=HX4Uxe6ktyYAwRez/Hu3dhSdVWfdv+8pwha2RUaXxT79QSMWuW5+hKKmGs3V+BfVz3H6IE
	NELPLeyw7q2MBSP0pheTcJTsw0+ClGsWHMDSmmKHdzjaY7JY46b1uFGeS2ucTinmygFjua
	iZZzx9sPG/7ivCVSQnalgLyFuq6KIEk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-D2EuB0mNOOC1bKc08WTxOw-1; Fri,
 24 Jul 2026 05:26:22 -0400
X-MC-Unique: D2EuB0mNOOC1bKc08WTxOw-1
X-Mimecast-MFC-AGG-ID: D2EuB0mNOOC1bKc08WTxOw_1784885180
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94C721944DE5;
	Fri, 24 Jul 2026 09:26:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.67])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 39464195605F;
	Fri, 24 Jul 2026 09:26:17 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH net-next 1/2] docs: netdev: clarify handling of idle patches
Date: Fri, 24 Jul 2026 11:24:04 +0200
Message-ID: <38b75373f813354ad0ee8bfde12ae5a42e9a11b6.1784884817.git.pabeni@redhat.com>
In-Reply-To: <cover.1784884817.git.pabeni@redhat.com>
References: <cover.1784884817.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Off-list pings are very bad, but unfortunately too common. Explicitly
state that, so that at least LLMs could learn it.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 Documentation/process/maintainer-netdev.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index ec7b9aa2877f..e58f541c29e0 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -210,6 +210,10 @@ landed - describe your best guess and ask if it's correct. For example::
   I don't understand what the next steps are. Person X seems to be unhappy
   with A, should I do B and repost the patches?
 
+Don't reach out to maintainers or reviewers via private email and/or other
+communications channels: all the discussion must remain public, and
+requesting special attention is unfair towards the community, at best.
+
 .. _Changes requested:
 
 Changes requested
-- 
2.55.0

