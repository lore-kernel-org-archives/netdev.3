Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D221E443E39
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696040; cv=none; b=HK2AUlkeq879MHeR9ezfShtmzvzIJanVVbXaC+RFXPZCU6EtquSUkLrlcLbyBljMSIQmRBAmKVWdy7SoVtYJvSBB92P9jjFhx0dMeAVD1RYK+QV+wFGUHkZEaESXXxFkDbUGp0gVFN5v0Yhhmyj7lcHvThBj+Ls9YIxc99A1P+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696040; c=relaxed/simple;
	bh=gkZNdDMQXkaW6SSn4TVnkPJ7tzvSBdKU6Ciz95VgaJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elOlVvfSh1I1RWk//HghdWFj4dfZxs/li172mH+d5YqgQ8lIxHki57BOnhneadRmeZSyZfYr4SzA1m/8LF4JNwzk9cEdDQSTdKOEqUeQXkMHlAlfyVve0aW5bbKexLGT9RDVI8GTxGRCC2x/HwsPzzJr0N8eovJRK0fU/XBJjbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zmz5uRC3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zmz5uRC3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786696030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYFXkfbDcUP4393UgcP5NkiEjgeoGj6dJK0aHjYcAxQ=;
	b=Zmz5uRC36bpCFFAEZl3AcNHat+4l8AaDdpBC+motFmMBF9bZg17bYDS41OZ1aMYc5/fPnG
	zhbJ3G2fZQv8jusAlEsCXPiqfP3pbYyNv/AyF9KiW5KUNlpRfdzQhrbT0nzTooc+F3oD/w
	SGjfm5THckJcJvSvVjk5+OvsA3KIs48=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-ch0j5dU_M16Isb9yVV1qXQ-1; Fri,
 14 Aug 2026 04:27:07 -0400
X-MC-Unique: ch0j5dU_M16Isb9yVV1qXQ-1
X-Mimecast-MFC-AGG-ID: ch0j5dU_M16Isb9yVV1qXQ_1786696026
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68B71195608E;
	Fri, 14 Aug 2026 08:27:05 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.131])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FFAB30001A2;
	Fri, 14 Aug 2026 08:27:01 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Min Li <min.li@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 1/3] dpll: zl3073x: scale poll interval proportionally to timeout
Date: Fri, 14 Aug 2026 10:26:54 +0200
Message-ID: <20260814082656.306534-2-ivecera@redhat.com>
In-Reply-To: <20260814082656.306534-1-ivecera@redhat.com>
References: <20260814082656.306534-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Replace the fixed 10 us poll sleep in zl3073x_poll_zero_u8() with
timeout_us / 50, scaling the sleep interval proportionally to the
timeout for all callers.

Testing showed that existing callers (mailbox, HWREG, DF read,
frequency measurement and phase error polls with 25-50 ms timeouts)
typically completed in low hundreds of sleep cycles with the fixed
10 us interval. With the scaled interval the cycle count drops to
single digits. The longer PTP-related timeouts (up to 3000 ms for
phase step) added in the following patches benefit most, avoiding
on the order of 10^5 bus transactions per wait.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
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

