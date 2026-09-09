Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87E568526
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967948; cv=none; b=LA3dgc06exAEAy7KEhwHkFDQapyKIfpkuYVT8VsRAakHAj0g0e9UTjm2ineWxSTE20hEabT/Z5Pyqhq4AwOyrzrletR4EvSGGpxkd860M9o/V3YoMbbks2E8nddh1P7kXNLKB2NvjDKi9adsxKG7Uj7TcGkRVCqUU3BLf79x9nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967948; c=relaxed/simple;
	bh=14M4ZYjhJX3O4zggMzrZLFQTOxB+Uxhxu4feVRw12CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QuUOHBbQadXNpGCu37pkhfyENqDB1shwLT3fhrggdbWbLe4LYOJ0ybUot6E9lzbn2M1SbibD3A4TH7Chou5Rh4gi1rqDNF1Gu5hpSDA3tzSr/00xKw7RYz+I1FfEKCvs6Vad6mK7mtZbFodDoM6ed8NivOGianAaLXdX5h4M7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ew0xP6cZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNVuWJc7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ew0xP6cZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNVuWJc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788967945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiToT9bwf6jQEAPqpOH3/rlRkJ/28pcpFwIlQDA5v28=;
	b=Ew0xP6cZLUqrbliDhTFDAhc7hnONzmwrkjvEOiiN7FgSgae+OenEB1oaZR0mSVbSIzgbpa
	ww6jFTX8hRlF/gPcjwW3dSWbHxq/zl/8CIABSNtPziECAWwkeEePJKwZguSlv5E80tZghe
	rkuOeFKOIbwfy9SfAz+QQU/ARPxFjbo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-E64THCn3Pb25H716fn_VWw-1; Wed, 09 Sep 2026 11:32:23 -0400
X-MC-Unique: E64THCn3Pb25H716fn_VWw-1
X-Mimecast-MFC-AGG-ID: E64THCn3Pb25H716fn_VWw_1788967942
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-484357599a4so4222913f8f.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 08:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788967942; x=1789572742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZiToT9bwf6jQEAPqpOH3/rlRkJ/28pcpFwIlQDA5v28=;
        b=eNVuWJc7HEkE18t4wYhw6RqSbj/Iv7dffC7mMW0/kuuqXY8PJsRwKL5jgIr7gZBTEc
         ElNIY1Qu4FUQ+R0g4npCQQy6jvKYdX6tB3vMfKH3dUi9Owwqwjjgp5yeGnAzr9mSjUcN
         NmXMdMFk80iHwOIE7J83p9CrCzN5TDqk7PoS6kx4H1gRDrWqBvxDYRfuqQFCPnkEtWFK
         yYT7rCeM5I3ttLgW08/L8aUrU7VHJpENwnxOfwz4U4TwxVU0vmF9zGbZvNX2nsxpFSel
         //AuCpJMV4WTG7NU6Z2n1ZR/luWMCid/ycAsvcr30y+2jGyE111jr0t7yfDu9McTT74t
         +szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967942; x=1789572742;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZiToT9bwf6jQEAPqpOH3/rlRkJ/28pcpFwIlQDA5v28=;
        b=OUvedBI+7HUIFIMLSNH5UvUJzX+9CYyqbQ+dN+wXjhmdL07SjrFm9j8e6szNCVFnx5
         IdHfioPkobJeoWQcuxuLTCmmfO6XlBetr+24DXZnO1fdcWGyIjFomY+15ysx3LoiYxtT
         SNIX7jiJyCjdHHTWrZwJLcecPrCvXscVM3AnUL9rnrsxxc3r9w/zYK4YYwW862POA+Bq
         Inq7rw2wqmhaVKt7q1O7uSqnv7/w8WlAvybVlUHKgAZSk98grfyD1Iy8li1ttT7plEI4
         gn6k3YOqm7UxLlS6Dak9ekQpH8JoKDQP2XnbDNQ0HbuFz79PgRq2NFjdRhHQTvWaGDSz
         XPPg==
