Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8121254B
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649393; cv=none; b=CiiaICend2BebsS4fC/ep790Yxpl+MkqqinUb/SjWBwrEX0pVIxH/ljE2ZwK4zIBKax6eLHrQ3VDjCl/RDnfgPTrFNdIWCiEjz80QAN5lvf/tTZq1FIYsN5c/5NRXqoAHr9jqiiE+LB5gFgTOZPTBSSP2gPDpiqPyzoPm3dJC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649393; c=relaxed/simple;
	bh=3wGB5TLUAM2lyPDgiHa7uRZvLdJWnflmXZw3/JXr6zU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AkVvPdfJLQVW56d/Pey6gBIJsSLF25Y9CpTOTPvCOJn1KJ6qXT4gIfE6Zs8XYzb4Jk9nLqSru8HNkd/VIC1+6AW83fAAYQ70JEDP821dM57tnwe6wpLuGiWNJ7JAGFRWi7QZpfjfvR0VkYnn5NVEBYfljOjkWchTBE8qOz0Nslo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiEqYifK; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiEqYifK"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76543e2so2681531cf.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 05:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789649379; x=1790254179; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B3RcLmLF2sXIevnZJMdQPOiyO2wTIg0xWGGUTEuoGdM=;
        b=TiEqYifKFNNp5GHeaYLhztdQjzfSez5JmH/3xTh5MwepleJH7sLGckLdXm6LYILSy+
         R212Bbh6Q0t+yzh2JA/ixm4GYxn+4DMaIhLWoZivu6cZDEDevGBdWfcWWvKxeyP20w60
         M0io3UQSjym9WANTM9vdu+E9OO8Of2HA9Dd7TSoOGX0wdvdhls5Usd6aduxiWFGZOWcu
         +3newBVOo7piMiZkqTJdgwX2MYHCvo6sKI4vOUwXw9vtYaPkR7ovW1E30z9BbKVynftz
         BBedxiqADNwzzDlGuvpRzMEqht3FIzbPZjQxFQrpc89j3wcMKjNs79XiNgjv7n9X2D8X
         wXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789649379; x=1790254179;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3RcLmLF2sXIevnZJMdQPOiyO2wTIg0xWGGUTEuoGdM=;
        b=vV7zFdCcU0YN0TqGtG5+Bv5DkCf+LV5eZD03+6yYtc6XrqduaTalGJRWHw8SL3AvkJ
         qoEeGhii1Sc8XawEwX/DDbfbw55dFy/ZvCqCrGBcS6KN5cuVun/21kYR988NnRkXcu/W
         vgAwkLC2/ZatOvGT35g0XoqVQErIwZWbM6EmN7AL3iJppFAkSMuC8lq6kVGc300L1+kg
         YJJnPP959LLKOLsi4rp6eNy2e64p7cnDnZ062eSA4p1Pkass3u07nD5bQJmea2TkKw+6
         pXo+hi5tRNeFNFglUciOgu57+Qr6VViFTuLyrfOas96pGmzY6pQCHvMc7Qgrd2EEjDhc
         cMbw==
X-Forwarded-Encrypted: i=1; AKwUvByflcYUD4q+QIH+kSoeeRXhKKT2nrYlZPvRsi4710hTeSN0fJsZuwhVOTBUBQcKdYbUi+C/yys=@vger.kernel.org
X-Gm-Message-State: AFuF++mc19cbmlccyB+lKptcEB5eefXsVKO9/aLoGmKhaQerQ9FzAN1T
	WbELN9ZoAxRuj04uDqMFvFemsrMyxkH5AZxEez+Ph9BgFNvfOR8xYV83
X-Gm-Gg: AYBFou1g6OcZNXm6jfh0LsYodYOPIta0tdfBI69E3zgg1fU3i3NSUtwe8aBiZWqt3yV
	3JRrJSG4XCDyv4lUcU4J58laPLOPraDLONol8ckvunIjLOZJonjGAH5Gvt6d6Z2MXz49tdeYUWU
	sO8sJbZylr4i/VW22BHjiVvN2lP5B3xKOCd+40ua3HVXIUIdGnaI/oDDZnYQFEednRDipH/ZEjc
	/dQhgzpC9PDzRjZt2vf6ET3V0X4ZOupm2bVq7DS2fHGvFEjClebRVAS36TQj4MjTKdK7lBaz1e4
	v6uax7AZeiwL+ioTt+heEDbYsgDUQvIeZ2srx0a3Z2ruMOrUcG+wyMzOI5LjauhScYs+SKiZGOJ
	LuiVKKw7kwD7FAJQQOb8Eo8QPy76lJzK1gzhGXhReif94UvWOBNuuZol6AlG2PvAU10yKA5tAAK
	ShuNDE2chFxW/1go68ZqpShZcfgOf4yR8fXu0zZE0NHgO1dAjYAY39CULV26dcL9FBORKdAui60
	Ft0DMSo+5ZhjtA=
X-Received: by 2002:ac8:5ad2:0:b0:530:d0b1:76dd with SMTP id d75a77b69052e-5328cfc03b2mr49321791cf.23.1789649379226;
        Thu, 17 Sep 2026 05:49:39 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5326204ad36sm48656621cf.18.2026.09.17.05.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 05:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 08:49:37 -0400
Message-Id: <DLHLRA8GVI5B.2Q1IRQG5BVJNZ@gmail.com>
Cc: "Simon Horman" <horms@kernel.org>, "Kuniyuki Iwashima"
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Kyle Zeng"
 <kylebot@openai.com>, "Michal Luczaj" <mhal@rbox.co>, "Hyunwoo Kim"
 <imv4bel@gmail.com>
Subject: Re: [PATCH v1 net-next 1/2] tcp: Do not allow buggy transitions
 between ehash and lhash2.
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Neal
 Cardwell" <ncardwell@google.com>, "Willem de Bruijn" <willemb@google.com>,
 "David Ahern" <dsahern@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260904033543.2635540-1-kuniyu@google.com>
 <20260904033543.2635540-2-kuniyu@google.com>
In-Reply-To: <20260904033543.2635540-2-kuniyu@google.com>

On Thu Sep 3, 2026 at 11:35 PM EDT, Kuniyuki Iwashima wrote:
> The following state transitions have long been a playground for
> syzbot, and recently AI joined in, reporting a lot more bugs.
>
>   * listen() + shutdown() + connect()
>   * connect() + connect(AF_UNSPEC) + listen()

Hi there. Thanks for closing these. I'm wondering if connect() ->
listen() via timewait is intentionally left open?

    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
 +.01...0.011 connect(3, ..., ...) =3D 0
   +0 > S 0:0(0) <...>
   +0 < S. 0:0(0) ack 1 win 32000 <mss 1460,nop,wscale 7>
   +0 > . 1:1(0) ack 1

   +0 shutdown(3, SHUT_WR) =3D 0
   +0 > F. 1:1(0) ack 1
   +0 < .  1:1(0) ack 2 win 257

   +0 < F. 1:1(0) ack 2 win 257
   +0 > .  2:2(0) ack 2

   +0 connect(3, AF_UNSPEC, ...) =3D 0
   +0 listen(3, 1) =3D 0

For PSP, this allows us to end up with a listen socket with PSP state,
because we don't clear it out in tcp_disconnect(). I'm planning a series
to remove PSP on listen sockets, and closing this would make that a lot
easier.
