Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773343;
	b=GnEOs5ow77IY/Htea1dZ69U3OSmj2X0sM2LhrwjnAaVJqyckjSBJ4NQBFYYddfKRLx+R
	 ArRGLBnT+LE1txAvaPvwLBnGPQeX+hzPQULKL3jIC/XjAKAWIf2iKjW9eUXku8WdaeYEh
	 LV+5CXRwbrolcVGZVwHKv9bzuD5vWEEjgqhqUdwuM66l085cdbG7ff/4BUxq9nRE/AOMn
	 t6uP+q0zwEWNq9q7EQ1MADkBuCEXBZssTfrYPk2uyZhxytDu1hfrwsWKr4i8B1Q70DMNP
	 o7D2KCjgv5ZHo22OuhkS56LzedrexI4h7ICwQo4/nmChNVJV/ugks1zi4FfwHmk6NeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773343;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9tuwVOXQBEaXsKIi8tl2Z1wOT2yemgt0+YJoz/5KaXY=;
	b=EQ5vhpvs4u9BSYZBpUHwaFhQnyz9Y4e4UiQ9sj6DnJ0qi+90sP0BiAT3FXLVK5K9SELN
	 V1HgN0zH+ytORGtSp+Noh7mUq/iLjlTvBfY183cP5JP7HLn1FJv1s5wdF5Dw/kAH0afjC
	 l4ghuoZu2vOZHqNAtOFVj24trI0zlcRB/GLiNkhJkZ5/+z45A0D5F2CEr+O5dViD801D7
	 2gK9hz1Et10LIQEy7GW10vqlHEfoxGZ8ijFF/Y5kwD1kpt7EvZuKJ8UU6KZBF1GuCnkmR
	 yXb/slrnDz0R3sFEs5YNfr5SF4hBOj6XhU4uGpxWLn5WN2SmM6oVI3mVds71Gp4BJgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VQVvdwkf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C1VNdBK7;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC97606A32E
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 06:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AC97606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VQVvdwkf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C1VNdBK7
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40RUG7230859
	for <netdev@vger.kernel.org>; Wed, 4 Nov 2026 06:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9tuwVOXQBEaXsKIi8tl2Z1wOT2yemgt0+YJoz/5KaXY=; b=VQVvdwkfxDSzkpO/
	4ETpxhNJp+TZTXs3EzISPCHbIKimQsJ3iEuzZ73JH/aA8GlEnLaN/JWY1srGwqTy
	ExQwk4/Jm77GD6X7oObQKoKQUvUjGAiZl5fXP98XnkUT23/N1TLpX0LaPHAFBRmt
	XQmQQnLKLNwPPsBvJBnySGSL7UKeaKPqQJmzVDy8JTylw2PnIoXN1jIQynqbSpEN
	a+ogRPrhmILtrn1HzG4K3cgcNNF7uN9MEwr3qgqD9MRTOpo43bV6Tpb+rjSgCIhQ
	GGS0yV49eo3gfo003nTGn1uq0Rk0k7W+WLGSDRw34yu425ngaDbCP0CVlF+VxBPo
	Fzc7pg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqhypkggb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 06:22:21 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ae1d132d52so502272a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 22:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793773340; x=1794378140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9tuwVOXQBEaXsKIi8tl2Z1wOT2yemgt0+YJoz/5KaXY=;
        b=C1VNdBK7N6zqLSSHXKTaGHcCXKHv7R0Ijb2pwGAp7yS0G+2D+b5As8aPO7mkEWwNAJ
         6HQj8DURRjw7Pjyl56k+TpGYb0naiFewciADm2fRWNgp16LkKIH8BLjc7ceoLE4tudee
         nssjEriQuRVbjBMuAkZnGswn2CH+yndCw1C7wss3nIwSIS1CGBmqUizd31eo9YfSVqjX
         3hN5J/SvFDGRw9VvkJSm/S7U5n0X1a0aGHmdhcChsmwfK9RTPOMLLzROE0lW36grLxIr
         EYR277ioNlm7bKsawsyRJfMQPoh6cUxGO70019onBQ2JbGhei90554eZGn6QKI6zoeDl
         qyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773340; x=1794378140;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9tuwVOXQBEaXsKIi8tl2Z1wOT2yemgt0+YJoz/5KaXY=;
        b=lXFzzsRQw4wpeyJhZB7MyIfgBSg0Q0qEmvvN8xhqpCdGOo7ut2VZsgBiVoLdnA4kNx
         GLqH711z4ttoyW7XWIpKciEkdu5s8zeS6aVM5xtZ3fWaij6dXtiuTQW6S6jMwXg3qQyd
         uwYhjd5tEHkg/seYYu5S7zR+qXD76oa50ZuFU4Oc8Cfqsce8/C7qODam2NfIq8EYQIwa
         dEKqHu2APWOSKFfNTjz8FfpdPZi3jyh4SBfL7GaN8Ew4q5sHwo8uFgd3LTNuOrb5zmkW
         HbEu4MU3GpEEcrvrmhezrI8skOvp5UZUg2MxBh4RdI4VlLSxNUYotyaAHeqKOmhxvlb3
         Zfug==
