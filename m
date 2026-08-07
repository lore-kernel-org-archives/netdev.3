Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593543D525B
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096735; cv=none; b=Hy2ho4ySXn9Uj21VwDQLnPvIsaBWiI1M1hd7lr0tDQ/JBfKRmC3bh/f9l8PdDmVxdSiFRPcfQ3HZK5NXFDhIGpLrq2NRkVXtaWpAOiKx484xSh6IfvlFK/pVyIbf9srs464Ab/K7WNEKvDUrzsHzvtgjKfbqPRV6rQM7DDUv0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096735; c=relaxed/simple;
	bh=hZHi9NW2g/WqAEpGxXYimUrRfchRnZho0g3kDJOMeUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0/UkwUeV5Aopy7G5VezyuwRkt9uW/ezNGTM1uPExKA+afCzhy5xIwa/ppk83xDdx8uao4zd4MMKvTJ4vxbyTXZbZwwf+JjutKgZ6SZg+pdRI0LFLhz3qR7DAV36lfBmZ4xm5o5URomt5SiL6y6VgVA5x5nXS1FecEgsrebqxeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qt83ysMS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qt83ysMS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786096730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6/TbhPr4NGkFf7ZBR9YY44udE2MKMd2e1TIVa7v+k0=;
	b=Qt83ysMSNbRRx4X8FrFuf40DI9TZRHfDs+u72UdpWPNrhYWaWxGYVv/H0uQHI4lNqMKHVj
	AoefJmtFkMtropm5r+uTY833vrzt0j+CD3yZCSZHuVM8MqOPC+TmU9few0dglkr25xDYHw
	sBH1tBnwtMjk1wMoPTGd+EfP1GvuI5A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-FQl4o-m3NcmxP6Yhycdw8Q-1; Fri,
 07 Aug 2026 05:58:36 -0400
X-MC-Unique: FQl4o-m3NcmxP6Yhycdw8Q-1
X-Mimecast-MFC-AGG-ID: FQl4o-m3NcmxP6Yhycdw8Q_1786096715
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB2171955F19;
	Fri,  7 Aug 2026 09:58:34 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.215])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 904451956094;
	Fri,  7 Aug 2026 09:58:31 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Min Li <min.li@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 1/3] dpll: zl3073x: scale poll interval proportionally to timeout
Date: Fri,  7 Aug 2026 11:58:24 +0200
Message-ID: <20260807095826.386756-2-ivecera@redhat.com>
In-Reply-To: <20260807095826.386756-1-ivecera@redhat.com>
References: <20260807095826.386756-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Replace the fixed 10 us poll sleep in zl3073x_poll_zero_u8() with
timeout_us / 50. This scales the sleep interval proportionally to
the timeout, targeting approximately 50 iterations regardless of
the timeout magnitude.

The fixed 10 us interval was adequate for the existing 25-50 ms
timeouts but wasteful for the longer PTP-related timeouts (up to
3000 ms for phase step) added in the following patches, where it
would generate on the order of 10^5 bus transactions per wait.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 5b2d77f2c2288e..2e8b52c8de5e26 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -322,7 +322,7 @@ int zl3073x_write_u48(struct zl3073x_dev *zldev, unsigned int reg, u64 val)
 int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg,
 			 u8 mask, unsigned int timeout_us)
 {
-#define ZL_POLL_SLEEP_US 10
+	unsigned int sleep_us = timeout_us / 50;
 	unsigned int val;
 
 	/* Check the register is 8bit */
@@ -336,7 +336,7 @@ int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg,
 	reg = ZL_REG_ADDR(reg) + ZL_RANGE_OFFSET;
 
 	return regmap_read_poll_timeout(zldev->regmap, reg, val, !(val & mask),
-					ZL_POLL_SLEEP_US, timeout_us);
+					sleep_us, timeout_us);
 }
 
 int zl3073x_mb_op(struct zl3073x_dev *zldev, unsigned int op_reg, u8 op_val,
-- 
2.54.0

