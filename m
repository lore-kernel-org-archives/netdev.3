Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261739;
	b=xUVZme3HobefA6qZru4KAacSxZePbKr3RPbsVL8gyMIR3OFv8VY6l8Y3FVv1b3CuYkNR
	 I1mDC+n1DQGxBYak/OcpYnQPry2dm+hALiLplcz94DstahZ4eGA89Cmi8J9X8uIAUeihA
	 Z7StugEikEdzvvZ9EmAwwDwDGh3LOnsQcQh21kfBSgLJsNb4UdvsQBRNFxuieHtcx5Abe
	 HJrLU8qINanIQj0c0JuY2qJaMlaUEQ+xrQJV+Z6B/NT1yNOppc1T6+IiRam0aJFTcOs6G
	 ou2t4BZnHEx+69UigW/bB3vPfceNF1vROvIFbTUNSldhhwzh8IP4a6SMIZw7DS6o0iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261739;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Tl52HgfBhP7MGadRKuB2FsjKDzug2OUyie7+y3f4AwE=;
	b=amgnVluSFR0qSslRzP+PssdwVxVvZjidRTwlndIY4mnEVLN+N4TA/voWn4vA9A2ZQAgr
	 bUjX/+K6cL6qXL5a2yu1ykNMXqisoPIWpV2iEEP2pPfQqOL845XCYl99UnFC86bixkKFb
	 F4c6+JPiYB7CQli11SGmJJt08wO+N0oubWak35BBNsmqqI92yFyte1xRijwulDrqw6WV6
	 6QGMTfDge+40CNr+k1ID2NZ8+vqTAKyO3vL71AqkvA9Un9zljx919Dj1oHIZNCXOLoqva
	 1FIRO+/dL1mHhHSbNOZ6tIDdDaAdfIrbQpHoeEsQYk0ybcLRQjk8lRvS7D/l/K7SUpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ni51Ydx+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PkyhNcYy;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED8606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFED8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ni51Ydx+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PkyhNcYy
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T5HA6c3889641
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tl52HgfBhP7MGadRKuB2FsjKDzug2OUyie7+y3f4AwE=; b=Ni51Ydx+CDpqf+Rz
	ur3Ui4ghmpDtxdRogFb9VeGwX3g6B4OUCvBJRzwpPq3ayxksQoofX/d+Q7HP/dn3
	epQDJZZYEpAKPJ9p/NdBZLbtt+6T77Rx843WiSnV6JVau5SePRAqiGy9kMtTAihl
	8Dis2v39BxC/Qxo5flms6gNprWw9RdP4Ab3Ig8BXCvSgMyVAd43sZ/YK1b3oJz3p
	kzTrsAM4rOQAV/FzJe/5EO9hAkj1UkqxXqO0VMuamegIMZH6J7C96Ru71QUlZc+j
	o7RElPMcE9Pvd/l0+xPaArwyJNevPUaoannm2KAQZBSyx+eYvowlrHe6KDDoJN6+
	aEqbqg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpmc2jpt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:15:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-943fffbc5dbso39587585a.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 01:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793261737; x=1793866537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tl52HgfBhP7MGadRKuB2FsjKDzug2OUyie7+y3f4AwE=;
        b=PkyhNcYy/3eZwUiKKPY4DINNI+7O8PhgWzTx2eO+RPRgOE4iYcoXjZj+eZ8uW5d+zO
         yrDShLjGlnccCN7iJRuXTE6x4d6wqiPm9RW/pWs+7mzKq92tBUO1CsHI7aTZEoxs7stp
         DAlrXW+8Tvf5Yk1EuVFDJIPQQdEIB+TzJ7MmUHohnattdqOuLjaczGEhwrBQ2ZL6Bch3
         m2svPhgQv79xUkLytJHaeh7wMQipk//QREZKUSQZaFn0n/WvPFQV+OqxP8/0dgoevHHe
         Rrjw4LTTFNTko/IZLSDuj4TZNL8DzBzOXpLxwlmrtlU4FG1XaWiIsYBTIapqZ2W2KQA7
         iykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793261737; x=1793866537;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tl52HgfBhP7MGadRKuB2FsjKDzug2OUyie7+y3f4AwE=;
        b=otBfR6lLay1kgj2ieDvQx+/8VSFNImhCtnyJy50BMwELB21zpIuaD/80be0XWJDphM
         N89NUqPcidpb0lBRo5faxwVGRwSqNNShnrpkAKpXm7kr4A7tE7maEKZeHAGBqa8LvrLq
         JoSpnIqdb7JWBrxKFSkmuBKv5kCHdgR/ZrOOhnLTcsQtRE2nP0mirN3jGqzCEnR7eTNL
         JLgotvNG2LCtpB7zN/P9PY1O5R/mWgiXIsS7LBjoWRbFK6YJydmJQwyezdrffnLFc2FS
         ldKJcBmzxQLufCTGYuiBnhDUhzWLnav8O24ThQlsIGGZ7zGYP7bFa2/hnb6ZjDl276TQ
         XBPw==
