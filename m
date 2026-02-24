Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4862E36A012
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924375; cv=none; b=ToDRm0lyBNrhZsoGfswMmYtgIhp9Vutw6O61VXVfCklOXz8XiJhmJR1ciecRvO0UfDXYH4eTAH9ICP1WFnpQGQttSCFW4FKs55l5CMUb5RJNZp4NMJpdw170+v8IKqKmf7DYP36ZuZ3FALGEPykbumFPN/hwNbD6numck7GCzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924375; c=relaxed/simple;
	bh=+d7GmB5h5LdPHvxn+uGrvl9/J+QyLt0w4+NWNl8Hc1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UR1+GEbe4Mam7wvkK+MhImlCBYLfyQPAuEFUBrNrt9iPOINhypulmB1vrRbWJirBBk3U30AQHBDHRPhgYbwc5yST8Sus9ROVilFM6F+KWwf/R4tF2DknqUU7CXaw+S3hWyQfi3eZ4bXzhsUA9IrRDSo6y1HATxD0lU4wDoCU/+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdKHzHdJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdKHzHdJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771924373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFCJ6InpT4P6F8PmUWqMkIgih5vzk9IS09L3d8aVgRo=;
	b=PdKHzHdJ1s2J9H4DSxD0MQR7etbFpNs+D1stZ65NZn/8NMlQZUeQOCIOjSAGqcSKL9m+KC
	RbJMUBGrnbgZxnNYJWbOqGuLCw2Jdfm4z89N2HTdv9v/zjQEJN9x/jEkNblyoP2dhKoURD
	4U0Yh+tuhrHqYCZT5AfDriHdr4XSEpM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29--cuDLd0lNruiLZzea9WLow-1; Tue,
 24 Feb 2026 04:12:51 -0500
X-MC-Unique: -cuDLd0lNruiLZzea9WLow-1
X-Mimecast-MFC-AGG-ID: -cuDLd0lNruiLZzea9WLow_1771924371
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D75221800464;
	Tue, 24 Feb 2026 09:12:50 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.225.132])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79CF71955D71;
	Tue, 24 Feb 2026 09:12:49 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next 1/4] dpll: fix pin id-get type filter parsing
Date: Tue, 24 Feb 2026 10:12:40 +0100
Message-ID: <20260224091243.58501-2-poros@redhat.com>
In-Reply-To: <20260224091243.58501-1-poros@redhat.com>
References: <20260224091243.58501-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

dpll_parse_attr_enum() expects the keyword to be already consumed,
but cmd_pin_id_get() used dpll_argv_match() which does not advance
the argument pointer. This caused the parser to read the keyword
"type" as the enum value instead of the actual type (e.g. "gnss").

Use dpll_argv_match_inc() to properly consume the keyword before
parsing the value.

Fixes: 656cfc3ce05b ("dpll: Add dpll command")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 dpll/dpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dpll/dpll.c b/dpll/dpll.c
index 624567c2a826fd..0effa5a9c67e72 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -1768,7 +1768,7 @@ static int cmd_pin_id_get(struct dpll *dpll)
 			if (dpll_parse_attr_str(dpll, nlh, "package-label",
 						DPLL_A_PIN_PACKAGE_LABEL))
 				return -EINVAL;
-		} else if (dpll_argv_match(dpll, "type")) {
+		} else if (dpll_argv_match_inc(dpll, "type")) {
 			if (dpll_parse_attr_enum(dpll, nlh, "type",
 						 DPLL_A_PIN_TYPE,
 						 dpll_parse_pin_type))
-- 
2.52.0

