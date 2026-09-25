Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864849B21F
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336562; cv=none; b=VkIkAHVEX+ifcqEuK71TSogxzTrHIdeCaZOyA5QMalvPg/C2hzul0m17cD7tzGTdpa0vi2Gtj4yhn6rFUBqQZUwiP3D7RcBB5/Lx7wMHLR04LIeBGQ3GDIdTjmDJznglOVvTU9o7BBdpRuB+RWtEA94PSiWghNEHI1UhlOQZik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336562; c=relaxed/simple;
	bh=rBJnsaVCHfaOL/WHv+pHL3sj4oETCI/VZTPPqHKVDRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnVw0jZDjWd4m17WFiD4Yid8KYOEYhByhhPvVAKHzAa7Uex5NXjui/x+y9YnRkz7XZRXfMM5uXPVCVfLTizfjbE/UhRnX2k+TjEmycMe92OEJl3ycDjYn5dq3GdzpOVeX9brCCiXx+ug3phd7v0/UbxDpXaqL9wcLP8NxrLTjRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wo02HaYP; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo02HaYP"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so4628995e9.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790336559; x=1790941359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ivBplz0pPix7WscLWvh29/mI0h6ugzDIMPQk1yJ2WUw=;
        b=Wo02HaYPw8gr2wfBPe2GBXKKieIYrT21mArXUtRiRfJo0Niz7rzXN8HnqPJfCp2nEW
         Yd8J6Q5TgpBD92lq/Lvd9BKUhFVH/phZTfuTbHSfNBTSzGQ3OSxYqXZMXnwfEpJpwPi8
         vtCwNRWoVKavYWIU38uGKG1v578BZXXqqKLYYrr9v6ZXyhbkFw82FxdYf6nLl3otTxtk
         2EybzJiYQNbWP6CFcVhx04X/7BT3i3J01Vgzx6L/kxczIBKYfp+3U1nlj0/+9bjQiEPv
         fV3HPAPYKlSg0fD7ywsJhRhogBvBQUzVO4VRKaI0+lyaF9HuOMzh0H+N+H+3FPwKzNK4
         q9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790336559; x=1790941359;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ivBplz0pPix7WscLWvh29/mI0h6ugzDIMPQk1yJ2WUw=;
        b=qBPKe0YU+nCDr1uI51RE8QmLbAAAgLGqnZD72RjZIGSSrrlezd6lacBjHy3dJm/ni9
         sJ4qkFu9uVtd1Bd1yRzHxyXvpe8cPhiCjAGQwktnqGbsy++jrWYyJGe7ByYYjvYPQbhl
         ziHECk9VyMNAEZmvOTurgL6JvAwpV+WQ/EAJrouVUYrFckcmdfVlb3zoCtX2deRHTenm
         BWLp6oFwJqu3GLukzrlpOenyvMznvDGH2zHD12Nn7HMDd/UTPZOtaTtodW7zx1y8Y6fv
         O80l7//ilI71YfkKJ7bTAxlIVJscP+XnXul4skkx3++dKQbmvJpj6jxSpae6KLIfwEr3
         HyHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzfRxdfgqnhNtXPsE3GNNED55nDK/kvSrcYknNYMNy58giRmgPo1E405fb4D7eWGA/JduW3zq4=@vger.kernel.org
X-Gm-Message-State: AFuF++m7SRf4E4LWR3s/DNWYBAl6xJUjlc9ZkCefkiBYwaWTCNeEAOyB
	Xs7a9cvk3r49ctu4hF/s4H4al4XhzEyTJB1YFtyU3JsyV0oGlfElAIil
