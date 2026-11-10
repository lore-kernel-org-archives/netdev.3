Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294490;
	b=02Tsl0WtIFlynoV8hhgsO69J/5VkclI7PF97WmT+cUBUoBlJM5KZsbgVwE/6HXj8gk55
	 KTCSEenR7rxKqius5uFzhgnzQUmJdSTnYlIzKVCcn1Cg5hJ3/K6EGyjKW09fSAU+JsFUj
	 606GowBsgCl5pawZ8nLklfyARc4h+Oqs+7EAPgWh5FbwaPoo2yFRXprvx7UCFU2Q7/k1n
	 BFN/Fgym5dT1jDvp+/79EpmAtIBo13GUHHt+EKijNsCZcM6yYQAbu1eqTx8b0hb1EJ28l
	 s7wn6oL6sh1RPVKSlhOjB1ijiNNtaLfffENW7I78tYAhcFTjrVjkSQeNvTcPoIX5j6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294490;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fgSrZKADbXl/YSiOGT5BVNgsU86IzRBSHrswgiXFdHs=;
	b=pMmEvwurNyS14/m+jxsGe//pNiiSF7SyyVBUKHmksZXWHoNjqoeSAGcDZY6ZkVxCrGo1
	 Ltm/uH+dKTDWVTOmkHL4LbhpM55/VGfoLeZiy6cRTJZFDBjm1Kam2IGBsI5Yi4djsxhm6
	 upF+HoLyARep5Y+WuSD9hLDno2i1bFyfexuNIv3OnlwM1Vcs19ZsyPAC2xxUKLW6Tmbmv
	 ZDgUCTk8Q6SUXpsFckVy6mzJtiMy2BcFZh/YqyA/AAXErUajCKVVcluN/e7FaH/rZENjc
	 zNCmhrnnwf8b9N66uT8SussMQASrVgpHgdrEM9DAL4kZS0A0paW3p7nzNp39/4c2nhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=thdjrUIF;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBC9606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CBC9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=thdjrUIF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=thdjrUIFu2AVCoAPuIQCJMYAi/LMAuHfm5VUuyznkWfeFlxhZF8alkWGGt67gL83kBxYLUk23N+7e
	 WdbTp8JlymGB0YFuRohaYpEHQGRCav3MOgZG5nZlnExQwOW0fInLKJr37aaKZVt4dU/hOnFHk8YnRV
	 c2GQRNdNMR1EQS6o=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af2c2d7254-ccae7;
	Tue, 10 Nov 2026 15:08:07 +0800 (CST)
X-RM-TRANSID:2ee76af2c2d7254-ccae7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af2c2d35b4-ab42a;
	Tue, 10 Nov 2026 15:08:07 +0800 (CST)
X-RM-TRANSID:2ee16af2c2d35b4-ab42a
From: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linusw@kernel.org>,
	Imre Kaloz <kaloz@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 1/2] net: ethernet: ixp4xx: fix OF node leaks in ixp4xx_of_get_platdata()
Date: Tue, 10 Nov 2026 15:08:01 +0800
Message-ID: <20261110070803.1099-2-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261110070803.1099-1-zhaofeng2@cmss.chinamobile.com>
References: <20261110070803.1099-1-zhaofeng2@cmss.chinamobile.com>
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

From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

ixp4xx_of_get_platdata() resolves the NPE and the RX/TX-ready queue
phandles with of_parse_phandle_with_fixed_args(), which takes a
reference on the resolved device node, but the references are never
dropped, so the NPE and queue manager device nodes are leaked on every
probe.  Since the DT parsing happens before the -EPROBE_DEFER check
for the MDIO bus instance, the leak also repeats on every probe
deferral.

Drop the references with of_node_put() once the phandle argument has
been consumed.

Fixes: 95aafe911db6 ("net: ethernet: ixp4xx: Support device tree probing")
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -1397,6 +1397,7 @@
 	}
 	/* NPE ID 0x00, 0x10, 0x20... */
 	plat->npe = (npe_spec.args[0] << 4);
+	of_node_put(npe_spec.np);
 
 	/* Check if this device has an MDIO bus */
 	mdio_np = of_get_child_by_name(np, "mdio");
@@ -1414,6 +1415,7 @@
 		return NULL;
 	}
 	plat->rxq = queue_spec.args[0];
+	of_node_put(queue_spec.np);
 
 	/* Get the txready queue as resource from queue manager */
 	ret = of_parse_phandle_with_fixed_args(np, "queue-txready", 1, 0,
@@ -1423,6 +1425,7 @@
 		return NULL;
 	}
 	plat->txreadyq = queue_spec.args[0];
+	of_node_put(queue_spec.np);
 
 	ret = of_get_mac_address(np, mac);
 	if (!ret) {


