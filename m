Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270542D7386
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467312; cv=pass; b=aJ7ckHYGO8p0vuBDezgMciISGSN8vifU0C21ZhubPT79RJimJ0qpLDUGnIlWYzQuNFDQgZ+Mef4N45nuo6DEfBu9AxWxwHz1/FRdX0vXGpWUQkQgjAnR4o5m0ZFPkdaSPYVoGe8Z08CaA6B5WmXe9JRResmC9iBV5E6EKOv/Sbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467312; c=relaxed/simple;
	bh=GxYaZEmMSfj5cqopxpHkz12DEhpzIPayu+f2kBBrl7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxAq/qOAf+p8ahItXP+jWQyqNdGTyL5EYrDRlSZweah3W9vTsRxSDgmD6iBY7UnFVNQaMtcbZO2YFcmZ2/tLNLo2NFyJ1A2HAtHjhtTgdbxaDzuUUwHilDCwF17esB4yTt1zfaU0tSD0/WvDSzS9B39LMNCQYoo7o3fz0tz7Lvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz; spf=pass smtp.mailfrom=sairon.cz; dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b=LCs1mMyJ; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="LCs1mMyJ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4b5bdd578so1416141a12.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 06:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791467310; cv=none;
        d=google.com; s=arc-20260327;
        b=mmeh98s0Znb45dFYBYAOpEgInZNVRV4OgzWbHAoLxdYW1EgZV+YtyKMPRHvE6XRNPK
         2THfntykdviJiQoK7WN5MhrIYqSHqR89xfSfoi2f4sPhLps3u8dzd158gisHChgvIYhe
         rqsayj96QcJkzBM8jgcB/karAkAyQN4dVPPQwj+ZP88JcZWMcqd/yItqygvNe/zmspRD
         203tuik00qm3trKGtn96tnj7otOTxAyvChvWA5kwXVBhNIqPQldEKQsHx6rFYzZ1/7jG
         bU+nbde0x9hhvK5EOGBiExZ7euPdclOEncmJ6uYStMFrvW6jTtA0RQjhlp32aSvr4fFU
         Ijnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GxYaZEmMSfj5cqopxpHkz12DEhpzIPayu+f2kBBrl7o=;
        fh=EBqoCPZaNXRyXxZlJHEKg2rAFhmb6HNVkLtw4QtdyAs=;
        b=W3z3M47MeDeXEihudxuQJvPLNuQIy6A6kSBIJIHoGt3s0Z0DKGJUwSVpp03RMHW8if
         kmgMx09FIXGNVtMC2sfb5Oa0KbfM2clHQ+xq5paFTJi/2JQCp1C68rxJW7RQEBtETxH4
         qSM7W9sSnQ9122GyRhcJMmpQGcsSPpm2xadslJyGD12geEMvZIL/LVYkxefKzIdQzHBb
         gPYhJfY/eOzZr7lNSGwjmFHVGHURYikSoKt94MPDd5Lj1udXcTOV3jJLlUbWOJy0y7WU
         RctHrv9PL78mzc+Tz5gwvUsSn+Ww8e0T+/9+raE+OJa5wB4lXu8w4yxqYh8hc5S3ZPCj
         Hg9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1791467310; x=1792072110; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GxYaZEmMSfj5cqopxpHkz12DEhpzIPayu+f2kBBrl7o=;
        b=LCs1mMyJon1k5JnMiOnisxp3qDbZXdZaUpxF/wwWHaod9t5KBkrIUwt2aVeM4UAEVE
         xdPvv2qV3aZ8RmjdH8XBXCtHE9uhAVNjYyd8kDxaBTUy3ZEjs6yd9/o8k7sTr6JGm47H
         /CMqen+dwS/xESpLLV0R9RGyUkdtEyGxS5sg3odyX4h46ugT5sZ84KyE0XqydZguHSeT
         hfOef0IV3fZ5H2ANDt0rSNLzWd+0Lk3AQDKr3KJ4LrgApEhkUB4P+4odeEfV+8zDbvM6
         VZEnd6MiXtd+/uvggp+eLZGDqPhO1nMoBez9bM1G0czyhTiY0DFz3rtiZ41U/v0JKU22
         U/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791467310; x=1792072110;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GxYaZEmMSfj5cqopxpHkz12DEhpzIPayu+f2kBBrl7o=;
        b=M1DIDb6FKLDvqNfZUK9g4rsAtFQOBGrpbHhOEv52YRgds4n/uYzzgC/EMQ4iUtadMn
         iBRetcYIFyM/Je4ul0zNiKjMwC5am6csa+AvhVOv3pfzEVcccWBBQ4pyAdGtDGcjRJ+z
         mmdyOZMEwU34Z0smmIBDL7Xlm5bNo6cHrNyg0VNTaNgWoFNeCVSSrbX45b29MXInCnKn
         vZ5H7NGK1k9j1B1Ov4GKJKSNKIECL0WRZEpGeEoKRddrwi5KpB+mvnsJ+pclVt0tZEnr
         /4SvkSaAKk6m++KPKvCjMwZLW9aBM6Z1nC7EXb1EwqN8+H+Ba1l10YKNg9wv+BWqyFv+
         /cmw==
