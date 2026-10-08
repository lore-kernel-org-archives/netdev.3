Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53108373C1A
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431827; cv=none; b=m5ibTP0mQgcQYOfGGo/mvg7eRu2gt/+cQgkouKKITee7WPvZpXDBeyhG1CfgQDPAst5WlchfcsPBdgr76DlSSFDyrtvDyDlHXvbZCwIvTn0G6sQE+gH7Srgk0vxJp5qU50kGZ66BZvVXCU7erau5JRKujUPBXL75WwslSkejzqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431827; c=relaxed/simple;
	bh=Zy3DQ2bg09l45QUdJegt9V4PSCAJQxSliXQ/WCsW8y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4x4GZt/OawvPt9trRq7fsGc4YoRxa1e4ASwWL6nkAeiZB8Nk4tqBvlUbjDxLxrbqd2LE7TYsNBcjo4Y51tpmHdnNWvV0TBxbBD3KstonAOwEsqwETY6sPXLq3ATQNh9aTXMOlFZG9H0V9H8r415DpcLmhjsXzfPY6RzXngoolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUwxbU44; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUwxbU44"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-872024e2b4eso1281473b3a.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 20:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791431825; x=1792036625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aVcS6UviFiqfW7v+A1P6aceXNanxZ3sihwct+0rMisI=;
        b=ZUwxbU44CPGwHL8KYYZwa/oNIcH69QzyiYVNlDe1r3bS5NssH3KBVnpZJ/r2axplma
         D+jt4G3k277kfOpxx99rlH7fz+ADnEUSSG7PE7LxLEfT0FxZ0HGhKorZzfNvLJw+poXJ
         //gM4Y1gaiLpr6lfer3352m1qhIe7KuYh7ppMyaN7N4o+7iuvCSli5WAv1J1P6vqmJTH
         KvvBSrTAqbB9Ku/SbW6ew1nR47bZmGXe9ZPkEJuBeX0Y3Vo3m+Tu3eXAxksKhVH4ahMX
         STgNQzxIOx2L6OgCohsrh62Ohr86sn7MQjbfv/XfgH/lj52C8xTajj5pS9QOMDTaL0yi
         +enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791431825; x=1792036625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aVcS6UviFiqfW7v+A1P6aceXNanxZ3sihwct+0rMisI=;
        b=FVlUuoqBr/84EsJjCaMtoWlK0JWTmrmprNMwLyYga2ozOJuy8s5BOUwiVyv8bodcv1
         4exw2fE7iZylWe1chX/y9GZNK88PcRbBwb3IJLCnHiHCbSdNR4DjQj4I0tLK18YGl4aO
         SeQOqamzuOICiz4fI+Id83jFAyiU24+uTfGd+szrkaeUgE5AujWGLUPPjW31gn6An9qw
         7Juh2qoUvGZpi7d3ISOGR2mfWCQWbvk3y/EmnrxMx//hFtriOpQEFRYJBQA4RZy/caAB
         vzY4EfEoeJ2/4dTwYgNI2z7kH1ivViLasK4abr615GU6+5ME0YKytXwK8Vyu3+cbrz71
         cLxw==
X-Forwarded-Encrypted: i=1; AKwUvBzQaUr/uJUUMLaT2rXIaihcMIBU1IWomJLSCRCBkjzqJrhdms57IFlJoYxkyryZs5h97JvOrrM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMX2KkwqJDeC5m40SH6mzPV7JFTlMZkQ6BYUR5yFnENpDg4bjv
	o6p6wiabaXG2WJ1/vWtB2+7PvRlDTo0u9c/Mrc71rSeIggl6i5AUZdFP
X-Gm-Gg: AYBFou1LbLvbgNpgXPP2cO4KbeLh/jFEvKOWYijRy1uEEsVG4YO5NDzRzVhm9SD62G3
	+eKGjnfHq3vqghew+yRHcpfGuabvIm8whBMYeLrRqm1RyXt4nEnsdsQvgcHoyqZ4q1KugQxodE9
	mbrzXjr45x1zTuiGlgzh6fclB+LNe7Edb+t9serXEj0Qp5JmvMPOseqh7C685NbIkH/qB0pJ5W1
	nJeqQ5xtjaYroFlWLrhSgCEGbaeD94OyD0SEuSeJnIbBqitHBh8pZEXc1uBCRcdnOYZZw6w/x+d
	BGljbE29hdWwmRuy+xJSy87N7EehB9An+jX4HuN4baXYYQaJrFHN7kHLp1yNUrzyVPj9/ECOK7o
	+4o+DR/E+fhpxv+cjSQudAXv09hm/Vw+Q1IB31MHTOpL/nObXR65NbuXy8xA5yeXAwScAG/dCff
	f6M9HshJOQkXS7XG94AnM2K83Okfj6BmmSIRvb2PYUuSyVGg7oxl0O/+CtXDfEDskxUoe5Eyztd
	ZOKmw==
X-Received: by 2002:a05:6a00:a1f:b0:882:359f:ef42 with SMTP id d2e1a72fcca58-891b57c4d09mr2887938b3a.49.1791431824604;
        Wed, 07 Oct 2026 20:57:04 -0700 (PDT)
Received: from dungbv.. ([116.98.134.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bac8e058sm1021934b3a.13.2026.10.07.20.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:57:03 -0700 (PDT)
From: Bui Viet Dung <dungvn2345@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bui Viet Dung <dungvn2345@gmail.com>
Subject: [PATCH] net/sched: sch_netem: prevent packet length underflow with negative overhead
Date: Thu,  8 Oct 2026 10:56:56 +0700
Message-ID: <20261008035656.330667-1-dungvn2345@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

packet_time_ns() calculates transmission time for netem rate shaping.
It adds q->packet_overhead (signed 32-bit int) to len (unsigned
64-bit int).

When userspace configures a negative packet overhead (via
TCA_NETEM_RATE packet_overhead attribute) and an enqueued packet's
length is smaller than the absolute overhead, (s64)len +
q->packet_overhead is negative. Because len is u64, the addition wraps
into an astronomical value (~2^64 - 1). When multiplied by NSEC_PER_SEC
and divided by q->rate, the calculated delay spans hours or days,
causing enqueued packets to be frozen in the qdisc indefinitely and
stalling transmission.

A similar underflow can occur in cell length calculation when
(q->cell_size + q->cell_overhead) is non-positive.

Clamp the effective packet length to 0 if the overhead adjustment
would underflow, and return 0 delay if effective cell length is
non-positive, matching the behavior in sch_cake and sch_tbf.

Fixes: 7bc0f28c7a0c ("netem: rate extension")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>
---
 net/sched/sch_netem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 8a1b89a289d..a3dcd33bec4 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -366,14 +366,20 @@ static s64 tabledist(s64 mu, s32 sigma,
 
 static u64 packet_time_ns(u64 len, const struct netem_sched_data *q)
 {
+	if ((s64)len + q->packet_overhead <= 0)
+		return 0;
+
 	len += q->packet_overhead;
 
 	if (q->cell_size) {
 		u32 cells = reciprocal_divide(len, q->cell_size_reciprocal);
+		s32 cell_len = (s32)q->cell_size + q->cell_overhead;
 
 		if (len > cells * q->cell_size)	/* extra cell needed for remainder */
 			cells++;
-		len = cells * (q->cell_size + q->cell_overhead);
+		if (cell_len <= 0)
+			return 0;
+		len = (u64)cells * cell_len;
 	}
 
 	return div64_u64(len * NSEC_PER_SEC, q->rate);
-- 
2.43.0

