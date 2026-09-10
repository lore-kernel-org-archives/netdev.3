Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868A313540
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027942; cv=none; b=R+7snPazu/nMY0EQ5mbgkeRkDLU3YlJefHJZXT2bb1i4/2/DmEGe6o0/LIrwWeRXMmGYMrYWOWHwke6cawE2s/EJCsF1qHAzmY1CKgoiK0cPPzjQITdCZczkVktrOkLMjvaLPZZcWfJHWKzxOuf97BkT3mPfQ2EbeZ65yVfqrZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027942; c=relaxed/simple;
	bh=WQe453I+O9kJM6b6zHQrmqWzKsZXSoS+9k6LVQH7nSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+KzKk7O3xZMZdlv1LxdRoVE1gcBcHyIaxO4w94hRvplBqwWa7wn+4XT/Gzdypi+m2cKsFxPUJ0p6XRD4Ys/gFq13QTkO/NoBsDPU54lQ3ECZ9uINi7HYO3vts1XYOOiBMdcDdJdjexrmQW8H36cSqK/nNgJctZOwE/qK0nwHrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQL7/581; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5TAFREs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQL7/581";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5TAFREs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789027939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7m86Nl0R/ApS0b4Hz6J+TM/No6iRyeaUTybs4HgQjpY=;
	b=QQL7/581r9xBRja65AwCA0K7x6H5lAsasUGg66B48xDQDCz1OHeLcxo62+o+qEUOKwVOYH
	w21weqh06jiQ/fCirs3fpY62G+DvP2nhbXB4GA7ShdkH3qETRg631wyVnJJ7tDQETlGr0b
	xqGfiG/ObsOEsu7gh2cI6eQAIJmizw0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-enG9dPw6OjGy04IAkZBHXA-1; Thu, 10 Sep 2026 04:12:18 -0400
X-MC-Unique: enG9dPw6OjGy04IAkZBHXA-1
X-Mimecast-MFC-AGG-ID: enG9dPw6OjGy04IAkZBHXA_1789027937
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c25501f4aa2so92797866b.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789027937; x=1789632737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7m86Nl0R/ApS0b4Hz6J+TM/No6iRyeaUTybs4HgQjpY=;
        b=R5TAFREsYgfNj4lGbb6z1oXp3LjIm+LCrmt4wek2bRHVqs7Dzz0loTSkVaFYcMzH2M
         q5wF705P8LlFTKzDOmH9vDM14VGQTYpT4VfGqunsHvjfg/oWaFPP88K9ZoKmer2/JtPm
         kOUcR7hg+SGWk4o/LDcgqvagkvK/qH5xhZFmZY5SLnW/5O11ICg+lxg+ZguPcFmnJ/l1
         Jg38EdamYKeAz14pZzo2L8ETEQ8ivipprGujNICw5VMU3gbM25CWOv8FN0swN8SNFDaC
         Kik95Wlzocw475lkXQCwJbH4Pldp59IMAk8i1O8C3Qm7POrSerMw21E+ALB0+it02TNi
         Vefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789027937; x=1789632737;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7m86Nl0R/ApS0b4Hz6J+TM/No6iRyeaUTybs4HgQjpY=;
        b=gp7L8fiJtElwpVXe2D64D9JTzIQvc+Bt77eEbggxGyffpqw8FRmeqF88tRRWbf/GfN
         M6eB+XaBkFHh7Hrh7vViLRlAFSr6j7MzfHfwODmPEmQeq3fmQdQnsNEMVSna+sLviS6K
         ALneyYHdmqO27JY+i1knl0PC4rTW/Uhjjpf6gcwxkmhs+kLIGSUv/qURR/v5/Hyn6eHT
         QS2k/dPHDE3Fqs8g3KuGqUhCUN7ii52PfAwvlmwMxDuYSdd55ebw+pI7o5gTYs+VJX/T
         Pdjww/zVZxuAK2BaVRL6oLn7J015bc7CbP1pRzi/JHxr75vXyTUyDVIpeB4mrXLRzUiG
         vgDw==
