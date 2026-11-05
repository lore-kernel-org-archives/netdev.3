Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873786;
	b=r3ERLjeAsXcdSXDNxX4acXLcdlifKyipZki5l85o5iih79u/PsGBq9eGzmcliXdBMImi
	 jvtMyeccaEgyh7ufJqJxpssZfBw9hAb4IZhbDQawuDfHzVoQRUXEhrMkHd1YKOxcXSYH4
	 5uwWLOXS0lU502TG1XoeHDnTAuCfXU59IsZSc/rbkjN1jxd+r4w/P/9J/CIpAjajsxPmB
	 sE5uBTUx18L4LcHNGpUvQeP6rtndcvsRdZ4QW158kewIK8yASxfgotFNQSn24aXuJpqqk
	 eMe6ixEpkRSP6ZQ4zePCDarpSA+1B1ByFkkkpJw7TmSawm/JM2wDdpzycFqN6scqh5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873786;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sNLRvc7OS9U73u6m0l5Vfg634kpS6gu15CVwplIGc98=;
	b=dZ4klg4uyBvFglcUxrJjb1544DMTo30wIU/fq3AV+fkrA0y8+yqHuDrza5OUe5C9pAKx
	 DhusGMxHkg+lQS8t0ka4WWCIPeuPOoKmzJdqEESklmhmJ/RQQBE2LLECiczk/VD+iaUlO
	 MqEMszwHraw4DTp2b/jIvAvqMtyA/3QPC9cGMGONoMo6948ny2w8cH3KQ0V6Fejw26Nq6
	 wF6VtjCDbtrpbVilp1ZPBYx1TC+H/H2EAMlrCBLDkteS9VOk+wJTrkYEvDCvZOioU7CTD
	 k/tXIqcO7LEifdiNgCsNIcWy9Z6hPwF/vXJ+h1he1TihIEUiybmhxQUgg6jqL2rGROQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Dm/rrgvG";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SsO7qFz2;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8557606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8557606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dm/rrgvG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SsO7qFz2
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tDEL3684470
	for <netdev@vger.kernel.org>; Thu, 5 Nov 2026 10:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sNLRvc7OS9U73u6m0l5Vfg634kpS6gu15CVwplIGc98=; b=Dm/rrgvGMH4DSLSF
	Nlir3zx3307J6xCw3fCd9n1NIa/n+sLVK18mfBvjQQ12WDY1TY8woRYsmKtFANu8
	7MRIZ4Tz65xAnOlFyf+eArVvFLG5fkuTUe4jRioo5pT653Gka47VkWXjzJ+cr9n/
	6cX/wN991s4mWBns3uQmTzajy4nkPOHEFbngA49gNM7HiLmf6kmbm4tlvWVRFeq5
	isxxeI+cppMuKbblwHKSfp+/d6XVRIXD5BPs1UL0Uy8KOVadfVvpqJEggA+H1XFV
	2IFhLuH8yFyPdQ4boXhOd0hJxgIQtb5AxMxhmhOFXJ7C7gwKkP3RfNZ2KAPdj9SP
	4H+jkQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43hh1u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 10:16:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-359b81ad4e8so2169169eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793873780; x=1794478580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sNLRvc7OS9U73u6m0l5Vfg634kpS6gu15CVwplIGc98=;
        b=SsO7qFz2tz9dgth4FHcGwJ4CNlsPXqS4tYpy6Tuv2eqnxGQNNF6OBsr998YZgzh6LJ
         lYSasC8Xvz4N7AVjogVkLqCDgx9wJzFX1qKdK6V7yIiTgCBF08moxUNRz75zlDoujFoj
         eeI4ImQBgFG3TAK0++UYg9IvBh6rEH9zWqtv2e+e0d0acv1ZZ8znk+WV2yBTB6xkehiR
         PLwkAcFWdPGdqxN9op7BWnSg0OVB0UcL8/GoNuQDv12aROtobiRkx/5eivnZEeouWmFS
         6r/3b6kluqHripQcao1Ww0+5LSyYxFScEHYiiICSWSfrWYS/h6iD7XgcQDhDJHIOQhyr
         7v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873780; x=1794478580;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sNLRvc7OS9U73u6m0l5Vfg634kpS6gu15CVwplIGc98=;
        b=Td5OeUouJAUG9DFx5ucrcQSt3DHnBS6rcnQkcITHNUSpmwDutUpkJLX8hX+u9k5JDf
         u0aoDsuVWXMqnLgiWi4alxwwoM146gGjPLEjqk4msx3HrDKVlDek5htUPimdmnjaUUh8
         juPjlCkMj/Cnu+U9MafNs/7Wu+um06+aJb2nwxgULlIg2AbTDtHxHFvEP4QE/+R6Ogae
         rhDwJ56MvUFDpl+rzQeT77MHDp7P4HZveboYbA3GSbeOjJi4PqQddzjbKoVkjchwA7OH
         w+DVubQ9Hm3LD9ZWs4MrfaJ+iKZoPf7ZDWSLkevhyPjgqWM8WhaUZsBvSov1jyolekcP
         t+2A==
