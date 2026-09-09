Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8705568FD9
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969010; cv=none; b=TyESxkN8D/q8X/dCvjm7CALvTQfFN9UqNCyBlr4ilyJ289NP1NFebmfbnYgq6ug4+5nqcEjM5yreul4rouBL3Qo5Fo3SGd1VspxpGHXLjbVxrceaB/jv9QRU0XF8/rZOKIZnfl4hh3bbMndraHTEzLOT0f9ZwDH8aV1Q030oHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969010; c=relaxed/simple;
	bh=nFE1mVHqzRhOWK279L/SKUnOy2Ov3lQzrqja+W6JOSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icu2+pbfw53tBdTi2ZKFsEOTA9o/uTf4zIF9qYqd9NIp/8Li1qdxPd5dPZTWHFdYCnoLoKOGRHUID8nqCVzsSM54vRoZ3MHf4UPyR/mV6giFMd4T1q/UDt7Gy9vp/5v4ceaHO/DUyuG19V6X7JD4PqI9MT5Dz+xHpMT77CM1lJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HvN6JkgE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQx7zpw7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HvN6JkgE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQx7zpw7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788969008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7Zn/OFO2zbwAV9G4cd03zWGTSa7F4U3l04SAQu/SgI=;
	b=HvN6JkgEL6ck6MfD54zNXI47t67Fo3oAt7igArdXZmWk9F6C9T8sARa7WOMfjcIUH53uwG
	tql/UXODdKRLGaCdyiF3x6Ri73K8hGmbx4XWD2INwdycnBxTZ0W4IremKJpj+FNpCAazdT
	YaLtwvbYq9aJieWxLsPE2qvk503iZyY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-rG8OI8ysM4CGpEFybOg9Vw-1; Wed, 09 Sep 2026 11:50:05 -0400
X-MC-Unique: rG8OI8ysM4CGpEFybOg9Vw-1
X-Mimecast-MFC-AGG-ID: rG8OI8ysM4CGpEFybOg9Vw_1788969005
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4994cf6cdb9so43185165e9.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788969004; x=1789573804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A7Zn/OFO2zbwAV9G4cd03zWGTSa7F4U3l04SAQu/SgI=;
        b=dQx7zpw7sCZcpIlpbI1XuxMa78BUOcZL8yRmkqSSTlZisc927/IWi6xLwrflR7pP1D
         qRvdWgrihWAKV6vGjfBLuJg0oIg58zuFWB5EccMn1dDc1mGZvMiKj26KNHRwTMJs4dZ6
         Bcfxph64UqcY6OIz27UCB9g4N+RGmCzoIYXonkhsfkdcM3kdaEQymthlVOhSrrdBRvkt
         OdXcLCPPb6haSxnDrtLVpQmwd90cxp0TiHcFNi622DHavSTgwGHXOA760B/btZMbOTpn
         S39JJQPjb2Xs9DWZ9a+lhDF85FOtAf6POoMwwISoLt2LLrfHNgJLFjSq9qnB1lz6vqeT
         aySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969004; x=1789573804;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A7Zn/OFO2zbwAV9G4cd03zWGTSa7F4U3l04SAQu/SgI=;
        b=L8S7AECAagcUpyRdTwg5VW2iPKbC4CVFUZiSCgGy+1FphZ5tc/x1MOVq6R3YdMj3bR
         pMAm0ef98v8754coODjl8Y74JTSp27XwvEdCvYQy2+feNEoHuuUTIk5AFeozZScJ1BhL
         skLsGRuCu5EZ80bD9h3wwcusbQrsaDIhK1qDAGklLDYqTVe2j0LXReN4MDypi8NsqIRn
         1T8EinfXyUOkATqzsrNSWzx62nJTQQ7iikUxMjnXh2WB5NQlpoNxDrw8/MbenbUbtG/C
         /SeZCpI2o16ya2ZNe7AHRzEvKlRqepyDz5Fa8FDnHleBjsFjcP0TCNQ/KrzOuOC7/CJc
         +wTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRJkWDA5ArJMp4wtzc62qgX4TV00ujdU2PfO6/9Az2taoet0IlfuaSDOjZ6ckwFyhSV1/5bdM=@vger.kernel.org
