Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C03451B2
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 01:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785117392; cv=none; b=UUqes/KfQMiBNNdIXZ1FWz/EEvnY5HX1RDwuNJqV0uYdFpzZW9+m8Eahv2jp2HqLNz3MUOONvYkbBLLbJEwgUyYpjnOOaXtkFFSVB6M85rCc1yx3iDeZOW9bL+QlpFkNsmoOxzMbUMlGOdrE0kMxaK9gGiPFaRVUeQ0iUiPWo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785117392; c=relaxed/simple;
	bh=mQVB2t9LzJI+yGicKFNoUXjdEefSJTw0Z1UWFWZh7bs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iLTJXa2Op1X1MfOuGAVzodEinyZw7dv1XgSAw6imPiqhec6qgDSWOfDqahVhkJoLuDX58UTQpWHy730lczRooTw16W5vtF+YuPRDYnpK6x+RMTT6osPCAoa1zqxkStaZY2jpkptf9rb1iPFN+GoNHbd5CeHFQ5GwAyAQdfG/KAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1fRJeMC; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1fRJeMC"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bfa4c51c2aso782431e0c.0
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 18:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785117390; x=1785722190; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aRBSZf316RVmEz8YtVlzSIPSRkdsomKjew7P60LTIqo=;
        b=i1fRJeMCI7/kGxq+98cJh67xVUqzDuy6pb8YVvc0vV6ik+rvxK9mBKp1yN8NQIJ5DW
         Py7DwB7lTYmAsAEZl/g+wrLSaGzAHMRlBlChjLaCdEu5e/a+pVdVSSnrOmah8tTJ+qEK
         mbmWxOtffmrQyE+zefaowHiryAD+y9IId470lYr35eAHvklc/2rGIU3hjd9ZN1nuC1la
         GXs1LJk216U0pObdRFh4MxDPIq7b2+Gob61W4N/ZEXic0CiAzWsLsI03TOzD2lWhTcoy
         dqB42H06d2u8CoI3s7p1YZjKMgQAHTylsNBML3aidY90P5/iTc0bgdLHUkVoDHykxMWD
         Ns5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785117390; x=1785722190;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aRBSZf316RVmEz8YtVlzSIPSRkdsomKjew7P60LTIqo=;
        b=VzEfs6MzDbk4CvoHe8RuyQSI8I0oS1TAiqul9RITB+I8tX8YimclAfbkpeH/nyKmEg
         3xKH0DCfNlWs7FT89jI9a+3vgALofCl9WO9QoFujPQb8qvfgeCMcb4AHix9dvanvQ6jJ
         4Yv92OLL594qX1UXYGPuUNerVhbETC3Jc/3OeWoZhB7YQlgpfRJRHoMivwizBRMAr87K
         ihALWGk2utwy2YzbOtUVRt0yc7Qz2IK35/ledIUug9TNOaVCJWz+VT1YkgWISJfNEAo3
         x/Ia1QlnHhyTKKGLPPI99Lkg9Sq47IwiJvtZsIZ7Ih/t7MsREvBstn/FpgQhZdGo3rS4
         YUYw==
X-Forwarded-Encrypted: i=1; AHgh+RoBVIYBWJE+isbeAfydhkGhB7BK3UNWXUac/UenMrnE2zHCMwam5RmbA8nCB92/RRlC0SDiM3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy06cTTuOHIuN75AVw4nrp4L9JzdFwZyeYck/Il3vx5gQDM5whX
	3BAmzXGFH3VxoCjK+lQp6LyD/wVfznMXjgiPjsUUFegk37JsXK1zXZW+
X-Gm-Gg: AR+sD11+LS3m1/TJvyzaoqpOikbs5J4XdkjOzaIyEMTp57a57zDm+qzqWF4FxoTBSp0
	+xBh4EaHZLPyUQPd+TXvT5e+uIsAnAJ+HuifAtxYT/VcHd3syXxUiraalkDO+og+hQgV6lWnJ0e
	kmwiEiKIkCexwrnoL6OmjpH/QR4LqCLtUu8/KSSJKr4ley5vIWIpTUEYdvyDw0q+JlyRtRXrsQP
	9RxPhYs5GmWyCDDDQ2c12Mw0ZgBvF9gGWkv5U3HTWWmbyRKPbLmknHmILAMkWgPtbtIdqXIIBZW
	aVQ2VBJe+jfDkqt7iAFKq++IqseVU426EH0bd9h3jpV+R5LLyKiULwPer2B3eOggdZ/WUCAQr3c
	MUqqq4H2Tzzj8hpYHXkMybhb6e86pL/sLRIzTNeKewmERBC5RzxQMx0r4XtymAt2HWI0TpLD1Y9
	01Nc3YVPYwh2IR7lAlyA==
X-Received: by 2002:a05:6102:504a:b0:604:f849:462e with SMTP id ada2fe7eead31-75040ad334emr3450017137.25.1785117389899;
        Sun, 26 Jul 2026 18:56:29 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-75036705086sm4545306137.12.2026.07.26.18.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 18:56:28 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net v2 0/4] net: dsa: realtek: use devm_mutex_init
Date: Sun, 26 Jul 2026 22:56:07 -0300
Message-Id: <20260726-realtek_mutext-v2-0-5d62ba998791@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALe6ZmoC/3WNTQ6CMBSEr0Le2pq2QTCuvIchppQRnvJj2kIwh
 LtbcG1mNZNvZhbycAxPl2Qhh4k9D300+pCQbUxfQ3AVPWmpM5mrs3AwbcDr3o0BcxCpMjLXONl
 KpxRLb4cHz/vgjXoEKn6hH8snbNimNqxhHwb32W8ntcP/HiYlomyVlyi1NMiudWe4Pdqho2Jd1
 y8N76KXwwAAAA==
X-Change-ID: 20260718-realtek_mutext-41a072e5cd24
To: Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Rasmussen <mir@bang-olufsen.dk>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

This series fixes mutex teardown in the Realtek DSA drivers.

With CONFIG_DEBUG_MUTEXES enabled, mutex_destroy() must be called before
the mutex is discarded. Using devm_mutex_init() lets the driver core
handle that automatically.

The changes are split into individual commits based on the feature that
introduced each lock to allow proper backports to stable trees.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
Changes in v2:
- Split the commit into individual commits for each mutex_init()
  introduction. 
- Add the error code to the rtl8365mb_stats_setup() error message.
- Link to v1: https://patch.msgid.link/20260718-realtek_mutext-v1-1-1cd7beb20ae6@gmail.com

To: Linus Walleij <linusw@kernel.org>
To: Alvin Šipraga <alsi@bang-olufsen.dk>
To: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Michael Rasmussen <mir@bang-olufsen.dk>
To: Florian Fainelli <f.fainelli@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Luiz Angelo Daros de Luca (4):
      net: dsa: realtek: rtl8365mb: use devm_mutex_init for mib_lock
      net: dsa: realtek: use devm_mutex_init for regmap lock
      net: dsa: realtek: use devm_mutex_init for vlan_lock
      net: dsa: realtek: use devm_mutex_init for l2_lock

 drivers/net/dsa/realtek/rtl8365mb_main.c | 16 +++++++++++++---
 drivers/net/dsa/realtek/rtl83xx.c        | 14 +++++++++++---
 2 files changed, 24 insertions(+), 6 deletions(-)
---
base-commit: 4361bac9a4adf0e97639130c765669b41030e86e
change-id: 20260718-realtek_mutext-41a072e5cd24

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>

