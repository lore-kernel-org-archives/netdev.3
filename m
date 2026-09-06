Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C222F39B5
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700468; cv=none; b=ifDzPkGKeV6m8fz3UJNTytUW+L/8nyp4TRIEosm4Tn+uGZCJs8ankTWbtjOH2LoGkCtSvNP+MQAOWTeurlmnMV8qdi0ds7Yy6jWP8gLTHQ2PMuyGat6VCxZCPcj3OYEXuiSan2rRekqI/8EO3JRYCDhqRtT6x/0o44LQPqBW81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700468; c=relaxed/simple;
	bh=gCdi8+mm0Hk4Y2N+V2qNeLa/lwj5SzUh6zHtJRCkuD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chCihQAyosDRPR6x7MaLLGMPYjYmqJzLs2w/u7sbmsMuzLW8PG0jszRy384CWMrgJ/dBYZs6qvACD75faLTTM298C1VckGZ3zeN/ksuRF3yqXlKVLxECUH4HNMGm1wCBZm8WQ1ac4H83ojSAy18qsl51cSIr9DfTie4aTx6Cm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkZX2juc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkZX2juc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d7200b2e15so27871555ad.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788700466; x=1789305266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MHTtcI2u5c1IQWlhLu218IwbzGxGSXh7P5dm0KOUeao=;
        b=HkZX2jucpX5riF0SSdReo+jhQ/Uz3qvUz2h72obwcS7mFL9EfGXb7LqVBQhLJp7I4r
         UUDMSfCoq+gzj5EcjYYh5M57OM9l2hYg0YAkFUtjHBknUDdv+DLtR5tHI8WjCMotW2lU
         vEtDak0u4AwXCjWcpNCA5tkEOTbjHQGjKXLgizgffgAR9OPd+fSm6duoZaExqL5eP8GG
         xlcY3Cq+Sc/kBJe64D/VxuRwhq0TIdlpA0WfFxXFj72SIifB0qa5FfuGdjzy5D+TOTEn
         LKwj8VZ6y0ecbOwADoyIVPrfiL57IS+oVNoHbvoo+9ZNA87Ta2LbS6crKgpM9zoW2wFd
         KSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788700466; x=1789305266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MHTtcI2u5c1IQWlhLu218IwbzGxGSXh7P5dm0KOUeao=;
        b=oabb+Q8G05lrJLElC4FlHekJCltWqkbmmrIDWDCibrVraxndzhoRcRGifGqHG28S2Y
         VNV96VekGD0jO+tNQqAodi2mCTSGMXPpdZvsWp+eZ0DRZIGaEcMY62dh+oEqb6oBGlvN
         EoFGy8KJjguyykjPhNAcyR5efkC+DTo6oDpgfKBCEXQxV10zR1NGnFXpWZlL4Dfv1MSB
         6NBO++qdvasWmR0rgezzYLx+1VRwO/FJpXNpmeZeU9T43jjDoYK8QV7wMERR0knKribF
         o+ysMTtC9SrRkhjxi4hIqtG4V/ukROdhgNdUUgh37gvSd4Pjw+u/EdXAOCruHOHnCs8C
         DPhw==
X-Gm-Message-State: AFuF++n4v5viO2ijRN3FY/HjuRXEug96VIFmlI/d7cydBWZj8+xb5AMm
	5uORQfJsLxWjYKZarZoF87JOChgwnRSN06AgPvXcKRLBdYle4SRHrqyOgSKNfwsB
X-Gm-Gg: AYBFou3RwPPTuzRufbW8ZPwgRVx1uiMHIk+clNBhKsESEc0546RXMx1X5i6xvGtAbNu
	QH3aZaMNR5mvfTNbTzzjMVezD1+0miAQ/AzYfli+UciYKixS8fRq3i3UVLZOA/kSMZqP+rP6+Wa
	y0GENmo0uGs0zD3l/JLFQfui1EEJhbAK67oCZuyp34MzZcoe+PMw1u/o9GKbNufbqnJrFItIELP
	CdeLQAwtiDzwzTUaowFnS5v905uF94fdrY5zmSQh/d/oGD4ESCQivAlReROqUqXhgo6rAkCctFs
	SpCGhgxSwXk4yBjNIzCfgZhD/Ur2kzEgpYVJnRT94SVx9NtImUSej428pgdYqf98yEBglAfeYNZ
	UVRwV5cf1+jmrKI/Q6bBUrxF/NCJ/x+AWvkTn099eaHpW+VifvFsxzLZzdVDSMCFuUNJWSrkTt6
	YrTwT96Q0j6OJOUKzh5s/UNVapGfAGaCrpxIvFHc1V8unvTPMKRggdS3jZODx3ESFGHVScCGbAR
	Aud/cFckoAGoA==
X-Received: by 2002:a17:903:2349:b0:2d0:cc92:f7a3 with SMTP id d9443c01a7336-2db125a5535mr260508125ad.2.1788700466300;
        Sun, 06 Sep 2026 06:14:26 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4d0:7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495b2f8sm32259965ad.21.2026.09.06.06.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 06:14:25 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/6] net: dsa: motorcomm: MIB fixup
Date: Sun,  6 Sep 2026 21:14:05 +0800
Message-ID: <20260906131414.2683362-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix (theoretical) MIB inconsistency and prepare for new devices. No new
features are introduced.

v3:
  - fix build errors
  - fix logic error on MIB buffer creation
v2: https://lore.kernel.org/r/20260904162952.709368-1-mmyangfl@gmail.com
  - split patches
v1: https://lore.kernel.org/r/20260903143514.532023-1-mmyangfl@gmail.com

David Yang (6):
  net: dsa: motorcomm: Rename MIB stuffs
  net: dsa: motorcomm: Split MIB buffers
  net: dsa: motorcomm: Split MIB module
  net: dsa: motorcomm: Use u64_stats_t for MIB stats
  net: dsa: motorcomm: Fix MIB synchronization
  net: dsa: motorcomm: Use safe 64-bit counter reader

 drivers/net/dsa/motorcomm/Makefile |   1 +
 drivers/net/dsa/motorcomm/chip.c   | 408 +++------------------------
 drivers/net/dsa/motorcomm/chip.h   | 122 +-------
 drivers/net/dsa/motorcomm/mib.c    | 429 +++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/mib.h    | 167 +++++++++++
 drivers/net/dsa/motorcomm/smi.c    |  30 ++
 drivers/net/dsa/motorcomm/smi.h    |   2 +
 7 files changed, 667 insertions(+), 492 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/mib.c
 create mode 100644 drivers/net/dsa/motorcomm/mib.h

-- 
2.53.0

