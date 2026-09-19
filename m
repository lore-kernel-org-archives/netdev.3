Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7323ABBE
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 03:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789789912; cv=pass; b=ZOzTWWHIfEwykNvnIGod1gwX5oDl0tflK0ky27utUu3DAr/O0Zcx7O3fWvMRoOzBMjXRNVOtuALMIylejki5SD1vforI/W+n6B6y8nhI4LKU43BJhNwH8ehRJ0NZAD445Wy4CT+USyDmgdB0bNsiQxUFXekETa26UxOXjwV79AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789789912; c=relaxed/simple;
	bh=hTa0cJ+wIISdMRyCZeKr42I5DMGv9YFDWO/5UDkL5yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiDZHB6+luscVEVuZl0fAGjeCWJRLDg1fpa6DHiXBCJ2U9BHQ2Wv5ui8dhdLkuF9dd1QYfoaGC1QF+eQaW905XCxf08a0w/1ADBMCCMLjskMigPwrMt5aaqX5jy2q3lBtzD+VVQ/ssXXQL7Jk7iIxSG0392TJ5rRXDipwDXtLyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE0sPFU+; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE0sPFU+"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff16c0e6so9819991fa.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 20:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789789908; cv=none;
        d=google.com; s=arc-20260327;
        b=ngWFznrwLpYGt0h9VMm4paoD0qjXXWyS6d8EXpoTGGTGQwNTRhrswUaE44VmizRFkf
         VUFoLjgPXyPlMJP280m9fCo658VypICLgVIcRq3X+s81dUb5DQlyqfRQhsF7mn9G2JXF
         /RZgfTh9iPzqhEXVCC9X7wT6ujifqAsLEBjCwu0F7lwilveBy4Cft36BDRY4jjXWo6yE
         Y2a8Vr5JIYkyKGXpMB24iFcIhZd4z7+KBW9K0Y3ec2kICgPikwJNvd2Rj70XE6hk+g34
         25MBgwTVGkHejNRXEI6vIWrjYy6AF1uWJ3stjD9OT7ok6k8yypGVlGqwglWB3nnI0+Kg
         Rw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U8IHx8ZPAeKtnfGboiRf2eSbCOa6mdkGIwjEr3hxwU0=;
        fh=ifsccfPajgKiE/hcv4cgaGN2yvDzokUleA/rFXUaWl8=;
        b=MpdlbovgT0ejiixcYtRu+PgZJh5gILVN8gi6ZS0KuXxDcu4FNw1aJX1VAnJQ2sU5ov
         ozN3mY5U9CfQVFHSnlpFDXnNL6tk1QESlrFs5r3PVPygx8GrrWgY+YwUiZAJ8sL/u5JK
         SM7hMyoKKTT9wHqMz1CQ81y0+gQaKuaLV77GqdhLgVhVS5UUMreQdh2JDhLBJgYP1qrX
         YvlnWHhNuBY80NlUyU3W+eWEtbsqeLE2OadoI4q26Hcu14zmuU9IKVd+4mobjjUCLp3f
         Th5aXzwiX5UfFZ6f0rmrzTeysJ2IA5br0mULJ/OMrUXTqnA5yRmBi2bM9kmviYk6pm8+
         aHdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789789908; x=1790394708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U8IHx8ZPAeKtnfGboiRf2eSbCOa6mdkGIwjEr3hxwU0=;
        b=SE0sPFU+pO3mTQhHf9uiqW2UeedlYBwWgy8bF5AmtJ5ZRe+fcxsQ/taGTlByMsSgck
         0GPZBloD/ibEGEDFaDbh3haX29tvyWXB9PZShIOHVpuGdbIp6A8X9B9zJ/BKz/h/YEb5
         OYFzk5thtO266BJY3AfFKtR6TndIru0lS0E5pfD/f7sc97G4ifLlw/2Gbj26ugiQCB1U
         IS4X9IZlZsV5AhEi6iwLztiGZP3T8PW1IpJ6M2S5QYZigu8R1KP3+EITNK8oqhwfsAqO
         mgfeFyWROM4p1FPKBr9Vmsr/SX60Ab0KPJMr8dmwpwV5T6O/fTBIpyNa0pPBiLaZDHLt
         e4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789789908; x=1790394708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U8IHx8ZPAeKtnfGboiRf2eSbCOa6mdkGIwjEr3hxwU0=;
        b=gO/Ofs+anKUBViBVHE5JdRSLcjjDJpzHwDQ48ARp+oXxN4LW/oQBaPe4cTUNkuL/up
         3RsFm9saOr9cBMYUsWz3bjen/eG1VuqbJb60Tf1OIVaArBdXUFgKL6KzEJfm9Bg/YdLh
         5M7g9w/2WavU0XDsgr6XmbLZjUowjtENQkcsYiL9QYkIDgSpQfzaafcfwdeKsJDZqzzH
         gCWyGDRySgoincCPaA3o+x6vU2faaMwI4EO/1cgJGvJYL84LCImIOhRhyvMcLS0acSDA
         /frnRZKXJm3pnTSmunalpU1SoRts5KPpY6wcyYeSpgfM4o3OCIaUFhfBai3M8OrVptju
         HUCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuAJLo2GRa9cAkjZPeVh2WETXxAKAu8Ic8URtlVqFrY2y1SQO4078G/3H2cOVKqOM9W7xva6w=@vger.kernel.org
