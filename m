Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6719130F52B
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950987; cv=pass; b=gyQwgYQLbIi9fj3aHyDR8logWPds33jSQhHD3twqdgtEzgyT5UJ360Uy3VgJLQZAKboQccq99Mwj9ABt86skxI36zh0HrEBKy+WyRy+P0/YFLdmPMuIKkXvD7zwT3stRtMGirELee+5HIF6rzAxgMaWhrvvQq4y4hKS+w5jY2EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950987; c=relaxed/simple;
	bh=fbdJgvOiLac+N7V2H/t2voYvdk8syWy7cBDstC4esp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEMOaEQHJD9agqVoN7kwmpHxrBbsbseSB54hZ6p7dOpzEu5PtqOrgKi1YDxkwnDJrGY31XHfCBoZOHRMOY0Zuro/gQ8vCZVCR406MXldmp50Stx27bJGO2vOGvIKCS79aSz8gIa8E7d0lc6STjzzVRalhMos2l7gvH3EeM9aT5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K727ZcLa; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K727ZcLa"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e227422e3so11855666b.3
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 07:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790950983; cv=none;
        d=google.com; s=arc-20260327;
        b=hjwjV0f7mT7zWXa5aNN6rBd5fZZcTa8EgJJryj/lBUVQ25GJqWEqLjD4+Iwoe3c58Q
         if+236KWGPpwDgLbEp9wIrryeTsj1Nwcc4zbRBLsCPNS+C9m3THtsiq/WbJrnHauA2Jy
         EZsanUxwUbti0+NQtkOIKDW2sLDGWxq/Jk+q9J7s7QdgySIQtuKysVzDudUz55zHmEsy
         ryshsqUPhY3w9etkR8NzHWAi4nzrZ4UKM+2KAQWgvEE7m7Rga6JR85XmYBRbxAqMoUUw
         cXPi3y1D+aABdLUUyX8hp2GQzbBDPAN2kiFFll+Y/AYC6olvoqimfcbjVTbthYhivjNS
         7Q+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fbdJgvOiLac+N7V2H/t2voYvdk8syWy7cBDstC4esp4=;
        fh=Bx6JFarna8Nn8IJ9iMXp6LXKQ8Qg3TXS1W+z5YflHPE=;
        b=caBr+8MdWXoj8j6BRSHcKgtPkxt8t6Z4mgUM4oMQooWLpEhWmTzXIaA27TsT0vIKv0
         74Y/n9Rzgni6lJcRPUA7a+HcHjbswDTxB6XWHbgXUeycG1q15BqjFgVqr2lbptdci98O
         gOnkJkLKaIWDBtYOM0adCKBgDnfZLboN8kMfVjWqzIkaVWvpBy1lCYJ91Idv6XnLExkv
         e7/JldXlvrnh6Sygg+LM1wNXdjsARpHYdZdQCUGRrpojRrDY2o1IeSTEt9ojnKM1OFKk
         65g/hIiWHugGKKiYEO+GskSq/2k9A36qRyiVeNsQ7EhqBb/CiUAwwpYG/UqbsZKOCdxD
         sNVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790950983; x=1791555783; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fbdJgvOiLac+N7V2H/t2voYvdk8syWy7cBDstC4esp4=;
        b=K727ZcLahsiXFl9ljhTq9839N8JRutZSUCZIeOKiAJ4VhyxuSke4Vqgv0UiVr6CKKs
         3lAxmlq2XILzDUCadpUdFoml6yUWjz5r1uwgE7c44Q5Rm9QKD2d2hDcF2uvJxAY8D2FR
         vXHbOBPEf4t3JyBFpdeGcVDbaVqttUD6f5rVNANjLYx3GYNZqH6BeZFUeKXect43l0nC
         x6i8X/ICnCUBbuI3nmQVuTBZHUEsVyyzk6vu2xHswwIYHbAoQ3kZF40+OaCaHoX1dIDf
         jvb8vAw0u8FSUlij0DLaZ2ytHTPNruaNIz0G7MhMh9kd9g+smGpalIw1vgkTQZi++c0u
         t64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950983; x=1791555783;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fbdJgvOiLac+N7V2H/t2voYvdk8syWy7cBDstC4esp4=;
        b=FS5NpTeEDdMQ2DVgJSx8rov9aU+sgYJ48qJqSTug4xkK7MD5V5VEsRH5n3EJu+0OSY
         7yFnA9reERGljqLLG1n/rDEtdnBhimjTWtmuYEUFlmr+oeVt2cGsD9MFMnNeCrsjmVVd
         B+Rc0erc6OCFa/3HaoZekd3/t++blG2sjyOJ4pn64ldLMSXn9ckAWzd+F/LNmK9OFhmF
         cM/S1tb1IRaCtJ1avbuZ0Jqifhd/p1ZtTjcg9J0Ip7G7KJiDkSLecmkETa6ckG8GZBqN
         nZkZqyWVumt1er4EiH8oRWOEt3lHNr7ut4qPugJY/7WvzRJNa/PMgRz92zVyV6ue8Yf8
         cCPw==
