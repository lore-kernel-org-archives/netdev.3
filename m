Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757854D0A05
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005353; cv=none; b=orL04BBPi0lYAcRWLMc6GJqeKaojXyDDB7oAPo6VtqGwHKAoNSn8VEcLY+uPkUR3wwq6pDKxJZska2BfHauXKvX2OGPZjSXWulqTzi3ON3UUUY1viGtjHzre0SNYVjGdXK+xN8J5E3+ceYVIFpDrAEQioGpwAfC+8jjTP6yWJW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005353; c=relaxed/simple;
	bh=9kH4Z0v4eee+DKg2Rpv77UIr+n2moHtnlgKwmj9MEoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwA1zUntGQ+ipdyCfbMkew7XviyGqxhEL602vR67VZ8Z4gMpxPqRvlyYGYXCRkXch4cdgNb/S2XHLnwJETEeiSiV+DfNqE78jOZUmBa3t/jgN2VZwrRnS2BA01VGHt+feaida9a2dq1r/5WEHtyu6vlyzMKCXye90t4DHmYrooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ad7Rah05; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ad7Rah05"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e25400so2330517b3a.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790005350; x=1790610150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B54+vCOLkFDdOpiW0k+Uldsd6dkbrkEHEWRd5WaDkpQ=;
        b=ad7Rah05PSvOwE/76pZJMjzTlqCO2T/G9Tj6rT51mH8Ds8VYe0LseSg15hZ1M7TY+e
         G/IfSz3zdDCcLhv7G83l7Qp7aO1mJ064QX0wG7etlFd9DnsdYY91NNHW3ex6U6Z+vx9y
         koKo3vu/kPjrv8dn/wvrcTWpBV+bjQaSx2AKoFVuLeb0tjQtDuSxnF0AgZcdgZCOhfHm
         gMDzNWyIvd0eGj4AbYiJVzFj71alHFBES61XJr0QkVqNMuVUGblEHRdj9fSHy9g1mTAn
         odOP0gFKnPa8DUBpX3MJTYnnfJ8mTVLWup775ftKoH/HBkKRGuerxNobtjm3cELXl5b8
         YYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005350; x=1790610150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B54+vCOLkFDdOpiW0k+Uldsd6dkbrkEHEWRd5WaDkpQ=;
        b=E0OBUoP4LUdU5OELJF6GV0yb9l+xICHcKPLqr7Qm8i1h+zJbIYiVB1b/52ps2JDpkC
         Hp15C+ZKp2rG2wWSjBGiQlAe9wgjXiJyzkEtKZpi/r1LHtpHHmB6ZnwfnD/e3hPWkSLx
         Sn0J5BaZ7aR9t32OdYnZYK6SiUDFYspy3uGaeImCtMAbY+gW0pUo0PF3Xg1ldeVsE6cn
         IG/2lKRSf0oKpmadhhYwxfIxz3DuAp0woo642+lOfAROmnPNmBIqv+PfrSq8pyxCmYQj
         HYuPm9AT+4HBTwu9Fj1QGyNiuzwKxBlLZ557eeZjsfTLZHauRR3un0omD0MN3FOkJksG
         tKmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSQTcYm8jII07mIXkYjHO24XVg7V8FqOkAiDwD2yVAyNZF7vu75X0WgNpYGUqVyJYgULxvS9U=@vger.kernel.org
X-Gm-Message-State: AFuF++mypSJVQqW/diTla9J894wDrmg2lePOBoF+CjyzV3okwoYhGNw2
	lF06lmz6+5Lvi3/tpe7zCyHkmNMJlX2tXMT68ig+lZMz8cGS9JfzWsVd
X-Gm-Gg: AYBFou0SIUWpRs7h6KLQ1tD13Xypll/ZnakbhZkxC2IJ971RdqKWTFCIcKj62jlZh5Q
	YrhY+sKxb+REotmM2L+cdxRAiIbc+ldjmPFIkVq5B+VcCH8ola3S+fe0H3STubYiXDicLYgJO1d
	gFfmStEQ/CuyCtPojlrciN0dxlb8U/2ljz7Fh37b/HH5z/LLjHAYfwoEBQ8o0hWOmLi1sr2Oyvd
	qG2wYb7X8lAL5FVVx5Sx04+hE7aiiR+xAh8ofecRFSAESmLUrR4ju7Wum67hr3dcsI23BhxiAaY
	y/r39lZOVJjlRa3cHRfcsAl55GWOq3texwm1n8EjPeu5NsbOqSiFsTR4lSCIRIJ+N70OuZ/v4Lb
	zOKl+NPtdRbbmbULoxqtI2UoEFWDjdfDVQItmZ6ZvI0wTBL8T2w9uTTalJ5+o6cZEPxidS5eNcH
	MHkJwT6vE4XYGRdiHuBIpaz3+ycr6FGXZYCr1Cx/38/X9tXF8go25k2w==
X-Received: by 2002:a05:6a00:2eaa:b0:871:f803:1f1a with SMTP id d2e1a72fcca58-874db6f71d0mr13984342b3a.6.1790005350498;
        Mon, 21 Sep 2026 08:42:30 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa70200esm3449599b3a.61.2026.09.21.08.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:42:29 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	Amit Bernstein <amitbern@amazon.com>,
	Netanel Belgazal <netanel@annapurnalabs.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/2] net: ena: fix MMIO read buffer leak on probe failure
Date: Mon, 21 Sep 2026 23:42:02 +0800
Message-ID: <20260921154202.471662-3-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921154202.471662-1-lgs201920130244@gmail.com>
References: <20260921154202.471662-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ena_device_init() initializes the MMIO read mechanism with
ena_com_mmio_reg_read_request_init(), which allocates a coherent DMA
buffer for MMIO read responses.

The normal removal path releases this buffer through
ena_com_mmio_reg_read_request_destroy(). However, if ena_probe() fails
after ena_device_init() succeeds, the error path destroys the admin
resources and eventually frees ena_dev without destroying the MMIO read
request, leaving the coherent DMA buffer allocated.

Call ena_com_mmio_reg_read_request_destroy() in the probe error path
before releasing the remaining device resources.

This issue was found by manual code inspection.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 5f0864d16dd3..7eb6456ed0d5 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -4123,6 +4123,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ena_com_delete_host_info(ena_dev);
 	ena_com_admin_destroy(ena_dev);
 	ena_phc_destroy(adapter);
+	ena_com_mmio_reg_read_request_destroy(ena_dev);
 ena_devlink_destroy:
 	ena_devlink_free(devlink);
 err_metrics_destroy:
-- 
2.43.0

