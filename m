Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F87221CFE0
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769371386; cv=none; b=aiG6zsURczYNYLHBUDAmN1yW0NNoaTRLFk/S1CvqSUDkgKlKLdlHz/YL11A13cvD8keJ2sqwn+ZMGdWieYDegJm2pRr0caG7t3D1tC28VkAoDzsRfctpopG84yAmkqwXW9h7KNJtHOS1FDP6de0dQ5JEeHCCe2uiyriNxNVcOag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769371386; c=relaxed/simple;
	bh=tbSwx0lCQ4pXqGFoLVTyOfGSw9UfpsVRwglYS1hGf3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dc8GCI5V9GVw5rvHfrNBQFIDZ4rfEdNP8cwZhnmTSDGWLJU/uKXmIqLMYSFoHbC1bk3tAwpvECYof7NXn12Z+COKvBAxc5NlldNZHPUTr0e/tVMNAQamY0II8onRAMIDdDUbPjur1kVMZ4Kvux3HXAcBTdSNpOSqwSicDn5ixYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeMUwQ7E; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeMUwQ7E"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so3384879f8f.3
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 12:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769371383; x=1769976183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=loP+b95vMbOSoyIR83NDDZs7yFSKvx4NPA8KoAIFKhQ=;
        b=OeMUwQ7E8/B0Eu6avVOyBaz1VggD1pCW1UR4OFIWpy8e5OXfqZ2BzcQcFYJUj1JnlE
         heGJTOaYwjrZKtvcvRpsvCW1xUnmt1e8kTWujqY+WnyQd60oL8BzjtqbCIG9F5mBPqFS
         5qc8NZ7lZzrULSjuunIubs6w8EFJFTJ2nRfr58403H0Mu/LSHAfRZqPabXAxkMBtXxq6
         GdDHZ8ecQEfa9Hsj1hrAGABxhEbJX+W97v+/AInCvLR99wzltuBLNw9/zxSeZuUmhMeq
         LAuq/Oy7qjxzd60gVlj/XGNsw8RWxr3qWLXMEcLKjE42IMHUTEJOzmTF5KUTY0OaF7oW
         Nzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769371383; x=1769976183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loP+b95vMbOSoyIR83NDDZs7yFSKvx4NPA8KoAIFKhQ=;
        b=HPK7MSoAS9rIwHnhg2qYnc1bwGETsijiNcVyLcDrXrYV+VbpjoJWGthfHcZ0u41N51
         X14cQRI46vq/fN0atzg5lBgu1eIyrePqMee+ZHowv6f/A7PzDQq7wvwsjJ4B59l7EdLU
         D3XuF5dmwoXbunMgXJgy3qESxLshR2eUM4Tkvsg9uzAQnU34yYJYI8AbLLCQbYEc9Em0
         AcCRGuZmaVQhbeMKZ9V7RZblGoEHufzTqPmcvKzYQ3+Pd+EQoS4iXMiQDcFWPiKPqaUF
         W+k1Kg4TgmOYGFuYkwpa2kuMXUYtzOLYOYiU6/0Dq1KijhVo2SursinJNp5BUntDQW9e
         9Ljg==
X-Gm-Message-State: AOJu0YwvdYsK8cLY+QYsytbAfm9rtGEYVs588FWXNHwRmuK86LSnLGN5
	cBrRttO8xQ8kiCnqIC6aVHhCUBIcyhHlQGXdzpAR1VKvaEQZwXB8I+ih
X-Gm-Gg: AZuq6aITZwK2EjdT+Hj8jIVb1tTUp0s70HiE7XaUENbhXAcBjbMkXkFzQqMuDuZR09X
	SRqqQa4sf/JXe6COkEQBGRrwsORf28Iaso4Q3gpebvYgi5/nFJ+uQ65WhAn03YWcGG0qDuJ4+FX
	G0m9LuLbSjVYHMDx1I18CaIZA64hlIpgQXgA51Qpm/iO5R1rlNcr1aVm1mne1Nohy/aAglHObum
	8x1UNTZ8k7MdtpKk/tFaSTqnISO4ESMbd2NelExtz3eWqC/iB+U0hk/n8s4qmK9qSJTB0LAn4Br
	3ogQKUL94UV19gmljRXox5VERmBisxnByIiJrl76zJC80dLlpe2qcRLLhWaAjutevUzs6jQCmVC
	IJrDeKoKMmCUwtDOuCRWnrt6eid4OO26QosTtQ+SkV/zZpCupKliwsVghMUW/7v/0mk05nrorso
	/0J4MOjfyLkW0=
X-Received: by 2002:a05:6000:4210:b0:430:f6bc:2f8a with SMTP id ffacd0b85a97d-435ca138f6dmr3758503f8f.47.1769371382610;
        Sun, 25 Jan 2026 12:03:02 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7c269sm24418036f8f.43.2026.01.25.12.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 12:03:02 -0800 (PST)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH v3 1/4] dt-bindings: net: ethernet-phy: add property enet-phy-lane-order
Date: Sun, 25 Jan 2026 21:02:56 +0100
Message-ID: <20260125200259.2903271-1-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add property enet-phy-lane-order to the device tree bindings to define
the lane order of the PHY. To simplify PCB design some manufacturers
allow to wire the pairs in a reverse order, and change the order in
software.

The property can be set to 0 to force the normal lane order (ABCD), or 1
to force the reverse lane order (DCBA).

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index bb4c49fc5fd8..b8cd5d2b9f76 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -126,6 +126,12 @@ properties:
       e.g. wrong bootstrap configuration caused by issues in PCB
       layout design.
 
+  enet-phy-lane-order:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description:
+      For normal (0) or reverse (1) order of the pairs (ABCD -> DCBA).
+
   eee-broken-100tx:
     $ref: /schemas/types.yaml#/definitions/flag
     description:

base-commit: 983d014aafb14ee5e4915465bf8948e8f3a723b5
-- 
2.47.3

