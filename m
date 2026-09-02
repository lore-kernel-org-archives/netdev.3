Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F154A8FED
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364722; cv=none; b=sNh03Yl+Aeb7A+Ns8/DobfQ1+4l0HGG3wN+Sz5509F7N+0NjpvVumEVpBZQBJ0JmHEB00gURuXQKax2eNKVxzgI9oW08MGYcIqQcbG1bXe1aadufpnR0IrBd/Xc99b1Y2J3A2VeAquD0qR9T/Pjxjd+2A2Zy41tgzGWZe2oTmZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364722; c=relaxed/simple;
	bh=lwm6jSNbiO6LZzYLxybW8K+lAptA9OdyeL+wXz5Haqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cika0E8XxKvuBABHA2fF8rHtDRZzY+20xwgCFQ7kZ2VfRdy/vvejpv19iAL8Cq3gL/JALfvsd4LDAnxW1ViZs7ltBDE/WEc+ZkTpPjTZ3OzD1LAFIsefbEZVb7VHgoM3nWxjvUCNAjCmJSyKwX4HUGZflkuAQoSkdvXVM7icZso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f0o06vvW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TxqY5ztF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f0o06vvW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TxqY5ztF"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682FYvmK3071057
	for <netdev@vger.kernel.org>; Wed, 2 Sep 2026 15:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WT4vDkQPrtgRr5nF277OBdLIuA4Vcdh4zy8bVUfvfeE=; b=f0o06vvWiYYW4k0B
	x8yxMht7qboOuruBR1QI8ZqNZ89BhK2FgeLQWItmX/mvkfR3Ph6zKVc5wmzZafb7
	tejjztWgvzjFzkxrQs2UlCg2dINhF/HAsLAOP6lL6BtqUQxQ+O23Ulskx47I67KP
	x4y+Cqh/rdhd3CvwlkbvynmUFSoA7i/+4pUVs+QwXS7p2M6tYBIWBsn3dTrD1l0B
	4jNMH4ZF02A/GZg1BL14C1ztUpW0TnE2/3GfmeasSp3iG5i4hHpX5Nb7gI1Ei2s9
	Bv/sNn7fK/DSGvhtYFMZnEB2D5WADtBGSAlWsbiUolgtTaSmOaoMpy/IGSftyqKW
	rzq1iw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrnga3b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 15:58:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930bd2bfc45so36714585a.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788364719; x=1788969519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WT4vDkQPrtgRr5nF277OBdLIuA4Vcdh4zy8bVUfvfeE=;
        b=TxqY5ztFr0nbrIJvJGnjP22/xTXBpB8XkI0pbcxcw6gqHlgQ0GI41OSc7eXo+cS0gB
         tWMToahKLND4a+m8Kk6HbDJhBNLNWL0IsUOhvmiI+zMhGJeepgpYdMGj02P0jvytkAuQ
         HV/NwUXHq8j8CjF3NQeqqCeV9nFDvfTgSx7N6qHP+CoVsn4sL10rVXaSsVQa0PbwJP57
         T2eiyLx3No5zzrodj6uA+L9srRfitR4mjM8sICw9Elx2Nacnd0S52pkx4g3qehEByzcS
         DvLprJpXG5A02J/aI/TZTioCXQBi+9pTyDnlP3H/fqxr4XJSN75dwvLrmoFpen3o5TOl
         kogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364719; x=1788969519;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WT4vDkQPrtgRr5nF277OBdLIuA4Vcdh4zy8bVUfvfeE=;
        b=L1DNC2p7BrLcoklzfxUK0u0WKfHNsrtT7thBqD41uBj4MEwfMRykhRC0rOb399M0ar
         3Rvm3wPSL8vs32DTyZlQQoZ8Zq0siw280tF80/svZN3m5ZYigTYOsseKkwOEYrFxbeT6
         YjuP9JXGCM/eBpTy7CYQZrymMYpttsgaSO4ruuPQoRIrbmCyTHVBUxkSl2AzDY5qqqnj
         8BFztjzLO3NnbFPlGBU5zUi6FBqvo55GVdOIM4ZPm/weU74ZT8drnBtIzihka12ekG6T
         BISVYhdeOYiEl+jq1loEKBxW8GhoaelxWnxhacpl1eA8cgb61MsAVW20upG+V8owSWpp
         Ky0A==
X-Forwarded-Encrypted: i=1; AHgh+RrtbWaeBN5BbKmrEzi3y5PGALqkdB5GYfq5DzIkqvo+zUqnFTAEWizKaV4XkEq5JUkKJ3Dyc8c=@vger.kernel.org
X-Gm-Message-State: AFuF++mXIS3PeqsMcPcuv1DF/8yLEVKp9e04XzJ0NdRj3D+JrV/7P7/O
	y0wIZORxCEjLp0WqPhe6fZzpumbifpHGl0Balsl2uSt+z/iaAptLFzGPVLLXoSZBggyx/mS+rMX
	9HRTRplgT8nz1boLnJNR1vh2mfSjM88zTwCCHDUGTk96lvBbxQiDvM39sQR8=
