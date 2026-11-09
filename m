Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208259;
	b=EEVh1SgY8uLdG3JLhZ+e+aQ6d44i7lCbEbj4JvnkfISKeBMo24v0Km5UCGsSi/g+BoDt
	 98V4LgU4IyZ5EpBLYxq4DhXWwW/WcY9ycMD7nlrbmp49FMdea71U3Enqsf+GRlkctfTmk
	 sWfvmO4zw3fxwrw/mDu8SpfOQuOipfFImFihOjatY52BiAlNs55vPD370oRWEx0kHnNQo
	 uRkpzrIzEH82GGuaxu5JQuW/HzSzcNFAAJriWzkGAvHkbk8JtRX/S6FpDgClklSUzWook
	 1TGrP4HpYCInyGW4aPYH/CGQFkzPmhCKSADZaZYMuStoKS6M1foZ1f2IDDxg/06fgjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Td911GW/RuVeylqJZh+mg3PMQ4kx9/FZxzP7fXWcQL4=;
	b=zeEF89S+1c8gR16TRk/EM88XR8MLzCWdkuUjjf/NrY7wbZZCltid6qUYYC7lv5T0tyZ7
	 9rfYCrHOOSznzV9Hy3I9JJk5N3Jzd6kveatnM6zjhQy+VG+28FhSQv+RUeGkRE3SzAgnC
	 EQ5hmv64cWhPVbfa6vRLic/9mUs1UmmS3aNUpRmKTR7RMsg/38O+auPf9q900vB67OfCb
	 MDR0F4XpDiMcr6MprC196itFlhmUCrExLT/wG/vGmxBkVDTVBrFvMYx5WC1sBh0vaX3O2
	 cnrqSC1s7N77yKONccRv/s7N/+77f/Aibj1nkwU/FgwoeQtgqcFuN/oRW/giH908gfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lrxcpB//";
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59F606A326
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 07:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF59F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lrxcpB//
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1ae18eb9b69so525323c88.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 23:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208258; x=1794813058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Td911GW/RuVeylqJZh+mg3PMQ4kx9/FZxzP7fXWcQL4=;
        b=lrxcpB//IjTuPa7XFTDWdg33npJj5T51SLHc6M8AR/74UrbF2JHehRosylQO0o9XZ8
         j4RFL58oYnVWIv9sFQomNvmL5lZfqA4yN0zluUI/oaSPkOm47PjDowot5EUfn4AHGXqT
         cA38vbof9RnIcx752HV/8bqsO5uzBJkOnUWuKVS3QfaIIRvgAFjsL4cS8G5ZTbsc1ouj
         22osgFP7Chezl2hnKavXyxyFC64t+4LIE41HcNabkfPvbhqPiG2DviQ3+C9LRH9rQkjU
         WTBuAktne/jYLtMWTW/gdzxRR7QzphX5+h/TliNKEuhu/DBdMKXWcI+DQIjkosbkrPpV
         gygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208258; x=1794813058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Td911GW/RuVeylqJZh+mg3PMQ4kx9/FZxzP7fXWcQL4=;
        b=CPLdX0UXpYbB4meG44ahoguVEcxdMnGxIZCL4XtK48F4Rdv6rbxVpzc+dRDkqx3oqm
         A6KT8zhfTUB3DzxPrp0LysVALde1NFJcK/WQqJXMzhzx9Jd/KoKnyal2IcMVWu7IaEYq
         vvwGrDA6NdUi3UA4+0dscbX7uUgjQ3UlWJPmCdUQhwlSofjwnQmf3XZhh7pdrRmPJ81i
         951dADMzuax77YsWToM+bHRC5cGa+lxGMvLR2ftwxF7+XtvwehgYG8ZvRmq0kiRHgEsm
         pmJQDWYXEoDEocBMm2LOtq9xk0AC2dK30wEY/8JljB2NkPHtEf5+W37KmlVV1Tow9CUM
         YjvQ==
