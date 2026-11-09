Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258371;
	b=4yp82C6Ue5INa0lfWlmSzd939oom9mNsMEsgxToH92g0jBrVXvgKNnjltqSOFsRLje7M
	 I2uBj9wZCCkCHL7yLvPCRosVV1gzER8yQO8LvgfaSUmMwcYaS1MyNOlQPa4MzfEIboqlt
	 t8Y5IOegfIg5ITORjLKk7yDSbLpZh/YfMj9sWy9g32xmxuq1y9L2CgD652eg34ShOBPzb
	 1Tp+5mjDFAqlORCeW+/4HyrzVQOeFLf7Ci0BNhv1ZGfXEn2MsoYST9F2DKAhckVyl4GcY
	 5nMSHB/2i8MKIDFk69eQpKaBQ7Hmg/O2v0yLjK+XfXYdXlRsCSmvd+2pHthG8NslxGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258371;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KehNcAM/I+CG+cC9LNypII+QIVvqswfmnEsbdGljei4=;
	b=LtDwxzlu4Z04jw2k0+KkqJwZaEcdZJOKSCJfJwNHaJrSYFWQ0tV0rPwG48Dk8DRuOJ5K
	 m05BF/BuwNgWcXbMSRKYdKlQ8lEp0Tch7I51E7FBR9GeeMB0+Vu70v52yH51FnNQmP7Vh
	 L7QrwnTHWuXhOJRJvbyL5x7xSmVGmUf6zsakNvqxylO5/jz/5Hd7St5cSZ67JhTIjMY8T
	 r+rIOifORdiVK7xT3vSR7poi9nFzTdns8DjaSdkJDLDR2oRcxJMVleAh9oy+h5ArawOLA
	 HXghvuMeFd+y0vYivICFLOjmNeg2K3o3vZyZqxzGdVX9NPti1InlHEMeHvFAGPfXwfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=am+eQczP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EXKm6V2o;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A1606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B92A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=am+eQczP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EXKm6V2o
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9JjLGu1196392
	for <netdev@vger.kernel.org>; Mon, 9 Nov 2026 21:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KehNcAM/I+CG+cC9LNypII+QIVvqswfmnEsbdGljei4=; b=am+eQczPNHV3jVDh
	ZEu3fWVA9aF9sqngd7i1s4DjD84wfrviSPEJ/H4AAnfh+gLGKiWUg90j7udLer/W
	hIe8cP0wTS6Otb1lCqI+GrGDyK3RQAd4pdgTYTLftb31v+F6ORMPTi00wGBsR1fN
	yG7RSCG4hZ7RfTRt082tnrhSi8ouMbVxHbkU22Wbq0OkiF0gYDm9Gv1ZbBVWROfw
	RUK6F876Tm6iRHP48JHkWDJacfoHEqr1a8t57L4vsevK2Q4IYQpj7tjQave+T39V
	ltzQ9Bpz8zSXgp8IAJbIpRhij4F7toVkeXnc5TWkB0zgJK3UvVVpn0HFICF995bd
	kdUb2g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudf5a28s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 21:06:04 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36efb506f29so2661680eec.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794258363; x=1794863163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KehNcAM/I+CG+cC9LNypII+QIVvqswfmnEsbdGljei4=;
        b=EXKm6V2olsWaTsMXin8+lhG7+qxBsCtSLsGrL+qxo0rUz7lDdNPSlv7MEvQg6T7DmY
         JsdpASHd7b5BErJj6S1UEQXCJGn/4HqyXDo1bKh6Wf1p/l2VtsQjzfDWvFFZY7NA07dv
         cBrs4w9F8XPON+d5Xu2ebdh7Oz+Ud31IXFCssGqousjJYl/YfwtSbNj+pGbCY7od0trI
         gSUfhafCJkTOJ0sX6vYxaTcurdekgjd6UJv79DAAtQ1CM9EKjMBlLV1vEQnlOZxN1Ws+
         H1pIUImjr8lBsTEVynw6M+ab1u0RTEx+pBARqraxkUqdMSswVmQ1VB3ffa1Ra+9IlzNJ
         vwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794258363; x=1794863163;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KehNcAM/I+CG+cC9LNypII+QIVvqswfmnEsbdGljei4=;
        b=ncVUWVO7iqxQhlRBltDmH4YaRJA+b02ZluYSmEqTGwjkiSoA9xqrd24Jl290M4AUir
         8Zhu/o9yG5wQwJ8GwikVwIIhFHu0cpH/dqFN4xoLQ7W4nkIFY5P1XrVUodCcevaGTxLO
         Z5KnzR1bw0Wj77d7tpPBVYBGMjkPfaTa40SAcxLjZX2d6XRJ8uRidQzUY4IJfIoTM/sZ
         pGkBSlACEOHdYgm69m2mKlbtDIdw8Pt3RiH7dMnjQgRi0c2dOoN9N/ec4xuDMEoIsTeo
         /Wu3Vk3dIwfYSMVzxHxRNKdvmbSAQmLXViG08mUKizYqhyXl0wLoTLnb/Vr03FBrSaxY
         AdPA==
