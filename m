Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623023;
	b=1YIAtLvdML+yShcWfh93QQOEJtLYdVws9lIkLsbfD6DNAIYZ8AT1lGSZKSY7a3Xez+Xr
	 43Zdpo54PJVKm7FUdNiz9clpbnZbwFmKRGeS4BsGxH9iD4tluN0uDCbJEnszfzR9i8xh+
	 bDNVmSCwc3EpR/vRJO38TSlXxkF9IGyaHY9laZLGWRvI87xal7dGPci2/R9010HIqGkxN
	 iD5qwk5eoQBHwYmmN/Ba9sWhOFdvEzDts8WIaQegd+QImORZCY5olviRvsvxjKsIeFO9Y
	 kX7uVwxu/fu4j9/8+71uinKmul+QPPtXtK0ADLILt+2fzZiYgqmuBEzT+MLLr1ZmCdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623023;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fo9U4mQtdzOXnqHjNPhP5klJCeSKvYSjrDxBHcKHsbI=;
	b=L40jdBxm+rMMCHMQtxedA3qVwiUtGA9YxrP1BpeRAxHTNKOlcOh9C0e8QvIayctrT4iH
	 tljDE5/6te4tVg4Emm+LK6d/0n+LLB59g3tPoXKU4OOZikKebcFmYNaR6HKLatQICO81I
	 4CbonGNeIaIxO1YAk+KwZqlP0o/berAGo9k/n0k5rqtU3Dppw01VpvE4AgfFCqfWI8CgL
	 cIRMNIHAqqf3vZohpRGEnf6iCfmefwuM6hG70wHKoFJtJeUrAI0yHZkDdiu6jXA8CSYl9
	 fOUwnbk2z3fZ5xXhv0dmFQ0q+pRPYyz4F70pTuECLnsvHIj+k9AJDwfHiRm4PjwIs1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fa6t7+Kt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dKP6WEnT;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD98606A331
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AD98606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fa6t7+Kt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dKP6WEnT
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2B2sgB076868
	for <netdev@vger.kernel.org>; Mon, 2 Nov 2026 12:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fo9U4mQtdzOXnqHjNPhP5klJCeSKvYSjrDx
	BHcKHsbI=; b=fa6t7+Kt8eTcs4U0HYHGcZQDuV3aVxb/iidmCi2MmGWdlHY85ie
	c75zYmcDvjSMgVRfxKmMOSNGvFNgDMdFyqoMBTX2Cjxyb3n1lGfjWn+XqnI7jbsV
	NAxNz1uM9hGn9HZuW6NuHjqpU6eLouUFgGxs0f5Xp26u12eYF/ZW9i295NhAAFIK
	VGvDbh04ysR6HGbLdWX0eqgYMF8cRVzu5c4+TBk6jz2OhFq9PWZEZ3yjWCxWJAhg
	t1bTD8FCUZySaojxBbra2UXIdc2IBkvxtu5NGSJNX8r/Pkzlod1gq2/sFBs3P1dC
	7fXZFduoL3HZonnNR3D1023PcVPsNjhUWWw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsa6raj4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 12:37:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f2005ce21so410235985a.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 04:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793623020; x=1794227820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fo9U4mQtdzOXnqHjNPhP5klJCeSKvYSjrDxBHcKHsbI=;
        b=dKP6WEnTSqLFc/XHzWwHM3QxCdXnw7/jMPQXAzGhsdni/vW6jErZeiKyyu4CE1UNo9
         g0BiDGTO/khbYpDnF2aVWCQBpQ72qVXZKobzGGc6dhZARnzMRiKIJWXoiVqO9AzTiWM9
         8trrtLM+/1Lo9nCxGNG5lB7cy96xayB4Zie/OBNkJ7nliqTGsZp++Q4aUE6RgnogGakz
         GjRHQ7g5ncT1L5t3aTiJlUjSk2tG9Yxp9FwZ0y7ks2V+qF1LdOhsIBR2apwNzPCEVZqr
         Ikn/be65QV3z78kUPsYS5xPtv8UTLdVg1WfKy5xQCqbFMbLSFDthRcap/R1LqcRV7ojk
         mjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623020; x=1794227820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fo9U4mQtdzOXnqHjNPhP5klJCeSKvYSjrDxBHcKHsbI=;
        b=tZDryREdEXK96V93lOweJ00//7fcgEjRo/suIH1nwYmq2T6VnqKUzQLgEXx6Bps2I1
         TVZjgYfzwvE35qryku2iHySNi0eus3yfYITg8vCAADgCyNpVyTx90oWzLBI8DSNNolKq
         PHln28CzhfQeg3OBOruJ4JOa684YomeZs+wRMCdL6ChtviVrHCnjt/D2nXDVYS2U6D26
         yFDFS/kVC1nuOPUGW9VbfTr/huSP/hljgPng7+KZUy83TknVcv6Fk+Z50KiD1zIvWtES
         /MN3sJ64KXKNrVRems6WFHToPbizS8j8Af5b5qnPm9db7hPA8cixkV7ribsxippwY7QZ
         detQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlN6s//Ld1WjqGb3kMg81YX6MyPuG32TnoUtR6gYKm+ZfeoKqRK5xvfkg+n19XGLTWgSYMaGc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJfVhZb2+IZtCopxR+vI3xoY/UGKcofFnfF9Iq5rumMPOaetHj
	KR9/mS1Ocd9kbc++TPSgRy/Cgw3Vq42VZ1OHf6/aaVRABucduBGnO9Q9lSXNy6EoVUcyHJbRpLK
	qG4/K1Lr+fuWPDAKhkO7dET/ZH9U+QFJ1IuP1/0B2LCk/qF7zajPwCgsEM0s=
