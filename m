Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988447;
	b=E03SBi8sAPd6nYDwAq4LYWFuJBDwh+/0h/+42Jf7I7aNMUZNiCLgKTSy8MJ9kTVzveBZ
	 pdLJaihvVG3kuNG0DS/bWLhqui/eepfz+OEE6oPeWWP2xreZwLVglComn2PfcEyyU9TId
	 I/ri5ax3EFLS2kwwBVn+bFeszeIZYPce1ayhy7ka2iko084hatxtu4OE7HJ7klBe8HyEJ
	 jsnAtmqJhj6eU7ljbKvE96bgh+bFV6nRZL3s/naOkvd1hlUit/ESV/xpYGgJ5ZhWue4bM
	 zD1QYKjISWlhgKiOUkNLmZaCc2ceX655QGB6hC5KVZGDece84JB8pBIQ0+AePdzGSpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:X-Google-Original-Message-ID:Date:From:To:Cc:Subject:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aTv8lkvWYYtmkfaYVZ3RQ1F7LBmnW9Tpy7fJ2ahU4OA=;
	b=nw29dfv1+4Bhw3ctIDcPJ/3HAsD1fd9fU2Hnu5vAsK7szROCWxmN6A4yB6ROFdWnJeIG
	 I/J9VJ64L1BdVxKvefWpVidHzHW7b/lwOHdT5RFg9BbqTE/P/CJPStZkkFoQ4ZkQ9cZb8
	 BY6uC9qGNS0tfgRkKxjmD0Lh5ad00eeL2g8WHyvrORzqopodEwwTc/WdjH/Fhs9S/h24p
	 62oPCMIKiyyHIb3iRd4Tx8F18Vd+mgOvjCjFL0nGpQyjYATb7TBO8avhZX4/ddY2++Am5
	 uxaN4YXhc4RuNwV0wUbXbG52T57oVPGGlWS6UBVyNWVElzBKcSFDN4n+OvUtloXjD/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KbUnUMSQ;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A40606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 18:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1A40606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KbUnUMSQ
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so8250415e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 10:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988445; x=1794593245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aTv8lkvWYYtmkfaYVZ3RQ1F7LBmnW9Tpy7fJ2ahU4OA=;
        b=KbUnUMSQd5t/j3E8RLeWdRCbRs0NdNgN8nMaCA7IO68kJqdioMqCpQLNMJH4H0g87o
         jrPY6IFoGXEboP6vHxQjNYNzF8wXguVzdux3dzoziKp74LeuS5qIi65/5nKsvDqnDH/V
         FrX+vrC/I2hrZB/I3gF5ojm6t88sjkIBy/sOBiD8CngKhW5TUJKilJA33nUQlKrhJqNv
         wk0D35TrgHIRvrHGAUuHvuroitlxoKWC9QkhURo47BzCXoGHGZ3hvKmNC2OoxMoWDKrT
         gE7vAnH+LFd5qAX8P9ueSn3H031ktjAbRGYmVIs7FywSivan/EUkuilJsIYtv/wc/0WC
         dnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988445; x=1794593245;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aTv8lkvWYYtmkfaYVZ3RQ1F7LBmnW9Tpy7fJ2ahU4OA=;
        b=yGrOXGzerKLOIoTVinm9SiE8U8G+gTe8Qy7VYFwr4A2x52TID4fAzmILwUVQq5UKbq
         PIHJsWYsSM0hIwpXGvevlBAK2KFcEPCc6H3M6misQ9uWcP2IOzeEpaypELq/twLb29h+
         +ldJpNhAdYzMLQ/kfEmcppiZBDi5Zbecu1I6HIIzbDJ+vdjEib4CNmlH+PE016/q6yuh
         H31CvkeqGlvCGE0UtzoapJ7Q8swkq3EAgUFkmQrVzmqrz68ZTyGcSE8kMsTIiqlJpML/
         SIuUCwlcd3iX4nMp0dDdUu3Ec4P9+f8xCjIoSnI52Df4kLgykM2ljt7eKGW5hgbZL+2V
         +3vg==
X-Forwarded-Encrypted: i=1; AKwUvBwpvhpgNtL7/sJmIuIW7wYijj47mAhNtGq4Trf+rIwYmn2OjhxCyqzsZTCCfwCtrjRjS9GLHQ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wn5+j+3trnkh8bx1y80yZmIo/tYmntWeheBfg2KrppAPLCx61
	jE6ke3zB0BzeMuQnBRgH0gkOwx+usPWvp7qiEZ3c2l3XafUaORxxyXEb
