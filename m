Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493694;
	b=ckhqnB5qf+8KQa+IFx1l3c5uY3TyO3uRS8U0yb65LgCHELGyRCuTak4a2TUIp/pv7WYf
	 EyWdnsBEdnbzDWIn83kC6cbzs6BXncUSSs9I9K9YeZofDlCSw4QKXiL2rnMj6NwEYkfPq
	 GuzCylUlRrY1eoAuGSC1Ew4I38diT8gud8/pG7j6FeGbUKe1Asg9ivZx+vM8HvQheTIG1
	 v/hJD3N9nQmNNik6DeOOHIWsyXkVjEj35GC920xKdhkQc2z9W1bOFlP5KC+wHQ8+n9lE/
	 rp1F/vjAjNUAAyikbvvBP027WHfkX+i0OH7IyERDqAm5tMjsIZ3HgBvOpbRqYqTVv8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493694;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Rc9bf8NN613bIi8UJTLUeEhOmQUWktCfilbKq+1NuLg=;
	b=jdniRSE3yU75kdDmn8SmY79T3oVxNHK1tibY19t+/6Qorafje8B8iHoSxQI7mDY9efac
	 pp7R2LjELCc1EAfy87wlzEqXF529a1mOx0p442g0CuhRq7Pp23k/zUhw+PPzk+QTIkeTo
	 lKTe0mA8c/Kx69sfudhf6vrDg+TlAPjNIN6EepCHs+g3bwceD8HrElpWVlDI2hGwbGJpq
	 Ae7CNfGdLQ5a9qa6/qtIwMwSlE2yIdo31/nYbJXrxjlLXaRowdDqWH4dUCk/YzkcUFeWk
	 bY3/a6fJvXubjHDGcHOpjKbDP4Rsg2an26+3z+UeghNH4NsdeppEKG6z6za+utzGzSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ch0w08DL;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XEIeebje;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2034606D54C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2034606D54C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ch0w08DL;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XEIeebje
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794493692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rc9bf8NN613bIi8UJTLUeEhOmQUWktCfilbKq+1NuLg=;
	b=Ch0w08DLquo/MLe3vXT7N8xsd7o/Jq9FqjHyz1ARzFAyef3kblh5ATY7MpfJnBxIzEZ49F
	YalEFjvhZiqj4z4KN3OH2moAWP2PXWkAVmdctBw67FvjNcbB7TbVw2csrLSceKEYEu0x3Z
	hAl1PqKM0I2xFzbatiLdwcBtf8zCRBU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-TfnZj2wiNUKh8BQ2v5MAmA-1; Thu, 12 Nov 2026 09:28:11 -0500
X-MC-Unique: TfnZj2wiNUKh8BQ2v5MAmA-1
X-Mimecast-MFC-AGG-ID: TfnZj2wiNUKh8BQ2v5MAmA_1794493690
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4b8b3cd61a5so5243585e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794493690; x=1795098490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rc9bf8NN613bIi8UJTLUeEhOmQUWktCfilbKq+1NuLg=;
        b=XEIeebjesgm/l0zQ6wDtEuFi5RLFtZgPXWTOOgS/vwHYC2SZzUTH6SiTvBq73tBY6T
         aDQBm4e1hmHrF0gYjNdg90OITLZx1iCF6NUJ+At7UCG9Z685PIxFk1xEQzEm7UW3hlQc
         P1Yz0KqQTKX9bqfmFaQY7vuOVCc7QzGue/bkN7a1+WP8oXTCLPi1P8uTbaz3ln/r7lNg
         RqjmiuqCxuiTviWyP3yia2dPep/TpdQYWJjxyk5Qc2xtbnnK+2y03sCIUg2Cb6IipdDG
         3dRl1kXmN1AiiahIV3S0+Rhtv0SzcMa/kGPQrhWrDhShpM58YvCIm7RjBZgccLfoAlfF
         9Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493690; x=1795098490;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rc9bf8NN613bIi8UJTLUeEhOmQUWktCfilbKq+1NuLg=;
        b=WuCz09cn5+sN3EcrzU1KliLJyvtskYezRDWC95neJRiUQbUdv66TKwW7u7hfDcdRdz
         4ZlUI3WJF1FT1XsaRQXsWM6MBzc5vbtDCTChWDcSknuBor+7H/8Oq6FR/59OdOpb6PXn
         Iq6LDyNaiBhn2mrAPi3fBFWf88VIUjH5gN/X+L/3/gIyODApfzVdeEIlpN3bJ7mZXgoA
         ibAx0ZKOPM6A1BQRc2t2xboE//S2jI0nYujoAI9aSB6LH7iUwS3/avPn5l2GC7kR1zM6
         Z3mzZPRLPDzAlvWUHpwOkDZHqCv6IqAjKkAzKFyd5lEvIio6zyBuB7zEBCP4sKd21YTb
         yjTA==