X-Gm-Message-State: AFuF++lBkHSvI1mKXBEXDFBCu/R+3tYLds/p6gNvOXWWKIjcxnUWIiv7
	aqboBXmoL5bFLv/isTORPiO6Ofq4kudiL143C0IAqqQJ4KuZv18ZZb4DXB+oXhXoVTDS7lPOM+7
	qNaELqc9A8FgxzhszMukqKHmUOv2Frbo=
X-Gm-Gg: AYBFou2Wc98oX0/AaOnVSMmRHE5IVG18OU3KcpZ7qh4nCxGz+E5uoq2IL0IAmrKz5ej
	LFO2GtyX2FEgsP2Q4ktVxj3bRU1mY0G5RAaVfT1xiACks8/1jMxMTSTZ0wPcMlke0owoiCreNKy
	kgiCVj5WI6SYHeclEHvjWNWC9zBhYZQS3cQQUwIIbUX0zXVQGuqi6Mr4sYnqYndGXqCzZdLa8Bm
	sPVfjMBxtBG7MAaTc82mY0R3JDN2xXSUb6EhYgYJf53yFDOxeLfvAFEBd+sUT5rcHKdXj8y/tGw
	LkOzSew+ke1cTERddlRopRgjphb5O7+/bH9wJ0Lr7N3zUYCoZ2QyS443cIMSwBWZgZjiYcRpcpI
	JV6g2ZV/3IXM7blasAsKHwdxDAELUEzNos9P09cHcTwesHA==
X-Received: by 2002:a05:651c:a164:b0:3a3:74b7:fc09 with SMTP id
 38308e7fff4ca-3a5fbfd82ffmr9833281fa.21.1789789908286; Fri, 18 Sep 2026
 20:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914014539.5015-1-sigefriedhyy@gmail.com> <20260914014539.5015-3-sigefriedhyy@gmail.com>
 <20260916184909.279f5cac@kernel.org>
In-Reply-To: <20260916184909.279f5cac@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Sat, 19 Sep 2026 12:51:37 +0900
X-Gm-Features: AcwNN1UgzoXHsJ_bxhh-rzhr-yWoPfk627Dv6gK26WB-RKglakSDcOZfeNpQwmE
Message-ID: <CA+7S2vLLNCQ=+rcGUyd-jt8ErtaVWgSxt3Ctoq=pJz+KZE62QA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/4] rtnetlink: add AF_PACKET multicast dumps
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, Nikolaos Gkarlis <nickgarlis@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 10:49=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 14 Sep 2026 10:45:37 +0900 Yuyang Huang wrote:
> >  net/core/rtnetlink.c         | 174 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 175 insertions(+)
>
> I don't think we need another 200 LoC in rtnetlink.c ?
> Especially if we make a precedent for AF_PACKET and someone decides
> to even add more code later.

Agreed the logic doesn't belong to rtnetlink.c, I plan to move it to
net/core/dev_addr_lists.c in patchset v6. It seems the dump logic
should sit next to the dev->mc helpers it walks.

> The AI report about consistency check is probably good to act on as
> well?

Will fix it in patchset v6.
