Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B5249D5A6
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591582; cv=none; b=aH/p0XlLR7qk0P/1jG5UYmV2HwMyKsE/TxknP/SfhhgWPMrZm9QZTu4ZfYZd3FYsNJK94SWjHSyoRM+q+0bqO/HR8gSJCvp3sJhbuvXSBSDl6Dzc+S2N/c44d5PChxb8XkSarpF0LAOXkvJHH0mfUt6xViv84l+FISfPpaTfdEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591582; c=relaxed/simple;
	bh=2XNAhu9CxceJI8vwdqpOVTsl9oWO7hi2cpJ1xfPfc28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HqV0GwORUeCb7W+cFBA0YQNByv3rqwJic+Ls1IEpal8HoBHSwiJJLTYO01kdPmxh737aZGpPv741V07mgQFGxDXSTJZTeHxFIl22j3CO3bR/8vVhhZ1Dc/xivc1vHtUbDjKj+/5JJrUiymxSWOVszuZsH2tSyxvJU3rgikcCJGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M7ZuDK+7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i0q8xq0q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M7ZuDK+7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i0q8xq0q"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9MEDt954452
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vxstwlbKuBUJawkY+2kMsXbkr7mK4XNxlqUWYk9+Y44=; b=M7ZuDK+7COYZxi0/
	Ix6tg4JvaZXPRQcI7YYJjAMW9atxYiiEaKdJheVVdQsM0/ONof3w3FfaH2K1U5Ks
	d7aFhL/jQOVGrZryfFZROOA74sAQO7G7KA/5/78eeazdV5E3e8EZ5W5VzvH60hL0
	Q4VdKsIfuUxGTf34swjxvZEbyauWo5uqx4niqQKFCBJPfB2iXBfxSjn31GdsHEeg
	ISBBzhX1ZHjRsdgZ183v72vbCLFLljmudOUSeELEEA1S9EkWK4x4dD6hBSsl/s7R
	bJhMmKL4gVN2WuU3sgiFDXzS04m9U1Lavjd0/DyGdAneJbaPAZ9ANy9M90hU5aq9
	ZbYnrA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc0a46-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:32:55 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1eb205d31so3318388a12.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 03:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790591575; x=1791196375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vxstwlbKuBUJawkY+2kMsXbkr7mK4XNxlqUWYk9+Y44=;
        b=i0q8xq0q5FrEoEKlkdovtSj5HmwBMAHx4ZlRjVuB+NUeAdlJXLuCBV7RkODmbRr1Rn
         0zIrOnMJEWARzEEy6QajnbScGP8251JqYZJtSkjdeKycq7ahG/WJPiSaV5wCzd/SB4jv
         +VEC/eJjMZ6m585hXIv6y1YeLbgxsWIEO+NQX/5Ij4897TkwH2ZTQz0st/8swuu8rnY/
         WqUqeHZISJ/KqxbJfbaqMGsTd2YpSYiQUbEoI7cu0DNT1TO7aghCSx8srtsKTdckrqib
         BJNPNW27zSL+P3a3QaUYfmY9zHbSjWx9CdtdW5souQj9ZLebJujAtRbXRMTqyhhYvS1x
         sL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790591575; x=1791196375;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vxstwlbKuBUJawkY+2kMsXbkr7mK4XNxlqUWYk9+Y44=;
        b=oBDw/8ut2lEKhEvkNeTtRinKW5UM0dY9/0NpBWYaFfIKfkHrKwpnshEo3LjOI6LjhM
         UnunqmTshYvWuXuuXb42JMJb8gerzlO8uBlP5XkEKXKCpmWJo1chUjxDaGlzgvLqyvmk
         /wpK4iujadvOMWdf9zVO4rhkU4rPaVAP+3+oHahCjqr/BjRAd7U7hvFvhSnz88nTdoJI
         v1FCp/VGlfXPOx84jlQYzZXTTINbwbZJw9qZXoHJF3xmVL2axmgYDvnx1Boud4PCcK40
         uL1Bn+MgyQEBQ93AwkxXXtbJ8VKN10yUw+4w9tuUiWSEsLr2xcpdZo1ZrraZtsCoHR/7
         lqMw==
X-Forwarded-Encrypted: i=1; AKwUvBwo02lHOVb+al9V5DuJvrqzjmYmCHi9EHT4w8qIgqi8qEzg0KGQunftyK80mGQKc3pgamdY328=@vger.kernel.org
X-Gm-Message-State: AFuF++nZXn737u0RXlnQhd9+YNrE9hNeBuW8+/nCFv9e6tQLpi8Pj4so
	Pbzcp6zaAK7NAcm4JTn/4OnWQS7J1IElQd6VbY4VcRwFOcMMQsIsY1+/aMZYN/lyIN6kI/+J6bO
	iQvkmhgsMezzE2Wk+AjVfnM4Cazc/wy1HvLulQure8GapLgig8IqHi7x9dlQ=
X-Gm-Gg: AYBFou1Fz1A+W6rz30jfv1spVHCMYLK2K0wt/hm+c8BxvH7gzQrGi6IF8OsmBuJzBM+
	zlSWFWyP9YRjchi77xN0VTw+XODc3BaQeITC4TUkqLvHNbqJcFsSwO9UKfyUKo2Y0bJ6UWsEFiR
	+imI6A2zW9jI9zuZibuUQbJQOOE/VPkxVRFDwL9QoQCz5vjqV4RxUtsY1VUFOSkGeuyuwArrLUI
	YWJewpFNfWFSs8rix0UllXepIYKOIEA2ohVV4r9LNErWHG3jWtJSR78yOUjIu/XGwn1hjDNeUEo
	xR5AZHvwfA79iOuVmSdVUgkOXssRqltqDdZkBFKpkrt1vvF3lV3Ezgd01puFwXYEbvlSY+de8oo
	D6vfMayaG1NeXeRMKeRjUO6isoH0qwF7s
