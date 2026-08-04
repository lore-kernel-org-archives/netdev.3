Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7678534B1A3;
	Tue,  4 Aug 2026 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862719; cv=none; b=MnF6TuA1Y4EsuOxUgQE7+q2CMMufsGRsuTG+fCg0MxVJWhsDudAPSjgjDXWtF3AhuX8KRG1mZ9+AbUs4yDfgEZgHXZbn+WWW9A9jUfTlppocQMoi4EjKDv6WaVKMwc6Mkr5AkpQ/QwBt5PHyDgcOg6/91xhxehRL/yzAAfHfRMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862719; c=relaxed/simple;
	bh=TeXhNBYMwnHy50Y9uAJW+IH5iWiKAx8biaLeUplWTYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cYN7LF6yIxoPjCO2oORn5jmxuDrSVrqDmO5v2y5yuX2WHIxc879I5KimzqXBwmZ2mZEMob1/ZmWktFFkrpgzCl80ZGla5vRS3csFKNn+aKbgPTF6Zz9yUXKUhZmv22LrpncO84CnpZ/JAOTDNK650Z8mgyRLUx89ucM0eD/OhW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhvMCvhW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhvMCvhW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A779FC2BCF5;
	Tue,  4 Aug 2026 16:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785862716;
	bh=TeXhNBYMwnHy50Y9uAJW+IH5iWiKAx8biaLeUplWTYw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=hhvMCvhWf3yGtFmnGbh/ThP3rIHUu3fltzJYQtbjy/5q92m+xlwe6wbl13ezL7GwP
	 niSXmpaTjfHRDWyBJkqYMjIOx6oZcTSS5t1x/niNPBYezYa5NJEyWvPGhe7eZD57bx
	 K0DSIqoJA0yxpBKXpZvXXCNu24wrU0P4Bhn08Pex8CY40E/Gn228946Tl+mtsE7WlO
	 aqlSQTBSsetU2mWaeGDclZ1oL86R39lt5K7bMlGZYB51RJ0iebvd88Zw11UiCq51KV
	 bflzDw4m3TByaV25vtVCxhMKe0ZN/E676+Wc64mYKCiHIQHjKF1Nn+gITwcUEYo4L7
	 Ko3JKEsX7ogGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E573C5518F;
	Tue,  4 Aug 2026 16:58:36 +0000 (UTC)
From: Anuj Bolewar via B4 Relay <devnull+bolewara.gmail.com@kernel.org>
Date: Tue, 04 Aug 2026 22:28:36 +0530
Subject: [PATCH] usb: atm: cxacru: stop polling on device shutdown
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-usb-atm-cxacru-stop-polling-on-device-shutdown-v1-1-d7fd757cee31@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBBA0auQWTsJNATUqxgXZRhgDLZNp1USw
 t2tunyb/3dQjsIK12qHyC9R8a6gOVVAi3Uzo4zFYGrT1ee6xawD2vRE2izFjJp8wODXVdyM3uF
 YGsSoS06jfzsc6ELd1PdNZ1oo0RB5ku03vN3/1jw8mNL3AsfxAURam6WSAAAA
X-Change-ID: 20260804-usb-atm-cxacru-stop-polling-on-device-shutdown-bc9c6f771624
To: Chas Williams <3chas3@gmail.com>
Cc: accessrunner-general@lists.sourceforge.net, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+e4b1171e7c5ae2556f9e@syzkaller.appspotmail.com, 
 Anuj Bolewar <bolewara@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785862715; l=2251;
 i=bolewara@gmail.com; s=20260802; h=from:subject:message-id;
 bh=8QcyJ5CtzZlRqOs+qCqjWR1tFjois3OdIejw7ulYCm8=;
 b=3l02SODI7MN+59jCpk6x2TdO9IUA1H/5XGGUINn8KHxAjoTChTzCNXCL7zsTibbpz5zVn9UVJ
 0I7BgtWIoQxDXBZC5spgAbkk1qKvU5TFizaRR3ly+JXc3AIWK1WyvuC
X-Developer-Key: i=bolewara@gmail.com; a=ed25519;
 pk=XxcXxqFWk9xQziyNEfhS6NRJQR1shqHRRYzkbaYamm0=
X-Endpoint-Received: by B4 Relay for bolewara@gmail.com/20260802 with
 auth_id=907
X-Original-From: Anuj Bolewar <bolewara@gmail.com>
Reply-To: bolewara@gmail.com

From: Anuj Bolewar <bolewara@gmail.com>

cxacru_unbind() sets poll_state to CXPOLL_SHUTDOWN under
poll_state_serialize and then calls cancel_delayed_work_sync(). If
cxacru_poll_status() is already running it only stops rescheduling when
it observes CXPOLL_STOPPED; CXPOLL_SHUTDOWN is ignored, so a running
worker re-queues itself. cancel_delayed_work_sync() then returns while a
delayed work is still pending, and the work fires after cxacru_unbind()
has freed the instance, causing a use-after-free.

Treat CXPOLL_SHUTDOWN like CXPOLL_STOPPED in the reschedule decision so
a worker that sees the shutdown state stops polling and cannot re-queue
itself after unbind.

Reported-by: syzbot+e4b1171e7c5ae2556f9e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e4b1171e7c5ae2556f9e
Assisted-by: deepseek:v4-pro
Signed-off-by: Anuj Bolewar <bolewara@gmail.com>
---
cxacru_poll_status() reschedules itself with schedule_delayed_work()
unless poll_state is CXPOLL_STOPPED. cxacru_unbind() sets poll_state
to CXPOLL_SHUTDOWN and relies on cancel_delayed_work_sync() to stop
the worker, but a worker that is already running when unbind starts
never observes CXPOLL_STOPPED and re-queues itself, so the delayed
work still fires after the instance has been freed.

Treat CXPOLL_SHUTDOWN like CXPOLL_STOPPED when deciding whether to
reschedule, so a running worker cannot re-queue itself during unbind.
---
 drivers/usb/atm/cxacru.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index f1900c567ba..a9902973914 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -923,7 +923,8 @@ static void cxacru_poll_status(struct work_struct *work)
 				instance->line_status == 0) /* down */
 		instance->poll_state = CXPOLL_STOPPED;
 
-	if (instance->poll_state == CXPOLL_STOPPED)
+	if (instance->poll_state == CXPOLL_STOPPED ||
+	    instance->poll_state == CXPOLL_SHUTDOWN)
 		keep_polling = 0;
 	mutex_unlock(&instance->poll_state_serialize);
 

---
base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
change-id: 20260804-usb-atm-cxacru-stop-polling-on-device-shutdown-bc9c6f771624

Best regards,
--  
Anuj Bolewar <bolewara@gmail.com>


