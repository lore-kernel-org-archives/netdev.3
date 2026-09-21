Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931753C1D41
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989205; cv=none; b=H8NrurSMDfm5gNuj87zwBiNR0t80Z6GsYINrg6Q8et5SddA4KWXFXyIXfzsDhcn51WBdAVciS9KRI3fIiOnZ6Ru+ZKvBig4EDtabZlGY5HVfB78vmSmVmLCTh0p/3DuoIkUxvzII4ZgKVzPVrHPk1L2vrMQMGTRch0f1AIXIe9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989205; c=relaxed/simple;
	bh=fXKRY4luOBuC26q8snPUvLLSu+eYRZ3ytofU8Qyhzl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mgotk7FVFgJ/wQiClAQe5A9JMWC6MSUCps6RhTAOAbYzlJgVNCPy6MXNji62HAyWIoGp//e/H4HTyK/cWHSOTMdd2ueCukzo/mEhjrAOznLpEpxjfcgHS9viZVNFWtni2cblogi71p44Pr3z1SNv3vRArCigNkIpqKYJWzIQqcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DY9DqFjs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M+3HteLS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DY9DqFjs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M+3HteLS"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAe1jS1563503
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xt7xwZX63g3WHcGt+rjhKDljCbJzR9b3dOXuJ/miyXI=; b=DY9DqFjsMXACE8Ta
	1C34c1k6wlJIyArfEXJe095nHYEIJ8FJi6y6Wckt9oPKe4W7j2J2+pqeZC7DmO4A
	HW9MoKlD/FAU0HjTKwNqLZDBo5R1zl9LK467ThMB6c/pRBwYzVkyXlsdD0D0KDmc
	HQlj7+ERfrCMfqNZDV8Bim6zzF1jr625ytSsNe7lbHi47o3F8yq2qESp3oU5sruf
	qNFrPNhbX1hLbhekK2Uz4LO/xCKwwjZp77V13J++oFZBx161IHefVO4E0c2KeV9L
	Es0qduuDwyUCaWEmJaNzwl8MM4E+0BszMf21+pRDKWUuiuGD/vBo1ZLLWD3LfCxi
	315GTw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtysw0yxm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:13:21 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so4394088a91.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 04:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789989201; x=1790594001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xt7xwZX63g3WHcGt+rjhKDljCbJzR9b3dOXuJ/miyXI=;
        b=M+3HteLSOnxGdKFqhlXLTFXC33QdpuKlIZOyYYTiy3DSOkGa+kK8z1DUPxqC4+MTNG
         hBtLqxmguhVH2NzgO094B0RGuvUugyGI28KuuNWMeiENtj7ES7xoGyihJZWU0yqR76hA
         j6cSdoUw4Ow45HXe4xcAo5KnFokTJOt+HCbkejPyJ+PDe/FumXOm0XhLm6xh3VCx8mdQ
         bgan2uFvEtlklaaRBlUScRdgiG3djyG3Y48os1iCzUgojk4ph22YRQ3qO5K7RrY8UUly
         3Y8Qc7ZhUm0ePf1cJsQn6r5GT9laWt7wVeFmyPMdOGc4PXbV4d+bUu9W1eC0egOlPnGB
         HuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789989201; x=1790594001;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xt7xwZX63g3WHcGt+rjhKDljCbJzR9b3dOXuJ/miyXI=;
        b=J8WwIlfsx1d/1e6IcMyAXo5LCFdfWzEW/o9idwMhga656G2C7tzyCp090m9FPqhhgb
         t4YhAHRxBTjCKyKKL3v5qtuKijyfhXSDzkwFgVhdlELYFTJ2qIzn1NISKRkIRsNd0BDQ
         r94kHxDIknGPuGR6ZQiY42Q7zFTeQHdgkxt4zh6GbR2YJw7Cvu+5OmcAz6A+WZcjSnLa
         7snT/4ktHNyWDCvhSv8dmiGGLa59zTnZtLcXm4zp82+4x7Iiga675ALlppiMAaUZX+9Q
         RLNwdbnLeR4BzFLheyxDOBpb1l8cSd0T5y3/WjwCuqfZaGUP/KQuu0u0nJn/kv2JMH2i
         RjRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLK9LrnVLYSrBuvD9rZmY5e/uXSHUCCw/SRNRuxkUsYcZGhpn4VLMilcix0RBknJlzyyeN6KQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nVPxE7SpNKR2xvSUVmwwZz3+SEApanjzqoNihUWfikIt//kt9w
	SEq47oNmIVCAUJoWzTCArXGOnGfdrUmJZHET+L99tOIZWgVMXanT6Xh5Ub+F37RxYGBHCWTh338
	q5u4Gvw5sHn9X3I7R6wciGQv38nO3DZsIdGR8PG08m8EnopinbWz0e1mvr+I=
