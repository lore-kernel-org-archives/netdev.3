Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3730E1CFA2;
	Sun, 20 Sep 2026 03:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789876065; cv=none; b=MdmJL84phbMJV7YxN2gVXpnJhmWVh/W5ZP4pmGQjXopuPo9Mwsub9UuAzIPIsbsNwGaynke3j68c8HZvoLNhfQlPUwKIzKf9f2j26aQwBH+FQW6VMjiRMFlgwsNCXJ9KZAWY0h+6VgUKjisrR1MaI/JGdETCeKQSj8jbf078RCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789876065; c=relaxed/simple;
	bh=uL0o1MAS5yI9Uxm5OzrAh4kcBGy3cTjh5LAhGkuIxz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l8Q8CIkxazAdUnTBbLtFTNlD2Wnw44/d5Vie0Nuzepc0nJD18isfvRO9oV2b2MJmPSFMEwgLZVlM4mmo8K3QzQug8fSgaOgPrq4gHqx3Hk9Ei9sDU9qXureluxSTn8XWasvL+Zidr79kbRyGp2TEe4wh0ED4bkbDA2wr2raAoaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gvcdU7a5; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gvcdU7a5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Rp
	wXAbsraDMpwD5cGtJqrLnyJJbi4N0lKABEJwZ+UYo=; b=gvcdU7a5uuMuXvoJo3
	Jl5hpMBP6Ik+iUoPIX4U2PnAAakAkGoT2sv+d4V5OueaDR7I1I3A2bXAazm+NveG
	ikCA3eLStBtSCJpopVQogzyTylyQXJ26zuTKjGcnAyh7TG1fFfFo4VxwwXeD0UpS
	xRvV+N8i/Nz0ZqfRjVAc6Txtw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wB3UtItV69qxlxaBw--.58956S2;
	Sun, 20 Sep 2026 11:46:54 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: linosanfilippo@gmx.de
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	richardcochran@gmail.com,
	hppiscas@163.com
Subject: [PATCH net v2] net: alacritech: publish the PCI module aliases
Date: Sun, 20 Sep 2026 11:46:51 +0800
Message-ID: <20260920034651.18109-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3UtItV69qxlxaBw--.58956S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFW3GFW5CryfXw4kAw1kXwb_yoW8XF13pa
	nruayxu3s2qr15J3Wjka1rXF98ua9xA34agF9rKw4Fqw1q9r1UKr1xtF45u3WDJrWkGrnF
	yFnIvasxCa98J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRY0PhUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7g5nMGqvVy60qAAA3X

The SLIC driver has a PCI ID table connected to its pci_driver, but does
not export it. Its module therefore lacks the PCI aliases used to
automatically load it for the supported Alacritech adapters.

Export the existing PCI table without changing device matching.

The issue was found by our static-analysis tool.

Fixes: 60c140df15db ("net: ethernet: slicoss: add slicoss gigabit ethernet driver")
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1:
https://lore.kernel.org/all/20260704152053.49780-1-pengpeng@iscas.ac.cn/
Rewrite the source-analysis explanation as requested by Jakub; retain
the one-line change reviewed by Simon and Lino.

 drivers/net/ethernet/alacritech/slicoss.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/alacritech/slicoss.c b/drivers/net/ethernet/alacritech/slicoss.c
index c1949ca060ca..14b74c09233e 100644
--- a/drivers/net/ethernet/alacritech/slicoss.c
+++ b/drivers/net/ethernet/alacritech/slicoss.c
@@ -34,6 +34,7 @@ static const struct pci_device_id slic_id_tbl[] = {
 		     PCI_DEVICE_ID_ALACRITECH_OASIS) },
 	{ 0 }
 };
+MODULE_DEVICE_TABLE(pci, slic_id_tbl);
 
 static const char slic_stats_strings[][ETH_GSTRING_LEN] = {
 	"rx_packets",

base-commit: 518e5b794c06c0f0eb40df3e202274a66202c137
-- 
2.50.1 (Apple Git-155)

