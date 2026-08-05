Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3A23A9DB9
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894799; cv=none; b=bVRnYXRli8FO4Yp3F/ccJaobkr+Ylg5+rV/freKkLq9XcAaDuju7yM9BOAsUcWl30CUevjUcwOTwDrQiD0C3R1c+qeuVWY+iyH4uE7Cpb6n0SxWc+3URoH01LGfi9MXEIPWv6EvbQ0Kp9oV/5kEQykaZVbvpyxolFZU3KyjTRx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894799; c=relaxed/simple;
	bh=p+yt+NMYZiDZtNW7V1ocafNfHODM07sVNNvQH4cw2lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXJxX05BwcExL4fcZnS+Qk5N6bwQg2T9HKSZMSRHhREchr0t9+uzSsebwmzdVn8sCTMfynYTEIeNpfjGz0M6JTir6NvVTIIlnzFTWcfJmVj9LUR2a22FYngZyI4IR1gxfRTdkNKDsHc5g8Da6efU0dEE7B4daPDcnZJu7pTYDRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=apDTIqy5; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="apDTIqy5"
Message-ID: <2bae8670-3b95-4baf-a61f-fe1600ed9ad6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785894783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqZFARE4/jTJNM90sWjl4ngmCPDnLA3TQRiLkSPh6Q4=;
	b=apDTIqy5eKfvCaBvCwhrA2HO8tBo1kaBCR3B3m1nX/X5akElNIMNfLjEWLgOhYmmk6iCAP
	IP8oQEi97rab1929hq1QF+Aj5vBOtcokkhS4a45CSVlhoC0c8XgwzFSPzREzYZtaR+UQlD
	cuIEplPHm1NjcEkjrq7GFO3OyLL/vTc=
Date: Wed, 5 Aug 2026 09:52:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix sleepable check for tracing prog
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Sechang Lim <rhkrqnwk98@gmail.com>, Varun R Mallya <varunrmallya@gmail.com>,
 Viktor Malik <vmalik@redhat.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20260804145710.43062-1-leon.hwang@linux.dev>
 <20260804145710.43062-2-leon.hwang@linux.dev>
 <CAEf4BzY0=ZL5MD9j-tLewfuLhRVMipAYnRJ2CD5Biji9iiZG7Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzY0=ZL5MD9j-tLewfuLhRVMipAYnRJ2CD5Biji9iiZG7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/8/26 07:39, Andrii Nakryiko wrote:
> On Tue, Aug 4, 2026 at 7:57 AM Leon Hwang <leon.hwang@linux.dev> wrote:
[...]
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index b274004fccfd..7bb541e343b2 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19019,6 +19019,9 @@ static int btf_id_allow_sleepable(u32 btf_id, unsigned long addr, const struct b
>>
>>         switch (prog->type) {
>>         case BPF_PROG_TYPE_TRACING:
>> +               if (!btf_is_kernel(btf))
>> +                       return -EINVAL;
>> +
> 
> see sashiko reply, just move it outside of switch and disallow
> sleepable for anything that is not kernel/module BTF, regardless of
> program type
> 

Ack.

I think another Fixes tag is needed for the LSM case.

Thanks,
Leon