X-Forwarded-Encrypted: i=1; AKwUvBwsJ+8RgjXqRih+Q0tD9C8xroCUqqnp+ZwyPlmQADfg22m4LteUJY6MxBNd05piRD4EIJlCsl4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+g1O6i4JvxTsP1K8k8MceeKvCNdCFRSAmZJGpZstF8GO0jVlYa
	7yEXxADqAsQVES2eYfuBpbXkJ8SfpfcxwqGo1IQAqV1GhQ3LfbIl1mFyPvs9p97kdzAp+27VVAl
	73moeVAkNSMpYt451/Hxi9SlFgwxO4h4CEDHT3tHrIpZMA8md0aaZ9Bn0VOM=
X-Gm-Gg: AYBFou0npwx5MEAcAAQWj3PUeaGy+JpBcYf4lhLwfRFXl54XC4cZcfKEmGeBaFDXR9Q
	kIqdFuukHlrTZli9PFbv+Es3L4Ne33xKrG1ZGKPrD5VLDDINpkMkXH0igYVPz95PDJZgcLQahyP
	+pIBh9Wc783GxvKTaw6qwOR+KtJ4a92yYSFPvzTDIsf1wRzAHxrKT++u1NzzRcllT77qfSQ7FIK
	+yV1kc2M58xhzqxKS8W31Pn6O11weF/3KUaygqleqyUrY0qXZshCdaL0GFWhqItsbmGBUt6MKgI
	l/38SV3TN5QEWFugtHS3gLXVpXupwG59B733fOZ7wzG4AoRtIxHWTGOg3F729m2ooDmKGZLxGPw
	BbBt916dmXT9Wzt9Uc78eiUqwRBRq+9QMY1BvT2UqLovRoB3BeztXf05B7yV04F6qqPzg7oNkW9
	wNu6j5
X-Received: by 2002:a17:90b:380c:b0:3ab:3437:554f with SMTP id 98e67ed59e1d1-3ae89749415mr12176644a91.29.1793773340053;
        Tue, 03 Nov 2026 22:22:20 -0800 (PST)
X-Received: by 2002:a17:90b:380c:b0:3ab:3437:554f with SMTP id 98e67ed59e1d1-3ae89749415mr12176619a91.29.1793773339417;
        Tue, 03 Nov 2026 22:22:19 -0800 (PST)
Received: from [10.218.31.237] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944bb7d0sm2303388a91.11.2026.11.03.22.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 22:22:18 -0800 (PST)
Message-ID: <ca063b2c-a218-450d-b28e-7bb1c775e7f1@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 11:52:12 +0530
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
Subject: Re: [PATCH net-next v4 2/2] net: wwan: qcom_bam_dmux: Assign
 restricted DMA pool to remote processor
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sergey Ryazanov
 <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Dumazet <edumazet@kernel.org>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
References: <20261103-qcom-bam-dmux-vmid-ext-v4-0-3690cc5ca0fd@oss.qualcomm.com>
 <20261103-qcom-bam-dmux-vmid-ext-v4-2-3690cc5ca0fd@oss.qualcomm.com>
 <CAFEp6-3iRLDJUHAEa4qGGcqJYUSB733wKBFDw_k5NF7LQF+jQg@mail.gmail.com>
Content-Language: en-US
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
In-Reply-To: <CAFEp6-3iRLDJUHAEa4qGGcqJYUSB733wKBFDw_k5NF7LQF+jQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyNSBTYWx0ZWRfXzAXC9nnQQpjK
 kVlepU2v1NGpq8SigwUOP3bjsVxFrZ3lVUqKL6zTRvw023l2diVlMLht0dcEhl9Ql33imxfiWFw
 a2exNKiONYpxIuHptp4Ra7AYsABO7+I=
