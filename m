Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214265;
	b=FOoOUZp7LJfF5XOiqfmuQj8MxudUwf8FkJ0YXT9UmQZ7zcwfmhGcafaTHudU8li8P9OG
	 Z/3uGrtP9vr/fz0+F01kP2EqKCCK5HtWCXdzylEt06DouaTFi9dudWqnncfP0YavAPIJx
	 yhToLFhYtrDYd+1A5UrO/Om7fxBBnYTionUejbtYm72GuE6+4VAoHuSN6zEhiq3GQazdy
	 2gEPES6HlJs03AfFRuH7e6I9gZXTVd8add/cnjdwBFC97+XZYeuDi7aH6sOBF+KYRwDTe
	 5l5ep+T+znAay+HddwO0drUmVpSFbuIYQ1Hoy5LaRJv4z7wqDAHKMCERDFCdWMT+wRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214265;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/3oARxDEXLg7TaIeiQ6V/+h8xlKkrQx7Ze0qvtDuS0o=;
	b=YvX6uHKg9Zjl9KuzyNXIJ6eDTNgxMxzutEVgL3FBr/ZjtERDhKTKnGupvcbXazzOs/C8
	 cUQzSEfh0o5qbrSxuPVRyYtWL5xbZQswrE99GWw4+jJOuMWVU6yEiRZ7KcQssZdIxRsX7
	 /tBJgxRvjabQgqrzKQuNxOtjQ45MEaVxDNYoeEana0VwJu4dR2YChyZSAe0mwVaYULx3v
	 lknglI1MD3k9sF5yRAqbbukJaBIk03UU0lLa5tTDZXbHXSyY+ArxBKJaeceaue7H0Nauu
	 6XMjlDoFIAuYIAQHzted+OdpHfTj1urfsOjUSTBapMDReiq53J8Y7SOemgtSgA816wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cjrSw68y;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UP7EsUHX;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB2E606EE9C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 08:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CB2E606EE9C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cjrSw68y;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UP7EsUHX
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A969qPO480811
	for <netdev@vger.kernel.org>; Mon, 9 Nov 2026 08:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/3oARxDEXLg7TaIeiQ6V/+h8xlKkrQx7Ze0qvtDuS0o=; b=cjrSw68yVIWyLr/e
	xwi4uJeVc9sKtHO2Xr1mYmIH7z5SlQE7UxfRuNJs9f9tvHYNZ1YItIbo/mB/V3+Y
	r1Ztf36xojPxSquwT5XIpkJzpVL+7W5IguF1hckFJtVxPYWG82pSA2Nq/q4on1cK
	5wwkarHShHogSjHBittWPna3/BMZt49ns3QHBpYNixfjFm5u6u1FXt6XezwDRXsg
	ptskg9C5EwJSFo9bCpTTYXt1Jmjbvnhgf9YECn96QMFuX7JFmJ8GKdZY1NQYPW3u
	bz+lu+ZJaalA8mHfH3r6h0BknwNXeRZRIsuLr9o1CO+Ue4O9wDXOvc1IGo2W4XA3
	U9iXkg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hstxsdmm9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:51:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36fe0b57d91so784007eec.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 00:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794214264; x=1794819064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/3oARxDEXLg7TaIeiQ6V/+h8xlKkrQx7Ze0qvtDuS0o=;
        b=UP7EsUHXjxAcRBKAOoYsVd+lU1C8nKSBhoGcKyHouS6aedfgJyQ9vEAFNRDag64F+p
         WjdfHa8yd/sH2luNCUiMI6sNI1nlyHURl4nAUlXVcZYz6FsDybgoj+ur9CcmoWqOkKSm
         ykPNUSs1oedb3gttjjxNIaXpLb6QJRFzjIBccr1gXE2w63q7r3/M90mf1vbna8Sqv1ih
         GYIMJoWcoY7n9tPHc17nauv8brGEJTM/K/DkZLqr2DNyWU6++20IjoN1APRM4aGLTm4b
         R4SRy50Rx6Cq0KkA8O1IC4wOtSzhWG2qRWJmSS91L6IjcWFn7iUeaAdPQHqFo5wxypPB
         ao0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794214264; x=1794819064;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/3oARxDEXLg7TaIeiQ6V/+h8xlKkrQx7Ze0qvtDuS0o=;
        b=pVJ+ZCp0qPiYd0MVkLNpjKQl92GEcCO8HkdJY2T6O0flyg5MFuvYQy9F/4D1A0Ptqz
         VoOIU3USRNvuXuMgy8odAbSjKUNMCbpOJWESsJAmN1B+BVtaywJ3pYqun0bhUdINV1Eh
         AZx7nf7iyVeTwnkVLBRau6ftPqHAGdfy5HoqmIehXR1dPf+JF+aSJQthcoPobxlt6h9C
         8UB3pI4BDJy7llQNi0QiMjttsS/X7VJ4yOG8cGKRSK1WfHXKJNT+HVkqOKJmwQBWARip
         TMUY9WHUFV26FfgdovFPy+4K60CzbR+8ObiqXOE488trUmn4qOFUt7GDiNVnUoTHEjaa
         hLFg==
X-Forwarded-Encrypted: i=1; AL+hErEbhYYb8M87bQAEU1L+OyzhNdY4Ko5C7Tl1XyR+rReXaYGqgNCse8/TRvc6URp7ZdRHBQ+UO4k=@vger.kernel.org
X-Gm-Message-State: APuU4Z83099/fcIeIARiDivxCiG7ppXdTyvkF1XEKZe2KJerTDNSfbqi
	MGtKJSk0oe+fruZKVjjdG7qjUiAH3GquI7F85JtMh8myom+lqloLmZ/6GxF3R3nyDFz0XkK2FOs
	xEncJ0hffxqfY2T+h5Xy5W9yA9f5I9K8Hr95JwigbaPEtXbCvfESnSN2crlA=