X-Forwarded-Encrypted: i=1; AKwUvBwT7p6dXDbBRbCX2lQwwZiNY5VAXdO4laDKAsmqo6t+hvjO58JGohY3K5gj4/Tsn7VeFQn6skM=@vger.kernel.org
X-Gm-Message-State: AFuF++kwnoPgf6+tWgF7wJGaUBK2aE0flmEkRSXxIyg/GPS82TuEgYk6
	0u8YB7wTy8S84yeduLjoYx6+XgfJNitXpqKgBkkJDrN/LRdqrSuqKDkvzxGWPomUPekT1NO8Wf6
	j/mXuH3Sdgg54ymv7leX0zyaGxRMGzbI=
X-Gm-Gg: AYBFou1386Aih52uGgpqloJm223KEfvawvItn6AovYehYLbe2GZlXWj16AD0IGpfPa4
	lbm/7iPHl74+34emDAOb353g7v/v6tOAbwQytoj65zU3UlKmWfJ3cPNKkKgTroAM+HonQkrNQDp
	D4FnmNglKroFBksBb8c6Rbk/sKnfxCO7DIZpAw0qMbD/wzfhaOMu4udOL6mCNZkgB/+yjqwuTT1
	Sifi6Pm3oe4kXaITSp7DHM0yyFd4qiTGczeFP8UQ+MgwmtImrZ2pC5EHo1P35zZqmixH6ni0OIg
	aobEoOEJODwznTPz5G518anoJtK8IxvQ/yOTpBj5kuqzJWUdoVJcAA==
X-Received: by 2002:a17:906:dc92:b0:c29:37d7:75c0 with SMTP id
 a640c23a62f3a-c2e4a9b3933mr229815766b.1.1790950983438; Fri, 02 Oct 2026
 07:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de> <20261002115850.962676-2-o.rempel@pengutronix.de>
In-Reply-To: <20261002115850.962676-2-o.rempel@pengutronix.de>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 2 Oct 2026 11:22:50 -0300
X-Gm-Features: AclHuK8FwquojjJt6tk83Vx2IuLXihfbekw0Fk_thDrubBdKP_mNo6oPAfZ5sBo
Message-ID: <CAJq09z6FNA8a8Si_z3-JG7=aqBjsJkgNypW6UcftDOV2WCiKbQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/8] net: ieee8021q: print traffic type and
 queue count with %u
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> Switch the out-of-range diagnostic in ieee8021q_tt_to_tc() from %d to
> %u. The traffic class count num_queues is an unsigned int and the
> traffic type is an enumeration, so printing them as unsigned matches
> their types. The print sits on the range-check error path, which still
> rejects a negative traffic type; %u only changes how an out-of-range
> value is rendered, not which values are rejected.
>
> Preparation for the inverse helper added next, which follows the same
> convention.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