X-Gm-Gg: AR+sD11QE+T6Jea7Z0DI23FFabQmMQuzBP020D2+7XbMkVbaC0ePLrW2gWxAIZqE8Oy
	RQjNREaTL4QGcF6qkhCuinHKCjCvoEdZDE3PIlgxqH6R0d7nPfOqXdPobpZM1AdWPBPLZdfTZpk
	9/6XfLG6mIBdy9/gy7RIfXqMd6hrH9n8ncJqUlWwjyKidqSCHZQOHlxiulD4KChBsMVHKZWpLSy
	KbPmkgSRn/4NGN8pTzesS7JLpK8h6rlWGzReOu+FAg1TfbcMEHLeRP4rv2tWlAScmaaC5QA4Ilz
	Zk5POloHRx/6EfzD32MRX7EVqyjYNL6UPm1KawOMcNbu5sscXOPFbcN4JNh3B5Y4C2SK7cgrDc4
	1pbI2shKeZHVFtekxmCLXag==
X-Received: by 2002:a05:620a:1790:b0:939:2884:e11 with SMTP id af79cd13be357-9396108b065mr451170785a.5.1788364719173;
        Wed, 02 Sep 2026 08:58:39 -0700 (PDT)
X-Received: by 2002:a05:620a:1790:b0:939:2884:e11 with SMTP id af79cd13be357-9396108b065mr451116785a.5.1788364713865;
        Wed, 02 Sep 2026 08:58:33 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d044d776sm159586866b.62.2026.09.02.08.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 08:58:33 -0700 (PDT)
Message-ID: <245eb766-e35b-4f73-a252-69eda60011a2@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 17:58:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: qcom: lemans: Add support for TSCSS node
To: Imran Shaik <imran.shaik@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260727-tscss-v1-0-beed14e72510@oss.qualcomm.com>
 <20260727-tscss-v1-5-beed14e72510@oss.qualcomm.com>
 <a93f11c5-d0cf-4acd-a959-53fecc996e5f@oss.qualcomm.com>
 <9d1c5451-f665-40d1-866d-51a53fba27f6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <9d1c5451-f665-40d1-866d-51a53fba27f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VVEfRnIfxJD0Tq2eBBpApfsTCM2fsSJx
X-Proofpoint-ORIG-GUID: VVEfRnIfxJD0Tq2eBBpApfsTCM2fsSJx
X-Authority-Analysis: v=2.4 cv=YKuvDxGx c=1 sm=1 tr=0 ts=6a9847b0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=hKkCCEgSrQTGbmuQoJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MSBTYWx0ZWRfX1gUPgBfJEDUg
 wULmB9NGGaRmItg6PWJdt+1fRH8tWoQRs5C4Y+6WdLA66npG+TpyIxQccSOV2XaefC0DUPKafZH
 Loxj2hBT8IChP/NgtMQhVl8inOu71uBd4vOIGzxLrYxEF7vmh0cE/OSP/CZsvFNFdT/uy2htMYg
 IGyz7NA+IpCVlGkbM7LvbkK3WP6ydQENv7hHSyO9wp5Tet3jH55q94AfH+yDYkeJO6Edap2f7iE
 6/3EU+1ap6l+Pqo8ijiepXCSIQBtNpUvRoG5KzFw2NlR57FpXF62iNkUh/KfaLCf020mubLlrqG
 AzGmKV+o7fu/YHGZiM/6hHz0iKAHW1jsWfYuc847Qdz6lTZ7bnBuIPYxWG9zcmvopzVIUjaSMxb
 KFmFKIZ4uMek25KlywBOiyoa0MfW8LY19iykuHlJhok/xZPRekbwkUFI98q7KzpUCVpzKuB4V0u
 7VOZYawzQ0pJvZRouaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MSBTYWx0ZWRfX0LiEyBzwRRPn
 wbgTaeGM92j1RhC7W/PV8ddF//Bd7EjjAr2Hc4vBWCmetar/pA5IO3I+fJpr3HQioY6OB8irm04
 vTSOQFqxRNxtP2NFMHG3elg8cKDZFL4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020141

On 9/1/26 8:41 AM, Imran Shaik wrote:
> 
> 
> On 27-07-2026 08:14 pm, Konrad Dybcio wrote:
>> On 7/27/26 4:11 PM, Imran Shaik wrote:
>>> Add Timestamp Counter Subsystem (TSCSS) node support on Qualcomm Lemans
>>> SoCs.
>>>
>>> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/lemans.dtsi | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>> index 3b0539e27b5192582e0bc9ea248f1c0382e05030..e225292a1e41a5a313aca188ca04bb12474995e8 100644
>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>> @@ -3023,6 +3023,17 @@ pcie1_phy: phy@1c14000 {
>>>               status = "disabled";
>>>           };
>>>   +        tscss@1c80000 {
>>> +            compatible = "qcom,lemans-tscss";
>>> +            reg = <0x0 0x01c80000 0x0 0x2000>;
>>> +            reg-names = "tsc";
>>> +            clocks = <&gcc GCC_TSCSS_AHB_CLK>,
>>> +                 <&gcc GCC_TSCSS_GLOBAL_CNTR_CLK>;
>>> +            clock-names = "ahb", "cntr";
>>> +            assigned-clocks = <&gcc GCC_TSCSS_GLOBAL_CNTR_CLK>;
>>> +            assigned-clock-rates = <15625000>;
>>
>> I'm guessing this will only ever require a single rate - do we
>> need power-domains pointing to one of the RPMHPDs and a
>> required-opps reference to match?
>>
> 
> The power-domains/required-opps are not really required here, as this
> clock's rate is at the lowest corner on the CX rail, which is always
> kept ON.

The clock plan calls for SVS_L1, the RPMHPD node also defines SVS,
LOW_SVS and MIN_SVS below it

Konrad
