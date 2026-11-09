Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208282;
	b=mFA1AWUNjmR8LoEfkVfzryJsb3ppWcUpJf7LFGRyGOaYOYe8Cd2/bv5CP6eO3OiRmGfX
	 2VnWI37uDUCxU6aaBnMqvGeiuBfo5OHed81IjM9J3nz2Avy8hQ2prJLI4E7ch4tPsGhgw
	 8KdBobpohqukqKMH1yXJTb35hVHGMXFQcAdKIdtSCIQFuC/XGM7CZI9F3DQqP3ivhblT+
	 jzvLbycGa0oDpv6FPRxgKgxND0Qm4211+2dovSMSKT7rUw5XBJWakocZKv0lJHFb9yndK
	 xygU8iFJItXiu7kDAI0GHb6kcInc7R3FHt/YJ0+tY9BnZ/EJa33r41u52CG6q1etQWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7mHMsCDVeycRBqs1waIeg/qc9zHDhufgZN4r24QbNvY=;
	b=3JzbRh7mB07murtpmLbz8cbvGCirVr108eqCaERbYpDNL6GF13WwygFBPEVY5vBO1BcT
	 UNJ2F90RAfxlXaUBAtyMa2YWb98v9E8RDfaDgsQqUgg3qLE7LJZRl4k+QX01HWYCwXDrZ
	 VUxg5Rbp6O0B8J2+WVf6Z4psaPaG4cYDIqk63qzq4nsitg76Fus5YgclyV7boyOpKiTkL
	 3NQL+lIeOfWW3oZH9iNuwDdKdp5BzIMKFodppPE9mmOKRRiSTzfZJ2AuRdsQOj3UkQDJB
	 CLsCZ/mMfEFb8ZUcFyPq5RqptM4W3WSurHUw3nwN3s+dI53BSlM1GEKlbUDx7yLQWtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yrqxFb5P;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705B9606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 07:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 705B9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yrqxFb5P
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a8cc11ac42so351173c88.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 23:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208281; x=1794813081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7mHMsCDVeycRBqs1waIeg/qc9zHDhufgZN4r24QbNvY=;
        b=yrqxFb5PaoQQpJVCeHWMecfV0DneFMtWF/GXOqRhI0nEu2oGg9szux5pv/edWk9+Sk
         +ppyrwclcOxV+2mENRlj/4KIDweTwG+EqIRER130x0e7FLSpReLt0D+07OrhFl/CNj74
         jTfLsmKQpgXRDkQHRHSLcePJ+ey/araaccry5l8QAO1xfFWqYunFSq2awtolqAN/Skd9
         VdCI0eB415MTrBz3FRGDOx+Oixe8zNqL+9dGEYxBHJtja7zk700Cxfo3aveVGV43hd1c
         Zb0PptMUKNJE7zcrXz34xw8SnuWKiy1n526v3PxdxA2SX3TU0f6GIh6CJ9aDoxgSHHRM
         R44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208281; x=1794813081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7mHMsCDVeycRBqs1waIeg/qc9zHDhufgZN4r24QbNvY=;
        b=DaMwtOjcAS9fGn6K8YPbS+zLU103Q4T99sJA9a6EI2HKSRtxi13jh7OAs1Lwy5QTbl
         z6JpF0a+PteYeucoVoEfxKjliCFIkm8WjcdGLGHcxnbH5aWeKT2ceA+WD8d6RPA9cfgj
         fPxwSAKTLkvmiZ94g+WOC2HHPoVPfCMysn/a7iEoubBAThW76n1D+sR4/P4w5BPxAUYO
         zxBBnV1XKbP8Y0ZRmOusIVHvAdJDmz3jfHPFvQk536g10iRzmG9Q4X8ubyUXTMdhShsF
         33SYRXEZ6W3OQHXKxEXX6A6urZwby2WfFePOQFXPzhj6DZaeE801g9Kpg6t3eeEBBSde
         Yzzg==
X-Gm-Message-State: APuU4Z+IZ7rTZMOif3Hv85O1p2hY6H7o1KuEZOMp+fC0WkfVLGu9WPfN
	q7rbjnkuQkBneYCYvhfkqc3yHjrfZ1j8WhWh8vpRD5A/8EYUuvldXaJjWClvHyRaGCA=
