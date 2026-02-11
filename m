Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CEE2C11D0
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829653; cv=none; b=jRvJZhJHrGhXWyPyCxz5g35qqM6Sq1W/c3KqxShoKfrdeX8bhjbEhYodR7SDtEepzk+/I/9T/HkbMJV0GAuqss0WA9VQJggvlUeXrpOvDM9W84kXVmn0vIP1lCqoy5Peb8mbweVfoPoYH/frBOVBEoiHdgLJyektONx+l/W+xEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829653; c=relaxed/simple;
	bh=6z0bwNW+j8/3sMJFz1mkFhZEkvmLjfR5rLLO/MKoDBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWNycAh71PCy4oPZh4golq9juaalPxeDSct+zkvD7n66+SmoHg0z8bDiVTPs98Wbr4oRTdJStoKABxx3lVs/DVSeLV/abt0HiFPnwPpQ0eOjljRm0Q9e3cHZhhkgrdpY7FpDPbZvtfD6JsiQAMhzCFZ0dsHMR5lj5Cc27z2eCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=NI5s4K0V; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="NI5s4K0V"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2baa098ffc6so612900eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770829651; x=1771434451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3iX2DrcUkWAVlNTZjpbrIYhwk2Itva/TzDrI7nJhLMc=;
        b=NI5s4K0VH1Xjd8urUGWJKDMTo2uhIz4MwlkMVVZFn4PgmRzv/P2ub70u+xJt0b/XiC
         vz///VyWeYc8H49/0UGhfTqGqAeKXFwrIRvTk7B/Hip28rz3RS+SphBYP6O3U7ga26TP
         SaJHUjFWfO08NO1Jc/kC7C/CMyihyvhawEZvB2MPb/nsw36xMZaiAvH6mk+nrRALEbPV
         LFOo7A4ZRmfMW+Z/I32Y152lLd6RBIKVxmmIvBnme/GE/qVv/ldVW8xC2jxlYspwA1Uo
         UELg57bgAwOmf40IWpM4n3D1ixFqulGWmiErIvtZPpqPUMKPEm6ywHiWwwCgvZNHzy9K
         6R7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770829651; x=1771434451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iX2DrcUkWAVlNTZjpbrIYhwk2Itva/TzDrI7nJhLMc=;
        b=SoI7zIVqWVaGo70rb/UkVocNOP1q9eCeN/T0xfOw9IHCSHlWLh0FTUyeLHp5qkGcjq
         L65aYkjkR0lW4sfvS1gWaqXGfbLj8p+HeWceIRce8V7V3Zrg7+gADMpUgU0eHetFADrR
         svRVIkm+7FHLuPZpk+DC5B4xz++Mo+BLXqLywQvuEjqMyfObfRlaHcSZo4slqmbMd0kW
         bhhaIi79k1EitldNlz0WjAYQC+59S7Uw0gJNDuGrCYVj3OZM9hCQLkAFwAGlc8EN55Ti
         WRRldLEAgBTGBjRLT8qEbyxGbSONwjgseMbJkO9P33TLzm3lJlbbBC4Q5I2DHS9MxEAN
         2FQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7mUu+Z/0XC/JqjeSeCtJ1FXRArpv5zBIDHFX3dxw9wZtojUeErzG36M5ZsnSFXQLp2F4gFRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUUTEAZxUEj8zLHiDB+yk6dtDuFhnKMuYbcjQhJo175gHkpVy
	4XHFyhltoNAarmf1YG72JSjpiqtqr0o6YLXVlxrMHDzm+MOj76LHNr/ZFgBSPVD01g==
X-Gm-Gg: AZuq6aII53vDWqOh09fKsOCUtF7oG6+kz75ls/dD3qhvIuGifcEUTDI4gqo3kbJ2dg5
	KHntzE8w5JltFIH6RDdZYLkD7pWMGd+Hef2JoHO/5b8Gr1dwmzXdmRjBQIZnjIpX5a17cjdgoZ0
	J4e2d0Na2q5byNCTG/qiW42NO4354Aod/cLjB3OHzg0NsNJOFhvkecWLZWUCJ63i9LGZzS1xsmQ
	y1+5TjqlTi/n/ZCkfUeZSkkrh+NhG6myp+ottL0XOXwtkpuErzjfgazxwL+XOy1vFXL6Yzh8mfP
	MqQG/WcI4zGmPO6J2Xe4iVNZca4gOVLa+LDG0SuPaxGXRtOWtQvYvLWmnfMEfiMba9sCIgyJKAA
	Xa7URBhvAXZFxuR9GLHX7qVCOCoQSO+7j8/2hxmVwdVLsVQo0j2bZDjdXHQTM5/2sAo2Ax0xqON
	bRFj2nhhPmH+DPellxjGehMVeliJaNUg==
X-Received: by 2002:a05:7300:bc84:b0:2ba:7b0b:e1f1 with SMTP id 5a478bee46e88-2baa7f964fcmr427eec.17.1770829650727;
        Wed, 11 Feb 2026 09:07:30 -0800 (PST)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4efb::2000])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dd00ae7sm1649496eec.31.2026.02.11.09.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 09:07:30 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: dsahern@kernel.org,
	stephen@networkplumber.org
Cc: jhs@mojatatu.com,
	deren.teo@outlook.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 0/3] Add JSON output support to the remaining qdiscs
Date: Wed, 11 Feb 2026 14:07:22 -0300
Message-ID: <20260211170725.1514427-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since qdisc core already assumes all qdiscs are able to output JSON,
add JSON output support to the remaning qdiscs (HFSC, QFQ, muiltiq)
so that a JSON qdisc dump outputs valid JSON.

Victor Nogueira (3):
  tc: Add JSON output support to HFSC
  tc: Add JSON output support to QFQ
  tc: Add JSON output support to multiq

 tc/q_hfsc.c   | 29 ++++++++++++++++++-----------
 tc/q_multiq.c |  4 +++-
 tc/q_qfq.c    |  8 ++++----
 3 files changed, 25 insertions(+), 16 deletions(-)

-- 
2.52.0

