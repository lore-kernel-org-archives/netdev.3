Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566543;
	b=Rrh5a/d82NVWZrfoprENJF47hse1DuHTZp+wQ9x7JxjlGVJ+bSRn2/Omuge5C3XeaH0B
	 o4tZ+W5gkjD8ywuFe8AwLCPOZBYL7qoggn+PXA10SD2UJvAJa5BVYl3EqDcg01fWj3y/0
	 vMwROmJw4J+a8l6meqK3m5UR3pQuflpdyfLlQ47T3BdVODjHuQ8er75VyBW301+dowRB0
	 mhOZXtQ7nC5I6rtIe75urAFczHDdjOV57DQbuZEnJ+2A//UPDWPLEGVBrrQGrwV+0niug
	 ROzK25G59Npp0kG6kbYrUoAzOoBtPz7FnLc1KWFGB2VKjUq1u2I4mxan3VBO+0UAsDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566543;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=AZrSqa6J9X2gCGozWEGsXBsDcpp0b5wmHfpwSMEBVxs=;
	b=Q1dnU2l0zHgU5c0NHqsMLY1VcR7mTcVA+035cZPZngJ9NT8M5OrFwGNQpRmCTqu9uVIf
	 1P4hMTaY1v102INTwNG3g+nZFL3dcprcG9rxra+/luh0VXnt0yl7G/dqOYB1dAWfXDjgx
	 Gsaw1sNIUd5u5WWGwn9POCl4OGG3Kb7SNqNTBUX6J/G7Cpu4RZFeiL8zevNPuec2z0845
	 ooHu40ShMXLQLvFzZKPXfx9YVhPFiCCewsh2tg9vqK7rkqikv45ShuQMCSzflW49ETPD/
	 GolXgslrQdebI3nQ+FQYGDYZBem+8s+iE6VVj+bouj1qpY+JaEst7jSxyUQ+SLL0hiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Lyx/avOW";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=atqgKOv9;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0AF606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB0AF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lyx/avOW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=atqgKOv9
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8V82f619207
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AZrSqa6J9X2gCGozWEGsXBsDcpp0b5wmHfpwSMEBVxs=; b=Lyx/avOWN/Gzjezo
	1q2AESFfytV5VIPa/TFcWve/Mxfl/V+aCOt9f8aw3eNMHwK0VaiLSqaOxgmdBKTx
	AVDWT3kGjbqmV/Js6jh38h8s0VKLEBlnvSQTetiltKShQnuuzdn3tTmZ0Q10qy7c
	4a8RhL0pqt1jbknUii0S+rcLSTFW+SYa4urN+MPCDD02uqWnkP58g4QfcRz8G0cu
	5UzleEEAuvGCadrAoXU1Ya5Q8vbv+yFJNwfEUNKHvgwpIJwK7cNP2SNSju+wL3Ha
	i1waVTAMPVu8sSjEe2InKqDe1VC00uYQvQTfA26sKweQFrPZHUexdAcb2LEDsx7b
	K4DDAA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs04ms1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:42:21 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-370230d93efso3814116eec.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794566540; x=1795171340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AZrSqa6J9X2gCGozWEGsXBsDcpp0b5wmHfpwSMEBVxs=;
        b=atqgKOv9tz8jDQ3rKHbgm/q8bDwkIK0SZYrA1kLe/dsjwxxziwfV9m8SwVkvnM2X8m
         2HqKRoDE8FHY4oZvL/1230OqS/9L1m+XCpc6bIE1z040ORjXHmVqf8cyo4/0iEBsMCrL
         G4RSTLo+D/mi3POVCfFWaepd927dg4pKr2RCL3WTrPR4U0xmDxcErBKz8+D0XbDa9Vah
         Kq751Q6JZ2Lur9iprrMXZPZ3JITjXg/PtHUf8i4h/l9auW5IA59lVcCpkGTggCfQk87Z
         2pKSm2aEO28GJbSviRxwMchy+O8/Z9974gu8hFgQNBtwMX0AIcEF3zIcXMknzGkK5Lg5
         0BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794566540; x=1795171340;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZrSqa6J9X2gCGozWEGsXBsDcpp0b5wmHfpwSMEBVxs=;
        b=xdxS53c2guDVVMFxY9ZCU+dZ95MeqYp/VQuijU1E0JeDYYcuOHG5AdvB7xn1LTFa5v
         QvyDzIfWeixnE2xUpJWZA5HzcPihtfHqwJyf2HYXRew0gcaubUAmi/bbf3IaZmTScYc9
         Gq2uIC/GK4s9+0n18b++E5/w95nvcuh5sLX4b5/pB5RMfICLJ4mRrTVuhczDffD6q8jK
         mUfzykUNDQepeSyMDIlrA9Fi5J1HqDY+z9j1/lz7IWo7UI1KY+qK/itxOhSKa0R/y/fG
         fQYpneVDjYQCdJCEYXyTCmnWeDjAclKzk2i3sBhJ7fTX8/lJegDmlRbLesGnUoz3Ejdz
         b3zQ==
X-Forwarded-Encrypted: i=1; AL+hErHcpV9nOvgNfrsJvLoSkuAICe5Est/n/OboPonFpQ0vDcBYPVG0C+isTpZ4Ut0mTxfFWhWRwRY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/x3VRiUZVs/zFLATQ/4bNdVhgNOdBMKDsh0EESLNE4XKUY8iEa
	nX5Ga5/hMXhbUDYPxp+FsU1F2wktgi2xfJ7HbvH15buQ1GnGbiK50EMmFcmMRMuqsqfyk6WLqUL
	CPZdpVBIYTcokQx6i0rPbhrjD7FcfJHcEHWJEqdy+n2EjkY6FhG/uk+XZhvg=