X-Gm-Gg: AYBFou1UIkxUMb60K+hTS+SZaThWqsL65fKf9NzgTCHdvvfo0ieiwJybdU9ejWi38x1
	8mSXadwVRdGniaf+dMI9ehGN+MPNPWNICwIOdZaB5RDiF2LUsupn5M/8NrDXXd9EHTqvXujBnhb
	SJDZj+ihPcAC9Qg6NUzw1pupodX1quiS5iZIi2+7nhaYO8ir6DxXmHAm7i4JIRh2PA8MuXvTJoE
	WswZlm90n/vuP0TZ8PoVg8b8NEHPUQ/yMYP04sshJBxbeXMepmzbh/V7wVJ0pOqiXbtLUthIgoO
	KaTHm/5jVRtjjia9r0UAFLdt7V5lGTeRINwISJPiv18RpyeXM/suDUcvcpXdtjSh3Gexos51cLn
	JNW+3icEgDtZyjUeZR6bY33EcUNeHyCgrh5LpSUCNcTFOWvniSLxO43JHRedaG4xRKmT2fUCMoo
	kH
X-Received: by 2002:a05:693c:87c7:20b0:360:d4c5:7243 with SMTP id 5a478bee46e88-37256614e85mr6020765eec.11.1794214263889;
        Mon, 09 Nov 2026 00:51:03 -0800 (PST)
X-Received: by 2002:a05:693c:87c7:20b0:360:d4c5:7243 with SMTP id 5a478bee46e88-37256614e85mr6020716eec.11.1794214263258;
        Mon, 09 Nov 2026 00:51:03 -0800 (PST)
Received: from [192.168.0.195] ([124.123.199.27])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372656187f8sm10575336eec.5.2026.11.09.00.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 00:51:02 -0800 (PST)
Message-ID: <a7228569-c78c-4262-a9ba-d355101a48d0@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 14:20:50 +0530
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
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
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
 <20261027-inescapable-rough-viper-6cd56d@quoll>
 <fc2c4943-0482-4c72-b713-5a66c9995c5e@oss.qualcomm.com>
 <362884cb-71c1-4d12-b315-9923118c8564@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <362884cb-71c1-4d12-b315-9923118c8564@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Q2KhLYYeJ83n00DnYNnzE5dwIyN1Y2a4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX7i9vj3e3vx41
 e04KYPXw5kjXU1injXQ9E5Fe9yKzSK2RKsc+ENzP73JXVoP0A8+gQB0714Sh9mdUPeR90vMyLv9
 OjSKJwg7Bgd5LrSbzPYc7ztMOKmGWf0=
X-Authority-Analysis: v=2.4 cv=dZMVTnXe c=1 sm=1 tr=0 ts=6af18978 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=kgg5nJQTCQF2KXP9n8GJFg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=IYge48onPvb9mXducVgA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX5ksa7GbWu5Ez
 J0I9I7Yz9a2ewhwDJFswAeQiPORabx4/nJA599LmGO05Dklm9rQuE48Ee8o6gpMAUTpGOGXHoEf
 Hiq4J6AjR9Y8pprKI6MyGuXC7abfadUvDrIMlk3//xPv/Jlii4exz5+gq7kzGH/dIZv9+59j7dQ
 oDaOnNStrxsrWUp5vKw4oaXHk0tAJNTISJlBHmibV5L0twXytp8EQMEfL6h4rGoSsF4vB/JsW2b
 YZk52NxbNmTnfE1yHwUKMElx4KXRFzfQQhzB3mMf52GAXKA3y9nfM5VVCN6uJhhRMekR9ATFrI3
 4SAHT5nxbks4bVUDlhdgBFbOFXUTbLgXfnDNAH5kfwMjvQSBaX00UozFXShZJL8N3sENzNaJmOg
 NTRkLECWzFGJTtTIr2NkrBuv835DHgYwZkPrdUHRYeBCM4pEDP7GcbiJxQeCmyhKjnxSKEmrivf
 XccymGa1uoJCfn/JkhA==
X-Proofpoint-GUID: Q2KhLYYeJ83n00DnYNnzE5dwIyN1Y2a4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090035



On 11/2/2026 8:38 PM, Konrad Dybcio wrote:
>>>> +  assigned-clocks:
>>>> +    maxItems: 1
>>>> +    description: Parent clock phandle used to set the input frequency.
>>>> +
>>>> +  assigned-clock-rates:
>>>> +    maxItems: 1
>>>> +    description: |
>>>> +      Rate for the parent clock in Hz.
>>>> +      Supported rates: 19200000, 9600000, 6400000, 4800000.
>>> Neither assigned-clocks nor assigned-clock-rates should be needed.
>>> Parent clock is outside of scope of this binding.
>>>
>> Sure I will remove, but the parent clock input is a requirement of the
>> Hardware and the output of this module entirely depends on the above
>> ranges of frequencies mentioned and that is the reason to keep the rates
>> specifically. I will capture it in the description and hope that should
>> be fine.
> So this is essentially xo, xo/2, xo/3, xo/4. The gcc_pdm_xo4_div_clk_src
> you added is defined as a 4-wide divider - do we need to limit that
> divider's range, or would div=0b1111=xo/15 also work?


Konrad, the divider is valid till 15(i.e 1.2MHz input frequency is
valid). I will update the frequency range in the next patchset in the
description if you think that is the way we should go about.

-- 
Thanks,
Taniya Das

