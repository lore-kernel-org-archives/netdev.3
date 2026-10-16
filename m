Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1A39A04C
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131129; cv=none; b=ksAd4madxtSVnm8MIKeyFlcoijr41skPZAIwiqa1sotKXMhr5KGWL0451FHzyhg6feI9YIRRL2xHaHoViT50CmcRM5v/1h76Yn2DaisDwPiXRgGW1yH9cR9WMWug0iz4cvbXmAY5kO1hVfhNVimMw5CBieYHFGBWoyL32Zh9nQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131129; c=relaxed/simple;
	bh=L9ZFiyAFmPsRderO1/Rh8bWC0nqqw4eZS58Lu9GM2YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+RpxQrVcMKJtOB9zN63YwHCYQSRlz32AHRpjw0gL+KRrrOjfCCRtzalGI+Go9gfCRqKVm9xZs9BKM2saryik0Sj8i9HtSeqTguKiDRYsOKw+/mZFiYE4CjIaKV82dTDC19UokWFqcobjo8BPrFi0Jyu+lbbdj4e4BA6PJc7rtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2DX4C4K; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2DX4C4K"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15dd124bbe7so326834c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131127; x=1792735927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8JY0PAJ8qLoMlN4L9aNAG6FBeK4r0HomK4GOKTTjBOY=;
        b=V2DX4C4KC5EgOE4gzbxBD1swceF+drPnKz66lXurb0IRsJgwq3aAMjt4UTJQKxKQFz
         Jlze47oOKwp01hhH1fk26x9kVNgT19HCKIQIMApaf8bauH68i2a40aJEdBo8d9LhMIGk
         KMFxVRmKW2KQKwe1n8yVCPJJTae4eY5VLX/kzBr6BC16iE1PIvOsbe2L2IBU1QaYy/dG
         gjImftdhKoDPXFG2ymTA4tp3sr5DmlER8ibI8jiGcvnm9129YEPNYgN3cjqOTLvt2miZ
         M54+oml1P215mN6wAvBW3VK56zaiiGEBl/p7IajwaoYpBQK60L1/TIUWUPPOexKI1huO
         Y/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131127; x=1792735927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8JY0PAJ8qLoMlN4L9aNAG6FBeK4r0HomK4GOKTTjBOY=;
        b=qgfK25cMgOtynRDN02N0nOu8DGu3GACw2IVh5yc5Pw9dg1WxEljqzwmEtZbNIRnC8I
         ogPb6ZYTwz6agPZ3o7giXgJ7NEspMw491WND7XWsBOr/2UsN1i4HkMtWBWW+aNUrk8BY
         nV+OYXKwE/YpvjXN1huzh8FFNI1qUSPgYa36Jbwj3AXQvX+tkmkQ2cRykFNSQ5LUG5be
         aTBrhvjLR8Y9bxinEF8l3lnH65UFNDtt1mZQSiO5Jiiy2tIFnnNWexPRKs4DviNpIop0
         ePWMwdQERbTuo+qlPBzkdqZMRBtl4y2W470Qb6l5nA+H1S6cxYc1ho1UENJ8nAL0ELrK
         SyGA==
X-Forwarded-Encrypted: i=1; AKwUvBz2iBcvJKDuCg4LWoYdyWYFfFNrJFaiz9nqA5yz9R9pA/X0d/uid8wh6NLY5sHfr1rkopY4AMQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqlJ2DRFhlOkyTnCo7pUM2jBGv1Jvaj03mp0DnFpc3P7EB0Oss
	ZMF3hJKerveIK5tngh6/oJce4sUN/TARbey+jlNbplgjO8iWa0M6XtC4
X-Gm-Gg: AYBFou2tAsf7CGWg5Y14+dq4HDYL9ZTKGoY2ArReAEgbx/6oSP0xbfXw+fB/+saDiwI
	ycTubAhQLZzqAdGTydf/ugcmW+68T6Eylzd5ax+K2mQLGV1rDamWTfyLPzr2TktQzjIWBYhGV8X
	KSgAW0AxF9CH3HXah1GXfALCIp7Gwb31orczWJguH3XVFjnrH3bWMsofyZGUECDsJCT8mN66eQo
	tkJR675+R9my3GGMTt803B+00lfeBFVfr9OIHZq2aggM8HmmFQ0NSS2KO9xnCXOXklC7XubCkZr
	Pn9hUDc+WYdk7psO2rjtVgVkIDFle16RV79UY8C6T0iOGWZcKxFDsk0wxgGBD02tWCLHicIAQik
	Cv4Oh6dY2dniC2C0Zlzev/qMNLSf+7kJHwSmt3sgockY03RATBvDqVasGL7r48Y+6OAXMjVShIr
	XrYy+pG/OfkN0oXEWXsAuoumVc2StFj72xvqQlaL6SJG5YUd9f1o4wxZAfsBCT+uo0dL0W7j1By
	zGaDP/UYSo4m4qEufDjd2j/ekBFDjIOccVv+ka4uZ6GeP0=
X-Received: by 2002:a05:7022:ea8b:b0:145:287:ce91 with SMTP id a92af1059eb24-16a5c6ec19cmr28597123c88.14.1792131126858;
        Thu, 15 Oct 2026 23:12:06 -0700 (PDT)
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm3755480c88.13.2026.10.15.23.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:12:06 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] can: janz-ican3: don't discard the IRQ lookup error in probe
Date: Fri, 16 Oct 2026 14:11:38 +0800
Message-ID: <28add8d0570b72d35c65c19b2365007cf0aa15c3.1792118040.git.chaosheng.qu.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792118040.git.chaosheng.qu.linux@gmail.com>
References: <cover.1792118040.git.chaosheng.qu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ican3_probe() collapses every failure of platform_get_irq() into
-ENODEV:

	mod->irq = platform_get_irq(pdev, 0);
	if (mod->irq < 0) {
		ret = -ENODEV;
		goto out_free_ndev;
	}

Return the lookup error unchanged, as the neighbouring CAN platform
drivers do, e.g. commit 057bd6168d98 ("can: cc770: don't discard the IRQ
lookup error in probe").

This driver cannot see -EPROBE_DEFER and the change does not fix a
deferred probe. The device is an MFD child of janz-cmodio, which takes
the interrupt from the carrier board's PCI device, and the driver has
neither an of_match_table nor an ACPI match. The probe should not invent
an error code for a lookup that failed for another reason.

Build tested on x86_64.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 drivers/net/can/janz-ican3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 1efdd1fd8caa..a65326b0f11e 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1944,7 +1944,7 @@ static int ican3_probe(struct platform_device *pdev)
 	/* find our IRQ number */
 	mod->irq = platform_get_irq(pdev, 0);
 	if (mod->irq < 0) {
-		ret = -ENODEV;
+		ret = mod->irq;
 		goto out_free_ndev;
 	}
 
-- 
2.43.0

