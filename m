Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3859B663
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887458; cv=none; b=ETFjzcnsRY2bJRcSJ/20LVCBz7H+3+JrFTZCDZpcQniTOywgU87DM6qINiv87dlccA0Fy+2UDyStyX4GTG7p6V69D8Aho+gp6RQToA+03gL/qmLz5HqkP61nrjjoRcS+Ded2TmjzNDXfnuGPDmdYEHVWzaNdGXpP89Jx6uDe/gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887458; c=relaxed/simple;
	bh=79ChjcWn9P3rnnuHKmMDzO/rpLHUhW4oLw8lkH+rZT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SY3p19Ss+W8yfkkvPDJW9oBKFQs2k01sMCSidMQSWdJHqJuXos69EtMWC/YiCX5i4eYxowzPyJG009sRvOEHXF1x/eHwiGvsjZiMM9emIMFbEANFtE0IQhAmWzMRE/RIQQlATnmMV9yDL1hQlkLjUucVOPYYmLG6/KbHe2tsuiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Khn3Rjy/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RPDoomkg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Khn3Rjy/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RPDoomkg"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FdefO045837
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 17:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OEZFudhXBWzoCl30tcULXwca6zIY1XEjQJyY0OKHCVQ=; b=Khn3Rjy/VasoDmRN
	rUQs+bK6kKu56PflOnJOaMDRQhx0Fm2upRgi16tC6SYf+/xzrH1ZJ8sfHeKX5r5F
	BBa01GjWkBp7W2WCRzdbG6XSeSQF/I5QwgPrc81jqxuHt8sfNm28rzw7UlDqoN0s
	0/r1U5+XsG4fakgSD+WjeFQpCBDCi1oVYYZ0Z02/+rfI+obBl+woeDnQ701frZcQ
	09W07kocvMLoFMjGYgTnMsWRXlc7SJpIKtnQFubHBjWUTgYkjSDidPGFgooxDvZ4
	KO+YzeDr89vkHBgIDzBH7mGGQxPC5FLYdQp3PUc26Crf+z2WCupIunM7gO7YDzWq
	/STKfA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjg8xsy8p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 17:10:55 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1b8088203so5324165a12.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788887454; x=1789492254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OEZFudhXBWzoCl30tcULXwca6zIY1XEjQJyY0OKHCVQ=;
        b=RPDoomkg0oFqdPOoHA1QGc6H2nfJnE9B947m4J5Q2mbb5YmHIFHjR1K9ZX93TdjGfV
         Sbl2JdqsHFO+kfkiqskTIJZXjP0hR4WWC/XG9pLm45zQZlKaiIIyQJHZ7CY+FMcmC71/
         75ou/wl0Jo6v9dt+Ag9ihlZzVo2u5qkGz5eJG3fIDaTUf4dzLjVLfJIsyKTiwjmd2Cns
         SyZSLfPvnwQ4Xqt3XoqWgfUfOWluKI271TY+8LU7tcgLI8DFPDUPH4p0poReCFM4ESvi
         y//JaG5ErR5+r+VQzPHx0XK21v92jEWkH5dB0Rj2HKNMoPOn1dEmxJ8oAZv+kXsTvgQq
         Omtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887454; x=1789492254;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OEZFudhXBWzoCl30tcULXwca6zIY1XEjQJyY0OKHCVQ=;
        b=Fvm5qxA4vLZSoLoXqiN8CPOWL1v7rPX/D0fTMZji7hbAut0DQsf6fjp9P3dsCnjqYO
         DNbRc8/8V2PJfIwKarWq0hgLaLtLaICPylSixc80QnQmYvMi15tdHaGUL5qp2WAcOyhi
         +9EhNQ8JMVgwOw9neGgxEqgnxP3bW2jpNy9nve4WYW8BW5O6G8QBs8dBiC/QTR/WdwgV
         /M/kmjcFNR8s2m4JnIsRg+ooulCxsf6Nmz81aYp76s4oZrlkZNPR/25n3fh/1DH6hES0
         KvFUY/UYcd7bL862qY2grTJV9Tr5RGB4IibGuWHYhsHMTRYgnxr1rO0o3IkpToV/P8Ys
         Hl9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzjjJzTbuOs3aKjH//p/O1PgS/fpT6GzMIOgSEgq9/TEqWo3hkaxvxUG6PQ/wRCmBVlGWemMZo=@vger.kernel.org