X-Forwarded-Encrypted: i=1; AL+hErH2cscVwJ3YqyznUXV5kIK7bdptlQFOy+DygzbFnyvS4jwrdRfQRDpiFgDWX6kJKxxPsnv+p10=@vger.kernel.org
X-Gm-Message-State: APuU4Z/s9HXq9GW2izEEunZH36cxGE5XK8VTXD6g2lcMguVPxBsG497Z
	pP7oCwQE5R/4S/vm7l7DFUP/n068UoQgSudL7PZ70DNbZnR72P26UFvoi2Y4k6HygYe7Ket7ANQ
	uceiQfTVFYKNF63tOUp+R/rAdgWlI2UQXHCuFG76d5+CD2ebeFCH2wKYSTfo=
X-Gm-Gg: AYBFou3u0joglgZvBoaOjK/AymwLmMJc8YpDUPHV2AcjqPYZHEkHdNldTHxxWLkIlFl
	atOa2szgGcAGazMRTV+UoLXOSIUOYFL8tqQEekc/LAKf+BLUrPa9PRkO60MV2Oa95TfPPrYBYYX
	x9BcgdQrgQ5PeWQiWMeHcoTOggjP+RMfH/wyBl6/Dcx2vBQo4HfZHnqgEtI9SW+H23H1snOecdR
	brJ6h5Vd2r2M5d2d1SDW9PLQqa/wYztCT5XRK2+OJB8jFG5e4t4kuhx1xpu01o0eKxEOhFC2jjc
	r8guFWQofKi7z8kNFUghLRhvZiMhSw8nlqVxtxPIvq51zus5+qgZyoIkYMz/ZpFvOaaaMa1AR4u
	xfjf/cgqHr+T/o6Lh+m+OC5wnqmWdjiKbCGJgHk4nNts0N8dxY4vFIHfT5t898d03iVDjUMESb4
	tKq7NZQQu1+LTC6gxWY8rIT+huCidiDg==
X-Received: by 2002:a05:693c:41d2:20b0:36b:d3dd:2e9d with SMTP id 5a478bee46e88-3751f078fd1mr590679eec.19.1794258362974;
        Mon, 09 Nov 2026 13:06:02 -0800 (PST)
X-Received: by 2002:a05:693c:41d2:20b0:36b:d3dd:2e9d with SMTP id 5a478bee46e88-3751f078fd1mr590636eec.19.1794258362202;
        Mon, 09 Nov 2026 13:06:02 -0800 (PST)
