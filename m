Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792953262;
	b=Yi96F2/sefF3kCpzQZZ6oHrfyUFoF2HLXWO1BS1UJkP6uH8NZi/Dr6RIGQw2bdGgVOtw
	 xV455W1vw2MHZtTeO9qQcUpTzBE1JXJ3z9WZZ+XyJMqHT8X+P2vM2XQNsrOl6Zas/bxLb
	 QqqRTANtEDBNORJxZLrGHEmMWf5xrhvfI9XRTSReCJLk0INBSRZkbI1JTcP2ZZRrnm+rc
	 OD+rKPQyRY2x54kGxzgjjEsbUXimfpY7OuC3rY5/01jvNQfwkQ3hOX5buMunZwFEG/TC3
	 AoKQyXCYwAbH5e/tYmk6+6WcnHxifW3Hj4l0/Xq/3w/IlAvmsh7p8G/qtLfZ8iMiyfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792953262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qXiolJoVo/QomQ5F/RYb2Yfyvd/6E3aOqV+uqEMp4Xg=;
	b=mg/iYkUcM4DLF3Cydm0eQ+lwOC425hoBoXekWijSzQRYqxkxtvrZQJNkTYQZiynxd6YI
	 +eK+zemRTP2VEa7WqLaQjrZw7b6Q61OC6XMdTuxOANGeEfJ0TRQxGad2uxectiDsL1H81
	 MEdFgsDYzRrB9w9X7kx8EPSyI4FLd6nECiTeJqIgUl5NbgcLq1G5CDhYovcmF7/2lKgp3
	 zUXuM6fOkkbBRr9sfO+Qfq5ootIDHaTF/WEa2cVO5k9fyyV+km43dFOf8RAcQbI6IAShR
	 BOrMnoNQdonjqxiM9IdTRSVklwtKD13Z4+y747wwVBVZ4J9tZyJyQr2hmvIoVnKDm3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=vX9uroRa;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142B606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 18:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E142B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=vX9uroRa
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ade49a7ebdso923691a91.3
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792953261; x=1793558061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qXiolJoVo/QomQ5F/RYb2Yfyvd/6E3aOqV+uqEMp4Xg=;
        b=vX9uroRaJmEMTkg51OrxC1DEg5GevGDDMDo8sV2+mNUZmZJz0amQBk7ZD8GNdcwo3c
         quwuSHmyPRQPkrOYTmMEDEyKQzIIOEi3YSv9+eOwdQ9e2kjBir+/UYKiXD3ZicLvcPlX
         xkCWa0yBc9+Cg36mvDpGdIylthlXIalZXPOuk73qcXaEJAL4s45HjLC17yHq16i7oKa1
         l4DpIdtxa1Xc6Xp4ycEw1HVJceLNIhXWrKlIGbfjdOrtk9ZLeSGPj1xUMpRQip2uNPNU
         2X80lT64DCeFT2li3pTqBwVObnIZ34BUxMz6TXpMfSlx/CjXepfXUYGHPNt7RggAVVfy
         OUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792953261; x=1793558061;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qXiolJoVo/QomQ5F/RYb2Yfyvd/6E3aOqV+uqEMp4Xg=;
        b=dUbeirV18+YZGeNcUnlt5zcsML8Qd+SjQQXbjZsT0MtW+erjHejS+gQaBnulzqdAj2
         m8OX6wyZ0bfGi9jqazvtQGyUiW8IG1QIrVUsWz4hyCI+TB8IjW+/uyaJef9kiFkI8tvq
         qEulmBl/3YG1jVQx9pCEvbsBsGpVKK4jDOA5oq/X7mupOd7PsRmLjYn2Eo+Hwt19wICw
         y1FGxkm2S8ZpOXfU7/pK7fwszX4mRB9a2ywKc4VfBP3alQ9PNuNsHKw3h/TxDaPuhE5z
         i6o+2fi1LU1Q/RNGa+wsnaQMmATnabxkrI2SzZKvTrnmLhtAbX9DJ/QXc91zGxOCkQOc
         mhvA==
