Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF522156B
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770591366; cv=none; b=FOiL01F2FHMtqNTbhpNm7i2SX+IGoWY0y+qLG+rrYnwe6tUC2HrnvryQp0Ff9MU2hPkUvTly7xiRHWfVfdfbAYKvymjMPBFX29ga7q3kCVMoLOaKkKCwER7aqDoEEY/accbD7fEPfGloDFRgudueQLiOKgMVgRbN8lRiQasJIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770591366; c=relaxed/simple;
	bh=epZQl6aH3Iprswq2Efr27hhM3c22tI6UZBYC848lbeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RykZLmmLyeSn+4XeqaYRTBthBpy4uGAe8P+Vjn6l5Q7HNC8T7Vw/LHdWS5nmeThADDauhgKt3scfbkmvlwsue5aEbJDqas31mugSCrUps6OQdsAvPCBAAnHJ+Ayyl+YPz8vyjDt1HPHevN74L1RGllJJ/S7sqNzN6qVsABZH3Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=IixtMTAE; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="IixtMTAE"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c70ce93afaso409766785a.0
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 14:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770591365; x=1771196165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K3KNNR5e8anJtagKFjGB5hLb2oNmHI5i5qNA4+TPpUY=;
        b=IixtMTAEZTQWHlF93lViqKvNpr844SowkJ+UnG9dxbNXUZLk87a9PTvGRDil8quG6X
         hArgEjfvbTeP4f+ZgSNLaFbhe6SYS13PvWjghHBzrL/AV8BHY1uXFy+6G1FMX4tBh3cI
         O8Cs3XbrYF5cCm7TA5FFK5hHnCuAKwPcUnF1znVq1ULP1YoqEIYAECr44hTjnPKei245
         0CL2pNp6b6QG92waRAfPyVNL6xxs1lPF4g5t2LLQ01UARxPBJ06axCPpH7vh8cwyLt4J
         wy6p2CRq7pk78hCeDV94oxMlB2YyYNjYldRNrWU1PPwAsQ/imurRIOKATCBA8HPbTGd/
         X4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770591365; x=1771196165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3KNNR5e8anJtagKFjGB5hLb2oNmHI5i5qNA4+TPpUY=;
        b=njKyYnJBvxwWkH5KP4tFh8GOGOyv5ardiDyNIbSbSmOKE3FC6tOkAzsxlJsdckYPCe
         1WDh+L4mGwf6rILVFvQBbTCRodvf+JfWxM9UUu52/pDXFOvX/g7S/pklc/I65HEk5hVt
         oUxYqxfzxFNtZZv4LHJEdKDg8uq0eJZREkaOnAVn+XoHFdnR91nMxNOUsQ2KKrTgikVn
         PDgRVUSYj9j0WB2j9jBZGYnkA5DQojlMeAavi8Wt5thgicbNBi8D5ZFG1I3qDkvnbYDo
         DeSMqW86RGa7tnLACz+f0HYmuPH2+opqQjO5+gqvmd/ZW1koiPv1dVruBMJCu4iTxrmd
         0RxA==
X-Forwarded-Encrypted: i=1; AJvYcCUzT2piFIRyKlt9AP/NZrUB1MUiHS9c3Lq5YaOjiM/b6Q6zVJBDDmA0XGFAQ6SwjXysEG7x8/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbo1vhjb0DcCTX4HwTM+ziJ5kHafR4VMzwV8qBw1KC4Kx89lms
	ZuK9ddF8LT9t6bMV0s62eA17bc5Br3qv9bg1a+XZiAlAJ9hbooQsjKTKHkPYjGyYUmo=
X-Gm-Gg: AZuq6aLoZLB26p1iV51CK4gTP1IowG7zCvc6DE9UyQQ6Z7/jRp60U1dq6gLRiB3iv+N
	WWvmdY/c4gEk80ekovFvNxj8PtwLUDqh2Gja/ExxoR+ZfISBiFJicoqhoT/o7LiTFTk1Ef4Xv2Y
	jnFEmRmh91RO91QtMsxGgPn87rZctFeCOerboxIvXKgjA+V6DN/qywvr7e3CWJYClJGOEWitRMc
	TETcSaGZElklE4gHsD0Lah4OfnXI49yx8rsNCQTp4e6Cb+gtXSI4Q1QVnXzS4fY8r8OQX6ay+E4
	glnIbTC+MdVT2t8w+xwaogorZszo21u+hwS6K7DAPJRi7/t/PEYznU2gLEiwC4OIDLxELf/87KS
	d57Q7kdB3bJjEnIo1f2VM5yFfZRqVXMjVMG+O/UT36SS/rgw3lRj3tcyo4uoh49yc/KwQCXQfmz
	yhxCwllriTOze38VPorE7p+JJBxddJ1iy8n3cegKWSfz9/HP79jQP+HS533/a3s96XvsTPZmejr
	4QewOMKfQc4dhfLFUROAgEQzLqzDjs=
X-Received: by 2002:a05:620a:458e:b0:8c9:f996:81f2 with SMTP id af79cd13be357-8caefccac00mr1216907185a.17.1770591364743;
        Sun, 08 Feb 2026 14:56:04 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9ee9efasm679622485a.43.2026.02.08.14.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 14:56:04 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH v3 0/3] net: mscc: ocelot: fix missing lock in ocelot_port_xmit()
Date: Sun,  8 Feb 2026 22:55:59 +0000
Message-Id: <20260208225602.1339325-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ocelot_port_xmit() calls ocelot_can_inject() and
ocelot_port_inject_frame() without holding the injection group lock.
Both functions contain lockdep_assert_held() for the injection lock,
and the correct caller felix_port_deferred_xmit() properly acquires
the lock using ocelot_lock_inj_grp() before calling these functions.

this v3 splits the fix into a 3-patch series to separate 
refactoring from the behavioral change:

  1/3: Extract the PTP timestamp handling into an ocelot_xmit_timestamp()
       helper so the logic isn't duplicated when the function is split.

  2/3: Split ocelot_port_xmit() into ocelot_port_xmit_fdma() and
       ocelot_port_xmit_inj(), keeping the FDMA and register injection
       code paths fully separate.

  3/3: Add ocelot_lock_inj_grp()/ocelot_unlock_inj_grp() in
       ocelot_port_xmit_inj() to fix the missing lock protection.

Patches 1-2 are pure refactors with no behavioral change.
Patch 3 is the actual bug fix.

v3:
 - Split into 3-patch series per Vladimir's review
 - Separate FDMA and register injection paths into distinct functions
v2:
 - Added Fixes tag
v1:
 - Initial submission

Ziyi Guo (3):
  net: mscc: ocelot: extract ocelot_xmit_timestamp() helper
  net: mscc: ocelot: split xmit into FDMA and register injection paths
  net: mscc: ocelot: add missing lock protection in
    ocelot_port_xmit_inj()

 drivers/net/ethernet/mscc/ocelot_net.c | 75 +++++++++++++++++++-------
 1 file changed, 56 insertions(+), 19 deletions(-)

-- 
2.34.1