X-Gm-Gg: AYBFou3h/43D4LIQtAJyMqgWHIZSwPITY0RCMq+KMmxnKDRGhqxgVwuf+pN7Fr1oveW
	1BSaprzKVF12Iybtauicwj6rAo4u9jLefIbhk3CHsHKk2oMxda/KiMiXbh7027VY3gT8NxnSl8n
	YPfOBvCwgHBJqb9d/XnCAojTodf3gZHQGp/VIYGukq91Z6iOWJ3h0xTXqE5YIKeX4Yc6RtpF4Cl
	ozPMB4UWCNutRBLLBiL996qaQCq7wco+kCtMKvl0DgqxeyXPI6cxrso8+6RZyFI54XtD8JCi0uQ
	y0NdJiqcKKqqY9eCRtSc9d5Ij1iYKzS0vW9MNVv8fuNP3nWpdIvOZPgLN4OP+WW18yFy7kalhaN
	eF36J6kySRmQCAIAq0D7nK7PG44NFMpwPXtsTptdPon65xB4F6/diHfX1F7bXIA==
X-Received: by 2002:a05:620a:608b:b0:943:f2ea:5ee7 with SMTP id af79cd13be357-94421659ddemr1511460985a.23.1793623020027;
        Mon, 02 Nov 2026 04:37:00 -0800 (PST)
X-Received: by 2002:a05:620a:608b:b0:943:f2ea:5ee7 with SMTP id af79cd13be357-94421659ddemr1511458985a.23.1793623019553;
        Mon, 02 Nov 2026 04:36:59 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabc18ed0sm388838766b.2.2026.11.02.04.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:36:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Alex Elder <elder@riscstar.com>
Subject: [PATCH v2] net: ipa: Drop unused qmi_elem_info arrays
Date: Mon,  2 Nov 2026 13:36:54 +0100
Message-ID: <20261102123653.151700-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2729; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=SVtj41NSKUuUeN6yNUPC9v2Dm3p2WWZ62iq9Yj9RStk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq6IPlkZKcjXeBoWCKudtzswNDeJRU9zaSZJ8Jp
 87Mwo5fnqOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCauiD5QAKCRDBN2bmhouD
 14NqEACWiIllhplwOmgTCW3qwWPoxiflM6hx3NhpSuKBAGBxOIBHJ5WHP+r0l0+vdAMvrMcF3Gg
 PQIWpErbxbhzVBF2ReRbdai5dfPA1RJFhoa4Jc/Ef4/gQ6LVaosjH8aiFkdIuBmYwo7f6ttwuME
 t9MjawbvlXBLOUnkJCrLxIL9E6BJpgseL6pd3NHHEYHLjOtxZDEpeXlDX8IeWM0oEmJHdr9JZky
 vmnSeW7oB06jOeLxxR0UQLZuhKIeZ+s7KBMKsATFcj14affGbjVQdD2bbLga7HVvhELVNLRZqv2
 P+MZ5PDQP3NAeWSfOqe6aUg0eJSzQYA8gn2fwRWy9mSqT28njyIbPmNwWibKPkwHDbyHF+DoCSV
 w9Sifotr2tEg9x1D8vw/AWGAELBASCcoSOLjsS24gDlpaNTddppGMQ9v1hyF+wfDiKI7qwejSFa
 BFX+7OGzK2PmQn0VDjGQl3SnDK3+6zpWI6c08Kkmq14BqB+sqLClhLBhym/iPRpqWVguKjkEboV
 5wVk4mYNLjOGDecX9CFEBo/s+GkIgFMnezFdnQYOHFiwhTsb2OUUeafp8yaOna68yJp70bpz8yk
 7YHvSPv1xkPk3lPcPHH65olDddIhRvsDtuWs+DoUXcftHghiCVZIxOQOfDkoTfGI2kNwJZBYiXJ gB+jAxoXJ+kG7XA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX1KidOUo9Jqom
 U03AiG+biXcQ5WDi0u6rInVxMWVfjX2Nrd6bMLzu6RPRnUmYxDF3+/4KuU6uRw7+pPfgv3bSi88
 qwMRGvYAPfPIWEjfaHUS7pNtrGmSDvuLVDRd3QWpPuttC3E0QX84y2i5nFzVh7rrMfZ8GhQCjJt
 hpTp+utq/vMmou38M+tPU14NYxrHyh9AhdWEwH5yCsYeeYlpQOgyp41fKgNNJZOceKmgKiK1z7y
 kft2zgg2N8XgxvcJxXqeANJqLPiLQNh8DmtoRGnV02Nsn7ZbMIBTWZqXL5XtjouqHt2r2/brYYt
 BBFAdPRRYe/+XraPAHom8o+6s9eNAJQIgknb7yazeM0qA7N74C/kTqp0/xkwNzWVt5i14RYluEE
 pgEYxNocgWlJR5Cbl6yKJXAr/mlM9x1jRm1K9Z6Yd+pvAQo6VFHSzU7knxVJvu3N4n04mM+xVhV
 BUF0O2W/zAv8bNvM5iw==
