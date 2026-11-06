Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939802;
	b=AHADYc/mmQTwXa78Ks/5kLpFlmwa7WRIaXaPBl/Qk+ER+FVRHlvVEQdQ3Z83vhwNQryE
	 Y891LmiSdVSt84fEOzgcsz4E6Qa5swDzPd3HjJTxy1wh56UDBu/IYaaQt9gfQpKecWhX1
	 +eOcLUEoijgO40lqyi6SC2X1x3TYWLJkJzlDE5scv0PeYA8kc4lAUXFPdAekugXmW6v14
	 LNCUlZUCn2iMHtFOxEnjU4YxLWawCsg0vMIaiDpSfJK2niamnhipiQ2pldXWw1HI2hHNu
	 a7qB9ewss5kn0z+6XwdrAfX/im8FxQUcf8sUArC6VshkMUr0dvtFlpfXCy057PLH1kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939802;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Cyl3IszRXftb9Zsaj929sRYbACZ+gYXwE/XyklBs430=;
	b=OB8pla+SDoJoHa9bY+OxQtkJ6WWcpPXM9h0mO4nzButfdCh8g2FYrvTROLIYUf65qcg+
	 x1e4FZy9pVF6x5TAT4qAmOa+pS4t79iOegRLH7HWVkFy7BoAAzUweOVfXjEr1IfImdy3v
	 hc7lGRVYKX4mJGN67b5C9qXMXgObiESsprpp6CHRMGoHQcdXyMtis/fbjIsNqXAEmPe8X
	 5NAv2swr38NIvRnJRSitZcSrJMJ7kR+CMsye6WtYfcgmy85sqdIo563+azk2uI0ONM++F
	 xgpAeTvNCMWiFNZmqj2icCBB2xWdnhj+9bBhQ5AzTWfTP7yeJeYELL/o+ycutdD2H2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Aau6bUqQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PRh6Mjzx;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD311606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 04:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD311606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Aau6bUqQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PRh6Mjzx
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A63xxA32264786
	for <netdev@vger.kernel.org>; Fri, 6 Nov 2026 04:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cyl3IszRXftb9Zsaj929sRYbACZ+gYXwE/XyklBs430=; b=Aau6bUqQO6KZlczx
	iiiCouk/R1QQo3vRKygvOLQXrnyXEG8NneCvUy7QrQN10usDDVSGgLZoNbYkv2Zl
	MpCf93hx+Vm0eCtm/t0b0s2p4b9kU4k2XXizk9E1iv9pYCHm8SkV36Sm3qm/8AKG
	P2L9zidBwczr0yec+ntcp+QRI874naqHrt52fkPly4H8y75NjTwMb+H8Q19wNK5S
	yLWVhSvbOhLz8yHEr4MTIKVtUCxVb3jVRv7XmJ3wJDS7cUc8I7VEDaRYuPtD26gV
	TkTe9OokIVTYb2MudM0Sb6g0zSTisKyiaeME55VVTcPhuhWUfdOpc4rO9psgw741
	ZVcGKA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9gvj4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 04:36:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso469686eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 20:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793939800; x=1794544600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cyl3IszRXftb9Zsaj929sRYbACZ+gYXwE/XyklBs430=;
        b=PRh6MjzxXpSWMI/DFStiJ3ins5vCqFQqN1NKDX3K4XfXwcX/qtG+YX56waMUZNApww
         XlJm31A24CBIHF5px5iFOLAX7ApdXiOQFP1ECSYeZVG+asS7oF62cpOzl39kKjCZGl1F
         vSFAIY0mgGqHHLDT9G33Qo3rx1wJi0gXPQLhKtB1IbmXA4PJWsOudjoJXgiDszPRxObC
         wKjjevRkKnp7Ao1rw8m58/ZrH5bJdykTmNvD6qbd8BmqGEz6+8teYfFmkPV4PTDxOPPo
         XbSG9U9euviWTwFfOlzmkjtJzwj5sfSKuRy1467gyiiqSxL1mHo+Iolri6CNz2/rJakv
         nXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939800; x=1794544600;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cyl3IszRXftb9Zsaj929sRYbACZ+gYXwE/XyklBs430=;
        b=f1yO0zcHVdvoEagxHw9XPzUVzxHyIXC58QLNv0NWZzOoSYrOL46nsPRAC8oEg7W/4O
         aWKDCvJvmV2GiQ4fMVgF4RnIClU0y0rEiWJAOYrNUB8no6L8LiN1GzpjVVSO0tPaSz41
         TGjWQCIiEpi1g7M8KuEfaaZye8fXmn+wbVsw+DItXYt+d1DV6xKeaHI/ZV/N9jORmvau
         unyrY837touYuYcLcusEW4cow0oH3NZWiyFYyIVNqnzT5JujyAKBuEshQRZx9XrQH5d9
         A06mvG76NapJa7KxptBITy1sI3GWck9QIkD7BS+Qea/KicGT/Dzg1lqEc7LgOUDcGT0/
         AOFw==
