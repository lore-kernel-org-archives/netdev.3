Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B2F3ACA75
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789811685; cv=none; b=St4AYpqy6kKZsCVAPq/Ttx8GC6M1I1YFrO+iWXRWVHBY8JvNUh3oTEKRDGGLAAhszmAyabIqkBhMsxCN889U/BlLvoIU/8qs++dtvg0i88ziMVq/TYBnjUQeeYLIGuZJB69GTloIP2RfvmYiRn8h05ZhIK/pFSe00vJ5w39zcuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789811685; c=relaxed/simple;
	bh=z/qQL0CPK3fkdmYWyHcS9nuOhJqJmsrxtpGJPsiPrxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uT/Rb0vpn+8EJs6nZSbtRojlzi7/XjiHHGTIzHwTgq9IGPJvEibWs2gdcoSaL4wYSEAjd77fG6Gk7SRbnAgZHHJ/AQwrQsCDZF92NC9b5ZlYptFc0xJ/A9fK/oG/uanXXVw+miH4xlQQYhxzDPegDggzrmvb/1HK/8qyuRQvvjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kHHgbV8X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U5IUZO7f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kHHgbV8X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U5IUZO7f"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J6dw8K3101448
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 09:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	53ePU/EqYBKQnQJgkF/MFGCIZg32zoI4VYtyTC3M5fU=; b=kHHgbV8XW4BLQhwR
	zhwf8R2pzBNi0nMPRSWluKnWhOR5SaFGHIaE3NhNxRofWIsnIcqj/efXEKyUwlZu
	9fGHhf/1rih7ZrN4SjHVVntrX+tnDM/FLVorSEDFA05otRPX0kRz5G4GB/n++5W5
	G2liyMqDBG5BPG1aiOQyrOYi/cjlYmDnXwpfP/RjGVHtBi0HncuwWTLYTgsS9SGJ
	XhgxwqRp33OfjqFQ/CTb8Ua+vokjppBzyZtDJL0IC346edBPHiPhTEXGCwIoaSmB
	wkPzOlpqnTGhNMWINX4pH8yuYT6W1PJCV8p+3aOmpDw3gs7yhqbfE8TAYD1EYyOM
	Oei6Yg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsjm30mny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 09:54:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e25a5f6e8so3031015a91.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 02:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789811676; x=1790416476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=53ePU/EqYBKQnQJgkF/MFGCIZg32zoI4VYtyTC3M5fU=;
        b=U5IUZO7fTE1AxCC9rKBOG3furOaEcWddXHITeFe2ayPr9JANW4qEuoOoGy6vQP0Ncs
         4bQIj5QPDgYymUpsUF8xbRuc7GYh2FzLqxady7iMQcHXQg0836fptsZPyb7Y4PDf0FTW
         rp/7m3bvf/6D+oqMk0GCvGSTIlg0pPjlUBUeQ/sTE8cDxB6n3wme1PTa9uA1GhVItJCP
         niuoklfLi59IJPa9rbZEK0SLK5F/nxupw4NKW5+lyeB6WBMcxUaCxCGg/9k72P27z5yN
         jlG/dXaY558UJFKyXtG01iOBUUQLNQymUtLa0I1gK9lBTM5ULf/ZCA271UqM83pvOBp/
         sHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789811676; x=1790416476;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=53ePU/EqYBKQnQJgkF/MFGCIZg32zoI4VYtyTC3M5fU=;
        b=Kwa5WAX8oe5db6VoD5LIrV7Tsf/mUJL3QmKx/JccTmRBHtNNPoM90NMoTk2glgFGYq
         lF0eLfnx+V95+APSG7+1XLKFQsGGPR1BTv8W891HToJMwVs9jKsZQrlVNO+rX0zOhfii
         JYMqCXOMGnSykzLK6UwFo+E3AUdy2DuKPbns0kR6u4NXTbtz9A+JZl0Kj6zL1q0DKH1g
         x513I6jFWewRADwF8AMYbQ5ddH7+079wPDA464JxocNKia1yURLCrEyo9sq5BV2Cb1Hf
         xIJfKEI5f4el6A5X7GV1Ui37gqfHE08upnKKXIXEvaiZiUDA3LXeUnSDvTXPQO6AfldZ
         egEw==
X-Forwarded-Encrypted: i=1; AKwUvByogc04CZ8URQ/gmr8FAP0AcrgZ7LrsWg4864nML7AzNxqZ00AXgPBb8gAbeVUj9eJd2JuFb+c=@vger.kernel.org
X-Gm-Message-State: AFuF++nJ5Rrph0ZWYu8TqGTPfB+EusBXZQOoBbKstiWwxxUUx/6SkSIi
	T4tbf+/AsT9FGMcBovUiUobd1RvJSMLWGA73bcaUHK/VJUndhLohyDiibNu4uL8H7qnsiAXRy8Q
	dQHtx/jQv2l+5xaMRt5Hng75pLCou5hI5MdFsTzsSdlU86PQxajgvkZ9agSI=
