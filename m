Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A333F20C029
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401164; cv=none; b=PshknCJ5ZZH2RjG1eRkom5QutCElp30tVpTsvBesnt6G97Tz/g2okPpBGUHrNO3YTV0MOqLJSZDbU6S/Bzt7OtrhVnyPUgElMq5jru7gALJgKKZCkplaeYisRWowooepnGW0IIwMrhXFPXFZTYHfdJzS7vUKUJ0XgNjuPl7GRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401164; c=relaxed/simple;
	bh=HIk1IpHMIoS0JC9EwLMBzSzfIUXCdtc0LgtWZRJBnoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dbfv3XjWt5REyPGl/4Cggh9hpqJ/jq41srWs39R+wcfmjMqo+X+sHKhZ3cII26QOF5B1qEt4ICLNPot3NcffFxpCJKFeXIGnmMQ+I46l3lSi7+g3BSFqHGkCF3+yDA1IDRLrzbevwo1pQJDW5UKkzA0tIPKZWEK4yJFIbeUyptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JpKZIH2f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BXpoo65f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JpKZIH2f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BXpoo65f"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0UQY607560
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 15:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wVlvxm/so69i9rBF3Qqf6pqpvc/+LeTsxiPPuQMtYXE=; b=JpKZIH2f9DAXQmXH
	2iSP1VdlpJ0jceUw4F13wvvmhwgtDHYwagzFi0IhLy8fWf1EZBTsFWgxC2NtF+td
	1WB37/06bpqcAzlBAvfooguEFqC49IGSvPVLEjjDniBT5Wk0wufQgO3pvEHhA6DR
	vzmq7nW95tq33wdbJ61049JaWHRe3zZQo9rYHgZSTB3t9nBRWzVB7ZtP/fofSiWi
	e7XA9fOcoKAvtOLodW3OMJ5HOzHr8EhHdSiHkovtecswNEkJ/z+6GaUfDWFH6tn1
	lLDJrJtF4D74EaNcKXw610/z4fDiD6TCkV8IMdJyApCyirO2+QUisvflLq/wqhrD
	t9dkSg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpg2ks1ue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 15:52:41 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c93c294214so847022e0c.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789401160; x=1790005960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wVlvxm/so69i9rBF3Qqf6pqpvc/+LeTsxiPPuQMtYXE=;
        b=BXpoo65fycPbNdNe3FLAjfX1dzcYEzO3xRoSnQIm+Cj2pa7L5NrNv2WijhIkFfGNXi
         Q2QJBOCclSlsR5J+vIbT4QGgVkOvuSF4XxlzZcZkYE/vdjAmtZgaVPRKJD6Aiqbk7E6Z
         iYedvPzxWuRLL4SONWEp5cRQDm/4ChT0lExJVcwI9cha+zrGIVnS2M/0RxZBLpWvDfPZ
         47QIIPmv9RuGxJadHfnedvaItZzCqxYb4AksZDv9FWW3edRitvSo1gQ32UlCq2zi9mWZ
         egfZ8DsVXoQ6+f70pSYD0pQH5FHuZy1oBzDzIzORVc3QLsTHTiQ0a5gpztzV/s+83oZI
         Xi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789401160; x=1790005960;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wVlvxm/so69i9rBF3Qqf6pqpvc/+LeTsxiPPuQMtYXE=;
        b=fb7xpJmR1tvgd2GiC0qOxSeYb266xKxDKI3qfR5tbmWBo25Zc08QKnM3jgBWdWoXpT
         2jOsOeQxRM3DyAB6x95rwKyl4bWgVEz/yR3OGVFYUCUhZIevJi3KEf9407MbATjw9TKp
         zjINW2Xoa9z/cvszmYn3QE/R8bYpNsx1NR1+oirwbuVtO7q1SJSe/MXmF4Ne2Qbz9pfF
         +0k2PtUUo9+dtDvfEaz3hrJBRq/BRIDraVkLzWIGdgZoMD4XWWbFSwuR7RebPXg/QMSF
         nZMcbRzh4WS4K513/14HAAz0jQ6Z6i0EdANOFddLasK/xbq9Y22zc2DZ9KjgN7mvjl7O
         Okrw==
X-Forwarded-Encrypted: i=1; AKwUvBznAt3PMzCBS81c0iT9UwRGzAuQgvSAHZ4RrPXVAo/tfTGmvSJLjy4u8U5hhVhhflej6s7Kwk8=@vger.kernel.org
X-Gm-Message-State: AFuF++kL0fno0V1ZTycbEHdgbWftOo/HY44VeareNTENSgrO7EbNxDql
	TcoLDX6ObFFhXXadeHuQ60bIpAPNGU16KYqwus3xHphQYjQaCZ77end+1ko8LZD7+Js3KOTLDZb
	7fm+FHO6GpcJKJJxmrkf/Dv1WHsq75jSnvS0A5CSg5FpUde12p7ijbmYuAPY=
