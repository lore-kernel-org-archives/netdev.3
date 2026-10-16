Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C5C34CFA7
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181362; cv=none; b=brRUQBSEcSGAmdyFuZl660CMydPp03sRtqfU09uygLq81tdjQUB7EWuxOEVqBSblS0kmHyscTtHwD++IosYPXdN6eVviNXdK+aIya1JMChqXaF5jVI35VZ+rZP+KzpddIAFLlbCB/SVSAlj/SG5Qq1K233V7AB+hRfVJMgc3v7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181362; c=relaxed/simple;
	bh=R+MUUhiH4WYWF0K73efftgtgtFL2/f3RlP2IzkYVdDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGTYEo35Zk4OSY1k4TIkDo1NxNAvKh7N8GOtf/orbPDaeMAlCq4SrTCd7VHosPqCnOAVN0DVL0YH1JBUD4gZc4j5brY9CQQvmR00Z95yWws52aQWg9kpAvpEJKuHp5Cj1qgvxhPK6ioy1+ikBog1b46GlixRpzjcim5160CwB1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=okS0H1mW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QnZK6WSM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="okS0H1mW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QnZK6WSM"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GJeAQX103732
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6kYxzNclKEel8BkYYMK0SJ40K5Fwar4dQSxuwGkd2oM=; b=okS0H1mWOwsIqNwO
	Qp7LX0zL3c2SRgJIxWcmHrTbe7VtOfCNHbmWHEjJ2QBxW/WIan8+JYfF+2kyjy/w
	abJzpHSXTt8RV1xI+8J2KBtuY3qgkf9HBU/8vsJuMF3cp1tcsBhHxtF1q7zesJwJ
	Qgt3jPzKNXcKbIezNF4oqeJS09SCWbZeWGMH4D1TdkU4GQ4I+i/Z7XGlvEpJNDND
	UHCabCobpPUVLBr1IhJLCixdmESkwjM8jE7MAH3jmxkmd/itQzODR6qqJh8vV+uu
	oIQ5aSXWQLOkPF5Lw5tdhPU6+k0l2w3THA9+rzPtYZxxaO9c5p0AFNhkMHy1GB8v
	g4amCw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbrw70cqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:09:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-351788121cfso811867eec.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792181359; x=1792786159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6kYxzNclKEel8BkYYMK0SJ40K5Fwar4dQSxuwGkd2oM=;
        b=QnZK6WSMtE2OFpwPzhUiRJ1fvsfXNZlfK9XtXEYDs7gA9gFvyQGDFkJUPpnlEm9PSu
         ndC17HLJFdsqu1v2kK01/C28TpFuc2ypA1Olk++r+qv6UtXqAuhlp4tmX85y4l5k1gEF
         gHln2tx/99XJOOgcjEYzuo2CJdggcb8WF82TiWdXmP0xDCL7zD/88cc+p4lP1sQUdCUq
         ffgDIZt5EhzCNMKQ2NYi+Svst5usLFRytal0hAvAWCEO+NrMulggaomYTCWhH/ZUGT2p
         Pi33ZR+/df5/StagusW6nZsZ8UjdcyPPgZluURbIdxKUt0FxeFD2oMMScivHQuZEaLzR
         pA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792181359; x=1792786159;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6kYxzNclKEel8BkYYMK0SJ40K5Fwar4dQSxuwGkd2oM=;
        b=OFcWyYp0zJjHaxD/vXUMT33WaP6Xphz05oLjCTeD46pYOBL219ELOmJsO8d07G0ruX
         SKUDi1kdf4ldZLX6LFSMWJ/FZTiQnRGiUPQGePR+wzdbiyWwBcyLJ6JhQ7HdI5YkW2mf
         cSGyiqtmfpdY7eQA8GWXZSHj8PVdfhKsEyTLpNCdhbSbP1L3DRlG3uu7yjA1kp1gk8jZ
         hkQ6dHttcR4R0PHMM+heNllOSJHCQkf3inhvjPWVxIug+tOS9+5+bl4RMgrz4CdF9ZCc
         w1QGdIF/qAaR4/R/k/Ktgdg2hES+ZV69RAkroMa4rCPTlKyHDM17m0eKODFDa8iktep6
         Nc/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwQIfCT99UFNvI4WdkFoSLtJ2QxaZAGK9nIl+hSMJcRb/Fbyg56/pB5UPZtgPpIYJXUkZB32OA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5bJcLzJM0DxDsguig76y9Yo/BlU3fsK1gxD0EMc1MnbONwONo
	equphD9x5uT+VwLDLpEn7goTczU+EBtxBoIScTCuPJxmy2j0vMNqCnIXPZYwuyG3a8DkvSpLrRr
	1ZF1D4x6IF8UaoJDsFMbPO0b6bc70Mz3XF61INnyp9FoGUjUOfTcGtBZwxhs=