X-Gm-Gg: AYBFou2xzpS02hYdlnEuS/wdrPa8L0oj0/bDLVo4s1Y0z8btCS+OUIXN7W27ptcwNoK
	StmJeIGNaXBWVfO/ZvUCDG896dW3hDrwU3YGbz59hQPsogojAAgwIqBbr41enhPMOYDsA2g6wZx
	/wmIZFQkYUY9AwuICAgpA5l7PSk2X5GYVMavdr6AyUoXyS2Dg5e5xq3NwoZ2KqE5QqKwqpWyObD
	ec4UBSuR1/TkAfy9hjbia8PItr6k/Lrq1uqTwzGliSr/uzfPxZqXFTdaCB2+rQ01pWzig/rITdp
	a7Ub6EhJYLbf5HvxSTMeXKx409l1XBNcOHGd+9bVQ/ntnkIn2p0LpbtWclAdULgrUTzPEssKxTk
	Cp1PylN3jbS4Ks4a9FndTPImGjf5vviOfxYN+
X-Received: by 2002:a17:90a:bd6:b0:39e:6a81:5a97 with SMTP id 98e67ed59e1d1-39e6a815e70mr2667643a91.43.1789811675942;
        Sat, 19 Sep 2026 02:54:35 -0700 (PDT)
X-Received: by 2002:a17:90a:bd6:b0:39e:6a81:5a97 with SMTP id 98e67ed59e1d1-39e6a815e70mr2667631a91.43.1789811675424;
        Sat, 19 Sep 2026 02:54:35 -0700 (PDT)
