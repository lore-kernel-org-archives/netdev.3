Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93807128816;
	Thu, 16 Jul 2026 02:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170291; cv=none; b=qv9bjDk/X7bU4rhHoQBSZv1CXYERkjV2L0U6e/UCMUMrVKDntm8XE69k3idwlmM8KBBxxFbIffzeHgqwJ7fLOZWSo5BEAupuYD9o7iXBcqoek6qrGON5+hz6zr9cHh0oNEyZO3HUFn8GHd7NjPFITFlYtmZgBuKQ6s5khbb0C0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170291; c=relaxed/simple;
	bh=HFHC33VHDa7Nr80x2aegxprL5Xjj9DsXFcFS1Hd+WvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwoq3GgxL06fQTAuIhy10OUKJu0xncURF1cvEaMSDCb6TuwLpeIGyjcEbuUJGSapC4ySKI2t0YzxAA33TdEYZOYCsUUB+dWO28WUTraeKg6A4407AmLSNG5hEZ0UhKbXZYzGhrWdXtF5/MerSSoP7/SrfOuawqA5FRlE42YYzVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Aa+Ci+uR; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Aa+Ci+uR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=79
	zu+JEWx8XoOd3YM7WEflFZNws1iB3czFJtkpyl+XQ=; b=Aa+Ci+uRHXLWIZYyHO
	ziErAkjWkkVN9fvbtJvTyj7vRd7LhFwOkjb8RHz1t6HoIeHfT5gTUPLG16SLwfVY
	gJLGhjomlOLCFi4wyeux8/Pti9hwy5PKu9fKAZaLxszztWU/Inq3x686qKdLgri5
	Mz/gAYGAxW8dmqfoIut8ZLFNU=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3n58SR1hq8MrBGQ--.46029S2;
	Thu, 16 Jul 2026 10:50:59 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Weimin Xiong <xiongwm2026@163.com>
Subject: [PATCH] unix: use kvmalloc_array() for BPF iterator batches
Date: Thu, 16 Jul 2026 10:51:03 +0800
Message-ID: <20260716025103.118200-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3n58SR1hq8MrBGQ--.46029S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW7Kry3CrW3KFW3GF48JFb_yoWxtrX_ur
	92v3W7tF4rG397Janxtr4rZa4rKw4kJ340g3WSvrZrJw18G3WxC3yDGrs8Ar4fu345tF45
	X3Z7ZFZ8Ar17CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMGYpUUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzROGFmpYRxPx+gAA3j

Use kvmalloc_array() instead of open-coding the element-size
multiplication when allocating the Unix-domain BPF iterator batch.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55ee..6664ead46 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3659,8 +3659,8 @@ static int bpf_iter_unix_realloc_batch(struct bpf_unix_iter_state *iter,
 {
 	struct sock **new_batch;
 
-	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
-			     GFP_USER | __GFP_NOWARN);
+	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
+				   GFP_USER | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 

