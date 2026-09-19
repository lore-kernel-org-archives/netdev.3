Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910E6345EB7
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857275; cv=none; b=V2RF+Ot9ZaT5VTJzQ5OghF6WWRHOhTGo8kVgNN0APrdMVfwC0AHK7sLbRDdf2Z532/gwwcaiuqgt8blxKiN9AVNoBidmkrqvC+Hv7Wa+XU5E/e89SKcmbQjLGmOUHfhsEOScUIIwrwxgVrdqxay/Sgu8HPwtqD6Wpb8Ke7VgIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857275; c=relaxed/simple;
	bh=B4GdAMoCwiLRsDWwbKoMF3OGxfJiyMCwoeSLCf4H0Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sj410zhiawGMS09bRu0aTGQw3/D6zuKJJGOHxeqeb4rnZvKKFijE39OVAXZXmDBrt0iYmWIHbXfb8LS6zhMPWHYGpsBxR7pyhH7WYjNI7dpd6i6GGWLAC6Hrt9lIp2pfvGeufPdl2mTlN3kZnFMjxTenIYCsUkKieojlK84pkXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxZgoOdE; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxZgoOdE"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so1360575a91.3
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 15:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789857273; x=1790462073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2xZ87fdrDeLo7wrehSmNDX8WxnxSY6Jc+Z4ytRNTHoA=;
        b=bxZgoOdEjhWG2FBBTZ9SZuygYxmL0DdLPXKLdXuaUeDihh3rbF2EZwN4Z2Z6PhRLVb
         zygRTdmX23s5QAyWo5NbkL0X+gJ4DEpOlQrSf/huVGp8wzL5HAGHSGTBv8JQCJyEg3pa
         MlBbMT0YlcUqVdvkB8mH/cIqYpNRv0dJGhaAyv29G4W8bkPC9Is8JP9UPii1wB+pEOjX
         3OkBb6YIZSjXoDGYvP81MdLN1TW9hfxsEaOSWKZRkTZWD1eJGFNuH9H8UmIDXgkJUOjY
         qFD5qcG/n8PrNhJ1wgvgfrV6pQQexGvxRsdkrPTbDFdVSPTHwubmDt8qVrml4aP7WDa1
         A/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857273; x=1790462073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2xZ87fdrDeLo7wrehSmNDX8WxnxSY6Jc+Z4ytRNTHoA=;
        b=k8Xl27tXSIWQGtWFwnEpzKWZmBKuFSjKF0g96001jg101sbBxFg8Qr7LHtvO2RbpJ3
         14qruqgzmv6RfTkkpcBrgdDfjg6E+k0G7UA4FybZbCxVYDVXdqHQRAiVWMzoeUBsvUkl
         oImR5CrYEtC5jMhK86fGZ/+UblfjomUa/hIkTGcqGSDzNqEK5XfrrZcf/K+UFFPmkmnT
         yWvbQ1ITLGSCayngzXXnNqaeE7JdGqfD25MCC9rAVaaUgW7X05rlP5n2cEbGKP8o9r+a
         vpKg4M/drPnRaE82k0i2JAnM9605pJ70E7lJg3OVMylVWikj7keYZdPlEcZ8Y6BdwfWl
         MLAQ==
X-Gm-Message-State: AFuF++kcDoSGJw5B0b967+Doc3tVcP9TtHeZ3OMR2P76bNDZjgs+83IO
	t/6/mDZH+QSMpM3yw44c/J3Mn7DusmjVAi68KvYpwRz76876TTilRa5W
X-Gm-Gg: AYBFou1FWf9GY8vGlS/E5CECLMugQYgOWFVn9Ulorj6lUJM+nROxcbbQccMiL4qz7PA
	YjXDnA1EljAHBRye9gHMD0dE6jDLaWslWFiF1wZRUZ2uCHmrIcea2PnTjceEXvXV82Owh0YyW/n
	C283NNLUi4V9CyqfmnjB9k9XoddVuVEwIri2xXDvlcejQEkFaWESSKp8+WhgnH1y5dG5X5pwswD
	U1JnDo/oqUciNESoYk/VzTXv5b1IUB8gcWfZzWhKzjWcAaSNwEeKelNli/Wv5lm4gOGrt2HdYxW
	7hhfVXwNnQAwHEb14nMv3Q05I5TPxzg4BXaLOpRjowlkYi05VRZrexgW+FyJM4v90oT5gpZ2NZP
	9Uth1hGB6ZhZ0Nx3PK2AygShMZbGKBwFB07Ccg9UPZ2/KaG4+S02Va7DqM8ZpEl8rsl7Cq9lj8s
	S5ypyH9ksVS8H6J4FzwtCSro52Ux5yDLWVOSTJ7HKonKbbwRPUOalsSlM5gg/+oCEF7lSZ6ZYby
	AJXjdfvDOlu5928yjRwgJnP7LAiljeTnbB40vutZ1+oepRVAW1iZQVvt+Q/Lh4U5IbkkeL/esI3
	5JGFxgaaDQ==
X-Received: by 2002:a17:90a:1c82:b0:39e:6795:f7da with SMTP id 98e67ed59e1d1-39e6795fcc9mr4171272a91.19.1789857272930;
        Sat, 19 Sep 2026 15:34:32 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55b83602sm4702234a91.1.2026.09.19.15.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:34:32 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: slip: fix out-of-bounds access on short CSLIP packets
Date: Sat, 19 Sep 2026 22:34:31 +0000
Message-ID: <20260919223432.3882500-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In drivers/net/slip/slip.c, verify packet length before invoking
slhc_uncompress() / slhc_remember() on compressed SLIP frames so
truncated CSLIP headers cannot read or write past the receive buffer.

Fixes: b5451d783ade ("slip: Move the SLIP drivers")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index fdd6f63fb849..4389985979cf 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -335,7 +335,7 @@ static void sl_bump(struct slip *sl)
 			}
 			/* make sure we've reserved enough space for uncompress
 			   to use */
-			if (count + 80 > sl->buffsize) {
+			if (count + 120 > sl->buffsize) {
 				dev->stats.rx_over_errors++;
 				return;
 			}