X-Forwarded-Encrypted: i=1; AKwUvBxVJ6otNirk2trtkWrzzhsZRT1+jECwr6FW50Cp68KQ9W2k0htnfpBfNSZjrX/13K1RbzUOe+g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/U9gBLlE1ZjqhBX24tzw+/3fADtFhyg73vM3B5dx2L7VDRyf50
	uNgH/wxqvdbFKe3OHFsbvv/FkDXrFX31p/ND9Ok9yojPN9MaFgzqoYCiLK3H4Jxp1Sh+Jcpqx/O
	sbofNERbadg00M3l0f+Mw7gfzzT3kNFsGbxPmLZJE6CId0VxT0sfNIDHVHUg=
X-Gm-Gg: AYBFou2eF0YKC98rF4wefUfDqSXDXBlsQWbWwyvWvHikouhUhK0olvzoNysWlmEKk41
	MnSh2tXZJnaFfJ5i0jHEMNAhDhDy/+LTiTs8G8VZHmCEIMvooUgvfsB7Va5Y4FWiZuXh5X0AHNx
	z8ZLn6GKNFPfbNDxem5bogiaO9rMlUNDqF3UB0oi9M398HwZRuTJCnT7PmPPFtleKL9iZ08JyKv
	NobUX/Q4avxpQbjFFxnMKeLVUyz0rAmNCEUqWdUIFP9sTkkrCi/9vCyW/v99x3Qzuo2L0qOn4lY
	fYx7FXIXCYdkcgV4RXYNTIcBPZWdt/p3K+yY1WXfR4GkHILDAaBWmYYhVB408B6Zj0f9syjZKZX
	WX+UGVYtcGLhAMH9/LuJq70ZxTKQ/6QNB7ZrpGeuYOnG+RnyG51c6fRiNd0F3ep2c8/+8Z/fuz2
	FQ
X-Received: by 2002:a05:7301:1705:b0:36d:1e81:4a6 with SMTP id 5a478bee46e88-36d1e810863mr5355041eec.13.1793873779437;
        Thu, 05 Nov 2026 02:16:19 -0800 (PST)
X-Received: by 2002:a05:7301:1705:b0:36d:1e81:4a6 with SMTP id 5a478bee46e88-36d1e810863mr5354978eec.13.1793873778588;
        Thu, 05 Nov 2026 02:16:18 -0800 (PST)
Received: from [10.217.217.199] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38fa273sm17792403eec.16.2026.11.05.02.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:16:18 -0800 (PST)
Message-ID: <e07bf018-9a3b-4b2c-aa2d-32bb3a8db60d@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 15:46:09 +0530
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
Subject: Re: [PATCH v2 01/12] dt-bindings: clock: qcom: Add bindings for PDM
 GP_MN clock divider
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Richard Cochran
 <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org
References: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
 <20261026-b4-pdm_clk_gp_mnd_v2-v2-1-ff8e4bc8d567@oss.qualcomm.com>
 <5ekc5ibn66mc7gubh2n7htv3u64zomvfopsjnddanzayenxnpv@nczbef2enjfr>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <5ekc5ibn66mc7gubh2n7htv3u64zomvfopsjnddanzayenxnpv@nczbef2enjfr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dieS27yrmJp9r4wsWWOfhT68thNjltRw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MCBTYWx0ZWRfX7I8DTwMKjsPh
 qa6AWV2OfboscpJ52aRuBBT0FcensSSxqhCCzNjq6kxPz719qHKpiBvDzYpRN+TA4f0G76pY1/h
 LnEqfwTxczYNqj6WSFRrkHFUQAhY/73VfVvOY4T9k9aYPYttqoR7GqJM8raXsNOBdQL63J3Byyb
 aRx+iB3hO7VgMKEc1R9ujLjJ+h0qUrMUBp69uzuu6XaEMQiEboi3mtod64zEywC7h8kV9lgatfD
 T52zlW4zUvBB9cqy7CUD2rqWW5shAO+AzYp89gYWDdgQHTzHFp5Xm3tKmzX8txyl9eUT2ee3Xwe
 eUEY5vIcrZxhi734Id0r6GFpyFsp60kNrv7GpcQg8hf3RcYePyV3dvl52twOAgG81FKGPTA4V/M
 sx39qRZpK39TQsS9YNLt7LiRNdoqNKwWbUhFIkVgvoy9lPUR+81TtmLO2oR7Q9TGDLtzKKKb9Y/
 ei+jf277uNZRjf11HXw==
X-Proofpoint-GUID: dieS27yrmJp9r4wsWWOfhT68thNjltRw
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aec5774 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=D307_pyVuiG9t-qGCPMA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MCBTYWx0ZWRfX49Wh9uOlWVv/
 Kr1boxdCj1LJm/JN+tvEXJ7bVfq9lBsj0qS3E4SwsntTA3WtN2XBzpCOicAhn/w0afKI5LD+qYd
 c8FSm8pKs7Q2yhie4tW1cfc1puGLJYw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050040



On 11/2/2026 9:24 PM, Dmitry Baryshkov wrote:
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: qcom,sc7280-gp-mnd
> What was the first chip where these registers appeared? Was it present
> on SDM845?


It is available, but we didn't enable or tested the block on SDM845.

-- 
Thanks,
Taniya Das

