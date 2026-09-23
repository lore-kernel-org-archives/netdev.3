Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8C13AFCF1
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152876; cv=none; b=p1BHRrEgpkYjdSlNn3UQ49Oydq8st/eAAjxsf5TpDZlNahFuWIrGH3w/dsdEs+Qi8xX3Z4+jawwH/8SnwjpVjxafSwaHHuAmzu3i/KTM0acgz6YJjt0Ewg5rvG1pdkpPrKr36qlNw+7Rf3TvvJ7D47GIKGS1OsKfNg3sP7PTEUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152876; c=relaxed/simple;
	bh=MtElMJ8fbL766bC95A8ZzPRkioZPIOD0KBOOEsCnNBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cnvhNwG/ljA49C0WRmtcJBX6tHl9zPuLxOdt2NVqLHePNjuaWhCLKYFi7LfDcqfDajktaWcuzB38G5WaNIWRQfeHPDL6JnwCDWkAlkOL7n0YcbdqmXcBjtT4ck7FbDgkegcmb+7qPiiqkM3o+E2kADXW1Abdb2kcw8kKIu9fVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz7BOztW; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz7BOztW"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so402942a91.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790152865; x=1790757665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FFMFjnfJDGF+mkKV4NlETqKvpStxbHkejYuXiptoDT8=;
        b=Jz7BOztW05YtqM24OhZpJabutmbXTXX6pYw434qjpjj+rdWCREpg+bDawCVeUw9nc6
         YYyB7R28H58WDxoKxCdWyMKGnSxcfRveqrO/hzC0bnmE9Oa5lfosP0dhyF1xvelhK+LC
         ic1dOvI6jxYDBRveiTYNc+QDlak7hFYkWHVSdQJXmgHwqCHqNOvD/ohA9+8npspw4hrd
         RV/Ly3HS3dnFmnIkI6HTGtodi4Gmw37ePePOvgwvuhzO0GesBQrMguq8OuAxYFfBo/9B
         hgt7jL4ZNzZWxMjn3MD9cMlfvRUJXTDm2iJU+9sbMSAqqKvVAzU9w59BkOc8zoTZASFl
         CErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790152865; x=1790757665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FFMFjnfJDGF+mkKV4NlETqKvpStxbHkejYuXiptoDT8=;
        b=0bAENU3m1cTYEy8o01wdy1syUxYOIeGyO+LLvK+gEkXR+m7JaCMAUIHB8hbHR4VfPJ
         1GQQNxA0HNc/016UmNgA/rKKudJ986YFM0a10POPUI0tKsLdKTfFQT0qkZik8QiSiNgS
         2rAnmF9oWRa06Ovwta2+pFcBwVn0/PYEfAw7JitQVDLJKqDMd3DJxsa52egDtNDMi5IK
         bOW3MaT7v9xBLlnrmvQWmqLd7lkbYaiUB44hEyZZ7K+omgdeiWM1uc5ZQ0kyVFGe88Ln
         bZsr1alFBwSF4FsNf40xhowSgdtIH4pZldNETsGoPe6vvp+0/jPYSP7/qOcU02vEVcDq
         DP9w==
X-Gm-Message-State: AFuF++k8JYVgt9A8FHca7WxdYfpfFfD7/dLgRp158QmP/TIoixiwsmVq
	7LLOm/N1LSP1KaPKBazRZw5qhK+kzM7pI8juYld1zosArx8a3yBdru+ODCz40oZB
