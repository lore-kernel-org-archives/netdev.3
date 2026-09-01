Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD5B471D0B
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298805; cv=none; b=Oz1r2AJqvQFTVeGgAxTgJ5zOmbGaSh6BxdXl6DM4Zfju6aXV1dAPfmOATQ+h46TPzlJ1xLtsnge2h0aFmOz5+rBw+nSd1Kp1Z5sdG356IdWXzmk8PKCX352dnJeWnrwGGZkvF1Vkdt9DQHbqS+JHvOWgE76VONitfKGITAjS2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298805; c=relaxed/simple;
	bh=eyE60TegcdJMhcfWpYEF1SbVB3JqDiX4LAJmDhQCurs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOM/1PeQ6/8ilJ774wG9pNVu7jtWHWypA7GqtvZyBHwhqSOeICVk3FWHH3lvRrwHZMXHdhO5jTO2yHN6NF5iPEIVk+gSW0qmiVIQDDU7xvIsy0Eqr9MnNnH2Pp/Dzdl277dxAcTwQWPK1sIv4Ua3tO3AP5o+bTISf7O/emlH6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=euX+NJAl; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="euX+NJAl"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90cc372d6b2so4498636d6.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 14:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788298802; x=1788903602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wr78r6eU22ImOp3LoEBgktlcoV8p3UrAuZPj6+yVHc4=;
        b=euX+NJAl65/31QpOZiiLkhfJIglVogQ+OpybY2S5ECOwIA1sIZKIcyvqD6kDBQoqlu
         4knXPz6AxN9sA9mhlmEC7g0nZaOQFfffIQCIJLW9CioqlY6ElNUdvyNUTZBCsxus2XlD
         tmnRMwm6PQfJmnrbVeNf9sbdWoFRVUhg9UcNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298802; x=1788903602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wr78r6eU22ImOp3LoEBgktlcoV8p3UrAuZPj6+yVHc4=;
        b=mxj63IJYAXpcMnB+OHYaCMmunUHLF2UFpHpP2zMPK8nkDpm229xhaIBEDVy1z0jEVF
         nLLOIusipME+gBtyUuC9Khq3zzRBjwuYgQgBTifKFHznl10EkmnUK/1WE4JBaNX6fZVL
         lLTZMl98D6jaU3CrHSzKrzLUzUH+Td1Y9sCeIbc5bKdWofF82Oy1fRjg6wMhEptIVHzC
         4g+KQWfaDBrrxpXgt/6JoPF/DHza2PjrYa5NhN/z0MQTHlxVro7Mgb+QVu6hpEvUduDt
         88Tcr4YJ0hVM++485Qnkkgk9kFLQFfHqDjUWtNtnuCztIXwyDOiUTrmcZJAYhfhSOa/u
         WwLg==
X-Gm-Message-State: AFuF++lDl85H3PoRcNkXtx8jpaLmSdZOvtWdiWRO+lKrZ6eYomVSs0Kn
	s8VzJBK3YyMMstqNQf/0pvmDmH0QGJvp594U2p5TX3yqFNvCyAP+VQsK6FtPgxAtWZmGn1mRjPM
	BTJDVvg==
X-Gm-Gg: AR+sD10KaPV8uX1NRBKl3kRdInUzAyhZSPmdaty4klsyyKO+xjr7YsfgurllChWtOb9
	+BlZ05e9BvZUtgGcGC9IRgrhkGDfBrVJTvW4q/FSY5RjeoDkK+KkSYq+a1aezwhe1rZAsx1G0hs
	oyfYilOf4do+cbYvgcKOU+Weq2wTudG7ZGUFgLHqe7OYFDETc6pqlXDuUdu56+t3U+3dDIKFbWC
	oA3emoO4KfDwe5x+CJRwRpXP2IEI2NMR1a8Cn0Duu2fGI8/Od0pEYdML+q4ZtQ9zpcxSjOBSiNq
	KF/Hsh7UYn8gjNNxhWkUyr13gDZLFNlkvhm8TRPZguuiWiueaAifpPaCS8w44OectwsmB4f9UFh
	gYMDKM5ZJgaI7RStUHN8z31g0HvSrtKrIBZ9JMz1+fiTsIN+JH9yWD942/AxZMWES+ETGmmYf58
	TrCwM9uMINEX7mTAkQudhb7OQE491Rbi0OutdiF/Q5jmbC8VzgrLAXLEtIr93PJDTswy7Qrrzh8
	jNJw3dVdJr+dKpx/EFxROBRtfiargcyRIVWog==
X-Received: by 2002:a05:6214:4993:b0:90e:9d05:b757 with SMTP id 6a1803df08f44-90e9f253f0fmr11350796d6.0.1788298801772;
        Tue, 01 Sep 2026 14:40:01 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm3458426d6.2.2026.09.01.14.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:40:00 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Vega <vega@nebusec.ai>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net v3 9/9] selftests: tc-testing: update ETS test 41f5 for clamped quanta
Date: Tue,  1 Sep 2026 17:39:30 -0400
Message-Id: <QDISC-0CFC.v3.20260901204856@mojatatu.com.10>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit "net/sched: ets: clamp quantum in parse and fallback paths"
moved the quantum floor into ets_quantum_parse(), so every explicitly
configured quantum is now clamped to [256, 1 << 20], not just the
psched_mtu() fallback.

Test 41f5 passes "quanta 4294967294 1 1" and matches the values back
verbatim, so all three bands now differ from what it expects:

  before: bands 3 quanta 4294967294 1 1
  after:  bands 3 quanta 1048576 256 256

Update the match pattern accordingly.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
index ee09e6d6fdf3..d2eab61c099a 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
@@ -987,7 +987,7 @@
     },
     {
         "id": "41f5",
-        "name": "ETS offload where the sum of quanta wraps u32",
+        "name": "ETS offload with out-of-range quanta clamped",
         "category": [
             "qdisc",
             "ets"
@@ -1002,7 +1002,7 @@
         "cmdUnderTest": "$TC qdisc add dev $ETH root ets quanta 4294967294 1 1",
         "expExitCode": "0",
         "verifyCmd": "$TC qdisc show dev $ETH",
-        "matchPattern": "qdisc ets .*bands 3 quanta 4294967294 1 1",
+        "matchPattern": "qdisc ets .*bands 3 quanta 1048576 256 256",
         "matchCount": "1",
         "teardown": [
             "echo \"1\" > /sys/bus/netdevsim/del_device"
-- 
2.43.0

