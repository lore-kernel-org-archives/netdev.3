Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7F53E6DC9
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539069; cv=none; b=UTgr77iD42CA1zOCR9wRDoAxOYychdGCZ4VVMcC7XkmEcl7JGBOExOygFUinWdBBc5Dlu5iZx6xFjTtwoxErZdffbgaUviAq8erLWGh+hwomFaKym3sBb67rY3ruuV9WkNSdK5J4vMRiHvpyG5uMrGKbrY6P8kV74p8NAeytFT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539069; c=relaxed/simple;
	bh=LCQlOENHLpgDLFIJjB+UUCKmKYjt9PyQtWzPpaNJYRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LWb3XAVp7slFnb5QCCp9qAi/gb9aNI0QAqtDhnSoFhXrQr5YFyjq5Dw4dFf2dMMLVeqTqG1y5F75BaprGIFvrbXXPHPOWwY84m/dpUdqgEmp+92qBW0Ybi2REt2hKNtOyPhZ26/lVkbMoidBd+lA1tLkVpnkPlAM7DuUs6jgzCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVyFxUbt; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVyFxUbt"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccc02279so447461a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 23:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789539067; x=1790143867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TmAAY2RsOedvqqE/dv3Tvbl9f0z0X1eUeI0/bSG7dyI=;
        b=YVyFxUbtjjPyq2bxlYUyZB8mVnZY2F8OSFvRFfGT7gMxR/6gBR/HOlAnZTqS83zXoQ
         zjL1odG7IMnsVOU1HjniVbsBtEYn/fNykmfGAWYl7HB8gq5p620MPTMG0k0PyapLbfZr
         7BhQGh8+e9YLpvWtyFzY4VQv3HTUglxqGKfvAAzDyvitLw9vng5LUFLUcFoKu8lbKYtQ
         ld4J+mxLVCimQ0r/zFrjyFqXIlaM7pM6r2mZ5ZkgE1J9UWUgH9/yl1cuwQ54ix5kwZEQ
         zwMDg5F5Z9WVf0oQiIOpyN9jDGiqtHiL+mMQvkelaqy6v16rK6tkemTTbiBls3Xw8X6r
         E7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789539067; x=1790143867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TmAAY2RsOedvqqE/dv3Tvbl9f0z0X1eUeI0/bSG7dyI=;
        b=qIxMemnJ4u1q8Ulyz7ghQvjktt7hkPGUMdM0nRsMuNMfRQLpMZPlzhpHushRNnmT6U
         edmdsk9Waax81qQO19zY0SFmNRvb97oFgv0SUCBl8Oh4rNiWelOKpPFpmchMLA/v/PDm
         s1Xn9C3TVOpND/nAVe7kjwZr9CKDxtCV+QLD/R+mPKJsPGWRc+jWHkhS59c2HaVX0uiR
         daioQxf6BBBJ+BJE9N76qfPX51exGOdLYfDFVZLaHZP9XlxCCQNThVoBY4xE3F7TjLM/
         wLX5+IJTslKCIW17pu5boao+roqSpzTLT0w0OS9IDAg3PiECIDZZPWCtS1GaS93Erez6
         5CkA==
X-Forwarded-Encrypted: i=1; AKwUvBya6tzfT2SQjWE33krVSmczVWN/ZGf5rfARuHJB1QMfdKlSLcsUIUWO2/xwu5NyWcSmylxLFKY=@vger.kernel.org
X-Gm-Message-State: AFuF++nnJhU7s0LJdZeGp2t1h+KQ+IHJNlGrjR+ZW4WMVeYW6zW3/F7V
	89OarXME5Yf+y6QPARZNUssXvcshS7ZLCZEh/SKzdBdhVZbe3mWuG1fW
X-Gm-Gg: AYBFou338u5PyE9uAH6Y94rJKTBkk0HLWE3hEIc90zVDHoMQ/MNLyinGb7LILBe7Eiq
	CsK3t3fEHTQf7cXMDdQn31kMUA5TJlTlmQA1DvvAutCpk64IEwaoRCPqDF/iXqzmQBenI9i++/K
	sdX2Cy0/vM1Ee2qksh8bnfRg5KQMd+dbDYVIg1TBl0l1vKfDAyTS1ftk8NyGRujm54a76EQp+Tv
	zy8MNrBcoP/8sQKl2uiFrJMxwDS7kWCzG6Jzel41OIUGX1QEnkOvX9LwIHXvE8gxvtReTPysANc
	uFF2N70M0vEPCWxuNyCgIjzHPEyEkEtN7Bob3Cp2dHNsen9PbKCmF2ATJeQFbKW3y4ZudktB7Hx
	8LibfOZbfS4UnzJAPeUzhYYCIOkyJEiEtiCv6NStoNe6C9keawWwy0UT3f5xr504WF8IOUhokzQ
	iH2uTOHYRsfceZHNC9I4y+QdKuNPrUhNT3QtuLj+taAxVLDf/hLyx/Aw==
X-Received: by 2002:a17:90b:390e:b0:39e:53a:c8d4 with SMTP id 98e67ed59e1d1-39e1e424a7dmr2996805a91.12.1789539067435;
        Tue, 15 Sep 2026 23:11:07 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1c4ac8cbsm668374a91.2.2026.09.15.23.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:11:07 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Samuel Chessman <chessman@tux.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: tlan: disable PCI device on remove
Date: Wed, 16 Sep 2026 14:10:56 +0800
Message-ID: <20260916061056.2917164-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tlan_probe1() enables the PCI device with pci_enable_device().

The probe failure path disables the device with pci_disable_device().
However, after a successful probe, tlan_remove_one() releases the PCI
regions and frees the net device without disabling the PCI device.

Call pci_disable_device() during removal to balance the successful
pci_enable_device() call.

This issue was found by manual code inspection.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/ti/tlan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/tlan.c
index 274a1837025c..0a8bed6c9ca0 100644
--- a/drivers/net/ethernet/ti/tlan.c
+++ b/drivers/net/ethernet/ti/tlan.c
@@ -302,6 +302,9 @@ static void tlan_remove_one(struct pci_dev *pdev)
 
 	cancel_work_sync(&priv->tlan_tqueue);
 	free_netdev(dev);
+#ifdef CONFIG_PCI
+	pci_disable_device(pdev);
+#endif
 }
 
 static void tlan_start(struct net_device *dev)
-- 
2.43.0

