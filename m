Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9944F375ADF
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789798389; cv=none; b=Nq/8cM72+8HwqzzfAClOSsc1tG9jpgtI4rX92xgujEA8gZWsyQmcV1UmoH8lp4w7DXFhlOEu8oDo8tBiN1aYJXRihxvvNC7swB/3v1OdSDx2qGwl2sfb3eqz89ScN7RDZt7Y+G1gINw9zSoMmiePKDa4MJBTu4dJDEF3ZL4yjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789798389; c=relaxed/simple;
	bh=PuRLeK0kxJFu1U0+l/zDyzGHEF3zEbInehgp5gFdOuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h6itJJJ0jcHBEhIDPeXPIOefGQcXtTsiquVB8ROkRhqgEEKtGnqYOlBighB5afsY/5TFVX6raQ41vWCKQ8DNlGhxxnZj07A8GJu0PgtQoE/g7muGIN+5V4B7bcs7fSQ7BQpH4noIsAJtTnbc5w6l39Fu9BYG2VEVD5hqZ7s70gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJqNs60C; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJqNs60C"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396cccbba91so1036557a91.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 23:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789798388; x=1790403188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wKHdeebXXBw0isNjR8wlUSLF2hh2to2En0Awr5oG48c=;
        b=BJqNs60CV3tfjHo4NknUwn+E9JwsuSnYQfWW0nY3fCGM3YqGjZoooyp/QlZ/Z7RQWI
         82Sw/gKjw9HwKmJB/WFV/6kGFX3d/0KzPfXP2XbWNyysubmaHqoj9S7KEKk48vV0PDzr
         tGyhirQJ+fsDSytAKGSIFCgBhM5MQnl6Ve5n/dPJes4wXpNVqheRs+tT6YGuwscZ5iRE
         B3H4X/5hAV179B1VPxMHQzCGkwcDJFxzIevA+I/XtKkFtBBxHcWiAcrdgzGR/VMvEbcl
         lxubkHCsyzFkdICnunTSLTCutG53j+rjf3TA+3eZHjtH1odP2DQiSOkz5R2gZTBu+Te/
         lUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789798388; x=1790403188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wKHdeebXXBw0isNjR8wlUSLF2hh2to2En0Awr5oG48c=;
        b=g5xPjuwTtbEJY/RVLAERicQZfZc9qslazJCVyh+krdoVP8/jGpCeFY4dmQxZ1X+q0T
         zNkFUroIGgFhSgTtnRS7qyCuQDKjyO4vqgi2lKLSUTyaPJYwM4W3htzUAwy5jP2XBaeg
         Ot+k77jeOsURqHm16YYl1yc5Emeq2X/GIpVGJkgF+4kq4xjBFUcFktW4hYh5tTcNkFUC
         qhfYnwBd/VvOaU6ZhOUvVLGJIYoetMmi/vPwbHRnkx4ZVDMPgwL5OHfZONBOPZnoKFkZ
         GKY74sGHUxSo1fdMv4rK1WB7UA70QJEP0QQuQc4hevgKF32AIWJZsPAK2X/HHed8dInb
         DRJQ==
X-Gm-Message-State: AFuF++mp+Bya6nGHVY6HeZ2YkHVPgBwEZIqB5frwsgYzFVtYCaqB23yH
	FHLTKJDMjhNYHg61nT1g/CE3cifpI+L3mEw6fgqZC4WC9C5pQYhblxEp6oQ4PZSNMK0=
