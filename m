Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764109;
	b=ifbM7YChgjoYKyn4NRuANhRA1chX9aCyEYbufkUlWu+w4Kj1wGFqxVs/Z97qiNdUGvh2
	 c5TuPPkVcBY1r0eh5U/eD8vfmwRWKO3MeoMbK0lSYPv+XqskOF7Zd2ea0LWxQEJLTuB7Y
	 PT798qUwweeqMKdtIkR/kokAUQbdNM3RyUrxcFtU0qbeO05ZPSoHSgAGeM5At/27KpAvZ
	 hRpZrbMk4pJ2ZQrib1XC6Si0lMOJrK09i9Ng3ZNyv/vLL0RQ0FSntguOW1MqeUuM8ULgZ
	 3UQYlqAFrBGRof6Y6GpPwzSEOZYxmpNGre67w/R5s2/eaKE03v8X2gtdhTHVlP+Ll+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764109;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=Nhr/pGVEFL1Bh9ARZKOX/CK/+/Yw8Uv2cNMgYVOXjkk=;
	b=EuEUYIekWCZ5GOjpUYKhv7GVj/MhXYXz0FOzjT6KfKKTaTc3odQSO4C0S9WKn1FjF0a1
	 yU9EGcQrKC1jkMNEQrp39HLDqSkUkNcwdh9yIOClt4h5ZqlvxT+Z3MzwUDyLVvq02qcW4
	 5i+ldMdZVbCQ0njMMFfDTSlyxO4I3+MzrKBx1/4nB5kgHZTl/BqDWLfCLg9pd1/+ijcXy
	 6a7IbyqTnnz4w071VDPnZ3PN4mNvEMg0wY8oGlhkN4CiCGzGLW5ae74Lqvl6gnJXoU61K
	 hau8nA05jzEVkcozShQE6igC7KDhkT8dz3eY0qVjmdf7iwi4b7KUgHIahQreCPfzn9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=0LibiXj0;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94E5606A321;
	Fri, 23 Oct 2026 14:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D94E5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=0LibiXj0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 124C9A0956;
	Fri, 23 Oct 2026 16:01:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792764103; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Nhr/pGVEFL1Bh9ARZKOX/CK/+/Yw8Uv2cNMgYVOXjkk=;
	b=0LibiXj0pgf2+dcSiwf/Nye2L/sZ5XMzzpxbgMV8ptO9aGHSnOBQ3vH87G1RdLgSzWx0hd
	O3Ulbd3QFaSZWdN056XHbVPX3SQorpuEUpYi/amYYtrg5fDayiDPjSqT8p+SNSQK581qfT
	BhJv8FfJ5xp0YVlrUKSxNTNNZ+45HEHkduTZS3EChgYWuHfWOIAi/Io/LlrYULoT9kpnmZ
	RNfNnAWqD0ByawWvp9qim8g2QNKYAkC36LmWgu3JkHZ/lM9wvM7H+FTTJiKArq3LPoBBLr
	kYKqmwv6GH33kLCRnr5HtZNkz9y4Zw+KAuhnh6MBFB3YST8AkXHdepK9/xhGQQ==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 23 Oct 2026 16:01:41 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: divyanshu jha <divyanshuj2006@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: usb: cdc_ncm: add Apple Silicon MacBook Air
 (05ac:1903) device ID
In-Reply-To: <CAGg1W3gd_nyRs6BrAOV=ysKJsQMQTOskv+DpeP=kf+C-o3JXdA@mail.gmail.com>
References: <20261023070419.235361-1-divyanshuj2006@gmail.com>
 <a386789d3d2d6709cc5e9c8b2b05a283@tipi-net.de>
 <CAGg1W3gd_nyRs6BrAOV=ysKJsQMQTOskv+DpeP=kf+C-o3JXdA@mail.gmail.com>
Message-ID: <aee715a0295e51cf132e8897459ebb19@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 23.10.2026 15:44, divyanshu jha wrote:
> The device tested is an Apple MacBook Air (13-inch, M1, 2020), Model
> A2337
> (MacBookAir10,1) with an Apple M1 chip.

Thanks for the clarification. Please add the tested HW + their VID/PID 
snippet
from lsusb to the commit / cover. This will prevent further questions 
from the
netdev AI bots :-)

> [...]

With the nit changed + details (you can my the tag in the re-spin):

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
