Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A89952D2A2
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651369; cv=none; b=bgc+EZTRTZdapoqdpwJYpyx1t3TOfm4G8s8WGz90WBXLifc03i4yTHbyFEcgwOo1NhFJK7YzTRrVuj+8U45xxAp3ovxVnW4ngzi9eMXbzvkgxIh1XK8jWrQfmNJUdByo1IyMO6S5wBdyYq72tXIk8xMzjIB/cqM7LCb3c07lF4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651369; c=relaxed/simple;
	bh=eUFZj7HdiNssWy2NTZ7R6ChYmtk7obu+WhbPxWvm/oE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E4e5QJonSWT7/sX1EEfoHGlQCKoVpP2het/+HlAMcwFRt3KrHJExEEUIPwFtMmSeEv2mftLJckxf/v1GNlMhMiXD0pPgMYmtK+rmy+kelIIhUBQVbW8TRILo6aCh7LIN5CJDx83aFafRut1SteUgr/R2ipNmzS9dbEvGdhax+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L/Feg6bt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GhELq6YW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L/Feg6bt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GhELq6YW"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9Zac3746566
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CflkOAT9fCKQ7PMjFcNJ2k
	iw8Vw7bCScxaeZQVMpyoI=; b=L/Feg6btTKnpBE/i54fr0iB++Wii5prBd4wavK
	v0hHE1w+YXFsJGJQ1LGTrWFImyruaOyg3i3/XJSGWJrzDtPxdM/weFsTF9wnDMS5
	GnF08wEQA6AWs/IeuMFc26b9VU5E/DM8oCEb3VdtVD07jORrIVSmTlWYQNVoYqvB
	fvrDb0R5g5rylkV880t6BIjBFKjKVXYqQzrB1gyfzHwFeG2q9LNrRM3ga//nvhVi
	8sKh9ULVAd3DnqIsFDhjR+wogdfQVMQWeAkv95FHLCpBo8hLscWMezqns034noNG
	WfwO0u35pVXo1sDTGXRNv7EFSsHzmFrBxMHvD4YnFOvS7Hkw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grcra97e7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:22:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939f3426a7cso159415085a.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789651366; x=1790256166; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CflkOAT9fCKQ7PMjFcNJ2kiw8Vw7bCScxaeZQVMpyoI=;
        b=GhELq6YWBstNI1XS8HiMOn6JmM/WmeRtXMscrY+RiOoJUMi314M8J40pcF6peZnNM+
         0lSTIkNDO7TPFa6Sd6qTp/thBprhvq+tYM894opxgs48vwil/TGY8pKapqGRhlK0uVGw
         YMcMLemOcyvH+8eK5Hqu3Yye0uTzvKCHlNDXZN4MZ+qqZOm3VR04EdFt8Fsm+I/Kn6Av
         W5nXKBT2/gIKgJE1OvPwHwqeILOx+p34jvgrOgff/Ckf9KxxrNTEuHb4tEf2sLoQGfUc
         Rv7tYBsxvWCGsLn30rzGZB3myPBzyKog7Z3PJeExALFYtuZ2foIJt8+gOj+SbbDJAgmO
         VY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651366; x=1790256166;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CflkOAT9fCKQ7PMjFcNJ2kiw8Vw7bCScxaeZQVMpyoI=;
        b=PjUb10066wtoLMUreR+/H6ecdQXwvrbiJlZTH/IVhQy18NqY2Ltmw/HzS/9ND6J/Su
         +Whx9xXvkZQFzxUe7WfRlsasBMoedNZIUtjMMRL/z6aFUAo6aAultQny5v/JUiduvLHz
         fRWgPGziBB1vhP6lmnlUxRN7KsqwI+kY4Lw8kr6VE8qYyqUYHqkatpN7fMy1F4E5V0up
         m1ADmi/NPrC31zteJ5+2YT9n1/LhY52zfwy1gzmMi5Dy60bKWXjci5EpUOxKJwx+vOEl
         oyatCOSS7W8oMlLs55KRbFxopEwBBzfU4WGBMXsPRAXhaBQAfxadR+h8UgCBOjESn02m
         mybQ==
X-Gm-Message-State: AFuF++lE1IVQGAEKsYjovzQT29VcJ2wXHweK5z6YC0WOKHJr5a8hNhKZ
	WMOKm9dZINGFGMn/m91YekhosTmZseHXYmBiyz2/yWB5PWiRr/sm32ipjO72rZrd5QRhYy0YiuZ
	hpwD9rdugd1oyZuc2rpOwHnTytnMEMri2jkc3BZt5LDkgI0O0UpmP4etQm4o=
