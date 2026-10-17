Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039D3C3C15
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266073; cv=none; b=ChWrrDAszpGdqRTO0luznWkzl7WclWsOg7XCzql5NN3XNp8iuSILPPujZ4mPx0VchyzZVZJ6/v24qYs3V4ZM1jHTjjN3lMuQuVCb01OmXQYqgqb4J2BXTJbfD/Fj3hjLc3qfoEgWkDSJrd06HuOrEXyV98cbrV7CPQx4mYyiGB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266073; c=relaxed/simple;
	bh=QPv+Z8vzX3VY5Sy1t/flRp1XN74GPkpxccCBZDK+Y7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4GEXIoHPgVXD8gz4sjWTjDQDDY6kOnkbEULIZy/DkG56o9CCo8kzL0rxh89wPf5BZMhmSukUHkk9vSVuTgQt/Qx8MERL0rNAbshF/G5SOswPXPsXQmKxvVRBNigJYucO7XzYGnRGxk4zLKp5Wg/LM9S4lxJ6P8W5+fpiYu8ymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rSUfWYRX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSUfWYRX"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48b060ec084so534344f8f.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792266070; x=1792870870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7bkANSMhFloWtWtc/bd8b694jgoI0AgZf+f/ClS6h3w=;
        b=rSUfWYRXrQNmlcYPWOOI/ITjxrth8LiEmwZI3WbyV8LyC6gUxefT4QGk6hrY5N5vFe
         3HbzBNutoa34pO1p/oewrObEBUEP68fcAZ6BxWAS8WUxK6BpFkqXlFj/DPcqm0mJSN0A
         xW/ddMyGxrJD4W1u6Po9J/42MpNE9Mqn7hi6ybtjW8LsN9ywzQxJdGqrb8ybsRokFiJ0
         sU+Z2hEdAfNVbKHVydqISwzu07DbfQPLgy818LFlUCJknb+yd0wY5EYGLpWlY+Alp0Ik
         7y8zCVbOr8Fc1b9fp2xc6zoYA+gss+TarDspW1n7WH5EaP3gxrfE2Q8i72hg0+ncKqBi
         UT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792266070; x=1792870870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7bkANSMhFloWtWtc/bd8b694jgoI0AgZf+f/ClS6h3w=;
        b=fO0qhDerAHl/Ficw/vXUTrU0u34gaDfi78Xs/rh+wLUrgxrcyJSE85MfTFM1rWDhB5
         OHenV2QUohQVC2CK/D6Zf56Go0y7IOD0NuP9y+BtefNhaPkFGURNpE3C2LPA1a+EUBOe
         gjXWstIS+zGwKhTlSgVQLlQF3NUPCtkAo7FNpbWaqNQlrAAz3l10jHz4moKNO9bALyUm
         FXzkY8dWZALr2uA4oSmAouAccB/rSsrJd7D0h8U2L6BezQ+GJXInMUla1YpHuRwHh5xL
         x6Io661kg2t9BPN1qpOBvntdq9J68mYBgjq9uNLH+rucEpoFQERVxP62/gop0DMytoIR
         WxyA==
X-Forwarded-Encrypted: i=1; AKwUvBzY94ZDe6KzF+LoWjANKIQZw4sO0MOwvBWO+t/yu642KuiKFZ9931EVeNR/+1+gvP8DtIPlbmI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDKz0Y7w9h3L7DDbS7iEccu4s2DUjOp77wOsflliFYJaFbSDL3
	NWQAmuslfE/6YvbN/WDZvXOdzgs1qvennl6o3t4uJKetvk7Qi64sOhJg
