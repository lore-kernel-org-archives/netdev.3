Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790732941A
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276448; cv=none; b=uMgMZ0j5DfPovs5QlIiVgZfOWMER8BvaHD8S9PtPVYDh3S1jz4JVSsqLjEdC6QaR59v3quMwC2oxqh3RnKI9+h0DZXwcdKg4oSez2AgzRgFItIjiGA34uA2pFFRLKRZw4X7q6zI57HEY7QFJkkJWKaM9cxKZiia14joYpWrryWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276448; c=relaxed/simple;
	bh=GCaSfTxYhIVhXVN/pYobjhk2blhEMEHesKJ+mWBsncU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9wtpEj2ypNac6rysJnLQY9/NT+Qzo6pVkL3jXwn5g0QFErGpKU9GXwxi3ENL2eZfOo9z9EU8u3rUXKwuRJo5Stk7k8Q69kJNWnOE7EfVg1pgRK6l2+ZkCwLhns4A7Uc48uwKACujPK+UQTU84E/JVgMxUd9ONYq+5nyyjUV4z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJSvBbOq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJSvBbOq"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f365afc5aso3283100f8f.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 01:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784276446; x=1784881246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=obdd0SmjDbePrgaCTtUb1ov2QIwtkiLcmDHoVSpucnk=;
        b=lJSvBbOqFNy8UZrACCu3ygIsyyyGX/Vu4k6LzoRJ8YkrM5rWxWVbCRB87E+L/PLsnJ
         Kvm3IA2bS1dTLQz7xnOx0RzFX/L3vjkS9GfTT0S+9lSFqgQZxSmCXuSf8+4a8N8+6QRG
         osPRPP8v8pEgycqK4Fh4sM8ux5fXYho++dyGOWUjW6kgxgyXLbfCB2e6CTygVjvWnr53
         GYmD8vttCjSyHD67khmOF3BK4mnBr8DBpibPS1TQoRLAt6uYQVCCWQSOjNh8C7JhM2ip
         +QAP5lwk/GIC21XoIbv2SJ2Rjrir93Or7M64bKMTtcj9qwUz8JRs7kGuwKc0oY/AUNoC
         i+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784276446; x=1784881246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=obdd0SmjDbePrgaCTtUb1ov2QIwtkiLcmDHoVSpucnk=;
        b=keTWVCUW2ZIj68MnoQxlNKytAxF+6ci2LcAdHtyKTsJfjZvRXcWg4n9mUvxr5SbIf6
         1Zr0THxYZY9KAbxp9kZTDIgi1rN00EBQn6i4EERCHpF4kne+3m8fMM9HM8pxmODps1SG
         9BPCwEv/Prl3VBGcplPQOA4tkVV5Qvn5dhKR8y9N7e903SDYMXJBsprvynogzodvWmP/
         I0MZjPwMM/C8qkAbnDVs+vRVgHpS/hElcBx6UIklAnmWxFErewbnumMUf6srhWqQmD2A
         w+Q5NqFrVdBzNDJORp/0zkd1oLAhhcMV9y02Rn3Fkxzhw1Om4oTVPDNgMTe7BBGGUbu1
         Xj5Q==
X-Gm-Message-State: AOJu0Yw/anlhDr94VPT4i2teyni3im82oef21WZCEt2QD2ocADXiMnac
	JdJTy//CC0iuwLN/byiq/xUsN7lqUNlemwiXPUD6jo1GIsEsLmnFvx52
X-Gm-Gg: AfdE7cmyIQ8n4yJELgvEBkjfV1fuqCdj13y99p3glTIv84qdm9xHrIQjWs/ZXzlOrTe
	CMErK+479W760DsWrMbVSNy0Ylq18gs+3GcYYHGIGtTeZWgKnbAXQ66o03yZ1ey8QVdTq1fcDhd
	sX3tdWYiIH45ibW9h9ZQozA2IfaeB0Y1yHvbz1kupjVSaJ2WiZkxfgQE0y7YM6i7cperK6ATpIn
	CMI2jJGSonM+agKQHSHFG63Uaht8cjNGUN6q4Hl16lz5KoLJd/Uwv2gFg4J8yZ5RCaaV0vx3CUc
	yhMhNGEm0tyixFDdkR8iv6JxHYK+x9VkKkBD3d1Oo7tfxH1QGa9ycGgA6a/9aSWnCFb0nZhru3p
	RUvPOx6C6GVDnZkPAeBaYZQ8A1CLUvEXDiYNSbbau5zGHH4RcoWbGmgx8n/gTKY8/3pCpW5WVhX
	cZopO1ezWD3J0O9hGH9YxkAQ==
X-Received: by 2002:a5d:6f16:0:b0:47d:ec60:658e with SMTP id ffacd0b85a97d-47f62313766mr2079945f8f.25.1784276445325;
        Fri, 17 Jul 2026 01:20:45 -0700 (PDT)
Received: from labdl-itc-sw10.tmt.telital.com ([2a01:7d0:4800:7:c817:c1b7:3e78:551a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e499c2sm1671314f8f.4.2026.07.17.01.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 01:20:44 -0700 (PDT)
From: Daniele Palmas <dnlplm@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH net-next 1/2] net: wwan: add minimalistic IOCTls support also to QCDM port
Date: Fri, 17 Jul 2026 10:19:34 +0200
Message-ID: <20260717081935.2071083-2-dnlplm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717081935.2071083-1-dnlplm@gmail.com>
References: <20260717081935.2071083-1-dnlplm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upstream libqcdm requires IOCTLs support to work, so add the current
AT minimalistic support also to the QCDM port.

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
---
 drivers/net/wwan/wwan_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ccce2ad74128..8168239e52c3 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -1046,7 +1046,8 @@ static long wwan_port_fops_ioctl(struct file *filp, unsigned int cmd,
 	struct wwan_port *port = filp->private_data;
 	int res;
 
-	if (port->type == WWAN_PORT_AT) {	/* AT port specific IOCTLs */
+	if (port->type == WWAN_PORT_AT || port->type == WWAN_PORT_QCDM) {
+		/* AT and QCDM port specific IOCTLs */
 		res = wwan_port_fops_at_ioctl(port, cmd, arg);
 		if (res != -ENOIOCTLCMD)
 			return res;
-- 
2.43.0

