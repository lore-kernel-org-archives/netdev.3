Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578284;
	b=kVBkcVlaXtsvZ9xv5Dxh4Qu6PptvHO9m6F2zQF4l6f4tR3QhP2+Zqg+h1E3Tnf+VKRpd
	 Te1eWypvM4dB9QhNou9/AlELdiQVReyMXek7Zi3hUKH8b7S4VKOt+PxqLTuoDgNJx8j3v
	 lJ8vHd6VSw++q79SSsBY76LTRWCVFyh8BPhPBC8wIY/ilKTXyikTKavuy0UCX0hMzgC3M
	 LsrtUIv/bKucSL9WMxoyGZzU0DjplQnZStISvri++28LPmFrvlF4efywfHfugxKIi0OD8
	 0yE5JjmsI3kwimeP9r0jadngH4VgWwTYGFinj42govxQqk6qnVC/giXEar2eMhx1GAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7VWjf8n3WvDFh+c5IGrcgvXEjMEwnWf0FFeeKq0U6ZQ=;
	b=UgJqjskOnWUBYEYVwdpCiZixRIIw0RDBT9grnccMCQG6cJPecjSW6ImGz2TZZd84b3sB
	 006pkttMMRs8vgDDa5oGqDrrJZNgdv5bqqclKojH3G28BuN8Mjxu7P5pjZutZFy9XJlv0
	 B263X7ouA6lkSMpGNc5AKik0enn9JpB8PbVSbFGOKCYsme6/+QysuA9nz7gC5FXz5EXZP
	 wYLXfSBOnDOIIBHl1ucZmSw2FILkbSxIco2XDXnU6ugjPp89Xa+lc0zLN2DMVCiYc3jR0
	 vcIqEqwuHBakQSAyYwGz4kksYEx16OpsR32V8Xx4M+sjsxdklRVLUDsPS4RZEBVi/5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PKfEHFCL;
	arc=none smtp.remote-ip=74.125.224.130
