Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CEF38A718
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929030; cv=none; b=eXh8TxwE7qoHmUYTuY5u+HrZSbPCmN611LhxHAP81rQd0dUPaDgTzKpFLEddEC2DDOc1Rog2iRsSU43UG0RE4WzrxiWbdkkHNGBw1bWLy2DRl9G3EHQkULoAv8n3FLPHejCts1QcgCnQFcUjlHIRl5uOGmU6+Ur4RgDJvo5pc+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929030; c=relaxed/simple;
	bh=tz42eNd6WagsuusT0g550uH1iQuPtwD0rcAzzXXjzGQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=E888GF2ZsXNlNYyYO0lRhgA5MJG/j0P1PGwQqzaySHSVf/i07LN0JRuGopAnQOmvWYc0VdH/nHcVtLNKD3R0UAFFxNaXMRtdtWN3fFO3bHOs9iD7nbsW0U3V8eHWJCVDWevdaR4lOFZuHvy5P7pKvVGVE/kERgjxTHkDWce8F3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=br9x+myF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="br9x+myF"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-697de23bd7dso1427881a12.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 11:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1782929026; x=1783533826; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tz42eNd6WagsuusT0g550uH1iQuPtwD0rcAzzXXjzGQ=;
        b=br9x+myF9c7NZ0AEYfUsQcpEIWNbfamyuw6HHM+SIZDx8qgebdAhWM02lk107nIsoJ
         XOYVP27uIgC6Ji3T94WJ7G5uWgNYMbQH+CrD/nMRVTXqs9WsZUyQ7WsA7BTls5PLvoNS
         p3ve1xuSk24QqV0+KXEt3aq+WJ2+JNTvumVQDT54jjfHhsoi+T/BLeTD+qB5Na386YuW
         1CG+rQ+ES6ELNEqaC2UvGLKprJVpO0TzxNrLryG4BJOakC6iPTbDbWz3WS8zuqdHAvgt
         Of/4A8Ri+g1w0LCyv5CWyvm1BQsD7jpzubzXgFgMijwUN2jSGyD03fElGAgrtW9ARkyR
         L+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782929026; x=1783533826;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tz42eNd6WagsuusT0g550uH1iQuPtwD0rcAzzXXjzGQ=;
        b=lrpz864vDKMmAqUZ/bnkhvuzwHvdhTA7ntNr8pMxAQU3MNi4G//vt9lJ6n8nGGD986
         zzbvtw23nhcmy3Lnt+WRrmQm/j3ybg659c4WjkkbPhY+3cxq00U60KIEvfZxXObvKCdp
         ABOtp3KIe4OBx39vOuShgqABBUMCcNEXO53Woo0CIxjmwR8HXarOctTVt5IuKMWV1rZ+
         mx5RYdQI+ywoeDVclgF2XCxirBQ2nUXKATanRx9SVa3rEtC8s473YHQdZ3P+muDHo5X0
         s/AC1maIwd/SAjmdyJiyPwk/praELMsWGuItVI2+69YyKq+xTC8Fi7Kc7kXxggjCwjWy
         5btw==
X-Gm-Message-State: AOJu0YwH18puien1Tr01888u0+A08VaskDrcNAlzZmVAJQdpV+cF5rnc
	GM0KC68n5jQ5kDDs5klZleQ+gv4QcNIkmBKcmNJA9tZue111JnAjZhuXeHmn598d3rwDROwiwNC
	m9dmIhBqiCUMs
X-Gm-Gg: AfdE7clxG44MTrl5jSd22xbFplSVGNqAJh0Op5Mcxm9XY8utiIBTXRyBWAd92lSWvi+
	5/49GEUR20MSssZS+7qdBD+PmCWmm6CeO3CX3JH6hQb9qceafsJZlCBV+6Qolgh35+fc4ag7a0r
	f0V/FEKWbBa1L00+45YSb+1urApvxpOIVxxtbpoZxlkq/ohKZ41eQHjfwp1+ztgZOPY4e8AvZOn
	PkTHOHp6MLOQg0bmOjzZZIujvsdeiuMO3YRbQFTl0nB6vRgMrdE1hvUIUpSqaR99BiMLJa7qObX
	o/JA3p6m/TZohp7svzsNaGEZIgx25o+95hHYVIq3jHc47aX2xOWXPZeLfJlsFGvjfpIoco1k96J
	sFcmhBhqSF8ZtHutoW3G4nQXqI2U9TOdBWD5uQrUG74ij2S8+0FNGR7xb2ThAhaouMIxRTP7lzb
	bIC5QoCLYX505WYo0enNras8bLnIXP9nEKAhWOvcJJ+jU/DigwdOBb1tvxidzyf4IhxA9K/d6+U
	es9aeraETNgSonnA3/9lzIX28oHtWJrFkZyubW0eoelWXofhA9VdDWipAugIgpw9A==
X-Received: by 2002:a05:6402:1ec5:b0:697:e8e1:d3c0 with SMTP id 4fb4d7f45d1cf-698a2c5fe57mr972033a12.2.1782929026374;
        Wed, 01 Jul 2026 11:03:46 -0700 (PDT)
Received: from smtpclient.apple (83.10.35.68.ipv4.supernova.orange.pl. [83.10.35.68])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c93cb51sm3094335a12.14.2026.07.01.11.03.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2026 11:03:45 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net] ppp: defer channel free to an RCU grace period to fix
 pppol2tp RX UAF
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <20260701132552.nFP2AZrJ@linutronix.de>
Date: Wed, 1 Jul 2026 20:03:33 +0200
Cc: netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Qingfang Deng <qingfang.deng@linux.dev>,
 Taegu Ha <hataegu0826@gmail.com>,
 Yue Haibing <yuehaibing@huawei.com>,
 Kees Cook <kees@kernel.org>,
 linux-ppp@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BC7EE0DB-AA40-4E26-A7BB-002961F75B3B@doyensec.com>
References: <C954A7EA-AA98-4E3C-80B5-42C34B3183A3@doyensec.com>
 <20260701132552.nFP2AZrJ@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

On Jul 1, 2026, at 15:25, Sebastian Andrzej Siewior =
<bigeasy@linutronix.de> wrote:
>=20
> On 2026-07-01 14:14:39 [+0200], Norbert Szetei wrote:
>> --- a/drivers/net/ppp/ppp_generic.c
>> +++ b/drivers/net/ppp/ppp_generic.c
>> @@ -184,6 +184,7 @@ struct channel {
>> struct list_head clist; /* link in list of channels per unit */
>> spinlock_t upl; /* protects `ppp' and 'bridge' */
>> struct channel __rcu *bridge; /* "bridged" ppp channel */
>> + struct rcu_head rcu; /* for RCU-deferred free of the channel */
>> #ifdef CONFIG_PPP_MULTILINK
>> u8 avail; /* flag used in multilink stuff */
>> u8 had_frag; /* >=3D 1 fragments have been sent */
>> @@ -3583,7 +3584,7 @@ static void ppp_release_channel(struct channel =
*pch)
>> }
>> skb_queue_purge(&pch->file.xq);
>> skb_queue_purge(&pch->file.rq);
>> - kfree(pch);
>> + kfree_rcu(pch, rcu);
>=20
> =46rom looking at ppp_input(), what ensures that the skb in-flight is =
not
> added skb_queue which is purged above?

Good catch, purging before the free races an in-flight ppp_input() and
leaks the skb, confirmed with kmemleak. In v2 I moved the purge into the
call_rcu() callback so it runs after the grace period.

N.

>=20
>> }
>=20
> Sebastian

