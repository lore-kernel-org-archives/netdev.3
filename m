Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793453730;
	b=NjKzDO+tsPyQBbxLY+6MsB4ju7PavfmkLeBsZworujTsNqk0CoOIwNGMYj5alof5Gx+i
	 4xzvWuAe79azq8yL/9VNj2E4YTtGW7k/IzOcjdHq8oFLDkaEjEACbNQTXKvu7GeJzBteI
	 dbuBwTFzai3LdTe+wUvnlADLm56RCnS7qwEAKMt2pzBjsjpw95NP50Ya6W1cS64tClUF2
	 4yXHvVQ6OrTteSe6x5d5065BC7OBKFq1nNXQ2aREwM/tTrFjhByiZdGizjywqBZguIl4n
	 rMKk9kjL5P1qdCDQsURyxnqpljEybWsYDyueImXLG1FiB3Mx4BOZLKy62ntXYPNYCQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jYABWeDo+AGiod8hgPoggERFln3qmx9KSSnUFrivFQA=;
	b=axqC0ZUCRCOFm3Rq/U93L57Uph+J9L0dfzuq9NJ+/RuF/VHhQwFUJK/bxx+LnlRK67FI
	 SnOS0PytJzyvYoQO+QnCPLKkoArwbDb6vugapqD6y0U9Nxdf3SVT1ax7PVloAJGbnkfTw
	 /fd8FN81+Y2HNzMndQ97nBAHKgr4vC6bKNg+dMvbVTDPsjEgvjetozWJ8jKB5UapO/2Z0
	 wNUby8u2AJKMrdJr2eBGR/SI8TL6aqJ5QYg8B+vu8mVFp7+jYNf6zAA1rSgdOUXugTzr2
	 8s27Tuz3nIaiYzL+TbWi0lIFixXsuJdrzJe27r8v2Ww+PPMWojT1V6sYDAlmzgDu61g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mX4wM0Tg;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2A606A32C
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 13:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50A2A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mX4wM0Tg
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-536717a4d83so15558731cf.2
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 06:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793453729; x=1794058529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jYABWeDo+AGiod8hgPoggERFln3qmx9KSSnUFrivFQA=;
        b=mX4wM0TgZgY0LPbLWGS2TWIQo9dW6F+CNVQtMb4E0wYV0YYJmqABQFQ3n41d8lcMP+
         ZOf8JTOUJe7wwn9Gm8kVd1HHLlSQwr4dbqz/C56sIucLWkSQescmtjJlptUosOFxdZCT
         qE8NUff1K8EhMsxf3aJ1HFTEIMMFZrbUxtw1c5eZT9TEYojoV/Dda55eicgHuFh3rfpH
         oMfYNJU0xPNQLsAt/k6lSoHcDUCym9YL59D6Mz9b/Msvp5lSlWbZ6mOks5x0ZC6I2oAh
         SJ52DkkTGIb1fRtFKkDyKPs04rKsKJjw+T/665i18LO0eiUA8xB+DQzy5W1JAl3AnwwX
         ejog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793453729; x=1794058529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jYABWeDo+AGiod8hgPoggERFln3qmx9KSSnUFrivFQA=;
        b=P/ZxRSChNUCzRO53X+caLGG/ce/HHFf/vtVkl8Aox3JjCjnm2h3qb/SzNGl1DY+TRR
         AWstsgPLZaVQwjamQlSJhpaI9F389l80nGSlpF6+hQlrnZh/BzvkjVq4X4ki0SFsVCdw
         lZvdTfIlZge1mynFfCVx56hB5viQUZ2np2fBl5v00NogA1mD8JG7p+6AUs53f1ARR+az
         26wml0eSzuEgcF9aoQVa7EfHaz7LE6CPvk5+//6dEu7529/o4aasj5zsKjrgUiFq7aVd
         uRUUeYZYT3t87zvSAhTTzjSdze/LNUt3UF+UlQStSHzFjpzlqZ7KKVUgZm+5QdsflvbE
         HfxA==
X-Gm-Message-State: AFq9FYItgvio+M1aWasW1lgMtQqP+x9IQc4KIXIY4Q9FSr+39P8hc694
	7CcKVuf/B1lDRJ6mx8El5Pxpn8sozXm3U5MHhxu1mEKmwBWX6o+8TCw=
X-Gm-Gg: AYBFou06/e524FAI6vz7IGO4hlKJTi9xhoJzbCT9/1+0TypvwhkNHra72LDJj2+Xn8K
	7iQwVeKV8OYgKZi2qHGzEYGK9WgJWVWpAe/9Aqu9BLS75PKb59YuCAa+V3tAcfHdJtE3jz58Qp4
	NwDJjJJpenFhJsAUHWAu2jhSPxYgXZq/CEhqHqjOCXhwmVMmhuaiw7EDhf2GyzdHWDOFB7T4DWJ
	YgqS7NHxJhLFTFPledZ8ecFF3tFmhl9K6j5XtK9SWEk3xdU6+XWc8o8uXB/+DIGTnzqfMWx5f6o
	LyPIQmuf9sbC7gZZxbsUG/sjUlhcfl9IrzUQMYNKgTzM9VMoRQvM4/1lHnrbfeSntGQZ5zDjoMZ
	LJdHZroL6quZFOM/qzwbF6EZWhXcmdMzyR+Gso+/lIsGCQ9E9OME6kYDg4vyoCxcfSgOsjoY7c7
	WQhitQxCF3HVRdCGiTJCbpStryusiB/l6YUsRAWjvJMnY8FKe3mWcAgCXpPpGXuNZ56DNQUoXfU
	vW7RZt/mYMX8eZRXoTowsF4yIoifpw33V2aeFV5+uJUbfxPmAzypNl3d/WADT76JTgxZfKaQQsq
	xhs0wgaz+IjMcfGtyTFkEmBnRlI0xMprvs7zzIIHWyLzNmZjV8v2laEju3oVKPLFDQ6/Rcr8OdJ
	tOG7uOPI=
X-Received: by 2002:ac8:5f08:0:b0:537:83ea:6923 with SMTP id d75a77b69052e-542b714560cmr82010581cf.34.1793453729164;
        Sat, 31 Oct 2026 06:35:29 -0700 (PDT)
Received: from phoenix.rocket.std.internal ([2a12:26c0:4608:9602:488f:ea65:c201:8ce2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75fd7sm38713741cf.11.2026.10.31.06.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 06:35:28 -0700 (PDT)
From: Rui Salvaterra <rsalvaterra@gmail.com>
To: pavan.chebbi@broadcom.com,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tg3: make depend on ZONE_DMA
Date: Sat, 31 Oct 2026 13:34:56 +0000
Message-ID: <20261031133455.3070233-2-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Since 614f4d166eee, on systems with ZONE_DMA unavailable, the Tigon3 driver
fails to initialize, at least on systems with BCM57766 controllers. On a late
2012 Mac Mini:

[    1.226623] tg3 0000:01:00.0: Unable to obtain 64 bit DMA for consistent allocations
[    1.226718] tg3 0000:01:00.0: probe with driver tg3 failed with error -5

Fixes: 614f4d166eee "tg3: Set coherent DMA mask bits to 31 for BCM57766 chipsets"

Cc: stable@vger.kernel.org

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 drivers/net/ethernet/broadcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index f0bac0dd1439..c9875daa043b 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -124,6 +124,7 @@ config TIGON3
 	tristate "Broadcom Tigon3 support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on ZONE_DMA
 	select CRC32
 	select PHYLIB
 	help
-- 
2.55.0

