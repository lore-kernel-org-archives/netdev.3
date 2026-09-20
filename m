Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A13E2AD7
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890938; cv=none; b=n0iRUANnm0oh0kMbXhxCyaZof3RgaaX6qEkOtdtZGotJu5xmA7xWkDkseG8V6L3U/rCQwDfRz9SBBghEqzOxJgNXRLpYYkjrdtN1QpfCh7qXBVWlrQJIYIqHHYb8BYTxNysVkZ1kJfwcEhBsdDphsoHylkgCLK+VXLznmXyroqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890938; c=relaxed/simple;
	bh=b0bDuD1LZgSRiC1UmemKX/tGg2f6GIdP8dzxzMBCLvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LQo777N/UgKZ2wuuBQGiTjvXhVoW9bRFBZ4H5jw9OToHNnit5DaAfgr/NQ0Jvp9V/LJWAzobkOH9HX7maCek6WIPyzEpZK1stGi1z5kYVdmKnn53OE9ETmfwhzgLTc1RgbTj9KejsxXQByyn3g/LoCpOnao9yfHtBRJaF+5GPKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IATISA/u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bIjBVGQy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IATISA/u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bIjBVGQy"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68K55uCk1477623
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 07:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pfx6bFZMERQUrEBTxPu8VU
	3eqd+xw8Jj7J3BM1EDBcQ=; b=IATISA/uzXCNai6GH7dAEwXGGjFGpgMHOk9YGG
	weTZJckRXeF9ErvS6FJiHsj9u1fQEJxYB9VFD/Rt3RRrNWkNwsfFWCghByE2d5g0
	XgiMxzTxKrUtzAoTqI7hiERPSvtEPTl+91r1JDeZSformC9bqP9pdkDMOFezGULX
	idCJEQMM++szYvkKW1p0lUmO4ty8/LyHPzNKxmYfSjUQsTClVtdy6wsj4UOB/R/N
	4pRgTJ1S/6dF626xc4OyqSEai8DPp33+iKZql85UfzE7t8IYRxQtinLhPoejx86M
	8BLZqrQOFcQtZvCLx7xS+fqwvXRYshKbNAcgZpjSyrbnR2BQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsfrntw2g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 07:55:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939f925ba4eso213217585a.3
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789890936; x=1790495736; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pfx6bFZMERQUrEBTxPu8VU3eqd+xw8Jj7J3BM1EDBcQ=;
        b=bIjBVGQy+yT3q0yRbAVVVoMxGeEoAOzZXjQ8DD1DGIPurPw7gdGCy+TMLCIa8GNNZY
         taPs6o3OHV8BMUM6Dinon+MuXyD65icu3Ys7SDitmws8hSufJTt6ln9V/1f0HDkdtKS3
         A/ycKK5dUKBGppbRjmUIxIpT6JiOSRWDKrL66CWli9v9blV3f1ZmARGlsbhtbAJzuKUY
         N+uf0mhg7CAynylzzwRCbQIjZZUHCyQeUMZxcz7ULM12Q8a38ddCEmXgU18KitarBTju
         8hK7dk/7IAajEuIRXmAniPXF7jbQlIDbPEZ/kAYNc1RY/Ji1Ji8o2uwqt/gjhuX2Swqa
         X3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789890936; x=1790495736;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pfx6bFZMERQUrEBTxPu8VU3eqd+xw8Jj7J3BM1EDBcQ=;
        b=faLKFqJA6iwH2JxDlIpy2aR4ntdoNbpUq5QhYY8NbhTKrqlCl8jpYzKD9G61giAuvQ
         Eeua+wKYnkmSYS8em0rerFaHCMSqbnJekTB9tPia5o0HE6AGNGDEDSXdE1aKSE++4xlz
         01rAbSYCKEJYviYT0UXYjamLe7DhpNBgg0XeT5JOsELpAHQlSJ+dHQLm8aEK32ZSUzAX
         /JFzI6tMjnB2y9yuOFDtyqmojxPPL2Kkokt0AOP+YP3HSx4GnhpTkJW8fOJ9kFb66WA6
         TOQgGOBBAxHOkNE57CN1niDcBfRkwwtL+HY3ajD4u31oviCu/fM4XxMEqMhrgXP88WzC
         +RIA==
X-Gm-Message-State: AFuF++lJgRagfo/C40iw0aZUfBnDA8YHN5SVn01GtODukksKMQLcnHFz
	NCQctdOg5B3LZLprzciiedsImcI6C6vHkzqLhEjfiu0VG5RCey5w8O3osI04zI6T4hvM2SKM+Q2
	RR2V1MhcYiSaeFkcwSeBfOq8qz0nC/R8mLMR47haykgoM+mT+UUs3pBisQnQ=