X-Gm-Message-State: AFuF++kO2+eEHKotPWreDuqkSagTn/mqm9ENQhfVfIX7zlTXdU7Ne1na
	96eSi1IugwDbLlD+a0QV83FNXb9S62K41VUn7+1j/oIKdHGCzNjPjRyHj5VvT1TpZRQG1KpYD8r
	TxKgU1/VId/sOWriM7Fj30zVaJH81X8tjtwj1pVHbnnoHhmHhmjat3MfzSQ==
X-Gm-Gg: AYBFou086J0Ut9dy9RC/bs+IFciBbCPgzLjsYF5if4xPyn0Ki9zzEp53dYg2xwpGzNR
	iXOwMODjwX3fHP8pLk8Q0ObMonsBXF8SRWvNk+Za4GyEz14Jf1fUFu3vdb2U404gLjZ4FbZMo+R
	xWpp59WgPRK3gXBmKcq26840kVbqVQ2sfprB3Ywc3TVuHFDVzwyGWocV0PsBvj9ksLKESJ6Mo3C
	u84161lxhgeIkeMIn6OWXsS2cW9hCrGrAbQF9jLvAjukNRv3AeBfUEuH+vi4LQ6gJ1ab+MZwlS9
	3yk1ODWTv4KAZUkALURJMpkbKCsgJXOIdesMTGrz2HjTmePmxYjHEMF+GOs+miLgE0y4/trZiUm
	0oklRLwVU++C69Z4bWkKUR9odjxNCeyyoHxhUZn4hjUjWLUj3xpxQ/HIMsptnE0iL5WPjHuOvZ5
	VP1HQ8cDD1QUHASgu3wBvBYg==
X-Received: by 2002:a05:6a20:4306:b0:3d0:9590:7148 with SMTP id adf61e73a8af0-3da3a11f7a1mr44331544637.17.1788887454221;
        Tue, 08 Sep 2026 10:10:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:4306:b0:3d0:9590:7148 with SMTP id adf61e73a8af0-3da3a11f7a1mr44331431637.17.1788887453622;
        Tue, 08 Sep 2026 10:10:53 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm31773675eec.4.2026.09.08.10.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:10:52 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Subject: [PATCH RESEND wireless-next 12/18] wifi: nl80211: Define attributes to pack SMD BSS Transition context
Date: Tue,  8 Sep 2026 22:39:40 +0530
Message-Id: <20260908-smd-v1-12-9fd2d876a1fb@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=J7GaKgnS c=1 sm=1 tr=0 ts=6aa0419f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=dL9KhdaHfVATLDi8aJoA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: 4kIeaC-lvWSRYj4oeqIlmK0WpP9B13XQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfXy3nxkW/g9DcJ
 C2WUfe6MgnQO2P65IymM8635+zrdVlqCZXxrDd9O6QCqencr6B6wlkMMND6O85ki//oL9X5sw0t
 jwOGPb6QqgZ5s8cyE1FS26udzeSt+JvYZsVjQ3bmZqZavXLJ/Qo6xB7c0EVEmLTCo8ezaohzlLt
 Cp8P44+Rf7oXYv0uMsG8MpAQzPJVZx3qVOsavc9OlSlM+2PAaGLgs5Uvhmh5gT9UIMRKQF5NYgv
 rGoZazBNB0iJNScu3RegcP24wBNXAXsqybe42Gnj7dcbSkYbPXERH39DdmF3V1ODO+F2hQI7LFw
 MdR4Y+C/3Jxb1Rqmx3pBbCwSRkVJQ3+e6EY7kFfMeiRijtv57DTgx139ny1eytMKA4fJoLFIGoY
 XOZsNYyzKTo/HlWAPlvoHWVlGQbY6/fDlxDOp1jnw6Q+lMUjcKvH1F3CZX0RU5XJMoA31Pp6iY+
 R3d1VKR+rg5fW8Cp5Jg==
X-Proofpoint-GUID: 4kIeaC-lvWSRYj4oeqIlmK0WpP9B13XQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE4NSBTYWx0ZWRfX+N3YvnsyhY1s
 XGbR8YCZF8vF+/VCMXoqDyH0wgC24Fj4dJd7mk08T9KAMwuVKmyP2NsUA5jEFul8Hi+rO2DICqE
 1JdBHcQi/JK25uaaQwdc11B+V+afgvg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080185

