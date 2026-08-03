Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8397E379974
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752243; cv=none; b=uVNZ1GpBgzyYIk7ojX/M36b32LHD4eOzOziF4Xf+pgx86IkgNzXtW9HPxYHGYJPer56uAQLdBYqNrj8TJCcHPnc6gwCluOqa3789o31ksxdC28L/jPo6jRYaSbv7BGJM0PTECRnaVRLuj+1w/fjfZfiXS877LRlMFMfRsneCK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752243; c=relaxed/simple;
	bh=N8lr4PhpdwnLHM3UOch1jueU2anoDcJwMvyA9m3ih0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WIOScZ5faVdH0+q5lt3WdPU7t6BCHvW+AjjPt70tNRGKMtqvisLMDskToDOmJZeS6Kb27k+c7mPjc3HACpYpBzVjL+j1XqIItkXqO0zAj3fu3xQ64YfRlD/EPGCuKSexrCc7w2rRfDBSUChVJqX/yskWE4qqoyr1Hq2f4dnLM0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGyWlkD5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGyWlkD5"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cacb8416a1so30860695ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 03:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785752242; x=1786357042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hthDC2Kbdeq2qaz2x8s8OZb7AI2FDOI03M6IYBfIxS4=;
        b=KGyWlkD5K7I0xP5xY5TghinBA4RuMhbLOhloQzQPvW4dhoDU1URe9fs1iHLTIjmzyz
         kgzCvKZm2uJuI3ABYBPyCl+L1Zix6YSNIj9Fgu+85Rb/1pZYORuV27B5nyGk/rFetJnh
         3mZKMR+fSxebcl1NFNY+yWN1mJgC29oaTwLyNG/O287xFzVUpJ06EdhMxekYHInlBWAG
         vPDN7YlYEn8SfUMcATrd8Vf/31uegg4tNV0dN6IbEJfn4I4W71Ak9sR64fNScuKzEnHp
         fdZVe6B/+spnTly6Gi+iEBW9OzqcdXtkIvqPZor+kWzWw0AhsaxRWhGXyukPCd9JfWJ2
         4eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785752242; x=1786357042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hthDC2Kbdeq2qaz2x8s8OZb7AI2FDOI03M6IYBfIxS4=;
        b=CA/0gim4EHL6gqZqB87wVsEY7HXyYp0Ft64hXrttBHfiYoRRUgdGw3zL6RDnTN9WG2
         fZRJRGjYp+Uz2Yf44elstNfx8Q21YHk0z3lwa7Vxoy1hPncF3ZTXr/2s5eMUCeXrbf7w
         FxITYAmWCLLaMYEdepHsDrtiIEvE9nLrzE3J92cp7kAqTZs1lt0AmYkbHVO4CUCx3kBA
         IWrD/04P2omc+uYo1Uq4IlAmuPoqTnrx9Z07rfH8tW6s3t0z31RkbSN49HS6y+YrNC7N
         tHExkFZo+1ySXFS3UXWNaSEAg8drOSrzPyFrOEASdaEmEtZmGtaqHFb2UddytPcJQ/aB
         88NQ==
X-Forwarded-Encrypted: i=1; AHgh+RrR30geL5H7sIfKIt9nG/AGr9IgT6Rqcbk0aSr7JJuq3Hn4FeLv7Y2Z6kHYHtdDzO/9liz5RtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ6tHFS4+y3QIEc25vswpg9kHAIF61s4uH64e7PemwQZoWhogg
	x3Hp64Bl0/4/Nh1bWYKKo7qfnCXOgtUuwBt1nN0yngl0Ev/mivurN315
