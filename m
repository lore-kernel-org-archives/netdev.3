Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781705;
	b=pLsv1gRES2fzzO63Ltv8R7rUYrtDcm2pWNwjjoVT/YVZrBXI9OY2QgGInv4wa4/9VqxY
	 TCR8R1pH89qG6lrWqdblxPmR7Hi7FnLgHK+hOxuE7wXle8AXbUpBQWz+RKXdRzyJEhYi5
	 zgr9WNhphmv3XRJtyzEPft2aDRqNRZJk+vuzwMX+kKI9pavqxfVjoLJeBLnkgul3Px5+k
	 +tcasw2govpHl8UtyAq/lo/qxVlUtqQbVEvqxxbrINWV87gN463N6KLZX5ZW0cIsp5ceR
	 ZI+XlxuqTGha+eyDOtoKFu43jH6s4sScTi/PxUjDx3DR4po1uGTeNK+EmCI+oImzOlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781705;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=tOA6pkU/gNCWHcJNqJZg0NzRYRy3OJtENBm4suvgaWI=;
	b=yV3XCVfD5oO8AYt3l8dC4wKkuvIC7S/DX/JBsIYdXd7+Y4P92hEjs7uRA7MG/zX8gfAS
	 huNoPMP8B5THekPMiPSJt7HXtmh7YhIYSP4BsDSlnKJyk5r2jmx/16Y4JuocYSPNqJ2SV
	 6LlG638h8CmaN/Pez0b3I/wEJUewsiIsy1r3BXx7XuJppP+auwhT/08hWCczmnqeUEq1q
	 ZHwHtT/Ho09rqSpCA22V0esk8qITHQGlZmt0X4i4RsWeQ9UK8LDWxQ3exMyeqWmmShVCq
	 td6jEU7A+gWU/4+OYfkPsJiHY5HSvhYaHKdDZ+crrn7I4sX7M5R2zeFJEN8UoVzG3YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YjOMFFH3;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="hkYPDeo/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83CA606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 08:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E83CA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YjOMFFH3;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hkYPDeo/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793781698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOA6pkU/gNCWHcJNqJZg0NzRYRy3OJtENBm4suvgaWI=;
	b=YjOMFFH3B4gbABFW7fjGUAsevGp1qOhYK4t+oEW42rYDmrTfX0E62gBogAS5/RJcqmxlkv
	BfutCBRDBbt42KXBnUTkR7eaTtR9oNFSniWhgBQ60Vl6TvZqkl7Zrc3lRxfl4jpALUXJD6
	+tyms6FTx143skW03MLdFS5gnHblItI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-0YiDLBk3MeuWA5bPKlxHAg-1; Wed, 04 Nov 2026 03:41:37 -0500
X-MC-Unique: 0YiDLBk3MeuWA5bPKlxHAg-1
X-Mimecast-MFC-AGG-ID: 0YiDLBk3MeuWA5bPKlxHAg_1793781696
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e0389d6f9so294951f8f.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 00:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793781696; x=1794386496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tOA6pkU/gNCWHcJNqJZg0NzRYRy3OJtENBm4suvgaWI=;
        b=hkYPDeo/+rw5xYOEw5/EDKXBZ44X6fnZdMHtvBQtQeO0kKS2SpiKEtE/sZOsk4+37W
         YJelI7l9+h3FrNSB1Iib7+EvvhPgnjUJ9eEEKINL9oT6Vte3FSIG7OinOymwWJp7u7vD
         DBIg2CxBjteS95KbwDdWLuCDVpay4zdX9DLRqjmRN+UWtkqfqSGqRXaC+dfOF4/49HWS
         10nACvG/WkkngPf35DzrZZIxo+nQDqrVyeBPm1HSEzKXHyR+9AaA7xFAuLhsxQt5u68p
         +n4b13z8gbD/0LXI5wNUevVBTrtd+Wz/HtHYth4j693qQpEwrqnwSpKaMOsPYLm7NtHK
         s6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793781696; x=1794386496;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tOA6pkU/gNCWHcJNqJZg0NzRYRy3OJtENBm4suvgaWI=;
        b=FnHVlsJYeJEgyb4OsG2uvMQnyua2olG9H5OPGIKzW8h4nrZgalkk8CMrhjTCbzXK5a
         /QRZYXoxUzZA4mAgHJvQ+jAHlrJ2p6yfnjIS+FxwZRLutowpRDZbGjnPma5s3TS1exgm
         4kms4sF1JpZhW274bWmIGNW7aojW9u+1TSJGjYwku35aEV0Sx2+pwl4gs7nvkal5DZQr
         YM3bSSmlLBeOziggKU+v4+hJuhNHUZtq4zO9NqsjAV1KjRihrUJSGukThG3nF/deXtED
         98PK0kZMmnoAFX6VduaVjhG9Nlof/Zui+ik+C5/7Xx1DBTlfoKKUr9HF1Ftm9iAZktjw
         LoxQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+RaT3JHVhopVgJUdmRyHGc37sVev0XGOfHFq1/hjeiRsmXO9JxAq28g1QTHp6MJPEctfCUsw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hpOK/D0oSG6Flg15vzL7cktcWEMYA3BpqouC4LbuRx2hDJ+ev
	QCE4ODPCks3wgMqttdErZWksajgR7mjhIPwGR7uInveZAfiXkc19LCCCuGz7/g6A2R+bV3Qqm4v
	J2tdMFH2ifwcAf79/7qToCdCxvxT6xnnsgUlUfnW7WCF5q/p+3/eKXtfoBQ==
