Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE834F270;
	Tue,  8 Sep 2026 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851766; cv=none; b=KLY782t8WZM0gpK6uVT+GrhpLC6QcKWGL1F2cnUmawtMXuDTdwF4vEQNgrZeBRq6xGzNlZbOCljLAJnpCxgiyFSlCMuL94poJtOjtwowY0T/4ZqGPymMn3NXLRn1L3W0XijKgdtFmN8V9l265bUuM1rgDnXsJ/3M2kODaELVYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851766; c=relaxed/simple;
	bh=qI6Ayf5wPgUTQ4/qNmGJZJVRLZrlzPExqwImPy4y9sc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AAlJyJa9m9J1iYtsoLisR+IDSXVnQO9UMz0ELGtqkwK/2hBUJCNQ1TsI6Xt+RPN/usECY8cqQVGCcbe1BEwvYY/8K3XWsAvDbY1xEBRd31FENmmYetkLOgZshlinwtVbd0MyXPyJjvtOcq9oZvavBfvE2pbkBSNHyE1O7poXiUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6FZnP5S; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6FZnP5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788851764; x=1820387764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qI6Ayf5wPgUTQ4/qNmGJZJVRLZrlzPExqwImPy4y9sc=;
  b=E6FZnP5SzB9SwamCMvmiSNyPjnWzeSQwUrVMTK2o4RY/MbNr62s9Md+w
   rzBnuNMDCZ1WbrvS7q3vKAX5qlXyU+C/lvMVTO93kOiRuyIUZtNmnBQmq
   OXO8uPTMfO/SnR3Y8CxCPp01v9BljN0XVk3x8MpJzeXKAzLkOnP1EdLgf
   3j8emcCJ/c7t2wT2qFdOA38wpmqS1CJp0egTJ4Mk97U1oAwh7YB05XvSO
   MSMLqt03OkGscUJHRXkkrfl0zWBfi5iZNE22KZqsSpCfuEWZzvGp/d8rY
   2pPdwlVa+NFd33OtmceL7E3NLqYW7bTobo6bp1r/lu1T/PWgoqkiEO5Dr
   A==;
X-CSE-ConnectionGUID: FOEJGA3ySDKd9xYYBb7jzg==
X-CSE-MsgGUID: jKJNh/vpQZC+TLqBiSW2Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="106760034"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="106760034"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 00:16:03 -0700
X-CSE-ConnectionGUID: y6PbfSSUQ82qjZZlHsLGmQ==
X-CSE-MsgGUID: CrhCmLDgRvasFm0K9a323A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="274699573"
Received: from qat-server-366.sh.intel.com ([10.239.92.87])
  by orviesa004.jf.intel.com with ESMTP; 08 Sep 2026 00:16:01 -0700
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
Subject: [PATCH v2] usb: atm: cxacru: fix NULL deref of atm_dev on sysfs writes
Date: Tue,  8 Sep 2026 15:02:03 +0000
Message-Id: <20260908150203.2119844-1-jie.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f3ef0a67-79d7-47da-be6e-7e82d92e68fe@mail.kernel.org>
References: <f3ef0a67-79d7-47da-be6e-7e82d92e68fe@mail.kernel.org>
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
usbatm_heavy_init() only waits for the heavy-init kthread to start, not
to finish, and instance->atm_dev is assigned later, in usbatm_atm_init().

A write to either attribute in that window passes the existing
"instance == NULL" check and reaches atm_err()/atm_info() on the error
path (and, for adsl_config, on the success path). Both expand to
instance->atm_dev->number and dereference the NULL atm_dev.

Fix this by logging with usb_err()/usb_info() instead. They reference the
USB interface device, which stays valid for the whole write, and
usbatm_atm_init() already logs this way before atm_dev exists.

adsl_state_store() also calls cxacru_poll_status() directly, which
dereferences atm_dev via atm_dev_signal_change() and atm_dev->link_rate.
Return early from the poll when atm_dev is not yet set.

Fixes: e605c30977bb ("USB: atm: cxacru: convert to use dev_groups")
Reported-by: syzbot+9b195c4f412ea5c4e56a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9b195c4f412ea5c4e56a
Tested-by: syzbot+9b195c4f412ea5c4e56a@syzkaller.appspotmail.com
Signed-off-by: Jie Wang <jie.wang@intel.com>
---
Changes since v1 [1]:
 - v1 gated on ->atm_dev at handler entry, but that check is an
   unsynchronized TOCTOU; remove the ->atm_dev dereference from these
   paths instead.

[1] https://lore.kernel.org/all/f3ef0a67-79d7-47da-be6e-7e82d92e68fe@mail.kernel.org/

 drivers/usb/atm/cxacru.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 75d87c31e81f4..4322553f2902c 100644
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
@@ -481,7 +481,7 @@ static ssize_t adsl_config_store(struct device *dev,
 			ret = cxacru_cm(instance, CM_REQUEST_CARD_DATA_SET,
 				(u8 *) data, 4 + num * 8, NULL, 0);
 			if (ret < 0) {
-				atm_err(instance->usbatm,
+				usb_err(instance->usbatm,
 					"set card data returned %d\n", ret);
 				return -EIO;
 			}
@@ -490,7 +490,7 @@ static ssize_t adsl_config_store(struct device *dev,
 				snprintf(log + tmp*12, 13, " %02x=%08x",
 					le32_to_cpu(data[tmp * 2 + 1]),
 					le32_to_cpu(data[tmp * 2 + 2]));
-			atm_info(instance->usbatm, "config%s\n", log);
+			usb_info(instance->usbatm, "config%s\n", log);
 			num = 0;
 		}
 	}
@@ -827,6 +827,12 @@ static void cxacru_poll_status(struct work_struct *work)
 	int keep_polling = 1;
 	int ret;
 
+	/* adsl_state_store() calls this directly, before the heavy-init thread
+	 * has set up atm_dev; bail out rather than dereference NULL below.
+	 */
+	if (!atm_dev)
+		return;
+
 	ret = cxacru_cm_get_array(instance, CM_REQUEST_CARD_INFO_GET, buf, CXINF_MAX);
 	if (ret < 0) {
 		if (ret != -ESHUTDOWN)
-- 
2.43.0

