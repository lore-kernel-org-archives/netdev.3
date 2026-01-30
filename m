Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491FA371040;
	Fri, 30 Jan 2026 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794681; cv=none; b=j944EARS7Hv+oUHRvQaRZPpR+RIWhsx+N34jtLew/b7nZW3iBjWYVnVMSP+eifcz6VRQ0mgKeHgjwrEfuVlAR+ban9PLHI9sVbJJRz+WveWDt0C6tiUWC8dJN+q4iIul5JiCqx4/97kM08ZlBw3B/faOBcuMKzNjeHCZJdPicmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794681; c=relaxed/simple;
	bh=HtAlXAZcolOufqDMf/VXwn7/loLBn96spGHI3kdbqm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bS9EQPNCPm/WVifR8cu0qkJrJN/ohEUF39sFQsTiUD65NI0p7u04P9Fq1/FPxiU55Ex8CJQ1b9ICsYo9KY7DVuPlEK0XG3YZa7uahSbcWipnAB7ewl+VlTReAcPs6VjbN+jIyPq0bucSXpKYmbChYdBO3zP80buIdfb+G6cDVgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PaKRi/kd; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PaKRi/kd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769794680; x=1801330680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vpLeB0JvZrWGa5+/2pZgLiAZzuec5SAaVzWSTRXFViA=;
  b=PaKRi/kdRe4mlaDX1EAQo2UqGlHVrZYVBUXsDh31dPDMJAwv55N4Up/N
   pKF3CVJC31Shn5nk+zaMo5kTa/Ee1aCO2yNCJMmrJ0irpcdECkbH+w4WU
   P7HJCOGZE/ZAzCgka9jIKtBycwk1BxVZRepihNWwb2bxjRpNvT4wegP+N
   iGv/SWBvxAeA88ZoD9+uGvMBp0Q4XBrkC7HNbQcQeSZ9aQWeGyYBpox1H
   1ZmCoMV4J7F1krYC1RcNkAIaMpE5tRk6/MTUKz8gkg18/Ab6M9Z/O/0p6
   3g4yx/BARo+zLbYeeMWTpC59E7HCHn4VQZi97nAGOsvUg7zz0gaQM4RRX
   w==;
X-CSE-ConnectionGUID: SwKwFRe2SEOBDHa15rI5kw==
X-CSE-MsgGUID: o6SMm4HPS3yLfjQJyw9mYA==
X-IronPort-AV: E=Sophos;i="6.21,263,1763424000"; 
   d="scan'208";a="11742820"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 17:37:57 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:11004]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.147:2525] with esmtp (Farcaster)
 id 3e6ee17e-ab63-4f58-8857-94cc68444b41; Fri, 30 Jan 2026 17:37:57 +0000 (UTC)
X-Farcaster-Flow-ID: 3e6ee17e-ab63-4f58-8857-94cc68444b41
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:56 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:54 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Babis Chalios <mail@bchalios.io>, "Alexander
 Graf" <graf@amazon.de>, <mzxreary@0pointer.de>, Marco Cali
	<xmarcalx@amazon.co.uk>, David Woodhouse <dwmw@amazon.co.uk>, "Takahiro
 Itazuri" <itazur@amazon.com>
Subject: [PATCH v7 7/7] ptp: ptp_vmclock: return TAI not UTC
Date: Fri, 30 Jan 2026 17:36:06 +0000
Message-ID: <20260130173704.12575-8-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130173704.12575-1-itazur@amazon.com>
References: <20260130173704.12575-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: David Woodhouse <dwmw@amazon.co.uk>

To output UTC would involve complex calculations about whether the time
elapsed since the reference time has crossed the end of the month when
a leap second takes effect. I've prototyped that, but it made me sad.

Much better to report TAI, which is what PHCs should do anyway.
And much much simpler.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Babis Chalios <bchalios@amazon.es>
Tested-by: Takahiro Itazuri <itazur@amazon.com>
---
 drivers/ptp/ptp_vmclock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index b6e9d4c96..c7c75e19f 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -83,13 +83,13 @@ static uint64_t mul_u64_u64_shr_add_u64(uint64_t *res_hi, uint64_t delta,
 
 static bool tai_adjust(struct vmclock_abi *clk, uint64_t *sec)
 {
-	if (likely(clk->time_type == VMCLOCK_TIME_UTC))
+	if (clk->time_type == VMCLOCK_TIME_TAI)
 		return true;
 
-	if (clk->time_type == VMCLOCK_TIME_TAI &&
+	if (clk->time_type == VMCLOCK_TIME_UTC &&
 	    (le64_to_cpu(clk->flags) & VMCLOCK_FLAG_TAI_OFFSET_VALID)) {
 		if (sec)
-			*sec += (int16_t)le16_to_cpu(clk->tai_offset_sec);
+			*sec -= (int16_t)le16_to_cpu(clk->tai_offset_sec);
 		return true;
 	}
 	return false;
@@ -350,9 +350,9 @@ static struct ptp_clock *vmclock_ptp_register(struct device *dev,
 		return NULL;
 	}
 
-	/* Only UTC, or TAI with offset */
+	/* Accept TAI directly, or UTC with valid offset for conversion to TAI */
 	if (!tai_adjust(st->clk, NULL)) {
-		dev_info(dev, "vmclock does not provide unambiguous UTC\n");
+		dev_info(dev, "vmclock does not provide unambiguous time\n");
 		return NULL;
 	}
 
-- 
2.50.1

