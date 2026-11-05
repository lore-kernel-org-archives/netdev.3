Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876944;
	b=eFL/ml/+BReYb3omQd7Wqw8BREAkpweYgns00GnazGS1L+yoJeS1tdh6ltKV0JqlgX+l
	 0soAPt4WGxILbPDrEeQ7gWjnbskxWw4ZQxZuQnx5nUoZ91sFZD8FMzEld43e3GRV7aG+t
	 rKlzPzmJC+jTthzR4PRIK5IzRnkiD3JuUHAA3YYvGPVedl6bk0nIWCNgK6EXeV0b8OP6o
	 a/Ua51yWZ6wGpUKAVJxvdRAfdGj4rzeY3diO8EjBE86KGf/HQu4eC5icNydxFEEAD2Wnm
	 IbXIAixYmPC+t4SbmuZEcgMkGLGCGdqYwlQTjUfJ+nwJpoGvK4WaWVyg4ldnLat9YWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5zh47PhyGNcCuyOqp3+KQ7znXgLobnEyNmBv/7LObTI=;
	b=y8InyOFHWfKtYWOfb7MgT52LBPkkD5GUfqbVuS/FXP5CmtrBZjg42KrcDwp+QhEd4UO9
	 CHyM7KVJIexfl8VmzEK4CSyngvPHbpncMoiyJi5kVQIP4aHowHxg9A+5e74tlGEp/Hb5t
	 W1fKbD7xl/ENxqqMH/yznYcML8r5HRN0ZuGy1x3vEv+NDVKzNvCSSxsu5NuHE0iZgNYUh
	 milncLHlUkw5NJbS+/KQIsOMc3rse+rzuxmbLekhQ7ILPEHt3Vo4qOtYS+Sf2dZw3SbrN
	 m9lng4f+M8xYRffhetgQudBoL0eXR8emlMvAdotUoRl5uSbk+luYpcOYgvoPB36p43w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=anxDHPe4;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26C606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 11:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC26C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=anxDHPe4
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49d05d51553so10787435e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 03:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793876942; x=1794481742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5zh47PhyGNcCuyOqp3+KQ7znXgLobnEyNmBv/7LObTI=;
        b=anxDHPe4qYMe5qqmqd0MSMf65qP4moQA3GuGNN2kFJ+wr8FIpecXPAEKrLywhHBhE3
         2ONRWPNI7u8WJN0gJZ/c8AnHRMkPlOVO01cuLkSSFLEcSPryxLODI6bauIVLTlF0TY5F
         2pDiuFpM6e4TTNg+vPvEsmsCJ5oW3j4HCqBqRQlbW2/D4vQX89c5/XEoZicysquf5IUa
         WgDJajZBM0cyTAhZhGK3Ww0V0Oi9XuirTLBUYTvsUvxPUrrUkTz421u5eC+XwAjtcvMz
         WCyHa2EuZa6qtyWvylKJ/cNaLw3CYU+136vYGmfWlVLKwSBFF/eXkbxjG4jhnr3hRnRI
         faUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793876942; x=1794481742;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5zh47PhyGNcCuyOqp3+KQ7znXgLobnEyNmBv/7LObTI=;
        b=oCTbTUt+8bg3GYQvK4vkl3UUhaIBRYa/bJHEekRs5SzdEUdMhojHktV5bJRbmKk/2K
         xUY03EP9RmKb/c5yM79IIRswOzvAmTT4jPycINDROGciZ1rKlZ6UOzO+v/KXUg6Bc9Yf
         T8RTzY8IYsh2KmLhzMXRGwRtzf6WmLUMOTKoqpdylaCi4vtXYh5NFd+WgHqWiNpRjPef
         TzTzAtqTR4sfA4Mw8AD0Rbv7AJcoe6er6lDRY59vC10/bFGXCeI4kLy8I/VFCln8qbTu
         4yHojWxI+Q4PQ/VW712t8u4XRBK8yC1aijhiGPklKi5ycjteWpFcCCPq997/t5QsC2eq
         0Igw==
