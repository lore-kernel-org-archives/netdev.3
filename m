Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59AD43803B
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386954; cv=none; b=oVsEcbYf3RcwOfoiFK4Hwenfif3++JqZvLZYAIOKmO/ob5G1jRUvJxwgIIXxG6jwbVyR3w/NyXgzUZ5uzOtz4Dksxx/yP+BHNZtvapR/pYGtO4OyJJJWo1jkRmm/AXJ/MVioulx7yBKH1LDxOCeY89R456kzodsoSiuYpjwWp1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386954; c=relaxed/simple;
	bh=4IVWRcLRZXG5mOOKciVTw4By5F6dI/gIUOH1wHmHPOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JL/l6hFJaNkCP4lub7jDZIv/10hakDYTJCtaIMBxinAyxc0S9ImbkLbwPTfcCSbzbWCyw57ZmXVkO2BPhN0o9nqH0hekFkbJVleytpi6MF9cD5JXDbzUhqDnAnxQTQb42rQASomPNPf15c9MMX9dj0JnPRBmxvIJs3v8TE4bfPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWxtYVLR; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWxtYVLR"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca7d1dc4554so1183445a12.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786386953; x=1786991753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=23HKfRQ9BSobiUbEA/UGqys9deBbbeVTQfHggJ+Eyd8=;
        b=CWxtYVLR8K1ee+JDl+OqCfKgRTWRwm6T2zI0d8Qcs01TPAqZJmKVdr4XIq9VXFjc1U
         q/bAEL57zgZpwLrSc+6GApejpEAG+RN6ISCq57ZVhe7nCOzuJ9BYH6EkapUVG7M7L7RE
         mgJag8bJ8RbfpQh/WK2DWGbP/rNZp0egkNErjj4U6DKAADg/Hygvw9anYG1HSqhuNekb
         En210g5U9eTe/pkw4+GPC/vT8DnucQGS//2Kj5OIGRSRUciBRQzie14pzE+lo1m0WfNZ
         WNMADJyajy/kRJPNFdYaZgWQ6UliIshr6gmOE6Z47UkPw+T/hucZ633q6vMA3hWGjRLp
         RZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386953; x=1786991753;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=23HKfRQ9BSobiUbEA/UGqys9deBbbeVTQfHggJ+Eyd8=;
        b=KYu6C2lvIuAk6oH8021TZZnQP8L/XpVWp5AP6Ts+udieraMnymqwy21i/sW532e04b
         uU47/b0urcdOIqaI9L5Ihl1+3iGLTqxcWRteJzF7qBPf7IHGlgZ3z0aZHaEwf6GP9clG
         SG3ERzKx4UWKudegm7m/mM4SYY6QpdEGFKwj0kD2CEXbg1T759hpvRD+9DEG9NXH1u4C
         u3dl66gm3IByruXe+1SP5g8prPfRJfskATZ7Rw8zaz79TyCsTp9D6gChk307U+aBs9g6
         3WBvoYWl9u4dDJfAwprjpQkZF7S4AbqfYmL2JU8yTrjAL1h0X9LuUgYcLemoKhwJqd9n
         q3gg==
X-Forwarded-Encrypted: i=1; AHgh+RpbE9ByEShoOOw3qG6RoltbnSf/mIcFROZ0OUIJza0OPA4qULZHrz3XTsgI6any3L3rz/Xr9jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf24+rT958qnDMM8Z5Ln3E41r2U76WhFruRI2NwSfeO7W1xRPM
	h7WF4m3HzoOLZOGNClfk1YlA1FMUMSpmM2ND2uk4TuY3hIqCN00OPd89
X-Gm-Gg: AR+sD13NcymYkKMo4ywpUz3xE5tD8REYGmFTN8hKYpnPEYfwe+acizKPN6g3bkG22JU
	MC7wlXRBsoJWES117yaWn0ERn7PjlGJNxhSiiFJq76sbwY0rNI2BDKq8gnkPUj5KH+7WPzkkvDR
	1oC879rEdDcK8lLGcKFNcEjfYUiI5w9OQsVLZ5OYoLXfUIp1I7dXanFa34i3UYyI0C4FNi+kpEq
	SC97heZVnhTEF4t6BVnuxUVFhodU/RwltoT2Yg+3doKTU+1GJCd2zsulWiUgf+UYd9usziFfJhP
	SZROH9LCj8BRev1akNKjBYQa1huTR3iE+BgwZrGAhbUHIXfkShTTDiGukpL41WBtbC1Mb6MC2c1
	GsljllrpcPHQ14rcqqgcKTBIlo7FKLpsw6G2ocazzLR+TJh2sb+ZxbV7Crvo8EOxUOR3P4Tv4sA
	j7FHUFoAjlWeBitQ2pL2GsESeVByVAIwQHBVm7jnpVwmALb0Wv/2J0
X-Received: by 2002:a05:6a00:2d0c:b0:84e:2382:f4f0 with SMTP id d2e1a72fcca58-84f2dfc8ed4mr47552336b3a.4.1786386952925;
        Mon, 10 Aug 2026 11:35:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3a18a5sm4308106b3a.8.2026.08.10.11.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:35:52 -0700 (PDT)
Date: Mon, 10 Aug 2026 11:33:58 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org, 
	ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com, jiayuan.chen@linux.dev
Subject: Re: [PATCH bpf-next v5 1/5] net: Add connect_socket() helper
Message-ID: <anoZjx8Y4IH-hydj@devvm7509.cco0.facebook.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
 <20260807171532.125149-2-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807171532.125149-2-mahe.tardy@gmail.com>

On 08/07, Mahe Tardy wrote:
> Add a helper that connects an existing socket while invoking the LSM
> hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
> logic. Other socket operations have equivalent helpers that trigger the
> appropriate LSM hooks that can be reused, this one was the only one
> missing.
> 
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
