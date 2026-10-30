Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349436;
	b=RpxLiqw5jYmr+av+sraHM3/UQTdblL151a1oOB2fGL1e2gMI648SSfgqOgNTEAA/zbyT
	 g9vNb4PYmxOOZrH2sUc7+Arh+fMbLNO3uV0Xde/O5F/JzXJiCvu/BY3yNE9IQkL5mj84L
	 tKtuI5SPjokKdP9T4kIHQp6iLsTE7PLERR8VsrE+MXe+k6JXZ1z2tNsvJxwgUmKjtLfgu
	 a75mwNVS3i7OT0DhFt5nYDOAxnkTBBlqm1nw3nVtvN4dXO4jpT53D5J9iY8BFWajrdgax
	 9NmsL3pD82iWhDN2JuXnx4uSBxil6KmEikkyH9AVkRLhl3XKVnlkI273OjWBk+iLYOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349436;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=IHJX3cw9JB2XTo1/s4O3fc6EUj3ibpEpcjIPZLJOlg4=;
	b=rwP3TBG3qw0eijb3TcmqHSyi0OhdfjZRqAY+YpRXYFkHaaMSkkzU0LFdtv8E6PlSX18r
	 Yilmrr/ZJw/+bVIr9EGdv39z8jjw/M/j+dqbA7zNDl/vLw7eNB+TA6wf1Xr/upJjUK+rY
	 M8WFZSWlMdblJfDP/1jrLXVjR5OZ+1Oh20dMcktcNHqKqSG4mJzWtiL5HshLfxcQHI9vj
	 ZXDzyhCXm2COM3xGaONR7EN5hiHnzgXKgoji037BCeZJhl/Ye2jbOtEE4yxZ/O5UI6WBj
	 q1zrI7DFOWZxa6l12iL0m5aM5+0xLdsLN9bnvbcDCdWDYyn6/8NoYEvFcDpYwrn5t3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bFLcJIuz;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA75F606A32A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA75F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bFLcJIuz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793349435; x=1824885435;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IHJX3cw9JB2XTo1/s4O3fc6EUj3ibpEpcjIPZLJOlg4=;
  b=bFLcJIuznBcbdbK7OiA+bZG6eBh4/MEQ63rkmJcXCxm4YSLjpTZint/5
   NGOa4eci5CIRlNBarh4Wks4jwBaPG7NYY9oDxEek7fRlX7duGkLx1lwf3
   NPk4q+oFb10pGJ1ZXp2RkEcTXa4nfEA15ZyWe4X9X7hQjG6vGVxBROly/
   yPkDrRUkp4QosZDLwtutbVaJfkOLObrnq4N/k0cY7WFq54y6HlnH111ag
   nq18B0dCmcnUIQOApk04+KnJMh8K5+PgBh99sKjoNT6S+YrLVD8zlrD6i
   oFI+7Ivl8RChCXVf4KYwTlkYO7/tvDby5G16nzXB+bxh1PgPEexLtJqs8
   w==;
