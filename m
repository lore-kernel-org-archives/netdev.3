Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491956;
	b=xipRaleX3/Sb47kTnAxkJMUeB4S2mhXK9gF8phxqJHPEnPWPmtT03CKvpEM+wzL93VPk
	 nNNoSZCbkjYA/+qXU29jU6PUY5c+c7LmovbWTaUoGQ1XkRi1seuw/TqiW1DorC4MSsfAj
	 w3IsAttjQht1G4Xt0SzH5D4mP3H4+xdu60we+7Cyo9+z6R1tCisMktx7LwrXwn0zKd9Iz
	 xvMX6mpsq7EjN5EiE0gHFx6TpNc/2rEE4osGFtyuwXTCtxaz2/aX+7Gkjmr5DTI7hfnPM
	 GxTfrIfhwbem+4Bi+IXYBpC4jC5EtewUJRMixgNcFpJNugFcB7VfnoWiP9RlXqwtZNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491956;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=FMqDjdMmi4Izh7O/PokrYiTvvPPFH5fzjIYWdhpR2Wk=;
	b=5cLB4uO5wlCFuag7oECD7uZJZGSySBFv1F9dKCKSz51zNzKxsLyNSMOyaBr8DMEKKwky
	 ehHM7XSOAoGUTJvd29GWvRqij2fKSNPrvWocg/ztDnlCxBjoiyuyji/TP8SQj6D4Kf/OA
	 AJZE45DRKgNIltCxvgrCG/ZeQlJfFXBzjwV4HRyrfaJyW8d2psdY/dRlSsazenjdTfiH9
	 4eeSqeMrhLxZ+kz9x3m6VoYstSfwK7z4uA+XCZiCwSYJ4kW1V2CWzwjdteHinPDlQ8zHg
	 30ol2s7DYhpJ8iM11y6Lf6Y4AkKDFFoPFk/RUeHv47nH+vB/IsKW7FSC7P3BCjPCjzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=HYMhgQ3f;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8153060A380D;
	Thu, 12 Nov 2026 13:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8153060A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=HYMhgQ3f
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54773892b;
	Thu, 12 Nov 2026 21:59:11 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] bnx2x: Fix potential IRO array leak on removal
Date: Thu, 12 Nov 2026 21:59:10 +0800
Message-ID: <20261112-88a3a7ff32-net-bnx2x@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1d00e27db03a1kunm2b5a5f4f29fd
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSRpPVh1KTRlDS0pLTB5DTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=HYMhgQ3fGK8reRrzWOYzX2rXKHfaq4oFtZCfNjropvIF1bVlWpcD6ytRaAowi4l3SJYliwaj+slK2NuNX/FJm+yv5/LweGvcm+2csL8QkstVAlNvrJciWt/F0joU+P9bsoqutiW8duyZWD71Kp8s3tCQjTUW16rubIEgkb1b+NQ=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=FMqDjdMmi4Izh7O/PokrYiTvvPPFH5fzjIYWdhpR2Wk=;
	h=date:mime-version:subject:message-id:from;

Firmware initialization allocates a separate IRO array, but
bnx2x_release_firmware() only frees the other parsed tables. Removing
the device loses the array pointer with the netdev.

Free the IRO array with the remaining firmware tables.

This issue was found by our static analysis tool under development.

Fixes: 523224a3b3cd ("bnx2x, cnic, bnx2i: use new FW/HSI")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 277c7bd9c6e7..c6afde9466be 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -13489,6 +13489,7 @@ static int bnx2x_init_firmware(struct bnx2x *bp)
 
 static void bnx2x_release_firmware(struct bnx2x *bp)
 {
+	kfree(bp->iro_arr);
 	kfree(bp->init_ops_offsets);
 	kfree(bp->init_ops);
 	kfree(bp->init_data);

base-commit: 2e54b3e187300893688c2c7517894f5d96732e05
