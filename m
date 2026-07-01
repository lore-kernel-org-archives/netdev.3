Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497B443900D
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903867; cv=none; b=EjuqRhuXjZKnbBeZQNISUYpFjClZspfRboCG0Eb+0duLAOxnc6ebS1wcuNRJXoj3hPFk8teTEu5WthecxLEZ/Lu6EjA+VIIl1Ut4xQf1XYw9Dsgt9hc8HhXhYBHtAzShG/3W6Y5rGXsjjxJE6zQCQTDLkFUwbaPsGSOalIB9t8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903867; c=relaxed/simple;
	bh=EoiXCnMfqaEvp6ChiEvuJfXjBruKNhqBu88qaW28Izs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JI3tvLWJNe6fQrb9hzb+rS4ENeacUAYo9EwML3nW/L4LJ5q9E8QnP5QtJy6ysS+MmanDqVVnwPLRWXig8PvJ/QZeYPYoj12/bE6GLwfZ3LiaRFslq6L4n5A4qKSJTdeUSioeFTvDTOuTmw5tAvAZwlwO8hLTvrnOdI/zMnMtCYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTtuXmSo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTtuXmSo"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-472493849a3so642523f8f.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782903865; x=1783508665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DzEMcOPWAAc3ya4BWHLrviknUVsExWDTeL6YrPN8Pco=;
        b=RTtuXmSoNCy23Dy+USryl6rjSjXPFRSIcQmSdzdcHTnzJmFRkGr23m2v8wvWFcys01
         z7TLOr8Zsiv8qgbw24lE5m8JIciWViuaBd+4kZISYQUCYYS9V6AXb8I0NvJBl27X6Puw
         nVK2ZbK3Y/ZKmxV+S3wNRQs96FWx1FyGy+snm3A9EtFgj1n9A9VYpVje/M1vgcwq7wKz
         nrEiHpgpF6dtRZs/Pbs5xNKWy4doI1ieQHQreHa/iXzBZyoRULysvM73PlznyC6kwrNc
         nJ5ZWeX20frHwNyCJN4VLSGHq/lNQD/Yo5MdISBVNUisIpbKY7LM3Lmd6ZMEn/mZkLha
         nXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782903865; x=1783508665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzEMcOPWAAc3ya4BWHLrviknUVsExWDTeL6YrPN8Pco=;
        b=HbR9fGUUDEBw8hWDmEbP7gCqpKY+F60P3lHqK1b9AzT6gRvRVd/cTgxa7JdW3lo/mC
         O27QkMJjpSRyrI23wYkxp0ww3/DcaYpWmcsaB19IPe8IDeRKr+G/u+FqOMgFo1seAGm6
         siR0W4fbQ5ARDJny+ZESalcoVE3ta3V59oNm5EE7lvh8tBSpNtpibYXaNr2qooS79j/5
         /2luDMU4FepQukarj30li16c7vPYpYMOQldP5HfTbC/unC8zE2CBfgLvHz8sFNlJnQLu
         /UsL0nYX5caAdfEhAgb0QatSKtbqa1taRswaUSmBVFRnRDO5POQnQaoVQ/JoJ6hnhyOw
         gBQg==
X-Forwarded-Encrypted: i=1; AFNElJ/+ljLAAwSS9KI5Y5tKuu8NGBItPcnuuRJB+dWvxVlwr6MgGcTPFK4F3n/fQxtyoOqeVLbHgMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQdba0vXQ1jPhlOWV2AgpLhjvNgHERFa7Q/q8JDcjTYNrXwiO
	WNVW98Il2509/JU9Wd+C+Lm3KvuIqL7t5y0t02EYV6SPoUh4UbVoBPv7
