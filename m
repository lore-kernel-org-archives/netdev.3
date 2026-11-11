Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407344;
	b=j6uq0lBgMuxMzsvEPrXXPnihh0GcubPjsz3FWlx40nRFRew40akr0mcG3DDyz4FOUl4/
	 EWdMJj/OxvfKFKbbwLgzyuSkRgwQlG2LjqQHtG0pnRcT9ZTyhY/EMSQsWtVK5gYDnj+Mr
	 1zFLqhmQ2cN+IYYMjJ/2wv/qeBvXbHe2JRjD3BA3DqQFhhXR5+Z2vZQH1Jel6u7wkJi7f
	 t3Nr9DRgPJzdrv/Aa9rgjfxbnMd4Nwz0gid5O2o+4sjkRpZc+k2MgS7aVkT+j7M2NA6S5
	 xMZiJ6JK1quuXUpg7EjhH3QgxlBQSqZg92LCq31uhTLwM7adjKWiLdG2jBBeQukKk2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407344;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FvLCFQbdJHdvS8TiMxoEDBC0gskgFKfqHEXYuNhy+a0=;
	b=yw/UqR8gvmXLKnw1mtKiR0+/BLB6DB8TBBHz1Fvab2TTJsNG9pIKm+s3jzVVBSnFWDJx
	 OUM5R8Cnm55xBirPxEVqZ/81BCSXyAhXRp0oBk5kEOs+QCvGEYOddEz+I2s+ub7QdowGU
	 3/m2gRw9Skx6ctxsv8aUZDhXPdTfTTTdd1DE2j/6RcaCQrTmXLJiSckRobtclEjWtCFbE
	 f03yVsfYv9NAt0vtQBnDOqEHqcMwoqR3Hlo3+hhmP1K2WfH1ursgog1Hf14CRyzTtEfWo
	 Dh6Mbra8ASk6I85IEa+v8H29wQszVFZKe5F8y3n8AnKtI6pbYs3vQCCCOg0aYjUD5Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JhrY4cSQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gYfYXp9O;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DF1606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0DF1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JhrY4cSQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gYfYXp9O
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABEHSP92556284
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FvLCFQbdJHdvS8TiMxoEDBC0
	gskgFKfqHEXYuNhy+a0=; b=JhrY4cSQYGOtqDcNJaKvvgLzaupKE1Ku3eDcqwyX
	QDHO1k0bvbgSW/KCwm/VFAc0rVHSknHxz36AL9C0b/BVHI7rPYMG1xi/XXGyGGXT
	PrfN2GlbXn6avqLd70EZi+lIlPlJH/3Fe1iplD+ubpTojdFgCluVGK20X6FIehYg
	GM76rfGBAk1oVVMVzlxUjBiOlRJyvhRd2GvUhw+MaJewvJQpIZK2IUF0G8+CediS
	h3rmQyhiPo63i0sCVwJlnKKIYY8TUo0Jque6Ys584O3MMvhhVpOrGoMtCSeBgpyB
	3cawDBTf/NEhweoavDi5an2wzlyvoOPwLoeASltoopFzFw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnmb26t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:29:02 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7d2ca2a4489so737060137.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794407342; x=1795012142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FvLCFQbdJHdvS8TiMxoEDBC0gskgFKfqHEXYuNhy+a0=;
        b=gYfYXp9OD7PM7oOU70POvyJhUdKhV7sHsZhU5aF2+qVWuiXwcMer4xyFEJTa/saBfL
         xd9QMrKc4X2rF6NFNxR9e50+Jh+dMXKMJQdCjRpRvbwtBvDhYHM3RCfaGZqYC3UXjCOR
         KFKZQaYtREBPRj2PRfqu1UcLa59rNA2izJ6poxC7c1WYiAtD+KRbDNtkEV1htHtcetRu
         LMdCe5C1e8uez0s8FlfrZW/CaSPA4C+I2/owbLLmqbQ9eXA3RDajw1ygWVBkZDDWDg7W
         HnOksA9Vyr0ix5MWUmPyokSBxc8bat7IQ3xwvciYNJqtBhfAGFVONNBQ+Ly1Lq3Vt6eK
         Q8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794407342; x=1795012142;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FvLCFQbdJHdvS8TiMxoEDBC0gskgFKfqHEXYuNhy+a0=;
        b=GbuZR3jBWOVnrK2p9ZL0Fvd9wqY5bjKwskU1K9bAl0GxWea5iS8h2StEpudjTsmRHT
         9f8b72TSB6NGbjoKe/qny+1mFfWq8hBSGMJ3h64VN5leT34nb1/hoDmPi7H+6tb4mmaZ
         eLafG1yIO6C5JvfHTySApY2CPEgguJuiCQC2VxRQjCocN/YI/ACT+Oi4r5AOGlAMVJai
         l5g5kQIjmoqGLN+PV7JQHwdKgcYBvEEDmvwXCtX4YRfoT9rHvWnoLrtPXaLXIx9Y9JAq
         lzGdfhtLcuwoeS1Thz5vZoZGf4t2C5R/RwLn8/mNNSBkufoLpv5lRkdhX//1KTbr69sF
         JdpQ==
