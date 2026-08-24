Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DF23E3165
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566095; cv=none; b=bwoYkob3U5Ffl1eMkB/XwP8rEcINumOx/EYABIh5wl+PLG2YJhGq+sFXpVGK1fufsXH7ad7n1lfnim8cHX24h6Jl7jIGHkeNi5UNRghLKzI2bIpOjWQAhcaOW1MXVrzEQWTeytXtUIKxYEufAw6sgcetVK8G6ebrVX7w6tOhBCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566095; c=relaxed/simple;
	bh=sNe769i2zcZkgYcxZKNZVQSTmpLULeOimhv44pX8Lc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3LnFPT2Cl7ZTYXbK4gGIgxneZq5xckKKNS4ulxgh+TOcm5lA5WzSm/RzbU5nXUctEsKrHKeW340Z/eBSnuKSbKaFEU3SjH8VYOXlezanR4sLaMvdBjVWraI0Q4+yH5j72O9PkRzh+k9sepv+bpWQBzRg+DzqdTm9UrcSi8EEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJnyw42d; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJnyw42d"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-395cf2535acso2744042a91.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787566093; x=1788170893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aSTifNCQ4ls91RrIVMopWzaYzSVTRuWubiFRAnBn54U=;
        b=mJnyw42d9/9D8PDUm1XoST6KawnJFNKRYZePIBD3Lc/3ATfTZ4o+cxsCZRbVhlQbIB
         0MAoaM0fKJ7AS9S7HOy35j7uI59rMqSGOlPYX5B9KuQ9F6u21WLuvLh+mzzRsEKzb9+3
         Eak/I+OGQBn8FiqyRLkI8mY4Bp1bMo8nFT5J/rrlF6snx42IjXV2u3AtX9kw+EsR3noY
         vy9O+ZWxBExEn7YGkeb3mvWyR7bdMBsqekGyMmS5L6py2toNBlySR66S01IEEYaQZJrT
         Ih5+CzXRfZAPxEUnWcAKImM7wt3fm4aM6YVTWIplzgV9jExqOwezkgLQD22HlVS4ZIgM
         hFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566093; x=1788170893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aSTifNCQ4ls91RrIVMopWzaYzSVTRuWubiFRAnBn54U=;
        b=hAmtCBXnCMZ0FBFq+UgJ1KZIauUfTOLFAqzoHLM3PFw1nQEcLxxuN9P7KzVFtNZ8yc
         sElR6q3Fs3j5bMvqYBTjm58FZdaHEGCFjoOgJIag7TF8JXbzA9c44FfI4Qv0io1+yCZI
         ko7KBp1HpgQDeomXW3aQ8RjezutDZpmedOLsBrV/hugNyu0I5vvAPUgcRDTZR/o6dKH+
         o5fM+P+n8jOTNEjDOhLh8Jdn1wmVfLCFHr9FQ7X1WCO/WhJFhT4C05c73MO0ntodoIJG
         IpZSbJ1FImbry4f2+28ajF0GqRhCY22tBE/auvDv61lAb90P/DPdMVhAh10WLu9BjpBd
         9dmg==
X-Forwarded-Encrypted: i=1; AHgh+Rof1bjzG+J4D1sXKXZ/ewAQlMldl2Wmi4dOPRLfzc3w8XsaD69MBdd8h2mIwHn0s6L5pwunh2k=@vger.kernel.org
X-Gm-Message-State: AFuF++maNAhgGEP6vnQWK+Wn66Kk6IvBCV02Ht0YjYu0ccL59XBexpdR
	aj+OuPqnClhAgWXvnSkEw7QUm/OEFlwQZXlqo9dEWotlzY9tNFV9+blt
X-Gm-Gg: AR+sD13FBNUuu6jsV6uwUReo4UCf79fhbKw3DObUQHxKR9Hi0eYW4eNwDdTbaAJB7pR
	ENe/jzKt+khwCOBYYs9mGurOM5+cw2YGPWHYTeFooCY9EMg+mfuu86JObnMAFEQbcTEeFNbDjjV
	2i10puuy0LzSr1cpZEDdTPfMG4TNtYsht6huBI1kOBQzFii+NIZ4NSXeLCx6XBaxC+ZBTZeinjc
	0fUoGazbwdKtpI2KYKNzXBpetVF74xHIWhMZnF51+2K/4bdQaX/gkEpVv5Bv2YXwdAU+TTI4qjf
	yTUTZQBS6o2oPWZxXuMwgsl3bZrzEdSmDAP+MWFQCwpwKNWy9EKFdyzEGkuzLK9p5667zoIRwD8
	j8fnziTfU6QnU+e8JCG0dBJoAdEmEafHZtYTLyOvdyl52n5pIlGq5JNQcSo7+rBTAPmXVWAK3I5
	A2Ug7yjeS5GlKGUji6p5EX3cT5GyVuRGUYZRLO4HxaGa+Bg+QMtgAH/TvB/TncdbHFwcCl7CnJB
	uWHht/mfJTtwXv6+OLzoK08qs1OjXTXzj+7XrbfeLnRXEDd81BAXVA75dfHwOW1OahTmrreCWb0
	M14i
X-Received: by 2002:a17:90b:2e4b:b0:38f:de94:bf34 with SMTP id 98e67ed59e1d1-395c514b5cbmr23554317a91.10.1787566092957;
        Mon, 24 Aug 2026 03:08:12 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e494fa73sm9727061a91.4.2026.08.24.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:08:12 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net] net: mvpp2: Fix IRQ error handling
Date: Mon, 24 Aug 2026 17:07:58 +0700
Message-ID: <20260824100758.31622-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

irq_of_parse_and_map() returns 0 when parsing or mapping an IRQ fails.
The current code does not handle this return value correctly.

Check for a zero return value and return -EINVAL when the IRQ lookup
fails.

Fixes: 591f4cfab38a ("net: mvpp2: introduce queue_vector concept")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index ccc24a1301f2..1c50174c9f1e 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5874,7 +5874,7 @@ static int mvpp2_simple_queue_vectors_init(struct mvpp2_port *port,
 	v->sw_thread_mask = *cpumask_bits(cpu_online_mask);
 	v->port = port;
 	v->irq = irq_of_parse_and_map(port_node, 0);
-	if (v->irq <= 0)
+	if (!v->irq)
 		return -EINVAL;
 	netif_napi_add(port->dev, &v->napi, mvpp2_poll);
 
-- 
2.43.0

