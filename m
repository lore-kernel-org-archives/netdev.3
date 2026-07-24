Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2813EFFD1
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885194; cv=none; b=kaefo+aSn2cCmYV6pSmgiH32IHAg8gNALzlNFxADlMG41qHEVSoxsvRaVe+fXABVdi6+V+U6Hzo48Qa9+NehdHz/W1VaLZwI2j9J4quhWLdrWmuWFAUYuZJDDFS1omrVuLaFp1mn5rDiT5Wjp6IdPcp52wnQSMGT8z5AAXLuveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885194; c=relaxed/simple;
	bh=Kp4euQFZSvAc6qLTWgt6t3jXjkTLAzWeK0v6TjI7B2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsrT8dUKrfv3KTTkVXjP2JAYkfifnzz7EF0dgDTey/hAyhG92BRYnVgxXYZI/6dnCf7kX/8zw+9vDD5lc4GSTRY1Ud+u8taXctPEnHetv2kCe4IUsRhxs3wUJ5ZOuv1kvK69RwbS+rjvIEOShJbHjvkb3VJcNST6inkpuoLUIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrN3RcEj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrN3RcEj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784885187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W32rqFfj/F/TTa7grLywwxJMLHzsB6IgmSEspxwYjsI=;
	b=KrN3RcEj7VbX0BXDgZ4Km8dWez5TcSMldflTZ5ah2KHhEfxkXzHPzUXgufj1n7I24/I0H4
	ciFISmV4zgXjuNUraoxsGDw08c4AGAMwloNHw5R8QFWUT+M7LYohjpLwGoArm/Uv4mS+4g
	WuzwqtR6GrSFXs+EBW1p7880yx3EbyA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-AT2CvQy9PqSxk2PQQvcsQQ-1; Fri,
 24 Jul 2026 05:26:24 -0400
X-MC-Unique: AT2CvQy9PqSxk2PQQvcsQQ-1
X-Mimecast-MFC-AGG-ID: AT2CvQy9PqSxk2PQQvcsQQ_1784885183
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93D011944DE9;
	Fri, 24 Jul 2026 09:26:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.67])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1231C1956061;
	Fri, 24 Jul 2026 09:26:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH net-next 2/2] docs: netdev: clarify expected interactions with LLMs
Date: Fri, 24 Jul 2026 11:24:05 +0200
Message-ID: <83360de7addb13a3b5f4d5e722148f248fdb2ae0.1784884817.git.pabeni@redhat.com>
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

The official documentation has not captured yet the current impact of
AI-generated reviews on the patch process.

Explicitly state the status quo and expectations.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 Documentation/process/maintainer-netdev.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index e58f541c29e0..1739d9f856c3 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -203,6 +203,22 @@ For RFC postings specifically, if nobody responded in a week - reviewers
 either missed the posting or have no strong opinions. If the code is ready,
 repost as a PATCH.
 
+There are 2 services actively providing LLM-generated review on posted patches:
+
+- https://sashiko.dev/
+- https://netdev-ai.bots.linux.dev/sashiko/
+
+both use the Sashiko infrastructure on top of different models. Reviews are
+available after 24h. Patch authors are expected to proactively look into the
+AI-generated reviews and handle such feedback as any other kind of review:
+either debate it or address it. In both cases a reply on the mailing list is
+expected.
+
+Authors are strongly encouraged to run LLM reviews on the posted patches in
+advance of the actual post. Large series triggering a significant amount of
+AI-generated feedback will likely get little attention from maintainers and
+reviewers.
+
 Emails saying just "ping" or "bump" are considered rude. If you can't figure
 out the status of the patch from patchwork or where the discussion has
 landed - describe your best guess and ask if it's correct. For example::
-- 
2.55.0