X-Forwarded-Encrypted: i=1; AL+hErGURd/e82iiGfQtScuLYBle908ihF4CJdmfw1n1EZ9q2gR5NlVz7xBGNiPKJ8Y9w/YZeYrxi58=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PfPsg8QByc8rvo4vYQI+HCxnT4jBg4vp17XiASnHFjAfKGOdL
	NaPQKjtK/3hisw5550JSRo+0j/hKodmYBUSO8aEpstbSkw7dOR2S10IuN9kaHfGuKDn4NFK/V0y
	etSXv7IyNSvMRZSaFfNpzH+xHTsIsGUFBAOputrk2p1pKRBYeW3uMy/HfEVQ=
X-Gm-Gg: AYBFou3oI6zmtpNsATU3FX4qTB9UnXPaDIHUskcgN0jVtcowz9R3yWs/Wzhm4NsAid3
	6q4GyD0uICVksd0aYHMDErsDTpmHdlAaz3QGASY8sPNZfIQuw2d85hYCyrcuCFNYls/cKGTCPF1
	fOjn62Zl18VvF6WloF0ZGq6symyHJ/dE+a5ZPJAJNaaPo1R7MzZyv/wsBPo7lAUsvjNpZzznmXZ
	4GKKtNtYD9yWbjuTq7Jr+T4L+/MGFsuv3orXRhnYNFo9h4o3nliLBQJvZlI5+R6HPvTxN1Kdcir
	t0DV5lOSH9pfHWlNG8nclq738IHNftyumbftx3YCHwSmt6HKpCWAB9hRhfSbvRVeuIEKzIu9fSq
	zvepGqNmChbO2d5/TSROW/adJs0LGuNCY1GCbPimZA3HTh4z6rLE7ZoowUM8jx+R0
X-Received: by 2002:a05:6102:54ab:b0:7d2:d159:f425 with SMTP id ada2fe7eead31-7d5060c736dmr784587137.19.1794407341944;
        Wed, 11 Nov 2026 06:29:01 -0800 (PST)
X-Received: by 2002:a05:6102:54ab:b0:7d2:d159:f425 with SMTP id ada2fe7eead31-7d5060c736dmr784569137.19.1794407341298;
        Wed, 11 Nov 2026 06:29:01 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cbbe5sm12553846f8f.42.2026.11.11.06.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:29:00 -0800 (PST)
Date: Wed, 11 Nov 2026 16:28:58 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: segcc-nord: Add I2C and TSC clock support
Message-ID: <25wbcmrhttoceflek62nu3e53xzb2jnaamawpyd4skiwnmmpjb@252s6ee2f5ol>
References: <20261107-gcc_i2c_tsc_support-v1-0-433d02972d7e@oss.qualcomm.com>
 <20261107-gcc_i2c_tsc_support-v1-2-433d02972d7e@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107-gcc_i2c_tsc_support-v1-2-433d02972d7e@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: SSEeN8HDpglU-3m5lPE04Rhhm4d72-LP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfXw0qNpOVrD+di
 Rxei1dzn9ku8cVOynSjbyAo4KWvaGqc8KesTOL9l2508OH7dHoLgHP80qcGhF2VY5RIAIQ4164s
 /sQrkib8aHBVKLEMchlYv88DcVtEtzs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX0LGZRvNpGW+f
 knn09kZRP/NzI7uY/UJMmISaOGnT0fCHfU7S0GeylsMVNZCkdntZNBjlwaAtGGBpRvg8jXbD/Wy
 QNfNfuHQwO64RopnxGMGjPFVyaQmBIe86MaETNehkBvJq9cqXIH7CcaYITeS1lVDBrVbGBjQOo7
 WPvYJwYQoGTaBq67MqXzi5/8bSO+k+fgpkAwfDyll7GMRLh3nmoibFOhXx2G91ePBjnfwyx3fUm
 r61Alb1kJ+ZrqLxFmFVAWKlhyjtao9gzPY0MrHl/V74AkdE91ibH+IXrCZ1n7dmGbp4nqdVeOA0
 LG9pTtVz3olm271qjULOS6ohZJnQ8KdrU54VpPBe+d6mrqW7DbzeEMHerhc/X8g1y9ka2gO5ZSC
 9IDcGh2gJRySJIRCEo8WGoeLWZR8udKqAxAaJR/qzd14eeRmdIiHncaqqglSI8ZPKWtCzTZucb8
 3hokKetonXdmWQ/U3GA==
X-Proofpoint-GUID: SSEeN8HDpglU-3m5lPE04Rhhm4d72-LP
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af47bae cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=OnpAFzfR-JcWsVFUPsAA:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_03,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110056

On 26-11-07 23:36:37, Taniya Das wrote:
> Describe the I2C slave and TSC subsystem clocks, reset lines, and
> parent PLL needed by the Nord SE GCC. This permits consumers to enable
> and reset the hardware through the common clock framework.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
