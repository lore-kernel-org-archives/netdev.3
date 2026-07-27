Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7902349CC4
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 01:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785117411; cv=none; b=qsAWeMh+KTxo6j9XH24bCvfVR7M93fZouI9pZ8RghOEHHzpY/truvN7tMFeWZ96p1NHepjN+c+aSUaHYwNr1F/z0Cc+8Dmxjg6Y3T1akVxON1bOSEvtN3nVQZXoEfOV707beFYIj+8BSdYU05LG5KwJK289YSoizkGXN5OIW1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785117411; c=relaxed/simple;
	bh=bt/QBGH8jzebAVQSg2EnFHPWGTDYRoR2f82Z1pOduSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LIOAxZJTnTWD8XQLPvm/xH5PpC/q2AV8UQSa4iEaj1LCUBSWtPN/nVGBggoqACjwD9JY42sy+6RK1GSbgToqWfyNYSyHt0FzMq6OTue6Nvv2PjEyU0D5kSy8hcXJJ6JgUxoMTwVBV55nreLHHW2MbeyLmgrxJvtZE8u3pVm2sNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gF5Mv+IX; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gF5Mv+IX"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-97715c7df46so419205241.0
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 18:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785117408; x=1785722208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6E4lr0nxe1bU+SeDOb65nuDXNro1fFH0tr+UijJu2Yw=;
        b=gF5Mv+IXDzT8Pk65OwEfODe+PNBF6TroE6WUDLljYWF0hEexO6Qfe9Co8Vr85GJXo1
         dcMddIpR/kokncSOkHEFnBJb38dhzPYr//22xDtAwyTFuUL/GP9rhYl3QsL1j7hXcBwI
         RlwHEGKD6+4MR0N0ftRZ1AWwDXGmZktVaNANzj9Q2q5ZQv6H5x/Pq8Zj9Z0WMHhmSj5u
         Gv6jxt8hcsM9BXvNKb/voA+WiBY7LFEu8diBaMuOrVtb6ZrOyJhl9pVO6/8mV+cX4IFq
         6RmIJCNyb2NSSgFy5Gb1uJpcAbXzMnr6nT+mWJBO7Phs7xBuOKIIUZivJJZeAn46YCOU
         Y/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785117408; x=1785722208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6E4lr0nxe1bU+SeDOb65nuDXNro1fFH0tr+UijJu2Yw=;
        b=fYHuSKzWu5lHTijUPaf0T/cJP22VEhUBmsxM5HngGM4eqb8XZomHJpY7LnsCSvs9/F
         B+sDPx1hdNiUO/XfyN7d4eoUfXxmyIMDfWjyl+WtqXNxoIwOGwp5s37IjnOqhdt9kreL
         Na2hzEwJblrlenf3d3wXIkkkynWFvUlRs0sUgzJeWmcBmvi/g/qgfHhM6M5v+h1+/bhZ
         2L5cTR74V1cH/rvFt2Edt1QQOo7vqypoW6/QfIyYm4nPTOMksB7IWmdf9R7W0dI3gixv
         QdHs0VDoJTwIe0VK8JerB8Sx8lvlqQneAThg+EOOdFm/FBr3rdnh/gzEwRsrvUjb6KzJ
         C++A==
X-Forwarded-Encrypted: i=1; AHgh+RrijPX8A9Ovz43na4G/L+PwliOhjjIoy9KfS0bbr6uqXC1xG/Zy9CONpGcHEWluKvNe1JzOGRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqb0C6pAc3OcSJAqYWLhh4C05Lzs/xpHolUGBKBm4czH4U+Ju3
	4mGDtaMkHH0jnZmbRgJ5Ps6yJM4faq4R2WMt6pPxdmr2F55QICQSW5NT
X-Gm-Gg: AR+sD11hDVY/N89wDS3bY1Miiko0m+3CQidawzoTwl11ntnNobAB46AZ9gjcQ4ougr8
	/jo98gXXaRvJ/3CgVnmdXKu5B87mA5G5ilxNIDnCIJ2I9jGkpNEtaXyIhNGtOST9ealKr+4tqvg
	dTx4g41zYPB7YgsQ3vEyAbbBOSsOs7ccq9efLyYbLR15mRtJMh5tRD1dRmr/7FS5g8y43Gu8nKj
	rJd3PbQ0SzXQ1Wf9l7rUmHaFKc6gCjWR9jJCs+nOZBvS3tYZUepGzE/8gdBHNjuOWkifOSffeYL
	e1TGGF+BdEtEWWhLQ4XUflBnO2P/F1io542ydvxYnXmgMiU6T1CDyAV+vMP2fiEaqqoviQhT7D9
	84DpkMTux/Dbxojnx62NnTnlp+ktoVrhEqjeZsbf8dKbJbXnnFJ8M1WGTVQeuSQz4qSjdFGtpf6
	SRC2u+OOOLYzinBY3eUg==
X-Received: by 2002:a05:6102:6b09:b0:631:26f6:701a with SMTP id ada2fe7eead31-750413f13c8mr3227468137.29.1785117408338;
        Sun, 26 Jul 2026 18:56:48 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-75036705086sm4545306137.12.2026.07.26.18.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 18:56:47 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 26 Jul 2026 22:56:10 -0300
Subject: [PATCH net v2 3/4] net: dsa: realtek: use devm_mutex_init for
 vlan_lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-realtek_mutext-v2-3-5d62ba998791@gmail.com>
References: <20260726-realtek_mutext-v2-0-5d62ba998791@gmail.com>
In-Reply-To: <20260726-realtek_mutext-v2-0-5d62ba998791@gmail.com>
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

With CONFIG_DEBUG_MUTEXES enabled, mutex_destroy() needs to be called
before the lock is discarded. Use devm_mutex_init() instead so the
cleanup is handled automatically.

Fixes: 9da2c8672f771 ("net: dsa: realtek: rtl8365mb: add VLAN support")
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl83xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 9402bfe4f85a..9f40afb19ab2 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -160,7 +160,10 @@ rtl83xx_probe(struct device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
-	mutex_init(&priv->vlan_lock);
+	ret = devm_mutex_init(dev, &priv->vlan_lock);
+	if (ret)
+		return ERR_PTR(ret);
+
 	mutex_init(&priv->l2_lock);
 
 	rc.lock_arg = priv;

-- 
2.55.0