X-Gm-Gg: AYBFou1Vz8EvjTT7K4HAojlIwo6YN02+HQI9UW4eocSzFqsTOMWCoZ4OK/LHuZDuBmq
	4w/SiboVdfCXglRD3CfTzlv06lDFOqkVppt8FJUH02M33L3MqO77Pi5i6zB7s8vAcyWZTHIxOK+
	YWdC01PViU7/m4YSQuJNsIaCYe6w5fvi+5YBkxhplc0hwZ8Z5ri6yVe6vbxzfqQVUrls5cnEP+E
	b079yFHJhHhg1pqcdC/uPcwB2mOCDhVqcX4DjoTB7Ti9ou+FLrogsYYDMa9YqXlSeIVO81Zh7v6
	YrAQIHn3A2n+2Ti7dSsuUT/MZ/niBbo87fJFcszXkCcorQHTnkX+c4z9u2YBWUJWmtPf/2uGP/t
	fERshcy5xgLOwQbXlLqfueFN6PPPSGZ+DiMwDCCBFAMOSXPRSkJfIs4EJW4eu9ZKXQVIjd8g0QU
	s843wX3/Hu8s+LSIWWem4bsPpJnTBblXPPSpFKBkyMC+GmhdI5TS7E39eyyGhk2tkCuV37sfnt5
	BFjdV2dWocvpl6ObooRkoLuudq/fh3dRqpcJb8VHeokMLuXN5cnZ3o1NZCH5J1lL9nZeNGsldxJ
	jOqOdSEiaR7kNrwXYc8v/cT+FkAYbL/6FyOgN3QCe0wYqTFq
X-Received: by 2002:a05:600c:37c9:b0:49f:c2ef:cfb9 with SMTP id 5b1f17b1804b1-49fe66c897cmr87889265e9.4.1790336558641;
        Fri, 25 Sep 2026 04:42:38 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm6221839f8f.9.2026.09.25.04.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 04:42:37 -0700 (PDT)
Message-ID: <8d1c634d-f481-4c10-a773-c4cab414f6c5@gmail.com>
Date: Fri, 25 Sep 2026 12:42:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: netmem: add net_iov_area freelist
 helpers
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, axboe@kernel.dk, sdf@fomichev.me,
 bobbyeshleman@meta.com, kaiyuanz@google.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20260922204348.717198-1-sdf@fomichev.me>
 <20260922204348.717198-2-sdf@fomichev.me>
 <CAHS8izPwLBCJXM_0Df8P6S-FVwAq+TaRKn3uTh1h=33Ffj8VmQ@mail.gmail.com>
 <f566591a-cef3-459f-a39e-86addb0c5d7e@gmail.com>
 <arVTvlvKsBRNG2aQ@devvm7509.cco0.facebook.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <arVTvlvKsBRNG2aQ@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/26 17:48, Stanislav Fomichev wrote:
> On 09/24, Pavel Begunkov wrote:
>> On 9/24/26 16:02, Mina Almasry wrote:
>>> On Tue, Sep 22, 2026 at 1:43 PM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
>>>>
>>>> io_uring zero-copy receive and devmem both maintain a bounded LIFO for
>>>> net_iovs in a contiguous area. Store the freelist in struct net_iov_area
>>>> and provide common push and pop helpers.
>>>>
>>>> Leave synchronization to area owners. Keep devmem's area adjacent to its
>>>
>>> This could be a follow up change, but I think synchronization should
>>> be provided by the netmem/niov infra, rather than the area owners. TBH
>>> the infra providing an unsynchronized data structure and letting the
>>> area owner use it and shoot themselves in the foot feels error prone.
>>> For now we could use a comment.
>>
>> I don't think we want it. The duplication is minor, but I'm not set
>> on the per area index array approach, and it'd make changing it
>> more difficult.
> 
> Do you want me to not touch iou in this patch at all? Or are you talking
> about potential future synchronization part?

Sorry, I should've more specific. I meant that I don't think trying to
consolidate it at all makes much sense, and I'd just drop this patch.
> I don't see how this is making changing it more difficult, the freelist is
> now behind push/pop which you can freely change, and both UAPIs benefit
> from a faster/better freelist.

There are several reasons. If there is any mismatch in how it's done
b/w io_uring and devmem it'd need to be split back, and then having it
in struct net_iov_area for devmem only wouldn't make sense. E.g.
Packaging of {area/offset} pair if converted to a ifq global list might
differ. And it moves one part of buffer management to another tree, and
there was already a precedent of patches being blocked for no technical
reasons; I'd rather minimise cross-tree changes. Synchronisation might
also be a bit difficult, zcrx uses it to protect more than just the
freelist modifications, patterns like lock(zcrx_area->common_area.lock)
in the zcrx code is usually not a great idea. In general, I just think
the upside is smaller comparing to losing the development flexibility,
it's not it makes it faster, nor the current code is tricky or complex.
Hope it explains it.

-- 
Pavel Begunkov

