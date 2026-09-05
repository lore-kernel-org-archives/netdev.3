Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C5B351C3B;
	Sat,  5 Sep 2026 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615742; cv=none; b=N8QSEeiWxop3zYFUWGBrWf9iHcT0ZRrO+Qj5RIAaqqlwVjLOioQYTP3jI4Qeyn6VUX9/AlIyGdED8nlnLVpc+BVIGDJP05gQmXJbhn3j6xtEaTzzgqJv6xBkzQ8UbYeWCvo+pTksRAYtvZeFsjbZs3vrNihjzyribkM/rwm/p+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615742; c=relaxed/simple;
	bh=DV5kZCn9AHgkn/ucq6cPcwx8ll6l6mes1tHqzQa8eVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIzkYBb9XLvWWDAqNyl5pMaesXAg4DxH4pCeGRT5eLufFumR7vU46paWLU6mrJk9+OTKT7vQ6ZyvmgguG/o3Y2t8Ua1JvzTzNTjfjret+u55ogWfsyyd7dnUzDGYexmtv2bbW3ouKWf93txrpJY5tjzp1A8Bwj3efk8YbwhAtYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Gi6SsZ9b; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gi6SsZ9b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=kj
	oEQnqFUsxb3IRO1evHu3Sz5ELK6lCtHFlobvOacsI=; b=Gi6SsZ9bl3EdwjFTjG
	jDR5Ty9HCmB7AdXi+ettwAm/5ym1B5/Oriz5z0PPa0OQpaYwap5oueE8sFA2WQbi
	rx9weeVtTx7wEHjqzXL1BXqkdLfxihGRYS+2Rxj986CZrJoquFCgD3e6SiQdPxvS
	95yf6KEy2D9nDuKNUQlBPGndo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBX1PINHJxqeL0WOw--.14183S2;
	Sat, 05 Sep 2026 21:41:34 +0800 (CST)
From: "hpp.iscas" <hppiscas@163.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "hpp.iscas" <hppiscas@163.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: dsa: mv88e6060: Publish the OF module alias
Date: Sat,  5 Sep 2026 21:41:31 +0800
Message-ID: <20260905134131.66680-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:PSgvCgBX1PINHJxqeL0WOw--.14183S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1rWw43Gw1DZryDXrykGrg_yoWfXrXE93
	WxXFy3Wr1UGry8t3WfKr43Zr9ay347u3WkZryIvFWSgry7Ww1j9w4q9r9rJryUCryUJF1D
	CF17WryY9r98AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUFoGDUUUUU==
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7Q7LlGqcHA5sqAAA3c

The MV88E6060 MDIO driver uses mv88e6060_of_match for OF matching.=0D
The MDIO bus emits an OF modalias for such devices, but the module=0D
only provides the legacy platform:mv88e6060 alias.=0D
=0D
Publish the OF match table and retain the legacy alias.=0D
=0D
Fixes: 277617603c02 ("net: dsa: mv88e6060: Support probing as an mdio devic=
e")=0D
Signed-off-by: hpp.iscas <hppiscas@163.com>=0D
---=0D
 drivers/net/dsa/mv88e6060.c | 1 +=0D
 1 file changed, 1 insertion(+)=0D
=0D
diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c=0D
index 9c8ac14..8373ccd 100644=0D
--- a/drivers/net/dsa/mv88e6060.c=0D
+++ b/drivers/net/dsa/mv88e6060.c=0D
@@ -364,6 +364,7 @@ static const struct of_device_id mv88e6060_of_match[] =
=3D {=0D
 	},=0D
 	{ /* sentinel */ },=0D
 };=0D
+MODULE_DEVICE_TABLE(of, mv88e6060_of_match);=0D
 =0D
 static struct mdio_driver mv88e6060_driver =3D {=0D
 	.probe	=3D mv88e6060_probe,=0D