X-Forwarded-Encrypted: i=1; AL+hErEHy1hLnZhk5JKp2cHH2b0+wtpgi39WuuSZ0hffU2+FK4YU4TjgQIoR1tnXCOYd6sR3pEGDIWc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TifzuI/Jw2Jv509TcoIb7r7PJzTNCxIuUPKrDEUZLNiT3AIKv
	XzKAL0ibxPqPljsbNw/c9euVB8iBT282GqMPMt8oZgf+8tpVQ983XQ7ea5BNHrPTTX1vbUjfkyw
	e2Brie6S2h/VLF1RjzY9dIMBmkwth6hbOcb3jQM1h5s1F9XQ3izf2UT/7NWM=
X-Gm-Gg: AYBFou0sSqoozz5WYaNkqSi+PPgQe1w5XlhWO6/W9vL8uLuFdbNFJEM5a5YOCCwCpOf
	k+2fIdqlzALLrmgtnRuW/Y5KYmTX0/RnYpVK5NPG6Th501XAeydsp/6KGpzt840ITptE38MyeVp
	RsYPLDAeIGuFto9zbBzvzSJuPN0mkJV4WzwhWo+dpoDdmPS85J49AoCLnDD9GVNj5xtM74ToMua
	6ON+TzCDXofoGOdZqfqYBUVksSN6yeW1BlEuXvP3hZ/GuKcQ7FnONf0k/4vqWAFsllCysSrpxq0
	QMfhIrFaaB8G/od7VlNd6C809gFtZd7PRJ6Z4fcT81T0Ck/UBmOOtcClrsgbKxKrNw1gNYg1I3g
	PF0G7xmvtuRUE/OS50ntjr37iwg6uFNIwVPf2JxS2ewvLFAkOT3XnFy9H4YZj7z26iF4cCprUyn
	0mskFYyx2W
X-Received: by 2002:a05:7300:dd49:b0:36f:551:2bd5 with SMTP id 5a478bee46e88-36f7691ac12mr1777947eec.32.1793939800064;
        Thu, 05 Nov 2026 20:36:40 -0800 (PST)
X-Received: by 2002:a05:7300:dd49:b0:36f:551:2bd5 with SMTP id 5a478bee46e88-36f7691ac12mr1777901eec.32.1793939799236;
        Thu, 05 Nov 2026 20:36:39 -0800 (PST)