X-Gm-Message-State: AFuF++lnBMJ6AYOszUaK9fPe0Mpe8CuEypzuT2cLkvpBJINvUsIPElFZ
	tFI9usx5UKPz2/WUr/O1yYdIrSdK7sI8EikBwheBi1LpjhkpwmZITWmqaR52phlISZLnzLTv7Op
	+n4I6Nn+ewXXAPyvetOuSLs927p46wjzJxIvD7sfrSLQSlhYlTymUppvAmw==
X-Gm-Gg: AYBFou3G1KqQTMrEo3MYSHsX2yQcS3eB5sSz3vn6peepKOzZOsdSQIOdHgdLueTLugu
	nE1euwmSSKFhSDqDEn73/uwboczOLR7tTED757zRHV1VmVZ0QjPG8F3Dl9TD9AngPDaFHAY4b6e
	secp86/FaaJ0TMmEIbwdSv7x2Y/RDFK+Mg11IGXLWODHTYYFPGGjvBGkRPM2IdFtOoalowTxvyw
	b8ioS58f3eEEFWFeAofjlNl/kvt+Ffs5x3IbRq04d5+MNinYEcoEbC5S70zZ7lWIKDEQTH1QqIb
	1f2sMv1umnaWdbXPXqqT5oPyHsIYkBDK83d5akjos/cmrt0zRdWF5fjNeLhWT/dO5nLcWHnmXFx
	Ghw78tPuReBw1rVGTAZ8P04caaf3I7w21SNDtVsgiHflsCde/HDMuyjEiDQkLbeJtB/P6VDt7zQ
	==
X-Received: by 2002:a17:906:8f8a:b0:c25:f7db:4bed with SMTP id a640c23a62f3a-c2945efbe7emr176079466b.19.1789027937034;
        Thu, 10 Sep 2026 01:12:17 -0700 (PDT)
X-Received: by 2002:a17:906:8f8a:b0:c25:f7db:4bed with SMTP id a640c23a62f3a-c2945efbe7emr176077166b.19.1789027936516;
        Thu, 10 Sep 2026 01:12:16 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4aa01dsm882062666b.15.2026.09.10.01.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 01:12:15 -0700 (PDT)
Message-ID: <c95bc6f8-b8da-426f-a056-1c692559d14f@redhat.com>
Date: Thu, 10 Sep 2026 10:12:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcp: fastopen: check rsk_drop_req() in
 tcp_fastopen_create_child()
To: Yilin Zhang <yilinzhang@moonshot.ai>, Mat Martineau
 <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 Kimi Security Team <bug-report@moonshot.ai>
References: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 11:40 AM, Yilin Zhang wrote:
> subflow_syn_recv_sock() sets drop_req when an MP_JOIN SYN takes the fatal
> fallback and destroys the cloned child. tcp_fastopen_create_child()
> ignored the flag and could queue the destroyed child.
> 
> With an MPTCP listener using server-side Fast Open, a valid-cookie
> MP_JOIN SYN could then expose the freed child through accept().
> 
> Release the locked child and drop the request before tcp_conn_request()
> sends a SYN-ACK. Initialize drop_req when allocating the request so the
> check cannot observe stale state after request-socket reuse.
> 
> Changes in v2:
> - unlock the child before dropping its reference
> - drop the request instead of sending a SYN-ACK after the MPTCP reset,
>   as suggested by Jiayuan Chen
> 
> Fixes: 90bf45134d55 ("mptcp: add new sock flag to deal with join subflows")
> Reported-by: Kimi Security Team <bug-report@moonshot.ai>
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>

This looks like the wrong fix. IIRC fastopen is not compatible with MPJ
- as the latter must accept data only after the 4way handshake completion.

@Mat(s): could you please double check the above ^^^ statement???

If so mptcp should reject entirely MPJ + fastopen and no addtional code
required on the TCP side.

A minor process note: the changelog should come after the tag area and a
'---' separator.

/P