X-Forwarded-Encrypted: i=1; AL+hErHKt7ITFT3vxoBur2IaLBHM9J0PRqYFECN9OHKs2GDlX98FGXiB4qv2QCNyrcaDlfBZ4tVarmo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kNo1neR0jMCh8amqefM9B44/4Qpi/d3pnlNZWI9LwLw3G+QLd
	zCRB+TkzaGOHui6/fP7vXdKnimYeqBFP/rts3HzfnqOK8I/u9UHgsfmHuIYQaNVsgMIoRJAvRqx
	24MJG6dWGSi9AfCNt2fijLMTCS7RIn4HU5jeUN8zjQ4kCDT0rZkhp/ebVmA==
X-Gm-Gg: AYBFou23edmg2sCAo8zBVg4exoSAcqpwGhj86zKdZ3/qtczt7F+/jKy8UQADJazCWel
	aItNNclPo1QlquCMave35wUlSoXMGlL2zuqrKUPTAwAwrea5OAkWn0ulNjcDJJwTRttQwv79hsv
	3lazIcwSqNCrjcC7MmEiB72yplxYUCFVbcRSvv9fnQihBrwAytVAXkt/PSauPMmydLe0a7sQSIH
	euyPYcaNeQsiOqiueuSwq7+/YB7QKUkQMqJywdKsolzwWMYL3+6Y6eLNNgbA5ebVGOCn6cc87b1
	EE8ZiA3DlGgsEEMvWv++xlbUJ4jeWBmQ+Hv1SvavpNeoo75In8sSRI8vi/sheh2kOEnHRyQi5S5
	+2YRveJjw1F2485ebzqHzXT+oDm/pBlqRUK6T6w0WqMSrTcENcqZiLviJbu8DSYwcFMOuOznioX
	v14JqIQ6T8vFe4OsZ1N/HSNpvR7KPaDEtnQ5pH+KzOOwiS
X-Received: by 2002:a05:600c:8183:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4bb4e296cd4mr53828345e9.16.1794493689816;
        Thu, 12 Nov 2026 06:28:09 -0800 (PST)
X-Received: by 2002:a05:600c:8183:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4bb4e296cd4mr53827785e9.16.1794493689324;
        Thu, 12 Nov 2026 06:28:09 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb51f3cbf9sm40266145e9.0.2026.11.12.06.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:28:08 -0800 (PST)
Message-ID: <2fb8d2d3-9840-4e1f-a02d-877a9b93593a@redhat.com>
Date: Thu, 12 Nov 2026 15:28:07 +0100
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
Subject: Re: [PATCH net v2 1/2] ipv4: recompile IP options on a private copy
 in ipv4_send_dest_unreach()
To: Ido Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 Kyle Zeng <kylebot@openai.com>
References: <20261109131736.3060756-1-edumazet@kernel.org>
 <20261109131736.3060756-2-edumazet@kernel.org>
 <20261112134645.GA3195113@shredder>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261112134645.GA3195113@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 14:46, Ido Schimmel wrote:
> On Mon, Nov 09, 2026 at 02:17:35PM +0100, Eric Dumazet wrote:
>> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
>> index 3a90c8d28b940bf615c165d9b30ac634943586e1..9af72cb892034deff2bb3169911c02c025d73cf2 100644
>> --- a/net/ipv4/route.c
>> +++ b/net/ipv4/route.c
>> @@ -1256,6 +1256,7 @@ EXPORT_INDIRECT_CALLABLE(ipv4_dst_check);
>>   
>>   static void ipv4_send_dest_unreach(struct sk_buff *skb)
>>   {
>> +	struct sk_buff *nskb = NULL;
>>   	struct inet_skb_parm parm;
>>   	struct net_device *dev;
>>   	int res;
>> @@ -1271,6 +1272,16 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
>>   	if (ip_hdr(skb)->ihl > 5) {
>>   		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
>>   			return;
>> +
>> +		/* __ip_options_compile() writes into the options, and
>> +		 * callers of dst_link_failure() may cache pointers into
>> +		 * skb->head: work on a private copy.
>> +		 */
>> +		nskb = pskb_copy(skb, GFP_ATOMIC);
>> +		if (!nskb)
>> +			return;
>> +		skb = nskb;
>> +
>>   		parm.opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
>>   
>>   		rcu_read_lock();
>> @@ -1279,9 +1290,11 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
>>   		rcu_read_unlock();
>>   
>>   		if (res)
>> -			return;
>> +			goto out;
>>   	}
>>   	__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0, &parm);
>> +out:
>> +	consume_skb(nskb);
>>   }
> 
> Not sure that what Sashiko describes can happen today, but I wouldn't
> rely on the network header not being in the headroom. Something like (on
> top of your patch):
> 
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 630143ca0f31..77c03620f89d 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1282,6 +1282,10 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
>   		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
>   			return;
>   
> +		/* pskb_copy() does not copy the headroom */
> +		if (skb_network_offset(skb) < 0)
> +			return;
> +
>   		/* __ip_options_compile() writes into the options, and
>   		 * callers of dst_link_failure() may cache pointers into
>   		 * skb->head: work on a private copy.

I think the above makes sense.

/P

