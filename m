Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D632B13E
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940637; cv=none; b=ExaFxEpFRn8VtqAMrpVRxMaHaUvbQlPFsvkWdf81TpvkgbrCSvk7p/W663s5KAXcvGCb+69GJ0wb8mnAt82rK538ITlxtVdDE+eJlw3kqTyBHcjILUuGNFPbrMWbjd1Ie8AlO22sDRwBeNnmyZA9OWAfk5K4KHPuqeqY0tAHD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940637; c=relaxed/simple;
	bh=6Ke/qXuAFWpOwvA+TbsjbUYyyLE9fGpPpz2JCxY3gU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T3Eh2AoIF4txeZYiLJZ7sV7iATsfmC7JzFBGttmJLXO2iVIwYwTkM4/fsNJC67axbm9Qvta5lpYiaj1I7+GI5cxrf1lvcm82wafW7flxJ96W5qE1lw7Jf3oMoey66cvWwZeHHOKvHlV5WFO3vKFEwP0UcmsmK0SJa7SHMstpbGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il; spf=pass smtp.mailfrom=mail.huji.ac.il; dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b=ospvDtLW; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b="ospvDtLW"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-499db1a5b5eso1553925e9.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 00:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1788940632; x=1789545432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yvryFZND2qtqNhnrV/ZhmZ533JTNZP/644T63iiaUjg=;
        b=ospvDtLW5aBrS9lMb6hTuvp1yhdbTw//wcyO5pZSVNLsq8kHpUYXNlI2iPnoTtTQmz
         3bJo2OY3dt0VPfFoYQF9IikVMjKhvC3jROs8w81fLXXNMxYbsMl9C4RyCwDfWU9ZsYpI
         ZcMhJU6G8czi83n1Hk5rw9Bt9AawnPX6jOG5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940632; x=1789545432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yvryFZND2qtqNhnrV/ZhmZ533JTNZP/644T63iiaUjg=;
        b=C340Dh9JOCn12PPmRyh9LB1N8/X/X683KKE3gOaw1uAjK+dW7bvtFQ9o5GfJNJjmQr
         BcZDIRGNP+yWPt1w2GOLHQizlXAs7irwgDpVAJDAdyTUS5MYD9IbxEeQ11OIrxUJxYcv
         WQQDbh7/B+lLber6Jkc9yKr6xr3VAc6d6mKuLUMyrVl/naSt2V7Nd+q4hL1X1xMsSuuq
         VrE1SbrBJnlXDa9uX8wOgiadJQI7OzH1p7s9oz6U49+OFLZmvCsIR+PiSRK1/bDZxUCh
         lt6elvecBb91aVuL9MiOTCIQFRm9rrs6u/51r7MmiPGB78MJwmMEIs6VQvt0tDQLjQH0
         X8yA==
X-Gm-Message-State: AFuF++n+C4N65Sk2QHDhV58Pokev5RuoiOtcrN5V6M83Ls4jEpFcAvqp
	Qf6elLauAZtXf35zV74n42Dz6rDgsucs0WcQNfB7MqXu7Kg8ah8ukMBl1SN2iE616L9dJ2jngLM
	rAKRWWKN20vp3XVd5PBYGE71dHm9EeFTuMJyZS6do8i5+SrELFwBRwsEFQq0gh81RQlwC7VLWu1
	knmTlV6wSYDA01vjm7trZR5nTKxkN5tkE/Bu029SBtC8LR8U003B52ovEUQw==
X-Gm-Gg: AYBFou0/frMQzeUVUQ3jysOMEWYFZEpJN8+tobTkQIK+n9HoAXo/MIngGiS4CdLGj8w
	ZuLAZx4wI3ivnIyBD6/O46WL2DC8h4DkmOCSpQy7G77Fyt57555zXFIorZUgjsRDYYm184tDps8
	5ghuSkQTd5zSMZGxmelLIsWgLf7wtDsXyeYrx8J7aQsgjav5N4hcUozqZCSfy4/NffEkRLkHG1S
	mE1smiM+2BcTyBkVj12+FmmiBTDCA57jX905/Q85rDusNrZiPQP+KxEdjLkfyHGXn1wpGpV0Ge2
	+zhFpD4vduUIRg+5sHOd3iWjTaFNlF+WJDRP8jYRPnJilkE3gpnnRfAKgb6KqNwmfdFfPdG/jmb
	Rkbz4p+L5V7110ilZDixysi3kEMOVIrqUXi3D9FgpgP+6olxRWGfZdjGCPVW2cmUS9GcUog9Za7
	XKugniMTdx7xeGZ6AD0TbaZESC6D+lBHfCFw6fqFgW+ouvV2c+QASKeEIuxRipVay49EYmkEahG
	XU4ylgRNg5kxQKcwrBJv1kLEHI+28lm1Q3T
X-Received: by 2002:a05:600c:a012:b0:49c:eac2:ddad with SMTP id 5b1f17b1804b1-49d01dc0137mr233217885e9.1.1788940632336;
        Wed, 09 Sep 2026 00:57:12 -0700 (PDT)
Received: from inbal-OptiPlex-Micro-7020.tailf3f5b8.ts.net ([2a06:c701:c272:d400::7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20db6e76sm45677255e9.3.2026.09.09.00.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:57:11 -0700 (PDT)
From: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
Subject: [PATCH net v2 0/2] tcp: exclude old ACKs from fast path
Date: Wed,  9 Sep 2026 10:56:42 +0300
Message-ID: <20260909075644.1408171-1-inbal.lipshtat@mail.huji.ac.il>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exclude ACKs outside [SND.UNA, SND.NXT] from TCP header prediction so
that they fall through to the slow path, where ACK
validation is applied.

Add a packetdrill test for a data segment carrying an
excessively old ACK. The test fails on the unpatched kernel and passes
with the fix.

Changes in v2:

- Exclude all ACKs before SND.UNA from header prediction instead of
  duplicating old-ACK validation in the fast path.
- Cover pure ACKs as well as data-carrying segments.
- Let the existing slow path handle validation and challenge ACKs.
- Remove the packetdrill reproducer from the commit message; add the
  packetdrill test separately.

v1: https://lore.kernel.org/netdev/20260906123151.1391349-1-inbal.lipshtat@mail.huji.ac.il/T/#u

Inbal Schussheim (2):
  tcp: exclude old ACKs from tcp fast path
  selftests: net: packetdrill: test exclusion of old ACK from TCP fast
    path

 net/ipv4/tcp_input.c                          |  2 +-
 .../tcp_rfc5961_reject-old-ack.pkt            | 23 +++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rfc5961_reject-old-ack.pkt

-- 
2.43.0