X-Forwarded-Encrypted: i=1; AKwUvByr3nAKYaRcQAHLtJP005HbXxVGBZkasJU1LpjWkR+8ogwtlGTq1PZFAakdSz06m1WrR4LTgUQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mm2s7o8XQBW0z581CuZ224pa0oJRsqSlhEycQnDQfyvBy5MHQz
	TPdPFm5rC8am4Jj2Ycj03iP5Rfso9ZImXn7t8pVKw0wQ7qHv6PlcwnKVf4BQog58dsU9a23jbPu
	JuErfeSNvPeskHVD/YdANZDIfExhBwSGYygNotApnbA==
X-Gm-Gg: AYBFou37an0UWY2sCXwc563taCqaHsnUA2rjaCJ4MmPdT3gHen/jCYydKKVisOXzQ9z
	XeOGHd73bQDJd8yxRvHCwBQ3M3NNUW81mOu5BMWkT5a6h2FIYLIofz2D/CXtDltPYi4yG+G9v+Y
	L3clLD5YQ+/JdmlLCd/H1feIYjmiRU35fzVOA4YlgsM8zdK79Qzeb1CuW/2nYeNWgdC5IATFOTO
	/j/8ZMPmJZrAquAne2jtGPw4bzuyKFaHgk83/bfreCYSxqQKNgZN9D32ZWFbl+PE9l2NljjVKU4
	gwF9NkCZoI9NYGdCRNsr6QsrxPi4K1Q6Q0TVv63Y2BC6KIk/fJTv0bRT0HZLzjRpxDrd2EmV4XP
	LST7SFIoni9U3YwL85WU81VW5J6+LdkXZ7wbPsj7K7SsaDYVko5Po4AvFLPwfMSz1twjTpBYOuA
	eI9sB4Jn/ihQ==
X-Received: by 2002:a05:6a21:e58c:b0:3de:5a00:e248 with SMTP id
 adf61e73a8af0-3e134154c00mr4172366637.76.1791467310506; Thu, 08 Oct 2026
 06:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
 <a6193df2-98f3-409f-b73f-5b91835a0107@kernel.org> <CAL4WiirwF6bZwocErCthJ+TUu7wipRfSibRBoKWjjkA2nVSrqQ@mail.gmail.com>
 <CAL4WiiqSmW093PDngLrUNiNA5GVKeM3+tAO7KMDJeyjYZ7GRzg@mail.gmail.com>
 <4c98eff5-c8c7-43ee-b59a-adb833978816@kernel.org> <CAPa5EdDk+HuVP0H1+iqOcHDHZnfdika5WOQcgSaMtfRFWzqZ+Q@mail.gmail.com>
 <CAL4WiipSpufpdo-AWoNEJta-puLQ5hMyPn2xcjwg4vg67PNoyA@mail.gmail.com>
In-Reply-To: <CAL4WiipSpufpdo-AWoNEJta-puLQ5hMyPn2xcjwg4vg67PNoyA@mail.gmail.com>
From: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Date: Thu, 8 Oct 2026 15:48:03 +0200
X-Gm-Features: AclHuK_9cv-O-41xZVfpN6e8qZHktULAqfmGyDPNmDuHK5rePS-wDUMv3tjDuuI
Message-ID: <CAPa5EdC5+JiLCHdCt4m-sqM1pUs=fG8T7zsmVcheHCG8FFF8Fg@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on
 VLAN frames with inline tag (REORDER_HDR off) since 1517d1996b52
To: Eric Dumazet <edumazet@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, nic_swsd@realtek.com, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Oct 2026 at 14:48, Eric Dumazet <edumazet@kernel.org> wrote:
> This is the current patch under review :
> https://lore.kernel.org/netdev/20261008123812.554729-1-edumazet@kernel.org/T/#u
>
> Thanks.

Oh, I missed that, as GitHub "protected my privacy" and I ended up in
CC with its noreply address (which really leads to /dev/null). I've
applied that patch to our tree and started the build, I'll ask in the
issue tracker for testing once the build finishes and reply in the
patch thread if I get any feedback.

I've disabled the "privacy protection" on GitHub so I hope next time
it shouldn't happen - but just in case you'll be updating the patch,
please use my real address I use here.

Thanks,
Jan
