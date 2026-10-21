Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574198;
	b=aQZ7/AVyyK6zW0XwBdaskQul+7cqIua8ddIMETrpZJ3wmgrjbjKQf08Sd1UxA6W85J5a
	 gD9zNjgnF7HCgxqS3HHadc5e+CnKbB37ri6vHh2WIv8rgZ7cw/JLQxRovX1UvzszdurG9
	 Dy5bR3kJTVrZvmvwfXdGZDBDWZJ6KcnT+9u/LNFay1TB34FJyp1r9RgbBy3zY5Mn7vGHV
	 3a0czrchdKkmSZUbhsiybrZ55UPHpBbWtBfnzfbJWElmR9bMRE2DR2Yu6+U9SFY8zOD2/
	 +KwTPVtabQ+vYeSF+fKdAbkxxVITU+Yq9JlPIoqvOo3JeuwpNVPgcDSjqYW+pkpadyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574198;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=bdizISaQv6T5r21RCqLPVh0le8FTYlcQqO+PwGInY+k=;
	b=rD7QF4ZKVjFENI61L5RRBLGwZUaKYV6tWN84zghp7bEdlE4zt7S2yFqizFBy5AXgeVla
	 I03RUyPEsutJDEmjvfwiKJlOM8EaZSMWR3NYi8lk6qwmc9soshu4Wfdxy3kyd67NyJG9d
	 dkSQMSyOIhPU1e/BYd1fqmTX77x/3qvOTFGYFzER2Kaxvh33rO+jIkEuQ+sP7P9w/Nexi
	 G3CXPRyLw3HFP1HuqMmmfSj6XxZMKKrhfYbUXWeHMxGXpaovSjY9GaqtYe0u8H8M3o4n7
	 wdWFEZzwPQnzUkIEkst6UTAdmyLGLKq4pIHPa6YXKQGp05I+S7/KcZNaThX+bzo2jrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=fibocom.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="XS7jth/j";
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E7606A31E;
	Wed, 21 Oct 2026 09:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D2E7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XS7jth/j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bd
	izISaQv6T5r21RCqLPVh0le8FTYlcQqO+PwGInY+k=; b=XS7jth/jOvSyGTktch
	9fkhXBYLKqqIjwyfs8+j3gpQQFO7TepLTLBjsVMIG8nexwPR9nPMqS1FCVH5kmST
	E2koV4DvAuYtn+bxNoFV5cN5KkXFIQYm7/GdB3P6XjRKxc11WgbRjb3CrAfaIzPA
	v5MeVs3+HBD0sEfCuuz4PCnE8=
Received: from GHT-5854251031.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnr9PGgthqi5y2BQ--.62596S4;
	Wed, 21 Oct 2026 17:16:02 +0800 (CST)
From: Wanquan Zhong <wanquan.zhong@fibocom.com>
To: mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Wanquan Zhong <wanquan.zhong@fibocom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v6 2/2] net: wwan: mhi_wwan_ctrl: add ADB channel support
Date: Wed, 21 Oct 2026 17:15:48 +0800
Message-ID: <6228f811c21e0d2e0b4dbd8621488d86236299be.1792573876.git.zwq2226404116@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792573876.git.zwq2226404116@163.com>
References: <cover.1792573876.git.zwq2226404116@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr9PGgthqi5y2BQ--.62596S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw1Uur4UXw15CF47Jr18Krg_yoWfKFbEg3
	4DXFZrJrW7Ja4jkr42gF43ZrWft3W0qF1kXF93trZYvry7XFWUWa1vvFs5t3s0yF17uF97
	Wr9xWa4Fyw1fGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8aZX7UUUUU==
Sender: zwq2226404116@163.com
X-CM-SenderInfo: h2ztjjaswuikqrrwqiywtou0bp/xtbC0hKl-GrYgtLgcwAA3o

Bind the MHI "ADB" channel to WWAN_PORT_ADB so userspace can access the
ADB port through the wwan subsystem.

Signed-off-by: Wanquan Zhong <wanquan.zhong@fibocom.com>
---
This ADB wwan_ctrl change was bundled with the device patch in v1/v2.
Split it out as requested.

 drivers/net/wwan/mhi_wwan_ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index a31d8540fbb8..50a3a940357b 100644
--- a/drivers/net/wwan/mhi_wwan_ctrl.c
+++ b/drivers/net/wwan/mhi_wwan_ctrl.c
@@ -263,6 +263,7 @@ static const struct mhi_device_id mhi_wwan_ctrl_match_table[] = {
 	{ .chan = "DIAG", .driver_data = WWAN_PORT_QCDM },
 	{ .chan = "FIREHOSE", .driver_data = WWAN_PORT_FIREHOSE },
 	{ .chan = "NMEA", .driver_data = WWAN_PORT_NMEA },
+	{ .chan = "ADB", .driver_data = WWAN_PORT_ADB },
 	{},
 };
 MODULE_DEVICE_TABLE(mhi, mhi_wwan_ctrl_match_table);
-- 
2.53.0

