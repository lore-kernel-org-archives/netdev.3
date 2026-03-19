Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED03E34DCC7;
	Thu, 19 Mar 2026 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903018; cv=none; b=j1xS/klwnXn7/TItJd9Z+xkEzRvufni0Cu3tMrfRxh+MVhXVAg+MRAxT+9rZODzBurN+X5FqyOFtz/3RmX2gDoe8zKqBC0TBgFrNE/9nLh272hffh+nauUOhTT7Y1aDHilY8uDxKfTpxhDGdiiM4bht/bsHuJvuE3OY7pckO3PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903018; c=relaxed/simple;
	bh=ubqL7jPFZLTew58NLvHWBunMCZbUlTs6SkPlgwTF0bg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=VVGzLmCbGUFgc3mcpgEPjNoXOWnEuPf79rvKuMEGnTjPOJ3QGwLLG70NnYQI8NvcKuHnRrspgwMBPmJ/M1+bzaYrENtv8rA1aqnOvybGtA1ExdTykdezOIfQj9ZuiLzNtarYvSk3Byp4q67/u/yME+/47jG+MI/DywIJSAuC3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GuqnF/1W; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GuqnF/1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1773903011; bh=nrN9XEXQYiZ0qjf3d1rT5FyT1XzbmEzXIfODvbMT2R8=;
	h=From:To:Cc:Subject:Date;
	b=GuqnF/1WD7GP+CdPTindbL9EEQ1tOC345xq/MpjansgWA+ey2p5361I2YTYYVbpuQ
	 mapyhQ1sZ4Igix4hB7S4QGqpBoB4xBO4nxDS/Imt/8vLgafm5+PavqgnZBxLXvlFpy
	 VvQodELFmBIr+7yXvzrOhP0WWEKOxJDjOqnAcgqA=
Received: from LAPTOP-KQCD4QBN.localdomain ([183.242.199.70])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id C88196F1; Thu, 19 Mar 2026 14:50:08 +0800
X-QQ-mid: xmsmtpt1773903008t4xz9679e
Message-ID: <tencent_1F05100756A32EDA9ECB2D342AFE8A3EBA09@qq.com>
X-QQ-XMAILINFO: NR2AmdDOCZJoLJRDUwnu3+l2qINSY2y6KSJHpYeiDk4PAYnoPSjbBMp4AbA1rO
	 IpFixWBmDgKfXuEWpLXCKZ+FadVfAAhQ4taC9yF2iWZpn5A3jIiTPynMyrrmkY9bTbQhQIia7aqN
	 BJDySKj9W2nSwXggPAV7o3SYxfKHYODNT1d8qwgSxodO+y1fDXENRHps9GzFx6mX78DWBzxOncbo
	 98JT3vJRvzzashd51aqHozctufNdkJS49oncJO7sMMKUiqODbnQNJZPHpeJAqK/5N6g53c1ODnJJ
	 qJsuZNOiMK4ErREsa60j85nzCJ2abPWlrYipu++OeLxRXrbF9mWkvEKDEzIO8h5H/zt4quv4Xrkq
	 oFPBf3iwpZoAbRs9Nsi57+0oJum46/7Do3TOy8aEt47N7Y/Upyvyk5FYpfvOiVZuB5Vi011KWCyE
	 fvGxmXTwynJ1otxJhZalmDu+usxvfI8OWjl/PUT8Y1ZgZwcfLBVaB+vjQZkbG8/bGxuXl2gDX9m1
	 nQ0oat37d+2JtV3P4VWUDz87UXNmpF/QEJGhIEIfu9EbpHWBkSrKNKYKkfQ9RPwEY1Qmf0h3ahMB
	 bxb7MsmxDq87O1wd8ppw9c7pAPI8EFKdNRASyUe88jIsnHJ88SjUgsmtBeZ09xjyrtQErR3DNdQm
	 1vm49xk6P95tVvrcf74oKgzbuj00sLzxtsF4AAKPaGswdNfcwjcYdEXky1UhzzleDxkq+hS3EDPT
	 rj0KCI7c5kWzmLa9tSckUGCGTQs0S3bzMBfGaIuPyiSonrv8/G8zQv02hnD+UX8kNrO4pDjbuFXV
	 BuADW6jR2/TCVTZJqOgMM6Hjqi5RKD7hHL2VKAHzVvaoXk2ZW1AKiljoQ1eNePSi6gbgzJQJTXCc
	 qF9fCiuhs+2KexxGdi2uHYYV/F9sCb/Z2+qKrIofN8ghEMM9Tbcq39NDw4pFHnpq1KzNeAEVWKFJ
	 z+0gDyVKllF/xLHPtgInsnunUEYeROflvI3zSa8ioL0PYKNBvYT/0l5LVoHo6G8QpJ7LBZ/GFqvN
	 0/GV5WgjzS0naAHD29K751VXguzdDCSIQtr2zRFw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Wenyuan Li <2063309626@qq.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn,
	25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	Wenyuan Li <2063309626@qq.com>