X-Gm-Message-State: APuU4Z9IiZGb3e4B/TBO/dxqI4acT9iqPyPWqvjvRhZXNupBo+MuSu58
	eJ0ZHjSOGy8o5eN7kstw4+y2mNkdDyY7OY0ll5eOq38TesBefiVygdk5FdORfVlGGzM=
X-Gm-Gg: AYBFou3QlvVdV3gSFPBbCYaI8xHDMvKwWlgtLgHfAIHa2iDzAyT9TIPKxUABLdHN1W7
	7McrhQWfRs3aMhuUOERfzdSmFE7v6HmG3UwpPA8HQNMZAd0bgmKtwq2jdrmyJrIN1M2VtVdvbPY
	b8Arep3ndvV/yS7si+mCIzXtyiFONCwyC1g7Cn1+ap6dhI81+FvEQd8aTs8bNhhwUFQezJ/S0uV
	Jz2LWmgH19KOL37U6EG/CObXtd4ENV+vYLlnNddhZ2igSFhmGqBFjAms8XNTT8hnmhIdmRwYXZ6
	/tox+L1qtb1Zsc08UajXzCw0ddOsdTlWy+l889S7iKXQ8JqmjCsDBgg0IO+DlhlKHUJAc64yBvd
	QUBFABYNGs/UZ5PlcgZhuHBk4Luc2RdK90RIadZ/6F018ZDi7/bn49f6U0uJqOs4tf50M5dG7uo
	yD9e/VNqCiqbudLa0gsL7OFKQ7mv6nszgou/BSwboSX3GES0AnybjGGai/KxIo9Az/QvlnaMcfK
	pX8FUiD4BHidL9DzcLZgvsvPq7IkQhVnfkODSwy2heRUiOeTaCLX8IsZBVPdRAhp6qG580eP7H2
	qBqEuC5xzEkb0S0eALGPvpxSc3KOyBt9YWhvqqjBzu4uOoH0/zTpHSULmvSvhFzNsdqyi+TU4dN
	79Quo3rP8yC/2oacVKZAMUmZgQu+G
X-Received: by 2002:a05:7022:1586:b0:1a8:b566:80c2 with SMTP id a92af1059eb24-1b39fed11a6mr5130904c88.17.1794208257851;
        Sun, 08 Nov 2026 23:10:57 -0800 (PST)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:cc96:e14b:76e:f8f1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755eb6efsm13443513c88.4.2026.11.08.23.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:10:57 -0800 (PST)
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
Subject: [PATCH net-next v10 2/4] selftests: tc-testing: add fq_pie per-flow class stats test
Date: Mon,  9 Nov 2026 12:40:15 +0530
Message-Id: <20261109071017.438478-3-hemendranaik@gmail.com>
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

Add tc-testing case 83c0: build a TBF + fq_pie hierarchy on $DUMMY, push
traffic through it with ping, and verify that 'tc -s class show' reports
an fq_pie class.

The per-flow counters themselves (prob, delay, deficit) are printed with
the companion iproute2 change, "tc: fq_pie: add support for printing
per-flow PIE statistics"

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
index 229fe1bf4a90..15b2667285eb 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
@@ -40,5 +40,32 @@
         "matchPattern": "qdisc fq_pie 1: root refcnt [0-9]+ limit 1p",
         "matchCount": "1",
         "teardown": ["$TC qdisc del dev $DEV1 handle 1: root"]
+    },
+    {
+        "id": "83c0",
+        "name": "FQ-PIE class stats accessible via tc class show",
+        "category": [
+            "qdisc",
+            "fq_pie"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: tbf rate 8bit burst 100b latency 100ms",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: fq_pie limit 100 flows 1",
+            "ping -c 50 -i 0.001 -W 0.01 -s 56 10.10.11.11 -I $DUMMY > /dev/null 2>&1 || true"
+        ],
+        "cmdUnderTest": "$TC -s class show dev $DUMMY",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s class show dev $DUMMY",
+        "matchPattern": "class fq_pie 2:[0-9]+ .*prob .*delay .*deficit",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP addr del 10.10.11.10/24 dev $DUMMY || true"
+        ]
     }
 ]
-- 
2.34.1