X-Gm-Message-State: AFuF++mwGL4oFAiccgtM9Y37HXtwwwxFQxslsN5QP/cKwhTxUdteO/Gq
	7NHBypQ1qKx06T0iCDLaEKLawC2ncD1VBnuWfGz95uvxm5gyfefJZSkLjQ625zAdXvy23hTmLeW
	tLf0pCuOIbx0DI0EfdKXVQITz1KQzM3nESf+cab+jyzvy9pzS9dglV/gKAA==
X-Gm-Gg: AYBFou07+lB1Bf7Fqv3qzTIJYzFkGO5/ZegGkfEapLdijlYm69YEbCOXDo5ZT5+ECbk
	iQT+sEIGNoCjxxhiO/w5DJ2T78mbqW25l12nLcTeH5QSNXPec7015+8bLLhGyhUVqvNOiTmzn/C
	CVDmC7YX6pZyx683tYg14E4yL2vlVEvkLqmh5klFgQ9O+aTccbVCtmoApWJ+63NCN/iAQ4HFFD0
	A2dzmdbMeo1uBpcDhNvyCxg4VMirYW5AJB+e/jAQrYF3hw2mWDHu8bAl/6Nwm8J9z0/JGuWIrnl
	6PqD06KGUrBxBW+6iJPsRlRu1zV27YVyGYCs+QSJe6aFdB+4akEQ0fRXVxbhRwchbjZ7k2V/7oh
	lXBmD7KGNAJMgGoCcRZi7vFLtdUZFDUbCub2HJMDUhkD+XqY3rPjqKBefahQPwYoO4A7yWGtBHQ
	==
X-Received: by 2002:a05:600c:8b05:b0:49c:edd2:855 with SMTP id 5b1f17b1804b1-49cf823c411mr387804165e9.6.1788969004573;
        Wed, 09 Sep 2026 08:50:04 -0700 (PDT)
X-Received: by 2002:a05:600c:8b05:b0:49c:edd2:855 with SMTP id 5b1f17b1804b1-49cf823c411mr387803645e9.6.1788969004052;
        Wed, 09 Sep 2026 08:50:04 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm137463835e9.4.2026.09.09.08.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 08:50:02 -0700 (PDT)
Message-ID: <121f90e5-a19c-4066-af03-8cf5594bb30f@redhat.com>
Date: Wed, 9 Sep 2026 17:50:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 15/15] mptcp: avoid pruning for OoW data
To: netdev-bot+sashiko@kernel.org, matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-15-df1de70348b6@kernel.org>
 <178896537782.219967.1022060629733006428@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178896537782.219967.1022060629733006428@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/26 4:49 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] Incomplete realization of the patch's stated principle ("do it
>   only when we expect to accept the skb triggering the cleanup"): after…
> 
> --
> 
> mptcp: avoid pruning for OoW data
> 
> This moves the mptcp_try_rmem_schedule() call in mptcp_data_queue_ofo()
> so that it runs after the out-of-window check instead of before it, which
> avoids running the destructive OoO queue pruning for skbs that are going
> to be dropped as out of window.
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 4309fca6b119..0098e2830931 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -313,12 +313,6 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>>  	u64 seq, end_seq, max_seq;
>>  	struct sk_buff *skb1;
>>  
>> -	if (!mptcp_try_rmem_schedule(sk, skb)) {
>> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
>> -		mptcp_drop(sk, skb);
>> -		return;
>> -	}
>> -
>>  	seq = MPTCP_SKB_CB(skb)->map_seq;
>>  	end_seq = MPTCP_SKB_CB(skb)->end_seq;
>>  	max_seq = atomic64_read(&msk->rcv_wnd_sent);
>> @@ -335,6 +329,12 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>>  		return;
>>  	}
>>  
>> +	if (!mptcp_try_rmem_schedule(sk, skb)) {
>> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
>> +		mptcp_drop(sk, skb);
>> +		return;
>> +	}
>> +
> 
> [Severity: Medium]
> The commit message says pruning should be done "only when we expect
> to accept the skb triggering the cleanup".  Does the new placement
> fully match that, given the duplicate-data check still happens later in
> the rbtree walk of mptcp_data_queue_ofo()?

The change suggested here would add quite a bit of complexity for little
gain, and would diverge MPTCP behavior from TCP. We learned the lesson
the hard way we need very good reasons to do the latter. I'm pretty sure
we are better off with the proposed code.

/P