X-Gm-Gg: AYBFou3TXDKCARvsLYWyQYmTvvbswWQ+rpJzVb6uweoksQIwpebf56UWoVfRjcLMA8B
	BW+Mp8Vdc2lWq/nMnzn2ykdLaLRCYFCSR5tT/mkxoDqJ9opUUkRPM42LbodNedgoKfCA0Wq5t2n
	fF1rsTtDCBrlwgnn27n3/+cqxFwYcp2KJf+N3n6NDw8fA8XuPGhXaiGV5asKhR6Q8pCbSa02TFH
	k63jrf/nGK/o3+KsotuXQfhtOstGVa55L1uB8fgv96fQlSM39uoeBU7Yhy+lxYyrWiuIlUoG/fd
	hEexnP9BQNn4o6uv+D4uiY2RQbo6XKA28lc5zYZymDy9yg4N/Xu+XDnBkoQjmuiD+UQdMuwEwzs
	W2oEXPPNVaDRUI+3Voi+TcJE47UYCNt3mSQ==
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:6572 with SMTP id 98e67ed59e1d1-39e6c6a673fmr8953354a91.53.1789989200808;
        Mon, 21 Sep 2026 04:13:20 -0700 (PDT)
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:6572 with SMTP id 98e67ed59e1d1-39e6c6a673fmr8953328a91.53.1789989200277;
        Mon, 21 Sep 2026 04:13:20 -0700 (PDT)
Received: from [10.218.31.237] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331433besm30494586eec.16.2026.09.21.04.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 04:13:19 -0700 (PDT)
Message-ID: <c9e6cb39-4b36-48df-80a2-84111cdc6e61@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:43:12 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: wwan: qcom_bam_dmux: Assign
 restricted DMA pool to remote processor
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
References: <20260920-qcom-bam-dmux-vmid-ext-v2-0-ef5ca2178378@oss.qualcomm.com>
 <20260920-qcom-bam-dmux-vmid-ext-v2-2-ef5ca2178378@oss.qualcomm.com>
 <CAFEp6-1zFOnEweiw5apGOc8zZkGXmAAVjFF0JpxhB8DBgakkSQ@mail.gmail.com>
Content-Language: en-US
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
In-Reply-To: <CAFEp6-1zFOnEweiw5apGOc8zZkGXmAAVjFF0JpxhB8DBgakkSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2MSBTYWx0ZWRfX3rbuHvT5hBrJ
 wAQgKDS4Z15quZ8ZHc2bX7j7dF5I/BJLMU1SBvPdof8GHr5PnD9P7QB1JoE2/A1W1VM98dPLWam
 j3jjaB42A4PAD3iT8BV8YHBpZx+mljmH67KdDnVsWCIVIYGy8wNE/uG5yZT8rMZN9FAh4LAdNE5
 /drZn1A47a2X+f3oJ/KPrm9XuPbnzJgZ1cueBDyvUGeDdDlUuwuqTGlDGKitO+x0ka+RFJOs2Zp
 4yg7U092AXj6FnORAUNn3HJ/SB/u23QP9QPq4LHVIdehb37zut7PpOj6FTtA7AqxY83pBSUdpIa
 yk1yUOBJ8Cl29OG/1atnAJD0PCvNt7OipULUs/nP50TiDUs+T2uFfuzyrGxpjju6hSNzfX0ZAY1
 LKsmGS9p+NIeFDHHyrT0u6A9eCMqe+VKvC0YE5ZlWHuSIUgQonyQqYng6jSUmEkyJn7qDL2aOdZ
 FPSzArSsXIAUXssuCTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2MSBTYWx0ZWRfX6+zIkTMF1X/u
 lbCA/xlPTbgfxkKbt8316izzu+cQ7BhO5BIOtIipidL6mPN8O0v+6DpN/qsry8B2cN79hBUNyXq
 JQ+be1PwKa08dEc9YFPoiFvlxpHWb3E=
