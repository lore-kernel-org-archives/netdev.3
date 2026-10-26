Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013942;
	b=RLRPlXuCasZSDIzgeAIZHDEjT4Vb2n+Hmn7WegPDY+369n52T65Q/jUFUNe5sbavz/Wz
	 ojNfZOj18iXzLug9XuOsZpHSBfqtba3uo8dn2STTpdPt1Oly13AcezXys8Pb3xhcyF8Gc
	 eO7LXlfrCpO3b14KpOa7tFcop5mqAME6eXDmmMvNnYSfE7PKmH7XAKLvQqlmww4Q9XNea
	 07OCQMJtw2oZuACvlYgptqbx4D8r+XXZfCwksa6ad0vZBj0bQW+tlo6LttylVZi+vx7zR
	 f3/i2ByOrq2iIDO2zq2S6RZJS2+gNML2Pr/Dsna+xA47gzSngJ7YdZKoBD/9Hiqx2bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6eCgEceiFsvuqOLL4DtIMBpdvoUh9ThW46mPVQRJDrA=;
	b=uZJZLfxH5UC5pz64ZAcGOL5VIxkBKc8ny5xkwRnDeJF8pkfZYICNgwvFbIhfSsuoUOp4
	 c0+RorRemxJxocqnsXQIZykV+08smdas8xyTVACISPe12LYR5MHn7vsPSQVWMS/qHlpqT
	 kwuALnspEru4fSP0A5W/NFRwmv7R2bF3h9rHHaqqFfNipUjmSXdKXsbxzHUSuNNKw7ewN
	 +hL/8Hv8YkO5mPl6VOzcvLQAy33EaSbSHefDq6BccN8hGH5ZHSe2eSuspqmvBTrpYKYVs
	 wrbcWIj2Tm8HkzkcqpP3h6Kl+h87AaMobxl8WhJqpnlTgK3mieEDm1uIA2lzG2dCz6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eV5jybMS;
	arc=none smtp.remote-ip=74.125.224.132