X-Gm-Gg: AYBFou2ZuHtcoA9WnfXOfXfY1W6n/e5IxfwyaHL1qZ8xFdWQjYqh66RsRjjuCWBhFvq
	XSVF26wW2bFc4Q6t2bwuDyw7HCMjkccQmx3rSQwIvEWcJgs7gzbsfnO4D9CK6D6nB38lzb3SAWo
	pS9t6Sra/bai5LKsBM0wXtWi2IPgPosf+MmmCnNPmhic/Y589CsAMODRJgm5lfFMvOGB1b8U2Ov
	qnTmdCbz3L6xycSkU5+6roiR924q0W7nwUKVODj9MXPQCUhnzrt13bSt2m7DQRNksZK/svw08w8
	2/ls6+WDag86HfGkeyBkb8TG7UNjs8jDIwlUt+REBkIgghApw9WEpuHiPlVS8Erg20XmI/P67i4
	KCRERa6OAkU6hmA==
X-Received: by 2002:a05:620a:7087:b0:93b:d7a0:d9ea with SMTP id af79cd13be357-93bd7a0f070mr53259685a.68.1789651366490;
        Thu, 17 Sep 2026 06:22:46 -0700 (PDT)
X-Received: by 2002:a05:620a:7087:b0:93b:d7a0:d9ea with SMTP id af79cd13be357-93bd7a0f070mr53253985a.68.1789651365901;
        Thu, 17 Sep 2026 06:22:45 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23f4e6sm91451705e9.8.2026.09.17.06.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:22:45 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 15:22:29 +0200
Subject: [PATCH net-next] net: mvneta: rely on napi_build_skb() in
 mvneta_swbm_build_skb()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-mvneta-napi-poll-v1-1-fb57604932d3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQ5AMBAFf0X2bJNyQP2KOBQPm7CaVkQi/l3jO
 MnMPBQRBJHa7KGAS6IcmqDIMxpXpwtYpsRUmrIytqh5vxSnY3Ve2B/bxraphwbWYTaglPmAWe5
 /2VFyWXGf1L/vBy4pxyJsAAAA
X-Change-ID: 20260917-mvneta-napi-poll-987b8e9aef0e
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE4NyBTYWx0ZWRfX/u1D7IEb1y80
 yDNq+7jlQGc8eawo4cQnlLvPj1hPefIQM75rPYWfPtX4UANaxsv1yPk08BKBkfITfJclNfWe00+
 TZKrpXSsVFIjWbpXSK2ZRFevFhrBemc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE4NyBTYWx0ZWRfX2m9ricYolRyj
 9G4ryt/wUaDtijVtI/N85MpA1aWQuxPhsE7Y50EpNrMsocLJpiqwJLKn/UmCDTjg1gCZhjY/fl0
 hGNrC70awxMm0TL7GboGlSKld6ncNX/dpErG39913YW7WNOkilTsNacYfCYf3NphxrnpOEfnpeR
 Yy/YZNt/z8CJmPGvPYH1RLJHvWZjQeES1kjb8LQA43JEJwTq8e/x+tHNccCxodZ6FYnwcd2/cdp
 OusOGoGp8rS67+eHfRj6wMeOLeSiVob07Tc4wm6OHXUlLWVBLrIHgxmU+ywRQRNEEcMlprDIhvt
 sfeJPiNscPqY4mD21RJkqTn+ID9UCzhcYNpa+d2LOcsmMc4o0e2Q/1qh5SOWf+KuBHNvVY6T8Id
 DJWFOezPiJ5ecj6fvw7vxp6Du1SZwRwMjn5kA2HJuv3v0JsBuocN+u1Irfn0wv94Cd8qifPtdCm
 Zi3VtqdsI13VqCB2DjA==
X-Authority-Analysis: v=2.4 cv=WL/qzXsR c=1 sm=1 tr=0 ts=6aabe9a7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=wB1r_q1jRA9oiTqnZLwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: trN5B8KwmOKGElzsCK7riFmurfrgrvXJ
X-Proofpoint-ORIG-GUID: trN5B8KwmOKGElzsCK7riFmurfrgrvXJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170187

mvneta_swbm_build_skb() is only invoked from mvneta_poll(), the NAPI
poll routine, so it always runs in NAPI context. Use napi_build_skb()
instead of build_skb() to source the skb head from the per-CPU NAPI
cache, avoiding a per-packet kmem_cache_alloc() of the skb head.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 543e566425c1..c2b1098d8d1d 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2403,7 +2403,7 @@ mvneta_swbm_build_skb(struct mvneta_port *pp, struct page_pool *pool,
 	if (unlikely(xdp_buff_has_frags(xdp)))
 		num_frags = sinfo->nr_frags;
 
-	skb = build_skb(xdp->data_hard_start, PAGE_SIZE);
+	skb = napi_build_skb(xdp->data_hard_start, PAGE_SIZE);
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
 

---
base-commit: 859e40055c19ceb8b8215f3269e57075023b72b4
change-id: 20260917-mvneta-napi-poll-987b8e9aef0e

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

