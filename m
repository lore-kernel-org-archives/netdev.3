Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588D48A2BE
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002697; cv=none; b=LSHppXIYrKFxbQKlVtOfzTmHKXhF4LlaRUxMEDWmA9p2s+dVjM8zs/qnoPJXkXNVpLG6+o/MVDuKeikqu0HMbvV/MwxYzQsCa5cA/6Iy4rnUWv1DfWrtWwYRdu2cLQWa6jnK1rfvKsPksNoBkOhBt2mFtHiZuiGfAXf4szvoSzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002697; c=relaxed/simple;
	bh=9UYDg2NtKSYx0cAymNYgrRU3tRNoT6ojnkckLTkJrOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zctk8TYJwiupACEDzXYPblSw9jLxO9ZLGFPT9Ib0PT2nolnFGOwMrtNI7f57hSbu6axK88t6aqumDg6L7uOr3skiAswYG31BG8N/lQb0sDzuXdeIB6xT2WCLIKz6T3V+f1DeTHdOpjH+XR/nG8GLfGZcdz4RaZD48Dg0+rNYc7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKfBm+/s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKfBm+/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769002695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+t5ikSuWWuMge/uJAfw1c8Rur5ydyVTP3mADUQkPvs=;
	b=jKfBm+/slo39ojML0Wshr09zoM+BBpyXt8u00oh7CQSKNZNOdfV+Ihm12bkDayrZfWOBji
	fD4Udi8fiMM1Ry/HvzFnNVjX5EilEwEvMrxXkYjV28CP+XbJhXeRgqc16JyhDJLODR75Xi
	CwxLzFWEp1RRAqkOSud60oYTHCbSa+Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-D_vLlJ-dOX6HFdKv9xfYIw-1; Wed,
 21 Jan 2026 08:38:11 -0500
X-MC-Unique: D_vLlJ-dOX6HFdKv9xfYIw-1
X-Mimecast-MFC-AGG-ID: D_vLlJ-dOX6HFdKv9xfYIw_1769002690
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0034B1954B1B;
	Wed, 21 Jan 2026 13:38:10 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.33.242])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A1B630001A2;
	Wed, 21 Jan 2026 13:38:06 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jkarrenpalo@gmail.com,
	tglx@linutronix.de,
	mingo@kernel.org,
	allison.henderson@oracle.com,
	petrm@nvidia.com,
	antonio@openvpn.net,
	bigeasy@linutronix.de
Subject: [PATCH net-next 9/9] MAINTAINERS: Assign hsr selftests to HSR
Date: Wed, 21 Jan 2026 14:37:36 +0100
Message-ID: <8f44e4f6e7715f0e6e35d67eae41e01664020405.1769001553.git.fmaurer@redhat.com>
In-Reply-To: <cover.1769001553.git.fmaurer@redhat.com>
References: <cover.1769001553.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Despite the HSR subsystem being orphaned at the moment due to the original
maintainer being unreachable for a while, assign the selftests to the
subsystem for the future.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e36689cd7cc7..b973b88f9192 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11461,6 +11461,7 @@ HSR NETWORK PROTOCOL
 L:	netdev@vger.kernel.org
 S:	Orphan
 F:	net/hsr/
+F:	tools/testing/selftests/net/hsr/
 
 HT16K33 LED CONTROLLER DRIVER
 M:	Robin van der Gracht <robin@protonic.nl>
-- 
2.52.0

