Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147128;
	b=TeZH2uqxRUHJsBhS5np10Em8xm9HM/+M37AqIc+Sb3jc2tUpjCHL1W0BJa0X7syEokZv
	 pD/IQi2T7Prx8SAoBrGnvfj4VdfhTG9HPFtaIy3CJ5zCHLp58XrKBCHilU8AVvWDjgkPa
	 9bUhX3cPaYs9OBYjLyL1LdOptg71lEJ/XmKGqIjXpCU/ArxRm+A5esJzKbVWIv4OyUgMi
	 803olqyjqITxivz7gLGiLWSSR36ZZqqFi0MOQCa7h5xqebOBEWltK601LpU1lUdS7bfZM
	 YlYFo0TB4cbV9I67t9GRcKqUx97MVJg0pHtu3ArwEXYtKjMiLJ9I71S8SrR1AMcAwiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JIaZlR1+78hwd/ku/8utqk2QTcK+/IJ9jh6fcvBKyxA=;
	b=mEssRvMEHyQvTW7gK1T2LG7yarCwwDaUkQ0UKhmU01q0PaUmstmtTNjqv+oYnVBC2sHY
	 Pu8uPSH8/tFsVtYhb/10AHyJWiMmB3uQ3JUA1U48banwwKNEduj25fQdufseSNCi5ELNk
	 g055Uy2vXiK3cuenqgSXs3ZNNnCZmm2bMOxst4L6AqOymwcFc569FpMH5UiZ71DFjs/Ge
	 u9qm84CyTxVLMpQC8HmHQwa7/zhBcPP0GUB8qb/Ip6I4CKDt8uGp7++sCB2CRTKBcv8l+
	 08481ae1R7PecmdB0eGbMt8sPuaLPyCC5o+sIhSAyaLWf7QOzhWG9EFkvTlRxrO8MQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xEvDusG7;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F525606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 14:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F525606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xEvDusG7
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-49134c8509fso80211f8f.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 06:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794147127; x=1794751927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JIaZlR1+78hwd/ku/8utqk2QTcK+/IJ9jh6fcvBKyxA=;
        b=xEvDusG7e13//Nt5/Jj6aSpbDpimRN26HoN8BTJhklcFFbALqrGbSpU9HVRvrBvN8d
         iQFFCGJgjdF+7qUz1yejuQim9bSJUcsJohaESpp/f62aQq3JoGzHmvgQ2VbvjjPRez25
         s4ZgguMjlgpxJr/zM67gg/km4Hsvvbci+npWtm/0j1XJP2+VgMO4uROMP4iVfw86IITB
         0fwmhjrqyAA9pDvQWcKIEZNCVYlQXGoSUswEoKvJ9JLQtysMDEcaBasrylmFXemfcDqu
         rUKkR39ABHbP6oB9abwJ3fvcOqglcpPM7W1gYVCnAh1wdB/R4cuWqqby1wFWN9zjuk62
         MyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794147127; x=1794751927;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JIaZlR1+78hwd/ku/8utqk2QTcK+/IJ9jh6fcvBKyxA=;
        b=n1XksahF1CxvF+B2ZqBnIRMha1f+GdiUH/L2gxqlIeqtGamyZOVwGvDEFdpkXEp+PU
         KvDfoebyU5bwc/35DWRJs+uZtz3WdKQ8OAteek3LcskETv7M7yZpR3x4GXvi1zKEp/ai
         2KCw15geG4NqQmclP6uFIuHB3NBfJZPUgGptfzD3/49W3OzcNEjGj7SLR1+dRz4oYtmF
         77TvIHdEEzThgYJ6Ukm1BQMoCUeKq/BmCCzZ+JLQYoxdvFGp6J10wkpGF+eEkNY28ieV
         u2wQZ6bss643MrsCRjiIRCTk3f0qZSLkoeBDLTy7yjZWu1XOKNvYkIcJqYCPyKlMBYek
         Xg5A==
X-Forwarded-Encrypted: i=1; AL+hErEnwSQvNyaUaEB5uc/1KWT495R41aNwNjkmkqKWyh7iv2aHOGodNKCKWHB9kwG02nEuBa+24R8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bK4FTK1og4xXOotIQDD2qOONN3+/NnJg8moDW1N5Gct/hvhpT
	D5sOZHsGuvaMFMch8T2LUpMl1xa5iG7c/ztmlhhktVz+q9/eHJ2aR1Ug
