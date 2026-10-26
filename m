Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025578;
	b=pf6nbMKxBZAUZ1koDFanj1H9q4eqrN4gWIGVvWYfY3xe/vVRz8WNDagqFqkL6f1tZ+hm
	 2NTuK2pr9x9V0yVNYlB9Jjehfan2WRhO36nAQ7nzCPvljCOTAPdeabmTDnbeMKINHH/iU
	 dbD5k+Ebb4jLt/0+dUH00RtKRX7RN/yGpniIHCt8ND5i2oOL9FsOCJd8dh2ARHu5FPsq7
	 w2gDthVamy/c8MHOWE5tFDF8RFo39w8kJHwuq7s+fsb3npELDxlNTXtiKqzGw4rWJzEFM
	 9SfGuQk+VS/EWYDHbwuJ3zoJr+Xb+dKoDWpxRuTzXZoOVOuD5qdmAhjfUu/K/EsV93g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=JfZYuXK6UL6ZlLrytd1AoBuuVUDo0kktcpMINSiZtew=;
	b=tAEib7YKz3rOOwJAThuLFBvhjEB7MAl3Kx8dkN6lbw5j3C5lhxkyXaymZQ4FP9HUgZwR
	 hx1tQyLRDwb1u6oGAae8KcE3O/ST+ovq2wROQpNsjfu7slsMdvhLBmlkjZYGPiSGcF1N3
	 s7/I3s5O28lQNMrwvn1ujdL7+rWRBeFmJda+o+O1/OLW7Xz+WYvfHDAKuY1Dp9oPJ1Lb/
	 sS/5Tww47meKcZcDNUTI5BUEa8B9TPgM+YA99SOWmnca3gFkLDvUzEaDDu0Y3K1w7ML5C
	 O5wHFbxztEy9HanbV9zYbTW5++z8gG80/WT7+ynMaNN3wI9ihnut/6pffIwLjfRSuIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Fbf6RtRK;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125C606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0125C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Fbf6RtRK
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so412051a91.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793025577; x=1793630377; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JfZYuXK6UL6ZlLrytd1AoBuuVUDo0kktcpMINSiZtew=;
        b=Fbf6RtRK7yc7vHavSf8A1PNF12deV+0aD5GUCicKJJVtv1QMcv4Aurlhr3TFhJSKIa
         aMv+pF4ZTutVj0IbTozngeW7L7cmEhxR/1EAE+xWM5sR/E4hCBa81GLlr6iMsMLgw0e1
         vIEYLUciv6btYt5lrl4eDIRTq/TLF1YMiUNKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025577; x=1793630377;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JfZYuXK6UL6ZlLrytd1AoBuuVUDo0kktcpMINSiZtew=;
        b=qvBa5BpDK7S07BChMbEPLrqvYhQ++ylXq0Dng0nUz8eKXhzO5PhFuZaLoP5v0FzA2t
         rHyc2vgoTTycIyfjLjCe9+2iHWSLTdd4NceJZMqakNhCXqL3Vp3xK5tiZFVbDpv+TZNe
         OLXZfXjEpAZkXC/odFM2popeqhlGP0gXzU8jVS8xXC2NiFiRwalbFCdxCoaBk/Yuy53v
         X4afCtR89fBjZmL1ntMPhFCcByQ4r37GDWIm7rHWOW0v5XE8RFsyIwC2cKMWKKhYO7lG
         0x4SQENY86ZYszjsBpcgQmYOuE3i1otZ0A4luNJtV1ul1mZtpQVrplx5xsTB4i1tSKrJ
         FnLw==
X-Forwarded-Encrypted: i=1; AKwUvBx/JJg5JYNJANuOHqfa0K72qoLa/zQS2zOI52F2b5MwrABFaNoZfUBV46GUfVCExL2eh2iyB5A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbN+SiXMLj1ClB19pEaHAt4Q4w6/ia4yYOmqozTSpWjhRr5Zn+
	xfOuA91BcMV9QbyBunOEyKbmEgBIMQJ6R+LEvixeV6wn/zd+/R+Ykco7nA0jHohvLIEhLDqVUKP
	QI9KRK50=
X-Gm-Gg: AYBFou1s5sX4OaHNFvlkizQlTPN/+uv/i1n28IkYjV+mY896SJv+cq2QWKdoFUEufHN
	8/0+yJ1/lO9rAffvg88ZAKxoNkTT9X+Nl7CFz+w3MJ6/gUYkROyw3Fz/uWZqVrt1m2S/hHOgeIC
	VyurYIM7wobSSdhg7a5NB1NXK2ymdljJWfG2+zm2wozouNqdvxU2t9mepcbPU1giqF/Ljg8CbE4
	S74E291llOeSuoceTO7IntHlYEUkD5wRYh2mCChxDem2my916FfGv/3ac9FzF/oaZKfnE21G2Bs
	P5Vrao8RkoJKY2vn9n2BX4AzrzG+GCWL8lWja5nRduqmTJNhzgFgIKy/91Bw1H/8b2IyGIqZbbA
	rOfpssOMe65hT8JDnnMk43do/HftKxcUqdp+OvGT2gdlzkjsTCpvxkNbU21hN/lTDkEwu+pvg80
	vO40cW+8z0anM96yKoYSUSS/k12A8W4PPP8OCGFksdlcAj/aBHaEoT016/QCbBEnPjEFTOazsNM
	R7UmROBDnrVm+vTwbg9Au23qaGBY8XcHGAQInL6GgYbGV3ojkjWyzKKe+XR69dFtsb4cnuJ8WAH
	qVV85O5zlUy091cFJ+McWwZYvEw/ogt6rbBUloM1X5n8fcWYDmdMr69pEX96E+FsxiI+PHQS8VW
	HlxDlxpZggBO1piv5Ds4WqhA=
X-Received: by 2002:a17:90a:e18c:b0:3a7:8c68:6446 with SMTP id 98e67ed59e1d1-3adeafea707mr5604183a91.63.1793025577285;
        Mon, 26 Oct 2026 07:39:37 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebac408asm8726950a91.0.2026.10.26.07.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:39:36 -0700 (PDT)
Date: Mon, 26 Oct 2026 22:39:34 +0800
From: Chris Down <chris@chrisdown.name>
To: Breno Leitao <leitao@debian.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sam Crossley <samuelcrossley@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] netconsole: allow replaying the printk buffer on
 demand
Message-ID: <at9mJoA8ZQfUCFGw@chrisdown.name>
References: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
 <87fqxskdpl.fsf@jogness.linutronix.de>
 <at84qygscue8crQi@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <at84qygscue8crQi@gmail.com>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Hi Breno,

Breno Leitao writes:
>So the next step would be to add a basic /sys/class/console/, similar to
>[2], and put a `replay` entry in it.

Feel free to incorporate an abridged version of my patch with my From: in your 
series if you like and we can take whichever one lands first.

(That also reminds me, Petr, let me know when it's a good time for a resend. 
I've been holding off since there's still quite a bit of activity on the other 
cleanup patchset)
