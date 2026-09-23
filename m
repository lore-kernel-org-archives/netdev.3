Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A3F23A562
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790132245; cv=none; b=EzgylP7V/Y/RG+GdHlJf7o6/GWrfPBDTHI48XOmhUTck7uh3SPMirlFOtYPxL9Pa5ZdmlENq2L1dasTmoda7Muq4jmpyBLG0d3vB0GdRZB8CUJ2v9pfDsSWXo9QyqLHioQwf0DPeg6gb1sUktVV6FxU3eNtN/+cIbtFL+XxNVE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790132245; c=relaxed/simple;
	bh=epxqIeI5sZ+sUyxhxZF9F/tBsaF50w8TcZg/mK1ow+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mRJCBKCLon8T6hUcmMUlZECbOmn8VBlnXjverCH6Y1YruKy42EoVvt8xFj2gSIBThh24bZ3ogovxMGtXjh410FppPk6rbdNjn4PTGzAmUzWt0WeR5f6VrYz2t8KMo18squ5HQFpP/SDZkm8rRdtIACKknnVxx/5315UQsSAxL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V+EOTlaM; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V+EOTlaM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZB
	jAOHcKoMeUkcmxSATR8HCoEIDOi5eaks/cwRRFp2U=; b=V+EOTlaMNslyURafeQ
	kU21zmcGm2syXK72L5yjm04KV1ntKReFYNNbgxL+Nd2QSP7cldORI6qfrqr54DXr
	S57Ei6PMtZ3V9124/DVu8YF1dfqYLDA6RWDoutui63lE/3Jtb8vFJ0SRseEbvRoR
	Ul4exMZOiafJDrDu05681DbbQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnj533P7NqgkvrAA--.82S2;
	Wed, 23 Sep 2026 10:56:56 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v1] tun: fix inverted error check when re-attaching the filter
Date: Wed, 23 Sep 2026 10:56:53 +0800
Message-Id: <20260923025653.59348-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj533P7NqgkvrAA--.82S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw43Cw1ftFWruw13JrWxXrb_yoWDGFg_Wr
	ySqws5Jryvqrn0yay29rsIvFy5KF1v9FyrXr1jqryfX3yrurn0grykCr4Sq3ZxGrW2kr9x
	Arn3XFy7Jw1I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8aNt7UUUUU==
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4RiVAWqzP-gCFgAA3n

From: Rongguang Wei <weirongguang@kylinos.cn>

tun_attach() return when sk_attach_filter() succeeds instead of when it
fails, so the queue is never published in tun->tfiles[] while TUNSETIFF
still reports success.

Invert the check; nothing is published at that point, so the attach can be
aborted cleanly.

Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/net/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5a302709a68a..09720883b9a1 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -754,7 +754,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 		lock_sock(tfile->socket.sk);
 		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
 		release_sock(tfile->socket.sk);
-		if (!err)
+		if (err)
 			goto out;
 	}
 
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

