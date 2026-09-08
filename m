Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F86599A33
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887453; cv=none; b=toXHAK5pw2rHEm+Nu7d3rA0s0FQgTiLV2BWjJ6bp2eOXVjo7NoOVQF8XDygUUwFsH2lFlkcMEkfL70M3EVckDTfdJQGq+QQwkR9eAO//rk8xbc47ZRPobPQsrFCpBKZriOIiAPO9rG2Xti2VtR+GH+Ysg4ay/8fpogvtOrnrpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887453; c=relaxed/simple;
	bh=slxYMd9pIzQAMKVqHjrMfdvbnPLm31GqOFhQsu0FO7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1wJuXJrTDQREdjYjju7DIPAx/4Jmtp9EItb9iZAXbOV1oX8vwcy2CN5pRmnejhzDPKIxbq/twhUJD9zYRCcGCpM5pnzE8UaDqP/lq+lzBqjNlpNlDHA1a6FKsWz56/+k60DMdFkE/zC+xUBkEk3BP6sjDiCS+uO+DYoZ82bTsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CSY/M17b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gXHor+E4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CSY/M17b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gXHor+E4"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688Fdk4W360710
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 17:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gYoBNxGLCxDZv4uAHMCNobIrbYmFXndZnMWIP9T37jE=; b=CSY/M17ba+6JAN7m
	qx3NtfOgCpD8hcuGCh/RO5fAabZDu9yP5NBAirlQ/4b26HSYwAgEy/+EsHgYyIXC
	f15jtG7LPIbMXrWdb2xScDbC5k+Fz1ziskjIyapnTdZbemz05lXbnvO8pZeuP0fe
	GpaV1VSy10hT8iL6btIMcHiKClqpg3p5NwDhjuOKukvLh6I858kM7B/nxBy7smRb
	9OsW/A3Tqx5knVYpFIabbVEsl93EJLHXgtuuHh0hs7iUOqegKXfXHolr9M3Ixlf+
	PSD0WdwKUT36xjPTDuw0zE041/cT2ByCXZ4ktlDy86eQkwJhBi1NRrjuXeFS6vdI
	5palaw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjb0pb9p7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 17:10:50 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso8736761a12.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788887450; x=1789492250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gYoBNxGLCxDZv4uAHMCNobIrbYmFXndZnMWIP9T37jE=;
        b=gXHor+E4Iw8U37yF05rTH9bWGprzM47aWxpLIxYRDVA51BWfhN3DEe1Lkc1YeSw2aj
         fkaMSxmiRlVMrksfv5w5vGp0BJaLMoLFalJn5IG4ZXOeI1SQwphyPzxrSZdnmckXdui2
         30PPRuzk37vqDjIDDva8W2Z/vKc+a54AJGXGkncUdbNy+QDSJj7AKCqdqWEQ5aM6LBr1
         icIlV0bX6qfcfahxJGRqDE1GWx9lsCwvGEEdvLRgo5mecEeFyGR/T9HiF7KncWidFQi5
         0U9qo8fQkVqU4n76h7gNW4NH3F14Ezb41K5555DAechdt1kxi4OVMXRT9IZG4gm9hAHH
         Wj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887450; x=1789492250;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gYoBNxGLCxDZv4uAHMCNobIrbYmFXndZnMWIP9T37jE=;
        b=hPp8FDBzK56hPr1idNQWmbSHDM9N0AOmKv0kIu/0es85HztYrCEAWAS39cJ8DFpB4v
         K8XUDaIRjCQB5Wnbgt4oxch4VFZAzWqXQT7zKP4kzIjtXaagph8zEiOuudwOcKyBDOuT
         ThJmZWSFEsBlFcsOkplU4tt9Hc+dUsYBemd+MliGY6V+S7o2IilITZPPHMwxnWywYCKt
         ICDqdFY0fB+qxTFPySkqwSYbsrOkR2rwOcFpWcft/8Zhgbw2jEAN1PpIERupKqktDIe9
         u9qGv6TZwOBa09NIIj6YTAW12r94CYe6teQ5XesFpdgvZSaOD3PFfKLIGRJlL+YVJ8cd
         rBhg==
X-Forwarded-Encrypted: i=1; AKwUvBxgknk/VMQZwzlV9j6VURPvdo82j3xXqxW+CHuY8YBJyTWqLFEKqurENHlEm5ZvxE/HvXYTLEw=@vger.kernel.org
X-Gm-Message-State: AFuF++k+MOmYFNMNH88TEqPAX/r2UWv6dZM0B4hY8edTVXLbIl4ll2vw
	ZsD7aSt6X9ajV1MEGx7QKeI6j8mxZ9SVSEcnwNXZ07UE5LUinLwGhpqCbin02IoNp+IJbnfLmrw
	MkZH2py0JWmAccJuBPHj91pmVzwmpq7D696NI3wYFCeTKsGPCOieGmLO8KIKGk9DrmQ==