X-Gm-Gg: AYBFou3oD3SsPiHWwgjDcJtSuH2UD7V14zdMiLjVxReNYo1qHx8tH24ILFVbIfeNvCu
	TKmQmsnhTKiSt+klP9+6TOLIaTZaq87YoZip87DUS+JiUFG2OmV/VkJbR7DjjhvQFWE99nAOdNS
	+PU0HrIIvAStUYlngSAfSlCEJtQpKLxe9k2Vx4zgTttVC7yYRNMueJYU7TANGG7GLzCvovpINmG
	Atu2DVfW5m4egeDbk+aaMhrCtn8XOSZgYlRRkGGVbtDbIML+VNeb8XMvQ3OBjlonlmOgMQsLqxg
	hpl4hZaNi5cHLt953mgUObIPEYIthlC1BEYGcjsN6mCC6J00vE9m+Gu36YyH686XKOzQ2JqcdFn
	Cm4ZSoEBGXT8/y/Vff8cIle4Eb+bUs+Rr5mDAz/FpP2vxzSY0w7C3SJcBqeA/tumhWkCA/c8bYa
	BjHAE3MFzyZP6diUTaeyeTmw0jw8llPlro3iLR8wbczS/7kfPJnfurzHqTMoIsDgXqxfea2Ue/t
	tNe+2OU9JhexvhiHIPZQoTWig3A9ZIFDl88Cl8BGD2vOtaAndYUrSecXPbv9IxR6mhFuesD9oM1
	kONb25lE4QnrG+T7GdQ8AAnduKoWJAB+AuN0hbQb1IpO9qb6pRdqS/5lbpwcsF1CFHsL3vxBrfZ
	koLCO1sSG7UZIlJ3mNyMccYpjPB8P
X-Received: by 2002:a05:7023:d07:b0:1b3:ad63:b9c2 with SMTP id a92af1059eb24-1b3ad63ba53mr2044328c88.22.1794208280449;
        Sun, 08 Nov 2026 23:11:20 -0800 (PST)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:cc96:e14b:76e:f8f1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755eb6efsm13443513c88.4.2026.11.08.23.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:11:20 -0800 (PST)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	toke@redhat.com,
	liuhangbin@kylinos.cn,
	j.koeppeler@tu-berlin.de,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next v10 4/4] Documentation/netlink/specs: tc: describe fq_pie per-flow class stats
Date: Mon,  9 Nov 2026 12:40:17 +0530
Message-Id: <20261109071017.438478-5-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109071017.438478-1-hemendranaik@gmail.com>
References: <20261109071017.438478-1-hemendranaik@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the tc-fq-pie-cl-stats header for fq_pie per flow (class) stats in Documentation/netlink/specs/tc.yaml
with its five fields: prob, delay, deficit, avg-dq-rate, fq-rate-estimating.

Extend the tc-fq-pie-xstats fixed header with the type discriminator and the per-flow class_stats fields
that follow the nine legacy __u32 qdisc counters in struct tc_fq_pie_xstats.

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 Documentation/netlink/specs/tc.yaml | 33 +++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index b6ccc645b0e3..b159c4b563c7 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -894,6 +894,30 @@ definitions:
         name: memory-limit
         type: u32
         doc: Memory limit in bytes
+  -
+    name: tc-fq-pie-cl-stats
+    type: struct
+    members:
+      -
+        name: prob
+        type: u64
+        doc: Current drop probability of the flow
+      -
+        name: delay
+        type: u32
+        doc: Current queue delay of the flow in microseconds
+      -
+        name: deficit
+        type: s32
+        doc: Number of remaining byte credits
+      -
+        name: avg-dq-rate
+        type: u32
+        doc: Current average dq_rate in bytes/second
+      -
+        name: dq-rate-estimating
+        type: u32
+        doc: Is avg-dq-rate being calculated?
   -
     name: tc-fq-pie-xstats
     type: struct
@@ -934,6 +958,15 @@ definitions:
         name: memory-usage
         type: u32
         doc: Total memory across all queues
+      -
+        name: type
+        type: u32
+        doc: TCA_FQ_PIE_XSTATS_QDISC (0) or TCA_FQ_PIE_XSTATS_CLASS (1)
+      -
+        name: class-stats
+        type: binary
+        struct: tc-fq-pie-cl-stats
+        doc: Class statistics of a particular flow (invoked via tc class show)
   -
     name: tc-fq-qd-stats
     type: struct
-- 
2.34.1