Define nl80211 attributes and policies required to pack SMD BSS Transition
context along with NL80211_CMD_FRAME to be sent to userspace, and to set
and get the context during roaming via current AP MLD and roaming via
target AP MLD. Without these, userspace will not be able to transport the
context to the target AP MLD, program the context on the target AP MLD TX
and RX queues, nor fetch the context on behalf of the target AP MLD if
the ST Execution frame is sent directly to the target.

Suggested-by: Jouni Malinen <jouni.malinen@oss.qualcomm.com>
Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/uapi/linux/nl80211.h | 163 +++++++++++++++++++++++++++++++++++++++++++
 net/wireless/nl80211.c       |  44 ++++++++++++
 2 files changed, 207 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 65c7eefe9db5..f41266181bf1 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1427,6 +1427,18 @@
  * @NL80211_CMD_STOP_PD: Stop the PD operation, identified by
  *	its %NL80211_ATTR_WDEV interface.
  *
+ * @NL80211_CMD_SET_SMD_CTX: Set the SMD BSS Transition dynamic context for a
+ *	non-AP MLD sent from the current AP MLD on the target AP MLD managed by
+ *	an SMD-ME. This command carries %NL80211_ATTR_MLD_ADDR,
+ *	%NL80211_ATTR_SMD_CTX_TYPE and %NL80211_ATTR_SMD_CTX.
+ * @NL80211_CMD_GET_SMD_CTX: Get the SMD BSS Transition dynamic context for a
+ *	non-AP MLD associated to an AP MLD managed by an SMD-ME. This command
+ *	carries %NL80211_ATTR_MLD_ADDR and %NL80211_ATTR_SMD_CTX_TYPE.
+ * @NL80211_CMD_SMD_CTX_EVENT: Event reporting the collected SMD context
+ *	(requested via %NL80211_CMD_GET_SMD_CTX) to userspace. It carries
+ *	%NL80211_ATTR_MLD_ADDR, %NL80211_ATTR_SMD_CTX_TYPE, and
+ *	%NL80211_ATTR_SMD_CTX.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1705,6 +1717,10 @@ enum nl80211_commands {
 	NL80211_CMD_START_PD,
 	NL80211_CMD_STOP_PD,
 
+	NL80211_CMD_SET_SMD_CTX,
+	NL80211_CMD_GET_SMD_CTX,
+	NL80211_CMD_SMD_CTX_EVENT,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -3207,6 +3223,13 @@ enum nl80211_commands {
  *	IEEE P802.11bn/D2.0, Aug 2026, subclause 37.16.6).
  *	This flag is carried in %NL80211_CMD_NEW_STATION.
  *
+ * @NL80211_ATTR_SMD_CTX: Nested attribute associated with UHR SMD BSS
+ *	Transition data. Used with %NL80211_CMD_SET_SMD_CTX and
+ *	%NL80211_CMD_SMD_CTX_EVENT. See &enum nl80211_smd_ctx.
+ * @NL80211_ATTR_SMD_CTX_TYPE: u8 attribute specifying the type of SMD context.
+ *	Used along with %NL80211_CMD_SET_SMD_CTX, %NL80211_CMD_GET_SMD_CTX,
+ *	and %NL80211_CMD_SMD_CTX_EVENT.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3815,6 +3838,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_SMD_ROAM_STA,
 
+	NL80211_ATTR_SMD_CTX,
+	NL80211_ATTR_SMD_CTX_TYPE,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -9247,4 +9273,141 @@ enum nl80211_smd_params_attrs {
 	NL80211_SMD_PARAMS_ATTR_MAX = __NL80211_SMD_PARAMS_ATTR_LAST - 1
 };
 
+/**
+ * enum nl80211_smd_ctx_type - SMD Request Type values
+ *
+ * Used with %NL80211_ATTR_SMD_CTX_TYPE.
+ *
+ * @NL80211_SMD_CTX_TYPE_PREP: SMD BSS Transition (ST) Preparation.
+ * @NL80211_SMD_CTX_TYPE_EXEC: ST Execution.
+ * @NUM_SMD_CTX_TYPES: internal.
+ * @NL80211_SMD_CTX_TYPE_MAX: Max type of ST context.
+ */
+enum nl80211_smd_ctx_type {
+	NL80211_SMD_CTX_TYPE_PREP,
+	NL80211_SMD_CTX_TYPE_EXEC,
+
+	NUM_SMD_CTX_TYPES,
+	NL80211_SMD_CTX_TYPE_MAX = NUM_SMD_CTX_TYPES - 1,
+};
+
+/**
+ * enum nl80211_smd_ctx_ba_param - SMD Block Ack Context attributes
+ *
+ * @__NL80211_SMD_CTX_BA_ATTR_INVALID: Invalid attribute.
+ * @NL80211_SMD_CTX_BA_ATTR_BUFF_SIZE: Required (u16) BA buffer size.
+ * @NL80211_SMD_CTX_BA_ATTR_POLICY: Required (u8) BA policy.
+ * @NL80211_SMD_CTX_BA_ATTR_AMSDU_SUPPORT: Flag attribute to indicate
+ *	AMSDU support.
+ * @NL80211_SMD_CTX_BA_ATTR_TIMEOUT: Required (u16) Block Ack timeout.
+ * @NL80211_SMD_CTX_BA_ATTR_EXT_NO_FRAG: Flag attribute to indicate
+ *	fragmentation support.
+ * @NL80211_SMD_CTX_BA_ATTR_EXT_FRAG_LEVEL: Required (u8) HE fragmentation
+ *	level.
+ * @NL80211_SMD_CTX_BA_ATTR_EXT_BUFF_SIZE: Required (u16) extended buffer size.
+ * @__NL80211_SMD_CTX_BA_ATTR_LAST: Last attribute, used internally.
+ * @NL80211_SMD_CTX_BA_ATTR_MAX: Max attribute.
+ *
+ * Used with %NL80211_SMD_CTX_DL_ATTR_BA_PARAMS and
+ * %NL80211_SMD_CTX_UL_ATTR_BA_PARAMS.
+ */
+enum nl80211_smd_ctx_ba_param {
+	__NL80211_SMD_CTX_BA_ATTR_INVALID,
+	NL80211_SMD_CTX_BA_ATTR_BUFF_SIZE,
+	NL80211_SMD_CTX_BA_ATTR_POLICY,
+	NL80211_SMD_CTX_BA_ATTR_AMSDU_SUPPORT,
+	NL80211_SMD_CTX_BA_ATTR_TIMEOUT,
+	NL80211_SMD_CTX_BA_ATTR_EXT_NO_FRAG,
+	NL80211_SMD_CTX_BA_ATTR_EXT_FRAG_LEVEL,
+	NL80211_SMD_CTX_BA_ATTR_EXT_BUFF_SIZE,
+
+	__NL80211_SMD_CTX_BA_ATTR_LAST,
+	NL80211_SMD_CTX_BA_ATTR_MAX = __NL80211_SMD_CTX_BA_ATTR_LAST - 1
+};
+
+/**
+ * enum nl80211_smd_ctx_dl - SMD Dynamic Context - DL direction
+ *
+ * @__NL80211_SMD_CTX_DL_ATTR_INVALID: Invalid attribute.
+ * @NL80211_SMD_CTX_DL_ATTR_VALID_TID_BITMAP: Optional (u8) TIDs included.
+ * @NL80211_SMD_CTX_DL_ATTR_SN: Optional (nested) next SN (u16) per TID to
+ *	be assigned to DL individually addressed frames.
+ * @NL80211_SMD_CTX_DL_ATTR_PN: Optional (binary) starting PN (max 16 bytes) for
+ *	DL individually addressed frames.
+ * @NL80211_SMD_CTX_DL_ATTR_BA_PARAMS: Optional (nested) Block Ack parameters,
+ *	nested array of TIDs (uses &enum nl80211_smd_ctx_ba_param).
+ * @__NL80211_SMD_CTX_DL_ATTR_LAST: Last attribute, used internally.
+ * @NL80211_SMD_CTX_DL_ATTR_MAX: Max attribute.
+ *
+ * Used with %NL80211_SMD_CTX_ATTR_DL.
+ */
+enum nl80211_smd_ctx_dl {
+	__NL80211_SMD_CTX_DL_ATTR_INVALID,
+	NL80211_SMD_CTX_DL_ATTR_VALID_TID_BITMAP,
+	NL80211_SMD_CTX_DL_ATTR_SN,
+	NL80211_SMD_CTX_DL_ATTR_PN,
+	NL80211_SMD_CTX_DL_ATTR_BA_PARAMS,
+
+	__NL80211_SMD_CTX_DL_ATTR_LAST,
+	NL80211_SMD_CTX_DL_ATTR_MAX = __NL80211_SMD_CTX_DL_ATTR_LAST - 1
+};
+
+/**
+ * enum nl80211_smd_ctx_ul - SMD Dynamic Context - UL direction
+ *
+ * @__NL80211_SMD_CTX_UL_ATTR_INVALID: Invalid attribute.
+ * @NL80211_SMD_CTX_UL_ATTR_VALID_TID_BITMAP: Optional (u8) TIDs included.
+ * @NL80211_SMD_CTX_UL_ATTR_SN: Optional (nested) last SN received per TID
+ *	for UL individually addressed frames.
+ * @NL80211_SMD_CTX_UL_ATTR_PN: Optional (nested) last PN received per TID
+ *	for UL individually addressed frames.
+ * @NL80211_SMD_CTX_UL_ATTR_BA_PARAMS: Optional (nested) Block Ack parameters
+ *	(uses &enum nl80211_smd_ctx_ba_param).
+ * @__NL80211_SMD_CTX_UL_ATTR_LAST: Last attribute, used internally.
+ * @NL80211_SMD_CTX_UL_ATTR_MAX: Max attribute.
+ *
+ * Used with %NL80211_SMD_CTX_ATTR_UL.
+ */
+enum nl80211_smd_ctx_ul {
+	__NL80211_SMD_CTX_UL_ATTR_INVALID,
+	NL80211_SMD_CTX_UL_ATTR_VALID_TID_BITMAP,
+	NL80211_SMD_CTX_UL_ATTR_SN,
+	NL80211_SMD_CTX_UL_ATTR_PN,
+	NL80211_SMD_CTX_UL_ATTR_BA_PARAMS,
+
+	__NL80211_SMD_CTX_UL_ATTR_LAST,
+	NL80211_SMD_CTX_UL_ATTR_MAX = __NL80211_SMD_CTX_UL_ATTR_LAST - 1
+};
+
+/**
+ * enum nl80211_smd_ctx - SMD Context information
+ *
+ * Top-level container for SMD BSS Transition dynamic context.  Carried in
+ * %NL80211_ATTR_SMD_CTX with %NL80211_CMD_SET_SMD_CTX (target AP MLD) or
+ * with %NL80211_CMD_FRAME (current AP MLD reporting context to userspace)
+ * and %NL80211_CMD_SMD_CTX_EVENT (current AP MLD reporting the requested
+ * context on behalf of the target AP MLD).
+ *
+ * @__NL80211_SMD_CTX_ATTR_INVALID: Invalid attribute.
+ * @NL80211_SMD_CTX_ATTR_DL: Optional (nested) DL parameters.
+ *	See &enum nl80211_smd_ctx_dl.
+ * @NL80211_SMD_CTX_ATTR_UL: Optional (nested) UL parameters.
+ *	See &enum nl80211_smd_ctx_ul.
+ * @NL80211_SMD_CTX_ATTR_DRV_DATA: Optional (binary) driver-specific blob.
+ *	Passed through nl80211 as a blob; parsed only at the driver layer of
+ *	the current AP MLD and target AP MLD. First 3 bytes shall be driver OUI
+ *	for the driver to parse as required.
+ * @__NL80211_SMD_CTX_ATTR_LAST: Last attribute, used internally.
+ * @NL80211_SMD_CTX_ATTR_MAX: Max attribute.
+ */
+enum nl80211_smd_ctx {
+	__NL80211_SMD_CTX_ATTR_INVALID,
+	NL80211_SMD_CTX_ATTR_DL,
+	NL80211_SMD_CTX_ATTR_UL,
+	NL80211_SMD_CTX_ATTR_DRV_DATA,
+
+	__NL80211_SMD_CTX_ATTR_LAST,
+	NL80211_SMD_CTX_ATTR_MAX = __NL80211_SMD_CTX_ATTR_LAST - 1
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 282d3c82dce8..d59f0eb40493 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -704,6 +704,47 @@ nl80211_smd_params_policy[NL80211_SMD_PARAMS_ATTR_MAX + 1] = {
 	[NL80211_SMD_PARAMS_ATTR_NEIGHBOR_PROBING] = { .type = NLA_FLAG },
 };
 
+static const struct nla_policy
+nl80211_smd_ctx_ba_policy[NL80211_SMD_CTX_BA_ATTR_MAX + 1] = {
+	[NL80211_SMD_CTX_BA_ATTR_BUFF_SIZE] = { .type = NLA_U16 },
+	[NL80211_SMD_CTX_BA_ATTR_POLICY] = { .type = NLA_U8 },
+	[NL80211_SMD_CTX_BA_ATTR_AMSDU_SUPPORT] = { .type = NLA_FLAG },
+	[NL80211_SMD_CTX_BA_ATTR_TIMEOUT] = { .type = NLA_U16 },
+	[NL80211_SMD_CTX_BA_ATTR_EXT_NO_FRAG] = { .type = NLA_FLAG },
+	[NL80211_SMD_CTX_BA_ATTR_EXT_FRAG_LEVEL] = { .type = NLA_U8 },
+	[NL80211_SMD_CTX_BA_ATTR_EXT_BUFF_SIZE] = { .type = NLA_U16 },
+};
+
+static const struct nla_policy
+nl80211_smd_ctx_dl_policy[NL80211_SMD_CTX_DL_ATTR_MAX + 1] = {
+	[NL80211_SMD_CTX_DL_ATTR_VALID_TID_BITMAP] = { .type = NLA_U8 },
+	[NL80211_SMD_CTX_DL_ATTR_SN] = { .type = NLA_NESTED },
+	[NL80211_SMD_CTX_DL_ATTR_PN] = { .type = NLA_BINARY,
+					 .len = IEEE80211_SMD_CTX_MAX_PN_LEN },
+	[NL80211_SMD_CTX_DL_ATTR_BA_PARAMS] =
+		NLA_POLICY_NESTED_ARRAY(nl80211_smd_ctx_ba_policy),
+};
+
+static const struct nla_policy
+nl80211_smd_ctx_ul_policy[NL80211_SMD_CTX_UL_ATTR_MAX + 1] = {
+	[NL80211_SMD_CTX_UL_ATTR_VALID_TID_BITMAP] = { .type = NLA_U8 },
+	[NL80211_SMD_CTX_UL_ATTR_SN] = { .type = NLA_NESTED },
+	[NL80211_SMD_CTX_UL_ATTR_PN] = { .type = NLA_NESTED },
+	[NL80211_SMD_CTX_UL_ATTR_BA_PARAMS] =
+		NLA_POLICY_NESTED_ARRAY(nl80211_smd_ctx_ba_policy),
+};
+
+static const struct nla_policy
+nl80211_smd_ctx_policy[NL80211_SMD_CTX_ATTR_MAX + 1] = {
+	[NL80211_SMD_CTX_ATTR_DL] =
+		NLA_POLICY_NESTED(nl80211_smd_ctx_dl_policy),
+	[NL80211_SMD_CTX_ATTR_UL] =
+		NLA_POLICY_NESTED(nl80211_smd_ctx_ul_policy),
+	[NL80211_SMD_CTX_ATTR_DRV_DATA] =
+		NLA_POLICY_RANGE(NLA_BINARY,
+				 3, IEEE80211_MAX_DATA_LEN),
+};
+
 static const struct netlink_range_validation nl80211_punct_bitmap_range = {
 	.min = 0,
 	.max = 0xffff,
@@ -1118,6 +1159,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_PEER_SMD_MAC_ADDR] = NLA_POLICY_ETH_ADDR,
 	[NL80211_ATTR_PEER_SMD_DL_DATA_FORWARDING] = { .type = NLA_FLAG },
 	[NL80211_ATTR_SMD_ROAM_STA] = { .type = NLA_FLAG },
+	[NL80211_ATTR_SMD_CTX] = NLA_POLICY_NESTED(nl80211_smd_ctx_policy),
+	[NL80211_ATTR_SMD_CTX_TYPE] =
+		NLA_POLICY_MAX(NLA_U8, NL80211_SMD_CTX_TYPE_MAX),
 };
 
 /* policy for the key attributes */

-- 
2.34.1

