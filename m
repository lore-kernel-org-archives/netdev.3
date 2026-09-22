Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6AA572663
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096902; cv=none; b=CidO8dnFMQlGQ30Cri2uxVH7fGAbN+3vihLpvtOxXkuL+nJ5g1PoY3pay6Ztm71cY8NMZL9MG0xrTEDp5RAsv42qOh57JsZLaXdfATiM3A9HLHUXvA/pxaCaCB66Wm2ipQyKx/AuMo91vYLC2YdB0UDrTmZBUr/86Viu0V1tg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096902; c=relaxed/simple;
	bh=iD/zzZgmRhJW4Nl5vQPx14/d2nileWoW87yndp3Ml1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRb0/u3Wzz+HyKmz6sbDdnbBqfcc9XKqjA6MiWFj8bsFKpfvxZkqrFxPWAFIytrN5nC6WdQkOAlqp9HYSytfG0BczJhPvUnBBB2F3L8HSBjkpYbAwsrngRhXHuvutN26LJpRinP15+KCjoQTHyojFdFD+BXml5EhLFXuYASocek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Svvt2SmY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YqtxHqxZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Svvt2SmY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YqtxHqxZ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MEjGvH449454
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x8oRSt+sEOboeNFCv168cePKrrWr+FqZQJjlgNOUwk0=; b=Svvt2SmY3+ymXzIc
	CWQFf9FtmUpvg7wLbV3aChiv1BvdzWYKR/XATRtCRlgqY2s232oIzC2ikWZSnQXu
	vKmpSVO+G+nqMkEI7Qt5YfXiDjx+htW+pI164UPoJdMlFp3uP0aLazcfg0XJhp7w
	gwPTVTV8fOUliKjD0nluzlof3bxyI6pEtCzXziTVhi4N3kf6Oi0E2dXu7Zon96Os
	ZVDi5Y6Y5T+LYGee5fJ0vyUlGU6kCeTfIQCLO/hTzJUFMgKkvsIthosPABrg3MK4
	8e6z3f8/giPGT/MNioYR4oltQpimlJdnMNmZa/7pbfyFqtxo0UAC9ovG0zBojsOe
	EJChxw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gunjytjp0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:08:19 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7909e307799so9569137.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790096895; x=1790701695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x8oRSt+sEOboeNFCv168cePKrrWr+FqZQJjlgNOUwk0=;
        b=YqtxHqxZQbhoKmmMaEipVx19GlMYZcqpSAUTjC6SMlWIoGF726grZESiZ2VeAbtNN/
         HaioNGT0h+vGjVu9t9E92XABA/yYsvneaxz3BUvmBvn/Mujm44c5EjJI7xRdy40f1r12
         hVue2LCl1Yp9zsJgh+6FN4BQ7isFSc0XCchPOuxt/GqpHINhw5VCy/NLIlxduZHUiL3t
         6zGv8p70tNTfhv0nn8T5DFOac7BuYNr4kyTZcU+w+BBc6TU0UpdP0G9lgx7jzqQPXXp4
         PFWJ64ndEh+sM0yLwCiqGTmJ9+sYDNcCP8UPZnEi3pPVNRt3bDyiRnjBQQmgDwkWjl36
         oGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790096895; x=1790701695;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x8oRSt+sEOboeNFCv168cePKrrWr+FqZQJjlgNOUwk0=;
        b=itT05Zr8cPuaa09XPosAIXGRFmxIDZDINBRMvEdWdyAzG5rsu/nZFTK3jU/CnwZAHw
         A68L1yZ/TG4UjBBofcRWN5L2ShEwidVaqfpiuawwEm3dsS3yjl8bAZnBwAOtErYV6zGg
         bx8dEFr9UbfMklRZteXg0ArQUoMFeSY0c4GQAxEWa7uQrWMaID82HgoqvTRPR04/LjK+
         taX0bZ17Ov3EVRDrlIcXb/L4u6+eRJU8/CY3k4cubKo64jicLeb1do09LWBP7gcxYj99
         q7ve1ChMk3mHwXdAhUmq3EecardPw+TIA2JEmE9TDB23+CKifbTYGL64E4x4Rj0G6EzB
         74ng==
X-Forwarded-Encrypted: i=1; AKwUvBy76wqo0Ftqo/PdAPyD37FLwy4JfUwEsm9erxb4ntUOpqHRN9wpQZGcXxf4QDU+9vX/na3MpHA=@vger.kernel.org
X-Gm-Message-State: AFuF++mN8OwDARRChkAPzdvFIinPKwSiv/a1Pn/6KUjh8lTk9XnFwEtk
	aWYATetuQBaZfXN5XOWHrZNKWoluA6Tla4VVU/uJyUKMCV9g43KdQo6JtuXBgMK1CTVErrHr22k
	v1IxsYZ8B0rMYEv0VEIjzzvoR1igTdEa7sfZrqmffCBx/6BqjIDSEDPtJShs=