X-Gm-Gg: AYBFou0kvS+YYN13GzUxh4z087KkeYpaz0nm425DBRtuezAGiGaE/ExdMdysG2n3FJ/
	bH2Z94uLbOkJ0xGymZrEQ47IeMUL7Cm+XCgdqWnEsLVOGrgGswf+z8ifUPq+De/aFpvo3E6IB14
	e2x2j68euwVn03b4k3xYHzfRtnVqOgGUBkOWTUyJTu9/bkHtIFMGYrrBCpQprOWiibgHXgPEFpS
	UJt/fJ146t2b4HeKbchDzF9j7yRKpaeafyhLPoEejKElUyfKJUPUBVzXDvyPyZ9OdPIcmYjkNoO
	bG6bLfXLhUqJPhS1RbF6PIX+hGcUBohPM0rWdXIw09Sh/8D7MqOuq5+w5mGvR7n4T8gPcPUq0WJ
	PO88hKJ707UzVmQ==
X-Received: by 2002:a05:620a:4148:b0:93b:d7a1:ba1a with SMTP id af79cd13be357-93bf57851c9mr458280085a.69.1789890935726;
        Sun, 20 Sep 2026 00:55:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4148:b0:93b:d7a1:ba1a with SMTP id af79cd13be357-93bf57851c9mr458277085a.69.1789890935172;
        Sun, 20 Sep 2026 00:55:35 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd090f0csm178070855e9.15.2026.09.20.00.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:55:34 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sun, 20 Sep 2026 09:55:09 +0200
Subject: [PATCH net] net: mvneta: clear XDP pfmemalloc flag between frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-mvneta-xdp-clear-frag-fix-v1-1-d7efadecf959@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqEMAwAvyI5G7CCXepXxEOs0Q1olVSkIP59w
 x5nYOaBzCqcoa8eUL4ly5EMXF1B/FJaGWU2hrZpfRNcwP1OfBGW+cS4MSkuSisuUvBD0QfHznd
 hAutPZdP/9wAWwfi+P/0hThlwAAAA
X-Change-ID: 20260919-mvneta-xdp-clear-frag-fix-7ac691e1659b
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Toke Hoiland-Jorgensen <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=W9mtxhWk c=1 sm=1 tr=0 ts=6aaf9178 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=GC6wR5CVy_D9Ox6dz04A:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDExMyBTYWx0ZWRfX1PMzx+ouuE2B
 nMfWRNaSy1HagM4S+x4oujEXCxocv6O5S6JCjVJF6wDo+UE63mVAbg5ORqnkGi6eulExLdyr8Sr
 KsgfVegjdmNqcznS9gdXIOMkgFQJ/Hk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDExMyBTYWx0ZWRfX69ZIeytD3pdH
 SHyJDnmWx5oaHgY1h81NLxCVSl0LwcqDBw2L5pVJEc/d+KB/lw2Y/yYxSquyUH2g01OqpDtuzw8
 kmAFDL/AGcMvwPj00eOduA78hjpBfyNFFlteKMXwRHBt7M4cR1rK9Ft0eNvJ9Ot9drg+WUETM4f
 BTjL42TkzEzZLip4+kjLA+Pr9Vyg3kXVct1iG+6enIH74NtBADf12dVu7uf6QdPLQBY2OKaWmNY
 db60Su57tCtUoohX4H6rTV9Un+oubKyHSnG0LLU4G3eMkKOQRm6m/k0NsryOYNybVAdwxxMrFvC
 oSiReIBdOyXzt0ytXy2IM4kJF77kndezXmY7gWio/OpmCGErFomAztsnUGeUhEL3csI1C2Ns5+l
 bMx3aTdC7sKmeFnbAvboB1jMJ3H6MfcDS3EFDKd4Je8anhG7nJpG+lXgHDMdmy8OvL/f/MCSu5n
 EjT9P5mxkQB2Jv8nTxQ==
X-Proofpoint-ORIG-GUID: -DR8UM8GYyCp1OXZafKKrUvoYZqyVk4n
X-Proofpoint-GUID: -DR8UM8GYyCp1OXZafKKrUvoYZqyVk4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200113

In mvneta_swbm_add_rx_fragment() the XDP pfmemalloc flag is set on the
xdp_buff if the page under pressure is a pfmemalloc one. The xdp_buff is
reused for the next packet and the flag is never cleared, so a pfmemalloc
fragment in one packet wrongly marks the skb of a subsequent packet as
pfmemalloc. Clear the flag in mvneta_swbm_rx_frame(), which is invoked for
each new frame.

Fixes: ed7a58cb40bd ("net: marvell: rely on xdp_update_skb_shared_info utility routine")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 543e566425c1..32416999f3d6 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2341,6 +2341,7 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
 	/* Prefetch header */
 	prefetch(data);
 	xdp_buff_clear_frags_flag(xdp);
+	xdp_buff_clear_frag_pfmemalloc(xdp);
 	xdp_prepare_buff(xdp, data, pp->rx_offset_correction + MVNETA_MH_SIZE,
 			 data_len, true);
 }

---
base-commit: e3bfd25626b44b6fa61a13c17178922171d519ce
change-id: 20260919-mvneta-xdp-clear-frag-fix-7ac691e1659b

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

