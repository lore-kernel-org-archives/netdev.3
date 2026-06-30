Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45F919C553
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857301; cv=none; b=ZJNzhenR4+qjIPE85iTmjOP93DbugWyN26Q7Ua2QL5tlJJFj8ERxXV4Ok8yY9mAoEDc4kmvglokMVYgaqA6Zyky5iO4V7UXo0d6V0AuSIwzXkRZertyx2KZaDuHHgVGxyvjAVQFK0J2iHdSaXQFtI7QcLDYSqMUHzi9zK9Ez208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857301; c=relaxed/simple;
	bh=XWXB5lkBc/phatIESF5YzvRqacHTijEtNRuYnvo2MIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfhJso+2nCjRXUZJcV89rMsv35BCneUSJ3bJidv8VcNAB2GXnttcaUp4IVfzpMA9Sj8wPNGzv3R9oQH62FUrN8vPx22JK3gZyMalb/seEP2X8YvTFrYn1D/JN1I429YavA5WrhKvyaB5x9aZg/XF2CSbOGDcMPn6CX2FrV3Nh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cCTN+vD4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M5IwW6Ik; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cCTN+vD4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M5IwW6Ik"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDkJR2879979
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BcCIhz6+fnrglONp8q+fp9mef6PmcObbxRhKXStO7Qc=; b=cCTN+vD4HZwmI8lY
	ejqu7lzDeKTXwqFAMS/sTRNpvdMoMiAxUyoiJA4eFhpTgRLfRvMGXkbNO/sLcOq/
	Kr+o5qtLY8bZPydk48LmdD/QYhha9Mb3Zu6Jg+jFbz2OOi1lt4JlAnzouxfKRufJ
	1vGYuxgbkXfYsDebztJs91VxnfPK2OfyBaisU1JmguWpqdxoLPcaXic72syA9QUH
	lQgzTeaDRLIA5CkABN64XzCZrZhXKelOBhJ4L0wGngzhGDLoUE7KBunhksmwlV73
	6OwRuUZRp541lZkHdVRtlTvsEu9R7y1qiVobl6Ek9AO7twcGrKJzrgt8SbClgnEU
	dlxizg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hfy9d4d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:08:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-915c364ae3bso1083985a.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782857298; x=1783462098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcCIhz6+fnrglONp8q+fp9mef6PmcObbxRhKXStO7Qc=;
        b=M5IwW6IkHK0iiF66T0HlZSqYBxXV2G7M0IeKaGSbbe73F0yJIaWzFqHevIJO8uzIpb
         NJpZ5komiQgwZ5mg1Vn89GRH2bf9vc3fLtCX/yZzK0wZgX5F0ellNrWmqv9ZzNnIQxK2
         SebMjQrysqRIXgyl/cta8uiRcj7xmyCOqMJTMei9OtRlUg+Bo7kqd9TQ0ePHWoUgrR1s
         RSwP+bXBvQp8qpFWg57bFTZfYrj3FRHPWVaRSHNO46r1gP+HHFGe7nhiTjazcsh+NwrB
         gSvXCfwZirBHtsae2T5Y4kaenRQArPYJ7Aq32plSwlH1AyYSdRp27EPcvPiicehTslAI
         W94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782857298; x=1783462098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcCIhz6+fnrglONp8q+fp9mef6PmcObbxRhKXStO7Qc=;
        b=jcrm3Z5Bxb8i5Y6c9Khw6Eq8e6nZiB19cUTthlXMBGJUhGQ1JRb++0TI1NPlo6sZaA
         mUmgdHY0XPEllpQK6xOhYRvxWjR65vQwUS8MIxfrQaKcRtPeFAevezWEhmld1L6BTFS3
         a8sWxsr7+qHEYax/ysKcID7arzkH6T8UYFNwlRvj3I9btsNMWr7wwjVZS5r998OfsCfp
         Mkrr8Cr0VV+gZlWH3o8GqhsRJNl7hlqytGtA0QhzwPX3jyyYvmXlDZiJpFQknSwBfAiU
         ne95Ox4CcZZ6F0du+W3xjh5xKu85i263Qrdd4NX6sPwwxm7T4LynbqisMjXYmFHoAl6X
         1sCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+q7LaqVBTpVwRBbsnC6vyA37Ty+SfbYEWKS2IWO75LjET5H866La9VWKVooajuOAZfPZ+Zz2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8nXhd6Sz9gipe0R1xrjL83aBPfZefQvLWUUZpn5qthAxZDr2y
	PJz1upafy8KKO8BWVv1dbmY6zzTZI9qGdnmWFUwtBiFEoUlWqNw0xBJ7rSxV2V+abzlBPN+NyYn
	7DM0+EtjjNshMdeDjbZ0sEPNeQnVrHjVyJx9cXwf6xM3ShzyrPZ5ohfF0LXE=
