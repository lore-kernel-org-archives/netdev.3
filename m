Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B67641B8F3
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926482; cv=pass; b=RcfGmbqSSSZTg3Psg0K7hCJ7wFu+dcnASBhbHvOeIf+neGbImuRF7UFptH77yK2AKtPgW/kMs2+Q1lm37yOpvRcht7aWTJL9BjYCwnoytlkwFm6y48/8j2tCHYqamBDYpYJgTcT+BF5avk3+Mfkc6gJMsj9JC7uz4HQd3JmDevk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926482; c=relaxed/simple;
	bh=5niBt8DyKkV5MwxSbrsZ3eqRRMmoyzmdPFe+ZCtEli8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9LzNFJL11J/p9lj3nnjgK95OA3hVu/+gsAjmYhfPcn7s43TPtuRfyVHkYWm3Meoot4V/zHfFV7EnzE3NazT0PayjE2pLYlieKZmX8U06DalwbCeUAwxsLsXopyr51gWuHgWvjlllhF85fd31lumvayDwFUf2VRRgljn497UFa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPSABqIG; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPSABqIG"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39db07589caso7660481fa.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 03:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785926478; cv=none;
        d=google.com; s=arc-20260327;
        b=bxeuV3b3juo5CTw02lcYxaW0qTso4Zr4kVi1lCvO1OVt/Mvf9qGqXl8kePaGWld7RW
         J8H0dBZXjTfY4Zt/Y9EovN2rlAzljr1MoGCx3oQ9GsxdsYXVl3t4JDlPrpS2TKzdVXU2
         +PLcdt8b+CshTjKczkx5E9C/7SSwENKj1NPeUbxihBTps4L2uT2Knsf/eXHxjpDeYT2w
         6SUiSbke0GMuw7op1zkyXSzDV5dEzFh7NwtcsD7FmvMkRUIZPavFU/SB/SieYmLq64Ev
         J12kbJMacuyKuH1Upe65UCXil5qsW2+/aLSodtoDeUO0uv7OKZ/OS9tjhd+qXVEhOP04
         iCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5niBt8DyKkV5MwxSbrsZ3eqRRMmoyzmdPFe+ZCtEli8=;
        fh=uEPGPrhv1l2nvicVkdZTQUQDgJjpNGX+O8ecStP6Ii4=;
        b=c6hafaYEgCGvf8Xl8UA74GCncazL+0CVnDhR7p8l+Du+IdHHVHGJSXLjKyYtIK9Grh
         ahLP35GSbwEomVDJns2xll+WxY281SynkoX8Y3dJg0DsLZRmeuubnqlhCZGZpTE8DcYU
         9QEgQX2SsqALFeZzuf2DqfqyiNtQ+w5no+0hwtkBmpowbgur/pnFk1kj68NQl5+F3leY
         cwc6HvIIJ+LDtbENqy+j1gLrxf16wdODnZZiWGOBwguE37K6D7GBdRry/sjdq419qiXE
         RCDs53fZgUegyeZQn3r4+9l6COosyWeV3FReCkcdMRZmJBpcNYGQTM03EEzgSmr6Tm71
         s5CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785926478; x=1786531278; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5niBt8DyKkV5MwxSbrsZ3eqRRMmoyzmdPFe+ZCtEli8=;
        b=qPSABqIGps0T6TKTjNDT4h28762RiQMmdmQiZcjqtABYlDnnIhj+j5rYozCj4RurXN
         UrNLziAORRnMfleTLqEnj4EA28Atu9GluXGZma3Pu+aNs8igXtVJCrV6Y/Eg5FeVOncu
         5qkLYsxKElvyL/Z8RLZWhbokmu5ved1m5zE4B5E/bElfAfUu8/AQJCAptPh68Qg8O2zi
         MTAZbvbWR/cx3cOOkvA63+x75vkRpGF+8cuQ6K9w27tjx6NIUOrJnb1pqc1O8zwp3LWv
         rS8VlOomIeHwgzKeM7PeZvdKkybuVkYzCm6t1Fe9m74zLgrAf0bB93+Ol6byjI4ukC18
         UEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785926478; x=1786531278;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5niBt8DyKkV5MwxSbrsZ3eqRRMmoyzmdPFe+ZCtEli8=;
        b=iNO3ZzkMbYAzIp0mjtGhO+aRgT2ixmX2tiCbOduJHyrrafZPZ24JxnWLYfCU/15tSQ
         Cc28vniOgiEx0+GaTmmpf5TyMCj96an+vwzHdF6s+5FbUVlj5z0AqIdZ97G87u2h7H5u
         2lNhTJp8/4Uer3FQgARt1F+xzpFrPckzi6dZcuNLoia6RBTRCOdWWMP1ROSfs+D3Rx/u
         NMLGu0BDEGrdKQ5blKMtLMVOZm9/kx+vTET5QF79seIRCz+6iO4yBgKAVGWFfERkcElT
         l+VuAPFZ4QdA68pq2Lgw4sqT76xUkjP6XmcRA4LN4dKHvIXqLszMMWKmbr/QqoucVPYD
         fdQg==
