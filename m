Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2555326A9
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914384; cv=none; b=EgKfN5CsQAAvvYOqfDWO+ZgDqqrywj3n2qLTu3hxU/wSIkd8/+qOkGwLl9oeOchC29cK5gqlUFYi3JHa+9WeBmsQ2ktHuZC0Ze2UCfnECFCfEJ2/yDRaYQeKOAKXFp4DDO/GRZ8pag1QLMISatRgI+9exQTc5I3QiqsUdiUVClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914384; c=relaxed/simple;
	bh=tJra5WXUJUAErMt026HVIKG9BLHea906af/cVQLm8tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1GlJ4ior2wiN7Rzz5AbmQhR7lsapbdceiIxoDChO/0B7+sVykzct0ttubU2yVstTiKED8QfxVhHYSetJrco9h8fvZv1t32tj+tfF1eGbVyop/Op7/bKmrtl4qktZcaLljR3/QBdA5V2JPnJW8XUOJCcx/3ARU6nCDiqZNMCqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=i+nr1hx1; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="i+nr1hx1"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93ef1a2948dso172484585a.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791914382; x=1792519182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I7PYK2NFBnnrBKq5En7ZMWWtpUU9RPTiFiLhdaDzGE0=;
        b=i+nr1hx1jUqGqLAJHMSKKDOI2nVJS2NqWUt624pJ/sUN0URhOZFLoWVA2iI1oMKVl3
         /mGQ3tRjJiMD3qaK2ftzqtjASF9hLj3xbGL2hMst2I9H5d+OVZFnzN+uz5CH7IK3NUjy
         c+PEnt2Zd8tWl13kqRoqXXK6ho4mL0ZrErLJGYhUYAEugShty2NpAl1UoZxnLm7SZP6o
         7mB32ty3hsaA6bdaGKoOCeP0GQHvefHZ45noD2b3RHB2JtORgCoOip7t9lCV6zai3cBT
         5vP1nB3vDfPNdTeHnZE/fagvvX5zVzu0MEM19ftCo/CdrABiqUdvwAJrWJBPDCTCGV7z
         EJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914382; x=1792519182;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I7PYK2NFBnnrBKq5En7ZMWWtpUU9RPTiFiLhdaDzGE0=;
        b=1ylIPb+8QqqmP9lyPnAgu/UNfmS2sz1rwyrDVfh+PZUoM4uP7NS5o6X8livD3NpaMZ
         Y8jHsslDeXAqSHzbB6rMolePKjuA1oPy6iI9gRnToCjdcGUCZDThVuimQ7+cvg1N6+F5
         XXweZs38f1oWE6c6oSww+kbifDzlKz1JTisl9OX5FSoY6sLvMZZLoAT0H+M9o8EoqEcB
         irEMfeUHFdNkuEeILKQ3thtIvwzpppUpEHJ1PVyOg6C9h+hAFlLVC0oBremFbkV0UgBp
         +Vs5AWoe8w+GkdRHLEn84y+EYMHLgD9NroaDY/7MSqv0WKeySUEfkruL0hK9QehWohj4
         PtSw==
X-Forwarded-Encrypted: i=1; AKwUvBzf/zdiGCj0Ep0oNVsov4ONnzbEs+EN97ejM8beZiFmcrrfwUI4pkIDi9sA7pBh3wZBXHfHa3I=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBQinaJoBY9cabbtBhqET/Jpy7nDdrQGBLhvlP2midJ82oXkrc
	BE9czdfIFKk8Th1HvXuxZTUJE1ye1x9YM9i7+ISkjTnHOeQsn9fKHGaLwBaLaDxKmNI=
X-Gm-Gg: AYBFou06DCZPYSB4Djx3MkH6xTBAQ4e3Xz9dlJCmW+Wyd6TvIEnl4Z5VeIjTePccIVP
	d0hw+r/geX23xYXnl4bZGRqcQQdWPoER1IMuqQOe+jg03FZT1s0D69zf4ozwbA8xrQ3ivZtn0jb
	MvxWjcdN0ebj2IpoOjYwzjbuWLgIc9baGWPk8cNE1W4WhuxaFwticUpXt9VxQNsrNcg+F9OQluE
	zXkUKozLO+mant8oYMJ2WIreHWV0K9rFXA1NuCxphnvVz7vlLwvZd+SlC/qGJ3KgibpAvNtsmVX
	QNQ0yFPgK7dgrCgutXjXYV8AXKXGux/32WjZtZE+spg7UQQ3bhxj7ymiuUUWs60K4LjEz1se8xb
	U4R9pDpiEgihh6x401rSqwAc8BKwL5MfgbtPVXSdbGK+kJwD18rf2xBSXd63xCSDvjP7fSN4uZH
	ATrswlvEvjBq4uvZZ8q9FOBq5FSH2uPcUTOieN78LaddbYn7UrjtEgneldM+3Ckexnm+g1DxHL/
	yzgOt7V1x9Gc5s=
X-Received: by 2002:a05:620a:6405:b0:93d:e031:5ad with SMTP id af79cd13be357-93ebd224911mr2124184885a.17.1791914380656;
        Tue, 13 Oct 2026 10:59:40 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.248])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5086fe3sm292732185a.37.2026.10.13.10.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:59:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: netdev-bot+sashiko@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: skbuff: don't segment unreadable skbs without
 SG
Date: Tue, 13 Oct 2026 17:58:45 +0000
Message-ID: <179191432558777.2.414389277062940952@toxicpanda.com>
In-Reply-To: <179163919450.434549.9325877615055483977@kernel.org>
References: <20261009-b4-skb-segment-nosg-unreadable-v1-1-7e2334a55fe8@toxicpanda.com>
 <179163919450.434549.9325877615055483977@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, Oct 10, 2026 at 01:33:14PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Does this guard also need to cover the sg && !csum case?
>
> The commit message says:
>
>   "and with only checksum offload off the segments keep sharing
>   the frags."

The segments do keep sharing the frags in that case, so this bug, the
payload being replaced with zeroes, doesn't happen there.  The commit
message shouldn't have implied the case is fine though.

> The devmem MSG_ZEROCOPY path in tcp_sendmsg_locked() goes through
> skb_zerocopy_iter_stream() and never sets SKBFL_SHARED_FRAG. As far as I
> can tell, only the MSG_SPLICE_PAGES branch sets it. That means the
> __skb_linearize() fallback is skipped and skb_checksum() is called on an
> nskb whose payload is entirely in unreadable frags.

With SG on and checksum offload off, skb_segment() calls
skb_checksum() on each segment, and skb_checksum() can't report
failure, so on unreadable frags it WARNs and returns 0 and the segment
goes out with a checksum that doesn't cover the payload.  That's been
there since 65249feb6b3d ("net: add support for skbs with unreadable
frags").

> Would checking !sg || !csum here be more appropriate?

v2 drops this check.  Mina asked for skb_copy_and_csum_bits() to
report the error itself instead, so v2 changes it to return -EFAULT on
unreadable frags and every caller handles that, skb_segment() included.
The commit message there only describes the case with both SG and
checksum offload off.  The sg && !csum case needs skb_checksum() to
report failure the same way, and I'll do that as a separate fix.

pw-bot: cr

Thanks,
Josef
