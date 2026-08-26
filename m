Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC13A63F2
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787726980; cv=none; b=Nk4sWlBZyBvQQyIU0L7Maq4mBZq44UpBB1g0Edq97a32osVVkBn8o9wlWTDAFuGfjsxp0b12bLnUjjHAzia5x4TCZHO82fRr+IZfRijyIev3F74bb12ZvVBSt1XESWdmXKRktTxxtYpn1/vZHiAA0XJHnicJxtxetUUJJ0JbxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787726980; c=relaxed/simple;
	bh=+s1q81uGzAC3EM5nOyVnAY7Asm3SuhxVuST/IBvgRZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4gaova7WXC9njZPeOlkEMi7K1IVh56WxUHeUnZvgZXDFrt40yFkzUHPor11tJj3WAQiRs2uPwjo70wbKifHiwXMOSufuM55t+LF3zQwBB+t4PYiUIFn+f5egE9qlmnArhwYG5kfGwe5uGTCnlbW0czVCx9SP/aHDwV6IIAjNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKVK5lSI; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKVK5lSI"
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-39662b5cde7so489064a91.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 23:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787726976; x=1788331776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S6+gZISuTotipjsrEyz9Cx/NTi3M8+6APWRf94zGuNA=;
        b=gKVK5lSIdesLrAP/4gXgIfkMNSC8GuC3igLWZoXRkqVilex6EG8vZAVPJTzQNzuXzy
         PA7TyS3JCb98ke6hARjLmmkE7OcjCfJFXRFNS5gIDOGJvkgWNKwDzhCeq0gm2hPRF6H8
         qlZhF6ClpMuloSYO/HPPFxMQN8o5auYNCl1sxwaL2D0xsHVyiq3GqoAkg4v3mZYWoTsQ
         WD/C0AtEvS18DO46OZtk9nXyhCt3sbJHX2ZkLx7RVEu0tYkHTR4NHtCftVrbcWQuzOrd
         cacvBv4aVkUMafaom/oNUq24i7uJmgs6COdhF9AzDocDG4WctJc0gZSoeXXRtjzzGnDz
         SRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787726976; x=1788331776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S6+gZISuTotipjsrEyz9Cx/NTi3M8+6APWRf94zGuNA=;
        b=b3g6mKG2PHdaN8aGvSG4o5ispH/y/Yn0Od0SPgbhU4Hcvokj8e+04iXS8X56lW//TH
         9Z3D+w4cLIclP1O/lRcN85YF5SOcpVXLxI5gYDl7XQivQT8J6oXQYYXheq9dvh70MNGx
         UCJIyAHZmiucRqAxdrhy42wBecAKOdlxuM6UzuwDHMSt6/H7kuZga1AXiqnV1PHdGsIk
         dyVwdmbR2m9quJShxBqRiZ6vQc1YPs32UrCBQRbcjzCI4ifDwVa/ncXXIOOHUbkgUmKL
         JiwAO9/2DIKKmIs/8SWMPsvjFwZClFU+IOnip++znO/Z+AJ2oiZUKVE8gDOgjnWwKKNr
         +lJA==
X-Forwarded-Encrypted: i=1; AHgh+RoH5DnhxQwpxvoIpWvG2eGcVCLy9yGXzDS6GH1UWQNvxlm4DHnsBbnSsI7PfLFnNQzBeqcNV5M=@vger.kernel.org
X-Gm-Message-State: AFuF++nxVqmlAV+DF+JfLWmB7KiCiE7ARi70cfYPPC83DBffjwF3HGi7
	e0RvhNInm9XclbcnY94WVOauqYTWxSfVjd75w3RpD4VzhJ8lxf1Zg3n8
