Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CF3BB102;
	Tue, 28 Jul 2026 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226728; cv=none; b=kZxXLw/89Iu4b0kIAzUM2BgkjhTZZGKXd7zvthJEoWUed/VVQAJdGWerLTFhrIxwENDOLP254qAs+MGzbsZEHeTyJjYdYkfqyaNoMk3l13F5CXEDO8qKZDCNAR6KPGksBitk5HEV1rMOFAPJ8Ot7hQZ3uhLK/I50UPlWaVGG4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226728; c=relaxed/simple;
	bh=MwaxVtIWw4U/dkRMKOlvbIGpJAOt7H5NJ5T+sJgRAec=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=YhdWue0LpnfYClIEz8hyVfL5fe7eCI+YzJKmtsvO1CYaBs8K7HOwDl2GWA9vhZF8vTqsrgf01IemkoPQECmexEw6mq96/M29soo9zaO9Hszc/jGGT281Qa9VuOBxLH3VSGO3icTuBUZEWgwxo1zIl19zdIyd6zrfY+zwMl9dmlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=uKsnoMI8; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="uKsnoMI8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785226721; bh=uAd1Z+5dVbcjMIzMcjnCW13h0hkylr15Ck6I93rKWC4=;
	h=From:To:Cc:Subject:Date;
	b=uKsnoMI8Y1atRCbcKvhUuYKpAxbncLdzakIgvYr4KP5al7FZnKPPXuJoanQ0XHrY5
	 tNJuZf9gicjiMBm9zo40cr6f+xtQpc8YFtCU4y5KXVfTQSrPhFkFsgZmIpAUFmg7hg
	 hOJQDUF1B5EdijO2/hhnk16ZcdkI9lcoImT21HDE=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 44B1B0A2; Tue, 28 Jul 2026 16:17:11 +0800
X-QQ-mid: xmsmtpt1785226631tywcle9gv
Message-ID: <tencent_5FFD37A252B4FEA6A80AD25B17C8E904F005@qq.com>
X-QQ-XMAILINFO: NnIX2CK8LSsJf4sCDN5KgWixuox8L+Ozpl34ZQJbEJ+UiumLjUdkb833ydpEgP
	 YX/6nBug1VEGzrK7OLK144d/VVmbCuUzlmpm2C2LohYIRXEnk++bPu4L9Yk3medM5SEjJqd5SEJL
	 6v7LPPgE8cHTnumm71sYSOnph2hn7MuhJu+JcnwioYL4PTGRZ3+tOffRcORC0QDlZM8gA0VuY/Uf
	 Kx2muH4WqjstiZY4gG/ji4L9zHUosfIOxDu8otJum5jDHbiPQKbko46Wqr5ErQ6Vs7VxRXN1eDtm
	 TkvzNS1WtNo/Eu/QWL0vTBclNmejf9+DEzSkAz+baaAlaIVSoODMuVrTlCK0QoH2tfNbR9RBxKzH
	 bNoAPE0Z19SKVvHlU1KcqGGHzI5h5BOBK0/76FQ4jwX1nHF02qmEL3c+BCHqTQuz0Cr6XE+R+Tai
	 Wmh0gQPDxkXndJT4/INr7XPyfCbLy5B6dNLC92MLgiasA2oUCTrFt6k4LfbzlTJLN+njjWjwJeRR
	 T0JAqmsyoCbow2jeMi6A53BRM4Fr3HAwPq64GnX0g+YBvvXe60dVA6MkNKoE5MSaAyGeuGbjn5vM
	 zt9X7iU84rdQRmE7QTII4KUA/BrIUjWKI9/FAm01l+U+z61RCqgwQ9OdvSeBHkHi8BH1HzKnO7nW
	 C4axSkKmVDs3E7QQm6gqAOPzHPyUik8pwY/gnJBP6UxC5aqK23FtZgraGnTbaWpdzg5Ao8S58Umh
	 avrghdTrKzd5H7ec64Nm9Ii9FXpqAM4YT9K0uyLtwnUgXvXLhIbgPHwBAabylVdtqaODLuYUQIGm
	 O4MmYl84JlhBei7hluOpOuhLiJM/vKEeD+IP5+3uBZzWSfoXZCipGPJtKonluJXKQtMcEE+epMQr
	 SJcW1cbD4EKx2vnTRY0ALmxyymMaM0H5thfDq1yBQO4ZOVwke7/l6nMFa9LRUHB+tSubw753xuj9
	 xlFIKxHC8cXgGRKTZERjxnX76zXGhq2Z1Yj8Botzf8joxxOY52WQNUu6xK0rSfJQN2iMry0dcCoG
	 7Jv6XYAY91kNFmU3AmT4l97gveEJQYopmk00MAPvr6emuqQJ8Kgl/jnpnOxwjuxelZdJRIR6A8TK
	 OVeODPzoqUbkNimmpEd4N4swhRRw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Jiawen Liu <1298662399@qq.com>
To: Jian Shen <shenjian15@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH net v2] net: hisilicon: hix5hd2_gmac: remove redundant NAPI delete
Date: Tue, 28 Jul 2026 12:17:10 +0400
X-OQ-MSGID: <20260728081710.228644-1-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hix5hd2_dev_remove() calls netif_napi_del() before unregister_netdev().
This is not needed because unregister_netdev() deletes all NAPI instances
attached to the net_device.

Remove the redundant call and let the networking core tear down the NAPI
instance during unregister_netdev(). The probe error path still keeps its
explicit netif_napi_del(), because the device has not been registered
there.

Fixes: 57c5bc9ad7d7 ("net: hisilicon: add hix5hd2 mac driver")
Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index e3e7f2270560..02282dc86faf 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -1282,7 +1282,6 @@ static void hix5hd2_dev_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct hix5hd2_priv *priv = netdev_priv(ndev);
 
-	netif_napi_del(&priv->napi);
 	unregister_netdev(ndev);
 	mdiobus_unregister(priv->bus);
 	mdiobus_free(priv->bus);
-- 
2.34.1

