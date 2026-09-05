Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81624351C3B;
	Sat,  5 Sep 2026 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615763; cv=none; b=nhhRHwBIKG+GaQa7+Pydllt3Yxssvw7/QgFUmGhoXkjIbzRhHxFjXkQJ3z8Ow4cNMxTtH/8xcAoTJVoo92vHND/qO2DsUm4qx8Wn/pKn31vJbvriQrhFs4MkxuwtRrFXOT9+FnV+/n4wGSL8hp3urHUtR+JFscea5WBYqMnk0xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615763; c=relaxed/simple;
	bh=PYSTaU2HixrFodwJXEtM6Q06Li8VvJ5yq8VeBmkZ89o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7Whok8v4a0ZmeIOKNCTkx5oICUZB+wtKD/Ckf9nH3XJoxy1Wt/2pPUjlTlAkYJ6d5Tse7QWk8D5ym7awcV6nrDE1V48wztCTm3TXqYT9T9ws3ZVK17kvAY9aokX0HFGdIwUz0V4/3LYNRCnmwP8cNlWSs6VnBBIRvKAqWgM15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PiPtoBbh; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PiPtoBbh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mx
	SLjAAyGChO5Uu4kD2jrbr20FY81+OCfC0p275jTms=; b=PiPtoBbhseTSG6RR1j
	ziW1mQb9/ddhrNfo9DNuwBNYzJz5XTwbaIPyMkizhGQAT8xnfHXNwhu2+Flj0F4B
	hQtLNuHLyKVVvNIoysU8tkqPW5W30a3tVhHg0Y7BsroNx6xHM8x+EPPS8QX0WHIO
	GpOvTSS8Yz93jiXnJbOA+ftzI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBnFy0rHJxquzJXAw--.7346S2;
	Sat, 05 Sep 2026 21:42:04 +0800 (CST)
From: "hpp.iscas" <hppiscas@163.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "hpp.iscas" <hppiscas@163.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Vivien Didelot <vivien.didelot@gmail.com>
Subject: [PATCH] net: dsa: ar9331: Publish the OF module alias
Date: Sat,  5 Sep 2026 21:42:01 +0800
Message-ID: <20260905134201.66828-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:_____wBnFy0rHJxquzJXAw--.7346S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wry5Cw45Ww4UZrWfuw4rXwb_yoWfZwb_u3
	W3ZFWfWF4UGF1jkr1F9rs8ZrykA3Wrurs5Xr1vqFy3Wr17Xr97ZFs2vrZrZrZ8uryUKFnx
	AFykXF48uayYvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRBT5tUUUUU==
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7Q3TnGqcHC1udgAA3w

The AR9331 switch driver registers an OF match table on the MDIO bus.=0D
The bus emits an OF modalias for matching devices, but this table is=0D
not exported to the module's alias metadata.=0D
=0D
Publish the existing table without changing DSA registration or routing.=0D
=0D
Fixes: ec6698c272de ("net: dsa: add support for Atheros AR9331 built-in swi=
tch")=0D
Signed-off-by: hpp.iscas <hppiscas@163.com>=0D
---=0D
 drivers/net/dsa/qca/ar9331.c | 1 +=0D
 1 file changed, 1 insertion(+)=0D
=0D
diff --git a/drivers/net/dsa/qca/ar9331.c b/drivers/net/dsa/qca/ar9331.c=0D
index 0526aa9..4b3b961 100644=0D
--- a/drivers/net/dsa/qca/ar9331.c=0D
+++ b/drivers/net/dsa/qca/ar9331.c=0D
@@ -1124,6 +1124,7 @@ static const struct of_device_id ar9331_sw_of_match[]=
 =3D {=0D
 	{ .compatible =3D "qca,ar9331-switch" },=0D
 	{ },=0D
 };=0D
+MODULE_DEVICE_TABLE(of, ar9331_sw_of_match);=0D
 =0D
 static struct mdio_driver ar9331_sw_mdio_driver =3D {=0D
 	.probe =3D ar9331_sw_probe,=0D

