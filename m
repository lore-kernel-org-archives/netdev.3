Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129403E95B2
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299909; cv=none; b=J4rZuj6Gf10VbuL77uoupilsWGyugT1WRO4y697Fepm0fu8GTNqHP9ov/gD8+IMiinQRL7PwgFr0xuAX0beEv7HL6NlpK01Ai066qsi1ZmB5ZfmORpVgR2bA9h+NqIlftKGPK4F2FG/FcfX5a5sAWqd34gov7kunQbGuli16zqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299909; c=relaxed/simple;
	bh=TuWPrCswIPrSV2+6rsA/rO0LApUZGyIhe+jXl38OUmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwoY1qrWoQq5Sbju8JrPJsnX6KADswBwBNTTAThmR1mdRFweqytIYn/1YW052chckyDEuhJdmWLVl/szYlcSo0IIhOPYdafyWJRk//hz8PZmNvsfDtgdGqVXeqPtd+bltGILgwQ/Tpl+kRixGi8ncQmcN1o8dbbksG/eWtcDMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gV/4timX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gV/4timX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770299908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVN7AUTxaUluG7djgp6aR7yKnth1EWpRVjZ/G0hnPEU=;
	b=gV/4timX0oDcDY12sUDZZkaDMum7Bxux+XHIbLYXh+Qex3ZGL9xAcADY2HSAn6xpljlbnE
	HX3N7nMMkJYhEWAzt3ygHiLypxARIYC+LniShEOKueZE9ul4ItHhab4mrWvGDaAQ5tfw45
	UZijfhPYZHPH8GHQJ3tlYciYsqmEUR8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-Nz4bOEC5OMWucFt0zPQPoQ-1; Thu,
 05 Feb 2026 08:58:24 -0500
X-MC-Unique: Nz4bOEC5OMWucFt0zPQPoQ-1
X-Mimecast-MFC-AGG-ID: Nz4bOEC5OMWucFt0zPQPoQ_1770299903
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E28791956050;
	Thu,  5 Feb 2026 13:58:22 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.32.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3830E19560B4;
	Thu,  5 Feb 2026 13:58:18 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jkarrenpalo@gmail.com,
	tglx@kernel.org,
	mingo@kernel.org,
	bigeasy@linutronix.de,
	matttbe@kernel.org,
	allison.henderson@oracle.com,
	petrm@nvidia.com,
	antonio@openvpn.net
Subject: [PATCH net-next v4 8/8] MAINTAINERS: Assign hsr selftests to HSR
Date: Thu,  5 Feb 2026 14:57:35 +0100
Message-ID: <f4a356b96f5e0c99d9db3984ea62596c99a97469.1770299429.git.fmaurer@redhat.com>
In-Reply-To: <cover.1770299429.git.fmaurer@redhat.com>
References: <cover.1770299429.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Despite the HSR subsystem being orphaned at the moment due to the original
maintainer being unreachable for a while, assign the selftests to the
subsystem for the future.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce6f49c054c7..ade3705431c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11587,6 +11587,7 @@ HSR NETWORK PROTOCOL
 L:	netdev@vger.kernel.org
 S:	Orphan
 F:	net/hsr/
+F:	tools/testing/selftests/net/hsr/
 
 HT16K33 LED CONTROLLER DRIVER
 M:	Robin van der Gracht <robin@protonic.nl>
-- 
2.52.0

