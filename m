Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D352BE644;
	Sun, 26 Jul 2026 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047772; cv=none; b=Q123t40PmaY85Dn0qbY3ruVI++vxVjsP+2ZdheCz+jlcJC6P4kt8iHSiVV7gdPixX4rmU/7EjqM54xBsEfNrcHnKob2tbajgkHYtheL6HGgQu1H1cLkuO+qjvxw6NHcmRk+HB1WXKkp0ZV/v9jXVXpK7Ctwh3AkgKskjd0Z7IXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047772; c=relaxed/simple;
	bh=po3NZ+pyoJWnj1F4A/zg8K5DEsPxGVen2PxEXiXJjKw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=czQmRXeXLmkjv+1+xZfNA+lQzO1Rj2M1Cnp97ErPSqXOQD2BVgShd7j1XD9i6yR15QZkolqQCU9Rkyb8iNKPv1hsAepDB6w2mPt2nfocJ+M5BlO1JnQ2fu2GP9BVB3LSMPJgK5uBWVJi3djQdV0OyDSqUyKB4W07UXPIT6ge58I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rfkMLGBC; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rfkMLGBC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785047766; bh=Ppd48yLKIMOMMe4QmlAQChOUsGjWPf14AyyTfnz2QxM=;
	h=From:To:Cc:Subject:Date;
	b=rfkMLGBC8wL6WO5IY2LLESojVuDKS7SJQyvQRoKLq2jFp7vhpMSzVkV8dx/gJqqF1
	 lZHBx0NiQNnCb9kT3S5rdhymh8N3y8IJIGtOLv9ZAR5Ar79MwcvtGXkI7DXdSA0/DJ
	 gNZzBGTcyf8FBMh6Om0rE+CBkXTF1DHSSzLM6qvg=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 8FB1747F; Sun, 26 Jul 2026 14:35:59 +0800
X-QQ-mid: xmsmtpt1785047759tjsaxq64b
Message-ID: <tencent_3C891D50F517A212AE7EAA88051244B7C005@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9Xer/mzKLex9FSQqpT25E2r5PnBuTvRrj4zFPehYbxmse6tIqdMT
	 73nGLtV4ThhasG1ZbGTVUpeXsFKKGUpiIgkrC5bEyIckl4FgLkmy52noIRMObIZUz17WOmIla4/k
	 dYJZXYB5s2zIFnvwnXEpGpMDubuaNtM9BuMp+Ga6Lc00Xw4h9tZWgCsof6u7zXmdqLZ+qyx2315v
	 5PLczrriMYAx8OvQRzhYKfn/XPDXosnFff5l5oQcc6etUHOXoOpuKMuVJoy3TNElsgrC7JlKiav/
	 okzuNK/edz4kRguWRXxbU83IBI2ASxmoYdxUjivLolFemY7+5EtYEZRHoH2dKoJqjyE5JQ+B/+VU
	 ubtVRa5/7tYFHEtaCWKVFmxWiFVhwAfoj1NNMHd6elZV9GzuDDF9oxzNXjoO5JRkjEChGG64Jt34
	 njJNsF3cUZznha3GE7b/5+W2CyhBvmkVPDnF4jMDtgF8tZYEbPYu5LWjT8wtaOOzZgR/cGfeQ1vS
	 OFhx0ebPVoFf/MV5F4hE1r6SM3LjUqYM+PiDI1bXOtPea5odfTgnDfXMouT6t8AyVOaJoi51lzMn
	 HsfAsovm9P+pjdWFhCaWHx7PXAMTIV4Iypk716VCsr6t4T3Xhqyd11gIIZVoSD/3UPihU6hqH9vm
	 2uqdbM1fdOJGBqsZ04y7b4fk4ZllGaexUErNWO6w3H8IKAcMUA8MHABJD2MWlV/WEmPCosxvjjGN
	 IRNx0Be6bhZNlMtP+MxzikUJBqm9zQlLZjkQgSuabTlFQC3t/ZIDTxgVsibQHgD8VvTH6Pk9ApIg
	 0XanxKNYvuhI5YxhN83PnwWp9l1FG2UmX/WU8gOfe7I+KzHqPtqLOn4Ww8i7LNyvZJNGaaX8stG4
	 jQSSiQJn2WmP3sQprdUIDcyRae2HWLIgkH0M5bgatSV46v97Kn0mcfuTs0HV9XoHyp+UAioU5cf7
	 KVNk0a4hFZZkBtTv0BQUoj+L+SAa7ZSTNXpuY8l+io/WZZDOY6oFhRpvFsFcTceyPKhlqQbElTut
	 j33oMAr4HcTi96U9uG+IfMCRXcYBLBh2vAyLrRCFFuMXU47HOfwuFBsJzx7pYOAhEgBTXAXw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Jiawen Liu <1298662399@qq.com>
To: Jian Shen <shenjian15@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH] net: hisilicon: hix5hd2_gmac: fix NAPI teardown order
Date: Sun, 26 Jul 2026 10:35:55 +0400
X-OQ-MSGID: <20260726063555.1434868-1-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hix5hd2_dev_remove() deletes the NAPI instance before unregistering the
netdev.

The netdev should be unregistered first so the networking core can stop the
device while its NAPI instance is still present.  Delete the NAPI instance
after unregister_netdev() has completed, matching the usual teardown order
for drivers that call netif_napi_add() during probe.

Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index e3e7f2270560..81d398918b1d 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -1282,8 +1282,8 @@ static void hix5hd2_dev_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct hix5hd2_priv *priv = netdev_priv(ndev);
 
-	netif_napi_del(&priv->napi);
 	unregister_netdev(ndev);
+	netif_napi_del(&priv->napi);
 	mdiobus_unregister(priv->bus);
 	mdiobus_free(priv->bus);
 
-- 
2.34.1