X-Proofpoint-ORIG-GUID: olBge5p6b6nvoV9obQD0TuUkPkKHLUwZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyNSBTYWx0ZWRfX76smnI7BVYTX
 big2BFwA0/VMPuojHzJG3uyowigjJrv35+I4j8UQQ+EGUgEWMqUwkJ1ehBuTPGLl4U86n1LglM6
 1eHAtfZevpZQnQOaK9rGIlyXdIYgwZ/EkB1f/dipFR5TK0rf/L66aKXSsUf9Wo0XVoB7mcEl4LD
 feVCxaU7AVotLGKzFKR731nzxPat24/uvc+l0le84ICr+LMWVkNTQy0F3ko2CeGxDQ2+ozUu91i
 rRm81BFngnFmsLKRXdcEO3eXQUF1zZpXdEOFEowSG4NdplIlpP76Xzyq1SxAsTN48y7p5KQcKwR
 LXxyX3KNIftAQl1pvOf+oebLVBXvs/eWQu88WUcGmHsicT5cRrR9rCWSBmhe9OddENQ/gf2OIAR
 TWsdrt1uX8X5zDH2g/fJorGXAcPvKG7TuYXvc4xZEKoypVisgX/p+H9UbnRmHUvmKlKF1kJqqPv
 ZipsoCqjeOupoq8UfDg==
X-Proofpoint-GUID: olBge5p6b6nvoV9obQD0TuUkPkKHLUwZ
X-Authority-Analysis: v=2.4 cv=T94Z3PKQ c=1 sm=1 tr=0 ts=6aeacf1d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HNnKpJZYh0h9KZw2ozsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040025

Hi Loic,

