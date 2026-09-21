Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4B49B462
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995607; cv=none; b=cdRw9Al4Mj5tVX2xiJh++dlYLtaSz9KcoMPGbEFBCzUIHp44D5r5rbIW9SUfRoLcYkRmjePN7ZnlVdndVIFc9Pk2SOP7y5Yz4fme6zk8VtBE93G0TNuIUgdgcHqmAN5T2xT6bfET9oW6jkZa7enQayuBIY5KcsuG6Vly9cWzX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995607; c=relaxed/simple;
	bh=ikNEYMx+B/ce1BP4LhNP2vesUaLw9BeI3qM6wtNhxSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XmU4LjdKlnlSXeWpencvnq7/GBC7X5liEWm0ooufBYIOw4O9VRcnEm9CWCrzxASplfbeSDm0opt1BBJ68WnyIKnZlm4w5uCg8NMrGCEXECU11e1Kl1f8UtLCD58ywPggs1Fq6DU+9awdI3DNgigiTneVQ9Hd82BNqCrS+IVtv30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMiCVpqQ; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMiCVpqQ"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9adcso5007848a12.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789995603; x=1790600403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gRV8TcWW5ZwNyFZnqA6Ki45Wf1bqD9wRv3NLNzR2dP0=;
        b=jMiCVpqQVf36pJVxR29Q6I8K7/sLbIt7peFUvCAcykYezqPzZkbUTzexCK7OFA/m9R
         tnH/2oELxQKtYEMp3QTS7FXg9E4hyjIpCX2xm7xfq6mORHdZ4WKnbZu+c02Hmzj4oAVr
         98s9NJgpEFzUss9QEGeP01kKYgrUuajFJ0/+/Lf3MQFSm1khhaWZ7jlVpIRapYfJfdeB
         h+4REURNp09nupRobhviZCbBkYpMMIP37LC6lr5Mylss/UsenNP3BFXaPUXWA093XH6q
         f3xTj/291D7YcGARjTFvBsG7yUcHV+/i81Fhd5KdtuXs2sJa6nqXccM/1fEKp3EJVl3C
         js1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789995603; x=1790600403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRV8TcWW5ZwNyFZnqA6Ki45Wf1bqD9wRv3NLNzR2dP0=;
        b=KuQ64spfJUmV/0ZBrrOZEhF0Jzyuo9o7NgES1IbAXq44cqxfzDaeUlMIU6HFVLZ9N6
         TYJzP5vrL6zVmXk9VBJL3cXCtskBJf3CpMpvUJ8ZqbWdSUVwEF4DOqCGxUXRzs0SMB/Q
         Hr/AY6gIRPjlqS9xGR4evN8xgg5IUhxnguS75hi7tmi/mT2YnopBLTYivNtwx3Xzywbw
         QQBG+4x5iRo9BhjIZG3hJZwLruaFMWewutxYHssmnQucKv4GRRRZMomP0KCYxN7noVRy
         v5cWaDP63oDkvTFNqWYUCXKEYHvGazU7x6NH7yHZHmyAECfJ4QWT6h6XAADJcPkk7EaC
         nyAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeoKCQt40wUDPFWLjP5DuVXpnwuNd8d/oOSzuaC5Gt6V3tqLIadQ6VzgUFyIaXIupmAaszSoU=@vger.kernel.org
X-Gm-Message-State: AFuF++m7rEfK04SqKUW2d4rZIbEwnEI47itWAl0XQlRWXZZE5gBqz1MU
	LeZ1dU1KB2AXRtZv/JJr8nbEDnzAJPnnBOF7q2OI1ORxWqOTxgnq0lvL
X-Gm-Gg: AYBFou3G9w6iSLUZO2VbatcjskAetmSaILy/jZMn81WvL1HLi8tjQ/OPDtuTt5oXXf1
	HYmYQjLMvePV+xE0hzYPw9A4mH5X66zJJxxgYelLavXCCdCWF1SJBj3D2Mp27ZOF83m9qr6Bc8K
	wK+v85stheRdRd3kKwa3LtfcwZ4/+Lz2tH/SpKhwbLGb+ryYEE5Qe43SRCkHic7TXwLrb2V2DBZ
	grlvWr7fX9acfCcq4YkE2tOQD3gE0L16tdPDuQTuY2xyrspO1Zbndsb1knMB6v0+PNTuIrKL2yB
	8MC0brFnonHg/v/6TpSQhsfd+T1HS6DhoWZWlDoMT6G2Fzvv6oJxBHYU9PEiHQHrxBd7KEE67cG
	4MxvtMYoetdR6v/evGjQtFq3dug0cNqrta8bjTnekrsbuHg3ZpkKCkF5NzCw661Bm5g5blT5zIg
	sJZy+brMDHFdtLFhv3BG4IEmWpP6zoCH2Z0CqbBEkHUoI4lFOWM25Zq6hU6bnylnWdT2f9sMJJ2
	ZDEWTLGBj5V1p4ijw==
X-Received: by 2002:a17:906:9fcc:b0:c26:1648:a070 with SMTP id a640c23a62f3a-c2a15ead5ccmr900804566b.43.1789995603107;
        Mon, 21 Sep 2026 06:00:03 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a355eb33bsm321193766b.15.2026.09.21.06.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:00:02 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Svyatoslav Nikolenko <nsvatoslav515@gmail.com>,
	syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Subject: [PATCH] net: e1000: fix warning in iounmap on probe failure
Date: Mon, 21 Sep 2026 15:59:32 +0300
Message-ID: <20260921125932.7943-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7f5c6f16142..156903089fa6 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1227,8 +1227,10 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-	iounmap(hw->ce4100_gbe_mdio_base_virt);
-	iounmap(hw->hw_addr);
+	if (hw->ce4100_gbe_mdio_base_virt)
+		iounmap(hw->ce4100_gbe_mdio_base_virt);
+	if (hw->hw_addr)
+		iounmap(hw->hw_addr);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
 	free_netdev(netdev);
-- 
2.47.3

