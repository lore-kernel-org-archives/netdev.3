Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AA14E80B1
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556306; cv=none; b=eMcXquKfBfKF0cYFiTOMhlzwQJNMGwSIHz4pUwATCrOIp8BG24XIo6iUQgvYnBbkg+GUpOqqnG2X+nwEGh/NWtfhjz0xs/UD6AuscxWZa5OtTUyPK79hUeQfo29FfnA8JTZ1DCBF5B+1ASuaant5TqUfSMfRgY9g7LZEiAqGJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556306; c=relaxed/simple;
	bh=97QLcNfG4SYEqzkhQWb/dBQh4N68dG6xlt0LNXhlfpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thNLc5+0u7rfKSoaAQSu0evzpi5PTb4UCaw1uSXauAv1PYqxn4SkxW8HN14dtWFotIQZa3e96MfyEzQ2nUJgLmWQceC+sbtcbk8nTNPlxbfyt+Y3DtgGsqGU/USdiaO29q9ObREdu+GEi92Ms3XiEbJlq7vab6/BslBebd8mZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQfSLYSS; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQfSLYSS"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2db39df9c51so20758665ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789556290; x=1790161090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kb1DFdILoNMBbkLAVYLbyq2AQV+b6SDIT+EkRgSHolY=;
        b=GQfSLYSSxBVLyX+yFWdqX2DpNUbvjYntoQqQK06GLV0mgGH/hoOG1tpBL8HbvO2CyD
         gCQ0qzHacD+LusfaAVXPBpERiv+BDYADi8yPCxfAegXk9m7hZ/jfJWYqh0Lx7M3pXbbI
         Vim4iq83RgfFTUfap/4wQ78PVMeUskNo6dGRu/Weu6KNHTt7W78XBnK3XDk43JQvzYwB
         pbaJ2rh8ozOUHsNp14kB3u28/BrnVQmLVt9gO3eHGn2ndgje5kX4QLCFJ89DyBaXO2S6
         8iLBr/t9UWk+uEDGIWjBS1XD1W+eDluiDigA7/hPytVJXkn6+G1DT8XUmKgvU50WKWzs
         1bfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789556290; x=1790161090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kb1DFdILoNMBbkLAVYLbyq2AQV+b6SDIT+EkRgSHolY=;
        b=RN6eKc2G1JmrDGW8kBu2wCZl/Jihj7BsAAppwW1qT/8B59fKtHAjn3GaOtbUHwOoAE
         hdkjmer+h/j5YaUx5JyTpKKEbAVhV3KieaM0cLjZPtSvome+aJmDUmZnOiDZGrsq+C2d
         sxPmUI8go6lH5RtSAo7cZYXBTXwVLT4t7O4Ut0arzbKrgxn1mPfDtVQnhIYokTI2eEB9
         xKiVlO/emky1L/TqxmMT27g9w8YgGKUWMTLHVDoC2GjJyNjBlux7NMpMr4K7DA9bcnMK
         tTakO8QbKnCw9NNP9+0nGNApfRNZUb4cy+bCftiIVgt6b69++byPyvhxaeuLgdhypOC4
         dC5g==
X-Gm-Message-State: AFuF++nbQt3K6z60ww7Hk4hijuGGkxW4KKu34tN8zeqUo0rCf7aulWkH
	h+TAH0QL8+y4sT2i8WopXQ/T+XC1SqfB718CThSImychCKX0KmqdlrdZmxZxMCTDZV97p57t
X-Gm-Gg: AYBFou0+DPGw1ce6Ts0f+H5zjELp7UuE2MIf8nNC7UGz4qnLikLkhXnYOeU0y4OVXgB
	hhJ2tgz3Z72NsvTTG48P0zuJQF4RAgv7WG5J7h0/7mn2Wc7vsCvHEFHs94osieIP+cwgFKMRO5C
	kIxdeCWq71C/VdA9FcFHxRnn9R0bSHkwe8kC9g0EBXTa8BZAQUaSrPc74ZYjSZobsrSvDfAAd1X
	xTXrHP9p7ZV0Ik1LlCgwwJcdXAQvdlxgZtboTJwDqGhqIoHv0pFPqFgpjPhjGwqgNCG/xMat416
	6+jtv/wjbKfGZwkScGrzxyyhC4v/ZkYCS+EDnEFiG7nQSufRDlK6IlxY9sgNHwbyy5P8Uu3innE
	J1QjDbNlvEgVuExO9uW4R7EYHlNtz1YZnh4MJEobPFPlhQCEV2bhdbd+UGcyX4bCasCEYJAey8/
	ZSO9nTbbjIXQnwnmJaeEgQYPqsi/5eKroDNaec5UnUua/rEsuRGHEutWB6lfIOhZchI8LgP0QGR
	K7NFu0XaAOM7qYUwDry1xE=
X-Received: by 2002:a17:903:2f8e:b0:2d8:d4de:fa80 with SMTP id d9443c01a7336-2dd8dc0c2e4mr47954055ad.4.1789556289961;
        Wed, 16 Sep 2026 03:58:09 -0700 (PDT)
Received: from amasharm-thinkpadp16vgen1.redhat.corp ([2401:4900:1c2c:2223:9a71:51cd:e556:51ed])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf596e20esm7497068eec.3.2026.09.16.03.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 03:58:09 -0700 (PDT)
From: Aman Sharma <amanrsdev@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	amasharm@redhat.com,
	Aman Sharma <amanrsdev@gmail.com>
Subject: [PATCH iproute2-next] ip-route2: document uid parameter for route get
Date: Wed, 16 Sep 2026 16:27:59 +0530
Message-ID: <20260916105759.742997-1-amanrsdev@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'ip route get' command accepts a 'uid NUMBER' parameter
to simulate route selection as if sent by a specific user.
This is useful for testing per-user routing policies.

Add documentation for this parameter in the 'ip route get'
section of the man page.

Signed-off-by: Aman Sharma <amanrsdev@gmail.com>
---
 man/man8/ip-route.8.in | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index fd04432f..852e996e 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -1368,6 +1368,10 @@ force the output device on which this packet will be routed.
 the firewall mark
 .RB ( "fwmark" )
 
+.TP
+.BI uid " NUMBER"
+the user ID as seen by the route lookup
+
 .TP
 .BI vrf " NAME"
 force the vrf device on which this packet will be routed.
-- 
2.55.0

