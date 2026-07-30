Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD89F335064
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442316; cv=none; b=cQCtjbXRwlYXSjaz2WkGc+2CnRHM4iP/mEPs3ODMNlnBKS/pB2g5j/0VIcvB9yHVAo0eKtToO6ZnXb/S21sYFqysvSCq4PUZrK2q0LUJ3FPbgCJ4JI1jXM/AlxcCE5XU+UzP/o4JsEOCIlbadtb8nvAAc6tFVBkPiaEGxjwnREI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442316; c=relaxed/simple;
	bh=ZdvgeoWh2TerW5rE/vqKIpMlNmv0bCF+vIbf9z8+9Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=leqqZ8PTqIA3dn6PF+WMNHXM8rZd96I6ji77Kqmo/b7l9UN9ffozAtQh7aWVq6J5bSmciMR22XjBPqA8Etzc082ncMVF5T/RsFvLhwbYEu9zucX2jzwixyLVOL+DkwoAWZp8RvyUdIEvZWDZe72Mj3752759/MQMMxh0BZjfV0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLvLbPlT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLvLbPlT"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84861fc51f5so259947b3a.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785442306; x=1786047106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W7nssRnI5PbZKyunLFrMTG5kzkBNYctSVirvyP8FTcY=;
        b=FLvLbPlTZGHeA6IkbXCPJhDPieVDpLmcH2m7gQubPq6BMmoTK/RqhrPaZB7QzafEnf
         3EPIYSnCXuxvlgtjh813EyHxw8dos2Q/2+nzLBnt5T0oiJ8aMcSaovp2xyl/ZvySGsKX
         BFmGPbCgh/tZf7uFYmBpR8SFFQ2st78hX/T63X2d23JzVAxTyT/DK0Jpgjhuj+riyDTu
         9Pdyv3n9iGsPaxKyis0NVhHMuS6ccShpWeu/EGqlKILAsWycedraVQBPikHc7zno+V9m
         wxiHDRu2rb+feGZI3mSX2icOMVa3yAXfTHgyL3ZjiEwifhOYOCkDuzWLe/Y9h/nJZLaT
         4c/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442306; x=1786047106;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W7nssRnI5PbZKyunLFrMTG5kzkBNYctSVirvyP8FTcY=;
        b=J3LWH1By4s7UXC0KrX7tB9rCwpFEhNwIR1UXgUXAHSeIUrLv98S8oOUIKgHteseON1
         3miDSVNEQQRBTAyVEv9LZxhYITWp1yQDc+EBS2ASn2HKVGYT5i+GT+WMG4uLuwgXVBR8
         95BMnETtpWmddBvZYcqGDahJnElk+dHcypvvG/uxQdbWdxqZmsJV4APq54i8edvZ8PfQ
         fAPCXgOvroW08x19NAIlxTZMJc/ssI/oWufHLzQebPOZf539EIqdU8cesXHJprlD9Rma
         3oBxaTKKCMNwh4sJsazxjBNSwAvXftADEU0LTPPRTK6onKGZ3hPZpCUnuBaOocEi+aw3
         HoNA==
X-Forwarded-Encrypted: i=1; AHgh+RrsQO0Yn+6WDTHqRYTBc/HRk4rM80BFi/UPWILM+BVlUkqYkxjgbWnG1hU8AUk1KIFmwNu6rZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJ2FBnY1J2MvhXIUr5Zxc4Nx+lbvwzrHUWO2utRxY2Nk2A1D3
	tpJpXYtxoudi2rdXcxqLoSJQfScT48CQHQFuTTbxgB9fajc9F9a9SwPX
X-Gm-Gg: AR+sD13f2PJ3yVpGZG6Ob9hqeTTC6+3gAKJSTz6CZGpH1IENveZD/J2KloZrQvgpOvG
	Y1MAjHo31H8pFIzHolAzzVGKDGAmL8EJNXYqdmjsLywUSR+aaHN6ZsphlISBJ6y4yTRxjRsYzqB
	D/cVScZRYuWVxnAhNE5ZAGxcNMNePyWfXv8hVWLRfixe7IWpe/me6R79seXfzoQYHmPjogxDaEN
	Ftoe5zLFYS9erRPFqI8CangPTp7JdvmSMPrthUjs/wIaMIeSW5owBEr7fmr9VDftKPKEJOcYzBA
	qY59HjAT0RJ5iurMH2bu8VGi18nTHu+g50jBjfD5MMjDiPJt2RbbPSBaYfKHJGPGDtlg88Di9d1
	oYum017V8XDcz+9ufRyUKsSIcxL4V5lr6WMsJWiPbQj18dNEobmXimQIaIoLtkIYPIFobhSLif5
	BxfhPVGR/9iY1HQcrgE9TLWzm0Al/6llmtQbyFJMYjcZfrcDg0/zCwgimreq0nE+GtI2H3afcN2
	V2QeX2o+XlIoUNoWk8Yv/os1brIg8UUO1dvAj1NMnE=