X-Gm-Gg: AYBFou11P/rXdcuGA5686GjmLUXtWDLfJIRLaSUhiXE91xYRmwpuO8bq7GMEWLzaKR7
	2gdSACIo1ILyHRe0Ahtp+QkM4lmkTkMHNEwLdREfTV2gSu8RFZ/3+FlkOlKVZzOaoy9vlOTnZt9
	D85gyfM5BVrUX+kRyLrr7nOFMBxTIVHnVXEh9PAkzYsbB2KM77kgwR2xEgdZkE6Ugt9ee+S5DBz
	0PePN6xQP/OtCicLDPNGjsFLhSQssFmdQLGXNteHX+huMTmb2ixV4mI7vrRlcdziovapvcofR96
	XeyUj3MdVaZtTlbHE7n6r2nDOkNZRt3KD05l1YsY1gK3Mys1h5OMjcnOaYMHNbgHCQPaqpQmZyp
	bB7I7P7qNiOzP5CL7eJEBIqZyeECWUf9JBCnqEuL/J3TKKO6bUTDjJtCLoIurHJS5GhkhEOIGR0
	vpTDcC69DA/VXNscuoRqtNrJOZHuuKyuZDRHK2r/snykdFbsoR2gNRvusHc7SF70JH7KOcfFFiX
	dNFQKw+T6LZpn/M+cBiY8rI4nGZycH3E8YDsBQ=
X-Received: by 2002:a05:6000:260a:b0:486:f9ea:796f with SMTP id ffacd0b85a97d-48e07fa67d5mr6234193f8f.41.1792266069637;
        Sat, 17 Oct 2026 12:41:09 -0700 (PDT)
Received: from varodek-gpd-pocket-4.tailae96b8.ts.net ([2a04:ee41:108:fe4b:620d:dc44:b372:2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5033a2sm12803462f8f.45.2026.10.17.12.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:41:08 -0700 (PDT)
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <bjorn@helgaas.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] net/mlx5: Use generic power management
Date: Sat, 17 Oct 2026 21:41:02 +0200
Message-ID: <20261017194104.2684-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to the generic power management and remove the usage of legacy
(pci_driver) hooks.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 5f28d906c35b..d8dba3328bb6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -2204,8 +2204,9 @@ static void shutdown(struct pci_dev *pdev)
 	mlx5_pci_disable_device(dev);
 }
 
-static int mlx5_suspend(struct pci_dev *pdev, pm_message_t state)
+static int mlx5_suspend(struct device *device)
 {
+	struct pci_dev *pdev = to_pci_dev(device);
 	struct mlx5_core_dev *dev = pci_get_drvdata(pdev);
 
 	mlx5_unload_one(dev, true);
@@ -2213,13 +2214,16 @@ static int mlx5_suspend(struct pci_dev *pdev, pm_message_t state)
 	return 0;
 }
 
-static int mlx5_resume(struct pci_dev *pdev)
+static int mlx5_resume(struct device *device)
 {
+	struct pci_dev *pdev = to_pci_dev(device);
 	struct mlx5_core_dev *dev = pci_get_drvdata(pdev);
 
 	return mlx5_load_one(dev, false);
 }
 
+static DEFINE_SIMPLE_DEV_PM_OPS(mlx5_pm_ops, mlx5_suspend, mlx5_resume);
+
 static const struct pci_device_id mlx5_core_pci_table[] = {
 	{ PCI_VDEVICE(MELLANOX, PCI_DEVICE_ID_MELLANOX_CONNECTIB) },
 	{ PCI_VDEVICE(MELLANOX, 0x1012),
@@ -2281,8 +2285,7 @@ static struct pci_driver mlx5_core_driver = {
 	.id_table       = mlx5_core_pci_table,
 	.probe          = probe_one,
 	.remove         = remove_one,
-	.suspend        = mlx5_suspend,
-	.resume         = mlx5_resume,
+	.driver.pm      = pm_sleep_ptr(&mlx5_pm_ops),
 	.shutdown	= shutdown,
 	.err_handler	= &mlx5_err_handler,
 	.sriov_configure   = mlx5_core_sriov_configure,
-- 
2.56.0

