Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009024CA278
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864262; cv=none; b=tbN2mubOO2a2KDYeSnjWOssZR7JQ1XoRQ+n7mbgZqEdHLXGGVQA7hBh8HV/vPfY6MZaBTA7DDabMSuHehADrDhkBVyR3V2E5A1vknTOcKKkv2HOYl9f42x2UwUhwYzdyPwRygJYwkdD7qTtSnEu62q8SYsvP7+YECWO70SVOcTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864262; c=relaxed/simple;
	bh=72ILyTl9jCgwg9yZ2GImiftUbtA7OuhBqlTzCV7kaxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jT1QjTbuc9nU2JnxrhcXRW6vmXqqxLnvF0zas85b4LoMr5AVgS3/cCtmVftsnsraDyBhM43tGEAvR8jZIeoZsK7HOr3/tlLtObjctyS0CxOX+o2s+SumTFeH2e1qT86GFx3kIG6+KuMQhbRwq8NEZVaQyPkeWBuFyJ0EMJMjh0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9vgCYYT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9vgCYYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778864260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=REAc7JsRtbinu+txA7XP+y23He7koIbTbBPR29/jj64=;
	b=B9vgCYYTftaJCJvEytyAKG0Ww4gP9oHC2FYms1tHYxn/j8Rf/dicyJz30RzYUxWJdafkjj
	It6OZZdIyDePKxKuGiv5LPH6JAD5NBusW/pXUkzY05iTc1l8M+7D4j5eG9+Gr8APJ0j2Zt
	f167QH5jF70z0IwjOd6PEbvaDoh2cKM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-obuk1iVQPya_kzCG57trTA-1; Fri,
 15 May 2026 12:57:36 -0400
X-MC-Unique: obuk1iVQPya_kzCG57trTA-1
X-Mimecast-MFC-AGG-ID: obuk1iVQPya_kzCG57trTA_1778864256
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8B861956096;
	Fri, 15 May 2026 16:57:35 +0000 (UTC)
Received: from [10.44.48.187] (unknown [10.44.48.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 92D5B1800349;
	Fri, 15 May 2026 16:57:34 +0000 (UTC)
Message-ID: <b84f93c8-d97f-4979-b863-f0cca75f4b0d@redhat.com>
Date: Fri, 15 May 2026 18:57:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 2/2] dpll: add fractional-frequency-offset
 to parent-device
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20260513145115.174597-1-ivecera@redhat.com>
 <20260513145115.174597-3-ivecera@redhat.com>
 <90c9c8cb-f547-4e60-8ce9-5e54fc38cb37@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <90c9c8cb-f547-4e60-8ce9-5e54fc38cb37@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On 5/15/26 5:58 PM, David Ahern wrote:
> On 5/13/26 8:51 AM, Ivan Vecera wrote:
>> +static void dpll_pr_ffo(struct nlattr **tb, bool top_level)
>> +{
>> +	const char *fmt;
>> +
>> +	if (json || !tb[DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT]) {
>> +		if (top_level)
>> +			fmt = "  fractional-frequency-offset: %" PRId64 " ppm\n";
>> +		else
>> +			fmt = " fractional-frequency-offset %" PRId64 " ppm";
>> +		DPLL_PR_SINT_FMT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
>> +				 "fractional-frequency-offset", fmt);
>> +	}
>> +	if (top_level)
>> +		fmt = "  fractional-frequency-offset: %" PRId64 " ppt\n";
>> +	else
>> +		fmt = " fractional-frequency-offset %" PRId64 " ppt";
>> +	DPLL_PR_SINT_FMT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
>> +			 "fractional-frequency-offset-ppt", fmt);
> 
> something is not lining up for me: the attribute is
> DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT here but the fmt statement is
> still fractional-frequency-offset and yet name is
> fractional-frequency-offset-ppt.

Both attributes with and without _PPT suffix is the same, they differ in
unit. Logic is following:

For non-JSON (human readable) output:
If both FFO and FFO_PPT are present then only more precise FFO_PPT is
printed (with suffix 'ppt').
If only FFO is present then it is printed (with suffix 'ppm').

For JSON output:
Both are printed if they are both present... To distinguish between them
in the json output we have to use fractional-frequency-offset and
fractional-frequency-offset-ppt.

> Also why the use of DPLL_PR_SINT_FMT instead of DPLL_PR_SINT which
> avoids the extra fmt argument?

To add correct unit in non-JSON output.

Thanks,
Ivan