On 03-11-2026 09:34 pm, Loic Poulain wrote:
> Hi Vishnu,
>
> On Tue, Nov 3, 2026 at 3:19 PM Vishnu Santhosh
> <vishnu.santhosh@oss.qualcomm.com> wrote:
>> Some Qualcomm SoCs, such as Shikra, run the modem in a separate security
>> domain with restricted access to system memory. BAM-DMUX DMA mappings
>> and BAM descriptor FIFOs must therefore be constrained to a designated
>> memory region that can be shared with the modem. Accesses outside that
>> region can trigger an XPU violation.
>>
>> When qcom,vmid is present, require a restricted DMA pool and assign the
>> entire pool to both the local and remote execution environments before
>> requesting the DMA channels.
>>
>> This ensures that BAM-DMUX mappings are within the assigned region. When
>> the BAM DMA controller references the same pool, its descriptor FIFOs
>> are covered by the assignment as well.
>>
>> Track the assigned execution environments explicitly and reclaim the
>> pool for the local environment after DMA channels and mappings are
>> released during remove or probe error cleanup. Skip the reclaim and
>> leave the pool assigned if the remote side still holds its power vote,
>> since it may still access the pool.
>>
>> Fail probing when restricted DMA pool support is unavailable, when the
>> VMID property is malformed, when memory-region does not reference a
>> restricted DMA pool, or when the pool is not attached to the device.
>>
>> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
>> ---
>>   drivers/net/wwan/Kconfig         |   1 +
>>   drivers/net/wwan/qcom_bam_dmux.c | 114 ++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 113 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
>> index 958dbc7347fa84ee869439bf8b503037faab8bef..1b133c56231615269698140187ca3141dfe48dbf 100644
>> --- a/drivers/net/wwan/Kconfig
>> +++ b/drivers/net/wwan/Kconfig
>> @@ -65,6 +65,7 @@ config MHI_WWAN_MBIM
>>   config QCOM_BAM_DMUX
>>          tristate "Qualcomm BAM-DMUX WWAN network driver"
>>          depends on (DMA_ENGINE && PM && QCOM_SMEM_STATE) || COMPILE_TEST
>> +       select QCOM_SCM
>>          help
>>            The BAM Data Multiplexer provides access to the network data channels
>>            of modems integrated into many older Qualcomm SoCs, e.g. Qualcomm
>> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
>> index cc6ace8d64371eb8d00c638a39b234ee540b83c9..c9639474e58acc16ce0d04f181b2e999cff42bd1 100644
>> --- a/drivers/net/wwan/qcom_bam_dmux.c
>> +++ b/drivers/net/wwan/qcom_bam_dmux.c
>> @@ -9,14 +9,17 @@
>>   #include <linux/completion.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/dmaengine.h>
>> +#include <linux/firmware/qcom/qcom_scm.h>
>>   #include <linux/if_arp.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/module.h>
>>   #include <linux/netdevice.h>
>> +#include <linux/of_reserved_mem.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/soc/qcom/smem_state.h>
>>   #include <linux/spinlock.h>
>> +#include <linux/swiotlb.h>
>>   #include <linux/wait.h>
>>   #include <linux/workqueue.h>
>>   #include <net/pkt_sched.h>
>> @@ -75,6 +78,9 @@ struct bam_dmux {
>>          struct completion pc_ack_completion;
>>
>>          struct dma_chan *rx, *tx;
>> +       phys_addr_t dma_pool_base;
>> +       size_t dma_pool_size;
>> +       u64 dma_pool_perms;
>>          struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
>>          struct bam_dmux_skb_dma tx_skbs[BAM_DMUX_NUM_SKB];
>>          spinlock_t tx_lock; /* Protect tx_skbs, tx_next_skb */
>> @@ -762,6 +768,96 @@ static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
>>          return 0;
>>   }
>>
>> +static int bam_dmux_assign_dma_pool(struct bam_dmux *dmux)
>> +{
>> +       struct device *dev = dmux->dev;
>> +       struct device_node *rmem_np;
>> +       struct reserved_mem *rmem;
>> +       struct qcom_scm_vmperm dst[2];
>> +       u64 src = BIT_ULL(QCOM_SCM_VMID_HLOS);
>> +       u32 vmid;
>> +       int ret;
>> +
>> +       if (!of_property_present(dev->of_node, "qcom,vmid"))
>> +               return 0;
>> +
>> +       ret = of_property_read_u32(dev->of_node, "qcom,vmid", &vmid);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "Failed to read qcom,vmid\n");
>> +       if (vmid == QCOM_SCM_VMID_HLOS || vmid >= BITS_PER_TYPE(u64))
>> +               return dev_err_probe(dev, -EINVAL, "Invalid qcom,vmid %u\n", vmid);
>> +
>> +       if (!IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL))
>> +               return dev_err_probe(dev, -EOPNOTSUPP,
>> +                                    "qcom,vmid requires DMA_RESTRICTED_POOL\n");
>> +
>> +       rmem_np = of_parse_phandle(dev->of_node, "memory-region", 0);
>> +       if (!rmem_np)
>> +               return dev_err_probe(dev, -EINVAL,
>> +                                            "qcom,vmid requires memory-region\n");
>> +
>> +       if (!of_device_is_compatible(rmem_np, "restricted-dma-pool")) {
>> +               of_node_put(rmem_np);
>> +               return dev_err_probe(dev, -EINVAL,
>> +                                    "memory-region must reference a restricted DMA pool\n");
>> +       }
> You later test with is_swiotlb_for_alloc(), so isn't the above test redundant?

Right. is_swiotlb_for_alloc() is only true when the DMA core attached a
restricted-dma-pool from memory-region, so this check is redundant. I will drop it.