X-Gm-Gg: AYBFou22wzCYSGaL3E9hN95IRNod/QgdyGlLsSYZW2ZQkdsfJcMD6pJI35vP3H/Tk+F
	OFsqh03JcfeY5ds8TCaVXJmUQGrsUJf4DO5Bz4zli/aE5cohvbRwY/d961/uxIBYNlA3OfsQFMM
	aOtbSrkbKSd8nsVSwOQHL4Q4D3s2xxL+6tpYkE+txa6gO4osN12r9eA5KKvc2K2VcrHgn7tsgo0
	g2RXheFA+iKR4zOx0AJX/24ptH5gvXMfgttMQtaKv0wKqJvAAeDi3yntC3AVOQuNxzy3GByd/4H
	N8sximf1nlpCI6ag+OJDn2ed3RJ3dzcAEQqw56nBG2QKrYftgT1r6C7AvikVo4GLUmqueaZ4EQp
	LtqSSOHBytIJ6aMjHrDEhs666NOW/pMCd9KObj5ekN9CJaZqAzcVw9NzBMRjbA4xdOeU5WZC/P/
	42HIUCT8TikH4zlE3ltB2IvCpkgOU6OKOpsnGI+g5zQpN6QrEJM4/aCM0O6wzCYrWipQ+HDym+D
	9neyTPr3dsZy6b8GWag+rdPaejbWi+2alrqhu5wBL/1/EpvpcpeemWK5yvon6OKgp3fKamW1hYK
	MIBOXMydtSr0ein+r3XeCVsdk9ezbharFo8R2IiCwZlsLTpzPZTdGNlZ7VAFv6chwRf2iPHCEhn
	HxflCvIlk+Z/qWdUl+iZPgLkBGisJlCacxOICg+DYNVF+wOeur6Rwv8VGDkPzeiXF3Q==
X-Received: by 2002:a05:6000:2310:b0:491:8286:5f0e with SMTP id ffacd0b85a97d-49585d9a986mr2902049f8f.55.1794147126685;
        Sun, 08 Nov 2026 06:12:06 -0800 (PST)
Received: from ?IPV6:2003:ea:8f45:7100:cde5:5d75:8598:b64f? (p200300ea8f457100cde55d758598b64f.dip0.t-ipconnect.de. [2003:ea:8f45:7100:cde5:5d75:8598:b64f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783f1d6sm4215028f8f.46.2026.11.08.06.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 06:12:05 -0800 (PST)
Message-ID: <d85b02e5-d9ab-4535-ab82-9b8184fbd1a8@gmail.com>
Date: Sun, 8 Nov 2026 15:12:04 +0100
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
Subject: Re: [PATCH net-next 2/2] net sysfs: simplify creating empty wireless
 directory
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Miller <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 driver-core@lists.linux.dev
References: <0a0a7987-abb2-49c8-bc16-3938233ae9c5@gmail.com>
 <675f4353-125e-4168-a617-c0d1fb519045@gmail.com>
 <2026110816-crate-tightly-8560@gregkh>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <2026110816-crate-tightly-8560@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08.11.2026 15:06, Greg Kroah-Hartman wrote:
> On Sun, Nov 08, 2026 at 02:46:03PM +0100, Heiner Kallweit wrote:
>> Now that an empty directory can be created with attrs being NULL,
>> make use of this new functionality and remove the dummy attribute list.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  net/core/net-sysfs.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
>> index 5c0402389c6..f58b59e1126 100644
>> --- a/net/core/net-sysfs.c
>> +++ b/net/core/net-sysfs.c
>> @@ -910,13 +910,8 @@ static const struct attribute_group netstat_group = {
>>  	.attrs  = netstat_attrs,
>>  };
>>  
>> -static struct attribute *wireless_attrs[] = {
>> -	NULL
>> -};
>> -
>>  static const struct attribute_group wireless_group = {
>>  	.name = "wireless",
>> -	.attrs = wireless_attrs,
> 
> Why does this want to create an empty directory?  Surely you aren't
> adding attributes later to it, right?  If so, that's not ok either...
> 

For compatibility reasons. See 38c1a01cf10c ("wireless: add back sysfs directory")

> thanks,
> 
> greg k-h