X-Gm-Gg: AYBFou3Vh9thoA/WI31nZKVeMOOhWy83GBdLE958wLL8FI/ISQaZpMO5+el4BWyIpoX
	mzSK6g0JuVtfutyxCjtMgI2EY+2foVNlgRRDWDiZt8DWEgSx7AymaFvwjnaiIPiAncANABJXCaf
	Rwf0amS2/GSZ8Lgsj6pp8nmyuNkFccjlJpAo/lXp85NUY9BbwM/FS/K5LB0LgQ3rK0nXxhX4ezs
	dgGZU+DrmjEc+XDuD/tUp3542DAPE4LpvwlJSZB94gJKSASXZXFAqEiOZyb1qm4kT9ugmhbg/R4
	kBBPK5fCAyp8tbi56dJI2fMeqfsVOSshcOSkA+HTXsXwxecrdeD6EL3DXSSGeK+C0WVVC+VWVUT
	o0WzGBPlIMhlmB4zuJhC1y6H4R8vQhXfVqRVO+kGUpJxkSDhGBv40QA40Ug==
X-Received: by 2002:a05:7301:1702:b0:35b:bb89:231e with SMTP id 5a478bee46e88-361a253ea33mr1057887eec.29.1792181359043;
        Fri, 16 Oct 2026 13:09:19 -0700 (PDT)
X-Received: by 2002:a05:7301:1702:b0:35b:bb89:231e with SMTP id 5a478bee46e88-361a253ea33mr1057828eec.29.1792181358121;
        Fri, 16 Oct 2026 13:09:18 -0700 (PDT)
Received: from [10.226.48.50] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cab0sm11053337eec.3.2026.10.16.13.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 13:09:17 -0700 (PDT)
Message-ID: <5869b931-4c5b-47a1-a81e-13123165e86f@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 14:09:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
        raag.jadav@intel.com, simona.vetter@ffwll.ch, airlied@gmail.com,
        kuba@kernel.org, ogabbay@kernel.org, lizhi.hou@amd.com,
        karol.wachowski@linux.intel.com, jeff.hugo@oss.qualcomm.com,
        carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
        youssef.abdulrahman@oss.qualcomm.com
References: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
 <20261009173152.2436195-3-zachary.mckevitt@oss.qualcomm.com>
 <as_v6iB__bh3cHm3@intel.com>
Content-Language: en-US
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
In-Reply-To: <as_v6iB__bh3cHm3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA4MCBTYWx0ZWRfX0YVjjTRiPBsC
 v646uWboarsPenatqWqTyKCaOAwHhac2ttE+G/+RTQOpI4iqSRAMX3OTcAq2M8dO1jJaDVYSIVJ
 eO3XRWm9WFpi+GhtYaO1hJWj01HOezo=
X-Proofpoint-ORIG-GUID: vB2E9OFmuIOWgvkviAG2iJu746brxR2C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4MCBTYWx0ZWRfXzLrR0+Oso/1I
 EY2wYqsxxb938nEaqsB4qhRnuQda38aaz814YcaK7gAwS0RevZwioDtIHjuC6x9iiXF+6DafWIa
 T56GP57aveIhyVg7nXuszMdc391phDIdf8Z579mLtthOc/92SgasnvZHMlnRRDZWH7HvcmE7k8c
 tHQxpEJj4mtjUce36+Qjx6NW/Yl+Zhqd0LWNlTKhU8cZ2Lo/vHrQo3BG/V56lB3LtVmPVrPDkM4
 6v8lN2QNU6YeN1frxwhIgVgLbpYqBtVesbL3XC80bWWCMHsGvx4hau1nCrTfFrjjUjdU0LBJZZC
 3dRm/k6zGtjOc0jIM/y04ctNVpABkhFRkV/9rZC/KiWEalblhPS7norUOUrqgeB2a2Dwa3UA/bN
 JWbUoD2QmDJckZa7QzX6mRbe9xE/VXAgQp0wMlpFmaLUV3kRILIzikHa6E5GUDu4B+sidxNegpK
 bKdEnzKa/d8Tyfn1UzQ==
