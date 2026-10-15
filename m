Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71314AA1D4
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048514; cv=none; b=t/SoWhifxM4zot5uPy54cWsiYg5KamM5T92tGrYE4S/bL8Y4vhsURE6A1avXZtZwkhBlrUbn7zNi4F+d0FDLbWJs28pGyG/ROVbw1TndNyrB3W7qnFh5jwvyk6aT/QifqwhI4BoKM7WHDzu25Wc5oSzI510QeyMhGU5kBPTdz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048514; c=relaxed/simple;
	bh=mfOTURXkLHsUM2K+xfvN1AuN6AP8ZVFosHyF8KwfQ8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZpKVYe+epd69+R+87GbJjUhlWOgNJJZX3397Nwf43FzpJgMgCx4rDiW0nQAk4NIjImlyaQdmQXraO4aKFr2ywezoNvWvKfxmlvfZjp/BzX+fFh1aeN2flt4pKEvMGMpyxu034PwYDR4PSzgA+nX5xUI40kKJ60OaNgBS9wbNSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hd7cS0W8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EF1xYKHs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hd7cS0W8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EF1xYKHs"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F6E9lj500299
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x5fiZu0AOBD5KzQVMVHnoqxelmroz5f5CORHmW4wi7g=; b=Hd7cS0W8Jl1T4G3W
	lIcILYHUthYwwNp+VnnsHgPvPOzdatwqQoxBL97dDpY1jgVW9T4AMHDUInX/948F
	QNKPhMrinCeS6Wo5YZSff7JWxGVgC3a4+HJmtzEdtYF10OTC8gsan+QOl1aUyGWa
	4Xxohs22R7tprpWhHlPWk8MCeDUzJu4Qa0P/KtFxydFbOd4W1Iy3Z3cJfL82zowZ
	hFjjQNlY53V13GBNZldvFsbdDrrLoETLWo4xWWzSZs9pZYOOVJu2Nd1va1xp4GBu
	Nu/uAb+R2L03pCkEQvT4YJXLboMuBdGmX/ZWDW0b69nwcr0xDu57hWA7fW0OS/6Q
	mX2uhg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf3qye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:15:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ac0ae43900so3366592a91.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 00:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792048502; x=1792653302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x5fiZu0AOBD5KzQVMVHnoqxelmroz5f5CORHmW4wi7g=;
        b=EF1xYKHsFTdPceAWMGtL+ZR9KxCMTNHVEkvPESGt6tadU0ns4NJZGUinmYyVn5JVKf
         Vw7zU0TIV+xEak+5B0w2c2LFAKjKRNG3Gr2clSi5t+gi3vrfi6tue8QZxVkqNMU18yZM
         qBY/OA7dG47hVKombAb5ysSdX7d7NRB4pO/LU9Jc8Vxkb+WOhZ4W0c+s/taIui+ZYq96
         Q++LroRBGutMLnvCFx8xe4BbCY010qzC5zIzyyfnd0e7sjzb4VarU+jwZ10iBu2Rw+d6
         8tr/oiYVGpvFQ71FuoxMJNfSfswBHy8KRzTMFQKgFM7H/eEHsDG+ffgurMVCNsJED4Qi
         eA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792048502; x=1792653302;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x5fiZu0AOBD5KzQVMVHnoqxelmroz5f5CORHmW4wi7g=;
        b=BckEZGjDFYXyax0MJv/bPjv9OVEpDVsjY1cnPsbLgdpf7q9XyGdSGe/rptXjC/UiAf
         TeZyyMp1x1TrcKhERFOYKiEqWWJ8yv3rolTKFo5HZgG7LxxI8jSGFerKXcY48hmBDOGx
         iKvOzWlrpepeMRseabGUj9SLoZugkDUWhZPnh0mnahXTo8SJ14bUtE5NqBYQTCqYrP9T
         zmWi5rXBST3O8KMU2r5+wtbGW13V1epCGqoveTm/f27g/AptXo2X3cZfx1525psfmqDU
         30tfMnHPmIUll2jxP8wtyP6Q11ILxl2csSE0Acp6Vwwfo4PRaBYv/gcuovWHDlCr0aPo
         ttKg==
X-Forwarded-Encrypted: i=1; AKwUvBxtveHmhj47ROM+ONem0bXx5pRKHSjNE4hQrPnQz+5U6CU04NdBHthd0rtXVt+ZOVgdDzb0o38=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqb7FjbPTMXqPDvc9qrz3k8HJ/ieQOR7hT5A6ri5aAtJAyc6Af
	cKSiGY4pH15mVM3IU+6xr5dM2cTcnEZ1PvTQqoMmJS1D6KhE0kp4jzPtCALXW2soXU5SP2yboBn
	M6PnFavRszc9W7zLnGT2Snf/Zym0DfWsX0FOVg/SmM2L7+U967eDwdQus17w=
