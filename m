Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291674;
	b=rIPc+N/2XeI7SjvTfghuPy8FlgbAS1sLm2WaUw4vtbJAhNd2E6pFu1XJkfDvMTB7Odlu
	 k2+traTcup0aJFsTZYIkwMg+7IEB+TxryOZVG9ssWXui9GYDkjlo2gkx46br9zxG8Ls3C
	 ShrJ3lWzWRYoHGuGZW8KR0xdGZNKgeHkiLW5kJ0j4aR0UXhcJ0YCBGE3v+Uy1qVY5HZeQ
	 1OePN1C3MhI2I+0TxA37c67HzzLKPDAHC0PLf8JKFPyShUR6wJZ4tn4BvlcjqRV2BFBgx
	 S0CaenVVstpCy9tfMddSyNY+e1SIuRW8wcvgYzYvrU3LMOHR3Pf1alxEpmux/OeAmxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=vK/1Q5dT+k2qL7WE6m9fO9udcHutWWbhzuslIdYzoP4=;
	b=iyeh9ZubO+BhmNqLfNkoUPZ7quLycNBX31p9oNlN+msBo0901Grz1WLuddGyyxQeMNZG
	 nqiWV7+Z3RoM+OgemZiXnHeWO+60XephtYUG4jKhIy7dp+TNkIj4by20dJmdkbz8mszns
	 wsTcGN0U6rJLoxtxNX+uOdzs42YpfMOIpv4obJV2SiTQNOELKRzPeM9QpfDIsOmV3mNf4
	 iWF7XHRuH9y8jj0irAx4hf3+AqMArCa9LeK4PYn3rRWRFGbDX/DRGr9ltfH91vtPE9SKh
	 thn9mOsKonysFoxyi+GCtXO4f6oqRYlwdfMtnt8wlXs40tHf0RFAZr49n6tFIf8qbyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VaSaZa8O;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE6606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1CE6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VaSaZa8O
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3adeba76cadso1103892a91.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 22:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794291673; x=1794896473; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vK/1Q5dT+k2qL7WE6m9fO9udcHutWWbhzuslIdYzoP4=;
        b=VaSaZa8OVQtBsXUaruHulCklkjbhXykKUdqCGpkbD7wQvKwFM9accEXzR/wA2DxujV
         R+hTr4/RtH34Yd6vIGfhXmxTx7PM16YNP8f/VmmKSW5sAZWeA8Zxb9Bv9IgzsrnM+RAk
         o9egYlRj0QlEqajSwAr4H9Z0DHmsygrNQAZ5pcUocLyUwftb+CBqZj+JTU/c1DrkHvHw
         9Lv4b6RZ6XP9e6hmEXChMhb88/NYNby1496EoV1Kz+CDplcJ49LEWfYN32nbnmHE2k29
         0m2fKYQ0WuIZ6fQzKQKhqZETLWOIfyQs0AB9fsweBGOdWYpPNXNjHV/JeAgWcuq3IqWD
         7dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794291673; x=1794896473;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vK/1Q5dT+k2qL7WE6m9fO9udcHutWWbhzuslIdYzoP4=;
        b=s7AYNbGwSsbnMv71IzJFAZkwUjib3jN1+AJboTT3RAU+TjtvidOdLuaKKe2UJ9a/5y
         BBnWB6y9tFLl3yGpeP68EU8dnfT0YU1h1L/xrbpYBP4MJiVmveNwF9cy1tzQxK+U3jP/
         SpcsBNysWo9bQoygGjEDlSOcF7Gu4XbsxbDvSrLUYl82qZMwxCU0RsMSMAKR8Miyketp
         fsxtozN9v8WVd60anK4yFkwB5kRbqR/S4I6GWqRYhuiLs9Ho105VyWrzLAXQ/Ucd3BiR
         Q111D0Rr3hXZlpvuGzq5eRZOIXUUFV8HSH78JIdxbnW5tdJPw2WBnbBRP+pv6xAdCQ9t
         sG7Q==
X-Forwarded-Encrypted: i=1; AL+hErG+H5lYydn0oudDWlja4oVsS1V23ww6vxAL49lY2yHT3FcjZ3tFhMbkOCFpj4ktqIPNMSWCrLI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sBWP29rm2NZfgA5cPvGjElfNe1Kw+jXVkotctGhZ9kzS/vPUN
	BgKoS1Sle9Ku9RFLV0KEwbhGDUPaZnagHQUW1/WkuunOqbtQuEOs4ae+IAoCdWoh9pXlyfHQqjk
	XBCuOVw==
X-Received: from pjbrm7.prod.google.com ([2002:a17:90b:3ec7:b0:3b0:ac19:f886])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c8e:b0:3ac:9ed8:f30d
 with SMTP id 98e67ed59e1d1-3b166cd0101mr2004963a91.39.1794291672832; Mon, 09
 Nov 2026 22:21:12 -0800 (PST)
Date: Tue, 10 Nov 2026 06:21:12 +0000
In-Reply-To: <20261109092016.2082-1-lirongqing@baidu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109092016.2082-1-lirongqing@baidu.com>
Message-ID: <avK3zITXAK1kVQJe@google.com>
Subject: Re: [PATCH,net-next,v2] af_unix: Fix wrong socket tested in the
 symmetric half of unix_state_lock_cmp_fn().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: lirongqing <lirongqing@baidu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, 09 Nov 2026 17:20:16 +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The second half of unix_state_lock_cmp_fn() mirrors the first with a and b
> swapped, but it tests b->sk.sk_state again.  Since b is already known to be
> TCP_LISTEN, the switch only hits default and always returns 0 ("no order
> known") instead of 1.  Test a's state instead, as the first half does.
> 
> This code is only built with CONFIG_PROVE_LOCKING, so the impact is limited
> to lockdep failing to validate this unix_state_lock() nesting order.
> 
> Found by AI.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks
