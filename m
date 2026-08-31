Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119504CCDE5
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211362; cv=none; b=u+2IQRzpHO7n2CfICCrz7KoWqLPcmQO080U5Sh+SX4MmPeGP6GtmQK3wxqQyzU/J8Foy3yffUcU33AamJdQexkB+0MHIQEwwnMFFhF2nptpkcYQobDRvCCf48xUp048DIRVhoWTxvAjgw9Iu1tkVvMvZBIVyTwEF9oAcGH+qqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211362; c=relaxed/simple;
	bh=j+4P5I1w7yupkjtI1aHIdS2EV8F3BTV+hCLwZ4e00/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DG15UlSNwQ1EP/+/I914Wbo3vPcv9fbERllVwNgrsX3yYpDCv3Bgp0P0FvGQDa8s/9DUwRhO7EJtFdjankoEkTgga1a4wpcuhMsPyfwG6cad5nLHm7/WJB1LcI05gwiI+vfmkQj6eA8FOG/hAQeIF9RgwLf/zg94L/GXCneRVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqaRKwV7; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqaRKwV7"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-398e9698a70so281369a91.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788211359; x=1788816159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tAf9E7CenHe6l5YzESk+eJosOnuoeSazKjhyH+9ql1Q=;
        b=mqaRKwV7gzP3vr0Gb29m9Q6UjUcqfOmdhGLENM3ypRBGi1cIaU42yiz+8+OE8YVqmP
         y3J+3HJ34+CZSBPDyf5v27g2z8D+S9llW+g2udUGRnCmi1gz00Z5yjOME3g4JJCjExf+
         crxYmIeDDEKN6cb9tEEEisSB8RRlzlNmyMqpJ5CnaNvQokJbZ6wDmt8TW0k3jBfZuyeN
         CjKttedYveaNoX2nh06YxKdfMLXURfLB9w54N8a73s3Mu/nqBQgrvb4xJz08giZZSWrk
         59P0Ya/GWsf/84WKACPpaKtJyeGY3Kd8IfQPtDykRK06rUViYPKC/csfJnAYEl3Y/Grm
         LiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211359; x=1788816159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tAf9E7CenHe6l5YzESk+eJosOnuoeSazKjhyH+9ql1Q=;
        b=RmjWwbpNCiWxWXGvedZrcoVw7SGk2ug8BX6485Kp72gTCTjCfXCmlgcBBNoG8/SRp8
         p4nH3AbKUkIPIR5sYEW7G6njYO6unwb0K7jyRqQBFR7lONBmZqYHloUEbJ9PRYXUniMj
         lxFIpHh4IPhschxh5+28jaMDdI/FpBDrNTgRwfV8kJGET21jDXMl1/dism/LcP2EL30M
         5Z1/X0v9K3NTJ+C3ZvuU9xBKzdDenmQtSmHqPwymJpXAh85JES16RrJExsErYbPbgJEf
         61VUtaR/qpRUzEWw4UvkPrcLYbU2KPx1T5qD+aSwuDo3Oh4glDXgchZUnPKg5HxF13+e
         CSJA==
X-Forwarded-Encrypted: i=1; AKwUvBwSOwDJ8Wf43ZCsUMSeBtkxJrldsHIy8LBPzHWIfWW4Kh0G4IjSdjV9fkj6WldcayiZ1v3mSlQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nNF3jvc3BZc17MbFGlq9w1VN6pZkp0KGDfivEJ0dxQ9zDA2yH1
	Odfi6Nc2uulPCNGzfRaqEsOoEO1Yz8BIOlpC/vxALP48UFKYxdepC+nvjCT81g==
X-Gm-Gg: AYBFou0ZgIQ5agru69ADwqCtRToUNwcHQrq2k6lBNNm3EAsg/0q6qyHBnPoU726r11p
	6ZG7/aoan5ACBSWMJZQs3/YcCtrJSDAt/KUkpWBPpJhZJrVbkscH0f8l/HQOeXY3qEC7fDdgFEU
	LSu0UnbV2I0Ww4BUccSiriBlrjdIp0D+GF6bCLzq+QCdPsH9s5Db81Ezo/iB4iEIPw0bA0+JuMT
	QhCaNDertxLn1L3ly9CEbZ0+Qoaixb/tnDVDfruBSL46RhGf5acj9c54QUXXke5WLQeYsDLuflH
	QQ1CnMaN9QJgP/BqAYloukRtPQ0ryeUmatpTJsLiM8ETOCPdQVbPwueHVurrsTU2K8JDku0BoHe
	M3XPS3EIQiyaQi71B6dz0y2NvwrErdaOCT3ye5zb38cwjpaaC7mLA0JHsGYxM3O3r8/MYo0u1kx
	NF53LEChN/WI+JZI+F5Zw7hHBDWp9T52lRrXn4uriCVfpA8oK2fQNtOejn7WWeyPa4mFUgVNC66
	G5aFQ==
X-Received: by 2002:a17:90b:588f:b0:398:bf7e:b267 with SMTP id 98e67ed59e1d1-398bf7eb378mr22481809a91.2.1788211359423;
        Mon, 31 Aug 2026 14:22:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::6:bac7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0bf8a13sm45871957c88.0.2026.08.31.14.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:22:38 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@roeck-us.net,
	horms@kernel.org,
	mohsin.bashr@gmail.com
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	zinclim@meta.com,
	limzhineng2@gmail.com
Subject: [PATCH net-next v2 0/6] eth: fbnic: expand hwmon sensor support
Date: Mon, 31 Aug 2026 14:22:28 -0700
Message-ID: <20260831212234.1212971-1-limzhineng2@gmail.com>
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

Changes from v1:
 - Addressed Jakub's patch 6 feedback on including a
   if (!IS_REACHABLE(CONFIG_HWMON)) return; guard.

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
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 263 ++++++++++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  55 ----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |   2 -
 6 files changed, 349 insertions(+), 84 deletions(-)

--
2.53.0-Meta