>
>
>> +
>> +       rmem = of_reserved_mem_lookup(rmem_np);
>> +       of_node_put(rmem_np);
>> +       if (!rmem)
>> +               return dev_err_probe(dev, -EINVAL,
>> +                                            "Failed to look up restricted DMA pool\n");
>> +
>> +       if (!is_swiotlb_for_alloc(dev))
>> +               return dev_err_probe(dev, -EINVAL,
>> +                                    "Restricted DMA pool not attached\n");
>> +
>> +       if (!qcom_scm_is_available())
>> +               return -EPROBE_DEFER;
>> +
>> +       dst[0].vmid = QCOM_SCM_VMID_HLOS;
>> +       dst[0].perm = QCOM_SCM_PERM_RW;
>> +       dst[1].vmid = vmid;
>> +       dst[1].perm = QCOM_SCM_PERM_RW;
>> +
>> +       ret = qcom_scm_assign_mem(rmem->base, rmem->size, &src, dst,
>> +                                 ARRAY_SIZE(dst));
>> +       if (ret)
>> +               return dev_err_probe(dev, ret,
>> +                                    "SCM assign restricted DMA pool failed\n");
>> +
>> +       dmux->dma_pool_base = rmem->base;
>> +       dmux->dma_pool_size = rmem->size;
>> +       /* Track the destination VMIDs explicitly for the reclaim operation. */
>> +       dmux->dma_pool_perms = BIT_ULL(QCOM_SCM_VMID_HLOS) | BIT_ULL(vmid);
>> +
>> +       return 0;
>> +}
>> +
>> +static void bam_dmux_reclaim_dma_pool(struct bam_dmux *dmux)
>> +{
>> +       struct qcom_scm_vmperm hlos = {
>> +               .vmid = QCOM_SCM_VMID_HLOS,
>> +               .perm = QCOM_SCM_PERM_RW,
>> +       };
>> +       u64 src = dmux->dma_pool_perms;
>> +       int ret;
>> +
>> +       if (!dmux->dma_pool_perms)
>> +               return;
>> +
>> +       ret = qcom_scm_assign_mem(dmux->dma_pool_base, dmux->dma_pool_size, &src,
>> +                                 &hlos, 1);
>> +       if (ret) {
>> +               dev_err(dmux->dev, "SCM reclaim restricted DMA pool failed: %d\n", ret);
>> +               return;
>> +       }
>> +
>> +       dmux->dma_pool_perms = 0;
>> +}
>> +
>> +static void bam_dmux_remove(struct platform_device *pdev);
>> +
>>   static int bam_dmux_probe(struct platform_device *pdev)
>>   {
>>          struct device *dev = &pdev->dev;
>> @@ -796,6 +892,10 @@ static int bam_dmux_probe(struct platform_device *pdev)
>>                                       "Failed to get pc-ack state\n");
>>          dmux->pc_ack_mask = BIT(bit);
>>
>> +       ret = bam_dmux_assign_dma_pool(dmux);
>> +       if (ret)
>> +               return ret;
>> +
>>          init_waitqueue_head(&dmux->pc_wait);
>>          init_completion(&dmux->pc_ack_completion);
>>          complete_all(&dmux->pc_ack_completion);
>> @@ -829,8 +929,11 @@ static int bam_dmux_probe(struct platform_device *pdev)
>>
>>          ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
>>                                      &dmux->pc_state);
>> -       if (ret)
>> -               goto err_disable_pm;
>> +       if (ret) {
>> +               /* The PC IRQ may already have powered up the RX path */
>> +               bam_dmux_remove(pdev);
> Calling remove from probe is a bit unusual, have you checked that
> everything is correctly balanced?

This was changed in v3 following the Sashiko review of v2 [1]. The PC
IRQ is already requested at this point and may have powered up the RX
path, so in v2 the error path reclaimed the pool while the DMA channels
and RX buffers could still be active.

Yes, it is balanced. At this point probe has assigned the pool (if,
qcom,vmid is set), initialized the works, wait queue and runtime PM, and
requested both IRQs, which is everything remove() undoes. The steps that
may not have happened yet (netdev registration, RX power-up, the PC vote)
are handled the same way as in a regular remove: unregistering an empty
netdev list, power_off() and free_skbs() are no-ops, dropping the vote
only clears the SMSM bit, and the wait returns immediately if RX was never
powered up. The PC IRQ is disabled before power_off(), and the IRQs themselves
are released by devm afterwards.

Do you see any specific concerns here?

[1] https://lore.kernel.org/all/178996250389.2160803.17277339384338088713@kernel.org/

Vishnu

>
>> +               return ret;
>> +       }
>>
>>          /* Check if remote finished initialization before us */
>>          if (dmux->pc_state) {
>> @@ -845,6 +948,7 @@ static int bam_dmux_probe(struct platform_device *pdev)
>>   err_disable_pm:
>>          pm_runtime_disable(dev);
>>          pm_runtime_dont_use_autosuspend(dev);
>> +       bam_dmux_reclaim_dma_pool(dmux);
>>          return ret;
>>   }
>>
>> @@ -879,6 +983,12 @@ static void bam_dmux_remove(struct platform_device *pdev)
>>          disable_irq(dmux->pc_irq);
>>          bam_dmux_power_off(dmux);
>>          bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
>> +
>> +       /* The remote side may still access the pool if it holds its power vote */
>> +       if (!dmux->pc_state)
>> +               bam_dmux_reclaim_dma_pool(dmux);
>> +       else if (dmux->dma_pool_perms)
>> +               dev_warn(dev, "Leaving restricted DMA pool assigned to remote\n");
>>   }
>>
>>   static const struct dev_pm_ops bam_dmux_pm_ops = {
>>
>> --
>> 2.34.1
>>