X-Forwarded-Encrypted: i=1; AKwUvBwSjmU2ERe8lIwfkZoWtrM/Fu4tlYm/ihCmV2xqwSevICScm4xwzxC0sjfRoFfp+m5yyGOZHIg=@vger.kernel.org
X-Gm-Message-State: AFq9FYL86Mx8oKO96Mvq01W4rLd1Bb2/V79Zc8tq9HRF2hca6rGuDup1
	xQEAuKJ2R0T30vlY5rKl1K36lsGtLhCBP95FHUKH71YcKa7Bw5apHbxlxj0ebld7mgJdhCfbHte
	QS0sq5Co=
X-Gm-Gg: AYBFou1/4tgMZf3d3f53fabroOgAcBEhG6l2BazVxO+7agYrtizUff0xAPtDKxc7MYf
	3LIZ7jZ5LsesLLHtYQ2ypy7kGSc0zQRyuvWyHP+u/gDLJhlTW/dUGmXA/VEKL76BT3ce3wwLXj9
	2N5iySxE3DDplH/+pHINGX54gqx7tbOv/B8fNeZemrNAi94FlPnzc+aYByiwqnyekMl9BI68AKb
	onUGxKDDxVIRnrv0ntjOjWvNhnddMTqtI2P21zmViiVKIxFTfNhUofq/4BvEfWCZ54Up8Rmh/j2
	q0HqoUtgC/MVdLvrpvCdTx1q/fE5ziwy3USST8YT+FGn1LtTjnKc65OTE1lauvtC6otiB03jRsG
	uLPCwz3mD8f9RUOORF9dbc08Fgoa6YdTu1IUI9hsU9bbdvtwwPOwxyAzOJEjKXckG3wmHpmKaSo
	xmrJXm9fzM95MkZn4XEHvsMujE8DZYeOD6eqyZkuagpvHjSFq+qQ93tecDlMnY/wTeC+zQA0dZ/
	RpfSrSqpwHPnqX/iIu9SCBSCxZN84A6ZPy8ZDFlDCI5wBpL+HsG/6ZVqTkbSqpJVqqtRbCs/K+Y
	AOMPPXOxKAape+EiHS/MFglPz2KmqLRcVZo5x5xW42Y=
X-Received: by 2002:a17:90b:28c4:b0:3ac:9d14:fe9f with SMTP id 98e67ed59e1d1-3adead57ca8mr4039856a91.31.1792953261212;
        Sun, 25 Oct 2026 11:34:21 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0718esm5326562a91.11.2026.10.25.11.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:34:20 -0700 (PDT)
Date: Sun, 25 Oct 2026 11:34:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hadrien Patte <hadrien.patte@protonmail.com>
Cc: dsahern@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] json_writer: fix pretty printing of
 arrays
Message-ID: <20261025113418.2f5acab4@phoenix.local>
In-Reply-To: <20261024183341.34161-1-hadrien.patte@protonmail.com>
References: <20261022211002.31098-1-hadrien.patte@protonmail.com>
	<20261023181302.2a06fe99@stephen-xps.local>
	<20261024183341.34161-1-hadrien.patte@protonmail.com>
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

On Sat, 24 Oct 2026 18:50:46 +0000
Hadrien Patte <hadrien.patte@protonmail.com> wrote:

> On Fri, 23 Oct 2026 18:13:02 -0700
> Stephen Hemminger <stephen@networkplumber.org> wrote:
> 
> > Putting all the array elements on oneline is easier to read and more compact.
> > What does python do?  
> 
> My current patch actually contains two separate changes:
> 
> 1. A fix for arrays of objects. Scalar arrays render fine on a single
>    line, but when the elements are objects, which contain newlines, the
>    brackets and separators end up glued to them and the indentation
>    levels of opening and closing brackets are off:
> 
>    # ip -j -p addr show dev lo
>    [ {
>            "ifindex": 1,
>            "ifname": "lo",
>            "flags": [ "LOOPBACK","UP","LOWER_UP" ],
>            ...
>            "addr_info": [ {
>                    "family": "inet",
>                    "local": "127.0.0.1",
>                    ...
>                },{
>                    "family": "inet6",
>                    "local": "::1",
>                    ...
>                } ]
>        } ]
> 
> 2. Putting each element of scalar arrays on its own line. This is a
>    style change rather than a fix, though it is consistent with common
>    JSON pretty-printers such as jq or python's json.dumps.
> 
> I'm happy to send a v2 that only keeps the first part, leaving scalar
> arrays in their current single-line form if you prefer.
> 
> Thanks,
> Hadrien
> 

Looks ok, as is. more of an observation by me.
I don't in general look at json pretty print 
