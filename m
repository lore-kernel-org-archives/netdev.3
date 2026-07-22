Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1F1381EB6
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746710; cv=none; b=s/8TWi+joztKSgFAUU4jOYA5Uf109CuyWmHwEo9oPDeMhFq8/jY4LUxMWXtvPne5DG0o6/iZfQfURfILGAGrB0jncgKDQmpNSt/u4GqLOQupgU3c4+iQ7z+CcZJ461iBKSUT/s1c3J450LMTlMU4jHb5fZoiuIXdhPDwMTMDkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746710; c=relaxed/simple;
	bh=KP6BRwIyXWiPibbOxlWDKB0Ob/q3NzJ7CORFXOUq1Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGJw2eA8iYKIZlG3bFauxbaLpjCTzSOMhfKnFSSyOe1qC4VZwSWoBxPJ5cxsSwcN8uv00qTAbnLAiBsw1/a//ScfC5Jyu3Sug9ivoMIcfZSg+OlihlB0intRnOS6+zTpXF42T68cFgboip/KfUVvtjyTYRu06GE4nkAmdGvXjGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOfgsHeF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOfgsHeF"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-471eeac43bfso12125866f8f.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784746706; x=1785351506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3A3FilI2WnTkfnD2bI9rIh/xd0dD+VTcZwi1wc2QOg0=;
        b=DOfgsHeFFqBFrOkEtqrmIXLJTMoAG6uvNBJKgGGdxtEp5u6hHOGOEQSSM1IcSGupPG
         M+3AtrHyCUU+RyJpilshfH8EgzipdZbIcgYpATzG69cb+d3dIAE442IDGcxazxWvZohq
         Ox5gkG9Ds+2wdUYHUVeKYlNfPKV66jPrfnhbCJQuMV/V0wtCMfG5agSprWosxhKIqTl6
         ckqc4oFEA4WxlFE2xI5sYHppekGC3oPqKHGHVpLNcQgnKFEQ+dVlcIfuZ5Hf3JzajzyH
         vfLFJAzoJyKVqpLMft0HkvZIL5LYtYZyHh6M8owdw19JI3eufZVIV0SQcXV6zRaxSvjr
         n4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746706; x=1785351506;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3A3FilI2WnTkfnD2bI9rIh/xd0dD+VTcZwi1wc2QOg0=;
        b=okWy+Q7lngHpw8nmRYCzcCc+iDKAOL4tJ/JHrJOAZi6khNQAiE+hnvdqTGJGhOb81Q
         oBNlVa4bTQVYeBgbyVLofdW5wZvHahBSDPfcfZHCPu8ZPbR6GFY3O9kdJjRTpEfsgTp2
         +ebeUU47DhNbGNsPV2DP06h0pwLpwvT8bEaBOyt0XxSmSeEwmDU7PF2MIO2GqFl/kWVw
         1QRvF2ftRwgHQvTqnvm20FDUXh2hUiGNfX7YTUFpv0Yj/Xf70cXVqT5STZuzmYxLXgVp
         8qfAWyr0Ge0qIq/aoEyBcI2vY5A7hblc+RvJqOtHS55hxgs/15ysIFzPlod3xeGkcXZ3
         cLeQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+yy6JcyxfX0Iwb/BFTHBqXC3JiyIy+UgOg2pnTszRG8BdTJDgboGzSfy+3LCfXUVBiJFOZUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzThFD1miSis4IaOapUcK27KdLP4KrDaQSXDCiDGvP8MKPEy11/
	W6Peif0flL1eevMQ6p5kOoraxxe6n668HymWw0hltIm07OetqxOw2SvE
X-Gm-Gg: AR+sD12onVX5LHEd1kdVFrRr4JLzw3WelzAjLOEJ2Bo+RciJAuY+B8lvXLlZloA8BDL
	UzMklfp3K4BVUQK0+aq6gHweCqtH8TMMxnx4nv4WI1i/pH7K7aLfZNIr6BAh4HN+brS6MryRzHb
	KxbAJKoyZRudkOHat5GGllqmS/bU+wOJZwLP23ernK8YCY+gGYskC48R0Vfv6M6aNZwR+5Rb0GY
	4R7O4zcieHmcnllop/9e6yW2DdyRNSwfrq1OYQuUBIxY7v/ZS09sBZ0gUe0P1NwYZGp+JDqFlLV
	qJPCZCAkTYw3f75tuo2RUXeFCYfU03iHrRy/jdBv2ykCduM4VCooEsrhrvTnGMHQBhaBPG4YIzw
	xpyKbh8uElqHikBCeyAjKqHnzpLgbLwBPfi5grElV9rMlNr9Y6uZOTk94HrfdSl2UATIMy+mN9h
	FC0NKWp655u6XhbeuBbZ/N2SXRJwJSpq0HTC/RqYi8d+nerq4Jcc37MSVMyYZF1u/1yDJbaJsCU
	XCQ3H0X+KVFmaiu3SAMxQNaqbT5J2J0UppRkwY6iVYFCM05/8sADdKb
X-Received: by 2002:a05:6000:2382:b0:475:3a97:8e2c with SMTP id ffacd0b85a97d-47f8d71f65dmr135742f8f.16.1784746706495;
        Wed, 22 Jul 2026 11:58:26 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c63678sm7860766f8f.29.2026.07.22.11.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 11:58:25 -0700 (PDT)
Message-ID: <5c3c34de-7b34-4122-a792-e91b48858f2f@gmail.com>
Date: Wed, 22 Jul 2026 19:58:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: devmem: prevent net-iov / page mixing
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Mina Almasry <almasrymina@google.com>
References: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
 <amEE7qImKgy4sWKf@devvm29614.prn0.facebook.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <amEE7qImKgy4sWKf@devvm29614.prn0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 18:59, Bobby Eshleman wrote:
> On Wed, Jul 22, 2026 at 11:58:46AM +0100, Pavel Begunkov wrote:
>> We should either have net_iov or page backed frags in a single skb,
>> otherwise it blows up down the stack. Don't allow mixing in
>> zerocopy_fill_skb_from_devmem().
>>
>> Fixes: bd61848900bff ("net: devmem: Implement TX path")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>   net/core/datagram.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/core/datagram.c b/net/core/datagram.c
>> index c285c6465923..35febc1c25fa 100644
>> --- a/net/core/datagram.c
>> +++ b/net/core/datagram.c
>> @@ -712,6 +712,9 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
>>   	size_t virt_addr, size, off;
>>   	struct net_iov *niov;
>>   
>> +	if (i && skb_frags_readable(skb))
>> +		return -EEXIST;
> 
> Are we trying to hit the -EEXIST handler in tcp_sendmsg_locked() so that
> we start a new skb? If so, I think we might need to plumb this -EEXIST
> case through skb_zerocopy_iter_stream() too?

Easier to EFAULT. It'd more consistent, and I don't care how tcp takes
it specifically.

-- 
Pavel Begunkov

