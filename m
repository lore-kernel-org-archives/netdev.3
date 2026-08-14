Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001948D87C;
	Fri, 14 Aug 2026 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734251; cv=none; b=pGrivYim3g+Eph6pu5WmxutVprVT1evwO/dslptIKFYhgfHc53iS++yKwZbG827T/H6OBc5CCWvPcgNK06ikVXgyOwSvkXSfa4oKf87MfQd3HopkzLDHlq0JOuwP5Mj8R7sIWDn1ZgRHyNgSbc1J+ef7mMuM6JnC3ZZsZKqptDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734251; c=relaxed/simple;
	bh=wRz5Xlhwy1OlLKPH1eMWymtQEb5RB/jQvPdq71Vl1iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKrvVDreYrfp84BPQ1xDwXmLIC1r8NhOVEBcy93e/x9B+xUh2mAKwHGPVpuemnMcYzdVtycpVEo4kitFPKeT5Kk/+0ImZWLjMV/V+GFDfWzIicDTv/jiIZ8YoJnuwy4L+pg2cU7nwXsB125lFcHIQaq0WlP76HQrsEM8pT2dyQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lQJKs7E5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lQJKs7E5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=AOAe2niGdV1VluiuMFqrsIhLOofuHSBhfowvnlRihrg=; b=lQJKs7E5VxRFcNdrCiwiZC8jI2
	m0Z8+B+gU6Tm9i/sbjuL8Di4+8rdp1sfpSsZVJUHkALbxwpJkAtzq9ssVJDgWJyZILienSAJ+GvsT
	elCnGhbPyHCEFLxx6cT+wx96I4b3F3dzl7ql37sfHt90kc+BTGG8MT0mn1K4XIC29xmMuuUbCcrfK
	1ggex12RZ1D9UPyFG+Yb05qPBnTDfpoEjIeIKLCwBjt119oySuhFgWKpmsfDC9Jl4fc/sHiBrX7T3
	SmWPAufurIdZ3h/Afy2ngEzA52Dsa/puh+VBWH+2hD/cUyV0rTJAkDsJM3LfnKymII2vCiiINFrbi
	C0B2XXMw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuxCI-000000034cd-0ihN;
	Fri, 14 Aug 2026 19:04:06 +0000
Message-ID: <984e036c-0d90-435f-a56b-ea39a2adf923@infradead.org>
Date: Fri, 14 Aug 2026 12:04:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net_shaper: fix net_shaper_ops kernel-doc
To: Jakub Kicinski <kuba@kernel.org>,
 Karl Mehltretter <kmehltretter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260813192131.21254-1-kmehltretter@gmail.com>
 <20260814101408.13bc8cc2@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260814101408.13bc8cc2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/26 10:14 AM, Jakub Kicinski wrote:
> Adding the missing CC of linux-doc
> 
> On Thu, 13 Aug 2026 21:21:31 +0200 Karl Mehltretter wrote:
>> Everything from the "Driver ops vs uAPI" heading onward is dropped from
>> the rendered net_shaper_ops documentation. Older Docutils versions do so
>> silently, while Docutils 0.22 reports the nested headings and adjacent
>> list as invalid.
> 
> Isn't this a problem in kernel-doc extraction / how we embed it for
> rendering? Heading are quite useful and IMHO far more natural to use.
> My understanding was that kdoc should be able to use basic ReST
> formatting.
> 
> Ack on the list indent fix
> 
>> Use bold labels and correct the list indentation.
>>
>> Fixes: 16812d9674d4 ("net_shaper: remove incorrect comment about group leaves")
>> Fixes: 26bc4cfb1737 ("net_shaper: clarify the kernel API / comments")
> 
> This is a doc patch, please don't sprinkle Fixes tag on patches which
> don't fix bugs.
> 

I would prefer to also see the actual warning messages in the patch description,
but that's up to the maintainer(s).  (or just one of them would be OK)

Documentation/networking/kapi:107: ../include/net/net_shaper.h:75: ERROR: A level 3 section cannot be used here.

Driver ops vs uAPI
------------------

Established title styles: =/= = -

The parent of level 3 sections cannot be reached. The parser is at section level 3 but the current node has only 0 parent section(s).
One reason may be a high level section used in a directive that parses its content into a base node not attached to the document
(up to Docutils 0.21, these sections were silently dropped). [docutils]
Documentation/networking/kapi:107: ../include/net/net_shaper.h:82: ERROR: Unexpected indentation. [docutils]


I don't know of another reasonable solution for this (although I'm no expert
on ReST), so

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

>> Assisted-by: Codex:gpt-5.6-sol
>> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
>> ---
>> The omission is visible in the current linux-next generated documentation:
>> https://www.kernel.org/doc/html/next/networking/kapi.html#c.net_shaper_ops
>>
>> Tested with Sphinx 9.1.0 and Docutils 0.22.4:
>>   make SPHINXDIRS=networking htmldocs
>>
>>  include/net/net_shaper.h | 17 +++++++++--------
>>  1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/net/net_shaper.h b/include/net/net_shaper.h
>> index 05cb625b0fe54..a2eb616a19fd0 100644
>> --- a/include/net/net_shaper.h
>> +++ b/include/net/net_shaper.h
>> @@ -73,20 +73,21 @@ struct net_shaper {
>>   * Each shaper is uniquely identified within the device with a 'handle'
>>   * comprising the shaper scope and a scope-specific id.
>>   *
>> - * Driver ops vs uAPI
>> - * ------------------
>> + * **Driver ops vs uAPI**
>> + *
>>   * Members of the driver ops mirror the Netlink uAPI but driver calls do not
>>   * map 1:1 to user calls. Drivers need to be careful when assuming that calls
>>   * disallowed at the uAPI level will never be made at the driver level.
>>   * The shaper core performs automatic reparenting and cleanup, generating
>>   * additional calls. Notably:
>> - *  - @group calls in the driver facing API may have nodes as leaves (user is
>> - *    only allowed to construct groups with queues as leaves)
>> - *  - @group calls may update leaf's parent if the parent is about
>> - *    to be removed (re-parenting nodes explicitly is not supported in the uAPI)
>>   *
>> - * Implicit creation
>> - * -----------------
>> + * - @group calls in the driver facing API may have nodes as leaves (user is
>> + *   only allowed to construct groups with queues as leaves)
>> + * - @group calls may update leaf's parent if the parent is about
>> + *   to be removed (re-parenting nodes explicitly is not supported in the uAPI)
>> + *
>> + * **Implicit creation**
>> + *
>>   * Shapers are created implicitly, meaning that @set and @group operations
>>   * are called both for existing and new shapers. The driver has to infer
>>   * whether the operation is an update or a creation by tracking the handles.
>>
>> base-commit: 3205699d79f262412c1be7fc1c04066610d3cd52
> 
> 
