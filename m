Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFDE4343E7
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456051; cv=none; b=PnpVLVWvcGBkMYtTQ3mTKGcyvGeshHqm+FIsGvFyUr/Vmou4GnzsStYt/PEdr4Nh6fM17KhUR8aTZDMM0kBnvKAuhHw7sP7UNXwT/Uariy+Gp1Mnxb6Hi4MGoREuYb9jkK73tqvg0dRt0du5GTmclX3nqQsw8u4KCAdXVsDSL4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456051; c=relaxed/simple;
	bh=ZzMudb7c/mo+GvAQg5QmRQnHcOqCd2Q95K343LStNgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYeY7Nij52uiPWb8t0qQBtujdnweqTu+gEp9hIcgM0hEQ7KqHIp5RPr1xxOfRRLbZQZpTzgS/Kbe2IntLZvU2CpwxZqs+Q8P/F4g9ipZeV8Yta6Yz1qc1CuyW9fpDqfaf5hymZtIaDb1eU9G7hVeiIOlE+0tREhtjn8zCgIRCO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHuXsAdI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHuXsAdI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786456038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GrGKMdz/1jegWEqmKxWWQdw6mFlOdld/a4bzJBeswoA=;
	b=CHuXsAdIVFtGnXvcCQaxke4/y4OF1LJ//uyMiSMjTGXmH5oB8m0V014IrYPA9bVrDQOCed
	rnro4HP68aQ/q5OHnXW0pEqhUWI+pk64FUoO9yU0UliOzG4NXc318yGzH0AktQHAgZnoYO
	VBlUecxkTFtr6kxI1B5fCY7LLI5WN3Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-Pgm37mB7OB2CcqKbUHkTeg-1; Tue,
 11 Aug 2026 09:47:12 -0400
X-MC-Unique: Pgm37mB7OB2CcqKbUHkTeg-1
X-Mimecast-MFC-AGG-ID: Pgm37mB7OB2CcqKbUHkTeg_1786456030
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9E121800651;
	Tue, 11 Aug 2026 13:47:09 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.49.196])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E1D9195DF91;
	Tue, 11 Aug 2026 13:47:05 +0000 (UTC)
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
Subject: [PATCH net-next v7 1/3] dpll: zl3073x: scale poll interval proportionally to timeout
Date: Tue, 11 Aug 2026 15:46:58 +0200
Message-ID: <20260811134700.1211010-2-ivecera@redhat.com>
In-Reply-To: <20260811134700.1211010-1-ivecera@redhat.com>
References: <20260811134700.1211010-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

