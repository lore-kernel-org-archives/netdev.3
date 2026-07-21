Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970603BCD3E
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623575; cv=none; b=Tse4jQTBDv27ve3islQJihAgC4c8zA+boMeK4sTRXb3YnNoONdCNaVhw7h5VvmmxRBwwCjccS6NL0DlBaDEvRaYqt7RTmojzAJvWBlQkEBg2shiz7GGw4apN634IvCMgu97Oro940OvRidWTG688vrttUDcVN+G4D1edUjztEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623575; c=relaxed/simple;
	bh=YuamI1BxG38RiHIYx/SIZEAvWsuh5tk+e8yJqhhWbvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFFikvvf8dXH3qzVOBUERw8968/hhKZ3Duzg+DBoeXxKgeAOeP+MLAoy7APyA0w/r0XgLf2fMt5QvkjXP59du/4hUyA39VtKjW0UHM5oPThkQxpz/XKJMSJ+S564WQ9VQy0UQECYDe1It8nfSnORN4tR1mEVWJBoQe1G9EBqaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICJSko3a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W3Ly2wwo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICJSko3a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3Ly2wwo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784623569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1h/8U8rGpm6km9e/8IbvCjZFi5T4w4REAp5AhAlIpE=;
	b=ICJSko3ax9oDOQ4UCJ236jp41OBwXMyp8t9/njji9e5vei0rKVaqOHD47ugZ094eCVFfdr
	HAkif5OgR8OtIA8CJmehPnFQnRG0Hkfpa5Tjjeg1f/DQNXrw8Fd72IXb6uUkYU497w3Dri
	A3rgwkIfowF6JrF4rYT3wZmqAoAy5E4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-m6ikUF1lO82zAwfitQ79Cg-1; Tue, 21 Jul 2026 04:46:07 -0400
X-MC-Unique: m6ikUF1lO82zAwfitQ79Cg-1
X-Mimecast-MFC-AGG-ID: m6ikUF1lO82zAwfitQ79Cg_1784623567
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4926fa2cb17so33281285e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 01:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784623566; x=1785228366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j1h/8U8rGpm6km9e/8IbvCjZFi5T4w4REAp5AhAlIpE=;
        b=W3Ly2wwooicru2zoLyt+mIu9plU5QtHLTq4vhGYoypG4d8IVmd4nagqhuJ1+f4zVeh
         AFHBr+KzzsTfcV4SLNgBww/6Lrfp2jQwIfwjoaQKosFgWxZU509pfRinRXFpwVX46RSL
         IEGphSXqSywsIErBm2zmXVXeLBaplLTCgb6UGkMI2iVKCZA6VMgmT4M5CR9CVZx5ENvU
         w9vsP2AS65Hm1QWrY+pk/8HTUS+j0WM3+AMkqQqfuGikfHuvElZPTm+VbWMFBWwaVC6z
         W0dt5G+MdZ73nsmIpJc2Qt0/UHBg/qscD7kZHbPCtCLIg8HRM2uK06FjM799KoX3Odck
         qorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784623566; x=1785228366;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j1h/8U8rGpm6km9e/8IbvCjZFi5T4w4REAp5AhAlIpE=;
        b=DcTBW6syCbvQWRHsdKdghyYIOfwOiYVaxbJZbi82/7HgQtNR4/qFuu2bTMjbwXYFrq
         vstYYnEB+uDGEw+MK8SM6Br0vlPsT6sbrypaA58jYCuwtV+ZQRt0a8ai4KvT7L1Vsyeh
         ckMYXRPDttvspF7z2CRybrlhcGkbBMH/bo1UKxKevxdKdbhLyo1JWG/UDQojkT1ixo6O
         Q2HeCxGoIQ0FxcrQujMeujNnX8Py/ilXN1WtfIMGFi5ZJjcJLv+AnHXIJ27CzQ5RJt0k
         6m/95Lk07sUkUQQmgXhaJ8430iV7uuDcfwHxKS6b+MSCyz59eeY9eJPZT80tT3MUH+n/
         1iFA==
X-Gm-Message-State: AOJu0YwYpQuUcbLXoHpDDeBkHKtz2It7QYfb+XrsQ+OXJDK/bJ43DNAM
	DaYGGhpQrG71H3LLBgwy1R7al2Kg/mZoWWbAtHy9y2Ex8hCHLvfujGkrrus3xGdtb9q6spglRRW
	iKuSSPan/yvdhIH5ztjKcvY7NNwqC5LkdNxxmzrHWmYaKx008C7vvm3S+lw==
X-Gm-Gg: AfdE7clTq08UuvYNMRV2zzsXXOmkeNWh797gjWLRNo0V7/ISDRTl/s1o2HeqBh9hJgt
	rF3LL8FLolJVuKS637hXEIUSwiNPmH6U6KYqhI8WOoHRoMogYetrFWRRd7ucugcyDnQgmmea63e
	3ew5uX43Su2eGs4VaBYYBSBr/bUSidk4kegGmEm6lAMcunzNjkg5vhhxLPyIW/+PfDfXs0Rwwlz
	ImJnXRzJr/OZ2OUueJxuMhveqF/qplXaPqo1Xix5ewI7WtutDPNjDICiyjMhtZ/cABpff0RdEkN
	HT0hHu4dvuhWuLGbZ9OSQj4PyFDkOoZZhG5/vwOcO3X+o/r/Pdxv2FByZiVbBrmhMn0qExnLoMw
	4nqpj75mN3u/byj1naMjhyVLOJ/euDjDtYDW1w73rZG0RNdQ4Aj7z47loUPO7FOqODFkpxpuhPZ
	yzYQ==
X-Received: by 2002:a05:600c:3485:b0:495:6193:c6c0 with SMTP id 5b1f17b1804b1-49561a30bb3mr70805015e9.18.1784623566650;
        Tue, 21 Jul 2026 01:46:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3485:b0:495:6193:c6c0 with SMTP id 5b1f17b1804b1-49561a30bb3mr70804755e9.18.1784623566185;
        Tue, 21 Jul 2026 01:46:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495499d1d4asm227108515e9.2.2026.07.21.01.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 01:46:05 -0700 (PDT)
Message-ID: <4793400b-958d-429d-b2db-d39b7d757338@redhat.com>
Date: Tue, 21 Jul 2026 10:46:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 10/13] net: phy: add generic helpers for
 direct C45 MMD access
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
 "ciprian.regus@analog.com" <ciprian.regus@analog.com>,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20260708-adin1140-driver-v5-0-4aca7b51a58b@analog.com>
 <20260708-adin1140-driver-v5-10-4aca7b51a58b@analog.com>
 <CYYPR02MB9828A0F83559EF025D01A14C83FE2@CYYPR02MB9828.namprd02.prod.outlook.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CYYPR02MB9828A0F83559EF025D01A14C83FE2@CYYPR02MB9828.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 4:29 AM, Selvamani Rajagopal wrote:
> 
>> +int genphy_read_mmd_c45(struct phy_device *phydev, int devnum, u16 regnum)
>> +{
>> + struct mii_bus *bus = phydev->mdio.bus;
>> + int addr = phydev->mdio.addr;
> 
> You may want to insert the lockdep_assert here. That'll ensure that read/write APIs are called
> after the mdio-lock is taken. Andrew's suggestion.
> 
>    lockdep_assert_held(&bus->mdio_lock)
Since this looks like the only pending item and has no functional
implication, I think it's better handled as a (separate) follow-up.

/P