X-Gm-Gg: AR+sD121gfmXQWwVGv7QMbEaPe7zdqyRRxYgVz/yMGPfCswNtNNBpo2SbnutQVd/C8g
	YERyH5dUrL7a3aeOtBs20zG4TO+jUSgTnK7InUbPXF3682jrSt9pAp4ffOgIRm22d4Z/vxDzzNP
	Ctoajg1+a+9IWgI+QnYwDxFXmsCtt/Z3nF3P0ZhCIcV7zh8ZkJmuaeCTZ5JYqECeOIM2/AlywjJ
	2E7Z/OdpWcEdvQ1A14KH/KFIPnRY/kf/Ri3VYHAIt18JQgc7nZVQn2im3Af36Td69Sh0XMbqFpo
	jZxejnKBcagWjBzhszjffa6scsWXCeSx/NgL+Ch97in9tD0X/qkz9x3Fjk7ydYvBTfxz1BEo4HE
	evy7nrs3pdXAUcmMiSy7erwbtYO1qiwx65I4CLGmqXln+diL/CT50WmbZ5EsyFssXp/PJRDtxBa
	n96v6dQIdTwBvAa4JmI6+I+0+4iQVAOyS7IInB4F2pCzHaSg9ggHriwwdjZ7bO1VnhDNmlwCRFe
	M6PToAiz9bX21VOz9a2c0x84Q==
X-Received: by 2002:a17:90b:35c6:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-3966d3bd49bmr9980179a91.4.1787726975810;
        Tue, 25 Aug 2026 23:49:35 -0700 (PDT)
Received: from localhost.localdomain ([38.60.126.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283da25c8asm6151397eec.30.2026.08.25.23.49.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 23:49:35 -0700 (PDT)
From: hoobnn <853555@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Cc: linux_oss@crudebyte.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sripathik@in.ibm.com,
	aneesh.kumar@linux.vnet.ibm.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hoobnn <853555@gmail.com>
Subject: [PATCH] 9p: dynamically allocate directory entry names
Date: Wed, 26 Aug 2026 14:48:19 +0800
Message-ID: <20260826064819.52523-1-853555@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

p9dirent_read() copies names into a fixed 256-byte buffer. A name that is
valid on the host filesystem but longer than that buffer makes strscpy()
fail and aborts getdents64(), hiding the remaining directory entries.

Keep ownership of the protocol-allocated string in p9_dirent and free it
after dir_emit() consumes the name.

Fixes: 7751bdb3a095 ("9p: readdir implementation for 9p2000.L")
Closes: https://github.com/microsoft/WSL/issues/41192
Assisted-by: Codex:gpt-5
Signed-off-by: hoobnn <853555@gmail.com>
---
 fs/9p/vfs_dir.c         |  6 +++++-
 include/net/9p/client.h |  2 +-
 net/9p/protocol.c       | 12 ++----------
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076..af00b79d801e 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -185,8 +185,12 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 			if (!dir_emit(ctx, curdirent.d_name,
 				      strlen(curdirent.d_name),
 				      QID2INO(&curdirent.qid),
-				      curdirent.d_type))
+				      curdirent.d_type)) {
+				kfree(curdirent.d_name);
 				return 0;
+			}
+
+			kfree(curdirent.d_name);
 
 			ctx->pos = curdirent.d_off;
 			rdir->head += err;
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 838a94218b59..9f3079c6f386 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -268,7 +268,7 @@ struct p9_dirent {
 	struct p9_qid qid;
 	u64 d_off;
 	unsigned char d_type;
-	char d_name[256];
+	char *d_name;
 };
 
 struct iov_iter;
diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 67b0586d807f..d4335884e0c0 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -770,7 +770,7 @@ int p9dirent_read(struct p9_client *clnt, char *buf, int len,
 {
 	struct p9_fcall fake_pdu;
 	int ret;
-	char *nameptr;
+	char *nameptr = NULL;
 
 	fake_pdu.size = len;
 	fake_pdu.capacity = len;
@@ -785,15 +785,7 @@ int p9dirent_read(struct p9_client *clnt, char *buf, int len,
 		return ret;
 	}
 
-	ret = strscpy(dirent->d_name, nameptr, sizeof(dirent->d_name));
-	if (ret < 0) {
-		p9_debug(P9_DEBUG_ERROR,
-			 "On the wire dirent name too long: %s\n",
-			 nameptr);
-		kfree(nameptr);
-		return ret;
-	}
-	kfree(nameptr);
+	dirent->d_name = nameptr;
 
 	return fake_pdu.offset;
 }

base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.54.0 (Apple Git-157)

