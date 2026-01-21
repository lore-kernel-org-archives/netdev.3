Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B387B4BCAB0;
	Wed, 21 Jan 2026 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006091; cv=none; b=onRmjxkNadBXk5sFENedmRqjNIdXDL+X/Z5ZIQ1kwFHwfRsBIH0QIWz4SlrWqNCx+sHsU1NeoH4RsVhCdN/ngAuIHBljXS5+6kS2SVCemfRBBPXszNgsVlJVaDNtUw1uuShVWVx/chzKHUsZqQJoTWs12CLpISgETdkGh8fNEeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006091; c=relaxed/simple;
	bh=BNVNoS/X+EeH0JkRQ6ZfkVSqrk6Vq3EjvhE/WAVPm3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSgVbDAXWMpSdhHr4Ahf5E7uoNQZZ20qZq8LM3WniDiFKNcpbyzUxjAavSWeIB+HOhmti79J56xnplsWoQfs8NTbp8p2QrTMjJlFpw010xRtLxHvH6hBkHlfbJ9dFx1jAVOpYqjLj7WX5o+g9SgjCJSROhzcfIjF0AWMODSEtfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nFjT/Kd6; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nFjT/Kd6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769006089; x=1800542089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5FqRCHwtM2CGLbcYhd42nWIqDE7JkoWPCz6/NSC/xrQ=;
  b=nFjT/Kd6daq3Gnj6pJakKOf8abc3l2+mru0yR5+u2PuCivLeJOpTNcd+
   ppSlpj4I8yIg4EzJuHJawZxf8kn8mIbIbf9uESkfJ+J9VFn/2WFp6p3ps
   VdoGgh8MzM/4Mr/SeHPmvWOT1DqM92vnvor24y1uyzOjp9na7iJCAKOTk
   hpL7UPxAZX85VN5L+B8w9TEkBfh+aPItkGeCYlFeTOoom4y4D2wNMO16T
   hzEaVL8njq1qqdJ0qH3mmuOS8wu7w7oOZPkQ/JKRTnXYc9M1879aeCYui
   t1GG8q61RsrxD+8JeME6SKbvlndSRXs0YCCDW0mtI6Tzh4wBdyr+cIXaG
   A==;
X-CSE-ConnectionGUID: h5qSvot8QHawOXrIP3ZXsQ==
X-CSE-MsgGUID: nrodrx8aSgqHwFXB7K87jA==
X-IronPort-AV: E=Sophos;i="6.21,242,1763424000"; 
   d="scan'208";a="11313589"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 14:34:46 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:18929]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.221:2525] with esmtp (Farcaster)
 id 4bc89515-80eb-4bcf-8d15-5dc3e811d086; Wed, 21 Jan 2026 14:34:45 +0000 (UTC)
X-Farcaster-Flow-ID: 4bc89515-80eb-4bcf-8d15-5dc3e811d086
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 14:34:45 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 14:34:42 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>, <dwmw2@infradead.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Babis Chalios <mail@bchalios.io>, "Alexander
 Graf" <graf@amazon.de>, <mzxreary@0pointer.de>, Marco Cali
	<xmarcalx@amazon.co.uk>, David Woodhouse <dwmw@amazon.co.uk>, "Takahiro
 Itazuri" <itazur@amazon.co.uk>
Subject: [PATCH v6 5/7] ptp: ptp_vmclock: add 'VMCLOCK' to ACPI device match
Date: Wed, 21 Jan 2026 14:33:42 +0000
Message-ID: <20260121143402.3092-6-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121143402.3092-1-itazur@amazon.com>
References: <20260121143402.3092-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: David Woodhouse <dwmw@amazon.co.uk>

As we finalised the spec, we spotted that vmgenid actually says that the
_HID is supposed to be hypervisor-specific. Although in the 13 years
since the original vmgenid doc was published, nobody seems to have cared
about using _HID to distinguish between implementations on different
hypervisors, and we only ever use the _CID.

For consistency, match the _CID of "VMCLOCK" too.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Babis Chalios <bchalios@amazon.es>
---
 drivers/ptp/ptp_vmclock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index 8605e441fad7..b5e264264051 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -749,6 +749,7 @@ static int vmclock_probe(struct platform_device *pdev)
 
 static const struct acpi_device_id vmclock_acpi_ids[] = {
 	{ "AMZNC10C", 0 },
+	{ "VMCLOCK", 0 },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, vmclock_acpi_ids);
-- 
2.47.3

