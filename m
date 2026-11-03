Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745818;
	b=fSMqLm4QEnOX5hz/2uecwb2opJf6MoRdkkcnN/HZft6EVBgCg1VPulII2ve9CjWynh1v
	 0rn+ZFyuufVDjSZERPKwqLMrIZ9ZCWeldT7HVBgPCrRCUkNiFHivgJ9l4itOQr/QfGxYK
	 cEfTjZ3j9m4HkR4KNjce79PCIrP9x5rgzrxJ9CN2LDvW6MTgY2O8KiF4Tb+ULgPHLzqir
	 KU122t2R4jM28phGnOfc+N5QRVvhelqYqlN70V2ar8or1/CDucLCjA5usTTzKJfhwyDKu
	 TV7a+oIQ45hICXMYHa5Mfl2BbVn+0Z4umAzxtMXwG5FHld5BWQS6WFDkXqJK2dmrd3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=TEsmJhHG6UzOUAsN1CLfuPQCNGFTSJjKfJhnGZfHeUo=;
	b=Bue3+hQvRh65S5SvyKaq9dxcW+nky0gq0t3yDQynls3kHECE/ErAz2YKctv1gltVL8am
	 M06AWmJT3rg0dsQFKwQhi7x7EJFX2jD+Sgh5n4I+zPZRhXEdebVwUTqNdmjDz5ewy+wC7
	 5os/dDQNDPM+jUMdMSNOW7rt9lbIBhKc6FigtkuM0LjcUJlLMRE0S6IMrX9B7RvnlIjUd
	 NjKdUvOwgrIGKCZzpGt6DF1OgWqcEBPZxdVjvzp/1ZMfvmrGcVN1gWxaMWG7SMuVuHWtI
	 B7PFe6h9QHoDPb5nEwQ06Ma3jNnhmD1tgdiL2GOsM6o1Vsq61zGnbZdf4gnQl+ll7aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="nSm1Ta/L";
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D40B606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 22:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D40B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nSm1Ta/L
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so38494eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793745817; x=1794350617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TEsmJhHG6UzOUAsN1CLfuPQCNGFTSJjKfJhnGZfHeUo=;
        b=nSm1Ta/LRGVYs7LSmDicg4qmLY+G3QKwOL6aUalRgmoK+cIOBxQOc6eQQ72XYNymGk
         1WjM6CiaaNZpDFPIYFWywDYD28bYZqKUI1qOJ9/6cCvuKVnmzVEIZtYlWX4uQeL4rDrQ
         In/H52J/vIpQLculr4W56KeYPDFPpiXr6NGH8+4lDLej8vMr0dCSTMnR7J8/gsJvj5wy
         fduWdiVgaax7kmUfpEagXnqcGhgF9AnPobHCc9NBLlWIWb5xxZ2OqVEMkisW5E3iVAmj
         sXonf6pxJ8mRtSHNJK+vrB0K0nak3/2yF3P+RlcjY2hdbBw59GdWH/6OmT+LHjGpWCo7
         S7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793745817; x=1794350617;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TEsmJhHG6UzOUAsN1CLfuPQCNGFTSJjKfJhnGZfHeUo=;
        b=hDmGGjIDJVYhjedWYOh+Cqt4sFdhF/VaSK5FYY9GZihgZenXHC5FiScUJWSwdsxcjO
         H/yxF0xA3lNZolsZuYHgEcz7lCejq+4hxT2lqLPI8KoFyaZtUOb1oSY1i5Qmf6T0ts2n
         AcuM4+FH9MOaI4g1VR12Gj7gRSXWiLuNDEDzomRvSL8mrg4KfTr9Ku/wZ1jk4nBm+gn6
         AMYyOdQoKGhU4fP+/w3ggnWQtsddGaLQ0roM4uE4atzDaNHjSNzFQdri7dzQCXab07oR
         fve7cuTnF/+PhCFEAcx2CO0Q0jU0XP/sM1ibFkpudb+DQIchBFmOTzxmTPGZWUH0//HO
         tcAw==
X-Gm-Message-State: APuU4Z8ASWQ+B8etre3ARZSHsOjidv4PpAVi4or8iz+Nb12wnMDgAjK6
	k5XDNHDblgf8KG0bjOnZ23WfGKqEYawANl4ACcJMDyK000noUbg14CiEIyu9iWms
X-Gm-Gg: AYBFou03ahMnYLXvTXd9FvVhohxHvcRJpC6SmVTRrBl8RUqbs0Mmq7MAsl2phK/D9z/
	pvOXXgim3Dw5k5I1yiIqerFSnbdbEBVe7aV3iKZEr5Ys8DYBp4jt/wYk1XmtLeAK4bpc2lcBJ4t
	2RJAMQDYw5KhfYr8sb0Od/3CBywPKt4nyGoy4zq76leO2az4YIEFGLXYOtXEbpPAof+bbzelH7F
	ZYB80sMM7AazKyNBmUvNKme2FVcRipeLbgvcXg4efWzbt6F8/EfNKfGLpjO4s5g1WitbWRr0IZe
	bRTE22DYR88dgB4tqTqo/IouCWA0GkUOZG34tb1iiyGaWBX1FwPLI6qG6uJMzUPRNntnhnl1xgy
	N0OaMZnWFCimlZ83J7NJoBz9TN1GdBsJZUehcqPNCAFJn3EzetdG8Oa6bio9YpGLpCdyEMS6k2n
	EBP3gdnZY+Q3snbcbNgtBq5hwLavwOot4cjimG3ZWC1e9xHx4dauisKLGuIu+BMiQp8B/7hF1UQ
	HsDWwUt6ixjE1FLxZzlDqzMwu4NGnzfvcCW+6BADsjChatH+6JKT0eSiyOdkGJg+ROFrdPcBC6q
	RwHeTaaDxYNnGmSERSgSgQ==
X-Received: by 2002:a05:693c:87c2:20b0:36a:6ae5:23e2 with SMTP id 5a478bee46e88-36a6ae52e67mr10824936eec.17.1793745816953;
        Tue, 03 Nov 2026 14:43:36 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:64::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm1372736eec.27.2026.11.03.14.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:43:36 -0800 (PST)
Date: Tue, 3 Nov 2026 14:42:13 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Eric Dumazet <edumazet@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>, io-uring@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next v2 2/4] netmem: store memory provider private
 pointer directly in struct net_iov
Message-ID: <aupiPcDWNkZAucKe@devvm16445.scu0.facebook.com>
References: <20261102231827.4088254-1-almasrymina@google.com>
 <20261102231827.4088254-3-almasrymina@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261102231827.4088254-3-almasrymina@google.com>

On 11/02, Mina Almasry wrote:

[..]

> Resolving the memory provider instance from a struct net_iov currently
> chases niov->owner (struct net_iov_area) and then dereferences the
> provider-specific container struct (such as net_devmem_dmabuf_binding
> or io_zcrx_area->ifq).

Chasing niov->owner is true, but I don't see another dereference you're
talking about? net_devmem_iov_binding does container_of to get from
area to the binding (and the area is the first member of the binding,
so it is a already a nop). And IIRC, iou has a similar arrangement.
So I'd vote to keep things as is unless you explain what I'm missing.