X-Gm-Gg: AYBFou2LrT/eOCfcLunFRd4NxClcsPEzQCQwShcq8WPwLsYaDLQmUpyu/2KfBgntYHl
	XwU8QDJ6cArzxHQIjTPjtHmY8YUoluE9J226U/rLs6zgjKxAcw+mTE0lZa3f7gLAbzlu2l8RYah
	JllNXdqfAFwssYJ3nHHyBHM56nQcLRfroCRAtiQ+rsyad+ELdQE27hEANf5kSmsTGs1Le54Ak1D
	dyQlDNRO4UQxaSTXmQtevKjDwNqYSN/mwJVTCbvUVOwAIcilmkGKsTh9QF0oxP01aKvOhlQlgfc
	bDvnvtw0i2Lv8ch8+fx6CJ7LXnZ6nTLmns6OvNhwfwz4v8wYqy0RDZZrJE7G3NYw/ZgrCeodGxi
	5Kbg/5/+qpju6tbe4wdMwtwlhvAslQpvp4f/Jwn+IGp23ka2HSemWvDVcHTcJl6xNUgrrVtx3e8
	MLyTaN1GAToOYkwT/Pb7AoHQ==
X-Received: by 2002:a05:6a20:7343:b0:3c3:88a5:83e4 with SMTP id adf61e73a8af0-3da39ee2718mr43902280637.10.1788887449957;
        Tue, 08 Sep 2026 10:10:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:7343:b0:3c3:88a5:83e4 with SMTP id adf61e73a8af0-3da39ee2718mr43902199637.10.1788887449336;
        Tue, 08 Sep 2026 10:10:49 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm31773675eec.4.2026.09.08.10.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:10:48 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Subject: [PATCH RESEND wireless-next 11/18] wifi: mac80211: Enable skb extensions along with mac80211
Date: Tue,  8 Sep 2026 22:39:39 +0530
Message-Id: <20260908-smd-v1-11-9fd2d876a1fb@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908-smd-v1-0-9fd2d876a1fb@oss.qualcomm.com>
References: <20260908-smd-v1-0-9fd2d876a1fb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jzP3AJo5UvH6WY0GF4T21svyM4e2liyl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfX4h1KpQ7YeQFI
 i0PMkl/7opPwaH1vHyRRpaf0sVrE6ptwBuiOUmvQ72h+v/ZjCCdr0tCaa5pgavsx74ysG8BzoDY
 +wTg323L0VHSsf551pYq0sv6IWELjPk=
X-Authority-Analysis: v=2.4 cv=HL3z0Itv c=1 sm=1 tr=0 ts=6aa0419a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=iJey_kD_w1PlP-9owF4A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: jzP3AJo5UvH6WY0GF4T21svyM4e2liyl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfX7yplEUkqnvJ/
 S/NHTYO4+vpFb6CjPIAIl70P1R6uCEwybw5tttvBJMItE6vua6ORZEQmUuULtUJZHGTUSFoSvbB
 0mEimPcTXPZ5L2UMDzhFFJ4WfQjZW+45JJqDCl2cJjE00SnuoYzJIrzEhP8FHQ5gF2Yq2QsQDDX
 +QOzZ8GJCW/VkVq1rpU4UURJxKULNSHd1t5oItI1px9mvI204+5jc5Gpf1EtRMnFjOd3TI0+j3S
 Xry+n9GQxrCmTFbtittXTUQX7GfJEWmUtGL0fyETBGpyUuwXhpZ2IXM6D5l//Z54P5OIYetmAbN
 29z5KU9+aYvC7ubx6Y0ry9GdvfYFihFwE8uG4Z6n0hoAhgLZg8KCEYOtmL2sRcxVMxawpmRkcbn
 IJkX2rba4ecJUx3ajpSlJstlhrVtePaQk2jGetuiow+OwSMyp3wgWywnk/3C370WpZLFQ9eWC0j
 0rjMRCiJ516IvjKEQrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080185

When mac80211 module is selected in build configs, enable SKB_EXTENSIONS
as a dependency since mac80211 has started using SKB extensions with SMD
as its first user.

Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 net/mac80211/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index d6bc295e23a1..10d28985a1ce 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -9,6 +9,7 @@ config MAC80211
 	select CRYPTO_CCM
 	select CRYPTO_GCM
 	select CRC32
+	select SKB_EXTENSIONS
 	help
 	  This option enables the hardware independent IEEE 802.11
 	  networking stack.

-- 
2.34.1

