Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE3043CE6D
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784748458; cv=none; b=iYkGi8R1zR43T9mzfVQz6EtlUxuLcmFyIwhSUcrieczBIL9iLoNrGxDN1e5jgIf3sUKK8C2PQSLcQ03KRrP7yaFWQ8hkSLKnJY1j830hmcbbVriZ/iG1C1tzmDfl0Mst+gpoQadqrHceRImlheRaixHl3Ml/PhLwCPIv1RF0G2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784748458; c=relaxed/simple;
	bh=NXrNrNrobISj2cFdOzeQsXJni4zC9IIseLuYFi5TarQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+aEzh3/F4FmVvIir+U9OZF6NZLrIp44sTSiVWc5RhYbdhcLopcoYOdnGZBGmRfmafWjs65kKAa2+QA5XycxfPadRQ140s73EgQk0VQ2Zcj7+Wcnk6WLxrNcNRzH52zDW4ZeXYdW3DX5/78fV6201sLyI1w9XeqZylXx0eao1OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYufu8gi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYufu8gi"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47640541585so6851883f8f.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 12:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784748451; x=1785353251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A4QGtthpDoSR8w+cOub6icKKshFZB4+JzCuuHxM4qR8=;
        b=lYufu8giCFoshMhaytTaXVd3ctCaam7gEXKU9T3D+gj+oCb2TH2h0cKoL7tEqKoBWD
         y1WNC6/QLEFIHaC0f+uy/X2gch23kpMuq6iP7/aZ88tPU++IeU3W3MtkUtnW5RZI9xWU
         wAFK/GFu4VmrKW2wI7KFQwFvgn+o94sLaZZKsyQB4m9VpDqikOCt/rQ1/ZE1WN/mz6z2
         XrRD7Xqg4hq4k+HAPFLOL2OJw6CzMw/IT9+8rTmim94Erc861XqrRZ35OWigfrG4Vdjt
         K+KOivd3CK25Bed0HhnfXPDmYbotZsCp6XaQ8eR2ptIOHXZIKJUQvMupLcdezShjT68E
         +DMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784748451; x=1785353251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A4QGtthpDoSR8w+cOub6icKKshFZB4+JzCuuHxM4qR8=;
        b=Ym1XauoZvTzN5HtGf8iYSL+J1cwy2EOokRvWkerYHXBRSkXQnapCnPWvFRfKZhgL0i
         rDSvBQdB8P2JxNnuLJlqX7dpv21SuvRKjsHZ2YgU9Khn1ss6BOpmWPwnqC749Dc5nDku
         DwdXLlVWvb8YJixjEM3NmMQ//XTK/M9X02Iy8psBtBseVcwH6L4CYpQszb/ksBWhnX8c
         mAw/inkOX5rMHHr9YHghli15ClOPkKD1bwhAObIYNiR41ZBo2lTdmiKXpnnCi69rDR8s
         acL/GloiVn2KwlHhr+jA/QtFbYq9A9lHBvptjhZgrnetlztuQE9nuixIrWD3YS/2M40u
         4iXA==
X-Forwarded-Encrypted: i=1; AHgh+RreOff4damx5yk+hC/midFNGe43X5oRhAIfkIocIzwguOY6k5WMZhPLhdf2Xa7lntKcGKTAj1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCarykBIfwCjjKixvk5Xch9nZll+TBTz8S42rh5HLjGhAA4aNR
	FnM1OV+uM9cmScHn5sEYLzIVfJtu+YeAVdPbwpRflyfcX4pfBsKv+U3h
X-Gm-Gg: AR+sD11DdyyR6EOIFO2ifM5oEWKSD+oTX8o3fepd6TZ4yLq6LQx9zCJF3xbu5efJqTD
	UHpVPvu9Qya2VMjg/124ApZ6z3a7PdGQtvqELMSChLmODap/911+hhbUaYiym7eG4ktjd5Ommj6
	Uqo62riBa0Bz+KCYuU+/7BoJIYGtMNgssyh/keo/45QE6G1iaDScxMJTFwzUno49cdL7RzdqBja
	EWnP/x9GzEMbqVLVTe8rjFaJDWvQp4xI2mXT1aphduHQTHh70UI2kYGOAjE6JIh4Aa3raPOEHDn
	eiN4nabFOoSFmPTj9HBR1+3lPqZcUUMWAFPp5KIohnvxphfubogGwA7eQyumIYSDtVnMmGPjRuP
	Aa04FnPhvf6wv0EKo+cjaQsgnjWJZmyWkL4FlNGVNn877XYuxdMkRbncPr4Uj/WG2K1DWgrCRSI
	zSQIgMHQaKbHywEPD4OVbdfOJz7O8=
X-Received: by 2002:a05:6000:2401:b0:47f:5289:d5e1 with SMTP id ffacd0b85a97d-47f8dc7a475mr188635f8f.37.1784748451208;
        Wed, 22 Jul 2026 12:27:31 -0700 (PDT)
Received: from LAPTOP-AVI.taile24b5.ts.net ([2a00:a040:1b7:4f41:5526:66e3:5bad:ba45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c7880dsm8585606f8f.37.2026.07.22.12.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 12:27:30 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: linux-can@vger.kernel.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Martin Jerabek <martin.jerabek01@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH net] can: ctucanfd: use self-test mode for PRESUME_ACK
Date: Wed, 22 Jul 2026 22:27:26 +0300
Message-ID: <20260722192726.230729-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use self-test mode for CAN_CTRLMODE_PRESUME_ACK so transmitted
frames can complete without receiving an ACK.

ACK forbidden mode prevents the controller from acknowledging
received frames and does not implement the presume-ack behavior.

Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source IP core - bus independent part.")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 0ea1ff28dfce..8e0a606f2c84 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -340,8 +340,8 @@ static void ctucan_set_mode(struct ctucan_priv *priv, const struct can_ctrlmode
 			(mode_reg & ~REG_MODE_FDE);
 
 	mode_reg = (mode->flags & CAN_CTRLMODE_PRESUME_ACK) ?
-			(mode_reg | REG_MODE_ACF) :
-			(mode_reg & ~REG_MODE_ACF);
+			(mode_reg | REG_MODE_STM) :
+			(mode_reg & ~REG_MODE_STM);
 
 	mode_reg = (mode->flags & CAN_CTRLMODE_FD_NON_ISO) ?
 			(mode_reg | REG_MODE_NISOFD) :
-- 
2.43.0

