Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326408;
	b=RpXY5VB3ggEyYLj85jhgSipeetmH4jAkZuQHltT6DsT6mEeDBzqA8Mk8nnHqVbyyWm4/
	 4Kmfkbi0jCXwmRugEYZhxVPNtA0EpeKf9G74yghFuU/dGNRYHLObO3dvZZRdddzYOeHm9
	 JG2P92Yiq7aqM50Ic4UbKxPXdi4cZ1O16WDNzOAVKGlql6RvaN+yRcUYx3AAnUveBMjSY
	 vCrJpzgQLUH+K7voEH2bo6hSt0HR6XxQTTxwLSfiWUSU8aemTiKJ03xZ8EXJHpnPsoYRC
	 /wPH5CgCQG6pZKQdHsMBqrvIsWfN0HpflhiwF8iqlgAHXIFoyRgk6LbF5tSE/vIgM+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=yoTpJiTFsgbbX5VQxcP/im2cD0EvpkANc1CUM3UG8ys=;
	b=SGRIe+8itY0NFC9pywhpAzcQoE/pRCL3nqtrpygB/w8EPwPLX3iJEFls1JdDHVQNb0YD
	 d+5RQN4OPcs3JhNyF6xli+8h7jro8S/2Y/ShBN6VoWu2vCcTPsAxLriFKYW6uxsXekimG
	 O6lxWtbnLymTD6EY3zKEOAbaDvIU0/T/VDa6ULB/zRZQzZ5ALfr6opQl9Fe4usAdxNO0l
	 a0ErPm9owQX9K+Pv1Yl/zMHvYvgUytIxRj9NV+ScyZgIZR6QpFgJwi8UAFupmtu6N1Har
	 WOW0x7TiiYAGs+iao+DWMwO6z0931LvAzHdY89FBfsKDfcBjdrve+QJ4wGgXh2YZ1KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=DvcIfwri;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8E560A2603
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE8E560A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=DvcIfwri
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c5059958d61so104584466b.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794326405; x=1794931205; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yoTpJiTFsgbbX5VQxcP/im2cD0EvpkANc1CUM3UG8ys=;
        b=DvcIfwriAUUuPjSdpLzsJ8gSloH4OQBZq3Z4ASHrRxFIpkaR7z2V6SqLR3rsW6ZvRS
         1/CWidvtSOgvC6LDNmwK3jq0z7CuZ4zIXtGvTruRF3anLCo1kk0rSQw42CnHkVEcynCr
         Q7tap0STtq0u9NpBSQ7uvzg9XeN0ZFM/MjXNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794326405; x=1794931205;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yoTpJiTFsgbbX5VQxcP/im2cD0EvpkANc1CUM3UG8ys=;
        b=Qx+LO5PJcGxEgJT/d4G9y0vTrZhtdXcfwZUE0Zhob28CX5DBnJCec86kppPQ+7L75V
         WseOGi2T5+xSq6k/txHxBC/8bF4v8cvwybAg5ThdIH8OkLK1oJGr9c/xAN++RoVlxajv
         RaMJq0tQfeHp3IqttgzZ9/I95VdbzrCv1HYGxoXPvARFELvWEQfyIyy7dPgumwWYSO2w
         z4Xosxj29l4Wnsf5wjlos3EYlc3OBhz074umpmtrnz7Caz9pBG+UkwMJONBC7cuCpSp8
         QcgQI0FoI5F+XCuYfTAYOB36nYQyrW+17+1lKfqN1JP956/Gz7W8y8/MizXAA8KfsUr0
         Y4Yg==
X-Forwarded-Encrypted: i=1; AL+hErEX3+qM6A548Y9SmjTvVeD0L1o8LSyVMmjHq0SZKQLTliFLYLDSy1Lfg72Lyg/DB7P66p+ifs8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PTTl/a91dUiLq2noveoreSXkJ2dsB2KH8NxNOdmQvc+gtyeHl
	4KRTgE2QZ24+QP4/tlpU6aIAAnDeuACHZwYJHzeI6DRfmak7CsIgB8VTZ8qYtXYWAYSLzmZTVtC
	66PjeVdlBew==
X-Gm-Gg: AYBFou2Ff8AsBKJgeRgcxcKSFi2C1z+zoQgI3H6UDyN4YWnfvXfVBO1INU5idGzb/8w
	IlYJhIOp5etLos9q3xMztjeh9Epp6QDVl1aW4uNL9D0XXzsyDM3G2BfPT5iiDev9upaPM2NwwEC
	2MstPh6k0/mzJ7+e53OM8uR6lWyjztRKE+w82UsNO8YXV8rJ1GbFXMEdUtnCLIHAOw2LbfZB1m/
	rHOKOkcav+2l15tgJ9RLUvR8bbya4ByfTcmzUhjqOSnGCVNX/l+Y0kQPxpxHtK7h3VHfdT19hdI
	jPNB6PygHjVtcisyJegaTrKJPmSCWkCqeFwsZVSuGEMfBk4HtEBin1kpwnF3kaMvCVeZvmqlm93
	CMs9eUKuEeBlUIju923363/V7RnculFjI4BX9lNki1uhJjhuKfnHd3SY1AgyzsbbXtoCqdKLyTW
	69nXuW9v0GG5h6ZJRzo9RMOBny/O7U6Fslf+WKNQz9Cv0FDs+85mICQ3o6dNFEidEXTMu5WuHCj
	f+bz1Q5u96O/6qaZuBNjKg1wX2OBfc6y7bCQf4zdrJHeNRxEQQJAP1KI6WQteDQVIl7V/4LB6gi
	v3cobUVBnQPBfBhl2OITGSNyfUPcE43AA7LerwxS3YgZWZjiwdi+UigBomZwbA7+2MVPr+rlB3A
	VhhA=
X-Received: by 2002:a17:907:ea94:b0:c2e:204d:9490 with SMTP id a640c23a62f3a-c50634220demr79966b.17.1794326405153;
        Tue, 10 Nov 2026 08:00:05 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a63f8bbsm124966166b.60.2026.11.10.08.00.04
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:00:04 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c5059958d61so104568966b.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:00:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGVuBxb23tWJF+iS7CGfm6h8RQF/uk5kyDeGcXNs+Z2jvcaF9MMUAoGC0Ayxj8/i5WMj15ScE4=@vger.kernel.org
X-Received: by 2002:a17:907:1b16:b0:c49:b6db:1 with SMTP id
 a640c23a62f3a-c50633ba346mr907966b.12.1794326403910; Tue, 10 Nov 2026
 08:00:03 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110145241.536019-1-kas@kernel.org>
In-Reply-To: <20261110145241.536019-1-kas@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 10 Nov 2026 07:59:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgPq1g-kt_n4-crr0qs3rBNkat5OgLxLLeMjKirevRuSA@mail.gmail.com>
X-Gm-Features: AclHuK-OUBoi1ZcEDjO00AEWOGxItrkKuC6wgZXx5y_lLM7MJshUB6roN-XGzXI
Message-ID: <CAHk-=wgPq1g-kt_n4-crr0qs3rBNkat5OgLxLLeMjKirevRuSA@mail.gmail.com>
Subject: Re: [PATCH 0/4] splice: remove pipe buffer stealing
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>, Jan Kara <jack@suse.cz>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	Bernd Schubert <bschubert@ddn.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Nov 2026 at 06:52, Kiryl Shutsemau (Meta) <kas@kernel.org> wrote:
>
>  11 files changed, 26 insertions(+), 360 deletions(-)

Ack. Lovely. I'm considering just taking this as-is now, rather than
delaying it. Comments?

               Linus