X-Gm-Gg: AYBFou2xb3unJmZpjBPVP1EBvo35LBCVws+f4MEn2QOxR21hAFS3Snz7jK7CpDju7f5
	sxrj5J0PHTj7DwLi0JPSUEkYnwgU0l9eKXooGQE6EF2g231stSmF8VRnytw1cDV+8lta9dq/TeX
	qP0m4JEqWqO2EUKLXL+pPEfDHNAO7o5HLuUoCVifIsULe7l1jMvSpEyHGds+8wBCcq8HJmD7Kp3
	Lw4Lazcra0OkTI004ZEYN7Bf11kMxFN8Pqpq9AyOkxi7fekrAR0rjosTuX0qZolpc3ytmkP3A3u
	3a1e8MhbejeHd5CghGXIa9dc9hEf+Ymnu3JUA5RxeUd6Qm1HTdRnl+QRhd2xv4/tbuvSrZrmjuu
	lIFXdqW5oIrmDGcscMj1ksZHSD5bhHEoWoAr5J6fvmf5vFtSMMNxYyeci87fXvYe8lgP0CYZXxK
	ELuuMQm3mTWbRcPgivUZZIXn8xQhN6G4WUFbvtIdE54ymxZGCY/Jg63p5jJOFXoBLyqdVJIj24h
	dPUWe4Y35n8LKi7vlyxD/C6UBw7POFSjo5V0Bd8Yv6Kz49gc6M9JMsIuNZia4LDIBdvMQ4IIEQb
	VH+tixab/DzisCTmk0z3ZSyf9IJPO/e5jsYQBfLquNLxANSpe9vMCc2JqUKbo/rY39CbqvFtfj4
	hIC75VTT09cb7NcQ=
X-Received: by 2002:a05:600c:348f:b0:4a1:f377:5c6c with SMTP id 5b1f17b1804b1-4b6de788f12mr56588375e9.10.1793988445013;
        Fri, 06 Nov 2026 10:07:25 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-148.ip49.fastwebnet.it. [93.34.90.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7c8a01afbsm64905e9.12.2026.11.06.10.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:07:23 -0800 (PST)
Message-ID: <6aee175b.f01aa0c8.37eba4.18ea@mx.google.com>
X-Google-Original-Message-ID: <au4XV3gQmbXyvqIA@Ansuel-XPS.>
Date: Fri, 6 Nov 2026 19:07:19 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yongzhao Chen <yongzhao.derek@gmail.com>, netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>,
	Stanislaw Pal <kuncy7@gmail.com>
Subject: Re: [PATCH net-next v8 1/2] net: dsa: qca8k: let regmap serialize
 register access
References: <20261104120130.48455-1-yongzhao.derek@gmail.com>
 <20261104120130.48455-2-yongzhao.derek@gmail.com>
 <6aca850a-ef67-4451-aaf2-977be884d1b0@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aca850a-ef67-4451-aaf2-977be884d1b0@lunn.ch>

On Fri, Nov 06, 2026 at 02:38:37PM +0100, Andrew Lunn wrote:
> On Wed, Nov 04, 2026 at 01:01:28PM +0100, Yongzhao Chen wrote:
> > From: Stanislaw Pal <kuncy7@gmail.com>
> > 
> > The regmap is created with .disable_locking, on the ground that the
> > qca8k read and write callbacks do their own locking. They only lock the
> > bus transaction, though. Since the driver moved to the regmap
> > read/write API, regmap formats the register and parses the value in the
> > map's shared work_buf, outside of the callbacks, so two concurrent
> > users can swap or corrupt each other's register and value.
> > 
> > Most register access runs under rtnl, but not all of it: phylink's
> > resolve work (mac_link_up/down) and the LED class callbacks do not, so
> > a link change can race with an ethtool or LED access and write the
> > wrong switch register or read back the wrong value.
> 
> Do any of these operations which don't take RTNL do an open coded
> read/modify/write? Does the regmap read/modify/write operations hold
> the regmap mutex over the entire operation?
> 

Maybe I'm just tired from destroying board from my HW project but... I'm a
bit confused of when read/write are not serialized.

Operation of the LED and on the port have their own dedicated register per
port and for shared stuff, there is a dedicated mutex for it.

So I'm not sure what case this patch is fixing...

Both mgmt and mdio operation locks at the start and unlock at the end of
the read/write or rmw operation.

Using the regmap lock seems redundant and this is why I disabled
originally. 

I would like to have more explaination for the 

"regmap formats the register and parses the value in the
map's shared work_buf, outside of the callbacks, so two concurrent
users can swap or corrupt each other's register and value."

case.

-- 
	Ansuel