Received: from mail-yx2-f2.google.com (mail-yx2-f2.google.com [74.125.224.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87421606A334
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 00:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87421606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PKfEHFCL
Received: by mail-yx2-f2.google.com with SMTP id 00721157ae682-8b0fa446a94so7789037b3.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 16:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793578282; x=1794183082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7VWjf8n3WvDFh+c5IGrcgvXEjMEwnWf0FFeeKq0U6ZQ=;
        b=PKfEHFCLO1Pa2cwXivsCSQUdhT3MH+Xe7A3u+cpoivfmVBg9GYcp8AE0qcJZBBGoDc
         bam19pUfhjf2sypZHGXLnDnzzLLFkiHRDJ2JrbFWIBDrnMU8+KLHlbvlac6gBqGpS8PK
         VjTIPr38Ne1OrzcRdeexT9SZUpjf9StVawHOIAsvPwBAPD178q4dfSjmYiT1V2HeuNDv
         wMqt+T292rulJCMlY28IbN1LdqKuqRCbmtK274uv53+uYBQnkRGOK/+cOAZliSvqw2Bu
         wO+bk4An1XRZmuugQaTUteNyk6uz9rZCdAuNmi3JnnYXV49oUU86s3kt57f56JxxabRn
         OjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793578282; x=1794183082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7VWjf8n3WvDFh+c5IGrcgvXEjMEwnWf0FFeeKq0U6ZQ=;
        b=XTskzG4zzknwZ7Q3Q0legQD2lr8soGcmlufSY8MViWFvd5Kxi0gpBICur47piPYPg4
         l2Q1NGXV7thyTDcqHSj8CkTvbDIjwasCnhmZCSfuhkBPlYQ+IvVCQ7VBgDmrSMCrmb4W
         SQqjoqecqtpr/KyZSCG0X7D0t0K60nFp5rQr4pw3Z2uT68RAMUAROxcsI/StqL1gDcrd
         j7kohC1aZU3ht+/zqm9KpdzNaSEFT+v8hLL3QUOl9l4yxHL1oeA2YIZTv/K3Bs3M/X+C
         lMGZs6QmrBGm5ilkkWaaDTUjZf43rLz4UJBLZUC/w6DSnx3WhfIdl1P9MIln8Qp0inM5
         FkiA==
X-Gm-Message-State: AFq9FYKjvWjRaaaJh4P5MpJbZg9iLB77/a/sPMwaDsciFgshH9ogjj3E
	ujoDI8Uw6YaJeasi+TmGZEKRoPKdknBi6FA6V05/++MyNHLViWv+hB0RIW+mSBzO
X-Gm-Gg: AYBFou0CVRQV7cguioz5CJIm+hx4cpRYjyVDLOsSD4VutOPH52DidnN93GKzng4ZXZK
	2hFBHBiM13IrfkDm6dz+m9wnjAhNXxM7iKQ0cinDDE346km4tL64QnTZRx0Nx3hMiiaaLvg3/1G
	6fWjUSiUPAFUm9C4d5fBpHRix+Pa8YdrNgnKr/I9nqmdgO8FHtApLYXcnHMRs42yoVNofoIxQM1
	u8M+AT5QYRHV+v7NrqKfTLh2ItRPn9+vmBnc8Y5L+gQlvTpYUef5domPrHiwlXTl3ClFqDHE89U
	ZhNuv3Rx/Y2brr3Q3dbL/uAD5up+nB02r6yEYsWWmDDtQVfl3JB76ApC6OMhQ/vjOZRKYFPsYpQ
	Nwyrbp+eiML+kjg98V2YPSEhHAuQp2VVJySxvYulrxni+Z0z6VsBN7+jjWfdHb8yh2OepqhCTWL
	nQtGrWldCnXk8AiwLjQZGAUCc83QTMjnIPzAiCzfKjWeKhRZWtm9k5gVRGoBfccd/5YUGKbCsfq
	rsTCIxh6Dt9yOkFb7LYVdqa+jhGLguoxMS5+jGPJaybc86WTmZ50sqGlKgYCBt6elOto7psXO5i
	NCH01eqxL0jifv9XhjTx9FMtHaGXfMZwstbEkvkXIiZ2HRZHaX8J13Qj2vWW06A6PFtQGrmmlUh
	/+b496Dk=
X-Received: by 2002:a05:690c:6e87:b0:8b0:ea29:c543 with SMTP id 00721157ae682-8b2b658dfdamr48293017b3.10.1793578282295;
        Sun, 01 Nov 2026 16:11:22 -0800 (PST)
Received: from Xinshengs-MBP.attlocal.net ([2600:1702:7d20:7d20:90c2:3933:d321:134f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b714bd57sm43161587b3.23.2026.11.01.16.11.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 16:11:21 -0800 (PST)
From: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	oliver@neukum.org
Subject: [PATCH net-next v3] net: usb: cdc_ncm: reject short GET_NTB_PARAMETERS responses
Date: Sun,  1 Nov 2026 19:11:14 -0500
Message-ID: <20261102001114.38144-1-xinsheng.zhu.ny@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usbnet_read_cmd() returns the actual transfer length, but cdc_ncm_init()
only checks for negative errors when reading the NTB parameters. A short
response therefore leaves the missing bytes zero-filled, and
initialization continues with parameters that were not supplied by the
device.

CDC NCM 1.1, section 7.2.1, Table 7-3 defines a 28-byte NTB parameter
structure. The pre-errata structure also contains 28 bytes: NCM 1.0
Errata 1, Issue K.

Require GET_NTB_PARAMETERS to return the complete structure before
continuing initialization. Return -EIO for short responses, including
zero-length responses, and preserve negative errors from
usbnet_read_cmd().

The issue is theoretical and was found by manual inspection of
usbnet_read_cmd() callers with LLM assistance.

Signed-off-by: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
---
Changes in v3:
- Target net-next and drop the Fixes tag, as requested by Andrew Lunn.
- No changes to logic since v2.

v2: https://lore.kernel.org/netdev/20261011035150.53315-1-xinsheng.zhu.ny@gmail.com/

 drivers/net/usb/cdc_ncm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 19db5a668dcb..5715c4bf732f 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -524,9 +524,9 @@ static int cdc_ncm_init(struct usbnet *dev)
 			      |USB_RECIP_INTERFACE,
 			      0, iface_no, &ctx->ncm_parm,
 			      sizeof(ctx->ncm_parm));
-	if (err < 0) {
+	if (err != sizeof(ctx->ncm_parm)) {
 		dev_err(&dev->intf->dev, "failed GET_NTB_PARAMETERS\n");
-		return err; /* GET_NTB_PARAMETERS is required */
+		return err < 0 ? err : -EIO; /* GET_NTB_PARAMETERS is required */
 	}
 
 	/* set CRC Mode */

base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
-- 
2.54.0 (Apple Git-157)

