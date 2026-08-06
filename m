Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6503A75A8
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009483; cv=none; b=XCripytpc5eo8NvTBvW5C+F7l9yr+qkUAqCi3c8B4ZhzOslAXAuR+QjmeqpfgcwzjyDd3u3lqd23VEqZLlH7OUBgb4LRoTlcWApG19VB2ViqerlvUpKcChUERNAKVBGkHCQJLH7sk3AV2oUS8EZH0ub19OzawJOvDy8L4r0SGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009483; c=relaxed/simple;
	bh=vdkX4eebTtkhLyIGl90t3Q0HZY++abfc/keJ1pJN+wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZletoTANHlUjceBbQVpXJYhARJEPvBzJIVSdcNdfCJ8odQHQCH2ZZQy/H23/3/+WGoFf6N1XA2lXhCHWE0nPrAdCxTNoXjCEVG2rLAQ1Bmn5cpjKKKiaudevP9hXDOi5S0gEegv0D3xmt3AaESCP2jIbYbkdO8If1LW2LjP+RhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=qFGJkHM2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="qFGJkHM2"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso13135635e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 02:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1786009476; x=1786614276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MX2YzNWvEMDzQeeGnNYveqZY8Q04vUi7OanQIHc/P2E=;
        b=qFGJkHM2CPu2za735TLbBmSdTzosHkD/Psg16DWMfzMgFk42tszf/cVeBLi2vs0uvM
         zV99Jmaqu+MQv8TnAIQiXb2aDAwr6AS5ov6GHGndiTjD6lE6X8aRF8td0g7hiyiZeUD5
         cLZInrS4pGCoe35elwuy5T0ItrjqY3b//O+H1IEQ0pkDTKVLd45ZbKiakLvitMIybpgH
         Jn9XrZKDLYKyRn0vvclwNdXr5VsobMjUl53HQ5fSNF4P5N943nqjVJ0AkpsmAgBpJ38V
         7BZGqy0lrD1QCpApWeHJMGOSsOaIWNAzuqyd14/Gc87SBo1mtwlrvf+XBc/cVaS6Od93
         wtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786009476; x=1786614276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MX2YzNWvEMDzQeeGnNYveqZY8Q04vUi7OanQIHc/P2E=;
        b=DPPS34FO7rQyJEHc9wRqhsMnI6nRUUbs1lNcngprIhajYxMDnP/QNUiQd+LjJnlZb7
         VNPJuJIhrqmY7N0hGkkLZdlRhSmumTJ5WmfPS/4w52f7sGEDzEdFnx6D+iRirC54RZqW
         3ko+OQthyiAzSF0unG7rjwL6ikCTOnX12ggQsvgvOavOsQjNc12DDg1cNT9HxW3uQ0yO
         Z8uYhaFuM8C/9U+ZUwanboldZIad60vWwFAADG2COiAqYXvQuDWIzec472GZqaEoUL/V
         vK2PMhe2Bh/Firiu7xBjcAjXrK8jHbd0/mo82X6s6DAp6adV5btOxN8GR9P2MYWARhf3
         ND2g==
X-Gm-Message-State: AOJu0YwPIvUnNSdf03WOluMBJfUrHyHpnS0W4tgRUJrcPcmIq82tVlyY
	HaMuqj92rvaWXyPIu1qqzOJhhilwtD6fk2bgnHGFqjyFcPwC5rVJ7UiMzZRiJpX/9WAtaD3mBGB
	xtskV
X-Gm-Gg: AR+sD12858NZMjt5ZgBqf5vwiTMd/u/1KeHZ28AQMsdCwNzuwUu+Ni7t912sZcljmCm
	uW+9+G4soHF/Dq3xxYn3DqQ8yzueuWIFtQi9VUlUgP3XJ30EHAy9ehaBDd69GPZGUCGCgTjZ0cc
	7ZG0Ll5p1xy9gzeh11WMWGfZeUts/6tNae8vlVYN8DQL2Mg8EaAXXAExOFQT/Zv9yLjh5grpINa
	ecn8QgXLs2AK5U9csiB0fzDxC/KLEb1KJibf0sHb6TWej/adPtjPsAXW+NseLHvkRced65rERSV
	GZRc/f5+bPS5Z4wDTcb3FWIMusSqPF0kHsnbTsz7G1oG+RDyyeEAHzIEK8tWjnEJwfqBWaa9JJX
	Bh6C4rF1BjaijpFY2ioZcKU2Ujf/wqtdGR5FpcciY/zKLyZphyUesGcZtSr88HkBzTbmuvPFQzs
	Y9TkS2j/4PaiF4YfxYgw26c8RS5UqUaFeZPK6JF5aTtK5PvZkEcKjmxsL8PchQUX+wqQzbM92An
	9G76HqB
X-Received: by 2002:a05:600c:1991:b0:493:e451:a9e1 with SMTP id 5b1f17b1804b1-4994e7448d9mr164090705e9.2.1786009476309;
        Thu, 06 Aug 2026 02:44:36 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995421fee8sm45564495e9.7.2026.08.06.02.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:44:35 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	ivecera@redhat.com
Subject: [PATCH net-next] MAINTAINERS: add Ivan Vecera as DPLL reviewer
Date: Thu,  6 Aug 2026 11:44:32 +0200
Message-ID: <20260806094432.163833-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Ivan has been continuously active in DPLL development and discussion
since April 2025. His contributions cover the DPLL core and API,
netlink, bindings, ICE/SyncE integration, and the ZL3073x driver.

He also regularly reviews and tests DPLL patches from other contributors
and already maintains the Microchip ZL3073x driver. Add him as a reviewer
to reflect his ongoing involvement across the subsystem.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03bfb79fca2a..ea683dfda21f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7870,6 +7870,7 @@ DPLL SUBSYSTEM
 M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
 M:	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
 M:	Jiri Pirko <jiri@resnulli.us>
+R:	Ivan Vecera <ivecera@redhat.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/dpll/dpll-device.yaml
-- 
2.54.0