X-Gm-Gg: AYBFou2iRkZLC+6vz5yzvRJg9+ZTGO3IgdmYOehlqGMw1V5F09EKsOWT1cnOhzuFu/T
	op/E9b84hxlKyvQs1O1u1UBt/PStSTzshQOQEudCf5WHW23booHX9l9Zm8BpiCsoF9cyoeEBvAq
	WNJKdWMTQOC2tOWcXBFCGc1bC1A+ZN/z43fpQcWCSoTNYG0d8Y69u2RgR8LYMaEvauem5VRS6Um
	j0TofZYWBho69IupHVBbU2XyjUcC7/Oj5AVcNh2XIDem+IjkK9U2K3LPVkd1K3Y1JlebsBq5K3/
	DXe/DEiyjkH8ZTRIZjh07rA05qUoeIq1MRovR/rMVl78JpIT6rhTiue0cUlJCMo280axVm75yGc
	cEdo2GlQ0GxV+XamZ8nKCsBiOTuik
X-Received: by 2002:a05:6122:32d0:b0:5c9:72ea:141b with SMTP id 71dfb90a1353d-5c981d701dbmr3781480e0c.6.1789401157668;
        Mon, 14 Sep 2026 08:52:37 -0700 (PDT)
X-Received: by 2002:a05:6122:32d0:b0:5c9:72ea:141b with SMTP id 71dfb90a1353d-5c981d701dbmr3780433e0c.6.1789401153186;
        Mon, 14 Sep 2026 08:52:33 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486f301121asm22926613f8f.0.2026.09.14.08.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 08:52:31 -0700 (PDT)
Message-ID: <3bda35ea-1f45-4cc1-af1e-7f1513651b60@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 17:52:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dt-bindings: net: Use consistent indentation in
 the example
To: netdev-bot+sashiko@kernel.org
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, justin.chen@broadcom.com,
        florian.fainelli@broadcom.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ulli.kroll@googlemail.com, linusw@kernel.org,
        clement.leger@bootlin.com, olteanv@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, nbd@nbd.name, lorenzo@kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        sean.wang@mediatek.com, johannes@sipsolutions.net,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        jjohnson@kernel.org, richardcochran@gmail.com, geert+renesas@glider.be,
        magnus.damm@gmail.com, yongxing.mou@oss.qualcomm.com, rfoss@kernel.org,
        abelvesa@kernel.org, vineetha.g.jaya.kumaran@intel.com,
        claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
        elder@kernel.org, s-vadapalli@ti.com, rogerq@kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org, ath10k@lists.infradead.org
References: <20260913122910.99457-3-krzysztof.kozlowski@oss.qualcomm.com>
 <178939022208.22033.14553895731937911806@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <178939022208.22033.14553895731937911806@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uFet4rH-2iiNrvNIw-sHGroh0bw6S1mt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIyNiBTYWx0ZWRfX1JNmTDJ9Fuot
 rAynf4VaBa9dFngWh1vLf5wOF0RerrmML0LcuZEaAp0hWr44UWU66s2z6UYWeNxhgcef8y5U2rA
 blpGBGu60XKUyM7ahY64rgU06Y9qhmc0TfEOUcYADSPVCvB3IMbEylhSp0YpxO7IEZESTwJ3RzR
 8HJvHsJ6EDJlpX1ugLqo9msaXLyDyh2aY5nYxhyEX2uFgsAa9qQcrjg6BjrIO6RHI5sjVIJuSTg
 GSPzWIv3CKrPaObtd65ZJqQ9zTr7Jsp2iVis28x752NpvoABciwyxQkY0KBrdmgWO8ynmRTmM8B
 luvSYKVPr3SzY5AMOYerJckr45dQUIXjJ0VO+vuHMfyaXz6/mgPk6AYqm0B8Eq/BmvzvC0pj5N7
 hKYY+c8d5DlexcUoyRmSARmUA62kI8F4LeH8fTnaPL0yB1wNcZoFGptDE16CLwaMHfuXQfuD0od
 7NCdE6zrzUew4UylOuQ==
X-Proofpoint-GUID: uFet4rH-2iiNrvNIw-sHGroh0bw6S1mt
X-Authority-Analysis: v=2.4 cv=M7TYuCws c=1 sm=1 tr=0 ts=6aa81849 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=JYzT5DUXXbXYkYiThRIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIyNiBTYWx0ZWRfX1XeFMHzvYfvo
 SQJ2S9Fe8+VRVQFWpmxiwZrCuyOuTWWsGL9OXYZPJTRMkLn9rB2PBpvZRkQJcLov/eyRz9XTgQ4
 hP7T3IFJPNs35kyfsxSFsmqI/HHS/1M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140226

On 14/09/2026 14:50, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] In Documentation/devicetree/bindings/net/cortina,gemini-
>   ethernet.yaml the patch does more than re-indent: it deletes the whole…

Overly long, it's like use the most words to explain something to waste
other people time... I really dislike this approach but did complain and
people disagreed.

Best regards,
Krzysztof