X-Received: by 2002:a05:6a00:1741:b0:848:5b1e:aec2 with SMTP id d2e1a72fcca58-84ebc3e39b5mr3714867b3a.54.1785442305476;
        Thu, 30 Jul 2026 13:11:45 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:11:44 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@kernel.org,
	ssengar@linux.microsoft.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	sgarzare@redhat.com,
	horms@kernel.org
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [RESEND PATCH 5/6] scsi: storvsc: Remove support for storvsc protocol of old Hyper-V hosts
Date: Thu, 30 Jul 2026 13:11:22 -0700
Message-Id: <20260730201123.1767-6-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730201123.1767-1-mhklinux@outlook.com>
References: <20260730201123.1767-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the overall removal of Linux support for running on Hyper-V
hosts earlier than WS2016 and Windows 10, it's no longer necessary
to support older storvsc protocols. Remove the support and associated
special case code. However, support for the protocol for Windows
Server 2012R2 and Win8.1 (protocol version 6.0) is *not* removed
because it is activiely used by HvLite in the paravisor for Azure VMs.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/scsi/storvsc_drv.c | 53 +++++++-------------------------------
 1 file changed, 10 insertions(+), 43 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 571ea549152b..095fce47c5f1 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -47,9 +47,15 @@
  * V1 RC < 2008/1/31: 1.0
  * V1 RC > 2008/1/31:  2.0
  * Win7: 4.2
- * Win8: 5.1
- * Win8.1: 6.0
- * Win10: 6.2
+ * Win8/WS2012: 5.1
+ * Win8.1/WS2012R2: 6.0 (also for HvLite paravisor in Azure)
+ * Win10/WS2016: 6.2
+ *
+ * Protocol versions earlier than Win8.1 are no longer supported since
+ * Win8.1/WS2012R2 and earlier hosts are no longer supported by Linux.
+ * But protocol version 6.0 is retained since it is used by the HvLite
+ * paravisor in Azure. The #define's for the earlier versions remain
+ * for the historical record.
  */
 
 #define VMSTOR_PROTO_VERSION(MAJOR_, MINOR_)	((((MAJOR_) & 0xff) << 8) | \
@@ -218,7 +224,6 @@ struct vmscsi_request {
 static const int protocol_version[] = {
 		VMSTOR_PROTO_VERSION_WIN10,
 		VMSTOR_PROTO_VERSION_WIN8_1,
-		VMSTOR_PROTO_VERSION_WIN8,
 };
 
 
@@ -1601,13 +1606,12 @@ static int storvsc_sdev_configure(struct scsi_device *sdevice,
 	sdevice->no_write_same = 1;
 
 	/*
-	 * If the host is WIN8 or WIN8 R2, claim conformance to SPC-3
+	 * If the host is WIN8 R2, claim conformance to SPC-3
 	 * if the device is a MSFT virtual device.  If the host is
 	 * WIN10 or newer, allow write_same.
 	 */
 	if (!strncmp(sdevice->vendor, "Msft", 4)) {
 		switch (vmstor_proto_version) {
-		case VMSTOR_PROTO_VERSION_WIN8:
 		case VMSTOR_PROTO_VERSION_WIN8_1:
 			sdevice->scsi_level = SCSI_SPC_3;
 			break;
@@ -1703,28 +1707,6 @@ static enum scsi_timeout_action storvsc_eh_timed_out(struct scsi_cmnd *scmnd)
 	return SCSI_EH_RESET_TIMER;
 }
 
-static bool storvsc_scsi_cmd_ok(struct scsi_cmnd *scmnd)
-{
-	bool allowed = true;
-	u8 scsi_op = scmnd->cmnd[0];
-
-	switch (scsi_op) {
-	/* the host does not handle WRITE_SAME, log accident usage */
-	case WRITE_SAME:
-	/*
-	 * smartd sends this command and the host does not handle
-	 * this. So, don't send it.
-	 */
-	case SET_WINDOW:
-		set_host_byte(scmnd, DID_ERROR);
-		allowed = false;
-		break;
-	default:
-		break;
-	}
-	return allowed;
-}
-
 static enum scsi_qc_status storvsc_queuecommand(struct Scsi_Host *host,
 						struct scsi_cmnd *scmnd)
 {
@@ -1738,21 +1720,6 @@ static enum scsi_qc_status storvsc_queuecommand(struct Scsi_Host *host,
 	u32 payload_sz;
 	u32 length;
 
-	if (vmstor_proto_version <= VMSTOR_PROTO_VERSION_WIN8) {
-		/*
-		 * On legacy hosts filter unimplemented commands.
-		 * Future hosts are expected to correctly handle
-		 * unsupported commands. Furthermore, it is
-		 * possible that some of the currently
-		 * unsupported commands maybe supported in
-		 * future versions of the host.
-		 */
-		if (!storvsc_scsi_cmd_ok(scmnd)) {
-			scsi_done(scmnd);
-			return 0;
-		}
-	}
-
 	/* Setup the cmd request */
 	cmd_request->cmd = scmnd;
 
-- 
2.25.1

