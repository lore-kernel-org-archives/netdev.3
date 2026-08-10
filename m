Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C734D901
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394355; cv=none; b=lF1PEO/L3WMjh85g35KMuJ/cwPbs0ksNB7NaS8mHf5pZ8h5v+uYqYitFk0gq787HmbffC7sTq067CxV/GzmrNZBrzmX3TWipHM6cG61Gp8MVZ2unlQ6L0OCCKHZb9PIXRYmFs+YDCniknWiEboBGRF/4Qcxy0ysW1NAqKhZQf0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394355; c=relaxed/simple;
	bh=V+eSSmo+Er6BnCuhqwH6RDWLNnO93l4Mkipp0Tc5BLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4WKwXidxy5oyTbU21XWcY4ag3AKShz6wcOHZcEfi8J4F7+fiodIed05Vbj53jnwTNmGmW0YWlWwxR2MKUQmngQ31pao6p2TkMD1srpge0ESccmqI5i9o5Egh5lnPlHeZuZ/W8qwLdECiloY7Jf26Uu+U2LKmJcK0KK6+6CTRt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=QcqDXJFb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="QcqDXJFb"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso1722315ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1786394353; x=1786999153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eq97j2m9waTfsldyzy4DhmOvCOuNMFynjKlTtDY675o=;
        b=QcqDXJFbG9c3IvJVCu6VEgWyh+CUj9am94T+1pjvXl7VBSth32nEPMVFaad2XzU0kW
         aB1no9kBybRIVtOc6ILfliHBvNy/8fiVr7Pg6yQxCsA2652dDyTX4XDxxeEP8yuoJkup
         bgZjcq6ZlzXiQtFiHZ7WxvK9YxukHoekk9XuetUNJaviL5vYnKuA7xI7dY0QzUD8/1Sp
         85advZUBzf3LZIBjG94327bqPNrqGAYKO9kZs97w4LA/WM5Qu1umx4pLejZNTRHmtHeF
         FWLYYjAv3C179FiNvKpX6UvwKTJeMm+pzyWe/PyIEwHzFBAWDfrwdyhzfYlXL2H7F6uA
         Jj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786394353; x=1786999153;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eq97j2m9waTfsldyzy4DhmOvCOuNMFynjKlTtDY675o=;
        b=HXN5dTJqvSG8gL/y4L4Qmfyy2G1xQ7aitmtLzppPvIclHpMU1Xhb2+AAuaHA0Y3zCk
         H9CD2wNeJavyW5i3+oXaX+EPUFHFqLCV0qdKMjuT1u3pBQaFkvTUqCMF33VfoRGrZ3lM
         DLYOdZdg+ZS+kJBbGkLI7uPQf11K+0J0FYh1DbCdpPGkeb892gWYe0a9Eb9zteVzXFo2
         +y5YvvpFoCFbaj/hsQYHKJixHzQskKmwNSOyc8G1FG2yBUJubhZ4SL6ouXwIVSivAKQQ
         8s9jSZZhE5cqGLE5tZAEOh9CIzyLX7gYm+74EUUmvpe66bvNAv81V+dkb1k6Ag26GPf+
         dlgw==
X-Forwarded-Encrypted: i=1; AHgh+RqSGFTl1aEmjcxgMG5xvUz4WJItbU7E/sOmsBUB88pAlYO+a8brousmTnj5ZBlfZ7+y2PdIdO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJR399aZIazjNv72tmJ4dDcBt0/eX39XM3ABYhEJhn9IdV1dzh
	XRn0u1e/nGj6CyONkjZ+jehRxIayBIXCxx/qo+GVbQQps62V+VI2fHLQmI7gHCd1la0=
X-Gm-Gg: AR+sD116EsSgLmEUiQiF7z9N+b3rysJ2VOLJdrtgXu+hm4y7h5tze33BSVxbcPaCuDV
	r5WgQqLvv0HwAnS0iIfYwW1/pKd4wI3lK+mJVPhR81E3ZVtJsrnW1w8C1snVwP/k+XW9U6KCF9o
	Lisxu/DsI2CXznWaqt6Keo24Sf3UoM5pDHKenb2X3xHm2W4HtGP4vxWUqShCHt59zHK6tISDN42
	gD21i8M+ezXmX+/WNRNChG/SsJyKkMSeKULVbehzSHsO/99MoD1xHhI5io5agi1udRhhyqjpI2L
	Ym+5a5VVe05096J2I0ClnYmIwTzaI5A3HEp0kOSokCOZP7y8koK9fZwGuuDKLwYFwSYuJ5gJu+W
	N12glVBluFHE6DMdf/ZTsYTaTk/cwknVhkkC2cbgqTQSOJckPzTQt9cGL5LfSQcEFm3b09B5Ydd
	URzS98HeQ788Xdgx8F6h5FOkJi+v0v7muhcdotodmRGw==
X-Received: by 2002:a17:90b:528c:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-3903c5448dcmr48045477a91.4.1786394352636;
        Mon, 10 Aug 2026 13:39:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:41::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5226b40sm899498a91.13.2026.08.10.13.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 13:39:12 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:39:11 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	daniel@iogearbox.net, bobbyeshleman@gmail.com, razor@blackwall.org,
	sdf@fomichev.me, dw@davidwei.uk
Subject: Re: [PATCH net-next] netdev: check for nla_put_u32() failures
Message-ID: <ano27zdc3KGvdXoh@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, daniel@iogearbox.net,
	bobbyeshleman@gmail.com, razor@blackwall.org, sdf@fomichev.me,
	dw@davidwei.uk
References: <20260809000609.327659-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809000609.327659-1-kuba@kernel.org>

On Sat, Aug 08, 2026 at 05:06:09PM -0700, Jakub Kicinski wrote:
> Make sure we check if nla_put_u32(id) was successful after creating
> objects. This is theoretical today, the skbs are large enough to
> always fit the ID.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - don't handle, just WARN
> v1: https://lore.kernel.org/20260609190804.1137085-2-kuba@kernel.org
> 
> CC: daniel@iogearbox.net
> CC: bobbyeshleman@gmail.com
> CC: joe@dama.to
> CC: razor@blackwall.org
> CC: sdf@fomichev.me
> CC: dw@davidwei.uk
> ---
>  net/core/netdev-genl.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>
