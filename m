Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0044A7E0FF;
	Tue, 22 Sep 2026 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038288; cv=none; b=OZsTpvBCATLoznZX9hgB/zafERQ1wZCXDHQ7r3PcroMwfdORJcYBhb1oYAddR7WSPaNC/IJx9kPTqYxJw+oNnooCDmPU6KLdY+U/+PnPdGfZpRPa+Fw3dH4u73ix4U0NT6z2c4R8fygKN/QuATIXm1aIPTVvXnpoJ6g7PG7U1FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038288; c=relaxed/simple;
	bh=9ODhgmhwooKZWj5DG3+H2ncIS+XGRaG6cFEiuqYVOVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eB6yBu/Tokqc5tdpFaIZdhr2WxBVnsx70jWoWbEXzFNYmY7YL9l3EvsDS2xDLR3wr5zKu/LPapWkkq3N+i1PIjvE3Vp5BLhG9A7Nw98jQVWYM7POlEKfZ6GcVskUv9OwCR3QoXAP466FKIy4GymM65gNeYGIF7zidrrMGgyr9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kH7wg21z; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kH7wg21z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hU
	rmChZYIzv/Ri4MxoMOBxPpdJC/oAKAp5fDivpiEYs=; b=kH7wg21zQ7WWqHZskM
	Jt3hsTfGJNVs7B+8oJmdzmOxOvhWK0Kza1kvgYlHBDYXK1CKbrzHc9qiakst+R8o
	+vtt9ol1SGYqW1KWGlWLqHabgX+e985lpEYHrrV/wvL4eCX/cKNgfrcQHKzQgFCA
	iEwWs8a+0H7pWE3xV/O8+O8Wc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3P5vr0LFqjmcBAA--.965S2;
	Tue, 22 Sep 2026 08:50:52 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: andrew@lunn.ch
Cc: olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linusw@kernel.org,
	hppiscas@163.com
Subject: [PATCH net-next v2] net: dsa: mv88e6060: publish the OF module alias
Date: Tue, 22 Sep 2026 08:50:49 +0800
Message-ID: <20260922005049.7647-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P5vr0LFqjmcBAA--.965S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1UGr45ArWxZrW7WrWktFb_yoW8GF4fpF
	ZrCF15Zry8JF45J3yDuw4xuFyY93ZxA395KFyDZ34fZry5ZF9rX3yfKa4Ykw15Jr45Gr17
	tF4jyry5ua90qFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRYg4DUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxQx2P2qx0OyolgAA3Z

The MDIO driver matches marvell,mv88e6060 through its OF table, but the
table is not exported. The existing platform alias does not supply the
OF modalias used for this MDIO-enumerated device.

Export the existing table so modular OF-based configurations can load
the switch driver automatically.

The issue was found by our static-analysis tool.

Fixes: 277617603c02 ("net: dsa: mv88e6060: Support probing as an mdio device")
Reviewed-by: Linus Walleij <linusw@kernel.org>
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1:
- use the full author name as Jakub requested
- rebase on net-next while preserving the one-line change reviewed by Linus

Previous version:
https://lore.kernel.org/all/20260905134131.66680-1-hppiscas@163.com/

 drivers/net/dsa/mv88e6060.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
index 64bf3d759d17..3bb485a90429 100644
--- a/drivers/net/dsa/mv88e6060.c
+++ b/drivers/net/dsa/mv88e6060.c
@@ -364,6 +364,7 @@ static const struct of_device_id mv88e6060_of_match[] = {
 	},
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, mv88e6060_of_match);
 
 static struct mdio_driver mv88e6060_driver = {
 	.probe	= mv88e6060_probe,

base-commit: c7a2a8c0c9ef480849d655273101dcd0c5067e6a
-- 
2.50.1 (Apple Git-155)

