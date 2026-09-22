Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0D53769EC;
	Tue, 22 Sep 2026 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041446; cv=none; b=eHVF3H18rcspLu0m/XvTYfLuVZYLdmJjRBqlJT/8Hg9Fi+7BkUjzYtcJTgrXtqSty4H6LUXkVkMgUm/ddq8nOSHU75STcJI4mc8rPF8+qtXEdLmvoFQXZasyNSIloykDctdXK7MhtJYwrLFvuXpE7YNRfyDEphwsXMWIe44kkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041446; c=relaxed/simple;
	bh=jK8JIyhGREW0TMylI1y9XEKxchWa3qkkmjrO5RGrnWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YyEHcGRiTU3W3yget7qFxlgHqH/O1pMMvMgRcwL/t1inwnbHgt9Y0qBk/UrU2mRU+f1tsOCk4a+xmWro9qI0YmTExfPZR0LUZiFmZdmHxyJUmSUkVmAQYsL5OI8Rb9X45qQsOM7EyfZgNDYEFeb2drNzxqOKAF4D71/IOyZOcc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLV4Lk09; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLV4Lk09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790041444; x=1821577444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jK8JIyhGREW0TMylI1y9XEKxchWa3qkkmjrO5RGrnWc=;
  b=SLV4Lk09iYk8iOdLMjA4CZucI2KZE/747GB7gYub77tGGQtu3nqzDEoc
   +LuOF9WQLa+H9Mx5T6J7s/NX4CCmubZHcNSm/QM09COdPDBqFyaFJW8R5
   n3Un9UCtP0TtjD+h+j85fLKsLz9IRqWLA+CQg/vX1fGxUsG8Sh5VB0wRx
   mqVWmciVkTMQ5vna7/svJGoFoSJo3s/aYqVIIvUJlRmb4ofusIXHGE/6D
   Z7DBlYCeMhCR8AlJQZ3r40L58dvayj1a+MCcBoAyt7sWQ59d9mUD1HpRv
   epVvSnVomcKsoms2EYAPq84njyrwfmcv4gAs6+FpffQlq++alRvZxYf+R
   Q==;
X-CSE-ConnectionGUID: Z432NT2pQZ+EafDKGwcdCQ==
X-CSE-MsgGUID: g+8EpNpiTS+K/Vn40IwEIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101198401"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="101198401"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 18:44:03 -0700
X-CSE-ConnectionGUID: MHJ3wyiTR1q0HaItK+rP4g==
X-CSE-MsgGUID: 5bIAnYVXQWatD0AcS/ERow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="3995330"
Received: from qat-server-366.sh.intel.com ([10.239.92.87])
  by fmviesa011.fm.intel.com with ESMTP; 21 Sep 2026 18:44:01 -0700
From: Jie Wang <jie.wang@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chas Williams <3chas3@gmail.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	accessrunner-general@lists.sourceforge.net,
	syzbot+9b195c4f412ea5c4e56a@syzkaller.appspotmail.com,
	Jie Wang <jie.wang@intel.com>
Subject: [PATCH v3] usb: atm: cxacru: fix NULL deref of atm_dev on sysfs writes
Date: Tue, 22 Sep 2026 09:29:53 +0000
Message-Id: <20260922092953.4048507-1-jie.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026091012-nastiness-coveted-74e3@gregkh>
References: <f3ef0a67-79d7-47da-be6e-7e82d92e68fe@mail.kernel.org> <20260908150203.2119844-1-jie.wang@intel.com> <2026091012-nastiness-coveted-74e3@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The adsl_state and adsl_config sysfs attributes are created via
dev_groups, so the driver core exposes them as soon as ->probe()
returns. At that point instance->atm_dev can still be NULL:
usbatm_heavy_init() waits only for the heavy-init kthread to start, and
atm_dev is assigned later, in usbatm_atm_init(). A write in that window
passes the "instance == NULL" check and then dereferences the NULL
atm_dev: atm_err()/atm_info() expand to
instance->usbatm->atm_dev->number, and a poll/start request also calls
cxacru_poll_status() directly, which touches atm_dev via
atm_dev_signal_change() and atm_dev->link_rate.

