Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2508B4E3781
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674665; cv=none; b=uXaajp77H2WFtvqysVcWtLnSIUikC2e1HSVxYeX8KN3a7dDx6Gj4P/LTmRCohwXx0dZ45KfbHxwRNgDHJdXX0rVl1DsC6JCfjeS44a9Jq04CDV7cijUzbrVndxsYxvYoZs4xZvL//9POk7/ooeUQwG9s2Kiv+Kgh8jsLW6fTfeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674665; c=relaxed/simple;
	bh=X4ase3uZFteQjnmGFNbz3yJmwutElbZjUY/hE2Cshhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=utKNhk+Z+xtsB/kdHiqi7upi+NvVRmYa3mkK/bfGpErgIUqFpP7jw9mWNd1tKa4zz36d9N34q3QSxKyUbUTZGJpfj35xAT73Kn8EUUE1OUPn0KUMmFg972XHH2SZVr2YMLYgnxz4SX3vcs/zx/BYd/xOWfbp391xO3pzxHqT7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WyjeGzj9; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WyjeGzj9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dZ
	HMcU6jhoiUs1eT/R2wR45KgQhqXtUtly+tB+tzH6s=; b=WyjeGzj9CIVV9fnw96
	sljaS8wuXX+rqA7+ODe+calpx2lJQWj92KC273fUR/oWR12nMqvQlQIr4kS2elvD
	lXRXm9UFkMYTQUqZ52oRjfT1rZaw0nG5yuycVy43B4k+vTDHVP+kmym//SVxCavQ
	E6vuGm57f7f6iFebgfV1Us/Bw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCnt5nKhrtqVp7nBQ--.16613S4;
	Tue, 29 Sep 2026 17:37:19 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH v2 2/4] net: filter: add sk_attach_filter_kern() function
Date: Tue, 29 Sep 2026 17:37:10 +0800
Message-Id: <20260929093712.131096-3-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260929093712.131096-1-clementwei90@163.com>
References: <20260929093712.131096-1-clementwei90@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnt5nKhrtqVp7nBQ--.16613S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW7Cr1fKw45Xw1fCF18uFg_yoW8Kr1rpa
	y5Ww43Ar1UWay7WFn3J3ykAryfX3Z5WF1UWrWDKw1F9ryDKr109342gF1ayr1Yyr4jqw1f
	Xw1jgF9rWw1kuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwAwxUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4Q9eyWq7hs8AWwAA36

From: Rongguang Wei <weirongguang@kylinos.cn>

sk_attach_filter() copies the program from user space and sk_attach_bpf()
takes it from a user file descriptor, so a program that the kernel keeps in
memory cannot be installed again later.

sk_attach_filter_kern() builds the program from a sock_fprog_kern, so no
user buffer is read, and attaches it like sk_attach_filter(). The caller
must hold the socket lock. Failing the attach releases it; so does the
socket when the filter is replaced, detached or the socket goes away.

Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 include/linux/filter.h |  1 +
 net/core/filter.c      | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 39decde7fc73..0de5a738fb26 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1218,6 +1218,7 @@ int bpf_prog_create_from_user(struct bpf_prog **pfp, struct sock_fprog *fprog,
 void bpf_prog_destroy(struct bpf_prog *fp);
 
 int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk);
+int sk_attach_filter_kern(struct sock_fprog_kern *fprog, struct sock *sk);
 int sk_attach_bpf(u32 ufd, struct sock *sk);
 int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk);
 int sk_reuseport_attach_bpf(u32 ufd, struct sock *sk);
diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2..64d6505a4ef2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1567,6 +1567,28 @@ int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(sk_attach_filter);
 
+int sk_attach_filter_kern(struct sock_fprog_kern *fprog, struct sock *sk)
+{
+	struct bpf_prog *prog;
+	int err;
+
+	if (sock_flag(sk, SOCK_FILTER_LOCKED))
+		return -EPERM;
+
+	err = bpf_prog_create(&prog, fprog);
+	if (err)
+		return err;
+
+	err = __sk_attach_prog(prog, sk);
+	if (err < 0) {
+		__bpf_prog_release(prog);
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sk_attach_filter_kern);
+
 int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk)
 {
 	struct bpf_prog *prog = __get_filter(fprog, sk);
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