X-Proofpoint-GUID: _MeGkV2j8gic8TZg6POygYelqyS4KysS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX+93XTP+RqGXC
 y8kkP1BJjMcNlK7GRYo500zYioRDIamww6WS5ykOF98uv/p0aoDw3byG7hNcoLHJy32ua6h+zJu
 z7RS2tU+W2KtBv6R+gP4jaP9YraE9fI=
X-Proofpoint-ORIG-GUID: _MeGkV2j8gic8TZg6POygYelqyS4KysS
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6ae883ec cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=ee_2aqc6AAAA:8
 a=EUspDBNiAAAA:8 a=e1SKIdZ0hHplv5p4F20A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020050

'ipa_mem_array_ei' is not used anywhere, so can be dropped completely.
'ipa_mem_bounds_ei' and 'ipa_mem_range_ei' are not used outside of their
units, so they can be narrowed to file-scope.

Reviewed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Fix commit author.
2. Rb rag
---
 drivers/net/ipa/ipa_qmi_msg.c | 25 ++-----------------------
 drivers/net/ipa/ipa_qmi_msg.h |  3 ---
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ipa/ipa_qmi_msg.c b/drivers/net/ipa/ipa_qmi_msg.c
index 51dc13a577a5..e2401d8475b6 100644
--- a/drivers/net/ipa/ipa_qmi_msg.c
+++ b/drivers/net/ipa/ipa_qmi_msg.c
@@ -188,7 +188,7 @@ const struct qmi_elem_info ipa_init_complete_ind_ei[] = {
 };
 
 /* QMI message structure definition for struct ipa_mem_bounds */
-const struct qmi_elem_info ipa_mem_bounds_ei[] = {
+static const struct qmi_elem_info ipa_mem_bounds_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_4_BYTE,
 		.elem_len	= 1,
@@ -208,29 +208,8 @@ const struct qmi_elem_info ipa_mem_bounds_ei[] = {
 	},
 };
 
-/* QMI message structure definition for struct ipa_mem_array */
-const struct qmi_elem_info ipa_mem_array_ei[] = {
-	{
-		.data_type	= QMI_UNSIGNED_4_BYTE,
-		.elem_len	= 1,
-		.elem_size	=
-			sizeof_field(struct ipa_mem_array, start),
-		.offset		= offsetof(struct ipa_mem_array, start),
-	},
-	{
-		.data_type	= QMI_UNSIGNED_4_BYTE,
-		.elem_len	= 1,
-		.elem_size	=
-			sizeof_field(struct ipa_mem_array, count),
-		.offset		= offsetof(struct ipa_mem_array, count),
-	},
-	{
-		.data_type	= QMI_EOTI,
-	},
-};
-
 /* QMI message structure definition for struct ipa_mem_range */
-const struct qmi_elem_info ipa_mem_range_ei[] = {
+static const struct qmi_elem_info ipa_mem_range_ei[] = {
 	{
 		.data_type	= QMI_UNSIGNED_4_BYTE,
 		.elem_len	= 1,
diff --git a/drivers/net/ipa/ipa_qmi_msg.h b/drivers/net/ipa/ipa_qmi_msg.h
index 644b8c27108b..1924ac2dfa90 100644
--- a/drivers/net/ipa/ipa_qmi_msg.h
+++ b/drivers/net/ipa/ipa_qmi_msg.h
@@ -253,9 +253,6 @@ extern const struct qmi_elem_info ipa_indication_register_rsp_ei[];
 extern const struct qmi_elem_info ipa_driver_init_complete_req_ei[];
 extern const struct qmi_elem_info ipa_driver_init_complete_rsp_ei[];
 extern const struct qmi_elem_info ipa_init_complete_ind_ei[];
-extern const struct qmi_elem_info ipa_mem_bounds_ei[];
-extern const struct qmi_elem_info ipa_mem_array_ei[];
-extern const struct qmi_elem_info ipa_mem_range_ei[];
 extern const struct qmi_elem_info ipa_init_modem_driver_req_ei[];
 extern const struct qmi_elem_info ipa_init_modem_driver_rsp_ei[];
 
-- 
2.53.0