Received: from [192.168.0.116] ([124.123.146.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55d45a6sm4526951c88.9.2026.09.19.02.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 02:54:34 -0700 (PDT)
Message-ID: <697a7c7b-5bf7-4279-898d-a8310f5a0a64@oss.qualcomm.com>
Date: Sat, 19 Sep 2026 15:24:26 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: wwan: qcom_bam_dmux: Alloc RX buffers as a
 single coherent block
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>,
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
        Johannes Berg <johannes@sipsolutions.net>,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.lew@oss.qualcomm.com,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
References: <20260714-qcom-bam-dmux-vmid-ext-v1-0-3f29da7cca76@oss.qualcomm.com>
 <20260714-qcom-bam-dmux-vmid-ext-v1-2-3f29da7cca76@oss.qualcomm.com>
 <alXm0rp3NK62G3-3@linaro.org>
 <c8417ff3-db92-446a-acf8-8c73c83b85de@oss.qualcomm.com>
 <amMxkrW3mu48HIOr@linaro.org>
 <63bae39b-1256-4e19-a9de-840d8752ec69@oss.qualcomm.com>
 <an27PVxkCpD09xSR@linaro.org>
Content-Language: en-US
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
In-Reply-To: <an27PVxkCpD09xSR@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UEa9ayyImELD0x4bXPbvNLJH63vSlelD
X-Proofpoint-GUID: UEa9ayyImELD0x4bXPbvNLJH63vSlelD
X-Authority-Analysis: v=2.4 cv=DtfDa2/+ c=1 sm=1 tr=0 ts=6aae5bdc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=K/78aEDNEn2Q/Yuv7mVN5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=07d9gI8wAAAA:8 a=EUspDBNiAAAA:8 a=vzY3hVqx5U8Bfi6rXLEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDE0MSBTYWx0ZWRfXxjO3d62jJpP8
 z5IKcGTRAi5oHqw7gVs4badxNIxWoogtdn2yLPQTwBOicD1SCg5jKIBIPXLSvB2k37XF5yrI26X
 HUkv7l0lCj2hlGuLUqLtJ5IdFFcCuE0F57u3zmCU7FcuyRmQRTR8deYyJuVVqRXJBeaVAypoDay
 VQVG8wxqNayy9jjph7ELmf7BWA9pyAq6mJQlxIudESwvwHAy5bcdHJLpgoyLXZ/alUV/mX6TfeX
 vLL745k0rMrRgOFLj6sj3he29sTh75LC/66J42K799uqJiW+6lVTmz0iOyKckNOLZxtggHp3D/B
 KWPYcnX7UolAVn94q9E+A6lqlK6z4WfACgarJDXFL/1S+nTvhmprx2bEr5BdB3DJO7pzlqnlqHE
 Lh55kAad2c/1sXk8iOhHvqYmD7wtLDPJsF8qYgNrogISOXdqlt93DJAxjjFq/VtdoB5mAgABhKb
 aJ0nyIZlMxlmqfO45Nw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDE0MSBTYWx0ZWRfX1j6rkpeoTglB
 Kdxc8rcz+fdSA9SaVtW5W+fmnw9fe1MNDo4RrOXqGeT51YaZkDjOh1X7dnF4cxLKvL9EMOTmNWa
 DhwVa2wWHBZP5vihWZokFkWSqkVvgrM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190141


On 13-08-2026 06:10 pm, Stephan Gerhold wrote:
> On Thu, Aug 13, 2026 at 02:35:01PM +0530, Vishnu Santhosh wrote:
>> On 24-07-2026 03:04 pm, Stephan Gerhold wrote:
>>> On Fri, Jul 24, 2026 at 10:16:31AM +0530, Vishnu Santhosh wrote:
>>>> On 14-07-2026 01:05 pm, Stephan Gerhold wrote:
>>>>> On Tue, Jul 14, 2026 at 11:02:32AM +0530, Vishnu Santhosh wrote:
>>>>>> On Qualcomm SoCs where the modem (e.g. the mDSP on Shikra, VMID 43 /
>>>>>> NAV) is the AXI master for BAM-DMUX RX transfers and the XPU enforces
>>>>>> per-region access control, each individually DMA-mapped RX buffer
>>>>>> requires its own XPU resource group (RG). With ~16 RGs available, the
>>>>>> 32 per-buffer dma_map_single() calls exhaust the table and the first
>>>>>> inbound transfer faults with an XPU violation.
>>>>>>
>>>>>> BAM-DMUX is a singleton (exactly one instance per SoC), so the
>>>>>> destination VMID does not need to be a DT property; it is looked up
>>>>>> from the compatible string's match data instead. Add struct
>>>>>> bam_dmux_data with a single vmid field, and a shikra_data instance
>>>>>> hardcoding QCOM_SCM_VMID_NAV for qcom,shikra-bam-dmux.
>>>>>>
>>>>>> When match data is present, allocate all BAM_DMUX_NUM_SKB RX buffers as
>>>>>> a single contiguous dma_alloc_coherent() block and SCM-assign that
>>>>>> block to HLOS plus the VMID once at probe. This reduces RG consumption
>>>>>> from 32 to 1. The block is never reclaimed across a modem power cycle
>>>>>> (bam_dmux_power_off() does not touch it), so the probe-time assignment
>>>>>> covers every subsequent restart without re-assigning or reclaiming. It
>>>>>> is reclaimed to HLOS only once, at remove or on a probe error, and if
>>>>>> that reclaim fails it is leaked rather than returned to the page
>>>>>> allocator.
>>>>>>
>>>>>> Each rx_skbs[] slot is pre-assigned its virtual and DMA address from
>>>>>> the block, so no per-buffer mapping is needed at power-on. Because the
>>>>>> coherent block is not page-backed, received payload is copied into a
>>>>>> regular netdev skb before handoff to the network stack; this is an
>>>>>> unavoidable extra copy on the XPU-enforced RX path.
>>>>>>
>>>>>> Platforms without match data are unaffected: rx_virt stays NULL, no
>>>>>> coherent memory is allocated, and the per-buffer dma_map_single() path
>>>>>> is unchanged.
>>>>>>
>>>>>> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>>>>>> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
>>>>>> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
>>>>> So how do you handle TX buffers? Right now, they are just passed on from
>>>>> the net subsystem. There can be up to 32 TX buffers in progress as well.
>>>>>
>>>>> Overall, I have mixed feelings about this patch. It looks reasonably
>>>>> simple, but fundamentally I don't understand why we need to go back to
>>>>> the old days of implementing protection using a highly limited MPU (in
>>>>> your case: the xPU).
>>>>>
>>>>> Why does the setup of BAM-DMUX differ e.g. from the setup for the crypto
>>>>> engine? Crypto is also using bam-dma, but it avoids this inflexibility
>>>>> by making use of the &apps_smmu. Is BAM-DMUX not covered by the SMMU? Or
>>>>> did you just decide to bypass the SMMU in this case? (If so: Why?)
>>>> I checked with secure systems team on this. Crypto BAM is
>>>> behind apps_smmu, so protection is enforced through the SMMU's Stage-2
>>>> page tables.
>>>>
>>>> A2 BAM (used by BAM-DMUX) is present in secure domain and does not
>>>> support Stage-2 translation on this SoC, and there is no IOMMU domain
>>>> that can be attached to it. The only protection mechanism available is
>>>> the xPU.
>>>>
>>> Thanks for investigating this!
>>>
>>> So is this a hardware limitation or something you could change with a
>>> firmware update? Could you move the A2 BAM out of the secure domain and
>>> protect it via the IOMMU instead of the xPU mechanism? The other modern
>>> platforms with IPA do not have this limitation, they can use the IOMMU
>>> for this.
>>>
>>> We can try to support the xPU protection mechanism in the BAM-DMUX
>>> driver, but it's pretty bad from a performance and memory usage point of
>>> view if you need to copy buffers around multiple times. So if you have
>>> some way to change this in the firmware (and there is still time to do
>>> so before production boards ship), I would strongly recommend to
>>> investigate that.
>>>
>> Based on what we confirmed with the Secure Systems team, this is a limitation
>> of the current Shikra platform rather than something that can be addressed
>> through a firmware-only update.
>>
>> The A2 BAM used by BAM-DMUX is not connected to an SMMU/IOMMU domain on Shikra,
>> which means Stage-2 translation is not available for this path. As a result,
>> it is not possible to move this path behind an IOMMU.
>>
>> Modern IPA-based platforms differ because their data paths are physically routed
>> through SMMU interfaces and therefore do not rely on VMID/xPU ownership assignment
>> for this type of access control. On Shikra, the A2 BAM path is protected using the
>> xPU3 VM-based access-control model, where DDR memory access is restricted and
>> granted through the request-based Hypervisor VM assignment framework. In contrast,
>> older targets relied on the earlier xPU2 resource-sharing model, in which modem
>> access did not require this type of explicit VM ownership configuration. This
>> architectural difference explains why the issue does not occur on those older platforms.
>>
>> So, for this path on Shikra, SCM-driven VMID assignment remains the only practical solution.
>>
> Ok, thanks for looking into this further.
>
> Can you please try the following as alternative for the implementation?
>
> 1. Make sure that you have CONFIG_DMA_RESTRICTED_POOL=y.
> 2. Define a restricted DMA pool for BAM-DMUX, e.g.:
>
> &{/reserved-memory} {
>          bam_dmux_pool: restricted-dma-pool {
> 	    compatible = "restricted-dma-pool";
>              size = <0x40000>;	/* 32*2K*2 = 128K minimum, but 256K might be safer */
> 	    alignment = <...>;	/* Check xPU alignment requirements */
>          };
> };
>
> 3. Assign to BAM-DMUX together with the qcom,vmid:
>
> &bam_dmux {
> 	memory-region = <&bam_dmux_pool>;
> 	qcom,vmid = <QCOM_SCM_VMID_NAV>;
> };
>
> 4. Extend qcom_bam_dmux.c to look up the DMA pool address and make it
>     accessible using SCM: Call of_reserved_mem_lookup() to get the
>     region, then invoke qcom_scm_assign_mem() with that.
>
> 5. Keep RX/TX DMA code paths in qcom_bam_dmux.c unchanged.
>
> 6. When testing, make sure the kernel log contains
>     "Reserved memory: created restricted DMA pool at %pa, size %ld MiB"
>
> 7. Add memory-region and qcom,vmid as optional in dt-bindings.
>     Add dependency: if qcom,vmid is specified, memory-region must be
>     specified.
>
> In a quick test (without the VMID stuff) this worked quite well for me,
> SWIOTLB should handle the copying behind the scenes without further
> changes to the qcom_bam_dmux driver.
>
> I would prefer that over complicating the driver with two separate ways
> of buffer management. AFAICT, the restricted DMA feature is meant for
> this kind of setup where there is no IOMMU but the firmware can still
> restrict memory accesses to a limited amount of regions, see
> https://lwn.net/Articles/841916/ for a short introduction.
>
> Thanks,
> Stephan

Thanks for the detailed steps. I tested this approach on the Qualcomm Shikra
platform, and it works as expected.

With CONFIG_DMA_RESTRICTED_POOL enabled, following the approach, the kernel reports:

software IO TLB: Reserved memory: created restricted DMA pool at 0x00000000fffc0000, size 0 MiB
OF: reserved mem: initialized node restricted-dma-pool, compatible id restricted-dma-pool
OF: reserved mem: 0x00000000fffc0000..0x00000000ffffffff (256 KiB) map non-reusable restricted-dma-pool


The BAM DMA controller also reports:

bam-dma-engine 6044000.dma-controller: assigned reserved memory node restricted-dma-pool

The BAM-DMUX TX/RX DMA paths are working with this configuration. I will update
v2 to use the restricted DMA pool approach as suggested.


Thanks,
Vishnu