X-Gm-Gg: AYBFou1vIpzoGUGajP8ShYXLTb6Ji8U9akRXYVgIc3Tr2plVU5UTclAUoimR1RQ9Mct
	6hExLLbTWYWT7jhJg3GR3T6j52q6c+p8aQ2LoAOjuui+2kMS0Lj8UuldA6MdKBI5sAsaoXjNJmP
	bbLPtATcEzoId4SSRy4pcxEyhN3TruVaYhDoOCdLTThrc6FRDvO2u98ZtoSA+WjS7oABs3CPvOM
	cukGFYJJ0Bn/TUUByqp1GG8Q5Jn1MIMPUW38Rd/g31jBqeGZWF8I+ab2MisxhC9UqFX9DGJ9Weh
	3BLZhTV78/R6JgCvBIfAwmgiG4zYnm0Q0VC++C/A5wgs30CSOT+jpsdlmXXvaqpGJGMBHSoAKVd
	yCEQNmJal+qms9sJ9FwBaCQ5M0bPUTVSmxDlfHygngMz7NiEyOdx7/2vgYUNZV/iFdWmPb1kU5t
	L8MfXffL4OwLC05Rz8QpbhqxGykTyxBkrgT7ZdvyEOZJk=
X-Received: by 2002:a05:600c:6099:b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4ac185bc1d2mr329183195e9.26.1793781696134;
        Wed, 04 Nov 2026 00:41:36 -0800 (PST)
X-Received: by 2002:a05:600c:6099:b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4ac185bc1d2mr329182855e9.26.1793781695664;
        Wed, 04 Nov 2026 00:41:35 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d87b5sm2470040f8f.11.2026.11.04.00.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:41:35 -0800 (PST)
Message-ID: <f029172d-855b-4e93-8a86-d4aff72c9abb@redhat.com>
Date: Wed, 4 Nov 2026 09:41:34 +0100
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
Subject: Re: [PATCH net] net: reject a negative TCP header offset in
 qdisc_pkt_len_segs_init()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, network dev <netdev@vger.kernel.org>
References: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
 <sashiko-outbox-194018@kernel.org> <DML39PMNWP8Q.7K2P5T3AG8LP@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <DML39PMNWP8Q.7K2P5T3AG8LP@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 23:46, Alexei Starovoitov wrote:
> On Mon, Nov 02, 2026 at 11:44 AM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>>> +		/* A header in front of skb->data gives a negative offset. */
>>> +		if ((int)hdr_len < 0 ||
>>> +		    !pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
>>>   			return SKB_DROP_REASON_SKB_BAD_GSO;
>>
>> [Severity: High]
>> Should the (int)hdr_len < 0 check be placed immediately after hdr_len is
>> computed rather than only inside the SKB_GSO_TCPV4 | SKB_GSO_TCPV6 branch?
> 
> No. It's already explained in the commit log.
> 
>> When (int)hdr_len < -8, hdr_len + sizeof(struct udphdr) wraps to an
>> unsigned int in [0x80000008, 0xffffffff] (> INT_MAX), which triggers
>> DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in
>> include/linux/skbuff.h:pskb_may_pull_reason() before returning
>> SKB_DROP_REASON_SKB_BAD_GSO.
> 
> Not a bug. That's CONFIG_DEBUG_NET only and the warn is right:
> the header is stale.
> 
>> Can this write uh->len (and uh->check in bnxt_sw_udp_gso_xmit() and
>> enetc_tso_hdr_csum()) before the start of the header buffer when
>> skb_transport_offset(skb) < -4?
> 
> No. The driver doesn't see this offset.
> 
>> Third, for other GSO types (such as SKB_GSO_FRAGLIST, SKB_GSO_UDP,
>> SKB_GSO_SCTP, or SKB_GSO_ESP), hdr_len remains 2^32 - |offset| at the end
>> of qdisc_pkt_len_segs_init():
>>
>> When (gso_segs - 1) * |offset| > skb->len, can qdisc_skb_cb(skb)->pkt_len
>> underflow in 32-bit unsigned arithmetic to ~4.29 GiB (exceeding
>> QDISC_PKT_LEN_MAX), causing deficit-based schedulers such as drr_dequeue()
>> and ets_dequeue() to spin in their deficit-refill loops?
> 
> No.

FTR the nipa sashiko instance dismissed the above concerns autonomously:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101194433.2637113-1-alexei.starovoitov@gmail.com

you can reasonably safely refer only to such instance when submitting
patches to net/net-next.

/P

