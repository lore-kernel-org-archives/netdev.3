Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325A33EC81A
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789097545; cv=none; b=i5saOZUIPeFE1no5RtzMiNtVeFyV6hBKOyjDlU2Wy5GRmeKryOh58Eepy69sX20TYr5WuOIZmi2ncp+znEQ8NBASS3N96H4lXp5y15AU2D4P7Tl+YZfgXof0mEtcs8J3vi+C3N5Su9TcTFPQaAU7CIJkGYz9KNvENdh/8UKLJuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789097545; c=relaxed/simple;
	bh=tTcdgtfkRdrrInk4x8w8aSGGE+X4ge2928bklO9RIEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=auDVaOwm+HpCqP8viiVH6JnJ1xP5QMc2XXr+iyVq1ZEAR+MYWdRLm4lUBQ3TW9ZN472IKzq/ELIa7DqedelgCObMT+1FevVO3F7k0fNeAlqhBSnJXPQSRu3rOsx7CYm4rC32NSms/ox2djAjIIcuOgVp9P42l8GtM6pzTkRjKyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGek2WNa; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGek2WNa"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6e3so5056006d6.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789097542; x=1789702342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=628v54VOGyoBAzqTpzRM1YpRZTIxWjHP4RZIO6itcPY=;
        b=AGek2WNaZQBNZR6cbs9PdtuTlu256AZlOE0Nj7UCc7exC0d9XHgc3pWlfFOW0qFbGn
         s98XTPxQvflF1KA4klCirXNYU4pejJLbfAtP1JmmCVwP0vYtB2bOhqLbfoH6SNQHN+5N
         wj6D15dDGdBHDBctlPN/YGtEHIXUNhzmWiXKNYbPSP5zlVJoBHeykIeH1COuk0aKXSfx
         Gwr4g42Xc5FSlIVheMIDoDF1ojC9E2RlyZ7VuQG/2ctNP1q09brwpdEMO67yXGyzqBM5
         o7dx5k/dMn6UHmpTMhGiVYEbt32XEpc0mfNlf0E9emfIIG9+x7T4Gku3ZbpXRj7Q1sW2
         Ru1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789097542; x=1789702342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=628v54VOGyoBAzqTpzRM1YpRZTIxWjHP4RZIO6itcPY=;
        b=DXdaWng0R12v7gT/WPY98FyZXKNuJLMaqIdqc40ftk9XxgMfPhPo8rGTXQUq0gB/4B
         kpK+ajGA3ZeNy9w+zfL89CzTaVAl9ZYHJ6HVWh6jbX88vz2IbqpUrPLm4a0UA130sJoQ
         fhbRK63n4nL1+R88SPm3daN2E+aDPXaC92UfCdV+hUEC87IZj5YEx8Nrb448IBTnmssV
         3HQ1V5cTZ9aWViC//QxbnNnFoXRzB0ePjzCV2KN2FS8qYknkISSx3LU+XCNjFt6/hhpb
         GWx8XKU/5gLY4cwkKh45uA1oiEf9BXu8ktXQxpIBsZqWMPJhf09lTaIr67ieqguoKS6K
         gvUg==
X-Forwarded-Encrypted: i=1; AKwUvBz74v+WABC3d+Ysrnr8jhncmNyhd+2vQ4ZlT8ROkcnlY8zvScZuAugt11p/0+RYX5NZ/8A3K50=@vger.kernel.org
X-Gm-Message-State: AFuF++kPGy8wG67qfjTQ4YQoNnKe0O4pE7eH4C+KnrBMRuscIj29MSx8
	q+QfTVBUK1YTvg4Keo45ERuswQNeTzr8ThVa+pZya4wsaeNbrVY3ylc=
X-Gm-Gg: AYBFou3JUWA5NzUk7AHAwOAU8CVKdZ3twm2SLW8qRiMHCrxLfmq4pMAgYutD6cKgAMt
	HA0gTSMzyhJgm3NQc6ah6dZxaRFi5pXEjBlEV+FLJGEBzDl7Pzh8A/8iNq1qgVDvGjl98ztr8I1
	VOBWRZca+Kn4O6aZUmr14gnvmjcCBgSWwjw/50WY92c0EORLYixEVv7SQN1nBvLhvaqBZUeMrw8
	lqHdHtjzAg3SnVG6C8wIlllbuRxbnWDuPI3AQuEkZBcQdjMouHtzcEgB7uTyEAQnYAlHhCGBOna
	Ytw1pF/QjZLnkHll+uzg0OSKOn41p++MpNxrUBSFAT/BRkK6B8stjOjC5oOLlidXsDcvbqSgjJH
	HeRUYHF10Agqls6wE7TU8dxd+KWY52PYbNpTXjpjRhVpHO0LsEFDY3A4DXI1uri8uJmxoB2bk1e
	T2QOOG1MC2fUf4ZvLiXV6LBu4UZt329IWM/iZkp7+DadPg+NNaMx87t3mm+eaj880cxbny2NbYg
	0rGMeP3EMpDJ/QhjLEiJzEMCMsTliRPsIWqdIP9LTSrHekTAbgY4mY2YuUr6MMQeCSWETl6EDuE
	tckA5pZEm3U8MVf2Y1r9Iau7i+Ek4McqhQ==
X-Received: by 2002:a05:6214:2504:b0:907:dd19:fcb3 with SMTP id 6a1803df08f44-912120f0f85mr29026286d6.24.1789097541743;
        Thu, 10 Sep 2026 20:32:21 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d389esm11109516d6.42.2026.09.10.20.32.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 20:32:20 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: GR-Linux-NIC-Dev@marvell.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net/qla3xxx: Use managed PCI device enablement
Date: Thu, 10 Sep 2026 23:32:19 -0400
Message-ID: <20260911033219.34566-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ql3xxx_probe() enables the PCI device and balances that reference on
probe failure. However, ql3xxx_remove() releases the mappings and PCI
regions without disabling the device, leaving the enable reference
held after unbind.

Use pcim_enable_device() so the PCI device is disabled automatically on
probe failure and driver detach. Remove the explicit disable from the
probe error path to avoid disabling the managed device twice.

Keep the existing manual cleanup of register mappings, PCI regions and
the netdev. These resources are released before the managed PCI disable
action runs.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 5a4faa873782 ("[PATCH] qla3xxx NIC driver")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/qlogic/qla3xxx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 861a13ad7e1ac50fd1607818d592828c869dba0e..c1fe943c91319956c62e317e99478b936562663f 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -3755,7 +3755,7 @@ static int ql3xxx_probe(struct pci_dev *pdev,
 	static int cards_found;
 	int err;
 
-	err = pci_enable_device(pdev);
+	err = pcim_enable_device(pdev);
 	if (err) {
 		pr_err("%s cannot enable PCI device\n", pci_name(pdev));
 		goto err_out;
@@ -3764,7 +3764,7 @@ static int ql3xxx_probe(struct pci_dev *pdev,
 	err = pci_request_regions(pdev, DRV_NAME);
 	if (err) {
 		pr_err("%s cannot obtain PCI resources\n", pci_name(pdev));
-		goto err_out_disable_pdev;
+		goto err_out;
 	}
 
 	pci_set_master(pdev);
@@ -3891,8 +3891,6 @@ static int ql3xxx_probe(struct pci_dev *pdev,
 	free_netdev(ndev);
 err_out_free_regions:
 	pci_release_regions(pdev);
-err_out_disable_pdev:
-	pci_disable_device(pdev);
 err_out:
 	return err;
 }
-- 
2.53.0