Subject: [PATCH] nfc: pn533: add error handling for i2c_master_send() in pn533_i2c_send_ack()
Date: Thu, 19 Mar 2026 14:50:05 +0800
X-OQ-MSGID: <20260319065005.9982-1-2063309626@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In pn533_i2c_send_ack(), the return value of i2c_master_send() is not
checked. If the I2C transfer fails, the driver continues execution
without detecting the error, which may lead to incorrect device state
or silent failures.

Specifically:
1. The ACK may not be sent to the device, leaving it in an undefined state
2. The caller (pn533_i2c_abort_cmd()) ignores the return value entirely
3. No error logging is provided for debugging

Fix this by:
- Adding proper return value check for i2c_master_send()
- Converting partial sends to -EIO and preserving kernel error codes
- Adding nfc_err() logging with %pe format for human-readable errors
- Propagating the error to the caller pn533_i2c_abort_cmd()

Even if ACK sending fails, the abort procedure continues by scheduling
cmd_complete_work to ensure userspace is notified, but the error is
properly logged for debugging.

Signed-off-by: Wenyuan Li <2063309626@qq.com>
---
 drivers/nfc/pn533/i2c.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
index 132c050a365d..4d771fe24f70 100644
--- a/drivers/nfc/pn533/i2c.c
+++ b/drivers/nfc/pn533/i2c.c
@@ -40,8 +40,15 @@ static int pn533_i2c_send_ack(struct pn533 *dev, gfp_t flags)
 	struct i2c_client *client = phy->i2c_dev;
 	static const u8 ack[6] = {0x00, 0x00, 0xff, 0x00, 0xff, 0x00};
 	/* spec 6.2.1.3:  Preamble, SoPC (2), ACK Code (2), Postamble */
+	int ret;
 
-	return i2c_master_send(client, ack, 6);
+	ret = i2c_master_send(client, ack, 6);
+	if (ret != 6) {
+		nfc_err(&client->dev, "failed to send ACK: %pe\n", ERR_PTR(ret));
+		return ret < 0 ? ret : -EIO;
+	}
+
+	return 0;
 }
 
 static int pn533_i2c_send_frame(struct pn533 *dev,
@@ -82,12 +89,14 @@ static int pn533_i2c_send_frame(struct pn533 *dev,
 static void pn533_i2c_abort_cmd(struct pn533 *dev, gfp_t flags)
 {
 	struct pn533_i2c_phy *phy = dev->phy;
+	int ret;
 
 	phy->aborted = true;
 
 	/* An ack will cancel the last issued command */
-	pn533_i2c_send_ack(dev, flags);
-
+	ret = pn533_i2c_send_ack(dev, flags);
+	if (ret)
+		nfc_err(&phy->i2c_dev->dev, "failed to abort command: %pe\n", ERR_PTR(ret));
 	/* schedule cmd_complete_work to finish current command execution */
 	pn533_recv_frame(phy->priv, NULL, -ENOENT);
 }
-- 
2.43.0