X-Gm-Gg: AYBFou0NC0WnLsjOMhl4C3DfTLKhLKhvDOgNrP9UT2TSWYUSu+mDc8ub8yzYBBFsnZy
	OzSHmxnNhPO6xgdT58gG+x33NimgfQW0rd2I8xNOD2h9w1envIAjJKxClcTyo/46tEbUxZL1s7U
	BBTJwGid7vfIqTHVhq0MoIKNEz/u4+8t4bcrcbS78HQ0DgHomXkw/Xe5F26Ag5mThA2jNZej184
	/mzt+Rv5UeBbQ/LwQV3EDdSqRSQumTbcUDNs2FsI7/DcK0TJaKizkhYKCegJvOBMc6PG8DqzFCe
	FhETnjH/cIIxdE4/GBBW1E5NspkMv5SuUmJAjXmE6JXYrfsQafC29nev0H9g6o7PxAtZy20bVU8
	kv4E0vINFVirVu1T94hSUrwmdakmoGePwvI5vUtWEUoZrwKIlLKRon7Im+v2ETPHILFz78ZB4W5
	VNeUA3Nbu7STJNHs0IGGcScK+sBPVQK14YaWJ0YPxk1UFThEXovuqU8dJkU+IrkDuNFGswafmMI
	zCYYsrarxtIraWXErPln1MnsL+S6eiJoDyOlMnTPVa1fc7OjGvlZSp+xXkXy0YuYDH0fdlhjww=
X-Received: by 2002:a17:90b:2d0c:b0:39e:6c6a:208f with SMTP id 98e67ed59e1d1-39e6c6a2272mr2274654a91.48.1789798387875;
        Fri, 18 Sep 2026 23:13:07 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:d11b:773b:fa83:c49a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55f299fsm5781280c88.15.2026.09.18.23.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 23:13:07 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v6 0/3] tc: fq_pie: add per-flow class statistics support
Date: Sat, 19 Sep 2026 11:42:51 +0530
Message-Id: <20260919061254.39678-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FQ-PIE exposes no per-flow AQM state in userspace today. This series
adds tc support for printing per-flow statistics via
'tc -s class show', matching the kernel fq_pie class ops series.

The corresponding kernel series can be viewed here:
https://lore.kernel.org/netdev/20260919060125.38063-1-hemendranaik@gmail.com/

Both the kernel and iproute2 patches can also be found in GitHub:
- https://github.com/H-N41K/linux-net-next/commits/fq_pie_class_stats/
- https://github.com/H-N41K/iproute2-next/tree/fq_pie_class_stats/
---
Changelog:

v6:
- No code changes since v5.
- Rebased over the latest iproute2-next tree and re-submitted patch.

v5: https://lore.kernel.org/netdev/20260902040221.83734-1-hemendranaik@gmail.com/
- Addressed Sashiko review comments (folded into patch 1/3):
 - Dropped empty tc_fq_pie_xqd_stats placeholder; class_stats is now a direct
   struct member in the UAPI header.

v4: https://lore.kernel.org/netdev/20260727165028.106817-1-hemendranaik@gmail.com/
- Split into 3 patches: fq_pie class stats, pie avg_dq_rate
  formatting, and tc_pie_xstats comment fixes.

v3: https://lore.kernel.org/netdev/20260630184453.171410-1-hemendranaik@gmail.com/
- Moved print_nl() into each xstats type block to preserve output
  formatting.

v2: https://lore.kernel.org/netdev/20260614130729.10076-1-hemendranaik@gmail.com/
- Addressed ABI backward compatibility issue.

v1: https://lore.kernel.org/netdev/20260531131411.28213-1-hemendranaik@gmail.com/
- Initial submission

Hemendra M. Naik (3):
  tc: fq_pie: add support for printing per-flow PIE statistics
  tc: pie: print avg_dq_rate in human-readable format
  tc: correct tc_pie_xstats field documentation

 include/uapi/linux/pkt_sched.h | 21 ++++++++++--
 man/man8/tc-fq_pie.8           | 18 +++++++++++
 man/man8/tc-pie.8              |  2 +-
 tc/q_fq_pie.c                  | 59 +++++++++++++++++++++++-----------
 tc/q_pie.c                     |  4 +--
 5 files changed, 80 insertions(+), 24 deletions(-)

-- 
2.34.1