X-CSE-ConnectionGUID: XJsPqA3qQriTMdF1O/1D8g==
X-CSE-MsgGUID: x0DjG2boQUuPdE50/q3Hyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2133087"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2133087"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 01:37:15 -0700
X-CSE-ConnectionGUID: TW8odKQhTKKIfvCGK54oQA==
X-CSE-MsgGUID: wI4aNNQ6TmKwNUCTeZif6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5457931"
Received: from aiddamse-mobl3.gar.corp.intel.com (HELO [10.247.212.48]) ([10.247.212.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 01:37:08 -0700
Message-ID: <baf11ed8-6a40-495a-ae40-15df5ad50284@linux.intel.com>
Date: Fri, 30 Oct 2026 14:07:06 +0530
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
Subject: Re: [PATCH v2 1/2] drm/xe: Expose retired VRAM pages via drm-ras
To: "Tauro, Riana" <riana.tauro@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Jakub Kicinski <kuba@kernel.org>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 simona.vetter@ffwll.ch, airlied@gmail.com, tejas.upadhyay@intel.com,
 himal.prasad.ghimiray@intel.com, raag.jadav@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 pratik.bari@intel.com, Hawking.Zhang@amd.com, tao.zhou1@amd.com,
 YiPeng.Chai@amd.com, jinzhou.su@amd.com, cesun102@amd.com,
 lijo.lazar@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
References: <20261007080354.3072751-1-aravind.iddamsetty@linux.intel.com>
 <20261007080354.3072751-2-aravind.iddamsetty@linux.intel.com>
 <20261016154913.1af64e88@kernel.org> <atYFYbLXfSIPLTzA@intel.com>
 <86fb7702-9b70-412c-a8a0-a2d78cb5fae2@intel.com>
Content-Language: en-US
From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
In-Reply-To: <86fb7702-9b70-412c-a8a0-a2d78cb5fae2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Riana,

On 30-10-2026 11:46, Tauro, Riana wrote:
> Hi Aravind/Rodrigo
>
> How about using a generic telemetry node for this series from
> https://lore.kernel.org/dri-devel/20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com/T/#t
> instead of a dedicated node for vram-retired-pages?
I don't think the telemetry node is a good fit for retired-resources,
the two solve
fairly different problems:

Telemetry models a fixed, compile-time-known set of named scalar
readings (temperature, voltage, power, ...), each a single s64
value, read/written one field at a time via doit. The dump op only
enumerates the field schema (field id + field-name), it does not
bulk-return values.

A retired VRAM page is a multi-attribute record (address, size,
status), discovered at runtime when a page actually faults. There's
no way to pre-enumerate a fixed "field id" per page the way
QAIC_DEVINFO_* is enumerated at build time, and the count is
unbounded  and grows over the life of the device.

Trying to map retired pages onto telemetry fields would mean either:
(a) registering a field per page per attribute ahead of time, which
isn't possible since addresses aren't known until the fault
happens, or
(b) doing N doit round-trips (one per field) to read back what is
already a single structured dump today.

Our current get-retired-resources dump returns the full list
(address/size/status, plus a leading max-pages summary) in one
cursor-paginated sweep, with the cursor keyed by address so it stays
correct if the list mutates concurrently (pages retiring mid-dump).
Telemetry's dumpit walks a static array with an index cursor, which
doesn't give us that property.

So I'd prefer to keep DRM_RAS_NODE_TYPE_RETIRED_RESOURCES as its own
node type rather than reusing telemetry for it.

Also, RETIRED_RESOURCES is generic node not just limited to VRAM bad pages
that can extended to support a new type of resource.

Thanks,
Aravind. 
>
> Thanks
> Riana
>
> On 19-10-2026 17:26, Rodrigo Vivi wrote:
>> On Fri, Oct 16, 2026 at 03:49:13PM -0700, Jakub Kicinski wrote:
>>> On Wed,  7 Oct 2026 13:33:53 +0530 Aravind Iddamsetty wrote:
>>>> +  -
>>>> +    name: retired-resource-attrs
>>>> +    attributes:
>>>> +      -
>>>> +        name: node-id
>>>> +        type: u32
>>>> +        doc: Node ID targeted by this retired resource operation.
>>>> +      -
>>>> +        name: vram-page
>>>> +        type: nest
>>>> +        nested-attributes: vram-page-attrs
>>> why wrap attrs in a nest? Are you planning to add other resource types
>>> (than a page)? It's a common anti-pattern in Netlink to over-wrap
>>> stuff.
>> we should indeed remove the wrap and have only the page info.
>>
>>>> +        doc: >-
>>>> +             Type-specific payload. The resource type is
>>>> identified by the
>>>> +             node (its node-name); each node reports a single
>>>> resource type.
>>>> +  -
>>>> +    name: vram-page-attrs
>>>> +    attributes:
>>>> +      -
>>>> +        name: address
>>>> +        type: u64
>>>> +        doc: Device address of the retired VRAM page (e.g. DPA).
>>>> +      -
>>>> +        name: size
>>>> +        type: u64
>>> prefer uint
>>>
>>>> +        doc: Size of the retired VRAM page in bytes.
>>>> +      -
>>>> +        name: max-pages
>>>> +        type: u32
>>>> +        doc: >-
>>>> +             Maximum VRAM pages that can be retired. Present only
>>>> in the
>>>> +             leading summary entry of the dump (no
>>>> address/size/status).
>>>> +      -
>>>> +        name: status
>>>> +        type: u32
>>>> +        doc: Retirement status of the retired VRAM page.
>>>> +        enum: retired-resource-status
>>>> +      -
>>>> +        name: pad
>>>> +        type: pad
>>> And then you won't need pad
>> I noticed this in the review prompts, but I have some reservations here.
>> We know for sure our value is always u64 because it is our hw
>> definition.
>> I don't see a good reason why not use the exact size that matches our
>> hw.
