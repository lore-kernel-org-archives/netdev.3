Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BB843FD34
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672147; cv=none; b=qfYjx6HJDlQVgIRNjnSHmj1fJy/eB9PIIj6csMOO5C8gYsvts676JE34k8hT98SZ1pQOGrD9isjfTRKJz9rcxjZmUaj3EIsYUgqML5KRrl+DtPP+eXo7EAYJLzVtf9iGSKiEqtNwgZ3Cp6/h6BPPy+sEBMEL0sKTXcZSrNuYmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672147; c=relaxed/simple;
	bh=VAWojVejDeGwOkjnDGXuV/vrvqiFfZQoLUqScAaNmRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UheSQnd5ZxOiFIcJzXtNbgKkLKpexWrg+AQUlGv9l0k8fPMsGWOkcMQD+R98oquKP7A1C8XqTFtgH7j6keDZQR6NTm2XxaOqGeGekqaszx5fUmrRFr4szqXnhc8b45LfG3VniaZMlmbqtgFz47cmgnTXpKJvj1h/OQBGWQU4VV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiOpAGmT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiOpAGmT"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf452def93so27402615ad.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784672145; x=1785276945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3G1xZyDLJd9iu8xkf6hvq4eD1i/K79dhkC7e31jMsW4=;
        b=iiOpAGmTDrBN9DhNpClATKCQTtxhwoulGsJQyCUccqhFlFCsGZuwt5lgaJmxaXe4I9
         ixNA7s83kig34k0BM+zbEElc+kPoLSEhL3vtfaGUDcrFnqUr99PIYSkGyp7S8Rg56P0Y
         0V9g7fWMzHaRX7rQgIysk3Bh2bKsajVkuXQMHnOls+iWydI1tkwkAv80ya+dT2U79OUF
         2sXrEylDbSEV5cNNyrj01/3kpdFBZ5FW2UJEKGhWnn8x5Cb9HV3MHKl81ad/11GbYPbc
         ku405UYHI7Hy6W2dZtlst95fbc7Gpj1SonvRyLxEAhn14viUuLNExoKVnm0AopGgtEvW
         aMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784672145; x=1785276945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3G1xZyDLJd9iu8xkf6hvq4eD1i/K79dhkC7e31jMsW4=;
        b=Z654LlA4zYbVGKC9HOC6iaYiWLWuX8zwH2rg5O2Jn6Ww1Kos4LaKN/zKH5K9f9r9jF
         yWETv+kJb1QUAph5EH8usyPkxXc3ZvjLK+Lg+VXj98xVNFPKNNE1/wJwKc71+Jnt0Ouf
         zzouxRjjoS7OKPgGO8UuZJraKnoCf8C9qkANHCnPxHLP7AsBaW7es8+nuqPX9b8C7zZK
         WIpVkPuFl4pClDjFFSHPnB5nXUxrmrW5EuolwmGthMgfqwc1syk0wR3v6T5Rtw1Ga616
         CA3kbozmlBMRnKH8n8mSfkk++j9fuxRbK/J+6Sx6QiJkThIdx5qQRArqnp2uj6JoKzKt
         UCrQ==
X-Forwarded-Encrypted: i=1; AHgh+RpgbjvN1pejAPztcttQP5kyJeWru/MIYyTWQT8HnIwn5ZSFqSWRNdF+tCDxwbVyIyDzqxApvQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZbop4ywF+li1MXD9bF5W9Io59xK/HrPEBOGXpNB0s54ccWSHo
	dif2RNShXGwGFKDZqBZSLVBo/y6eGoTsh/hES0H4eI0asV08Vxi7q81z
X-Gm-Gg: AR+sD10g7l1lyfDISRULcNMgJllLg87z+Q1n4/plGe//XJU2GqTNuY9tGrossOveZ5q
	MXnEVxQb6HnRE52e/aQMhUQ+T0xi9UdxRyeMt1t+7XxMX+I5R+n8IVdUW/qOl8T6z2940GOvr7d
	r/wZpw01Lkqw5FeVeSfNbWayRnDgdyJxrhKI9GRUZBkJy2vZSQdUFo8m9/LGTeu+hPqUCBIOeHQ
	zTW+5McnjGGgIiDpXvTztD0c3Q8L9rzqeKZhEWTRqHsUFFes5ZK3AvToHj+6iGeMdS1DW1Q4ox8
	ozqJm25S3aupL3vPFlLM2+Ra+Bp2cvKYvgAqPIbHXwYMqzAIK36CUYzWlu4gedn0oYroRZu4KI8
	eySAQr/T5CyagEmBEFOzv4LrIZ9jRir6o7Dg8El03/nP5JsUahTT1YxMnDHrldofn+zHCa46SHq
	hW5SLvixl+IlDf5k5w
X-Received: by 2002:a17:902:e5c3:b0:2cc:db7a:251 with SMTP id d9443c01a7336-2cf8dc6d1c3mr14543185ad.2.1784672145071;
        Tue, 21 Jul 2026 15:15:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::9edb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1bc886sm2079950eec.26.2026.07.21.15.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:15:44 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Simon Horman <horms@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	zinclim@meta.com,
	Zinc Lim <limzhineng2@gmail.com>
Subject: [PATCH net-next 0/6] eth: fbnic: expand hwmon sensor support
Date: Tue, 21 Jul 2026 15:15:34 -0700
Message-ID: <20260721221540.648272-1-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic currently exposes only the raw temperature and voltage readings
(temp1_input, in0_input) via hwmon. This series builds that out into a
complete sensor interface and hardens the read path.

The firmware capability response already carries per-board sensor
thresholds, and the firmware can asynchronously report when a sensor
crosses one of them. This series surfaces both to userspace and cleans
up the supporting plumbing:

 - Move the sensor read logic out of fbnic_mac, closer to its only
   caller in the hwmon code, and drop the now-unused get_sensor op.
 - Expose all hwmon attributes unconditionally as read-only (0444).
 - Cache the temperature and voltage readings for the current jiffy so
   a burst of attribute reads issues a single firmware round-trip.
 - Parse and expose the temperature (min/max/crit) and voltage
   (min/max) thresholds. Thresholds the firmware did not populate read
   back as -ENODATA.
 - Add the corresponding alarm attributes, computed by comparing a live
   reading against the stored thresholds.
 - Translate the firmware's sensor-threshold-exceeded message into an
   hwmon event so userspace is notified on the relevant attribute.

Zinc Lim (6):
  eth: fbnic: move sensor read logic out of fbnic_mac
  eth: fbnic: expose all hwmon attributes unconditionally as read-only
  eth: fbnic: cache hwmon sensor readings
  eth: fbnic: report temperature and voltage thresholds via hwmon
  eth: fbnic: report temperature and voltage alarms via hwmon
  eth: fbnic: firmware notifies hwmon on sensor threshold events

 drivers/net/ethernet/meta/fbnic/fbnic.h       |   8 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |  75 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  30 ++
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 260 ++++++++++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  55 ----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |   2 -
 6 files changed, 346 insertions(+), 84 deletions(-)

--
2.53.0-Meta
