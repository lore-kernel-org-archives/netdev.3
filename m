Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCA5388878
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945278; cv=none; b=lQLX5pbA99t4z/nxEL4i16x1TLTS1/DPfmFNrzDJZMVUY7n7s50s6LAvh5+kf+ljqrH8lseeie8CWYgvoltN081LfMCTFmclJsQcwNnuCqzDWwQ9LrQ+BOB9B9r2L9xd7rExYQYT0BlFhPOGXUdsUBQ80gLzfR+XyD3mIE2D/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945278; c=relaxed/simple;
	bh=69D9G3V9IbLdH1McJttEaThWssIEl844CXqaj4QXo+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQ5akp0QDhNOAJIGSWQfIJQ07jQt8ss5Mu42TBHojCsPh+dH7t6aJs6U3s1zSmACUuZj2pAZ7YqEdhuoXjWsQ8OsG8zTXLbnFGOEdcSARlkh1BIYyVHDhrVbA5AY5utSU6P2TarI7xtuKDPHkyutvq8QBELxoMCVraCxq/IZctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Grf1OtBt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Grf1OtBt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785945275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JPhgkHcZ8cddowQ9dCPgiE/BgHNvHOaiIKWKRrT5WyI=;
	b=Grf1OtBt9/sbbUJ/TYofsow6g5ek2By0a2n0R+2fJ7y4a4EOKluB2LuVkNyx0OBn2wjqhN
	jnfOeYlqnArw9JJmAJT5ZG24V2+MuZkUbeviUTqpZx8kOFfIseILpKvwsG2I/ibTO6z8wA
	3WaqZXjltmvIp7OC2++7NtR+xYbzmWc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-jINeaJyBP1yeAmalSnkGJw-1; Wed,
 05 Aug 2026 11:54:32 -0400
X-MC-Unique: jINeaJyBP1yeAmalSnkGJw-1
X-Mimecast-MFC-AGG-ID: jINeaJyBP1yeAmalSnkGJw_1785945271
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9BB6180034A;
	Wed,  5 Aug 2026 15:54:30 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.154])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3136C19560AB;
	Wed,  5 Aug 2026 15:54:26 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Min Li <min.li@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] MAINTAINERS: dpll: zl3073x: replace Prathosh Satish with Min Li
Date: Wed,  5 Aug 2026 17:54:25 +0200
Message-ID: <20260805155425.38808-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Replace Prathosh Satish by Min Li as the Microchip co-maintainer
of the ZL3073X DPLL driver.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 932ea1db048e59..34d18b41855f44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17855,7 +17855,7 @@ F:	drivers/net/wireless/microchip/
 
 MICROCHIP ZL3073X DRIVER
 M:	Ivan Vecera <ivecera@redhat.com>
-M:	Prathosh Satish <Prathosh.Satish@microchip.com>
+M:	Min Li <min.li@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml

base-commit: a23b36233d4103def55dc8cf65698106d0bd1e62
-- 
2.54.0

