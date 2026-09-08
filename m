Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6B34D8DB5
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859287; cv=none; b=jIZPViRhclc1eUfdJFne8TA+RHu2m/P7TBMqs3eAfq1Hclp9+f3kFcljne+U+bOf2bj98gihhX4v8d8hsW+fhs/8V8ltsehakwBXaNMc43Mp6i1mpzADsDI9YxnJOauNq8a7/fIFH8n9ibGcg+prxUuBp16V3yN4a2emWx1/dIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859287; c=relaxed/simple;
	bh=+m2hv7qCaLvWBeCYEqn9CVxbNWZv+mlbGT0yy4FYFVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6v+fr1D6UolXt2SxINeSrB9W8HlhOZuUekexKWlbD2pnXTxHe/IGL6E4WIJJT3xZREQGrvJl2XDZgmMqgs0dhfgzVE7Q7zAhg8MUufHZtI5img5eNzC+WlARIy6huIIHg9TMdH3XwjGhTUqJcvbzy+SfMhp76yqDwPOFkECfPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DP+2Whzw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP+2Whzw"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so42492335e9.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788859285; x=1789464085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eo62hsVx0ZUGOTQO0JY1oWFANZVGkcuejYroJ4ezr5s=;
        b=DP+2WhzwCo1Fcyo+J8/h3Q2ecMQRIbx4d2U1QMQSeuQ/f37syss3DeXktlETYQocSy
         V4sU+2NQaz8mPKo6BGyEnyUd4KClskidiDWezRwG00K7s52MVITNY0JIdAbk9e+dHDm1
         0SJxy9B7sMoThnWqzll/9SvVisdkadWwOfY3qZCX1jmCDTJS9hatmgBf/KQ3DNKg+O+T
         tGv9QBXrmdQ7AUmMaqJtMg1YS6aHeE9AygX0nTRU6ybKX0gHhgLzkNJKya9vataOtwNY
         8gS5b6QQ/j6SVWWhAXoAUMnXH2t/rFktAcfV+L68AEY0V/Rd/4vFh4Zd+yBfbfgBD02V
         iMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859285; x=1789464085;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eo62hsVx0ZUGOTQO0JY1oWFANZVGkcuejYroJ4ezr5s=;
        b=tAY2FS09MsFgUmv5V/Dl35tWyWzFYgdRGMw/8l588LgBLi5vvUzvJ/D34BO0d+rqbf
         oLXtHiKUagD/l6lFwTiiFAevrvldHAhWR+0NC4PU3+O74WGSon3MAVP7fCU4UkKcpDga
         wjPLy4I6DS9MpAX0PXuS3ha0NaJ1daElluSKi2jT5n4VPetzey93CxH9FbkBS2ocqO37
         +WWGMe7aEunDovOMX5FF4z6u9X9Ss6lEYGwjqcK9+pb9qMrp4Aw3MxCKPGE8wC82k6YX
         hB9Xwdy/H04wKH+H2a+GM8cQzWVcE+0t+X2sXM6m5kGhTs1moHo8rDyJfIN4YquLfUnx
         q1AA==
X-Forwarded-Encrypted: i=1; AKwUvBwot2xHmGsQcDC+UFKgMQ/wnc8aIS1FQZ1YS5aYceBZYR2roLyWXlPU2LLp6Upz7ZIQgmlZ7DA=@vger.kernel.org
X-Gm-Message-State: AFuF++nQ5BPW8KhUVnOWp6z2wobp5unkCIf3UiYFklL9IuZxznAPgdcI
	UphKM6vpaDFR1hRACZTqNg0gfLFRTohAOKqyYqNGnX5zHRywvTNfBfcW
X-Gm-Gg: AYBFou0pbhbQJMrFm59YBsi9VqT5i5NBzFNJ7m7UJMytT0brPTxCX3sjqDFEZkaanzo
	0iN/MPBrZU+aKzIkUCypoTbj0wfsHixCB3TtK53+Rw2ZLpDj/ai8Tl1hSp6cfwtlaHtEbGHfFah
	p3JchhJ8ibhsPyB4MDM4Et0QgKHuUb2l3x+cF6BGUE1Kfy+W59LBuKgaIIa9EWKkqsfUFLXNn+l
	eE7BfAaTl1Y8qNIclz8vF70Ecod3HsCTxMHvvMivwNr9ZX2benUtCirVRuzxiFhHWmITX7F1EZe
	s3a1wwoPg58F0JCWCUZ3Dn8PpDmgv4iJN1I4s8Ww/iH1j2UuuVpmO1RMZagc6Lv30zi1Sg4mgRG
	7bWgmhUxZQTEbV7s9LC580XJLaydZEXNlrA1FvULkherHtlPPeV8kpmdQ5/jczhYXpllsXOoAwT
	fn/v6L720sySOmYiSMkko66cqJ9jceYCSFDAOH0L2lzBvdO0+x1973PBa99hAD2vMZ781dlhTfv
	XMQw42ZhgrCjknTiY9aib4YWFg+Y2Mh5jAh
X-Received: by 2002:a05:600c:6290:b0:499:8174:9f39 with SMTP id 5b1f17b1804b1-49cf7f3d239mr599825725e9.0.1788859284337;
        Tue, 08 Sep 2026 02:21:24 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d0656e7bbsm274427785e9.10.2026.09.08.02.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:21:24 -0700 (PDT)
Date: Tue, 8 Sep 2026 10:21:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org, Daehyeon Ko
 <4ncienth@gmail.com>, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH v1 net-next 2/2] ipv6: Remove IPV6_ADDRFORM.
Message-ID: <20260908102119.3733b93e@pumpkin>
In-Reply-To: <20260904033543.2635540-3-kuniyu@google.com>
References: <20260904033543.2635540-1-kuniyu@google.com>
	<20260904033543.2635540-3-kuniyu@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Sep 2026 03:35:29 +0000
Kuniyuki Iwashima <kuniyu@google.com> wrote:

> Recently, IPV6_ADDRFORM has received many AI-driven bug reports.
> Fixing them properly would needlessly churn the fast paths in TCP
> and UDP.
> 
> IPV6_ADDRFORM was initially introduced in RFC 2133 in 1997,
> but only two years later, it was removed from RFC 2553 in 1999.
> 
> In 2026, modern applications natively support dual-stack sockets;
> notably, systemd's socket activation does not use IPV6_ADDRFORM.
> 
> Also, getsockopt(IPV6_ADDRFORM) can be replaced with SO_DOMAIN.
> 
> Let's remove IPV6_ADDRFORM.

How does the ipv6(7) man page get updated to match?

...
> -			module_put(THIS_MODULE);

That wasn't good...

David
