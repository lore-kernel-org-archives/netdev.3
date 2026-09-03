Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9424E8DE3
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454233; cv=none; b=QNNNGFEnCII59dDV1YwffHOvoHo7ym00PTpQ03mefz+FtPQcY/j/9ExyLavAtEGBLgHoMMLkhJnzDtLGK2oZIvf7BoTtPktbAbd09JeFI3ibPKv+TwTOc84rl+XxgP8rIxEHkv+f04tbWalD/dbPS/ZFaVZ/sbNIVZ+qqsyXzNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454233; c=relaxed/simple;
	bh=WIYW1hFseBhkom1HpovCX+6HMqEApH6/wtHvd3IL/Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HyIHPko30ELpKS21iGTKhyBeu9sMPslJYTYdT8NbEAjVxplHa3kqh1WJMS/jRMsPZR3pB6sFf1egq1JXpRcQbZeiAtIpDOqG6f3rRSLZ6owgr0Pxrti/iK6DkS70v3BN4pnY4QxcsylcwBWoTNPfVw9QyJTYaqU0i13XVSlJuEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojvU+YMd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojvU+YMd"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-482f9309813so77260f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788454230; x=1789059030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9P1PcfnFpiawXqi46+lwtTgAUutr2k9gbd+NE4dCYww=;
        b=ojvU+YMdFfVuFj2nIbfVOEwsGgEhz3qwPFA/lOM+gORChQwQkaEEEhcehBAiRfUkQ0
         CLwP3HBGAsip2UVnmCmy6VEtPmmQ/RYeEaWZpkiweEriVsma9RpqY+zaDqXh8Zu71LSX
         U5qhYLlf4vAm2U793ereSdb4AIgaYH3SdQXbTwWCm0SDRAbSPQT8OrXqy2Gf4Z+nQlmj
         anlcMMHJPm9/KecATx4Wv9jmhPuX2TnF9c3jR4Yin5t9fsNinS3igS8bcG+tXsU/x/f3
         RfT5yv4dWBL7ae6hHLaQnxhAM+8159CVwJSnXeXvKcEYzZMIstyP8b8E/P1VxlLKA8I7
         tmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788454230; x=1789059030;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9P1PcfnFpiawXqi46+lwtTgAUutr2k9gbd+NE4dCYww=;
        b=BhqxzQwmwtnHRzI4Ya6ReZ2CJFxudjHzAn2Ks6gCcyRj9ZFSLoMwXdVnGG5yRpM5ro
         QvIhBWEVr3NHriWXPcD43qK5IY1G/e2XIupvmDYlocERMpGeP+uiqPnCVAq/+TZ5LC3p
         9SeZit2hxoZLSm4ODKQrUFcPYf9iLFdFvYU2Leo6/a+yzzJPC9WdQ9X6O0yoeFhHVsLd
         ajuQ0Lr1O+1JNI00gFNSuvEw6m1kaIvZgTZoTL07ztTgjy0W+LRC3Yud8JFoWIL4HYov
         fJDilEkle89SuaK+15pktDPsuX0JM/DUy7240VrhnK1hpMYm9zxTWfswIS7/w9DheIcq
         rv1Q==
X-Gm-Message-State: AFuF++ltAU73ClgNfKVqU8kAdxRVp2XcjPqpSQz9HZeBXGI3/YomYWUz
	qqxFCC6F+Bie/kd+HqTZyRv/OTjzMvDhjqBNwefIWrjQZW+aF1CDE4FJKPSpRoJUbgk=
X-Gm-Gg: AYBFou1XhPZjMmCcWjVqYLdlrUSQbOIo6XMYIUl6q+IsQv/DtFDyGYsfx2TBETKCypw
	vLtE/u329MPhzb61RrH4dH1jMoeMYbLZo51BzN2SqMuffhkCfFRxbN5Ic9UTEkoiggtVcTmiZfc
	n9eIxfjJiliwyCYNdki3a4KbpoUcBAkxMdjMld10n6/PivOT0wQnRgMe3CAbuFd072d1oYsxy9l
	mXpQw7uo+qhgfcfuFsps2/TKk7QhFGSeCaJ8YAy0GlKYqmyXvUgnwTXmlPmWuygpVoRP9pNWTN6
	+VIbWmEHCLxdFEe2gWL2lr6rXNmPQC1rLsG0rLutaS/JEc1aXzXjo71jm7w4BxS7vZvdezQP1yi
	wy3V+zw9EHZ+PbcLYNuYTWdR103o34F5XogSXovrv6cycmeg57F3jo+mmTgmUSGtGlweHfpzN2t
	Q0iy4iVBalPEWPXrMiU7hFCHV4oVtMlkhoLkr3oCG3xw86R4Du+csPFIAhZA==
X-Received: by 2002:a05:6000:46c7:b0:485:847f:fd97 with SMTP id ffacd0b85a97d-485870914ccmr561197f8f.4.1788454229792;
        Thu, 03 Sep 2026 09:50:29 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e7fddbsm14470014f8f.11.2026.09.03.09.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:50:29 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: netdev@vger.kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>,
	syzbot+1e3df0852e82c21ca418@syzkaller.appspotmail.com
Subject: [PATCH] nfc: llcp: fix slab-out-of-bounds read in nfc_llcp_wks_sap()
Date: Thu,  3 Sep 2026 19:49:39 +0300
Message-ID: <20260903165014.497490-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

nfc_llcp_wks_sap() passes service_name to pr_debug() using the %s
format specifier. The service_name buffer is allocated via kmemdup()
in llcp_sock_bind() and is not null-terminated, causing
__dynamic_pr_debug() to read beyond the allocated region:

  KASAN: slab-out-of-bounds Read in __dynamic_pr_debug

Fix by using %.*s with service_name_len to limit the output to the
actual length of the string.

Reported-by: syzbot+1e3df0852e82c21ca418@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1e3df0852e82c21ca418
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
 net/nfc/llcp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index cac1b5487064..fda236e4d9fd 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -341,7 +341,7 @@ static int nfc_llcp_wks_sap(const char *service_name, size_t service_name_len)
 {
 	int sap, num_wks;
 
-	pr_debug("%s\n", service_name);
+	pr_debug("%.*s\n", (int)service_name_len, service_name);
 
 	if (service_name == NULL)
 		return -EINVAL;
-- 
2.55.0

