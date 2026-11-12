Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476047;
	b=rRLupkiGtfYpm6GRLh+d9tKryzDN16pQiatFHqisshU/npN1J83fTvBTHObYZXvKbZdc
	 C6tFFx8KlXRnIZGbrsgqQdeQfO//lIUMxoT8QT5sHyU3Lc+ItDR/7+3qNRPC0VT0/GPyb
	 O9u+xvsBXbl6Q2zmwMPDrNq1b5L0G5CAWzBI1jmvhsGaC/aTDjJXomMVZNWFPzJCbIf9Z
	 leUUeAuX+YGWV6SBeCI15PK8LCLEWFJ47M+QzCFmy7xwP5rtEcERVrgGLo/g0bIVxG2+t
	 zYwP9PFbPVD42omK/1OAegC5LvVEOSv69Oeo7Jd5DraxWXupzz8DBxdIh55MOGu4WXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476047;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ZEMqREsfmPbH/k7JgWoRxNTtP7MVL9uGc2qOxQ8K0XM=;
	b=DS/a6t89OAZSNFXSYnqWio5IGZpWrdj4crJ3+tPTdTEAHfX4UoAq84U9ua9Y2483R7or
	 ZGHzc7q0UwAYqUl9bYDb4hFTjb32c8ISosmmtLo3kfrAa7ywLTx3LgzyG+vs3s/RYQ7CY
	 2TlnFNDrEkgwrPwVYTnwMG+rpAYlopNnyEwNjFbtWURK4qbpiUHcjxXRWAWRKe0pgc3AV
	 D7pVXulTABZSQqg+U2Z7Hk6mTPF6Zk6gkfzTXnb3VE2JcPXHi1ScdMLLky4rPMXTxDykS
	 ARvR4Zf9rZZ6JACi8iXNgG2PcNa98S+JPfTcvTHU5mSJ6Co5UHoZ3O44J1h4YeV38aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jLYxMoQm;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R26FPh3h;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049A6606A32E
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 049A6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jLYxMoQm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R26FPh3h
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC90vVZ2514210
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZEMqREsfmPbH/k7JgWoRxNTtP7MVL9uGc2qOxQ8K0XM=; b=jLYxMoQmys93uE7j
	CuWvYbYPmrj1sUfJWh0gLR2ORgt4gpxUk5c2z5SxMWrfjZpHBYvqE2HA5VtTiqP0
	mgYQ37Xgum14mCK2xt/o3GtqLbxHRajXPrsMLXf4n0V/jj6Q/rwlaYcgsvYbOdph
	yObZEvvyhxFU1Q584JHKgmQtXflw75gAe3PKjP8ouo/TOcJOXwRMUiS03cU7ympL
	vdbf6ZHotCbqONNVn4oM3XYS2pNTrKdutcgBsNa47JkvgxN/qgD9uRG53SsFkJFF
	uIj02i+OFMCK9Z0TDa4J3hKi9eGNe6+vYuBhOvcRhathKOQKM6qHiGw0msgn5OY5
	g/lTYw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvwm1txv2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:34:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b0a528ca65so3832142a91.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794476045; x=1795080845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZEMqREsfmPbH/k7JgWoRxNTtP7MVL9uGc2qOxQ8K0XM=;
        b=R26FPh3hTODMjYe5LsIcwKRaYEOBRhFtXo4LLszzfjd4FyuMnVcoXYLnE2Hy4gXtdG
         0B7g5eSGb1YIE9Tojms3sGyIDUYK1Er2VsFWq5E2VOCHJsNQA4cjJdSMqPnqS1PkWayr
         d6SNBkFY0IVl4efDzkSYtzt3HlJrsE+8ihCsk7/12FAdyqCt7EnS1unf+V+ooWl0vhEF
         eB79NCjyjB50L+7/crLkY4PolkxLckrr2hAoc68Dplwv1WGyWv7JTnpwAXG2nYBgEbIc
         UtSgItyIgZOOI6NR4Ol7KNaJTwZe/w0IxfXEJACODxZRKeKoFfumTxH7uFy04mJsKHgf
         bJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794476045; x=1795080845;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZEMqREsfmPbH/k7JgWoRxNTtP7MVL9uGc2qOxQ8K0XM=;
        b=cOwPzqPEdBM4/Th1BzU2eitjMzNuyc8pBIUkoXyC6LHRMYhE2pwidCCExeCBTIT0Um
         n2LM5XZPXqkIPdBelWc3UZ7VHE/rNysHDrdEiBTb4GLQtmu6cagI8vdmWirBeaj4eP+r
         FjnBjWcqAdYcH8cotDdMr3mQ0ZvQiQo/LrK+Uy14IzV0MCKS4/1M0fb9RxhI4cchBwtL
         4MQmAkfPSFSkuQ+IDqyJ3Hl9RUUh0Xev0PxQ7Eb0lQSCePP+ELqOjuBtDuaVIzybhdx2
         p0QOPWm80wBO7kR0q+BE8jgG9lQPuzqZVTvKnmgRY2WHU5xSIIXBmgMyz+ulcWp0f/ED
         5sYQ==
X-Forwarded-Encrypted: i=1; AL+hErG6ZqagAocd66EJ/rWUkE+Hboy1C9GIk25hQDnCGLgjobCuKGoVA+e59mhXAZ4GoWf0w4BgsNE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SLHZ46KPa5xkaYMS/AmVzfwCA5Kf/BGbTzv/SssMZq5ecef4N
	aJ71i8zqGxVwzeQevqybnZS+5I/uOvr+duGpXYk98yS+vHMHV581SWaWCe/UXWKp+3XIZmAFiWS
	VvGfVFBcJM3BuXDWKezDMhbjXntyNbPLX1g89Gmq4Hm0bUk1GuJzOwmHCyCA=
