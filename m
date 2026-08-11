Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB9E427F9E
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440084; cv=none; b=V3jqOADNqXdoqYwoomq2LD671Xa3agNIfHGS1mwwrddo+OwyNdG+uIg3Mb3vDy0sw55uAXXs6CSjQgRHFIOoeIjv3pnwM8mlAn3MsQmxwNdgxb1kWIH6T/6pBZ9tfn1JX1kO1WnS2wnkq5LDAx18PG4ynjaXnz+KrRDnOF7Cwz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440084; c=relaxed/simple;
	bh=rQ83MxTdYDXXJ/sWnGZ4Dcgrn3SUyWiEQ5rBXRaIYqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTWbVgRA4OkbL1IspC7cL7JACSe3WLpuNrSz/9ej2TppHVDaAX3SBPHpxF6WzikPZ9wnloBTyp3LIZUz3ZFtGcN5U20CEYzUkybGdFHmGuqcNPcBgtZtJ4ovyINZpGGdE5ibQ2kzn4TSC4f2HvVhYgeUtd7IP/I1O2pMApJwAAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbT5EPCM; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbT5EPCM"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a063d211ebso3651602a12.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440081; x=1787044881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rxC/GxhN4TzXUqlm7Isfwqh8isoAuDWB2kvs90LXvTg=;
        b=mbT5EPCMFbyORUlitDU0ApnRJZxz6TOa+Qmhsf/wqfO2gygLyWgC0aQwaRVP8lJmdd
         eXYvl21UQNqrF97dq5Fp/6DU/Zr/lTvJNNEJAYFFYXm6QnFghubtTt4uopC60rYfpZj9
         t95J3bsZz5bi8KgWVuzy4hUmnL0x0P9/FBAplAh9cUd+1yVWkQvld+qdgs4eOzzqRmov
         vh/Qo+K8fFWE4HiUulRG/WncpO649bWo1SejwIvTheTNke7BPyLWH4b05fbNXP/GVg0i
         SMwzEXSm+bNoSaLThYQDFZBYa7OgfDDr1H88o+PMnep/zEEugDP5xnhjkv6m+bMK4wfu
         QOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440081; x=1787044881;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rxC/GxhN4TzXUqlm7Isfwqh8isoAuDWB2kvs90LXvTg=;
        b=QUCqU/wyMXqaze9mLjqNEQJEWeYkJ1if108yP5JJ8ExmHd1KOF+aC5iracunU3UvD6
         A8NlW9vr8AJAPURSwL+EbPTFqpEFVVBrJZhA3iGofArSHiRaRvMUjofwpBqsMEQxulGc
         aH8Seww5aCV7qAmvvXB8FaB1WdtLcf5lWo6BDEuW8LpIWKAv/nNplAzYnMvczl6hgRbW
         Vu6yezwoRmssD91L4tWuRjyez7Ys8iP3I0INIhSVDOI/8fWycxfe5N/ndBPsVQrxRH75
         lgMwn9FkS3chfSiulguGMIVcImkHb3bOx2ouh2oiK+ZJP7QVstnLQkjzonGfRozePDA+
         NCMw==
X-Forwarded-Encrypted: i=1; AHgh+RpMkpTWsd0FduJ1XncrzncgE0GRa/6CW/Rx55OccSUNN4MNGa7RvUM744NIjzfC3T6frZY3ZR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIFt47oLSDj65OKUra5O1dfHK9EhD5zFX7O3/JchVRGvV2c2Ow
	zGuNtmioKknMmFafNljXJtYDhdNwDhbtR1czA9YXav8fyuql3+i4VpU2
X-Gm-Gg: AR+sD11tvix1PbAVlsus8YDzp3UU/RK9BtWsG7hzOObssg6hPqHUw62LY7iHQoqzf/0
	AgheI+ICBb1G9Kd+0pG2qj+G105qnbOuMtS3LdgVyJDEexNGG8ENgaId5k9Uj09Ef3WLAvWRG1i
	SLNkO2BjsCiIyYPc9mbkGbLa5LmRMqWE1rs4DpJ9dCVgxy44DgBbuRIMpw7V7fkQYg7sq6oAcoS
	1dCFL9nfrYo00Lj2uPQGfnhR7l3R/ys0+9+8WvVe3urxkoIVeLQ4DalJ7nzNqqm4zgX3vYEHZBc
	K+PVtpuGkPl7FNVhzmzkE2oKZyKFEd0ZMkx7w3kQqzmoRT0ysXRHSQXNBIKT+4v/GqdLujETtj8
	3kP6LJcVpsUtsVs0P4Y9t+tqenUtcE1gINgr1PX5ATwUzdhIOVfrgibiMa7BY20tm7oJmw/6jxY
	rtqwNDTX2D31DILoTDCb6mnsEvlLM2V6gUdylYT9M0jGOET5tDNOBUeZ0DrnSQlAxz2LIBbj5Uy
	n4BxN4lKiL+M2Ho7xtQGCmxJk9AOWz/BPXewUY+hOtbZG8QscdPrBjcWRxYRFHhwYMcCi+LurvK
	ye/kWXTbFzVNgDakd5Vw588yLUl93L9S4oz96NyCzXB6gV6vJiByJT4=
X-Received: by 2002:a05:6402:5d3:b0:6a1:fb92:b3c3 with SMTP id 4fb4d7f45d1cf-6a3644fd3aemr1104850a12.12.1786440081297;
        Tue, 11 Aug 2026 02:21:21 -0700 (PDT)
Received: from [192.168.100.51] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a362ef8490sm423705a12.28.2026.08.11.02.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 02:21:20 -0700 (PDT)
Message-ID: <de87c6a6-44c9-4b78-991b-ff858e21e806@gmail.com>
Date: Tue, 11 Aug 2026 11:21:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] RDMA/core: Reject unregistering netdevs in
 ib_get_eth_speed
To: Jason Gunthorpe <jgg@ziepe.ca>, Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
References: <20260810133124.44513-1-krystianmkaniewski@gmail.com>
 <20260810113308.5db6937e@kernel.org> <20260810183902.GD507588@ziepe.ca>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <20260810183902.GD507588@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for your comments. It's my first contribution really, so I'm 
still learning on how to do it properly.

I'll do the requested changes by both of you.

Should I rebase the v4 patch on top of any specific branches for rdma?

I found "for-rc" branch while looking at 
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git, would it 
be a good target?

On 8/10/2026 8:39 PM, Jason Gunthorpe wrote:
> On Mon, Aug 10, 2026 at 11:33:08AM -0700, Jakub Kicinski wrote:
>> On Mon, 10 Aug 2026 15:31:20 +0200 Krystian Kaniewski wrote:
>>> Subject: [PATCH net v3] RDMA/core: Reject unregistering netdevs in ib_get_eth_speed
>> nit: Please don't tag as [PATCH net], networking maintainers don't
>> normally touch RDMA patches.
> I also drop all patches tagged like this from the patchworks sight
> unseen.
>
> Jason
