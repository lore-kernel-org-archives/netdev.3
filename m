Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC153A1D0A
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189591; cv=none; b=ei1fN2SmCRtiIc2ucxiVT0gmdxcI5Y/OgN9C+b06i+wMr2gVpJ2EoX0hW54wdWj88m8c/uXjcmX8Y5LUVBAWq5nUopIOgw0W6M3QMWWGIic9DZrR2IlcaweS+OcCavV72d6zhRnKIbV8Uv6wQAWT1uY1CHahL0eRSk9rgdQhaAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189591; c=relaxed/simple;
	bh=Edr9N2olxLaxijMUHS0n8GHZ3f5PPU6Cf1V3LCWMLL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqFTdI7WGGRPnGQuh9R//YXsbEdb4JBIfuSN7SKoYJwXdo66a1kwC2+93fhtYmZuafgZihE02Y/rIf3JnRacOgjnpbiaSvNDOZRxn+8TvGKe/7volO3dt3SbkJK1m3AHdY73SFYMauKiiCc+18KVzK7Theg7kU8h+xirlPSoeSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhCCvHJS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhCCvHJS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772189589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k6zEE769409AJr5AjsfM0SAQkPjG4+rPKOFVf3cs9/A=;
	b=fhCCvHJSEtf/slqwHpnB/Ol8ZZ+XrOFWQihi1ySK7qas1GUZfd6ZebBx3a9UaSvRXlJHXl
	eLHHifIYbTBi1b9o1ygWFqCpoxMgMt1OLcM2YeaBo5Jw2D2ImUKG+Vl4XfPmMj4gLrLFC1
	bQ+EPAr6V9gdDNzegrq8a6eJfxYumAw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-3aD-Mma2OVuECTDZiIXxXQ-1; Fri,
 27 Feb 2026 05:53:06 -0500
X-MC-Unique: 3aD-Mma2OVuECTDZiIXxXQ-1
X-Mimecast-MFC-AGG-ID: 3aD-Mma2OVuECTDZiIXxXQ_1772189585
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADC411956071;
	Fri, 27 Feb 2026 10:53:04 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.15])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA44D19560B5;
	Fri, 27 Feb 2026 10:53:01 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] dpll: zl3073x: consolidate chip info and add temperature reporting
Date: Fri, 27 Feb 2026 11:52:58 +0100
Message-ID: <20260227105300.710272-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This series refactors the ZL3073x chip variant handling and adds die
temperature reporting for chips that support it.

Patch 1 replaces the five per-variant chip_info structures and their
exported symbols with a single consolidated lookup table.  The chip
variant is now detected at runtime from the chip ID register rather
than being selected at compile time via bus driver match data. This
simplifies the I2C/SPI drivers and makes adding new variants a
single-line table addition.  A flags field replaces the hardcoded
chip_id switch in zl3073x_dev_is_ref_phase_comp_32bit().

Patch 2 uses the new flags infrastructure to add die temperature
reporting for chip variants that provide a temperature status register.
The temp_get callback is conditionally set during device registration
based on the ZL3073X_FLAG_DIE_TEMP chip flag.

Ivan Vecera (2):
  dpll: zl3073x: detect DPLL channel count from chip ID at runtime
  dpll: zl3073x: add die temperature reporting for supported chips

 drivers/dpll/zl3073x/core.c | 118 ++++++++++--------------------------
 drivers/dpll/zl3073x/core.h |  59 +++++++++---------
 drivers/dpll/zl3073x/dpll.c |  28 ++++++++-
 drivers/dpll/zl3073x/dpll.h |   2 +
 drivers/dpll/zl3073x/i2c.c  |  37 ++++-------
 drivers/dpll/zl3073x/regs.h |   2 +
 drivers/dpll/zl3073x/spi.c  |  37 ++++-------
 7 files changed, 113 insertions(+), 170 deletions(-)

-- 
2.52.0

