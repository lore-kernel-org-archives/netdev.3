Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF5B3C7E13
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165696; cv=none; b=CMKGW9njWnWOcae6ZwTIgWM5FvxBv1kl/7e94HpFH+kfAGYX3/sw7Dx4EMrDpsvEyVhoGQ98JbkVpkJF8o3AvfI3imjcpFbZk4JDkUkMxa4CU/vdNoP1bJVK8U1X66xVwPieRKRvsGEYFaS2L5ONq7scHT236skjNdy3gg3S3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165696; c=relaxed/simple;
	bh=to6zl/n2CMI8LEhJSWsLmG+6IaLANuFS6dLWdh6lZl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c7UNPq5SLL+WUBY1Q54wnCyae4Gnby2egCxmUQxr8vtlYG8XbA3Rwj8/PdPLnWr4ud0pM/Uhuk/COLXQVgrP52TlNAI887hKelzoXQ2Y9QDeLTkR+MVtSO0RfiECOPNwt69laOSHgSYP0DyhExCF+0W0IscjeQwgZqtEYd31lkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHXWP9Xt; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHXWP9Xt"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so2358257a91.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788165694; x=1788770494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nqfdJve8Ni4RVv0b2fgjV6qAXoGzSYyxkoSoeuiqXN4=;
        b=IHXWP9Xtlg3hy0oWbqLNzxTIS7X8CestPW4oRm4nMAYsj1MGwbC2c0B+IIrw84e5Yp
         g85KtM6u9VkvFpK1CKZ+Z7oEG4gesiDVZziiPYvQbz28vQK0f4WCc7mrwdsh5BrEqJQG
         v4Rf4+JUnFvvKMzClZAjQ7V6tPHguqZ8kKx4eBBBhpZE0d81EUjsteQ0n6Y0C+e8eXZt
         03ejxkEdzIC1ymT7C5fuqf5ixGUWU+LPQTtK4xcQLIc21SL8v5mhUPZaC8O4SlCdlBFQ
         e3zUbQm+GbQs0RJI23LyVpTLKAjvUg9szcBc9JdCf04x1J6CrBse3JdEb0ccXo6Tenqo
         RjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788165694; x=1788770494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nqfdJve8Ni4RVv0b2fgjV6qAXoGzSYyxkoSoeuiqXN4=;
        b=lO2bJHKBRYbGyUO8aQcRjl0YLlX5WTJg2PqSf/nZwSy6u9ayodxIYgQLl0cvI/+Em3
         MEQ/a0UoxkYRo89B2D4vwHy6xPMyph46LWN0Wnl+j95v5RJKkSPsli8RATQ9UsgU6P8t
         bZ89wOzDhUcRgNrvLO2YHoGNVSU/KRolutlNNuQ0EFrEIxe0CLm2HlR2IIZqpl9ij3js
         CMKT4ia8PD5A2nqxOrifquAuuODISldTWC3f5IByDJ84qzKb9qlSqvEOQoX3ULvIwNAr
         bH3/aZVdg/yNqVZ6YXfdx9LlfztNCNLQKEo0ldRpVz7pEtdaLyohvvnTvFrBNmduIcfc
         Y/QA==
X-Forwarded-Encrypted: i=1; AKwUvBx9GwhahBIjni6r8Gk0bZsRGHlU8qL6tqUV8Yi5RcG0Fbtt8FzcGprtTxo6LpevQUjF5/qPb8Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mYEQIg9f9ef7rFYusByUJIuPkufzmM7AcCWKIu2RqW/301joQn
	pdbtYOZQ9lrvQ9i5kb0wbgsjKuQuyCRIF2cR8mI+SpBkBp62BBXjbnXj
X-Gm-Gg: AYBFou18jkJKyIKDad3E2oyCcmajrZW48U6VgEn2Ip3RMWxTtn8cRSwSQ29/q25zp+K
	a5b20cTZCDvwQtEVkNYyklI4m92EWf0lTBRZZV+iHxHbzAynDHhRAF1rBKC7BXKxFGreX/k4Z/0
	OM63865hbfFMzTICtjjQFyguOGz9wKgPZp7Zt0cQW0AMcQicE4FS5lm3DcPaYzjDNABG0ALkg5t
	Adj94Z3YWxGPLfz7JqwgYzhA+AzIKKNhR2eNytOv4l2IWFbni+WA+Gy7LFMU0AvtikQbr/+G0jb
	B5N4UQVDBhkulujQJhnCLEoCh5kx8vf5YIiJMi2oKzxXo20F1biLebK0E0CqlkWWtVsl6ZDB1mH
	8zMkACwaEiN284DS9u4T7TMyGEbmhzeKRHHOpL2Vjy3CH+H4mV/hpJfZIu/jdETMpkO27QZxXSV
	zduKTaJ50Vnw5PMQg78F4L2r0HDkZIUFmeNHgCL7Kj8RetWuVQa088sqbr2vTPS2gI33W92CM2q
	7H98qcQqPfFOdlk3PIIw3IvF0tNrkGD2mkge720vw==
X-Received: by 2002:a17:90b:3c89:b0:398:9be8:ea66 with SMTP id 98e67ed59e1d1-398f86c802fmr2915772a91.19.1788165694102;
        Mon, 31 Aug 2026 01:41:34 -0700 (PDT)
Received: from ian-lin-DREAMBOOK-PRO-14V.. ([2401:e180:8832:3ee7:cbb8:f1fb:c6e2:ba18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd5c34sm20592434a91.8.2026.08.31.01.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 01:41:33 -0700 (PDT)
From: Ian Lin <jisayme@gmail.com>
To: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johan Hovold <johan@kernel.org>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Lin <jisayme@gmail.com>
Subject: [PATCH net-next v3] net: usb: qmi_wwan: add Compal EXM-G1x support
Date: Mon, 31 Aug 2026 16:41:24 +0800
Message-ID: <20260831084124.65074-1-jisayme@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Compal EXM-G1x is a Qualcomm SDX12-based LTE modem. Add support for
its QMI WWAN interface 8 using the DTR quirk.

Tested on a Compal EXM-G1x modem.

Assisted-by: Codex:GPT-5
Signed-off-by: Ian Lin <jisayme@gmail.com>
---
v3:
  - base on net-next and mark the target tree in the subject
  - add AI assistance attribution
  - post as a fresh thread
v2: https://lore.kernel.org/20260828082309.12513-1-jisayme@gmail.com/
  - split QMI WWAN support into a separate patch
  - identify the Qualcomm SDX12 chipset
  - keep the device entry sorted and add the product name
v1: https://lore.kernel.org/20260828075644.6228-1-jisayme@gmail.com/

 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 8178a8758..fdfdcf24d 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1446,6 +1446,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0316, 3)},	/* Quectel RG255C */
 	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0104, 4)},	/* Fibocom NL678 series */
 	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0112, 0)},	/* Fibocom FG132 */
+	{QMI_QUIRK_SET_DTR(0x04b7, 0x8217, 8)},	/* Compal EXM-G1x */
 	{QMI_FIXED_INTF(0x0489, 0xe0b4, 0)},	/* Foxconn T77W968 LTE */
 	{QMI_FIXED_INTF(0x0489, 0xe0b5, 0)},	/* Foxconn T77W968 LTE with eSIM support*/
 	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */

base-commit: 1bb784eb6e38fd73143f021608e4ef3095d0c0d7
-- 
2.43.0