Received: from [192.168.0.116] ([124.123.146.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fc92fasm2869344eec.19.2026.11.05.20.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 20:36:38 -0800 (PST)
Message-ID: <187f3c63-5550-4a42-892e-ea660247edc9@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 10:06:32 +0530
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
Subject: Re: [PATCH net-next v5 2/2] net: wwan: qcom_bam_dmux: Assign
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
References: <20261105-qcom-bam-dmux-vmid-ext-v5-0-5c7903385b4b@oss.qualcomm.com>
 <20261105-qcom-bam-dmux-vmid-ext-v5-2-5c7903385b4b@oss.qualcomm.com>
 <CAFEp6-3rt8yvTd-mMA6y5SqmzmF0zvrvO_Dc_w7G3QSv7oZWng@mail.gmail.com>
Content-Language: en-US
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
In-Reply-To: <CAFEp6-3rt8yvTd-mMA6y5SqmzmF0zvrvO_Dc_w7G3QSv7oZWng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UvZd1sVXh4U_QGC26Va3vtsy-w2-VcWp
X-Proofpoint-GUID: UvZd1sVXh4U_QGC26Va3vtsy-w2-VcWp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAxOCBTYWx0ZWRfX/nXdzVYZ0uQ7
 ea04RRdGCRN/XjdTvP+CY5JmKQrteUijoiJpTNXbrZ7y97fG0wRL9P8Kxg5xE1ROpjU4JljnIdq
 JZ1lkV8l+0ByYhmAU0NbDDAWpHjTpWI=
X-Authority-Analysis: v=2.4 cv=XvNvqlF9 c=1 sm=1 tr=0 ts=6aed5958 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=K/78aEDNEn2Q/Yuv7mVN5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=fKMpTyM1RLJrecArqiYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAxOCBTYWx0ZWRfX99RXlFj9SQdV
 a+oSLmb0I+fHMvwI26vmT+uhfpM/9UfKMMFA0SRGX+lfAbttjNPAJYFa7ar2KPfT5INxdo6lPWu
 rj7KqzPrZy0+wFVEi3HIBoZ/DM9ZTKjBmjurwpPKv6PI2bOhYqW4briSvUYKdFxfcGsQYdNKmTu
 3gpgH69Mj3iJj66w6NrcDcbwXqs6HgVMqAUPVGVbaP7ErLvPGzJJSLfjgwZSgXr5l6r9fzkYfq2
 n81DLsthQ6niNjdQjnlKrLAyjbnyy9RWcBxFdb3L3pN/+g1JiP5Zkk3Aga+m4zrRB3FMPZQi020
 GElZxXQPr7U20xw3ysoExncY4ae8p6J/57b5WIZSHOaH/KAmd4q96xhlf03XSiLR4uWupY7c9Aw
 iZkjDBcmC3/kU7p6/dbWWzzm6FJhOs5lawfrtzSvFxB8mUEG8a7zlpZSXLwsXU2mxlJDoQdcM/4
 GCVgQvxuUBQ8xU4SaYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060018


On 05-11-2026 07:51 pm, Loic Poulain wrote:
> On Thu, Nov 5, 2026 at 11:42 AM Vishnu Santhosh
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
>> VMID property is malformed, when memory-region is missing, or when the
>> restricted DMA pool is not attached to the device.
>>
>> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
>> ---
>>   drivers/net/wwan/Kconfig         |   1 +
>>   drivers/net/wwan/qcom_bam_dmux.c | 108 ++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 107 insertions(+), 2 deletions(-)
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
>> index cc6ace8d64371eb8d00c638a39b234ee540b83c9..0e7ad62f8b4e059264e89837f296ee13c0c31c9b 100644
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
>> @@ -762,6 +768,90 @@ static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
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
>> @@ -796,6 +886,10 @@ static int bam_dmux_probe(struct platform_device *pdev)
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
>> @@ -829,8 +923,11 @@ static int bam_dmux_probe(struct platform_device *pdev)
>>
>>          ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
>>                                      &dmux->pc_state);
>> -       if (ret)
>> -               goto err_disable_pm;
>> +       if (ret) {
>> +               /* The PC IRQ may already have powered up the RX path */
>> +               bam_dmux_remove(pdev);
> it's still unclear in the comment and commit message why we can't go
> with err_disable_pm?

Agreed. I plan to update the comment in the next revision to:

/*
  * The PC IRQ is already enabled and may have powered up the RX
  * path. Use the full remove() teardown so that RX DMA is stopped
  * before the pool is reclaimed.
  */

and add to the commit message:

If probe fails after the PC IRQ has been requested, clean up through
bam_dmux_remove(), since the IRQ may already have powered up the RX
path, which must be torn down before the pool is reclaimed.

Does this look fine to you?


Vishnu

>
>> +               return ret;
>> +       }
>>
>>          /* Check if remote finished initialization before us */
>>          if (dmux->pc_state) {
>> @@ -845,6 +942,7 @@ static int bam_dmux_probe(struct platform_device *pdev)
>>   err_disable_pm:
>>          pm_runtime_disable(dev);
>>          pm_runtime_dont_use_autosuspend(dev);
>> +       bam_dmux_reclaim_dma_pool(dmux);
>>          return ret;
>>   }
>>
>> @@ -879,6 +977,12 @@ static void bam_dmux_remove(struct platform_device *pdev)
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