Received: from mail-yx2-f4.google.com (mail-yx2-f4.google.com [74.125.224.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D41606A31F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90D41606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eV5jybMS
Received: by mail-yx2-f4.google.com with SMTP id 00721157ae682-8b0dbcd4b6aso5329797b3.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 04:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013941; x=1793618741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6eCgEceiFsvuqOLL4DtIMBpdvoUh9ThW46mPVQRJDrA=;
        b=eV5jybMSqOG9bpl2tJh0auk9VkaeAh9svu9HUTruj0TE6ut2p9ieQtaT4334wJijWQ
         j2OijJAAmWx+5EvpkGrgmmAdJy2eLkbVeOKuy9UDdGgvmdXb0o6hx2+gd2yCR1JVI7qg
         a/Ldlbva9AtFcMz/L3AtCnjN8Mtg9VBqhTq2HtkaFyxVFeLvTFMtOWXX1XIw4GfZK27e
         GdNhyZAMdopArMDhbBb5l3qliu+MA3NyZIAUJjn9S+5JpXKaAuWtmEjEEnaNLCiqi908
         xcW7Gq1PEIPwQTsWgFsWh2UKoIszphwpxcgTVAnJxXwhKbyINS9e6yxF1kQOZ2DgMrHo
         CJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013941; x=1793618741;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6eCgEceiFsvuqOLL4DtIMBpdvoUh9ThW46mPVQRJDrA=;
        b=jY3fvQJQzRb9gWVzzvTsTlytPp0prcm24gnHfuJjxtfTYeHeaRUpDXz3i+x3qzmpFD
         tS31+VeJ0jp7GlO47Qx5cQXG+hTQpcaa1WU6Q7HVQMH2noV7W10XqPDttBJce9Ux+Pmb
         5gqi37+UP5ZQUz/KYEI8BB6Q3g/eHoMc1M6Lk82iJGVG2tfH+VL/w6RAs9DOMZtokwCm
         LRg1F0PZf3RtWnAS9XHdJxdKob6bbtA3ljXLo+RPd14F25unWKzHtnevC2khmtt1ERQG
         9BtFv1CUDrHvAjLO7HIfjSfz2whoq9BZy3+ftuZYqJJki6rQxN58Ut9zv0YuuYoLHhaq
         0G2A==
X-Forwarded-Encrypted: i=1; AKwUvByYMQFXbq3Fj/8V4z8BEq3UtjprbYF7+WFq5rVJjHHdU2J9MmUfLqRETdkFtKKW/T3hL02RAi0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbat6dE9GDosh/nuSmEAlE+aNboU86pjlLeplITfkIxmZa1Gs9
	5uCPHSNHX0lIf/eYHai9UAI1xMGp5mbFsfnV1HCtFgOdYtJw9N9PITBN
X-Gm-Gg: AYBFou36uCWRX2VcOb6Lgz5+UsRN7hgPCWg13PdHhJWSMfVwJedTH/bXOXK84yz77lS
	qVF0DeZS+OU1ZHz1SKdojLIcWS7boYsj5WWV1seq48YYbOTewRhhzfbjTdEWvlGSTDWwwMQO79q
	m75FJWfpNvfhHZzajPAW9i/Q1KayqlAKOQ+mz7O66KG60p7ghBuDvof8D/dYk6nc0+8dM0qFwfl
	J3Nd+5L3Rx0dbim9oyC2k4fkbFSbfB0UwJMr7YOUVCA8X4X8DMaLhfYsRA0rpKpfGY7DYJ45sRJ
	mA864mwdRj40B8JmEForpxYkA8dK6BvknjLFvSOb4LmlEg9RsUbpWB4xcAH20WS7aBOncXSQEwQ
	2s5N4CJL7Z6/uwkAJ4AglZ938P/q3HuCR/1+55UjbSHWlToohoVJ1LVvsdCIvgScBIpG0kHPNPv
	+Sq4Bx3JdDM3QfgKfIuxm00psrdarM4IW3+F6DM7BseIN7V8b1TZgFgeKYiniLTCCsKpghVBvg2
	RMRmA9dKm0A5V9wreBmnE3XeNFGcW5sZlgmszo5xFuhXbgoS+DhzrqjC3sxy2Oi
X-Received: by 2002:a05:690c:2788:b0:8b0:eab2:f502 with SMTP id 00721157ae682-8b166c93421mr38305577b3.61.1793013941439;
        Mon, 26 Oct 2026 04:25:41 -0700 (PDT)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166c5d605sm29719597b3.5.2026.10.26.04.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 04:25:41 -0700 (PDT)
Message-ID: <c0c4dc10-8999-4c4b-977c-69beaae7bdcf@gmail.com>
Date: Mon, 26 Oct 2026 07:25:39 -0400
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
Subject: Re: [PATCH RFC net-next 1/5] tls: add HKDF-Expand-Label for the TLS
 1.3 key schedule
To: Hannes Reinecke <hare@suse.de>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>, Chuck Lever <cel@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Martin Belanger <martin.belanger@dell.com>
References: <20261025-keyupdate-rfc-v1-0-60b7756eccbd@gmail.com>
 <20261025-keyupdate-rfc-v1-1-60b7756eccbd@gmail.com>
 <c75aa5d6-5037-4489-99e0-3e38528e10d0@suse.de>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <c75aa5d6-5037-4489-99e0-3e38528e10d0@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/26/26 03:27, Hannes Reinecke wrote:
> On 10/26/26 1:36 AM, Martin Belanger via B4 Relay wrote:
>> From: Martin Belanger <martin.belanger@dell.com>
>>
>> A TLS 1.3 KeyUpdate derives the next traffic secret, key and IV with
>> HKDF-Expand-Label (RFC 9846, section 7.2). Add the helper for the
>> kernel to do this itself.
>>
>> Only the part of the key schedule after the handshake is needed. The
>> input is a traffic secret, which is already a pseudorandom key, so
>> HKDF-Extract is not needed. Each output is at most Hash.length bytes,
>> so each derivation is a single HMAC with the library SHA-256 or SHA-384
>> functions.
>>
>> Assisted-by: LLM
>> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
>> ---
>>   net/tls/Kconfig    |  2 ++
>>   net/tls/Makefile   |  2 +-
>>   net/tls/tls.h      |  2 ++
>>   net/tls/tls_hkdf.c | 82 
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 87 insertions(+), 1 deletion(-)
>>
> And another HKDF implementation. Maybe it's time to split if off (again).
> But anyway.
>
Yes. crypto/hkdf.c went away again in 6d888db2cfd9 ("crypto: remove
HKDF library"), when fscrypt and nvme-auth moved to the HMAC library.
tls_hkdf.c follows that pattern. It needs only HKDF-Expand-Label, which
is one HMAC here. If a shared helper is wanted again, I would do it in
a separate series.

Thanks for the review.

Martin

> Reviewed-by: Hannes Reinecke <hare@kernel.org>
>
> Cheers,
>
> Hannes
