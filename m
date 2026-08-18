Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9740628850E;
	Tue, 18 Aug 2026 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058817; cv=none; b=J6/iX8sf8cEltwYNKsRcCeUnnPRFwcsqrxUsU03kVbjigcDfq2l3zwJmc1Z9SnSwLQygnVsj582QYSQVixiUVWQLZRv2lT6XjB88dZER6fA4j5wzmeHxzkTVgpzZ05FcdkDaEfg4XXi5/4ksuLb0JjZ1Evt0T4JTz4owFNjezXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058817; c=relaxed/simple;
	bh=6YOfbXCCKvhFjZDUV4p+Z1szIMsxveYWIlQMnnVPSP4=;
	h=Message-ID:From:Subject:To:Date; b=s5gENWHoniUDzmAFG/tjp711REAagqTnTsGzMbo0+sLok1gR1wxPcC2e8dHELsi4Z4QjVAqB569pORC4zauTBbqeG4tjN0v08VdCrR+iNiwShWDHncsLHGsPqn0wHZOOv0+neRLMbt0ZQm7lLlZS9XdbqaO0FSoHg6Q9bxcM8iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HhD7Q0Rl; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HhD7Q0Rl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787058812; bh=Hlw+UgMe3Vr4eLzfqP2J7mxHixFZ6sWQgXVYEq+qYFw=;
	h=From:Subject:To:Date;
	b=HhD7Q0Rl6WkBTdOztETwiYcadUMV5I3ZL0sjYJ/B7j+1M627xxIC5xFggYBW+DooP
	 nf3GRmER9sLvFOe6Fcxe2wTwjP8Ofg7Bf/oe8633j+uqrbOmTB7IooBTjObrDO1TyM
	 NMSLNjsyyEC7YOZ31Y4eENmzPt2TeTafvjvdgFdY=
Received: from [127.0.1.1] ([5.195.0.150])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 1721C6D8; Tue, 18 Aug 2026 21:05:50 +0800
X-QQ-mid: xmsmtpt1787058719twlegke8g
Message-ID: <tencent_1B2B4E438079BF5595B1F50C45FF9067BA08@qq.com>
X-QQ-XMAILINFO: NAOky/E1C/NcEso1yPYc5BF/mLLAzTgmAFt0wV3S2WxA1w8x1X8HK+RV9MPLnz
	 AH8gK4ABpoUpzgKdpDVHdj8oDYCcpx8Y6myB+4rlABLgyw31xeaB1ZbGd5Np6GSyAYAse4k8h7Vb
	 AoMmVLLUO3T+kglqgQN1+UZ0TOQi+5X62Mr+ZoCgCJGH/73//gRP7P9aIR7kYK+QMIBqnabZNYxj
	 deDUmI9/S6FC5AX95KTMozkbhrLDKNIU8yVTCqVjNtzHFXL289oPvdi1iSLTT2h/xFlueQ80r6hR
	 k/Cvnz9wdavk41MGw+04lWk7M6j+A6/AAV/1jSw2tQodszF5QkxOwpSX514AxjT9pd+lR9RTPGHJ
	 Y+CSvfQthmGgOyii1IpmThi0dEm6Z130rjEfZzS04ZEU/pU9DEcoAWEmqZJRVy49InmnJqlGdZIZ
	 4SGs6D9umt7W0a/9gxP8V3M/v8GMF+ALIBpoQXFUGISwyZSTqsgxvwr45TcBqWluK2jwadjBKbCi
	 jLlCpvOHmjmHkq+8tSlpCvNVRPbn9NbVtJ3b9/6Xlo01IaGQdqWGJOqs1z08LAoiOVgoh/VfdW6S
	 6aCZ5OzsKdS0i6+38ay7hVMhhGh6Ks7Ei9BG2qM718oZ8l7LAhQbOfbwMThcnYFWzT0FoecKVKo8
	 MzRYnfY/YwHDvKVWiCjhwJBLPYR/lBde4T5iqCp699o0K22VYloKtuSD9XBODlYLatURFHIToI1S
	 /rYLx1hV14puq4lj+de+7V4u7Fma2ZlhgIG+Y3swsOESj6YtkXNM//TsTu+ysPli7B6Htc6yCZRE
	 OG4Zd0QNEqXgOdLzJwjJjCYOgO7ASg56f6zlVt5Hhvrmop783DlRS0+w3S4lJhRbJjUrkCvVZyIO
	 XR8npLKhesu+2cHESRrzBmXPw1K//9Bhy6hh5Qve9vFb6Xq1/fhEhbdhwA16weYhJjYJD+Cp98Fq
	 2X+pOUuacQU7zbbYP7oS9FWW6A1obeYEYH9mRSYl2sm3aPSrlzo9aNKvlFFXnL6/v42RpPXDSU5m
	 CKlzxUnrDmCJjKJjTpbutUXFvOW7g=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Jiawen Liu <1298662399@qq.com>
Subject: [PATCH] net: hisilicon: hisi-femac: fix NAPI teardown ordering
To: Jian Shen <shenjian15@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 18 Aug 2026 17:13:29 +0400
X-OQ-MSGID: <178705880941.291840.8524323292341451923@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Remove the redundant explicit NAPI deletion from the registered-device
remove path.

The confirmed lifecycle contract is that unregister_netdev() performs
the NAPI teardown. Probe failure cleanup before registration remains
unchanged.

Signed-off-by: jiawen <1298662399@qq.com>
---
diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -898,7 +898,6 @@
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct hisi_femac_priv *priv = netdev_priv(ndev);
 
-	netif_napi_del(&priv->napi);
 	unregister_netdev(ndev);
 
 	phy_disconnect(ndev->phydev);

