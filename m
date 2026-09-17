Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4077D497393;
	Thu, 17 Sep 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660527; cv=none; b=o981iqZ7W/TINj4ywTKhsogIPFWaD0+pVXoBWnvQ37DQfxv8veih1p62FqvpGnTLkmkwB6g9syqnccqDHZBW/ajSiPDRoFfaxybS9V3qbSAzOAzUj7KjWP8fikexvyT/vHBnv2l47L8D5FnKIvQhDYIS9cg/mkVJUSUz2uM7uIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660527; c=relaxed/simple;
	bh=L38sj/oPF+SgDEJj8vtcGsboNoDf1hlyZ8xrE1I0Of8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ikYDUFt5gDbHJQSmfi2cHs4g1FbrN5LJy25ep/sCzEjANkFx8lc2T9UMENKxaU8aEI9FwjW+HsDJU6DAW1MU2c4Vbv35GLV/BakgKMyGeU42zHOTjI8U923mqLPYS9pqCQasZE6uFp5LVCsj/7H7WNOJDcOXOLuh6vdQQx3wxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyvGmeKm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyvGmeKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2971F000FF;
	Thu, 17 Sep 2026 15:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789660524;
	bh=4tT0hSQZzT4nABmz0hTt14V/U2PpBkIFPgyrWbrbsOw=;
	h=From:To:Cc:Subject:Date;
	b=DyvGmeKmYJajnlOvIQqkzKyuLf9eqb/aCoiYdYNKCP8LV7Ym+3cnIN3+D65zqawUZ
	 0+p9uBtYyuhJNEppGew/ClGTLip+XLM6Y5ta+nQ7+LHUblUnM2Jybfp1Ag3881XH0Y
	 fxsgltWXsu+y3DOhbVEEvuMMOx+3HpQmWUKXlAwdc/6kOMRnCVgx6mIO8EDSnBsCfj
	 1x/EBb34cbrzAcUGB2lfQqYjp3g1Fa/Z/mrc+Py/zMtYd79MPZPMOndLyDyGIDgjTE
	 a9As5u/vBb6Hu/fmkh3NIThtt0O3RoaWYwjb9e8alnAXTnKpi5HZji097RWdecXRjw
	 k1LOW3EOr+bWg==
From: Arnd Bergmann <arnd@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Alejandro Lucero <alucerop@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sfc: fix CONFIG_CXL_MEM dependency
Date: Thu, 17 Sep 2026 17:55:11 +0200
Message-ID: <20260917155519.2121486-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A recent patch introduced a call to devm_cxl_probe_mem(), which is only
available when CXL_MEM is enabled. If CXL_MEM is in a loadable module,
this causes a link failure for a builtin driver:

s390-linux-ld: drivers/net/ethernet/sfc/efx_cxl.o: in function `efx_cxl_init':
efx_cxl.c:(.text+0x156): undefined reference to `devm_cxl_probe_mem'

Adapt the dependency to require CXL_MEM instead of CXL_BUS, which
we know is available when CXL_MEM is.

Fixes: 0418860ef2ca ("sfc: obtain and map cxl range using devm_cxl_probe_mem")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/sfc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index 979f2801e2a8..e2898ec2e6e9 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -68,7 +68,7 @@ config SFC_MCDI_LOGGING
 	  a sysfs file 'mcdi_logging' under the PCI device.
 config SFC_CXL
 	bool "Solarflare SFC9100-family CXL support"
-	depends on SFC && CXL_BUS >= SFC
+	depends on SFC && CXL_MEM >= SFC
 	default SFC
 	help
 	  This enables SFC CXL support if the kernel is configuring CXL for
-- 
2.53.0

