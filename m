Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A910C361DB5
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762030; cv=pass; b=rEa/8cWYb+lpPpg59OtN/lFo+o7fna2wI2yM9kDJv9ab7baHYxKU+8EJe/YMpWaW1FsV2tAkNUJavzOyCYDxOV4xLA5sK4QTtYPMdAP9BPLI+1C1mXGhu7lIsX9K0kNtTdhLr3Dy6Hwhp73Gje/asglKontul6U4/XrJCE1gwz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762030; c=relaxed/simple;
	bh=4p1WjIfbnjjGUejWmeuUHTxOShSwbRyQLk17H/VBNnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2WW/03IS5kgneMrjwUr/4ohqXWUuWhHf7cSsearhRY/jzLx6TxrZIvJh3u+PyKK7/hXZZ7NS6xcNAc/elVtE6XFjMmA315NeUZXu+9xiBdQGWV2SeWziqO+ncK3hJE23D0Ez8K+6kx7rl8vbOMUoxrXaOKvrIJR0HpSizs/xgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQ8CxBXs; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ8CxBXs"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b015b2d792so3271585e87.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 06:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785762025; cv=none;
        d=google.com; s=arc-20260327;
        b=CK6hoB/dn8zmk6EK0imCR6vSMEvLISngCUKJ3mk78yAW9KIGUJTn3eEs5P8Xng1Qq1
         ayH5Wk5R6aqaJEMYJu8ozVF4V8w8bxg211noC2guYAoIhoIhgtx8h7jdnvUsVx9v+mEj
         3KZe17rKvAgZLYPuMicDHplfXDHYsmrho8yST+lAQxDnSMI9DD9VldozW1Euc+XOrIgV
         7ovnkRWL+6+xhRAKg5lBdC816XTPMMsMm7eCT3ALHB0trDmSVAstojLFcd9smBoUFsBA
         0pjdO1xe4+mTHaLBNslgclCUyLX4EwKmKWLvOVW8PkpiOYRKQC4GSFQsBIVomq8mw/hi
         babA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4p1WjIfbnjjGUejWmeuUHTxOShSwbRyQLk17H/VBNnM=;
        fh=Z2ORUsceVvNtJsK/p988ICybSCQv4DO+S/HHQ2E6uho=;
        b=MTlBTEzOXdHBkwAaWj3o7m5F1jNZytbTb5S2yesUR6nTwM2dJQBthg6PP9/zLCQdmM
         cam1cc0/JjreomG8X380SZJ5Trt+DdcGeAD6DexltyjD2RftZ/PuQAFg6LkoLUwR1bmw
         KplxEDfMnTbCfEkMKAFw/w8xWZ9Ia3KDhBtffntBdnadU/E7sCr4H93HGbKl+4bLes0Y
         SDocNDoGy0eW2SGpLsYF9G9DhEHjm6gSXWj5aK7tO8TTfMuI0n6JbE0JpBegeJZefeoR
         yv0SWrgPHLRSSwdTfkFYmkVurim+aJNJF0CWnllbrqAD+YmLntDXRnDQfm39OpHnzIaG
         3u2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785762025; x=1786366825; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4p1WjIfbnjjGUejWmeuUHTxOShSwbRyQLk17H/VBNnM=;
        b=lQ8CxBXs2f4HkGiPaBqEMGMlVYg3YYWHQODs0mcT87JZtdW3OwWfErq5AjExoPVKmp
         FhYdZyXxyjr5JplhEPHfSQwRh4DITnmhpF/xV5iBoUsA6L3LKrG8ZiyXrLdnA+B/x4vx
         yL3wpEYiKk+ix03JSG2EVb0Xs1Eo8tkdXfXOAHAjXb6leu//Cr0LA1v5DIsZUgDNsg95
         Uh2osM3tdQHJbxPn3XVKT7okk+I3Pw5o++2H7NQk7lQb0gfI7dfrYrpdNSuJlMMzX56N
         XwOCVs/BKMZsLdHnNU1Dn+abNTKgF7hpzZ71iJLJqsTJYGiRjI1vfEJAWLDzRjOzMaHI
         Af9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785762025; x=1786366825;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4p1WjIfbnjjGUejWmeuUHTxOShSwbRyQLk17H/VBNnM=;
        b=VxkhahkCSMNVr51rSXbhhpAHhW7lUUWOYss9kvsDRXN5tYkD5O2QQug/DZAWCH6DuC
         yrHiBUjaAfLfJEjoqjN7V8P4J8cQe/88adMHKGwO9dbanqvB1Y25P6Kg/Y8k/3FdOFRS
         XUAJTUb4a37/8lNPbmvL5xGoYwIjvalS80SGfI/L83orAscBw1bS0PPtY+I7EIMPBKr6
         n5cxggOIDCuTHOaCBq0/aX6Yj8VrAD6ygCft9kw/U1olNR9tS5NNiAuNdfhVun9Zle4r
         GPP1+MX+6jMsHI5rusfhoinmHfcpM0RsmpVtrKk+sVret35lBckCxAY6+ixrSdnBTWBK
         XD4g==
