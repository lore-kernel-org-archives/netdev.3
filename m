Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE71A569F14
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970162; cv=none; b=IfkEQKiahK8t86PId6/NThWEg3m+RhJFqS3/kMYG8CfQV4e0pY0DDTTgfCbw7ewkBI++SM4Ss/z2MKLUFhekY2ek2HnFxpcPdGTGzp93w6wly9aj42pXKu0K4dy9XIsJP1J/kBz3YofMSDHd5gLwXtp0mc42/k5AJUZquOb6RZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970162; c=relaxed/simple;
	bh=eAly930iExSc0nx8hDXxCQBEPYU0uHos2zYVFXGsAlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3Kzo1qYNiKlJZ2QRm+85Ke77SyHqFMywZ7fHy+YlKWVLnBH1h77tc0MEdtDG4zylHCR/xEm86+fF47ABOZZyD9Y/QGZxbZK3byxEfXxXi4AFU6UfrwuQwv2uPLISZCJbjispUgRjmhAwCaG1CrI9n52g3gchg7cx+TmzEgnTaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=WrruB8P+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="WrruB8P+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5faa1cfso1416465e9.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1788970159; x=1789574959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SU+Vq0Ts2ZBtfqXXPBx43tPtSAYvdfKOjWmn3OOcizQ=;
        b=WrruB8P+IaN6NIa/n6Khcj1Za4dxN1CVr5op6iFKqpXz9ei1ISp4ZJJ693p/jzli+B
         Y1wrCd0208HAcu03sV9Ng6skQQBo6STLbUzf8zyynNikrmLea0t1+F7XC1OgGzxc5N5/
         PSyZ2P/H1tYXbd5+gSBQxWI8LvcYRBBgtcwRXUsf7XQCrbDTyArxoggxEX0tfL59/YIL
         F0szpGdUMrvLDlkIHaveW/3rxpUmrPrWROVn2FRUyocicsRuOb4akAHDIruPJtOR8h5O
         5a/dnhp7rM3hl5xltnRqhuQP2sWzsBWMiWb4vsGm2uzkzmwR0NEItsDyPgfsrs4prDrW
         O/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788970159; x=1789574959;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SU+Vq0Ts2ZBtfqXXPBx43tPtSAYvdfKOjWmn3OOcizQ=;
        b=aHjGmvFKENetJ0/18ul9Q59DNeGi1RVv54H5j59yhJAIsQJvtq9pbscJCAzvEFGEL/
         pihVW/CKG2Z1FFf9hATI80yyBRUZAnQvGLEKhhRy6xOB1hxnLiysknbdSwbIZdzd/JiA
         j3sjt17e1NcQcV8VoUoCUCuepLAHjNsiktAs7ehyvDiMPJp82tbs4fWipMvBG5qDzueo
         g4qIao3SRH3tRtIc8Eyna+SOOxpT17R1N+8b62iTojHefyWBWjGnEQbKnkLaYRwD916Q
         DVt1LPST60tEc1vKfKR6FIKHPd7BlmaXvumN1G3gZIFH1NvjwH9kERtqPezsU2yyJCPP
         L9gQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/atdH+Bu8tDQ1mKuI/Aev74eXxy2VvF3ECl5jnes1X8N8TPlHuT+YDbdr4sE/FGS2Xjaxm9A=@vger.kernel.org
X-Gm-Message-State: AFuF++mksjeFQK8hK5IPL4UrWEW3HOI04aWkPiP23OWSlAvwd9SJ7qCc
	lZOu8JI7I8KHz72qHGFRlAGUshOsnYIzpeaXK5KqTTM3zH7dC7vt3TaQVW3TRtRSEEE=
X-Gm-Gg: AYBFou2tEyApLzvk4se/xRwMbf7nzWz8fb4hRWmMJrlOADUcECVjm8T4THDFYWjN7o5
	bgnEasY21la/oy+++LbxX+x2O78ytptFuhz2FInIlA3TGVWRe2cUy5IRSevm+ILdl2hI60JDHD6
	jSOtcXiaPA5FIvNABZR+Ga+64hXcz90MdpNmov5JKpwNzAylcZgHDSsQd43UtHxJmDp2kF+vswj
	UVDsvuru4lOnONW5v8i8DpjjnbOle23l1DSACKqnuqHnD+MFOHVtq0o9nALlqLPvEC7tG9h070x
	73e15w+djvG/JJRiSznML0hoSgMaegVDQ53LZ0cQlnOelYagrWf8knIdkJWOXi1tP4w81E93Usk
	u93/p64/HtI0T4M39qojvO/FVffu1jEqLIKwCHLbLIuRsClU3VuFaXQclz/2vGK3A5J9sBoGGwF
	roxwhLhs0DbnyFHWdFkuYhvci4fsFwTK0fT7gsirnuNm8fb26xiOfrZXWFTFOLYV7i4jZ99G6tR
	bCx5T5mbx/jB+yGtJ6LlTQcdgjXGN+xeTpH5Mucqt+Lz4Uc5oMt
X-Received: by 2002:a05:600c:c494:b0:49b:916a:e553 with SMTP id 5b1f17b1804b1-49d010c2a57mr266347345e9.0.1788970159014;
        Wed, 09 Sep 2026 09:09:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c39086sm746485e9.10.2026.09.09.09.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 09:09:18 -0700 (PDT)
Message-ID: <a6836306-a60a-4bd9-8173-0bd759f73dad@6wind.com>
Date: Wed, 9 Sep 2026 18:09:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v3 1/4] netlink: specs: rt-addr: fix the type of
 target-netnsid
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260909133247.113923-1-sigefriedhyy@gmail.com>
 <20260909133247.113923-2-sigefriedhyy@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260909133247.113923-2-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 09/09/2026 à 15:32, Yuyang Huang a écrit :
> The kernel parses IFA_TARGET_NETNSID as NLA_S32 and rt-link.yaml
> declares its target-netnsid as s32, but rt-addr.yaml has it as binary.
> 
> Fixes: dfb0f7d9d979 ("doc/netlink: Add spec for rt addr messages")
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
This is a fix, so the target is net.
Could you submit it separately?

Regards,
Nicolas