X-Forwarded-Encrypted: i=1; AKwUvBxD1UqWlPSGiT3GxVZAs+iqWBKkEvwDBB+d8ITmX9VLC6rLJuSSXIck5OiGNVCikgO7D/5CM2M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0a200FbNZZcOD/uNIiZ8Vny3V1hSXFhJFeNMrxWkaVOUBP5Id
	cXuEhnu8MPDjAFxGma5eGLjfCOY5xvVXPhgqh74HQ4pPLm4KyLrI0deL
X-Gm-Gg: AYBFou2EPvAGI9YiddhfOZelKaW6CtP4BQJ2OVlsp9Idc0o7ek4aueAAg4kMK+z6h/o
	mrh9/Ws73dCue0mqTwYanmIG4oUjZH/Bnti4kf1wmB+q7Piv69iH7jY69/dhp9SgG654UOQZPRt
	SGIHrk2x1xNbrdfLMciPdEMKwRrzKG32BT9U1UKi7nkMThktQsuMG1Mtet48/bacvfPVCMgjv2n
	7U/GzLoRW9bnwfc6cEhNUzewTW3Pvvao+JMrQActwUd+H+uAT1XUMXeThCDD+dHravn1NFo010k
	z/lrbiR2LgUIim6mz6b+JNQO7sYnMkDY0A207hnb2yEa5wqtSu/A8PJN5USKqgdB1xUNKVZUCYq
	s6vFlRf7RLGtwxP0XuUl04liJkWyc779rQcNw4XH0SWCEfmE6wL69boMAGw+ydn0TbR4lq/eWYz
	Tc/pgIKXcIyKTEzQOcPQXJvy8Ixqd+H0NyYQTYUi0kte5711vMD9PdO3GN5gOXgs6B2B0lob1lW
	KVuEW8VejQ5cypUXhaV4JkeOskeNMEf1ctr5DPw6ypQEw6u3T3w4yE3l7xkSJCWQGoKdD7FUaEK
	3vAFGeEnon6PHotwq4JbyXU2I2TdazdSHCcu17qxhqRRx7yqY465jEzYjQNvso9e
X-Received: by 2002:a05:600c:848c:b0:4a5:dc5d:20f7 with SMTP id 5b1f17b1804b1-4ac175669d8mr457195995e9.14.1793876942030;
        Thu, 05 Nov 2026 03:09:02 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b433ebd278sm110253935e9.3.2026.11.05.03.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:09:00 -0800 (PST)
Date: Thu, 5 Nov 2026 11:08:56 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: tcp_ao: don't shift a size_t by 32
Message-ID: <20261105110856.2dc9f08c@pumpkin>
In-Reply-To: <20261103163921.641347-1-sashal@kernel.org>
References: <20261103163921.641347-1-sashal@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Nov 2026 11:39:21 -0500
Sasha Levin <sashal@kernel.org> wrote:

> gen_tcp_addr() shifts the size_t n right by 32 and masks it with BIT(32)
> - 1. On 32-bit architectures both shifts are as wide as the type, which
> is undefined:
> 
>   aolib.h:230:40: warning: right shift count >= width of type [-Wshift-count-overflow]
> 
> Convert n to uint64_t first and mask with 0xffffffff.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> Found with 32-bit builds of the selftests (gcc 16 and clang 21 with
> -m32, with and without -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
> KernelCI's 32-bit arm builds show the same warnings. The changed files
> build without them now, and the x86_64 builds don't change.
> 
>  tools/testing/selftests/net/tcp_ao/lib/aolib.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
> index 53be1744237ee..71ff975533089 100644
> --- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
> +++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
> @@ -226,8 +226,8 @@ static inline union tcp_addr gen_tcp_addr(union tcp_addr net, size_t n)
>  	union tcp_addr ret = net;
>  
>  #ifdef IPV6_TEST
> -	ret.a6.s6_addr32[3] = htonl(n & (BIT(32) - 1));
> -	ret.a6.s6_addr32[2] = htonl((n >> 32) & (BIT(32) - 1));
> +	ret.a6.s6_addr32[3] = htonl((uint64_t)n & 0xffffffff);

You don't need a cast or mask there.

> +	ret.a6.s6_addr32[2] = htonl((uint64_t)n >> 32);

That can also be n >> 16 >> 16

Also see upper_32_bits() and lower_32_bits() in wordpart.h
which might not be available for selftests?

David


>  #else
>  	ret.a4.s_addr = htonl(ntohl(net.a4.s_addr) + n);
>  #endif