X-Gm-Gg: AYBFou0FQHZKH3ShqrBhfahbLWA3bcoJlZrKtr0GKsnAjJx3i9bDMTzluvyNKwC4JaV
	K9OLhBDooZ4GUm/nJdzxf0eIasn3p/AOF6VhP4KyMhzR2NKp5RE1RZuGFjUzWVXEY4PpMtYecjo
	lfVXIHYCb2XNQF3807R+FPC/Gh/T2DREcS1KhyH6dKA4TPahQJkQNsGFnbvm+aRM+pZnboMEJAP
	gjBmdcMsMp4/5cvdB483viGG3Z8EZkg/NebWqt2lFDUn+RcLgjEGDSqeOwLn9WCzC2MjSEv9jO0
	3O64MELO5aQ2RotPbqtcBUe9Er4glS7bt35Hocr+B1/1j335wI0BN8Cp3B4c1bZRKnie/B3lXKQ
	AWSO6sarp/i6PLxdhG/6Z5+H9x58eFoHKjtgyBR7pMNjB0737LLytxTb2JwTpwcsmu2ViaBvgGO
	83eA==
X-Received: by 2002:a05:7300:c594:b0:36f:a72d:29f with SMTP id 5a478bee46e88-37967ae6bf2mr2219888eec.34.1794566540452;
        Fri, 13 Nov 2026 02:42:20 -0800 (PST)
X-Received: by 2002:a05:7300:c594:b0:36f:a72d:29f with SMTP id 5a478bee46e88-37967ae6bf2mr2219869eec.34.1794566540007;
        Fri, 13 Nov 2026 02:42:20 -0800 (PST)
Received: from [10.217.216.70] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3797f98b9b2sm6363256eec.6.2026.11.13.02.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 02:42:19 -0800 (PST)
Message-ID: <ff2e0234-3e9a-4ac0-9fe2-277735c8b1c2@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:12:07 +0530
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
Subject: Re: [PATCH v2 01/10] dt-bindings: ptp: Document the TSCSS on Qualcomm
 SA8775P and QCS8300 SoCs
To: Krzysztof Kozlowski <krzk@kernel.org>
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
 <20261108-tscss-v2-1-d5f575010427@oss.qualcomm.com>
 <20261109-qualified-pristine-newt-ba1c0c@quoll>
 <f2b119c7-ba01-46fd-96c4-10b918f98d53@oss.qualcomm.com>
 <2cd4da54-1dd2-424d-a9ba-e3e4fdad502e@kernel.org>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <2cd4da54-1dd2-424d-a9ba-e3e4fdad502e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0MiBTYWx0ZWRfX7VlEU1ll3CI3
 Krd8ZaXfI6KKxBkP6TyCzmpX7Phj3ulap7738qUupr1Lcpla87oKUdiSBIMZa3KnTo4OfmJx+J1
 QMddStc4OGR3dppQD37bqMeRyZX8g39ENdsX04EOXagPV3Z2fLyJI8ukSrsmXOzqDh/5bjBJQlb
 nqLSC5v869Jk4EUst3xBuB13EnukXKOqN86Jr/qfAdvoKmZRakLdVNseRk7Y45ZnqvsslYb7eW+
 1M6s+glb5Xl4nveUWDcbP4rH6WuAp0ds0mlgpEeF7jEnMPHob6n+Wx/wEdxa4/1t9Rqk09MRjFk
 TeipHumiRMBb19c0bcMzIjAeuxv8DCCXOtjGcQhhAzYn3xTJrIbEgJgy0OyewRW5mNkZu+2uATu
 wvhGSDsTTDkEt1KSNUN2emgzPesSQVInvFFPNpunqHoSRBNnP1/wqH5e2AlneHfe/3tRRujkLi/
 YT6JhAy/pAJqJZytJrQ==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af6e98d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=A8zP-s-B-IGqv6UKJQEA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0MiBTYWx0ZWRfX8TOHUvHR4naw
 D+BQ9gIhLaDeWjRICCcVIaHlT/vT5+RhCPIvxLvHx0do/67tA8oiA7AfPkPdIBPB5TrBpu0pLsK
 m7hLOmMWFu4dREQmMdEsCUQGk8U9tOo=
X-Proofpoint-GUID: ici67tZvtb7hQut-2yJ1up_tEM3u2rFz
X-Proofpoint-ORIG-GUID: ici67tZvtb7hQut-2yJ1up_tEM3u2rFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130042



On 13-11-2026 12:33 pm, Krzysztof Kozlowski wrote:
> On 12/11/2026 10:31, Imran Shaik wrote:
>>>> +allOf:
>>>> +  - if:
>>>> +      properties:
>>>> +        reg-names:
>>>> +          contains:
>>>> +            const: etu
>>>
>>> Reason for same devices with different address space details should be
>>> provided somewhere, preferrably in description. Assuming in the first
>>> place, that this stays because how two devices can be basically
>>> identical (same compatible) if they have different programming
>>> interface?
>>>
>>
>> TSCSS is a single hardware device, split into two sub-blocks - TSC and
>> ETU, each with its own register address. Every SoC with this compatible
>> has both blocks in hardware.
> 
> This is not what the binding said.
> 
>>
>> What changes is whether the vendor/board actually wires up the ETU's
>> external event. The ETU block captures a timestamp from the TSC block
>> when an external event fires one of the ETU slices, which are driven
>> through board-level GPIO/IRQs. If a board doesn't wire any slice,
>> there's nothing in the ETU region for Linux to use.
> 
> This is not what the binding said. The binding said there are different
> types of devices, one with etu and one without. Look, easy to spot:
> 
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> 

Sure, I will drop this reg handling, and add all the register spaces
support by default in next series.

Thanks,
Imran
