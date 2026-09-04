Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EFB47143B
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518480; cv=none; b=Bpvc7mfJIZfYYiNA0cThtCiWBt6TonyRWu/zR/bRXq/r0rpWZdv1lxfWNiX/vos+W0NL5RW945Oh+guFirZnjNj+/Ix85kT+zynLtxZpY21udHpLPhsJUUuhBezJUBPgufgnnBCNh9tG2R9O8AO7g6/WPUprklBAeUALkm77RqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518480; c=relaxed/simple;
	bh=C0egVGKZ0zFbzyKiNRp6bfje1hZj8RkZyWrinLyZmcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGz42a80/Xj5LwmXFA8Oq0HbFovd5cgRCexmk5f0d4laOYs1PkW/FqTfgTZDthGJveAw3JFDOEM8hGuD51PN3rvQ6jh09fWyImCxhBTXv5cPp5260lfDyUT+d0pmHNaPcB+br1287fBFWRH+pAihkZhZWHYrZf80nXhxV7KPJgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUafhj7s; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUafhj7s"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f0167e59a3so581496a34.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 03:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518477; x=1789123277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Y4lvfl8K7dMiWCUbzntkn6PCAhAT9IPKbAAb6EOT0Q=;
        b=EUafhj7s/UC/qhSfQTAEf9o0CeXsy6g4Z43oRbYJe3YV2yA3ADF11M8UVSP7xSCaSw
         XU395VnOJuajfbv/Ldw2a2aqNw3X+R7bDoJ/0r3m8cmL3Yo0h21yWGX63KRW684HZr5O
         S2+MuoSi1hoLGyzeLZ80ysoiIVkEkMBK1O+N4/RryE+XAPC6xD+KjFijhxOyMZ9pjtJd
         KyB6hv7PCGmIYpepru5YQZKkSyN4FFIHPes7uju2qtTq8on3T9su1ThiL4K7nsGrHB8J
         YUg6T/Bwtoo4mMIQbZ/WuaHC1h0hsBIfo68/rxxZaKSc0qq4N72w8qe24ILfOuEbVJ4B
         voXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518477; x=1789123277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Y4lvfl8K7dMiWCUbzntkn6PCAhAT9IPKbAAb6EOT0Q=;
        b=C0ceqBS0L5XAvnmImb47c1H7MFoKTTz0QPdqHYhnQ6hFqvHuAPMJWb773+9X0SP30i
         kT1+XBEwyjCfM87si0cp0xL40eDRx+ktcbzCxeiweozGJU09qWO32T/Pcj66PC4yxoV0
         NbBCO4xLl8RJucSvXUkhjRd8uD4cqUZDkCjBVUUvBGZgSqbWdCp6ZF5hnUYyTutBe7EO
         ZFHSv4cOrhvGN+RJ2cdZXck51E2dBIswA5sgROtNM9XSDoOJQ9QTDBiOrM41KVQyIbGx
         CBxk3yIRoj1JHQ8iLXKnOfaVcTVz+vJJ1vOEZOa+AJsOsBWRji3WMALqK+h+mODg2V9k
         vG8w==
X-Forwarded-Encrypted: i=1; AKwUvBz0fo0LEsyIHxRpBtFkmn714mu6yeGchHHpM9dETRSkww7RhwoGGl8aWpeS3uH9Gbn46UIXA18=@vger.kernel.org
X-Gm-Message-State: AFuF++nXT68Ium1LgtmHXI+ZiGPLj0u78NNNgk9QSdpFQBFrOayVUrma
	Q45tCK/G/1aZk4wEn9MuLusSHc3+OfBVksOlBicHsjTBr4qjy3BD1NxjLxA/EUcStlA=
X-Gm-Gg: AYBFou3m5U/NJtmE8SOgxg6XYb3xg81RpYloEjvqYJ62XrcgDlRVyeJb/ryrJYCJSkn
	zJPCi1bXxCZtibSuUpH2zBfldoicgB+2AvPjlIcsMj2nPOv5S/Pq9iebZgh6FJnjjiNuq+P63Kr
	TGMCpgPN4KJttpFGzz0tOJem8bRprbLu/8k/RkEmv/TgQYzHypom21ir0ReaEg4KopuLhf/cz3q
	qES/BCoH3bIZwQD8oZW4JAXjr5KU86ns3ljh1p33vRd3WCUHBARcgy+9a5vfbrIoK3rPDRSxII6
	iXbZWj6TqLANunAcNKJYJ10ha8lcOK9nr4qMG0VYYVJpAMrCkBMgUdxSxtWz0HCe+uiEQd607uF
	OkoYbfH2EBU/6UtGbfFXYf4EI9doKpJF83lWKg3gEcGdw/OsjC4lrHIniEkJ/iEAwk41D5yv8xN
	ROwNRfD58fMTExb/QvNSDyPvQkf2IYMDmP1PRcoLG+9xQZQWhgnnXRiG+A6cxSdHlEH7UpWdb6c
	rssZjEJJeR4sgY=
X-Received: by 2002:a05:6820:f023:b0:6b7:8396:f3c5 with SMTP id 006d021491bc7-6b78396f7f7mr1047288eaf.39.1788518477028;
        Fri, 04 Sep 2026 03:41:17 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435ec2bsm5319267c88.3.2026.09.04.03.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:41:16 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 2/2] mii: fix typo "asymetric" in comment
Date: Fri,  4 Sep 2026 16:11:05 +0530
Message-ID: <20260904104107.12832-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904104107.12832-1-hemanth.selam@gmail.com>
References: <20260904104107.12832-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "asymetric" to "asymmetric", reported by scripts/checkpatch.pl
using the misspelling list in scripts/spelling.txt.  Only touches comments,
no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/uapi/linux/mii.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/mii.h b/include/uapi/linux/mii.h
index 61d6edad4b94..d662c10ee282 100644
--- a/include/uapi/linux/mii.h
+++ b/include/uapi/linux/mii.h
@@ -81,7 +81,7 @@
 #define ADVERTISE_1000XPSE_ASYM	0x0100	/* Try for 1000BASE-X asym pause */
 #define ADVERTISE_100BASE4	0x0200	/* Try for 100mbps 4k packets  */
 #define ADVERTISE_PAUSE_CAP	0x0400	/* Try for pause               */
-#define ADVERTISE_PAUSE_ASYM	0x0800	/* Try for asymetric pause     */
+#define ADVERTISE_PAUSE_ASYM	0x0800	/* Try for asymmetric pause     */
 #define ADVERTISE_XNP		0x1000  /* Extended Next Page */
 #define ADVERTISE_RESV		ADVERTISE_XNP /* Used to be reserved */
 #define ADVERTISE_RFAULT	0x2000	/* Say we can detect faults    */
-- 
2.48.1