X-Proofpoint-ORIG-GUID: -_HijPne5RJPjpbd-df0Ge_1nmyKuied
X-Proofpoint-GUID: -_HijPne5RJPjpbd-df0Ge_1nmyKuied
X-Authority-Analysis: v=2.4 cv=W7etxhWk c=1 sm=1 tr=0 ts=6ab11151 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=dqzE7sNEaOT4AOC7MkoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210161

Hi Loic,

On 21-09-2026 01:29 pm, Loic Poulain wrote:
> Hi Vishnu,
>
> On Sun, Sep 20, 2026 at 5:03 AM Vishnu Santhosh
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
>> released during remove or probe error cleanup.
>>
>> Fail probing when restricted DMA pool support is unavailable, when the
>> VMID property is malformed, or when memory-region does not reference a
>> restricted DMA pool.
>>
>> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
>> ---
>>   drivers/net/wwan/Kconfig         |  1 +
>>   drivers/net/wwan/qcom_bam_dmux.c | 95 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 96 insertions(+)
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
>> index cc6ace8d64371eb8d00c638a39b234ee540b83c9..c81e668d4e961a645f7e2d823c3136845f086b08 100644
>> --- a/drivers/net/wwan/qcom_bam_dmux.c
>> +++ b/drivers/net/wwan/qcom_bam_dmux.c
>> @@ -9,10 +9,12 @@
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
>> @@ -75,6 +77,9 @@ struct bam_dmux {
>>          struct completion pc_ack_completion;
>>
>>          struct dma_chan *rx, *tx;
>> +       phys_addr_t dma_pool_base;
>> +       size_t dma_pool_size;
>> +       u64 dma_pool_perms;
>>          struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
>>          struct bam_dmux_skb_dma tx_skbs[BAM_DMUX_NUM_SKB];
>>          spinlock_t tx_lock; /* Protect tx_skbs, tx_next_skb */
>> @@ -762,6 +767,90 @@ static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
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
>> +
>> +       rmem = of_reserved_mem_lookup(rmem_np);
>> +       of_node_put(rmem_np);
>> +       if (!rmem)
>> +               return dev_err_probe(dev, -EINVAL,
>> +                                            "Failed to look up restricted DMA pool\n");
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
> This function appears to address a generic Qualcomm platform issue. Is
> the VMID allocation pattern and pool management specific to this
> hardware/driver, or could this functionality be factored out into a
> common helper and reused by other drivers or subsystems?

The generic memory-assignment operation is already provided by
qcom_scm_assign_mem(). The remaining sequencing is tied to the
BAM-DMUX lifecycle: the pool must be assigned before requesting the DMA
channels, because it also backs the BAM DMA descriptor FIFOs, and it can
be reclaimed only after the channels and BAM-DMUX buffer mappings have
been released.

Other qcom_scm_assign_mem() users have different memory ownership,
permission sets, VMID counts and lifetimes. Consequently, the assignment
and reclaim sequencing was kept local to BAM-DMUX rather than placing
that driver-specific policy in a common helper.


Thanks,
Vishnu

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
>>   static int bam_dmux_probe(struct platform_device *pdev)
>>   {
>>          struct device *dev = &pdev->dev;
>> @@ -796,6 +885,10 @@ static int bam_dmux_probe(struct platform_device *pdev)
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
>> @@ -845,6 +938,7 @@ static int bam_dmux_probe(struct platform_device *pdev)
>>   err_disable_pm:
>>          pm_runtime_disable(dev);
>>          pm_runtime_dont_use_autosuspend(dev);
>> +       bam_dmux_reclaim_dma_pool(dmux);
>>          return ret;
>>   }
>>
>> @@ -879,6 +973,7 @@ static void bam_dmux_remove(struct platform_device *pdev)
>>          disable_irq(dmux->pc_irq);
>>          bam_dmux_power_off(dmux);
>>          bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
>> +       bam_dmux_reclaim_dma_pool(dmux);
>>   }
>>
>>   static const struct dev_pm_ops bam_dmux_pm_ops = {
>>
>> --
>> 2.34.1
>>
