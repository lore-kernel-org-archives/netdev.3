Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DFC3FB7D2
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773340572; cv=none; b=mPCLWkGajey7HOSefNnxzR9eydGusu2DgDMFNl/5YokcxYnkiH12SViknwHCN2uYimNDp4FqD0xH6zKWpvVx7U20ivHFJ2HfPn6YNXjRtGN9+fiY+lgKiYEyjiQIxCi7tl3UZRECPtf3mAdT+lIJzQbTlKWpTdVc09xcICvoSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773340572; c=relaxed/simple;
	bh=/5vfMWpgCKCseU9LBmPcKYOKOtJwradcFuOEu5ltkHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sq7rAS4XyGNsPIoc1Hdi8E5Hsg+mwkueIbFTZFh0T0cvwdyp/+xpYa8SgtYMerP3jqJ63T+Ev5+nxqrd/QIfoFLii1r3HXqulTFdju9aCJiFnjyUxKPPbQ9NOCQk9JsNLJORQ0lJ64RIlfn3R/tk1kVZk9hVNv/lGi84V7PaV3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eq+5MwA5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eq+5MwA5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773340570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v53NECPPfKFXRU01LnlwSY/I0xJH84s3Gsl6hj9nZU0=;
	b=eq+5MwA5f0LKfz0rJR0ciS2p1to9ZTkMKhX0gthvg1GIEP8mmVUT+Wl4YsY3OBZYKqjmkK
	/l9IOrzTMWk8KTysBr7r8Z5dkQuHKa6UOQMJqyXWOWIaQ+Z1Gkjdz28ASXsreZox+iNyR0
	vqv/116vhRjFXKyoY9lp3aQG+hQ7jC4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-q5tjxeq2MKGbdClVla46JA-1; Thu,
 12 Mar 2026 14:36:06 -0400
X-MC-Unique: q5tjxeq2MKGbdClVla46JA-1
X-Mimecast-MFC-AGG-ID: q5tjxeq2MKGbdClVla46JA_1773340565
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4CED1953941;
	Thu, 12 Mar 2026 18:36:05 +0000 (UTC)
Received: from tc2.redhat.com (unknown [10.45.224.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6FA0030002DA;
	Thu, 12 Mar 2026 18:36:03 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH] dpll: Fix missing notifications in monitor mode
Date: Thu, 12 Mar 2026 19:35:47 +0100
Message-ID: <a44724170d2c5e288062a923d93c3eaccdac97e3.1773340441.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When running dpll monitor with output redirected to a file, notifications
could be lost because stdout is fully buffered for file redirection instead
of line-buffered like in interactive mode. If the program is killed or
crashes, buffered data is lost before reaching the file.

Fix by calling fflush(stdout) after each notification to ensure immediate
writes to the log file.

Fixes: 656cfc3ce05b ("dpll: Add dpll command")
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 dpll/dpll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dpll/dpll.c b/dpll/dpll.c
index 846ad4b0..84f68f76 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -1936,6 +1936,7 @@ static int cmd_monitor(struct dpll *dpll)
 				       strerror(errno));
 				break;
 			}
+			fflush(stdout);
 		}
 	}
 
-- 
2.53.0