X-Received: by 2002:a05:6a00:9095:b0:857:7337:5dba with SMTP id d2e1a72fcca58-8802a7ad603mr6283603b3a.24.1790591574600;
        Mon, 28 Sep 2026 03:32:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:9095:b0:857:7337:5dba with SMTP id d2e1a72fcca58-8802a7ad603mr6283581b3a.24.1790591574117;
        Mon, 28 Sep 2026 03:32:54 -0700 (PDT)
Received: from [10.218.31.237] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea88a1a2sm3854645b3a.25.2026.09.28.03.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 03:32:53 -0700 (PDT)
Message-ID: <ca3c86b6-c837-4298-a1ab-4fc61a2f8a0a@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 16:02:47 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] net: wwan: qcom_bam_dmux: Add restricted
 DMA pool support
To: Stephan Gerhold <stephan@gerhold.net>,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
References: <20260920-qcom-bam-dmux-vmid-ext-v2-0-ef5ca2178378@oss.qualcomm.com>
Content-Language: en-US
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
In-Reply-To: <20260920-qcom-bam-dmux-vmid-ext-v2-0-ef5ca2178378@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba4257 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=farQdCg5IzuLFFoMD6QA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: y1mzje9T0WIoU8XpU8Cn8nRtb5FdBtQw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfX8/wWKYVNm9A9
 E+hMbQJmw+Siv5+s9Mabjb2XCDXWCxCCPZ9CCM15LVJ7GsyqMU973Tj+cM39EWvFwbnBu/Dy66o
 uxrXvVIyceVzMJ2GiqgipTkqPcufPfWe+Dt0ckviB/3tL64WOxAhaCxW2pFqGl09iaM3WpvgeIG
 vwzGUsrNWlqsyDX8BMexEwRy4o3+wPaMFtRGK5iOn4ZLUtSrnacMvTO1E1lun34O9ki40Ex2tAl
 fXMDwsSwv53EQGGSQ0JTbPW0Ga04yukwu3ze+AKZDDAVyOMLzsyu3CYimcAn/Hh/l6ec2xbiTTb
 aOEib00nPilSLt4ABVDukFsfC32JPfvziazTFNU+Udx2bciE6SsPR+bbI0VipB4k77hn8aOaMS3
 xUXjZeS10fOGDhD+xX/NhJ+R/gCLcobDFdKfgvHTVpcjadTfn8wHpGY5jyR0n1onwtUiVcN3boZ
 Iii/AyIeqKk4vC4oSGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfX77voV5m//sIE
 UeR2YQNtSbqBwVnCbKwHE6FRdDXi2kAHwHaIDKzKi+gty8Psr6wh0jrAp4g/yHE8mk9poQHz+6v
 c5ncbfWjG4e0uJR9GhjBN63kHXrkq18=
X-Proofpoint-ORIG-GUID: y1mzje9T0WIoU8XpU8Cn8nRtb5FdBtQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280041


On 20-09-2026 08:32 am, Vishnu Santhosh wrote:
> Some Qualcomm SoCs, such as Shikra, run the modem in a separate security
> domain with restricted access to system memory. BAM-DMUX DMA mappings
> and BAM descriptor FIFOs must therefore be constrained to a designated
> memory region that can be shared with the modem. Accesses outside that
> region can trigger an XPU violation.
>
> Add memory-region and qcom,vmid properties to the BAM-DMUX binding.
> When qcom,vmid is present, the driver SCM-assigns the entire restricted
> DMA pool to the local and remote execution environments before requesting
> the DMA channels.
>
> The restricted pool then contains the BAM-DMUX mappings. When the BAM DMA
> controller references the same pool, its descriptor FIFOs are covered by
> the assignment as well.
>
> A related binding change allows the BAM DMA controller to use the same
> restricted pool for descriptor FIFO allocations:
>
> https://lore.kernel.org/all/20260920-qcom-bam-dma-vmid-ext-v2-1-4dbbff0e57c8@oss.qualcomm.com/
> ("dt-bindings: dma: qcom,bam-dma: Allow memory-region property")
>
> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> ---
> Changes in v2:
> - Replace the Shikra-specific compatible and coherent RX allocation with
>    memory-region and qcom,vmid properties.
> - Use a restricted DMA pool for BAM-DMUX mappings and BAM descriptor FIFOs.
> - SCM-assign the complete pool before requesting the DMA channels.
> - Validate the remote VMID and restricted DMA pool configuration.
> - Link to v1: https://lore.kernel.org/r/20260714-qcom-bam-dmux-vmid-ext-v1-0-3f29da7cca76@oss.qualcomm.com
>
> ---
> Vishnu Santhosh (2):
>        dt-bindings: net: qcom,bam-dmux: Add memory-region and qcom,vmid properties
>        net: wwan: qcom_bam_dmux: Assign restricted DMA pool to remote processor
>
>   .../devicetree/bindings/net/qcom,bam-dmux.yaml     | 38 +++++++++
>   drivers/net/wwan/Kconfig                           |  1 +
>   drivers/net/wwan/qcom_bam_dmux.c                   | 95 ++++++++++++++++++++++
>   3 files changed, 134 insertions(+)
> ---
> base-commit: 8830e65ed46de41f849eefb8ba227d4852c460f6
> change-id: 20260714-qcom-bam-dmux-vmid-ext-d9289db310c1
>
> Best regards,

Hi Stephan,

I followed your suggestion and updated v2 to use the restricted DMA pool.

Please let me know if this approach and the implementation look reasonable and
meets your expectations.

Thanks,
Vishnu

