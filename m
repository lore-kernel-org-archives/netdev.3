Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3C544C677
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931108; cv=none; b=pGMRjarHM592Yrgyntc3hX1K7wM2GzJIoyWxYZN+d5c/GvbpPtcuEmaPtOwyJLv5b24z5xaIzqZwF+vanv/UKHjUZ8npruQvR/mnumaaNm68f+guXUyPkWtXQIY/4F1exhh1eKpk3ZjFg8v4WzTIKoJuDZZZt/CX0JuRoEs/uSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931108; c=relaxed/simple;
	bh=5zA0DZ7xjZn+FAnB3S+NKT3D93nEPSXJ8ZAPb0v4blg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPldQbJQ1DTMaQvi1PJPps0z21Aure2Pp/OhrHWT90PMJDxzifhskIRj09gEZ+PynIq87MKNa6wWrzqbZTlkOWmzuuJ4Ng5EAbjF41Pj1O2LCT/UqipgHDwtFhpGPM9WGDJ5h1c26W1NEzt10GaA9xt3siemPTbDi+uAmTfR/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=X9dnw7xG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="X9dnw7xG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495773ee3edso866045e9.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 04:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1785931104; x=1786535904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Bbd2jOgBIIyitm6v+guhY1fqYeIKvMgZSNKvU3YkZBU=;
        b=X9dnw7xGbp+F31cVrDEayHtCFGKkGTsMZRRCtF4YqQ65LQQUkuLbgFLeqSKsY2y6qw
         lI3gNueddW4f6wPBah3hD7Wyvq++hCAlJzDhbeNUOuArvGwQbZOwZ5jfq2aP7LRU2Sbn
         eDTrJcWMkBqGJ/M5QwFlJqcb2DKfuXc7Df5w3FUd080I5oWQ/tuAMmb1hEB8CzkdXAqD
         5aPP9xRmFzhpOs/xKZ7jUO5EPv6Bp4B4lYW+A47r85n+EyogpG+gp2N14lue7GPhswT2
         FjJ7bTz8gjwz5yQXY2WrLRmWQsxfx3+rYGLkqUVDdCHJrAohYF6KDQLqV5KykANJHnRJ
         5VoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785931104; x=1786535904;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bbd2jOgBIIyitm6v+guhY1fqYeIKvMgZSNKvU3YkZBU=;
        b=RDQswqO1plyctvQ36VNgUZdtApvR4P/LUpPvXOxqtapuNGIhnH0ZhZfT2XFkoBqksl
         gmzJ6J2VzVSqsQTZ1JEyvO5wuGCKC+QfYq3IPRnmbfXXarIEFHx3w7Ay8t+86QUhZJdM
         grAqq/sahKpBJPbbM1d3+ECR7gsmDjt8OOyP2SnxiPK6VuZMiBL5fd3+x3cbyZFx00Ip
         WOQmlWwQRN5QLKNqCiLZR5CoYt4i+mago2BX9nLI+rYo5ox7wbsSlAHsjyAxW3PQ/5ln
         +WISKIlu5CrKCohNt8SdHX4ll8xWZqmu/ukBxgfRwdcTiaTUg+P2E4De84oc1DyeLo+z
         0hTA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5sg9m27WE+ATkfBPzlfa1M80Q07CMSzEX0UZZebPzkEkbLJ5scpI+4SObp9nu12FmtbglUAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4CM2pXiOLQeIbzIZ6gmCY7X+mFLwRvc4QyPOZAhZVypGdMZcL
	p5puJrd6i7htOG0g3ZtYM3q5LNfFjp3VK2eYLFwCdHmY+OR9ZqZSysk8LSK2+XQTZxc=
X-Gm-Gg: AR+sD11Fr+TzA0wgNI+E6clcIReoBOwivBEQvEy6rlDjpyV63uZEZy8zCgRJJeDqY78
	fWMfn7+Pr5MPHMJ5cDugaR+vOOBL2VC+n7npIvqE9lCEbaHv4znSt1LGOv9D95WbbJVC6Y6JUnk
	d9IjSqKE86pkr2JnLZ8eogqKO3Jq2eof2O5SJGg6c2+IbTpEbiqMsOLfG4Ai8sihDBSIZsnF0De
	JP8iPCqdCj0GjKYW2osaMii4y6ZLLu9bMkIseiNdVRaWDElPs3rU5cFOjEU5i8BnD56pI5UE4aG
	d2/Oam4bNMZhwrcIJAlhqffvYkphs+Uu4yl71zA4TntOFW9ymfsgzslNYzw9YuJP/cTMe4Ch6ub
	bMtwSmhY/hy3SbI/zaF6BixdwYwQ7RBBJbMAiF6CZ1ggShbpHamrS3ii/nMztszUodF7G5lTtfH
	DZ71RUKicyOY0yeSMerHZFk3mVW0qrNoDwmj9ohCf4Dq/FTKTXIc6P86z4OZnfe6dwFZtBBBrCH
	GtPVVoeYW3UQAPJZo6hzoLj5edInQqodw6JcvxcmDvlmkSh/ZytBQ==
X-Received: by 2002:a05:600c:3594:b0:495:4126:1e55 with SMTP id 5b1f17b1804b1-4994e7bd084mr42175125e9.2.1785931103865;
        Wed, 05 Aug 2026 04:58:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0fc94esm186957915e9.12.2026.08.05.04.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 04:58:22 -0700 (PDT)
Message-ID: <e7eb5ac7-7b5d-4484-aa66-4c92bb20c538@6wind.com>
Date: Wed, 5 Aug 2026 13:58:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2] ipv6: seg6: clear IPv4 control block in End.DT4
To: David Lee <david.lee@trailofbits.com>
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260804094625.715305-1-david.lee@trailofbits.com>
 <519a06fd-c9aa-425b-a374-607aff0a9140@6wind.com>
 <CAC_etQFJTsCN5zr_gxO_SEDjbJU4-yph0ezbvQ6zZ9ZVaLie0w@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CAC_etQFJTsCN5zr_gxO_SEDjbJU4-yph0ezbvQ6zZ9ZVaLie0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/08/2026 à 12:17, David Lee a écrit :
> Hi Nicoals,
Hi,

please avoid top-posting ;-)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n336
> 
> You were right. I tested End.DX4 separately on the 62cc90241548 (v7.2-rc5)
> kernel and it produced:
> 
> BUG: KASAN: slab-out-of-bounds in __ip_options_echo()
> Write of size 255
> 
> The stack contains both input_action_end_dx4_finish() and
> input_action_end_dx4(). A matched bounded control traversed End.DX4,
> reached SYN_RECV, and produced no kernel diagnostic.
> 
>  Therefore, End.DX4 has the same stale IP6CB-to-IPCB issue. The current
>  patch only clears IPCB in End.DT4 and is incomplete.
> 
> Do you prefer v3 to be sent out to cover this case too?
Yes, it would be nice to fix both in the same time.

Regards,
Nicolas
