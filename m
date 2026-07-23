Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58843F6C48
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800330; cv=none; b=ouWYL7/plDiC1wT5H0HSZpJNYGBuOkpPg3V8DwjylsVAM5Q0u0twI7ySU2xP+/ShW055KQkx3xbHDFJeXi4xKkX+NN2LIzQ//KyXHxcxeRSTBIot3z0iByqeLwd7z1l7YJeBhWK4FgMduMJZ97CvdsW4Q6g9Zmaea3gH5fXwaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800330; c=relaxed/simple;
	bh=PJrlFgAiuyfnK1/+yuPQLy7EwaiQj66gGELJG7MkhUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUlRQ6T6TVJ5klDU9FScO7DhEnEzJoMjsSFTX6dIegvCyee5htb6ZRKk2wJ7sg9YP2HRDrC7wwGfNYtZGe6P/osDwhDiQVZVNdO0kAgWu1Wn17OGsIdgT2tINv/KqOmwHJD2TZjSwa7qQWRjWRAZrzGTZlpmVK617lUDVYUjVH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUVjTT8n; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUVjTT8n"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b966dd74so2796715e9.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 02:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784800327; x=1785405127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tWzwSmtqiucIJdON+AGZxd6bPRUb1cQqs4PNYmJoULQ=;
        b=MUVjTT8n0sjO1HgO23tg8OBmx/l1ExTU2km2Cq5202klAStKj12AP5jeHSv4d6MDQP
         H/YPs1cmeCqdUu6nlnBxyMmlSRPYtOwZ69ZdfyxBqbTUCvJ+8SJginCCh4UygVGPjIBI
         YkxsrOtXmZq5dmjl8zWMyhzonXXBKdkItOTsfyG1q+cl/qpXnDYez47UdCKuo4qvEx4+
         MWNz434T32uGRYgTpn3njtWLgT5bD+tBnWTnfVOaoVNyrEXmaZ7PmnObN2kWIkqmWB0e
         CdphJ0VwH6v5MDV8vvctvQ5SJcXPyL9aIjRZ7eLI2WZLM96Ekke1C03mAfS0TLExSxm6
         TzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784800327; x=1785405127;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tWzwSmtqiucIJdON+AGZxd6bPRUb1cQqs4PNYmJoULQ=;
        b=XlzDMIqJTrqA25ndlNrE0qBpo52sYyXFwvBSwkcEiTwPiV0vNcqPTsr98wwQnFbTdt
         xHAU6WJZdHdIiYMMcfLFUA/hPvWUq1DsVCgnjMzkZkQETHrXpJ4XU63HaU2iig7hjJm1
         uMnaJZ8CNBpottSRiVypoLOSp/w6BU51VqTtQJbs2Ww1fFjRliFcvBrIM9ru46YUtXlP
         csc99wLEpxL+fJKSxX5nDT8qOCo9s0szjE95Gg3T5ss5H3/rEZs4nZ+5YBYqgUQk1IZz
         h6UEiOtufg5AaxtHc3/h0CmnL1J8BZmJEPjNdixD090G/vVCSwGlucQTl8G33qEIE7QI
         guLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4q6yj4ySw1/X7qFuY4ITTeZ4O1HgexzsSpAu4A1/g6qSEmAUET/8+FsHbOVBk90OaX/WTcV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmpoGXqh1zW8Rhyn83OfptGGXR6LY3UfBDzWHni+F0LFmHQHUx
	u8GPCkAcdmhtDtv2Obb5QQKuqnWLC9oTqrVBvL5FuES5VLkhttjq5R22
X-Gm-Gg: AR+sD11fjpzH10OF7FlRu75p6KSIuLjxNSTDf57Ps25I7p7PPR99sl6qx1OaAKLWeC8
	PfKU6vnNOuSRnvtEjF2gWE/7lSTSYxtdD80RK8MOT8a3WTBafj5ZknmsqCDOwqJxpe/XGu+pGg2
	Ylr3G3fimA/7Prd3vSmJ3cBthm3sijpgGn5pLP6iGaIXuiPQZa42GkyEyDo2jFhHg9emvLlJUhq
	tHifdIWNRC+7kAD+QNXk2fysRreNxWIy0JC2cVGs97CMO+wCbudzNraejhPFsaFCsMYz2OuAwsx
	GZzJAfn2d7TADXALNn+luX7KedIba1DtckNMZoHUsgtJipnKhjYYWp9ST9Jz/68pGuHyiSMaXvl
	RmfjQg1LecAhJoXDkHGamGKGE6MMq5kzRoWt8OCLzi3u2ak77skW1B82+srS9PaWfucVl4YhdUD
	OOF+Js1ELo1qE/M1rI6OOr9E871munoVs7kA==
X-Received: by 2002:a05:600c:4f56:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-49573cd0b3emr23809065e9.13.1784800326532;
        Thu, 23 Jul 2026 02:52:06 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4f25b6sm127202545e9.2.2026.07.23.02.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:52:06 -0700 (PDT)
Date: Thu, 23 Jul 2026 11:52:04 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	ameryhung@gmail.com, kuniyu@google.com
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Add ksock kfuncs
Message-ID: <amHkRPNLKl8dQomb@gmail.com>
References: <20260722104454.165911-1-mahe.tardy@gmail.com>
 <20260722104454.165911-3-mahe.tardy@gmail.com>
 <amELAv1bgc9DP6WT@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amELAv1bgc9DP6WT@devvm7509.cco0.facebook.com>

On Wed, Jul 22, 2026 at 11:27:32AM -0700, Stanislav Fomichev wrote:
> On 07/22, Mahe Tardy wrote:
> > Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> > sending data. This provides a mechanism for BPF programs to emit
> > telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> > socket types with IPPROTO_UDP protocol but could be easily extended to
> > SOCK_STREAM and IPPROTO_TCP in the future.
> > 

[...]

> > +
> > +/**
> > + * struct bpf_ksock_addr_opts - BPF kernel socket address parameters
> > + * @family:	Address family: AF_INET or AF_INET6.
> > + * @reserved:	Must be zero. Reserved for future use.
> > + * @port:	Port in host byte order.
> > + * @scope_id:	IPv6 scope ID for scoped AF_INET6 addresses, or zero.
> > + *		Must be zero when family=AF_INET.
> > + * @ipv4_addr:	IPv4 address in network byte order. Used when family=AF_INET.
> > + * @ipv6_addr:	IPv6 address (16 bytes, network byte order). Used when family=AF_INET6.
> > + */
> > +struct bpf_ksock_addr_opts {
> > +	__u8 family;
> > +	__u8 reserved;
> > +	__u16 port;
> > +	__u32 scope_id;
> > +
> > +	union {
> > +		__be32 ipv4_addr;
> > +		__u32 ipv6_addr[4]; /* in6_addr; network order */
> > +	};
> > +};
> 
> Do you add these because of BTF type checking? Can we have something a bit
> more orthodox like:
> 
> union bpf_sockaddr {
> 	struct sockaddr_in sin;
> 	struct sockaddr_in6 sin6;
> };
> 
> ?
> 
> I hope we can just pass these to sock_create and make it do all the input
> checking..

Yeah probably, I didn't think about this too much. I inherited it from
the netpoll tentative where Daniel suggested to take inspiration from
the fib lookup helpers[^1], which made sense for the netpoll call. If we
can simplify this we can get rid of bpf_ksock_parse_addr(). Let me try.

[^1]: https://lore.kernel.org/bpf/4b64ecd8-eade-4676-822e-da73abe2421d@iogearbox.net/