Received: from [10.226.48.50] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bfb58dsm1484362eec.18.2026.11.09.13.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 13:06:01 -0800 (PST)
Message-ID: <152e4fc3-7c74-452c-8391-04d4b0082a4c@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 14:05:59 -0700
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
Subject: Re: [PATCH v3 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
        raag.jadav@intel.com, simona.vetter@ffwll.ch, airlied@gmail.com,
        kuba@kernel.org, ogabbay@kernel.org, lizhi.hou@amd.com,
        karol.wachowski@linux.intel.com, jeff.hugo@oss.qualcomm.com,
        carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
        youssef.abdulrahman@oss.qualcomm.com
References: <20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com>
 <20261106181225.3333260-3-zachary.mckevitt@oss.qualcomm.com>
 <avHpogElibf5F0FR@intel.com>
Content-Language: en-US
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
In-Reply-To: <avHpogElibf5F0FR@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oLFsmtXen6plGSNTPa8DwS5MVZDKS20C
X-Proofpoint-GUID: oLFsmtXen6plGSNTPa8DwS5MVZDKS20C
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4NCBTYWx0ZWRfX0GTPxFnUDvlk
 /2XhGjJmNV00c/bC7BS3ntPXrh6mQXPmPbtifh+q2kfHsAGbBswZFgb0mJZ4TpTG+BQrrM3UfTm
 8YkSDRA8WH4tdIsWIdn5mAMK6C6donI=
X-Authority-Analysis: v=2.4 cv=bar+w+PB c=1 sm=1 tr=0 ts=6af235bc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=xihu62O6HHKiAZ0-3J8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4NCBTYWx0ZWRfX7uyoRlf87oJx
 DpClchpVrqZHP39RXKL+DFJ3yuZMqZqvKu14bk8EbxgI3L9n87ife/w0RLx1+kfanG2g+H61Jnu
 lXWnV3jo9OPtfZeQia9RvHKAY9PBl6gGO8fzJSDd2XIq3uhK5aQViSA/1cFTIn1jVB4dPRhXtze
 y9ySrcgGUCKIRAlmQEjQDbuSXVxQ1WOreFENNIs81uoiBz9IdrE8R1w7BAvNhtDkjWJ9bcsh45x
 rcIYK2GIR2G9LsGP3gUzbhW4z5XbS1LZ/04k8n0pEN5b6NP/+4IxjkG1SLDIA9AOcFQCRAN90U2
 ifniHtrqviEPhLhBqM8NN1PDfds0WcHKDTl3VP8cxE5fvhnJXjk3N5zHUZzfllcSa5wTbmsJohL
 KR+EK72aUiqrk7dc147ue7mBW/2qIGGPagNC3T7dxfBAjKK8mzZzE3CGtllazP2ArBCzW6XvS4d
 DQ+BWt4sF2h7KdrJS/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090084



On 11/9/2026 8:41 AM, Rodrigo Vivi wrote:
> On Fri, Nov 06, 2026 at 10:12:24AM -0800, Zack McKevitt wrote:
>> Add a new node type, attribute set, and doit/dump functions for
>> performing telemetry read and write operations using the DRM RAS
>> interface.
>>
>> ynl-regen.sh was used to regenerate drm_ras_nl.c, drm_ras_nl.h, and
>> include/uapi/drm/drm_ras.h from the drm_ras.yaml spec.
>>
>> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
>> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
>> ---
>>   Documentation/netlink/specs/drm_ras.yaml |  82 +++++-
>>   drivers/gpu/drm/drm_ras.c                | 329 ++++++++++++++++++++++-
>>   drivers/gpu/drm/drm_ras_nl.c             |  53 ++++
>>   drivers/gpu/drm/drm_ras_nl.h             |   9 +
>>   include/drm/drm_ras.h                    |  67 +++++
>>   include/uapi/drm/drm_ras.h               |  19 +-
>>   6 files changed, 545 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
>> index a88fdab7a1c7..cf015bba020d 100644
>> --- a/Documentation/netlink/specs/drm_ras.yaml
>> +++ b/Documentation/netlink/specs/drm_ras.yaml
>> @@ -16,11 +16,11 @@ definitions:
>>       type: enum
>>       name: node-type
>>       value-start: 1
>> -    entries: [error-counter]
>> +    entries: [error-counter, telemetry]
>>       doc: >-
>> -         Type of the node. Currently, only error-counter nodes are
>> -         supported, which expose reliability counters for a hardware/software
>> -         component.
>> +         Type of the node. The error-counter nodes expose reliability counters
>> +         for a hardware/software component, and telemetry nodes expose an
>> +         interface for reading and writing telemetry values to a device.
>>   
>>   attribute-sets:
>>     -
>> @@ -100,6 +100,34 @@ attribute-sets:
>>           name: error-value
>>           type: u32
>>           doc: Current value of the error counter.
>> +  -
>> +    name: telemetry-attrs
>> +    attributes:
>> +      -
>> +        name: node-id
>> +        type: u32
> 
> this we keep for legacy alignment.
> 

Im a little confused at this comment here. Anything you are suggesting 
to change?

[...]

>> +      name: telemetry-set
>> +      doc: >-
>> +           Perform a write of the specified telemetry field.
>> +           Telemetry writes are device specific, and may be used to set
>> +           device limits or other capacities, for example.
>> +      attribute-set: telemetry-attrs
>> +      flags: [admin-perm]
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
>> +      dump:
> 
> does dump on set specified telemetry field makes sense?!
> 

The logic here was to separate gettable and settable fields. If you 
check the qaic driver changes in the next patch, you will see that the 
settable list is a significantly smaller subset of the gettable list.

So, the settable dumpit would tell you distinctly which fields are 
writeable. If you prefer, I guess we could add a single dump operation 
with an additional field for R/W, but this will require an additional 
attribute to be defined in the spec.

Any preference?