X-Gm-Gg: AR+sD10dxdq+lmSUWtCvdHkhPZJjJHJ3FfkDIdeIp3GwPusCthb/XvBf00eMDugkxbo
	t1LIt18j+KIqx9G8zpx7gvNO0JQhef9+D5IsxffBwmzX+sEVZ6JrKGH8O36ZNHLhDvr5o/JBTlX
	Xvt3RNRmV70gvWqqgLOkeqaVXjJ1Baw30GNR6pmGaWqJHbtcJLy5zYkqHWfFu2vKTvTQByvVTSJ
	CVG+mpsbxcGQEvwoxfwuzKi9ubn1YJI7BB3Uw0XwZ1OQvn0M/SCQwamAjWLExQklqK/lTFrNX3n
	2gJFazKemsh4TzgzhYAE/0uAE8PvvJp7OJxMJihZm12idjL5joCbU9nlCW0ysgQYyOHj5OuUtui
	lf5w6mcmNPiAdZmzXbmysIu3Iilz21GO0+QL1AtMKnW5PuY752PbNu3UsmaodokqjS2XEH46z/0
	e1ty4C+gNJsPIAUMgCNBA5yJtr7nWtrwkB0CL2udb+tm1F3X5DXAD5ZcGynR9nllZ5pEjvTv4uI
	HBOnotbr94D2A==
X-Received: by 2002:a05:6a21:1fc3:b0:3c3:90de:60e2 with SMTP id adf61e73a8af0-3c92a951846mr8695669637.65.1785752241763;
        Mon, 03 Aug 2026 03:17:21 -0700 (PDT)
Received: from ML-GYSUBT565.ECARX.COM.CN ([101.47.164.95])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab132cc4sm29359598c88.2.2026.08.03.03.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 03:17:21 -0700 (PDT)
From: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>
To: 3chas3@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	accessrunner-general@lists.sourceforge.net,
	Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>,
	syzbot+24eb38c789655fc43663@syzkaller.appspotmail.com
Subject: [PATCH] usb: atm: cxacru: fix use-after-free in cxacru_poll_status
Date: Mon,  3 Aug 2026 18:17:16 +0800
Message-Id: <20260803101716.2592486-1-khiemtranzo532001@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cxacru_unbind(), cancel_delayed_work_sync() was conditionally skipped
when poll_state was CXPOLL_STOPPED. However, a work item previously
scheduled when poll_state was CXPOLL_POLLING may still be pending in the
workqueue at the time poll_state transitions to CXPOLL_STOPPED. Skipping
cancel_delayed_work_sync() in this case allows the work to fire after
cxacru_data is freed, causing a use-after-free when cxacru_poll_status()
attempts to acquire instance->poll_state_serialize.

Fix this by always calling cancel_delayed_work_sync() regardless of
poll_state, ensuring no pending or in-flight work can access the freed
instance.

Reported-by: syzbot+24eb38c789655fc43663@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=24eb38c789655fc43663
Signed-off-by: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>
---
 drivers/usb/atm/cxacru.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index f1900c567..fd644ae52 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -1231,8 +1231,6 @@ static void cxacru_unbind(struct usbatm_data *usbatm_instance,
 		struct usb_interface *intf)
 {
 	struct cxacru_data *instance = usbatm_instance->driver_data;
-	int is_polling = 1;
-
 	usb_dbg(usbatm_instance, "cxacru_unbind entered\n");
 
 	if (!instance) {
@@ -1243,17 +1241,11 @@ static void cxacru_unbind(struct usbatm_data *usbatm_instance,
 	mutex_lock(&instance->poll_state_serialize);
 	BUG_ON(instance->poll_state == CXPOLL_SHUTDOWN);
 
-	/* ensure that status polling continues unless
-	 * it has already stopped */
-	if (instance->poll_state == CXPOLL_STOPPED)
-		is_polling = 0;
-
 	/* stop polling from being stopped or started */
 	instance->poll_state = CXPOLL_SHUTDOWN;
 	mutex_unlock(&instance->poll_state_serialize);
 
-	if (is_polling)
-		cancel_delayed_work_sync(&instance->poll_work);
+	cancel_delayed_work_sync(&instance->poll_work);
 
 	usb_kill_urb(instance->snd_urb);
 	usb_kill_urb(instance->rcv_urb);
-- 
2.34.1

