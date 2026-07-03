Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1741336897;
	Fri,  3 Jul 2026 05:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056943; cv=none; b=TZNPdNoE9uFJIhZyb35J3kjCLM00aXZ7EopvB9wZj55UbHwn5aZAUjFiUAMNNhl/AjolqL8UF1kMMapcG9pVa2wfDFQYUZfae134griI/VE7Vo2X3FYGV78OEF6s9XER3l74cSNPY1/6FmiD5tReEra5E4RLccytWXvpydRyHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056943; c=relaxed/simple;
	bh=0mtq3LN+KWBSW9lTL9C9FcS9noZX2XKjwf2oyxhAxxI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k7tYw+ciKDdEMj8nhf7rl0d/GArNIMGzQG2A1ivkwuYjAcz5b+/I9GDTjHMeyR3z3z2LuYqSEBaKB4Xu2wTwHW9tiiWRLqPuOSc++WpY0RMwkRgcaqJuPIFHhkvSsdSerW1f2q7KpG++uBmdGaXx/ZF69EsqvmeHYcsHCQGMYL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=UMSyEgSY; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="UMSyEgSY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1783056942; x=1814592942;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=0mtq3LN+KWBSW9lTL9C9FcS9noZX2XKjwf2oyxhAxxI=;
  b=UMSyEgSYAxhqpe+onxKGUTkZ3e1rCvTF6164UvE+gVzwJjy0HXAuzk+b
   f/nRyDjzTXWT/qFuQKSXVOFfdg/GrG/Y7oJUko1Hdv6GzikAZ6FzsudD0
   pJqxz8yyjdeoDdxGL5+2RiLpzUgUCI0TqMcfbQ88bBAHqxMaSTN5iTVby
   E=;
X-CSE-ConnectionGUID: xeHXl9QGQGy8HVZGWnHucA==
X-CSE-MsgGUID: wWH+KjveQ/qycSHEfAysPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="99571517"
X-IronPort-AV: E=Sophos;i="6.25,145,1779141600"; 
   d="scan'208";a="99571517"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 07:35:34 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 3 Jul
 2026 07:35:33 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.043; Fri, 3 Jul 2026 07:35:33 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <manikandan.m@microchip.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
	<arnd@arndb.de>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
Subject: RE: [PATCH v4 3/7] mtd: spi-nor: sfdp: expose the SFDP as a read-only
 NVMEM device
Thread-Topic: [PATCH v4 3/7] mtd: spi-nor: sfdp: expose the SFDP as a
 read-only NVMEM device
Thread-Index: AQHdCHJjppL/9AvAjUSdTTDRPCeZfLZbR6Aw
Date: Fri, 3 Jul 2026 05:35:33 +0000
Message-ID: <8f3b422e0b7749b2a47b14a585dd0a0c@infineon.com>
References: <20260630092406.150587-1-manikandan.m@microchip.com>
 <20260630092406.150587-4-manikandan.m@microchip.com>
In-Reply-To: <20260630092406.150587-4-manikandan.m@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

> Register the cached SFDP as a read-only NVMEM device rooted at the
> flash's "sfdp" child node, exposing it in on-flash byte order. This lets
> NVMEM cells reference any SFDP data: a fixed-layout for parameters at a
> known offset, or an nvmem-layout parser for vendor data whose location
> must be discovered at runtime. The device is only registered when an
> "sfdp" node is present in the device tree.
>=20
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

SFDP is exposed in sysfs (e.g., /sys/bus/spi/devices/spi0.0/spi-nor/sfdp).
Why don't you just use this existing entry?

Thanks,
Takahiro