X-Proofpoint-GUID: vB2E9OFmuIOWgvkviAG2iJu746brxR2C
X-Authority-Analysis: v=2.4 cv=XKKl2ghE c=1 sm=1 tr=0 ts=6ad28470 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=tArK308TId--5egZv2cA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160080



On 10/14/2026 3:11 PM, Rodrigo Vivi wrote:
> On Fri, Oct 09, 2026 at 10:31:51AM -0700, Zack McKevitt wrote:
>> Add a new node type, attribute set, and doit function for performing
>> telemetry read and write operations using the DRM RAS interface.
> 
> Hi Zack,
> 
> I'm glad to see more users of drm-ras and glad that the flexibility is paying of
> 
>>
>> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
>> ---
>>   Documentation/netlink/specs/drm_ras.yaml |  55 ++++++-
>>   drivers/gpu/drm/drm_ras.c                | 193 ++++++++++++++++++++++-
>>   drivers/gpu/drm/drm_ras_nl.c             |  29 ++++
>>   drivers/gpu/drm/drm_ras_nl.h             |   6 +
>>   include/drm/drm_ras.h                    |  39 +++++
>>   include/uapi/drm/drm_ras.h               |  14 ++
> 
> just to confirm, you used ynl to generate these most of these files right?
> Please make sure to mention in the commit message so we are sure.
> 

Correct, ill add a note in the commit in the v2.

>>   6 files changed, 327 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
>> index a88fdab7a1c7..d558eb1cba3f 100644
>> --- a/Documentation/netlink/specs/drm_ras.yaml
>> +++ b/Documentation/netlink/specs/drm_ras.yaml
>> @@ -16,7 +16,7 @@ definitions:
>>       type: enum
>>       name: node-type
>>       value-start: 1
>> -    entries: [error-counter]
>> +    entries: [error-counter, telemetry]
>>       doc: >-
>>            Type of the node. Currently, only error-counter nodes are
> 
> Please ensure that the doc is also updated.
> 

Will do.

>>            supported, which expose reliability counters for a hardware/software
>> @@ -100,6 +100,31 @@ attribute-sets:
>>           name: error-value
>>           type: u32
>>           doc: Current value of the error counter.
>> +  -
>> +    name: telemetry-attrs
>> +    attributes:
>> +      -
>> +        name: node-id
>> +        type: u32
>> +        doc: >-
>> +             Unique identifier for the node.
>> +             Assigned dynamically by the DRM RAS core upon registration.
>> +      -
>> +        name: field
>> +        type: u32
>> +        doc:  Telemetry field to be read/written, e.g., SoC temp.
>> +      -
>> +        name: value
>> +        type: u64
>> +        doc: Value of telemetry field that was read/written.
>> +      -
>> +        name: status
>> +        type: s32
>> +        doc: Status of the telemetry operation.
> 
> is this status the hardware itself that is giving?
> Please add some doc around it to help us understand the need and see if
> is generic enough and mandatory vs optional.
> 

Yes, it is a hardware status. I will add a more in depth doc for this in 
the next iteration.

>> +      -
>> +        name: pad
>> +        type: pad
>> +        doc: Alignment padding used for 64-bit
>>   
>>   operations:
>>     list:
>> @@ -198,6 +223,34 @@ operations:
>>               - node-id
>>               - error-id
>>               - error-threshold
>> +    -
>> +      name: telemetry-read
> 
> should we do get_/set_ instead of read/write to align with the existing
> entries?!
> 

Sure, will do.

