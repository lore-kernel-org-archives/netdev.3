Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911F03264C4;
	Fri, 16 Oct 2026 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154993; cv=none; b=ofLoKJ7+XBw2MpOsqznl64bDwATQnKO1XY5jBK9w2U5q1GaDIC6XJUhdubySOydvcs3gbokU7Krpgl2AbFrbpu4rjDqeGvpFztCILXFhFjgOB4Zwqk1Qmgph3j0exllAWGYQ2+oCsF3SEQKakO/KQS3/4hFiGRnNG861GRT1c6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154993; c=relaxed/simple;
	bh=rod6xy9+gndHUdnbr4wgG656s1uGxUW7SPIP+EVNlHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c7vxrfEfzOfcp9yAaPqsNJhazJO+xWOxNl4qsr2gd7gc3Zton2d+KL5ES612WXrjaYT/tmNz2ZRh5o2d19k2+9/3XFzIU1Q4iFY6SmPn0huhRDrNGzJMkRchQSje+uW8iNBb2qCpUk9gdIO6MDwJOHCfQ4D7vVt/GxdxY+mC3xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com; spf=pass smtp.mailfrom=ugreen.com; dkim=pass (1024-bit key) header.d=ugreen.com header.i=@ugreen.com header.b=l4gXVKAM; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ugreen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ugreen.com header.i=@ugreen.com header.b="l4gXVKAM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
	s=pkvm2402; t=1792154950;
	bh=PTGNf+pFA4HlvSUNJLATMTS2BdbiXazN6lRObVyVPC0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=l4gXVKAMC3yETwkqcs1lFqJ8Qc0sAwQA76Y0SGeybbnWHA1it7xcHbXgla3dwVn6t
	 3+xSLhgLMVHG9bTTzOezXXlCuMlQ/1r4fOISDmMggcza/XbpEsGv8Kqf08yjqS381g
	 DsZ9PHj73mXQj8nbx2iZtcJUG1p3zgPHrmK/jkfI=
X-QQ-mid: zesmtpgz8t1792154945t80257fa0
X-QQ-Originating-IP: fxmolzZxMAKzmLOLloioZrYju46a8tj5RAF29sd94ss=
Received: from exmail.qq.com ( [14.153.252.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 Oct 2026 20:49:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5218228176751609531
EX-QQ-RecipientCnt: 6
From: Hanson Wang <hanson.wang@ugreen.com>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	oneukum@suse.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	hanson.wang@ugreen.com
Subject: [PATCH net v2] net: usb: aqc111: fix set_mac_address return value
Date: Fri, 16 Oct 2026 20:48:58 +0800
Message-Id: <20261016124858.1939743-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703073936.462231-1-hanson.wang@ugreen.com>
References: <20260703073936.462231-1-hanson.wang@ugreen.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NLIGCJzX3Qmez+MNMKksA/1yHF4RoeseEmx7qU8echuQlHQNG9HELPSI
	/CRwPoWzNFTkW+WcAboyncIJ9/N36iMcUxBlpn6yinfVDhskB9rWMPIIy9iEQQzSc8tMgh1
	mLnhFSfpCmQoJuDRk2rCNzOjyH/NODcnYKRVnCI1vdu5uSopbQYgy/vIlroEe1p9PwavUjD
	4EqzAFb9KIVCYQSyrNRBAfMsBNwyu+nTh7cdYRNbLX8hyT+l8TjTDEsXpmEUtNvA/LyYDWF
	kHvJSs7vgKgH4ID5WtzmL918Lm/7feltwwHwsTMQGcae/rq4CynArcnOl59YrYxBhifg/kn
	C+L9uAhlt951Tl0dUKk7MQU/2fWZAquRE1B0qwYE17z2OORN3HjuH7AqDvjxpPpEVABgJSn
	cs3nfbunp7ZrhMgu3kVHuVo/mWhsbZ5fcCJD7/0QHBj263PsTslQAfFu++9MdMe2TB1hH/7
	Lv0Jq2WVJ19Cns6JrhWeXYgLMmlSE7U2YOHb47tog750uJigas4/6sqlq/NA/Bp5pwmCxTq
	T8CIEUi0VlNNrKZjxVRO0aoQqVMzBQ1gzWvy4onIh9C47fhY/TSPZID4N1FucIVX9ukkawJ
	LWKLyvCgym4Fxxj+PGG1JwXKSuyu8zxAxU2z+st+vcv2Dx2NyLd735Q0kUGVUS+u5kdgyMy
	q3jjphsM2jE64esCjieeM8uCw0jVJn1q5+i3sLH8Ba8tIxTfW4+mV6Lwz5q+8HZF2a8b4F7
	5c6ue+F3EN7R+/UfcAorX5D0b7vUC1LHfFp1XZYQtEUL0Pcp2po/8IJgdXf+gWdbbi98OfS
	x6VvRYWm4F4JeDQ3FvcA4hsnBvGzIDtqVNdARSSjWOf/XOMCf//3ZjfHyEr8mG3kS3/hCXy
	Y8zBwcHPWQiT6GfS2EnFy4FbGm5ewnjOdEjaK26RrbCNC/KEiPbQF89pcXCzCQwqLdFG9bl
	XbXTwoqgbjkPSqIaKCA+p22CMlQsmPNZYwDYrDJjOUoHc/kBZbLUrqLMuvK+sXf3iMqooaA
	Hy2to5bA952ttl1Kn9VUx/j/eUKnBhVonxCi8yfdzZsBcTy58sByxu311xAcXi6+bUUU+Pa
	N8bryIKg+CRXFqydthrA7x7yDpyVQv3Wm+RGC7cm5hvpeHyySZMYF4=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

aqc111_set_mac_addr() returns the result of aqc111_write_cmd() on
success. That function wraps usb_control_msg(), which returns the
number of bytes transferred (6 for ETH_ALEN) rather than zero.

Callers such as netif_set_mac_address() and bonding treat any
non-zero return value as failure when setting the MAC address.

Return 0 on success and propagate negative error codes on failure.

Link: https://lore.kernel.org/netdev/20260703073936.462231-1-hanson.wang@ugreen.com

Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>
---
 drivers/net/usb/aqc111.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index 9201ee10a..827aab540 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -476,8 +476,12 @@ static int aqc111_set_mac_addr(struct net_device *net, void *p)
 		return ret;
 
 	/* Set the MAC address */
-	return aqc111_write_cmd(dev, AQ_ACCESS_MAC, SFR_NODE_ID, ETH_ALEN,
-				ETH_ALEN, net->dev_addr);
+	ret = aqc111_write_cmd(dev, AQ_ACCESS_MAC, SFR_NODE_ID,
+			       ETH_ALEN, ETH_ALEN, net->dev_addr);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int aqc111_vlan_rx_kill_vid(struct net_device *net,
-- 
2.34.1

