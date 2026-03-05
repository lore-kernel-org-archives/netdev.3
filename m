Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0B13C918;
	Thu,  5 Mar 2026 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721252; cv=none; b=OVCZMjvrC4qP3CCzYY5WLKwoqVyMiKAG6LW7Diou+sBxyJflyiBIhVyOlDNarTKnMZphnCdSLoGBFAyeKw7vZ0e/Ryw6zAxfLEpcOOT9qPmaOszAKvYa1FXhQnhiv8bqZsGV8UVS199F1u9c3P1iLYqYwMjOW3bwnGo7H/RYGMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721252; c=relaxed/simple;
	bh=B/uoFr7e+E9czrHLs6e1HK6yXKRUVQ3wD5Ax7QruoB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKxMq8fX8NSi3RboY0GnpyLTT2qMrOk4Ib2SZMEEUoIoaVIj6gbAe+p+fGu50fwo8PT5BYbnZu2j1kEbZEbnig/IgHpAfmi3UC5NfyAWqRsL+GpeiEWV7eKL5xFneczJoRjkE3k/86Ot5BvaqUVXoCzUmc8uG82rrGNu3KTlAfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VMU+cQtd; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VMU+cQtd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=El
	SmX4CRrGKvpQmuZstPGJWNTIkFLRA9/2KHspzpcc4=; b=VMU+cQtd/bUiesAKbS
	j+EKwXfid+rvP+5OtwndvnMOQRNPTcpEhP+YyNP5VA6jR88/0BI7fSDNuRkf+BtK
	b1TwWOYwu7LKUphluissoRNr8c9Ki/SXUxPxTlrL16fv4dnXCyBkWg0GUQ0sTuKg
	O+JsMld1QBaYyPiz7mBjV7yNw=
Received: from haiyue-pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCnZWUIlKlpoF6ROw--.52848S2;
	Thu, 05 Mar 2026 22:32:42 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: netdev@vger.kernel.org
Cc: Haiyue Wang <haiyuewa@163.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v1] mctp: i2c: fix skb memory leak in receive path
Date: Thu,  5 Mar 2026 22:32:34 +0800
Message-ID: <20260305143240.97592-1-haiyuewa@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnZWUIlKlpoF6ROw--.52848S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw47Gw4rKF4DJw18urWrGrg_yoW3JFg_u3
	42grZrJrWjgF4Yk3ySkws0v34Fyr1Yqa4vgFZ3tF9xZ3s8tFnrWrW8Zr13Gr18uw48AayD
	GrnxtryIy3y7tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRC0PSUUUUUU==
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/xtbC8ArrV2mplArizAAA32

When 'midev->allow_rx' is false, the newly allocated skb isn't consumed
by netif_rx(), it needs to free the skb directly.

Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
Signed-off-by: Haiyue Wang <haiyuewa@163.com>
---
 drivers/net/mctp/mctp-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index de6bc1736734..15fe4d1163c1 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -343,6 +343,7 @@ static int mctp_i2c_recv(struct mctp_i2c_dev *midev)
 	} else {
 		status = NET_RX_DROP;
 		spin_unlock_irqrestore(&midev->lock, flags);
+		kfree_skb(skb);
 	}
 
 	if (status == NET_RX_SUCCESS) {
-- 
2.53.0