X-Gm-Gg: AYBFou1bfsV5iaz9LKvSjcGl8a2PoaRKNe50eLjRbzcP0jDXxcVygqRrY6htGhrcV07
	H3pY+DFGwn+KZjFn+6V/e4Dub4FRwpn7tU4kGKiDaMcVTFKJOFoYnJLzuFol0FHI+At7+zlthHI
	wxHVuzqA5y17mQ8dQQVLzCibW3Ww2GSMAGJEEEM0h/ac0YelYhqZggHwHTVpwMMxTRGz3yaTdJv
	AibwsI7nhb20ZRZlxFlCx1+YDj+13fHW5wi18BlKmbHmYebOWbsH2TdoZpfKMc5AfWnbClQnHQK
	SKuNrQ8EaHJUn0YsrrBwQcxo8KoXj9/c4VB97Uq3cv2OwhtpzEQcKbO9BtrJGcG6Ri5FxBqU4+r
	8OlXUwDFTVhvNiZWRLgqMKCZ858WAEi5cNjmsVhjmJ+UcLoXKybq3lF3gLGgTYiRaBF8cvYvZnw
	C1sg==
X-Received: by 2002:a17:90b:2f4e:b0:3ac:9176:e82b with SMTP id 98e67ed59e1d1-3b182f42c74mr4784652a91.54.1794476045147;
        Thu, 12 Nov 2026 01:34:05 -0800 (PST)
X-Received: by 2002:a17:90b:2f4e:b0:3ac:9176:e82b with SMTP id 98e67ed59e1d1-3b182f42c74mr4784628a91.54.1794476044726;
        Thu, 12 Nov 2026 01:34:04 -0800 (PST)
Received: from [10.217.216.70] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c9d7c1sm3881186a91.17.2026.11.12.01.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 01:34:04 -0800 (PST)
Message-ID: <d2315dad-ecf5-4838-bbc5-663fc2d3c75b@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 15:03:57 +0530
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] arm64: dts: qcom: nord: Add support for TSCSS
 node
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20261108-tscss-v2-0-d5f575010427@oss.qualcomm.com>
 <20261108-tscss-v2-10-d5f575010427@oss.qualcomm.com>
 <avGHpvYV2Q6T3vwd@QCOM-aGQu4IUr3Y>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <avGHpvYV2Q6T3vwd@QCOM-aGQu4IUr3Y>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KsnYSmWN c=1 sm=1 tr=0 ts=6af5880e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=_qMGny95FC9WgreSDIcA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: IPX1UuzGoSzXB3AgeYeeVc7A10xV7RgH
X-Proofpoint-ORIG-GUID: IPX1UuzGoSzXB3AgeYeeVc7A10xV7RgH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzNyBTYWx0ZWRfX+mramsQzouLM
 CDjQMbXdH5LV+FsameV5m9GHqzgYdzE5xp5yQ7KXzH3VjblAE6BDfbTrkBThFCY7YZ8EpXAxC5F
 CFfUGntQamswz3+27DG71LAmArVzJeHOKB8arPQoXGQS3vM/yeaNT1WiLaAMEIiWaUN2W20GHLU
 k/9OjIQsvdqk4pCVIC3uysxXAUwIWT7IWLoxSLGzS8QU0qhj3vePioBl/gRqu7aRisBpVORcbc0
 DGmAam4ksw3nxiKUrwm3Ugbis0vPFu9dTKh4r+Puul3AR111i/4Jf9q9hUletP/TzK3KUyxbJuy
 y8rIUAgDmPphQCJ94q4tfRH2gUN87qFAIDtlTZWBBEzZiXJTyE9ZSyXWuLLIL0bUOeSPxQN2PZh
 EIaQ+qnNsWHQel1eTssiQlXJUhCtuV61QP9Das8qZNo2PvJVHHRYtB5sg3dIF5ReXyBQsa2ueUG
 comKsxuAbz+nO6tL3rA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzNyBTYWx0ZWRfX6uUEKc8ouny8
 ySIu2eBlUvdcYyAznFxo0Wr+0BQYHABvjvvH8CxVqKqOG88s4t7XxhYg8ZJwtcagVDTucQdCZNS
 zsYqdvYThoXbDcboi1dm/5XYhMCXCJ8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120037



On 09-11-2026 02:13 pm, Shawn Guo wrote:
> On Sun, Nov 08, 2026 at 06:48:31PM +0530, Imran Shaik wrote:
>> Add Timestamp Counter Subsystem (TSCSS) node support on Qualcomm Nord
>> SoCs.
>>
>> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/nord-embedded.dtsi | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
>> index 1ab7d9bc3cfe..1d5f27336f73 100644
>> --- a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
>> @@ -736,6 +736,20 @@ pcie_data_inbound: interconnect@1c00000 {
>>   		qcom,bcm-voters = <&apps_bcm_voter>;
>>   	};
>>   
>> +	ptp@1c80000 {
>> +		compatible = "qcom,nord-tscss";
>> +		reg = <0x0 0x01c80000 0x0 0x2000>;
>> +		reg-names = "tsc";
> 
> The node should probably go to nord.dtsi with nord-embedded.dtsi
> supplementing Embedded specific resources like clocks.
> 

Sure, I will check and move this node to nord.dtsi in next series.

Thanks,
Imran
