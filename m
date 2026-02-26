Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD7392824
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092696; cv=none; b=S1vgkJGHdVMDzJHUHkkja5p3X34DNwdsJAcnlycvEwd5ZozYOxBHeTojTUtbdjf+OTXHwEF70IDjMDHNaGTkxEpa+asUoHRfk8C5EVQmpmz0xWiSJqzheU0MOQZfxqIc5ldbpXeuVfXVZFEq6e2Trhlpf1sYc1odD6T64CtUwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092696; c=relaxed/simple;
	bh=gGVWYxuqBAKRWboZgB22e5eeNoS9Nlu8uKEOSkH2WZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AR2PPEvc9C7oy/fVji6+1pSQzhIwnS69yozdn9pOJqQRfEUNyFL1v0sqsyraCUZ5h3XIK3fIN0M1I1eREJNwmz8SjAsgQgVN51u2xwoYH0Zc4CguNTkZXcbShgG3ChEcRxsDt+vNxs46Q3FHaJpRwURaozXxJh9xc/bInVOuFok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZE4UIWj; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZE4UIWj"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-8272c559597so569436b3a.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 23:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772092692; x=1772697492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eUDb1Uv2996od0EfWXbTj1EoPcd9eJP51i6xtNWuFfk=;
        b=kZE4UIWjq6JNDcD/2wRly97yHkjRp2brP29x1wgp2X2xTZEnDev/ReVObT1sG5vVh3
         DqSLjVBqQdv6Rs8XZtl4nQMvAEs0LmWfPZeNI27Y2czQ62PHx7ziVJ8yEBDG20mBwR8C
         kreVdZFCsjT5gopZdI7ig0oAQi92TS9u5LfWDibDm52Du4dIPBJlTHDweQIHsJ2fF4WP
         BO5y5aXT19wNsNHRHMY7EMWCvO42i0frKDL2qS19LzFOi6LBF5K5+WH/pVSutod695jo
         jlICYZ7rlsv2mjFe3d35XIWb26r9Qefo+C6GdcjvukwCFMuSns+cVPRApGoOJFA6ILcU
         intw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772092692; x=1772697492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUDb1Uv2996od0EfWXbTj1EoPcd9eJP51i6xtNWuFfk=;
        b=rkmpTZFAIIo1l4moToXuM9HR88/Qjyeclw+AHHYYeIhtvwY2/92pzSZQ5DW5wmyOsS
         trXjrHO1y3yXyOpwVF11PurL2BQCFFVVSOeRxTeT7tLaO0u/9Rxcwf4oRHZivE4kQGsR
         Kx+dTWFFRtDjN/h0a1EAwJhmwil2Ur2WCv7nlYXZLXk2/ejWlEorYmENMJms+QeCkMEU
         j/VCIjV9E3Tp2kx35EgaM+ZFPEu5YdOhEIvmNovO/dJBrXY2MSGOrwTbbZWzrK8LqOpm
         lEgL2vBjLmiz09FSvvHpaFHw/+pwcNZxxXXEisz4yk4IFXeizkzl4N6QYMAcL1qCl3m7
         TkBQ==
X-Gm-Message-State: AOJu0Yw4k4TFRGC2m/+EQ87+Z1lmD5lHbDVwXmCLrA3FlmlxSpAURr2K
	1Hv8FuG/9V9lew+JHNDPZ5b1ecrBKcAAt9K6jylWnXWadUcJVy6L3rZJ0bsZBmixlZQ=
X-Gm-Gg: ATEYQzxuLNg8K+fXQVEKX+FluaB93Wis2hV6TPYk4tYIXoh8a6OT6X4c4adXklKG2Fk
	ZNf0lN1E1HNVvDDJWnsg5MY3TzLPsBxmMei5Ro3Nk4NRDyeOo/vleFzs8UC4ionUhQgn9Av5cfh
	6mMMA73ryPy/6W0jRnzP9dM8bxjTAQnHU9EedkNcpikTdrX2K1r2sTPT7UpIUn2bOKnxUYndZW7
	sqUh9qJbT/pbt+MxPe/woi8hjeJ581dmJuLSGb+Ykq2jtgUWrJEmCmQoZiqzFm4IXsjIyt/HrZp
	JFT/mu8CLzcrCP0TKUdAkFsZ/Ogdq9485s951rcz+tKFNYbzzlC0VS/0nGzqZQ60KIRzwe25r6X
	EzpgtqKeJL5hhqiWvXPSKHczjGnZwwLyElv6S+tIpyLpQQws+2ijuo+wSrarRWWnrbNUppK9c6r
	sL+59HHyfuNEn5nZZWMDr2jfRGCqRdrJUBgrfLPy70fdDiJvLFyBlah6yZxvdNwwtYb3Qq
X-Received: by 2002:a05:6a00:2290:b0:824:9edb:454 with SMTP id d2e1a72fcca58-8273bfa1d7bmr1758347b3a.37.1772092691828;
        Wed, 25 Feb 2026 23:58:11 -0800 (PST)
Received: from zeeshan-Standard-PC-Q35-ICH9-2009.. ([110.93.227.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ccasm1483485b3a.39.2026.02.25.23.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:58:11 -0800 (PST)
From: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
To: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
Subject: [PATCH net v2] net: core: failover: fix NULL pointer dereference in failover_slave_register()
Date: Thu, 26 Feb 2026 12:57:37 +0500
Message-ID: <20260226075737.8948-1-zeeshanahmad022019@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch warns that 'fops' is dereferenced at line 69 without a NULL check.
While other callbacks in this function properly check 'fops', the
rx_handler registration does not.

If failover_get_bymac() returns a valid failover_dev but a NULL fops,
the kernel will encounter a NULL pointer dereference when registering
the rx_handler.

Following the pattern of other failover callers, add a WARN_ON_ONCE()
to catch this misconfiguration. Abort the registration if fops is
missing to prevent an inconsistent state where a slave is logically
linked to a master but lacks a functional data path hook.

Fixes: 30c8bd5aa8b2 ("net: Introduce generic failover module")
Signed-off-by: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
---
v2:
 - Target 'net' tree as this is a bug fix.
 - Change logic from an early return (v1) to WARN_ON_ONCE() and abort
   registration to prevent inconsistent state, as discussed with
   Simon Horman.
 - Update commit message with detailed impact analysis.

 net/core/failover.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/failover.c b/net/core/failover.c
index 2a140b3ea669..1702bb1feca1 100644
--- a/net/core/failover.c
+++ b/net/core/failover.c
@@ -63,6 +63,9 @@ static int failover_slave_register(struct net_device *slave_dev)
 	    fops->slave_pre_register(slave_dev, failover_dev))
 		goto done;
 
+	if (WARN_ON_ONCE(!fops))
+		goto done;
+
 	err = netdev_rx_handler_register(slave_dev, fops->slave_handle_frame,
 					 failover_dev);
 	if (err) {
-- 
2.43.0