>> +      doc: Perform a read of the specified telemetry field.
>> +      attribute-set: telemetry-attrs
>> +      do:
>> +        pre: drm-ras-nl-pre-telemetry
>> +        request:
>> +          attributes:
>> +            - node-id
>> +            - field
> 
> how do users know what field to read?
> Why not a dump or at least a dump field for field discovery?
> 

We define the set of fields for our devices in our uapi file 
qaic_accel.h, but I think a dump is probably a good idea here.

>> +        reply:
>> +          attributes:
>> +            - value
>> +            - status
>> +    -
>> +      name: telemetry-write
>> +      doc: Perform a write of the specified telemetry field.
> 
> what is a write telemetry operation?

Our device has certain fields that are writable, e.g., 
QAIC_DEVINFO_THERMAL_WARNING_TEMP where the host is able to modify the 
device's thermal warning temperature threshold. These make up a small 
subset of telemetry fields.

> can we make this optional?
> 

Sure, I will make it optional in the v2.

> even write is allowed without admin cap?
> 

It seems like all of our existing writable telemetry fields should be 
restricted to admin cap only, so I will add the admin cap back in for this.

>> +      attribute-set: telemetry-attrs
>> +      do:
>> +        pre: drm-ras-nl-pre-telemetry
>> +        request:
>> +          attributes:
>> +            - node-id
>> +            - field
>> +            - value
>> +        reply:
>> +          attributes:
>> +            - status
>>   
>>   mcast-groups:
>>     list:
>> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
>> index b099eb67836e..b88293295cda 100644
>> --- a/drivers/gpu/drm/drm_ras.c
>> +++ b/drivers/gpu/drm/drm_ras.c
>> @@ -53,6 +53,15 @@
>>    * 7. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
>>    *    Userspace must provide Node ID, Error ID and threshold to be set.
>>    *
>> + * 8. TELEMETRY_READ: Read a telemetry value.
>> + *    Userspace must provide Node ID and telemetry field to be read.
>> + *    Returns the status of the read and the value read (if valid).
>> + *
>> + * 9. TELEMETRY_WRITE: Write a telemetry value.
>> + *    Userspace must provide Node ID, the telemetry field to write, and the value
>> + *    to be written.
>> + *    Returns the status of the write.
>> + *
>>    * Node registration:
>>    *
>>    * - drm_ras_node_register(): Registers a new node and assigns
>> @@ -63,7 +72,6 @@
>>    * Node type:
>>    *
>>    * - ERROR_COUNTER:
>> - *     + Currently, only error counters are supported.
>>    *     + The driver must implement the query_error_counter() callback to provide
>>    *       the name and the value of the error counter.
>>    *     + The driver must provide a error_counter_range.last value informing the
>> @@ -81,6 +89,12 @@
>>    *       that are raised by the hardware.
>>    *     + The driver is responsible for error threshold bounds checking.
>>    *
>> + * - TELEMETRY:
>> + *     + The driver must implement the telemetry_read() and telemetry_write()
>> + *       callbacks.
>> + *     + The driver can optionally provide a pre_doit callback, telemetry_pre(),
>> + *       to enforce permissions checks on telemetry operations.
>> + *
>>    * Netlink handlers:
>>    *
>>    * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
>> @@ -95,6 +109,12 @@
>>    *   operation, fetching the error threshold of a specific counter.
>>    * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
>>    *   operation, setting the error threshold of a specific counter.
>> + * - drm_ras_nl_pre_telemetry(): Implements the TELEMETRY_READ and TELEMETRY_WRITE
>> + *   pre_doit operation, returning 0 if valid.
>> + * - drm_ras_nl_telemetry_read_doit(): Implements the TELEMETRY_READ doit operation,
>> + *   invoking the driver's telemetry_read callback and returning the results.
>> + * - drm_ras_nl_telemetry_write_doit(): Implements the TELEMETRY_WRITE doit operation,
>> + *   invoking the driver's telemetry_write callback and returning the results.
>>    */
>>   
>>   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
>> @@ -617,6 +637,156 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
>>   	return set_node_error_threshold(node_id, error_id, threshold);
>>   }
>>   
>> +/**
>> + * drm_ras_nl_pre_telemetry - Enforce permission checks
>> + * @ops: Generic netlink operations
>> + * @skb: Netlink message buffer
>> + * @info: Generic Netlink info containing attributes of the request
>> + *
>> + * Enforces a telemetry node's pre_doit conditions (if they exist).
>> + *
>> + * Returns 0 if no pre_doit is specified, otherwise returns the pre_doit.
>> + */
>> +int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *skb,
>> +			     struct genl_info *info)
>> +{
>> +	struct drm_ras_node *node;
>> +	u32 node_id;
>> +
>> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
>> +	node = xa_load(&drm_ras_xa, node_id);
>> +
>> +	if (node->telemetry_pre)
>> +		return node->telemetry_pre(node);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * drm_ras_nl_telemetry_read_doit() - Query a telemetry value
>> + * @skb: Netlink message buffer
>> + * @info: Generic Netlink info containing attributes of the request
>> + *
>> + * Extracts the telemetry field from the netlink attributes and
>> + * reads that value from the device.
>> + *
>> + * Return: 0 on success, or negative errno on failure.
>> + */
>> +int drm_ras_nl_telemetry_read_doit(struct sk_buff *skb, struct genl_info *info)
>> +{
>> +	struct drm_ras_node *node;
>> +	struct sk_buff *msg;
>> +	struct nlattr *hdr;
>> +	u32 node_id, field;
>> +	s32 status;
>> +	u64 value;
>> +	int ret;
>> +
>> +	if (!info->attrs || !info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD])
>> +		return -EINVAL;
>> +
>> +	field = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
>> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
>> +
>> +	node = xa_load(&drm_ras_xa, node_id);
>> +	if (!node || !node->telemetry_read)
>> +		return -ENOENT;
>> +
>> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>> +	if (!msg)
>> +		return -ENOMEM;
>> +
>> +	hdr = genlmsg_iput(msg, info);
>> +	if (!hdr) {
>> +		nlmsg_free(msg);
>> +		return -EMSGSIZE;
>> +	}
>> +
>> +	ret = node->telemetry_read(node, &field, &value, &status);
>> +	if (ret) {
>> +		nlmsg_free(msg);
>> +		return ret;
>> +	}
>> +
>> +	ret = nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
>> +	if (ret) {
>> +		genlmsg_cancel(msg, hdr);
>> +		nlmsg_free(msg);
>> +		return ret;
>> +	}
>> +
>> +	ret = nla_put_64bit(msg, DRM_RAS_A_TELEMETRY_ATTRS_VALUE, sizeof(value),
>> +			    &value, DRM_RAS_A_TELEMETRY_ATTRS_PAD);
>> +	if (ret) {
>> +		genlmsg_cancel(msg, hdr);
>> +		nlmsg_free(msg);
>> +		return ret;
>> +	}
>> +
>> +	genlmsg_end(msg, hdr);
>> +
>> +	return genlmsg_reply(msg, info);
>> +}
>> +
>> +/**
>> + * drm_ras_nl_telemetry_write_doit() - Write a telemetry value
>> + * @skb: Netlink message buffer
>> + * @info: Generic Netlink info containing attributes of the request
>> + *
>> + * Extracts the telemetry field and value to be written from the netlink
>> + * attributes and writes that value to the specified field on the device.
>> + *
>> + * Return: 0 on success, or negative errno on failure.
>> + */
>> +int drm_ras_nl_telemetry_write_doit(struct sk_buff *skb, struct genl_info *info)
>> +{
>> +	struct drm_ras_node *node;
>> +	struct sk_buff *msg;
>> +	struct nlattr *hdr;
>> +	u32 node_id, field;
>> +	s32 status;
>> +	u64 value;
>> +	int ret;
>> +
>> +	if (!info->attrs || !info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD])
>> +		return -EINVAL;
>> +
>> +	value = nla_get_u64(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_VALUE]);
>> +	field = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
>> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
>> +
>> +	node = xa_load(&drm_ras_xa, node_id);
>> +	if (!node || !node->telemetry_read)
>> +		return -ENOENT;
>> +
>> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>> +	if (!msg)
>> +		return -ENOMEM;
>> +
>> +	hdr = genlmsg_iput(msg, info);
>> +	if (!hdr) {
>> +		nlmsg_free(msg);
>> +		return -EMSGSIZE;
>> +	}
>> +
>> +	ret = node->telemetry_write(node, &field, &value, &status);
>> +	if (ret) {
>> +		nlmsg_free(msg);
>> +		return ret;
>> +	}
>> +
>> +	ret = nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
>> +	if (ret) {
>> +		genlmsg_cancel(msg, hdr);
>> +		nlmsg_free(msg);
>> +		return ret;
>> +	}
>> +
>> +	genlmsg_end(msg, hdr);
>> +
>> +	return genlmsg_reply(msg, info);
>> +}
>> +
>>   /**
>>    * drm_ras_node_register() - Register a new RAS node
>>    * @node: Node structure to register
>> @@ -631,14 +801,21 @@ int drm_ras_node_register(struct drm_ras_node *node)
>>   	if (!node->device_name || !node->node_name)
>>   		return -EINVAL;
>>   
>> -	/* Currently, only Error Counter Endpoints are supported */
>> -	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
>> -		return -EINVAL;
>> -
>> -	/* Mandatory entries for Error Counter Node */
>> -	if (node->type == DRM_RAS_NODE_TYPE_ERROR_COUNTER &&
>> -	    (!node->error_counter_range.last || !node->query_error_counter))
>> +	/* Currently, only Error Counter and Telemetry endpoints are supported */
>> +	switch (node->type) {
>> +	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
>> +		/* Mandatory entries for Error Counter Node */
>> +		if (!node->error_counter_range.last || !node->query_error_counter)
>> +			return -EINVAL;
>> +		break;
>> +	case DRM_RAS_NODE_TYPE_TELEMETRY:
>> +		/* Mandatory entries for Telemetry Node */
>> +		if (!node->telemetry_read || !node->telemetry_write)
>> +			return -EINVAL;
>> +		break;
>> +	default:
>>   		return -EINVAL;
>> +	}
>>   
>>   	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
>>   }
>> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
>> index ff0dc406c27c..4577bc1a333e 100644
>> --- a/drivers/gpu/drm/drm_ras_nl.c
>> +++ b/drivers/gpu/drm/drm_ras_nl.c
>> @@ -41,6 +41,19 @@ static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_E
>>   	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
>>   };
>>   
>> +/* DRM_RAS_CMD_TELEMETRY_READ - do */
>> +static const struct nla_policy drm_ras_telemetry_read_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_FIELD + 1] = {
>> +	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
>> +	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_U32, },
>> +};
>> +
>> +/* DRM_RAS_CMD_TELEMETRY_WRITE - do */
>> +static const struct nla_policy drm_ras_telemetry_write_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_VALUE + 1] = {
>> +	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
>> +	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_U32, },
>> +	[DRM_RAS_A_TELEMETRY_ATTRS_VALUE] = { .type = NLA_U64, },
>> +};
>> +
>>   /* Ops table for drm_ras */
>>   static const struct genl_split_ops drm_ras_nl_ops[] = {
>>   	{
>> @@ -83,6 +96,22 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>>   		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
>>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>   	},
>> +	{
>> +		.cmd		= DRM_RAS_CMD_TELEMETRY_READ,
>> +		.pre_doit	= drm_ras_nl_pre_telemetry,
>> +		.doit		= drm_ras_nl_telemetry_read_doit,
>> +		.policy		= drm_ras_telemetry_read_nl_policy,
>> +		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
>> +		.flags		= GENL_CMD_CAP_DO,
>> +	},
>> +	{
>> +		.cmd		= DRM_RAS_CMD_TELEMETRY_WRITE,
>> +		.pre_doit	= drm_ras_nl_pre_telemetry,
>> +		.doit		= drm_ras_nl_telemetry_write_doit,
>> +		.policy		= drm_ras_telemetry_write_nl_policy,
>> +		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
>> +		.flags		= GENL_CMD_CAP_DO,
>> +	},
>>   };
>>   
>>   static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
>> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
>> index 9aef097ea10f..4bdd7ed268a1 100644
>> --- a/drivers/gpu/drm/drm_ras_nl.h
>> +++ b/drivers/gpu/drm/drm_ras_nl.h
>> @@ -12,6 +12,9 @@
>>   
>>   #include <uapi/drm/drm_ras.h>
>>   
>> +int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops,
>> +			     struct sk_buff *skb, struct genl_info *info);
>> +
>>   int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
>>   				 struct netlink_callback *cb);
>>   int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
>> @@ -24,6 +27,9 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
>>   					struct genl_info *info);
>>   int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
>>   					struct genl_info *info);
>> +int drm_ras_nl_telemetry_read_doit(struct sk_buff *skb, struct genl_info *info);
>> +int drm_ras_nl_telemetry_write_doit(struct sk_buff *skb,
>> +				    struct genl_info *info);
>>   
>>   enum {
>>   	DRM_RAS_NLGRP_ERROR_REPORT,
>> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
>> index 1765a3130b09..2a2cdd44839d 100644
>> --- a/include/drm/drm_ras.h
>> +++ b/include/drm/drm_ras.h
>> @@ -100,6 +100,45 @@ struct drm_ras_node {
>>   	 */
>>   	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
>>   
>> +	/**
>> +	 * @telemetry_pre:
>> +	 *
>> +	 * This callback is used to enforce any pre_doit conditions necessary
>> +	 * for telemetry. This is an optional callback for telemetry_node.
>> +	 *
>> +	 * Returns 0 on success, negative error code on failure.
>> +	 */
>> +	int (*telemetry_pre)(struct drm_ras_node *ep);
>> +
>> +	/**
>> +	 * @telemetry_read:
>> +	 *
>> +	 * This callback is used for a drm-ras telemetry node to read a
>> +	 * telemetry value. This is a mandatory callback for telemetry_node.
>> +	 *
>> +	 * The callback will read the desired device-specific field into value
>> +	 * and update status corresponding to a device-specific error code.
>> +	 *
>> +	 * Returns 0 on success, negative error code on failure.
>> +	 */
>> +	int (*telemetry_read)(struct drm_ras_node *ep, u32 *field, u64 *value,
>> +			      s32 *status);
>> +
>> +	/**
>> +	 * @telemetry_write:
>> +	 *
>> +	 * This callback is used for a drm-ras telemetry node to write a
>> +	 * telemetry value. This is a mandatory callback for telemetry_node.
>> +	 *
>> +	 * The callback will write the value to the desired device-specific
>> +	 * field and update status corresponding to a device-specific error
>> +	 * code.
>> +	 *
>> +	 * Returns 0 on success, negative error code on failure.
>> +	 */
>> +	int (*telemetry_write)(struct drm_ras_node *ep, u32 *field, u64 *value,
>> +			       s32 *status);
>> +
>>   	/** @priv: Driver private data */
>>   	void *priv;
>>   };
>> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
>> index 2f832275ee6e..d39c78a9ed5a 100644
>> --- a/include/uapi/drm/drm_ras.h
>> +++ b/include/uapi/drm/drm_ras.h
>> @@ -16,6 +16,7 @@
>>    */
>>   enum drm_ras_node_type {
>>   	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
>> +	DRM_RAS_NODE_TYPE_TELEMETRY,
>>   };
>>   
>>   enum {
>> @@ -51,6 +52,17 @@ enum {
>>   	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
>>   };
>>   
>> +enum {
>> +	DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID = 1,
>> +	DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
>> +	DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
>> +	DRM_RAS_A_TELEMETRY_ATTRS_STATUS,
>> +	DRM_RAS_A_TELEMETRY_ATTRS_PAD,
>> +
>> +	__DRM_RAS_A_TELEMETRY_ATTRS_MAX,
>> +	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
>> +};
>> +
>>   enum {
>>   	DRM_RAS_CMD_LIST_NODES = 1,
>>   	DRM_RAS_CMD_GET_ERROR_COUNTER,
>> @@ -58,6 +70,8 @@ enum {
>>   	DRM_RAS_CMD_ERROR_EVENT,
>>   	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
>>   	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
>> +	DRM_RAS_CMD_TELEMETRY_READ,
>> +	DRM_RAS_CMD_TELEMETRY_WRITE,
>>   
>>   	__DRM_RAS_CMD_MAX,
>>   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
>> -- 
>> 2.43.0
>>

