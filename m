Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C037A496;
	Sat,  5 Sep 2026 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615073; cv=none; b=Skev6VxCoBi0xb3ACJ93xwusCvI2PYsKonoQkVaEoGc7MzQ/rL5icFfFBhZVYiVoWZsc+CJ0lkyu7IbwJvfoNvp5cusDT2J7vxtYueph7u5tyt0iHdRtUzE+KqftFg9G9ERbtjkCQZPG1qNLFLonPnmGfsymu4QXAdSDWXCfKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615073; c=relaxed/simple;
	bh=Zkfi1HVvrwSQhZHkNPnA77UHSfEJTPixXsCO8TP0Eus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mxZ6uCLIFLL3KENLl/RzkLgTdVcRJb06F75uBIESDsp9GQWNHN6my8/MgVD43Av4zE9FoxZCMYAfXAypzzztVIEFcrM96srCIZAi/gt0pYlLD/UPWPJn0fFzsW9RsP3x4p2ZVgTnlyPdNdf4ceBhbo4I71hRmoBlY0+ROcB0ozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cjzPXlNg; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cjzPXlNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=V1
	sLHMDzzOomdHPsx4yOfg/S51LMi0KB8zcg4r6QBE8=; b=cjzPXlNgjdUrDfwt8p
	G/H1/R4hyDfaevn8O4LgQZYoMshQZODBhPIdmpJhUtXIHwTb9UUiq34nB9Q4rxHr
	p+7Dm/VgXgFzbfnzxRzmEUigrM3zc0ch/FExK14hB+i4WORaSBbH3Eo//XZ5Uzu9
	lprewofHTgnp984KbAxbqLXjo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wA3cXBYGZxqS2BuAw--.57639S2;
	Sat, 05 Sep 2026 21:30:01 +0800 (CST)
From: "hpp.iscas" <hppiscas@163.com>
To: Jian Shen <shenjian15@huawei.com>
Cc: "hpp.iscas" <hppiscas@163.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Subject: [PATCH] net: hip04: use 16-bit byte order for HI13X1 TX fields
Date: Sat,  5 Sep 2026 21:29:58 +0800
Message-ID: <20260905132958.63085-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:_____wA3cXBYGZxqS2BuAw--.57639S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryDXFW7uFWxZw43XF4Utwb_yoW8CF13pa
	1DCFW3Kr1jvw15X3Wvgwn2q348ua1Sg34xGa15u34a9r1Syr409ryDKFWUCrWjqrs7XF4q
	934F9anxJFs3K37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBa0dUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7Rke5mqcGVlG+AAA3E

The HI13X1 transmit descriptor stores send_size and data_offset in u16=0D
fields, but hip04_mac_start_xmit() converts both values with=0D
cpu_to_be32() before assigning them. On little-endian systems the=0D
assignment truncates the converted value, leaving neither field with the=0D
intended 16-bit big-endian representation.=0D
=0D
Use cpu_to_be16() for the two HI13X1 fields. Keep the original 32-bit=0D
conversion for the other descriptor format.=0D
=0D
Fixes: d413779cdd93 ("net: hisilicon: Add an tx_desc to adapt HI13X1_GMAC")=
=0D
Signed-off-by: hpp.iscas <hppiscas@163.com>=0D
---=0D
 drivers/net/ethernet/hisilicon/hip04_eth.c | 5 +++--=0D
 1 file changed, 3 insertions(+), 2 deletions(-)=0D
=0D
diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ether=
net/hisilicon/hip04_eth.c=0D
index fc2c47d..2920985 100644=0D
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c=0D
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c=0D
@@ -527,13 +527,14 @@ hip04_mac_start_xmit(struct sk_buff *skb, struct net_=
device *ndev)=0D
 	priv->tx_skb[tx_head] =3D skb;=0D
 	priv->tx_phys[tx_head] =3D phys;=0D
 =0D
-	desc->send_size =3D (__force u32)cpu_to_be32(skb->len);=0D
 #if defined(CONFIG_HI13X1_GMAC)=0D
+	desc->send_size =3D (__force u16)cpu_to_be16(skb->len);=0D
 	desc->cfg =3D (__force u32)cpu_to_be32(TX_CLEAR_WB | TX_FINISH_CACHE_INV=
=0D
 		| TX_RELEASE_TO_PPE | priv->port << TX_POOL_SHIFT);=0D
-	desc->data_offset =3D (__force u32)cpu_to_be32(phys & SOC_CACHE_LINE_MASK=
);=0D
+	desc->data_offset =3D (__force u16)cpu_to_be16(phys & SOC_CACHE_LINE_MASK=
);=0D
 	desc->send_addr =3D  (__force u32)cpu_to_be32(phys & ~SOC_CACHE_LINE_MASK=
);=0D
 #else=0D
+	desc->send_size =3D (__force u32)cpu_to_be32(skb->len);=0D
 	desc->cfg =3D (__force u32)cpu_to_be32(TX_CLEAR_WB | TX_FINISH_CACHE_INV)=
;=0D
 	desc->send_addr =3D (__force u32)cpu_to_be32(phys);=0D
 #endif=0D