Log via usb_err()/usb_info() instead; they use the USB interface
device, which stays valid for the whole write. Reject a poll/start
request with -ENODEV before poll_state is advanced to CXPOLL_POLLING,
so that cxacru_atm_start() still starts polling once atm_dev is ready.

Fixes: e605c30977bb ("USB: atm: cxacru: convert to use dev_groups")
Assisted-by: Gemini:gemini-3.6-flash Gemini:gemini-3.1-pro-preview syzbot
Reported-by: syzbot+9b195c4f412ea5c4e56a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9b195c4f412ea5c4e56a
Tested-by: syzbot+9b195c4f412ea5c4e56a@syzkaller.appspotmail.com
Signed-off-by: Jie Wang <jie.wang@intel.com>
---
v3:
 - Guard in adsl_state_store() instead of cxacru_poll_status(); the v2
   guard left poll_state wedged at CXPOLL_POLLING with no work queued, so
   polling never restarted (Sashiko).
 - Restore the Assisted-by tag.

v2:
 - Drop the ->atm_dev entry gate (an unsynchronized TOCTOU); remove the
   ->atm_dev dereference from the logging paths instead.

v1: https://lore.kernel.org/all/f3ef0a67-79d7-47da-be6e-7e82d92e68fe@mail.kernel.org/
v2: https://lore.kernel.org/all/20260908150203.2119844-1-jie.wang@intel.com/

 drivers/usb/atm/cxacru.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 636f7886fc260..501a51b27e466 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -356,7 +356,7 @@ static ssize_t adsl_state_store(struct device *dev,
 	if (!strcmp(str_cmd, "stop") || !strcmp(str_cmd, "restart")) {
 		ret = cxacru_cm(instance, CM_REQUEST_CHIP_ADSL_LINE_STOP, NULL, 0, NULL, 0);
 		if (ret < 0) {
-			atm_err(instance->usbatm, "change adsl state:"
+			usb_err(instance->usbatm, "change adsl state:"
 				" CHIP_ADSL_LINE_STOP returned %d\n", ret);
 
 			ret = -EIO;
@@ -376,7 +376,7 @@ static ssize_t adsl_state_store(struct device *dev,
 	if (!strcmp(str_cmd, "start") || !strcmp(str_cmd, "restart")) {
 		ret = cxacru_cm(instance, CM_REQUEST_CHIP_ADSL_LINE_START, NULL, 0, NULL, 0);
 		if (ret < 0) {
-			atm_err(instance->usbatm, "change adsl state:"
+			usb_err(instance->usbatm, "change adsl state:"
 				" CHIP_ADSL_LINE_START returned %d\n", ret);
 
 			ret = -EIO;
@@ -396,6 +396,15 @@ static ssize_t adsl_state_store(struct device *dev,
 		poll = -1;
 	}
 
+	/* cxacru_poll_status() below dereferences atm_dev, which may not be
+	 * set up yet; reject before poll_state is advanced so that
+	 * cxacru_atm_start() can still start polling once it is.
+	 */
+	if (poll == CXPOLL_POLLING && !instance->usbatm->atm_dev) {
+		ret = -ENODEV;
+		poll = -1;
+	}
+
 	if (poll == CXPOLL_POLLING) {
 		mutex_lock(&instance->poll_state_serialize);
 		switch (instance->poll_state) {
@@ -481,7 +490,7 @@ static ssize_t adsl_config_store(struct device *dev,
 			ret = cxacru_cm(instance, CM_REQUEST_CARD_DATA_SET,
 				(u8 *) data, 4 + num * 8, NULL, 0);
 			if (ret < 0) {
-				atm_err(instance->usbatm,
+				usb_err(instance->usbatm,
 					"set card data returned %d\n", ret);
 				return -EIO;
 			}
@@ -490,7 +499,7 @@ static ssize_t adsl_config_store(struct device *dev,
 				snprintf(log + tmp*12, 13, " %02x=%08x",
 					le32_to_cpu(data[tmp * 2 + 1]),
 					le32_to_cpu(data[tmp * 2 + 2]));
-			atm_info(instance->usbatm, "config%s\n", log);
+			usb_info(instance->usbatm, "config%s\n", log);
 			num = 0;
 		}
 	}
-- 
2.43.0