X-Gm-Gg: AYBFou2NgyfX50ITcR1nBUuLRtNio8DAkX7rjPZlVYjkBnu0z2f7V/1+DEcx1z8ygXP
	l/LkWVbaa0W+AbThiCJ+gO4ahR9J3M3hcc02+SMlxTxA8wY/HDmRIEwIPNwz8OKNqs9kVbI4nhF
	0jIo+sDt7eNsekzvkB76uVUdDp/KpN6XxNO5w2VMrhpIHK18+GVsEQ03MR/jXEYkSrfT4GgbWr/
	wCyv9hziKyiFTxwDidqkg02oIlbJY5JLWfZCvGQLERWRyQLE7THxsg78BCz9JEcDfVkc7L6vSs/
	uVXvONeVBImjnymF777sse8GZToMa1Z9p3tubUF4oTzoI5KN11Lohxjse12vDq0PbqH+KdKCUBV
	CWQNFFOOyzvyDCJUjUKMtg9Uafh4=
X-Received: by 2002:a17:90b:1d4f:b0:3a8:c0cd:57f3 with SMTP id 98e67ed59e1d1-3ab3a94ff23mr14061606a91.18.1792048502043;
        Thu, 15 Oct 2026 00:15:02 -0700 (PDT)
X-Received: by 2002:a17:90b:1d4f:b0:3a8:c0cd:57f3 with SMTP id 98e67ed59e1d1-3ab3a94ff23mr14061583a91.18.1792048501560;
        Thu, 15 Oct 2026 00:15:01 -0700 (PDT)
Received: from [10.217.216.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac944511c7sm3221300a91.10.2026.10.15.00.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 00:15:00 -0700 (PDT)
Message-ID: <edb0c405-e0f4-4d17-9948-5cd1703d0c44@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:44:51 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: Add gp_mn pin state for GP M/N
 clock output
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org
References: <20260602-pdm_clk_gp_mnd_v1-v1-0-1522662b6c53@oss.qualcomm.com>
 <20260602-pdm_clk_gp_mnd_v1-v1-4-1522662b6c53@oss.qualcomm.com>
 <f6fc66d2-b40c-48a3-9dc9-bae849353e74@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <f6fc66d2-b40c-48a3-9dc9-bae849353e74@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyOCBTYWx0ZWRfX/6ysjU4rRvV+
 uqG+odUzh6NHhuJKtbZoZfapHe0PPSOnz0kHSLaYruxtaRnyQ8papr6Y6kPGhAMKPblxHIoqspV
 z5A6sJ8mTCtidIF14OS5rSg/964lOx4xhqeitHt+daez4Oc7aohm8CFrKqld9WXGH+rEkp7boj7
 HnYv7fyo4Na3PTJJ5UyqWHQti8CZ5xFLr8ZiUm6yNbgNKcaqOiqfzMK7ECRVxyJY+wKQe4H41G9
 hVVj9nZ9CSUudldEho59UA1wg10pRND5AuebAnAdzXfdaG6cmfJ63e8CaroCLn/qBE/UH61vpqY
 qj6bXSNko97Fa5A3rEmLxb5VmcIZuFvjRD78tyrFyiSGQBE9I7s9/s0IYxCBGYmOwdLbXIaIP/q
 WJoTGOSsYwRaGmrL21BFNagYUagqYx8JudLKE+C2ZwGg0Jq6hIDsDi/iq+HCzb/blUAZp9dBNTT
 BrWp+TNTSYwO+ScIZmA==
X-Proofpoint-GUID: erYe46URg2kBjcq7bLak8SeGBo-Bf6wG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyOCBTYWx0ZWRfX8+vJyv+SGv0R
 LqsuXvheJSMgKjIXjXoMrLojY20rZYqcDStOFypWwyOQh20MJ45Ruf5k0IfKBRAH35/Hqom1d9z
 ouNCTLXTebl+vtL9lyYWwmkaHokKzoY=
X-Proofpoint-ORIG-GUID: erYe46URg2kBjcq7bLak8SeGBo-Bf6wG
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6ad07d76 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=CaCc2b9mPIm3Huh5NNcA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150028



On 6/9/2026 6:58 PM, Konrad Dybcio wrote:
> On 6/2/26 5:21 PM, Taniya Das wrote:
>> Add pinctrl states for the GP M/N divider clock output pin across
>> multiple Qualcomm SoCs:
>>
>>   wire it to the GP M/N clock controller node via pinctrl-0.
>> - kodiak (sa8775p): Add gp_mn_active state on gpio35 (gp_mn function).
>> - lemans (sa8775p): Add gp_mn_active state on gpio35 (gp_mn function).
>> - monaco (qcs8300): Add gp_mn_active state on gpio32 (gp_mn function).
>>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> ---
> 
> Please squash the pinctrl addition and clock controller node addition
> patches together (single logical change), and separate them per-platform


Sure Konrad, will take care.


-- 
Thanks,
Taniya Das