X-Forwarded-Encrypted: i=1; AKwUvBwa+wlT56Z8jN9XzNWkCXO3LEtSaBFMLkzrPr0Idg6kC33aQad20YNIxjSWRuZU7hox2M+TatU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpHhnEy3XiiM39YduOGNMDD3U27Qppy2jKNoRtuea2DzCoNerA
	827eCHccuJkPBu1z+wRmWw/5VLGm8O6O481nXSaqmCij5TsP6U12Ez9XnAmE7TdCrWUfHEAwwPi
	4K6uMlVobJZCjjrtnGyZ8iwVnoZeEQitOYHDTs4r1+iR4efnEFWLsX2oINb0=
X-Gm-Gg: AYBFou0Z9vJzOo7wh9+cfPgnB7ER6lyF2mSXqXTbIBuM0GzicSbS4kOL9ekYbjLEUwy
	7Jr4v+H0tlUTGDZ4alFdaB2DVdW0OFjnTMfV/f5H48nQn6fMcD0HMwrpASC3cCdXAFaIn/0q1hc
	IYFYGAhUvrzPXZr/wXIH+hxik+LiGS5vO4J7GKc6MsD6RZYBGvA4693EodNz0uOYh7YwofEdrD3
	icGwiArTCGEPd2K3/CXr/BHM9f4/KMvvoU8Jeq+bYvvMjA/Uu1Ve6wMBuo4jOTzE4Tdq/HO+62k
	WrcNmq+KcO+eniss1zxDjUvWU0PX9GPq3Uj0ci3PMGvAvL9fFljcLOLGTfNxfuaD15XF/BuwfUf
	wrLzGnkf8Jm7yh2vpAKZD8OK0jZU8IkiZnWfuhn9JKlZ1/OGJ7wRkmQnU6PcWYSzNUwPjsd0=
X-Received: by 2002:a05:620a:a8c7:20b0:93e:54fc:2c79 with SMTP id af79cd13be357-94408cff7dfmr690394785a.5.1793261737056;
        Thu, 29 Oct 2026 01:15:37 -0700 (PDT)
X-Received: by 2002:a05:620a:a8c7:20b0:93e:54fc:2c79 with SMTP id af79cd13be357-94408cff7dfmr690391385a.5.1793261736641;
        Thu, 29 Oct 2026 01:15:36 -0700 (PDT)
Received: from [192.168.226.64] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b495ac4a78sm2434202a12.4.2026.10.29.01.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 01:15:35 -0700 (PDT)
Message-ID: <e67f8b50-f3b0-4a19-bbe3-d1f240ba9b2f@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:15:33 +0100
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
Subject: Re: [PATCH v2 08/12] pinctrl: qcom: qcs615: Add gp_mn mux function
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Richard Cochran
 <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org
References: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
 <20261026-b4-pdm_clk_gp_mnd_v2-v2-8-ff8e4bc8d567@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261026-b4-pdm_clk_gp_mnd_v2-v2-8-ff8e4bc8d567@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4nHu2Te c=1 sm=1 tr=0 ts=6ae300a9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=UmW6FQozgp94pkqAIjUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 88pWiKThzdhXyImFY4lBwKm6UG-Eh4d9
X-Proofpoint-ORIG-GUID: 88pWiKThzdhXyImFY4lBwKm6UG-Eh4d9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzMSBTYWx0ZWRfX4/C/lpeP9YDD
 yQKtwDzuUZ1LYMlfGwYg07qZNaYXGQy5hHyhqM7X2E3sBz9+8AfnUCBl5/ceuuwt5efO9vBpVlq
 e7AVp5cSvpOyI70J5+/wrrqnQ62VMhTUA6fTA5FoHjINut5ZtyQIAeh+o1x5RyQjvlX4g+HSCjk
 XSQ59c7CqrdRSIj3RWa5MGglANT1qIBGaRsabyH/7QRPmqNRQnMFYAImp3vHXrKqD6Ima16U30b
 FABXaDAJS0hXj8f5tIM0Iy6Twb5DAJhdxRGEBtD0ODf83skRo8bbllWqZqAwM0PMN2ZQAZPyYzu
 oTy+JmLa6GrzzipSjQ9XPWcR0XNepERt7w3P/E6sqfNbCccoBVg6W2ikSxH7hz8ZPw27KUhlLxe
 e1TB0+zgbFEhVqckwjeP3ut8pJOM9X+K1OR2el49574WXxadrvHxda9exbHJmHyWHtHlAJ5GuHt
 jyaHmih4Ocvg180BvHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzMSBTYWx0ZWRfX0bd1Az6BUR2T
 8e+gokxtF4Scm8Co82dzDJfhe3oC3ntLqpgV+i5wfja+0VxF8HGg1oYpw+K4z9BVRD/43WWPcoz
 MmAcR7DnJLV6Zk8NZ8x/QYBAtfslvbs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290031

On 10/26/26 12:29 PM, Taniya Das wrote:
> Add the gp_mn pin mux function on gpio29 of QCS615. This exposes the
> GP M/N divider clock output on the dedicated GPIO pin.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