X-Forwarded-Encrypted: i=1; AHgh+RopOA5IjUxR8SWq7YoSn5XygKtaVI0kVfLyWEiSGlzQJIswjaA+tnU0W1TSyzfnNRp8Ms1qO+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqUopjnxhmaiCowLLPQM3zOulMkdkZH2o7Elj1zanxGcC5rQ+m
	QRC5LdfjhBA6mGR7YZKu1PNLWOjRIPi4WvfVkLFa0Q67Ius/GhOy/6puXHcqJjVEWx+wBd8Gk5R
	DDEJuRoSdaC1FrDWzNy5KGllnimzUJ/w=
X-Gm-Gg: AR+sD10qzbPMwtV+6NNZmzMAcCfjqnQHajbocWvHv1jD13bzJmxUAMccq2QnSs+EJxW
	tk+b0bxmmHu/LPK3zdtCJaMjiEqU7uQE8rcrMbZRsyXBApI53ROxxHzPaThpAMG10WeDfVtMw9l
	1ydJYVvFIFb7RlYF41dVT1orhgI2qaJ1kG9m6UlyZjqXmWcVoMRnhw3PpnPvwO4lkyVPIJVdlv9
	yuxMVKJ8qwOxuHbdxvGO+7v6qN8toMpbNxu2atqJavMSLbTDNxQM+AiMVcMOMyOlO7KUbBkJk06
	RS2NF8MVDlsILsC4VSK5AR0L2ErX5NOLaBrWNzWqof+jXfW9hxBjkaW7gb9mYrmABMveelCOuKz
	sANUSj2p/jOmhFuoXpbUaMXd1mPH5P2ec3hulZAEA4aKkOQ==
X-Received: by 2002:a05:651c:a20f:10b0:39a:fa7c:b152 with SMTP id
 38308e7fff4ca-39fbb1a6880mr5507661fa.4.1785926478218; Wed, 05 Aug 2026
 03:41:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804014714.4362-1-sigefriedhyy@gmail.com>
In-Reply-To: <20260804014714.4362-1-sigefriedhyy@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Wed, 5 Aug 2026 19:41:06 +0900
X-Gm-Features: AUfX_myaYvRXHpMPIXlPqkonD5M3Gijs2W5bvZsdGfZVgRcOCjHXYxfLchXmdwU
Message-ID: <CA+7S2vKRASitG1pK_RPG1L-hDsJyev1q-+ViRhCppBg9aFuZvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/10] ipv6: report why a route was deleted in RTM_DELROUTE
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Chris J Arges <carges@cloudflare.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
	David Ahern <dsahern@kernel.org>, David Wei <dw@davidwei.uk>, 
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Gal Pressman <gal@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Nimrod Oren <noren@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I checked the sashiko's comment:
https://patchwork.kernel.org/project/netdevbpf/patch/20260804014714.4362-10-sigefriedhyy@gmail.com/

> Should this new UAPI attribute also be added to the Netlink YAML
> specification?

> Is this new attribute missing from the netlink YAML
> specification?
> should this new attribute be documented in
> Documentation/netlink/specs/rt-route.yaml

> Is the del-reason (RTA_DEL_REASON) attribute missing from the YAML
> specification?

> Is there a missing patch in this series to actually report the
> deletion reason?

> Does this del_reason actually get passed from the deletion path?

These are answered by later patches in the same series.

> This is a pre-existing issue, but could this RTM_NEWROUTE be emitted
> out of order with respect to an RTM_DELROUTE?

Not related to the current series but might be worth sending a follow
up separately.

> Should this new enum and its entries include doc properties to
> describe the specific deletion reasons for the uAPI documentation?

Agreed, but it is a nit. If I need to send out patch series 6 due to
adjusting later review comments, I will include the fix for this
comment as well.

> Is RTA_DEL_REASON missing from rtm_ipv6_policy and rtm_ipv4_policy?
> [...] Should it be added to the policies as NLA_IGNORE or
> NLA_REJECT?
> Will the new RTA_DEL_REASON attribute be rejected if user space
> echoes it back? [...] causing an ABI breakage.

The comment seems wrong. The attribute is kernel to user space
notification-only, user space code should never set it.


Thanks,

Yuyang
