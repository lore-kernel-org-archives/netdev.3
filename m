Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D99036B920
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570904; cv=none; b=LqfBqyxBFNtSGsjCuNVb1sCVRNuaQh6KCFHtE1JK7h5VxRpHsUkMV/B/ep5MT6o/nXVy1yUGmeAiIN1lynV6uKRgfHvjWufWFD8By7+OTZNXDPqQRwF8O1q6YencVB85AU12xxh2ML4FVUnXNPISYwPs0FkMXiBdeMxbuYZEcLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570904; c=relaxed/simple;
	bh=qTOdMFZyJWtBhUGxiYeCLLZ9ZAHwRpChV6JdhbE1CtE=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=Jcf1BTWhM5s4DaQ+DsvemZIhnpQW9tAf5iaIdI64W40rayXWEvdOcgox2KnR3cant/WRsEGg3Y2gqEHg3YNyMtufZNXSGXgpsUedwzQo7tDPgZw3Jf+0Et375ulUPsqbFOBPVAWaGMc6wf0WE7Kn1R7Ep9tzaDXE+98MVz9aCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4hYa6Rb; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4hYa6Rb"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-398e10200a6so3221325a91.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789570903; x=1790175703; darn=vger.kernel.org;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qQIDfq7HDGGaieHqLSx0OYrJfpBmlRY3pKtC45J1x9I=;
        b=o4hYa6Rb/yDWp4NDF7oKYygVL5/TRmHzMC8xfeWmimDDH08qve6VCN+bpbCtVFlSDp
         JC+jEqMfl345rXdn9df7UAMUieJki3f0bjLcbMQ79gn3r+X70TfamtftEoKkVt9Iqc5i
         oDC7lbZl6Jd2vwiXguLhGuP9YalUJHe6LqHFNDqFJK9hVfer2z14xSNwYG9cOIml8ksK
         eVVrZuNGmn7XyMjXtrPHDJszO+ra/BtAoHJefDqsE9Ya4ZvPsXDJFE0bktZeC4fA50h4
         g802QPR3M8NK3wYS8M+PHng1tc///lxNTrcE8ikqmI8MCWSzpdYxB4xs2zHUEdQBWNOX
         jxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789570903; x=1790175703;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qQIDfq7HDGGaieHqLSx0OYrJfpBmlRY3pKtC45J1x9I=;
        b=e5n3paxJnXXNO84GrRE478KVCV/3grzGEdVqknDnAhNYviB55ShgomK6xoZ4Q4I2Fy
         zbMcVpo8PTdKeEL7KzkK6c53rTGN1nkA824dFUg1dLvMwJbC1LlE2j5/ThINc9Oyvphg
         b/TVrNzv6P/UsOYNJ57OsGyg0f0q4UE0VcRz5uuCZWUW+bliRGdskNavHmEhRm4oWMPx
         xCmgMOTKXK9kaSQhL37O+ju6FqWFGemCwZ9DICHaqakUIXKdXztCdx9eQeDtQkIfQXrJ
         hoFEU2hMLsrhDD8hnSdX92mFjhRztfI5lPQTRa+Ke5O2prFGaiWsDP757/OZVDFxlsZq
         YHkA==
X-Gm-Message-State: AFuF++nck0SFtWpXI3KhdXzyZpdYnpajPRIKSe0RpX5EX3BYce4O2WJW
	hvdz29FU1r31d9mZERtm58iXXPkz9RoPSp+1/iZDX4L8NNta7RJsh7r4
X-Gm-Gg: AYBFou03MPlQsswcmydQPlG5V8/swfLSmlxBC8cSGwcLj8TyPdq/0FWVzB+k0vKzSyN
	pdkdtQEj6PBLVLGZ6kh7LDb61YfIiY9FwW7PUggp+E0c3y3pJ+oxb5CMJlfLoxYak6LdKSa2K2T
	0w6yNJ0A3o/t3Lp7J8K0d7pqxD9OASF48VHWB9/fttR8XKNOnKHJYNhNsPjFw5+RCDMnquy/xez
	eBijz1xJP3FI9kyBP2bYt7AY7PqPTP+61tXbMkL+AJY6M+attuU9xdTh4Xw5emToZkSU4WKyCs4
	qpR4X5a4QiB2pEbvpausP53QX5trZOa3oPKx/RTykNWZgAh/4B/calEuIjyJQvkAj78QeqiV7CM
	QMtS+5tlOuqIA0zFIJF8/Q/jT4In5rgFP34AG2qlgEWPGo60QLo/0EyZZmivxrSn7pxmviiZSqV
	zBxWMCv8/xJBRi3M5kWkYFsPqFtnj81QjKBa8wmR5mjrgNaYP+7YMyXlbiVS+R6eXS
X-Received: by 2002:a17:90b:2f4f:b0:39d:f2b0:5afd with SMTP id 98e67ed59e1d1-39e1e24fa64mr7015363a91.2.1789570902731;
        Wed, 16 Sep 2026 08:01:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:54::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b706089sm6284438a91.8.2026.09.16.08.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:01:42 -0700 (PDT)
Date: Wed, 16 Sep 2026 08:01:41 -0700
Message-ID: <1f3eabf07c1692e419efece1dd54c9cc@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 bobbyeshleman@meta.com, linux-kernel@vger.kernel.org
In-Reply-To:
 <CAHS8izPWsTh=XYvMfdGy1P+RS2p-nzA0cvNXU81awys4OJTW8g@mail.gmail.com>
Subject:
 Re: [PATCH net-next v2 1/3] net: devmem: replace gen_pool with freelist
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

> You're warning here that you can't destroy the dmabuf binding but
> you're destroying it anyway. Something is off here. Do we want an
> early return or something else?

I'm assuming we had an early return because gen_pool_destroy would
BUG_ON on non-empty pool. Let me just reword this warning.

> The LLM thinks this NULL store in unnecassary. IDK if it will help
> anything in practice to remove it :-)

No preference, let me remove it.

> We don't need freelists on tx right? We should probably not allocate
> them then?

Yeah, good point, will make it rx only.

> Do we really need a secondary for_each_sgtable_dma_sg loop just to
> calculate the total_niovs? In what edge case is the total_niovs not
> just dmabuf_len / niov_len? We do a bunch of alignment checks to make
> sure it all works out to that no?

Agreed, that should work!

> binding->total_niovs and binding->area.num_niovs seem the same thing
> always. please get rid of one, probably binding->total_niovs.

Will do, thanks!

> I wonder if now that both zcrx and devmem use a freelist if the
> freelist should be part of the net_iov_area. The point of that field
> was to hold the common stuff actually, but I'm guessing there are
> micro-implementation differences that will make converging annoying.
> I'm fine either way. :shrug:

Let me write it down too look separately. Agreed that it'd be nice
to generalize.

> len is referenced once now; not worth a local var.

SG!

> if feels somewhat simple to exclude freelist from TX. Something like:
>
> if (direction == dma_to_device)
>   <store into tx_vec>
> else
>   <store in freelist>

Will do, yeah. Thank you for the review!
