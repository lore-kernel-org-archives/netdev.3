Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792804386;
	b=Oopaj6murzii890mf4ci/bQjoz4k3YmMaCl1jWIMUzA2HmkO0fbv0bgYzPX9BPjvo4fg
	 GjxvisW+7gqbu1qzpfjZuxiVp6hGWkK4oatd9RaNYb+WqK8tvh6fx/buOayc2JSZB7yob
	 8AcD0AQ/0Stt53QLX2AVvXtN5EkjsCYPs1VXVmq624H99M1QvyfKXx5U8vNrrcsoRLjn/
	 zpbmTJ+HjhsRR4IZaPOQV5ER9OW7zcxFmj5IpJqv33ApioPhq0yZMR3UrKXfZousp3FXg
	 OfGPovJ/3hRWKDoxh2txp8UhbFsFyW9SmqVlWZo2sjSQbupNShK1rPbI+tzntBbcyPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792804386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yXJ2g5fwWDIHFZ6U57l0s5oMJ3QkuC3ZCFYx3E6TDwQ=;
	b=v5sRJhzJ32o3q7bxXVWrxgedP4z2mKkvxmSGOLc+6UaS2RfUUa0DJ6wDb0RG97HuYZq9
	 v8WHVmXsDiIYOryT+8fFizIBLO5v+9DKkzEMukSvqKgtk9Y3iCEwga/bISejZhNKoMK0G
	 HGEwTEwR4732qYhISGyllDc4sf/DzhzLaI6ImxqkMABsmMoxWA5ytZ8yH8NY6VEbpIC4/
	 ecPL9V21JHtFq52M/CXUr1KdyWLaL20S63tIJz158sEZs9z7WpKCqUwi+ykDIYHTM0FZO
	 p2vsGqrQh8QM8IRvq1QnRUHbUw+/+YRlpDU7Zf9DuwUBC6U/BoXILL9cATg0385zewA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=g1ajCbPq;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A944606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 01:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A944606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=g1ajCbPq
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc751eddf25so733122a12.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 18:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792804385; x=1793409185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yXJ2g5fwWDIHFZ6U57l0s5oMJ3QkuC3ZCFYx3E6TDwQ=;
        b=g1ajCbPqgcXems55WLyTsax6JKyotCD6HxmozjGTLf5/s4aHiUIy9cDPTus8AOCkhO
         7RsUOfzY9ji7yNIjqOgg5TPoBhs9CrSz3IxXPbxQjYMV2M072m9EFJQiu5nDeZGQZJfT
         lxeIDDgi12ecp+wLnZ3i1lLoZGw+RSUh+VFEH1Y3syERgOMw7ICz3XJwkxWfDvyQgK58
         e3uyB00HSRq/Oaz6nMHGCB5FKg35ry5/FY5TWI/YCTjLoiSmRY9ZMaNB7lLDs9yrcUYl
         Rex4M7LTGE+ctgTT1QJ2XOyXsBisHekDbchLSmrtR01sAN2OAik+zfpinQOL9p8aVN2+
         Stuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792804385; x=1793409185;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yXJ2g5fwWDIHFZ6U57l0s5oMJ3QkuC3ZCFYx3E6TDwQ=;
        b=FyoDrODGx4T5rtpBzPeBMQGFg0fJTy/FVfI4za5lQCi5QJl5lRoHWYRPqTsLzYN4Wm
         EzxpZ2KWGxMt468Fa9VYeG5c/CIxBkudWsHSdtevLork65EXvknqifwGPuWEbajoF88h
         Fgj2JiOMaB2PvWOzXe66N40A+4GQX1dDRFS4lpCJ0FdFUdysxEVy9iRFcj0gmo73WkHw
         EYCLIWLT2fTAr6KanpeldV0zSrFW/5M3jJbdUi0VSRbXF7aUm4YIC6z5u6d/XG6hxFeD
         x7KSdTC3J64QeWc7IuOztT1F788Wd548Qcz9I1CS5F7P1lgT5hr7Umr+l6xQmqFtjfQT
         NcIg==
X-Gm-Message-State: AFq9FYJDwgu+9wvftmHMyCGg94Gl5K5MPrC9ElLSBajsgGbIuy3h6GPC
	j+yNuI6b9QShk/MJHDmjImoUFFXcimnUqidnyRdPThn6Gn6lF+xtOy6QkmFiY4EUTnQ=
X-Gm-Gg: AYBFou2p3RJ36So5SKnd3hPTe7ggMJJj0YnREkFY787wFiim9A/sAzvma850SY/DUZQ
	R0ofDqKRY1Jj1SnQrqGtsJb7UeAtRaKXUgq3UuZQebZd9tSy8tkFV25kLoWWXa90vIz7BSN4nIv
	/aKGSUkIvr4Ij3UZ7BXhnTby2eE5Hg52j5c/jeuFv0hTxWyAtCk+jhwyRKYAzfeKmcq+fPvm9YW
	SQ7fgM2X8rELPH545yKEK82pOQ5jO++Q1wEiGqRymrxNP1crgSdzsju1kfXdwyhf92sZLJyMXau
	RzAxhnq69fbijF27cJp+zq++SeZp9NfcHHYjQz3RVUKD+1Wvz6RnZwM1fjnKCSlIK20FB/n+ZCx
	oON3/MCnCngJHTcZGlKMw967V36FsgIl8dlG4j6/jaHUp/ethwhPCZUkb4N7Gb63E3d52GSA1Nh
	WisCS1h90kAMWrqDtrAhPMbnca5W9lmmj1uG9NieH3OqujU3XcqUdYGP2lFEA+VPqQOnFsZY1T7
	p6s6aO1C9/VtrmIpeL/GlMK+1x+LaewAL0LGfsskmESYRkA2YHUIc5WQx/0w+h6BLAzbkGLLiRS
	8k1uqQuIcPBkPc5ScTy3gzpNQBo=
X-Received: by 2002:a17:90b:51cf:b0:3ac:b7b9:6471 with SMTP id 98e67ed59e1d1-3adeb105a0amr758434a91.65.1792804384647;
        Fri, 23 Oct 2026 18:13:04 -0700 (PDT)
Received: from stephen-xps.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfa82sm937149a91.8.2026.10.23.18.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 18:13:04 -0700 (PDT)
Date: Fri, 23 Oct 2026 18:13:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hadrien Patte <hadrien.patte@protonmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH iproute2-next] json_writer: fix pretty printing of
 arrays
Message-ID: <20261023181302.2a06fe99@stephen-xps.local>
In-Reply-To: <20261022211002.31098-1-hadrien.patte@protonmail.com>
References: <20261022211002.31098-1-hadrien.patte@protonmail.com>
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

On Thu, 22 Oct 2026 21:10:07 +0000
Hadrien Patte <hadrien.patte@protonmail.com> wrote:

> Output now looks like:
> 
> [
>     {
>         "ifindex": 1,
>         "flags": [
>             "UP",
>             "LOWER_UP"
>         ]
>     },

Putting all the array elements on oneline is easier to read and more compact.
What does python do?