X-Gm-Gg: AfdE7ckrmOEcbiaQxoaJsNLvyIYRa2l7CmmJJYxFV83dyhvUlV+OwKKdCbZSd7LWl34
	FcT1ssS9PpJoo4v5ZCykN31X6Ijj64DQjbAVsMcJPU1OOlAm/LTn0lzta9vwGU+0EfsBG5kq7YI
	BlwLm3oSKxl3fpgNNB/dEJxZ3DDj6QJyCAsTqdQtA5DMkGylp3eMaUnwqLZ3EjcGkf3QPvind9J
	VxArLgjRgxETm8AmvZSwx/ehIJox7XNFfXZSDvKjlEdjJ3CmRHCe7jLMQV9mGBFDd2L2ag3Cs5w
	a48KGv7Gf009E+fef/t/iSk44UxZPqGQgXwJ1haOR9gZs9c7mMs+xVbFq4nE6X9o7QYClMwNWTM
	Rqg6GiBfNELdPT8eQM+wDknuYoAl+hkLao59/1bOS2pK/KBHiCGHKKad8fVnWPQp1G/7bmSjMIA
	zTStNE/3ICBFdWmrWtnYzGRQ11zga+eyNneBsipDNL5AGwmj66CTrLuEAH++/U5lvkhO2h+lrzF
	BYe
X-Received: by 2002:a05:600c:64c5:b0:493:c3e0:99ab with SMTP id 5b1f17b1804b1-493c3e099bbmr437705e9.25.1782903864587;
        Wed, 01 Jul 2026 04:04:24 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4659sm17142835f8f.12.2026.07.01.04.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 04:04:24 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: andersson@kernel.org
Cc: sumit.garg@kernel.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robin.clark@oss.qualcomm.com,
	sean@poorly.run,
	akhilpo@oss.qualcomm.com,
	lumag@kernel.org,
	abhinav.kumar@linux.dev,
	jesszhan0024@gmail.com,
	marijn.suijten@somainline.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	vikash.garodia@oss.qualcomm.com,
	bod@kernel.org,
	mchehab@kernel.org,
	elder@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jjohnson@kernel.org,
	mathieu.poirier@linaro.org,
	trilokkumar.soni@oss.qualcomm.com,
	mukesh.ojha@oss.qualcomm.com,
	pavan.kondeti@oss.qualcomm.com,
	jorge.ramirez@oss.qualcomm.com,
	tonyh@qti.qualcomm.com,
	vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com,
	jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org,
	apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com,
	linux-kernel@vger.kernel.org,
	sumit.garg@oss.qualcomm.com,
	harshal.dev@oss.qualcomm.com,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] firmware: qcom: scm: add missing IRQ_DOMAIN select to QCOM_SCM
Date: Wed,  1 Jul 2026 12:03:38 +0100
Message-ID: <20260701110344.1999068-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

'drivers/firmware/qcom/qcom_scm.c' calls 'irq_create_fwspec_mapping'
so it will fail to compile if IRQ_DOMAIN is disabled:

drivers/firmware/qcom/qcom_scm.c: In function ‘qcom_scm_get_waitq_irq’:
  drivers/firmware/qcom/qcom_scm.c:2512:16: error: implicit declaration
of function ‘irq_create_fwspec_mapping’; did you mean
‘irq_create_of_mapping’? [-Wimplicit-function-declaration]
   2512 |         return irq_create_fwspec_mapping(&fwspec);
        |                ^~~~~~~~~~~~~~~~~~~~~~~~~
        |                irq_create_of_mapping

A patch-set in review proposes making QCOM_SCM visible in the kconfig
frontend, so let's ensure that it's safe for users to enable:
https://lore.kernel.org/lkml/akS_6izxrhgK-I22@sumit-xelite/

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/firmware/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index b477d54b495a..9d137fa2aa23 100644
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@ -7,6 +7,7 @@
 menu "Qualcomm firmware drivers"
 
 config QCOM_SCM
+	select IRQ_DOMAIN
 	select QCOM_TZMEM
 	tristate
 
-- 
2.54.0