X-Forwarded-Encrypted: i=1; AHgh+RpcffZgVsMHGziqef9FxhweRjztCGv+y1g8EYwUGRxXY3JkSSORKGMwNzClfey/0HKmDLgMIOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXZIMj9bdAcxM4RAgxFXb1Dmjl/ubJ7pFeGABbaOaM7zk9dsGj
	tUM7F6afuRz9w3KCAca16WWCup2jmshU6OtTX6zivJ/l8/dDLdmfCBZ9yE8yY+b0BY5wVRQ7ePR
	h+EcRkVgBqBDcvaLOQ82+E7vSrDp4Q6Q=
X-Gm-Gg: AR+sD11/mccxQzg1WmN2k8hMWXDB5zbe7ijGNmR48umTEm+qyCWT3TFoyAE/777VGWM
	EHYRu5Rl4M8J6S9/LuZ0Of5g9ibR040mu8wsyk4onPLBe0+OOg0Ie5DrOnHIcQTrObdpGVwdXAm
	zvebsAmJQ3iL+AvG02Ph8aPWtQPeVFgV7KXSerOiL4jY/z+De6nb4o0AtwK/4G7ONMkc2K4Kl6N
	FVlQz3ecXt1z+LFfsq4dOXBbae27HJvp4+Zi+VGrtH3/BzZpfksKUqbqa5yb0CDLvG8f6kVNk26
	EjA6zdI+ieND33DIRH1dVwv2WQlQV1mbgmR/H2Dgf6FWYDFg2DWmPBZRZH++WUoiw0/mWRflNhi
	LZEsQQcuGToGYU49PKimh6t4ltSEveQ/myA==
X-Received: by 2002:a05:6512:138e:b0:5b0:1dd0:f238 with SMTP id
 2adb3069b0e04-5b2e4f1b067mr2062725e87.2.1785762024688; Mon, 03 Aug 2026
 06:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729120739.47880-1-sigefriedhyy@gmail.com>
 <20260729120739.47880-2-sigefriedhyy@gmail.com> <20260803081454.GA573507@shredder>
In-Reply-To: <20260803081454.GA573507@shredder>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Mon, 3 Aug 2026 22:00:12 +0900
X-Gm-Features: AUfX_myofC37c6hDTOJs8L7qTMquBYj9QB6glbVxSnoqG2Naw-j78vX-dRg_e08
Message-ID: <CA+7S2vJYnHoTx7S6x6CzAzfvTYB+RNw0RnYHnASYyiNRTyzq6w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 01/10] ipv6: add ip6_del_rt_reason()
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Chris J Arges <carges@cloudflare.com>, David Ahern <dsahern@kernel.org>, David Wei <dw@davidwei.uk>, 
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>And be aware of:
>https://lore.kernel.org/all/83360de7addb13a3b5f4d5e722148f248fdb2ae0.1784884817.git.pabeni@redhat.com/

Thanks for the notice, I will proactively check the AI comment on going forward.

> From Sashiko:
>
> "
> This isn't a bug, but was carrying the reason in struct nl_info considered
> instead of adding a parallel argument?
> "
>
> I did consider it, but it doesn't look like a good fit to carry a route
> deletion reason in a generic netlink structure (also used by nexthops).

Acked. I also considered this path but also think put the field inside
struct nl_info seems to be a wrong design.

> This isn't a bug, but since these names become uAPI on first release, is
> the RTA_ prefix the right choice for the payload values?
> RTA_ is the established prefix for route attribute ids in enum
> rtattr_type_t, and RTA_DEL_REASON is added to that very enum a few lines
> above. So RTA_DEL_REASON_EXPIRED reads like an attribute id, and
> RTA_DEL_REASON_MAX visually parallels RTA_MAX while meaning something
> completely different. Elsewhere the payload value space of an attribute
> gets its own prefix, for instance LWTUNNEL_ENCAP_* for RTA_ENCAP_TYPE.
> [....]
> RTA_DEL_REASON_RA_WITHDRAWN is an IPv6-specific cause placed in the
> family-agnostic route attribute value space [...] Would it be worth
> stating in the comment that the value space must never be reinterpreted
> per family [...]
> "

Will fix it in patch v5.

> It's weird to have 'skip_notify' in a function that is supposed to
> notify the deletion reason to user space. All the callers except
> ip6_del_rt() pass 'false'. Can ip6_del_rt() call __ip6_del_rt() with
> 'RTA_DEL_REASON_UNSPEC' ?

Will fix it in patch v5.

>This is a pre-existing issue, but does rt6_nh_dump_exceptions() safely iterate
>over the exception list?
>Looking at the loop containing this code:
>net/ipv6/route.c:rt6_nh_dump_exceptions() {
>...

I checked other Sashiko comments, and maybe the above one is worth a
follow-up? I'll see if I can get a KSAN trace on it first.

Thanks,

Yuyang