X-Gm-Gg: AYBFou1cZeD+zFaAu4Wz3m29lhsWdJnhtf64+IBQSwFl4vl/DOjXhu9tNPnnm8+68gr
	E8KMhoF87d+XfB+3KI9MTSQAppVuo+5kr+VvzdM86doFQDToeiq7gNH3ewvaKthRrCYRl4Fb6bu
	ESUQoe970ls48WXZ8eWrJkOQg+uopv0oyhHBuwEFfQf/jH3iCNBR3vHmKZ0iHkpy+iox+KXszlQ
	ymVu0s0AFLbcp72sS8IhTVfv9FqONoss1zkrQh7nTn4FwDwqltvL+3bxwL/9bYZLpYlawvc/Xa0
	nISDwDb5ziEe/rda2k7Eh8TomZNHlehzCqmCVtCk9uBdeavEtrQX9gDc/UAfxwZOguLnp2AeLeH
	9hwh3fOG0fpQwcBgjVyBiRu4DFF6o4fhFTuLLiV8=
X-Received: by 2002:a05:6102:8094:b0:7a7:19aa:8a85 with SMTP id ada2fe7eead31-7a719aa90a9mr7105781137.32.1790096895143;
        Tue, 22 Sep 2026 10:08:15 -0700 (PDT)
X-Received: by 2002:a05:6102:8094:b0:7a7:19aa:8a85 with SMTP id ada2fe7eead31-7a719aa90a9mr7105724137.32.1790096894617;
        Tue, 22 Sep 2026 10:08:14 -0700 (PDT)
Received: from [10.243.142.186] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1c0f6csm5359905e9.3.2026.09.22.10.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 10:08:13 -0700 (PDT)
Message-ID: <3f5da6c9-7394-4452-92f8-b773cd34aecf@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 18:08:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] net: qrtr: Allow the host QRTR to assign a unique
 node id
To: manivannan.sadhasivam@oss.qualcomm.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>
References: <20260921-qrtr-multi-ep-v2-0-27dd80d841a0@oss.qualcomm.com>
 <20260921-qrtr-multi-ep-v2-1-27dd80d841a0@oss.qualcomm.com>
Content-Language: en-US
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
In-Reply-To: <20260921-qrtr-multi-ep-v2-1-27dd80d841a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: y4N4xKfDHhwxIgT4OgNFZCHqpO1Xujct
X-Authority-Analysis: v=2.4 cv=KqHYSmWN c=1 sm=1 tr=0 ts=6ab2b603 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=JX_TeLtU1EXCEf5LEwoA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1MCBTYWx0ZWRfXzTkG5wn9TVUX
 rEfES3BFLoFvUPfmusAd+mtzT7FQvcA4jTf6kXhUyiqyNDWTvrqr4ChcQG0h92r48fPDpg1JLzI
 58xjp3Dn+/Pn37l/nPx+GEx/mz+/Bp4m0BgT/jxChhXFpZ9BTN+PjD0hIR7JXAGvfcz0+M0Pqe3
 WaPeWErnPQEFoYd8AS5rnvKMy+oK1qgTQcI/+87BX/BSM7UF70q/oQ97oCQqi96w7AY6dlxtxMm
 qAtfaYgTtWvGT1tk/ZelyYP2rLrDch6mpR8qvpzykn10ogfrfA6C7902dnqPSSEHNgCagMSkVpy
 3sDDl4IAM+8j48K7FRg2diBh+ESltj2hQxuE4bKcesgMY+RJ+Tl7nPjU0TEkwS80D0XwCuOjv1q
 69g5o9T1rhJonffox6c3Ka4gWm+1+vxJDKF0TniARC2L3Bz4wBNGVA6iOLKnflEVcDNEFjgRKJV
 oK5iKYgI4S5LwoF+hKQ==
X-Proofpoint-ORIG-GUID: y4N4xKfDHhwxIgT4OgNFZCHqpO1Xujct
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1MCBTYWx0ZWRfX+kjr+3MzUSE1
 CFKABWanUjMd+0D1Z1d+FzKzOsRYPwt4yof5QeDoxzy+0nkVwYkFg1XgPj3V5vkgE3wR2QeMAid
 +gvGjhmoDuS67OWxz3KOInVeeGio7Nk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220250



On 9/21/2026 12:23 PM, Manivannan Sadhasivam via B4 Relay wrote:
> +/* Replace the node id in the control packet with 'node->nid', if both are
> + * different.
> + */
> +static void qrtr_node_rewrite_ctrl(struct qrtr_node *node, unsigned int type,
> +				   struct sk_buff *skb)
> +{
> +	struct qrtr_ctrl_pkt *pkt;
> +	__le32 *nid;
> +
> +	if (node->nid == node->ep_nid)
> +		return;
> +
> +	if (skb->len < sizeof(*pkt))
> +		return;
> +
> +	pkt = (struct qrtr_ctrl_pkt *)skb->data;
> +	if (type == QRTR_TYPE_DEL_CLIENT)
qrtr_tx_wait() will create a qrtr_tx_flow object keyed by qrtr_node->nid.
qrtr_tx_resume will attempt to retrieve it with qrtr_node->ep_nid, which
will fail. This leads to the HTD path pending packets reaching
QRTR_TX_FLOW_HIGH and block indefinitely. QRTR_TYPE_RESUME_TX should
be handled here.> +		nid = &pkt->client.node;
> +	else
> +		nid = &pkt->server.node;
> +
> +	/* Rewrite only the endpoint's node id, not those of bridged nodes */
> +	if (le32_to_cpu(*nid) == node->ep_nid)
> +		*nid = cpu_to_le32(node->nid);
> +}
> +
Thanks,
Youssef
