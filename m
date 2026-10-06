Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33238B7A7
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324431; cv=none; b=S+cBoOLXnk7kuZB2KhVANI6h8iVnkBW4MppGGDZv5YVcKge1jH2VLt3eB0XkDY453QpQBv9eqHvANMF8dpZXsAQ/BgaOfZUljalnBtigX16fK+sntfjwcNrhjTNkSCcJEZqH4JRJ8ZmqTY/Zk2IpV2DROdVOGdIMvMaAA1za+PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324431; c=relaxed/simple;
	bh=tqEGtAhnxbXL9GpbFYtG/woquE6EdyIaEmoKb6GGAOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njAc/BkNPC6rTGvqgSpInpi1cwGsbTZ3aDhccCmhtRDcJCQ+PDo6TDbXpe3VwBrKK7Uz4S4xiYxiLNW7cIHRbRMmnH60/c0zV70MJ146S5Mlma5F7fuSaV4/JDFcXiVu8osq/EUxcAUzdxYYoh1ROqivWU98+d67sKjDH2Gl0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oR8pV8YH; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR8pV8YH"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3a81335d55aso1088145a91.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324426; x=1791929226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nuzdd06tW7sFf7TARBH4wDGelSXzM2xlPAPhaZjPmaU=;
        b=oR8pV8YHH20rjyYN0QHYj9CvyPKVaYMvDRDNIWx4f47I+sw8I9tIGv4CIFakPBkqt0
         HPXRn5+kL2+LYG+uTRUUlqucBGnXV0dX1Ob93Zl6TE/R1k4x+sCn6A7vmv8AnPA9+HpQ
         wXH2Jy4OAGHE96i7R9LWezHiLAfyUFcfH2CfLfgyA7ygJe7dZ4Vxc5uqPOu0cxkvuqhv
         LqsHhhcU8L0p68sAQ4ho7Lu4Ek6+WD1smuBGL/CGgHAgQEQ5B0+XQpQ9aOE5p5X7DTbc
         u6jLyqFSCeHQtwsC0A3NDvyxoPXXV/6d3S+SRZJh2isFcyGhfS4aE5jhvyysJuNrYazs
         CKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324426; x=1791929226;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nuzdd06tW7sFf7TARBH4wDGelSXzM2xlPAPhaZjPmaU=;
        b=oTMpgSGL9o7/1U00oV3nsftBfs8vP+aS+MC4HZzr8TmAZWTUJnMzWM+tirnst6405P
         L+FuB7E0TMj6DE5RMxb2herMQ8sFqUxLuxyByUHs+ww4gcoey5A+m/dMv2xNdfII/99H
         9dxe+8YMDMrhXjzYlCBE/oEV/6KN332tFbaCGjA06eON/dYvK2h8UqwzflvbBRfIApMU
         e6zsb4y1PXX9HllT1Ih/uOJefK6PhrtOR95RWAhvU4lPNBP8IsFe9/zFLX7h3taZfzo+
         AIwY1/hdhRWZWyLTCHibtKAa/vTG4QqsdnuCzy5+nKQSzRlWJ0LdMcbSJRhYPQYRgR/d
         aYiQ==
X-Forwarded-Encrypted: i=1; AKwUvByxqjIl2EVkxcfHOOMUAJt8Lcwslef1njcGeLOXEkllrlwolvHgNP4AwXEU/GUTMnNJf4eeWgM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBGTanCxOzrO8aDh9xMLI033cu8dgR5NHLv8YHhFttXCHj+k9P
	TVxf1CbA4FtIpFGGEsjTifR+LkBELpTEjyIYIwZq6fm8YEOc0CfMYOO7
X-Gm-Gg: AYBFou2DwZG7dxF/oE/b4MjpWbWSse8Z9Ww//w2xN63tf8HhKZh35919+hYTokQv7GE
	E/BwUWeASmvrs1wxJchQHkcxXgN7VNjLTqa7GPtGH5y4r12YeS+FIAAUDhbfMjakQmcw6Vy0868
	MX4Zpygwrnz/rlrhnulxjYPIVG45754B+vdkmAtI2Y+mVjvUF/zmhTUvxBg1a5TjiDUMs6OzGcf
	KiiIO3qQyJj+lLw105yLsbmgwXuo1WRJivD6zQioLOldL6CtM0gTeOj4tJSanz4oxkRC4lQpqv6
	NJ0SiA3jvt5SQ2QfEgV0L3Gd7aeXTKwNz5ndWWebR9N5PPKtC7CnGb6ob0gNDwuoaytRQTX6B56
	pvDMNCD8ujux7hJYrNvH3Oj4oPKIw4wY/ryWEZoEOuJ97KCl0W/C76vghwpihLKpIhexu3QT6dh
	Qn4kf4gsi/ZK2vrIxBqSdHR6eJ4Mb8lpQUBxLqAxivdxzdQSpqyJ1E+SutC3VV6U0=
X-Received: by 2002:a17:90b:5410:b0:3a0:f2c8:9ad6 with SMTP id 98e67ed59e1d1-3a8a1568aa6mr345073a91.64.1791324426453;
        Tue, 06 Oct 2026 15:07:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89d5ced5asm504174a91.0.2026.10.06.15.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:07:06 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:04:52 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 03/10] selftest: bpf: Use
 bpf_tcp_ops_set_flags() in bpf_tcp_ops_hdr.c.
Message-ID: <asVwfwx2Z3AxV_Ou@devvm7509.cco0.facebook.com>
References: <20261006192601.1875100-1-kuniyu@google.com>
 <20261006192601.1875100-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006192601.1875100-4-kuniyu@google.com>

On 10/06, Kuniyuki Iwashima wrote:
> The next patch guards bpf_tcp_ops callbacks in the fast
> path with per-socket flags.
> 
> Let's use bpf_tcp_ops_set_flags() to enable flags for
> parse_hdr, write_hdr_opt, and hdr_opt_len.
> 
> Note that BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL and
> BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN are used on the
> server and client, respectively, for better coverage.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