X-Gm-Gg: AfdE7cno8YqLZ9NnqfQzKmb7wQEPhRUU59VQBKo2MCafkZyIeM2qfi6iZSWVZWYt8GI
	IDuuhB6+Up2XGrdoYYOCqDF9hYkgd82ZnB5GJLVEX3PuiD9yzZbBwYtoX6Xsr2hNzTnVylBdgJ2
	ex7ZvV+oySz3HvcOzType+8O0nqbbq2/7MJRWZIZx+DwUnFuueIFndSVW3l5YJGCVCDg/6BKcpR
	e0vAktrDEAcjVZe34crjPJpe59priUY9l8SI0viUjaZPhSPS925Us5NTYe0e2E7rj1i24TBoHyB
	7FwsZgc+H6xIRwmVGP0eQj2Z/CMZFKF+HhATJhYbMTOx45yfvb6UqCIH/my0JLvngP6pzvBTueA
	ErGaNTscJEV8DdVPh0+nQdlKLT7oFrcKsnn4jfgjVhNH3vXqHdRlLDb9kceB0DQ==
X-Received: by 2002:a05:620a:25d3:b0:92e:5c56:727a with SMTP id af79cd13be357-92e627fa3f0mr909681085a.60.1782857297848;
        Tue, 30 Jun 2026 15:08:17 -0700 (PDT)
X-Received: by 2002:a05:620a:25d3:b0:92e:5c56:727a with SMTP id af79cd13be357-92e627fa3f0mr909671285a.60.1782857297248;
        Tue, 30 Jun 2026 15:08:17 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf26sm9903482f8f.19.2026.06.30.15.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 15:08:16 -0700 (PDT)
Message-ID: <9c94a0b6-a2e6-4d3e-872d-b1d3954a4071@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 00:08:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] mips: replace linux/gpio.h inclusions
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Frank Li <Frank.Li@nxp.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <zajec5@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linus Walleij <linusw@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org
References: <20260629132633.1300009-1-arnd@kernel.org>
 <20260629132633.1300009-4-arnd@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260629132633.1300009-4-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J5OaKgnS c=1 sm=1 tr=0 ts=6a443e52 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: TpK9OE-eoljsH_HDJxtMsvLLoWF8ofOl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNiBTYWx0ZWRfXzAT7blKas7Yj
 CuoAjDUBWi9XgCcsZJxkuvIYWw5PzdWJWroWG7yLJtLS0YZFXC7/rd0uirJY0/kY+OuBMt7T+Aw
 QJrK827S1j/Wu8Hul4kF6Dvn0DhXPoM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNiBTYWx0ZWRfXyfCRvVlZ+MvJ
 wxk94vw12mlIaz72i+uwIJ780GNgZ2g1uZ8pbstG1NDTwXuzHd1SMEDMddT7Isp7vl9646lMb1+
 z0eJoic8cXm9tYCfzOT342mplF8Igfh1ZEMNRBU62pY+m2YtBGIU+NH9Zw9TbpPtFi/raFm6X5W
 JIGlEA0DeR3qBkXyUiAZMMs8U/Rjf5N2d7pcPdehGJaiJFtg6yuzBcFlnhYgYnWO35pvXuVtOVg
 KxDJJE4mo2cSvrSzcCqe3948oMeoBustCUBtpijnn/SDqW9TRchr+Ish4o8nNLT/ab49HhLDBoc
 dSm3WRoDXfD0mjdvVVfBKlgpBs3/C9sBslrABHhHiZgC9lWOrcZmmM19hPFUfMARJ9sTaO34PqB
 VVX5wcqKNG0xGBXhVnFhlsqHl+4tGabC1Asu1iNhrRivphTR9BNd36BL5v6vlYJsXpajKFc6mmB
 OlgOKMt5txK12zWCAVw==
X-Proofpoint-GUID: TpK9OE-eoljsH_HDJxtMsvLLoWF8ofOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300216

On 29/6/26 15:26, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> linux/gpio.h should no longer be used, convert these instead to
> either linux/gpio/consumer.h or linux/gpio/legacy.h as needed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/mips/alchemy/board-xxs1500.c                   | 2 +-
>   arch/mips/alchemy/devboards/db1000.c                | 2 +-
>   arch/mips/alchemy/devboards/db1200.c                | 2 +-
>   arch/mips/alchemy/devboards/db1550.c                | 2 +-
>   arch/mips/bcm47xx/workarounds.c                     | 2 +-
>   arch/mips/bcm63xx/boards/board_bcm963xx.c           | 1 +
>   arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h | 2 +-
>   arch/mips/txx9/rbtx4927/setup.c                     | 2 +-
>   8 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