X-Forwarded-Encrypted: i=1; AKwUvBxjwHTqIDdxP+SpaMHfa5MzsEaqWEWAUNrphr/f8Tnu8y57vOTSs90DoqguQa87op/A2fSsg2g=@vger.kernel.org
X-Gm-Message-State: AFuF++n7U+Uo36HGgh/y1Eg5sO3ulh+oKeiKmqkrEZUbmgRucz8wKxaO
	zlY+qZR/FbzgazXmF9B99KKFq3AhEsxJdDrObICimAygLsGex71JB+BtobMuMNwrf59vR4bFB5V
	HyXYnT2TREYPfW0xj7QU1d5NEZ/1Kn1s+NVi47YtgmZsVX0Qv9U82egm5g55UgWk6BA==
X-Gm-Gg: AYBFou0lw6hd6ow1PDToJAdq4ZBqV0J2ZIAoBuzhHjweQNbKMH+Cqnuquo8pzTC236m
	TvCOm3ow89OHJj5MdNJqZt2l+PzdmLLw7fssZ3d3177mSi/ytJGAZMzBF8Nb+JEAo6uwyJ6BP2u
	teQZwp437uGzNQyF8UUUUO/3NC6le1Qtuw+bv4AHJ5uY/FVPcK8Cc2VTAQGDfjXUxbg91mv39jN
	+s9T/bjcK/wQcKkatTDiX4B/IFPv9nO11UyksZ2q50jKy1FKMFOieQmR6RcWohoSgYlji7erSEk
	INrLLz6tnJKXVaLqWAFyxqJ2iN6nDQ7fwMFnaRje3Gq1sioIH0WhAglYsxd0PkmPgGuqDf/IiG7
	+dVsYAaDt35qwmk6a0CXuP1f5YMBFgM82ZtWzCDFPNheawe0dznUvTCFxjwjybIy5I2YP8v+sFA
	==
X-Received: by 2002:a05:6000:40ce:b0:484:3310:710e with SMTP id ffacd0b85a97d-485aae0e2dbmr12698916f8f.26.1788967938746;
        Wed, 09 Sep 2026 08:32:18 -0700 (PDT)
X-Received: by 2002:a05:6000:40ce:b0:484:3310:710e with SMTP id ffacd0b85a97d-485aae0e2dbmr12698537f8f.26.1788967936909;
        Wed, 09 Sep 2026 08:32:16 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9234sm44398592f8f.14.2026.09.09.08.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 08:32:14 -0700 (PDT)
Message-ID: <7cef8694-2abf-4ba1-9bda-2bb8594140f9@redhat.com>
Date: Wed, 9 Sep 2026 17:32:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 01/15] mptcp: do not reschedule the RTX timer for
 fallback sockets
To: netdev-bot+sashiko@kernel.org, matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-1-df1de70348b6@kernel.org>
 <178896537258.219967.9085177988970978054@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178896537258.219967.9085177988970978054@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 4:49 PM, netdev-bot+sashiko@kernel.org wrote:
>> @@ -4141,6 +4146,7 @@ static int mptcp_connect(struct sock *sk,
struct sockaddr_unsized *uaddr,
>>  	if (IS_ERR(ssk))
>>  		return PTR_ERR(ssk);
>>
>> +	set_bit(MPTCP_RTX_ENABLED, &msk->flags);
>>  	mptcp_set_state(sk, TCP_SYN_SENT);
>>  	subflow = mptcp_subflow_ctx(ssk);
>
> [Severity: Medium]
> Can this set_bit() re-enable the RTX timer on a msk that is already in
> fallback?  It runs unconditionally, before any of the fallback checks
> below it, and the fallback state is sticky across a failed connect().

This is an unrelated/different issue: when (mptcp_)connect() fails early
it returns a TCP_CLOSE/SS_DISCONNECTED socket but the status is not
fully cleared. Should be handled with a follow-up/unrelated series

> Would gating the set_bit() on !__mptcp_check_fallback(msk), or moving
> it below the early-fallback checks, close this case and also make the
> new comment "Prevent rescheduling on close and in case of fallback"
> hold for a msk whose fallback predates the current connect()?

FTR, I can be low of coffee, but the above suggestion is crazy wrong.

/P

