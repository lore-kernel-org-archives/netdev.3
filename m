Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2123A4F58
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207308; cv=none; b=TMV2XEfqWMOw+4aER/aoEgUzMp+QeCKO+vtKDoB4vIDmC7FEVYSMlI5M3+xCcgo8uWE499mPXFjUkbpmJN/AKCwXjCcxp/vXv8NEZa11kLbMeC18D0i2UgtST3bQtAhFWUKlnlu7uEwzYLVMUnP2lk/pI/EywtRawl58RA7Jk1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207308; c=relaxed/simple;
	bh=fQu8h00EssdjX+65ajgh6Z7/h4WGYUevxgzZ1eNMofw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d8+0i9QZxlckNmVISWCyelwrQEDI1jKWlgBaw+QxDG01Jb26fVfHIJW5Ew000EMopu3E/BEXnRPhBwejvNVW8ojSWgZzd76d9FMQhNsM3G7OCqDCqdsV9cGZOGN9yfBa3dGTkVWDKJVhY8UFvtCp6jlSLon/TQWv1pGaHVv0diI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9waZS0K; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9waZS0K"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93bfa7b2093so156066685a.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790207305; x=1790812105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yR6Sw8KFOfic5kEDry7AfTNaMY9N/L+deT07wNcYwmc=;
        b=i9waZS0Kw/MSqlBl1uxkfnZnp3BusxxUs0VLI+hwq+SU0fkfyd402sGZxdwcblSnnJ
         wRqdIdUxT0DytJWRzVJamMM40wecie1w06bDZhZoVMO6Xez98hdyq/9ZG3GcY09y95s5
         bEXPnJwWmOmrNtIbjMypRU4FVbrFYqlDcPxka0FfOHj7zCTrdchBq+b2cpL9oGfuDv0B
         RqJoSNVh+lQRgIw5Z30Cd54/mFw93PX4htRp12+9Fgdx93og5WR/g0ZQAjqDTeWhu+zZ
         uN1UW5C0Df+Zvqrrk+031Zroj4wptddWTHRmK00qCoYGnQ4pxWI0W7zZ84ztbo8gBtQQ
         NW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790207305; x=1790812105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yR6Sw8KFOfic5kEDry7AfTNaMY9N/L+deT07wNcYwmc=;
        b=fvFqHBWOxnOOoBAxmb4KqPzLKWlApEtzIj/Py66CxPY7FJvnwWDYLWSVNNJaXFXvAe
         hIFTlu0u/uamciCoh7xCwJYvxzRB4fjZ7Iuqi90wu7jRsiStbVKIFJeG68eGqCAs+bga
         NIglenyIPM3zACFlKFx/2jlRegwKzSY/BwB1nZ4OXsw5XexM2yVJOJYigcdOYweczO8i
         hbA0iEBRXfWZIgcIuOEgmUeJfXSeeIUVV7QHAK1WhBLnXc/I58Px9Zz71GrwjpXvYFoT
         gn6HUGy+sl9POFSAGij1A9YQhl1ofTvQG7/QJwXQTKkuLP6uQeaoXfU5/ZX3QSZbpgDn
         gGEA==
X-Forwarded-Encrypted: i=1; AKwUvBwrqQcWUXrphtvNZpAS6m3ZjfSPS+zPilpzFMdQjPY0v9uFlLoJUB/KzucnsoXYu/RmZSSo8Do=@vger.kernel.org
X-Gm-Message-State: AFuF++k8LGGSX2m4nGw2lm+pG6yaJLtecTY4rig+nIAU35FskUYPd+aZ
	pVBhC9bdhTH0iqzT8VK7wdBTh8gvTvrWzXZN3S8PFMW+SdmoOe5nCREAGVs4L7GR
X-Gm-Gg: AYBFou3HMINLZcJFUzDflqd0EXj+g6h7h5xRM5fpwdxon5BZjuXcNdTDFAtZqGhHVa6
	i4dGNAvVhlb/1MBISHCBSEj549H6xPlITwGHq1mlGTUCqCaiMkZxuUAywzGOvjjOXdzFkeCgQqc
	HGTgrUq2tOKSnTRMxU9eZSI5pYSl9SY8NNy3cp3dD/P4eJHmxCmCGoFIYDmcoB/HsoPc7YEq5X7
	+w6coapY2vDxBw/d+EruAk2zaCP5TKYMq7CtDH2EHkfv4GPyUnmExAP+uhEwxDXBjQoQA4A7THr
	/U/6yMf3WXV4f1fn6KFphgaPFf/TQQE+y5G9Y/5UzBHFkBpA3Bp6lAkhrNYuoATUoLBpIWnmmUF
	ghJ71hafZkU7/g0XOmgEqopqhzBtVULZ05ZyCHEdlax5B7VlGBQh2asjLlQhx2uoimbHs5KiVZH
	3e7M5l1ssInWpfC3nWqR2OOabYvtQPwkWsZOd5PpXrtWut1A69xUhJwZijzrFHM5I0M0uK9mvSI
	lrqRU/LiuT0d/BpEahq0w==
X-Received: by 2002:a05:620a:448b:b0:93a:3aba:a0d4 with SMTP id af79cd13be357-93c3633a150mr43043285a.27.1790207305188;
        Wed, 23 Sep 2026 16:48:25 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c248a1481sm334514885a.35.2026.09.23.16.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:48:24 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH net v1] idpf: Fix vport IRQ name leak on request failure
Date: Wed, 23 Sep 2026 19:48:06 -0400
Message-ID: <20260923234819.702327-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idpf_vport_intr_req_irq() allocates a name for each vector IRQ before
calling request_irq(). On success, the name is released later through
kfree(free_irq()), but when request_irq() fails, the error path only
unwinds the previous vectors and the name for the failed one is leaked.

Free the allocated name on the request_irq() failure path, as done for
the mailbox IRQ in commit 9bff30482c10 ("idpf: Fix mailbox IRQ name leak
on request failure").

Fixes: bf9bf7042a38 ("idpf: avoid bloating &idpf_q_vector with big %NR_CPUS")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Compile-tested only (x86_64 defconfig + CONFIG_IDPF=m, W=1).

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 4311ffa30bb1..e7d5e7923371 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4073,6 +4073,7 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 		if (err) {
 			netdev_err(vport->netdev,
 				   "Request_irq failed, error: %d\n", err);
+			kfree(name);
 			goto free_q_irqs;
 		}
 

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.43.0