X-Gm-Gg: AYBFou3yHBaJ6icYmLEjtrwIJsHBGe+f5Vm6cZgLeQaUXw6BwaGRLLQoC9W8gUsHWhS
	cr4sTycjVCKHk7xJf5ixwdZX2fdlnz/ycESUad/aRT7lb+JgMj/ZtrYL19VgsJOvKEsfr9NeYgN
	ynvhGXQoui+Q+PpedjZ1dDZYdsHKQBwPh5EtiHdkeOVN9xFLJAmwJmjYagosMKBFcF+cp1kn9M9
	E/lxbs065oy+90LWei295QfWhroTyHRXssRHZ0faDS0bth7Ird9nyNOnA0+bK+SFt4H62POC7Ok
	fMhe8hkJR9s7qVOW5K2jp0ZBONBthTqvBHizyS7eG16pTnmbnBl4IL5sheuAryrwvw17EoZLlKp
	l36+kuyTnPXxHSe1sgTz6sfE7qthxLfb7gNxK2Olkp1FFHD1oZ1P9lw4jJVasuIcQhFn3nkaghV
	LSWUXwKU0C1MAFJUxm9EMoR1tVq5cVuOUWl//D0ViZfuWye2YVMfU0gEI4vIip1LAxmyFZ7lFQ3
	wTMtjeFJqnxd6v4RYyd/uFxGBqvxGu+f703Tbhbd3q49T13lXKxirI4qIsofoS0GbfZafiFFuTq
	8A==
X-Received: by 2002:a17:90a:d645:b0:39d:f317:44cd with SMTP id 98e67ed59e1d1-3a07e554e0dmr1667962a91.14.1790152865102;
        Wed, 23 Sep 2026 01:41:05 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-212-242-176.ap-southeast-1.compute.amazonaws.com. [13.212.242.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0812a1eb2sm1105330a91.4.2026.09.23.01.41.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 01:41:04 -0700 (PDT)
From: Ginger Li <ginger.jzllee@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dm9000: Fix a recursive lockup in the TX timeout path
Date: Wed, 23 Sep 2026 16:40:55 +0800
Message-ID: <20260923084055.65091-1-ginger.jzllee@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dm9000_timeout() takes db->lock with interrupts disabled and then calls
dm9000_init_dm9000(), which expects the caller to hold that lock and accesses
the chip registers directly.  For DM9000B devices dm9000_init_dm9000() also
calls dm9000_phy_write(), and that function takes db->lock again, so the TX
timeout path deadlocks on the same CPU.

dm9000_phy_write() already skips db->addr_lock when db->in_timeout is set,
because in that case the caller holds db->lock and sleeping is not allowed
either.  Skip db->lock as well then, so that the nested call from
dm9000_init_dm9000() works as intended.

Fixes: 6741f40 ("DM9000B: driver initialization upgrade")
Signed-off-by: Ginger Li <ginger.jzllee@gmail.com>
---
 drivers/net/ethernet/davicom/dm9000.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -325,10 +325,10 @@ dm9000_phy_write(struct net_device *dev,
 	unsigned long reg_save;
 
 	dm9000_dbg(db, 5, "phy_write[%02x] = %04x\n", reg, value);
-	if (!db->in_timeout)
+	if (!db->in_timeout) {
 		mutex_lock(&db->addr_lock);
-
-	spin_lock_irqsave(&db->lock, flags);
+		spin_lock_irqsave(&db->lock, flags);
+	}
 
 	/* Save previous register address */
 	reg_save = readb(db->io_addr);
@@ -344,11 +344,14 @@ dm9000_phy_write(struct net_device *dev,
 	iow(db, DM9000_EPCR, EPCR_EPOS | EPCR_ERPRW);
 
 	writeb(reg_save, db->io_addr);
-	spin_unlock_irqrestore(&db->lock, flags);
+	if (!db->in_timeout)
+		spin_unlock_irqrestore(&db->lock, flags);
 
 	dm9000_msleep(db, 1);		/* Wait write complete */
 
-	spin_lock_irqsave(&db->lock, flags);
+	if (!db->in_timeout)
+		spin_lock_irqsave(&db->lock, flags);
+
 	reg_save = readb(db->io_addr);
 
 	iow(db, DM9000_EPCR, 0x0);	/* Clear phyxcer write command */
@@ -356,9 +359,10 @@ dm9000_phy_write(struct net_device *dev,
 	/* restore the previous address */
 	writeb(reg_save, db->io_addr);
 
-	spin_unlock_irqrestore(&db->lock, flags);
-	if (!db->in_timeout)
+	if (!db->in_timeout) {
+		spin_unlock_irqrestore(&db->lock, flags);
 		mutex_unlock(&db->addr_lock);
+	}
 }
 
 /* dm9000_set_io
-- 
2.43.0
