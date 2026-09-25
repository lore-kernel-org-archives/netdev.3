Received: from mail-wr2-f29.google.com (mail-wr2-f29.google.com [74.125.225.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B0334C1C
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790323133; cv=none; b=Grc92Jm9NrpiO+ZgedkbNIwID7Ef+Ttqqth0yWueEyQpBSxrBk9fceHGvzrM2C5oxKMhtDud1wxoX/V1gdXg0Qs3k1L25e3dsOS/0SwKJBmQZ1wuCssQ0L+6DydcbxRjDkHwtjS/FuJYpJgN0wirO6k1opC+sKCM0eHUChs6MdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790323133; c=relaxed/simple;
	bh=owvT5MkOsiDpLQIP9Fll5Zuo96WfQJpF8vjQtgKYjwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuDgQ/QwFYlZjIY8icMC50jLOD8uW3ELR+Nh4zQREwnA6JZBx5JGPzQtxFs+n+wQ1YOmHIIlxjyZz2PUqL/kmxu+QjSBuVuVoa7eF8dObMWxXAGnWqKy8bgneN/U67W0KFpPbpd/oRnq611gPJTMVtQFZxtc2Pm+vkPPeR7Ctek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=PPA8x8C2; arc=none smtp.client-ip=74.125.225.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="PPA8x8C2"
Received: by mail-wr2-f29.google.com with SMTP id ffacd0b85a97d-4887ebc85eeso22014f8f.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 00:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1790323130; x=1790927930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9n6ZKLFcFHikmLkQ5fygAPRgtfnum06DEuIZGMf2IV8=;
        b=PPA8x8C2XLa79+CsUHdNWX0I9WtnFvMaYNLFLvgRv7H10VpmHjy+vZ0d3nyw5ygb1S
         qODTZEI4R4fYUsl+wiXKXKJReVG8mPB+CgI6td5/441cENyomzIaJfM/j8axXFyUxVEb
         qZ7hORjRGGEHSNaCnGKslOzSiffUN+DmP8Ty6LUPTRdcVLuOnl1fOdQHGugI40gTtcQ1
         tGlu5X72uMFBbo8Mg1MY9viVcNE9nCBP1iLuFbIVL6zj6agscIqdZFfap73eMBZ5MxeA
         iY8ePIBGekOVWSYw1TgUV4Ujw4xpyHB6RIv2793fsbbd8tA9gxe4vI//krTNUCq2JMFD
         OUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790323130; x=1790927930;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9n6ZKLFcFHikmLkQ5fygAPRgtfnum06DEuIZGMf2IV8=;
        b=GGYAQK+8KbHa3lICvhXLXiMMckEym1Qx6InTYtJuuUQlNka+DiRemPiQMVo+/8acY4
         0fyGYfRptgxaIIFHOyjt3lT7iMFJ7pb8S9BHXI9Zk4G90nUnK+j1qDORtjZ9vrK6SbdN
         3NNxDm+Kz4/xUSyCJWetSWhPtyvPAvK1Dg789a4Md99oUh4xN+USQn+eQGNHOcNB6FVN
         852FrNynMvdLpFsJirnT2tyPTk39S/Jb18FdPxtxfUPJSEWLMvjFqshXpi58YqCLjuWP
         62lKV1X2RbzF3Eof5edoeGT/Lfq/IUwyZkjPOHxPppV7cXCGhKgccFYi8QYlK8UjVtWN
         Eg/w==
X-Forwarded-Encrypted: i=1; AKwUvBwUK3x9+RP/LC2VTfaYA37N/g1/eR3adpVft9iwrD1McTxSSjsaAYBBqwf3v50ZWlm2awqZe+I=@vger.kernel.org
X-Gm-Message-State: AFuF++kyos1EfTEqM0EXqd7Z6DXvNwwdx1Xh4hYEzvY+2IrFhX0Bi52j
	I+cKNb58p2MqkM0jTDfgfI2fq0lCD0XjCXtVSwkmZwLsCs86EitxERxUTx+melstAVY=
X-Gm-Gg: AYBFou2hyfx+9fxfodb+XKtUJJ9B8JEdXLz1Z5VFKJwNcjKipjugQ68eUHCDcmudoJ8
	TzWdkBWvNBdSuNrd8zMTjYugONPG/yQRFY0G8Rao2F7eSGyw/kL6M/w1L3Vp1CBc1TbGA24qMBs
	Tu9DkZ58DP91wzwHOrJJxuRvAN6wa0+tNW9HeIz/yjxJgNKrmozpK+LyIyOzXo8Xs9viyXZrR0d
	0ZMrGr4D2ak//ZJOYGn045895AvpLSBbvPU5Oc8qEn2XeWMk7147ecSErIkIkC6Fo/4mFP+PHrR
	2MjVPJfmKH2DZ2RJtkbm5lyffAlmSptHiyU3Wc7YYYzfspp6ubOqF59mWTYAiI28xO8zOMMS9je
	cSpxmBvP+DVrcWaJF/7zFQ5lTGMY2p0ON3p+aasvbCLNyV2pT0QsiJ7t3RWg7EgXSsVYSZVFvoN
	MSPZT6brSfkZnFrMZN7E3jqnBnbGYIqioCuoFWDuyYxYKp2KKop2wZ3zspzBCaQbiOaHficuyXn
	FbumAESQfXOZBY/yfVk024V8idSMbbsu/1fHyAiJZp0ev8xhc4=
X-Received: by 2002:a05:600c:8b09:b0:49b:9241:7ff0 with SMTP id 5b1f17b1804b1-49fedce4db3mr40284195e9.0.1790323129618;
        Fri, 25 Sep 2026 00:58:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff13b3c58sm16717205e9.0.2026.09.25.00.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 00:58:49 -0700 (PDT)
Message-ID: <51d27e49-afea-4416-81ef-9ff132820066@6wind.com>
Date: Fri, 25 Sep 2026 09:58:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v7 2/5] net: add a generation counter for dev->mc
 changes
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20260924011554.3494-1-sigefriedhyy@gmail.com>
 <20260924011554.3494-3-sigefriedhyy@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260924011554.3494-3-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 24/09/2026 à 03:15, Yuyang Huang a écrit :
> A multi-part RTM_GETMULTICAST dump of dev->mc resumes by position, so
> entries added or removed between two dump rounds can be skipped or
> repeated. The IPv4 and IPv6 dumps report that with NLM_F_DUMP_INTR by
> stamping cb->seq from a per netns generation counter combined with
> dev_base_seq, see inet_base_seq().
> 
> Add the equivalent for the device multicast lists: a per netns counter
> bumped whenever an entry is added to or removed from any dev->mc. The
> list helpers do not know which device a list belongs to, so give
> netdev_hw_addr_list an owner set for dev->mc only and bump the counter
> of dev_net(owner) where entries are created and freed. That covers the
> dev_mc_* helpers, both lists of a sync, the hardware sync helpers
> drivers call from their rx mode callbacks or their own workers and the
> reconciliation after an asynchronous rx mode update, while snapshot
> and other lists have no owner and are not tracked. It is atomic since
> the writers only hold the address lock of their own device.

For IPv4 and IPv6, the generation counter was initially used to invalidate some
caches; that's why it is global. Here, the goal is only to check the consistency
of the netlink dump. I wonder if maintaining a counter per list would not be
more straightforward.

A helper could then manage list->count and list->genid, both evolving together.
