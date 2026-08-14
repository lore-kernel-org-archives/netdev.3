Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7336308E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689757; cv=none; b=Azla3yWH4frqMFIg68BhphH2wEffDseKLnFxzXHXurcV0c6Aeu1KZi3YLjdaOOoBjjhxwClKk3hhaotoq2sTm6kzP4WMQSWCnClZT63FFKMIqG/WzyXDjN7Pn10xCEFPfeieCAokgv1fEfwrL6PwGbKcolRkYGGXgf8aVpoqqwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689757; c=relaxed/simple;
	bh=ORhhQ9n/sav7gjBxoMp6d9oqxDDNFHBWcaAYyE2pe0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUoYy5wKfpVsUBNd0S9MKiZgN9uHrg3k/Rx2ZeL34IE23CAJYdMDZ8wQW1PEO9P4Q6TJfFhpVb9LcJX/xSqdJL/VJpkDcWZVZ5Mn6pD5Vg/huyXH6mG5gbOX4IhjkIi/tL20zGJB3Ldz2oHZF78X8p14Hk6+HyVxHy2VpJfONvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=GeNGHsOy; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="GeNGHsOy"
Received: from mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:f25:0:640:1f20:0])
	by forward103b.mail.yandex.net (postfix) with ESMTPS id 8D1F8C00AE;
	Fri, 14 Aug 2026 09:42:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (smtp) with ESMTPSA id UgKwCtUgIqM0-79WUZrFV;
	Fri, 14 Aug 2026 09:42:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1786689751; bh=bKsAZKs09uVQkYWKTikTEkkI/pO2NSRM2EVzEHdCPLA=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=GeNGHsOyQAXmQkMRf/uFN20Y6D6ZcDlidPBSUpa0bYfnqve1zltPK6XfBp1cNnh9R
	 6+1Dh29MNupUqnOIEyZxQ81PlsfrNJU01C/UAvVcjWw/lWaXuwkQsMznCwAuW9KTno
	 qfcLJ91qnlqekx+Ljl6fbRAYE47WS1bQ0Li2LZ9w=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] cxgb4: use kstrtou16_from_user() in tp_la_write()
Date: Fri, 14 Aug 2026 09:41:27 +0300
Message-ID: <20260814064127.1957130-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since actual value used for 'la_mask' can't exceed 0xffff, it
doesn't make sense to parse larger values as 'unsigned long'.
So switch to 'u16' to store an expected value and use the
convenient 'kstrtou16_from_user()' to simplify 'tp_la_write()'

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
index f521737d1275..5c6c27418891 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
@@ -664,20 +664,13 @@ static ssize_t tp_la_write(struct file *file, const char __user *buf,
 			   size_t count, loff_t *pos)
 {
 	int err;
-	char s[32];
-	unsigned long val;
-	size_t size = min(sizeof(s) - 1, count);
+	u16 val;
 	struct adapter *adap = file_inode(file)->i_private;
 
-	if (copy_from_user(s, buf, size))
-		return -EFAULT;
-	s[size] = '\0';
-	err = kstrtoul(s, 0, &val);
+	err = kstrtou16_from_user(buf, count, 0, &val);
 	if (err)
 		return err;
-	if (val > 0xffff)
-		return -EINVAL;
-	adap->params.tp.la_mask = val << 16;
+	adap->params.tp.la_mask = (unsigned int)val << 16;
 	t4_set_reg_field(adap, TP_DBG_LA_CONFIG_A, 0xffff0000U,
 			 adap->params.tp.la_mask);
 	return count;
-- 
2.55.0

