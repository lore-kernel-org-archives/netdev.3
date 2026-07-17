Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C533A3B42CF
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273476; cv=none; b=lIfXvq+HxrzB06IqWSusY1YS4vMKBuEgNtuSMsZl4u69mAKjaE50kZeLR1tpHctpAb/VxX2DmLHD4akavHGQYGcibelHQfxLE2CwAzs5a4Fq+5sz02J6FhP0iyKSX3qUTs6muIX1+oNxeuYIk82XhS56PNOISmOvdZp2A35UdF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273476; c=relaxed/simple;
	bh=TTTi84fQXmfqPktQvwQDzEW04r5TdLBnIP217eTzxcg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RzaxzOLjj/bif2X5QYA4XblgeUbiAA1PyHcojP0vZs3P2vHswBLOsJO1at8WAfglDGh+pXeHnSm26yQ0Bt1joZjFSIy1tYpSNWTtgAXtA2vOQIiznUcp5aec9h48mWrFFgZwU9pNYSZpCrYw7G2rd/f11+W2q5GF6euIXoRa1hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBtDEc/y; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBtDEc/y"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81dfdbd86d1so40467887b3.1
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784273468; x=1784878268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h+KxapTZ1cp8gckSh3wIoSmIwiEPYwiNb1NXspU7l9c=;
        b=TBtDEc/yf0SrDF505jcqA6l47BgyYZFxiBu/JGKMiCDXqfYka8fXK6Zrb76VK2OPD4
         yLtFt9cpCeK81cGKdoqPYI9ZaSB96yHEtqINa6O4R5dmsAjIdQrzi7ImkVWYHvvJjtP8
         7rntFt9gLv5Y4NFTR1TVr4WfZoV6sFcpe4Y5/Cjy/rx9XAxpwZPiai6iet5uuP9cDpll
         NO7EXKu1adA/taUvvSnfJwgFBeWVPDJshjJAls7Mgxd9PFYWqil55AdP44FkWuBNtAPU
         XUG2EAAKxLnPejBbYnbBGgBtpOtgIEGfSUR0xJ9L6tgYBlU2Msy2lbeVk1MVWwxdtDtP
         Cl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784273468; x=1784878268;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h+KxapTZ1cp8gckSh3wIoSmIwiEPYwiNb1NXspU7l9c=;
        b=bn/vypAutBHUFQbL4EbJ2kUjr3/imMV/BgS+2Xg8lwDHhqWGcvwJuaU7ExCN9O+/jR
         V6lAyOoGB9eNEHUNT+boSvInbkqYSJdTDZlHvano1KziLhB84vOGIvCDTaDRo8ozl5bU
         ZOCzPgN331PpqMql0hrDmEj2tsToNIhJiTTe/VOQz+7G1+czaEoRfI2TkSplfTlddVoE
         otMbHf7Dg3xYMMt1LEhuG/f6Xdn3YtoI/AFWXT6CCETwvir6OHVUqecPVIYZyqCi/JAV
         4e52Olfx/mDZHeZsT1HcgIOi2Gk+Fav7lzE8QHBLXbE5/aWHikqyMtQn8bYYbCO6XzoN
         or9g==
X-Forwarded-Encrypted: i=1; AHgh+RpOoXPUkBAcRhDWJof5kTnMZksQdTMllqrrM24uaDPWI5inB0CCauzyAGB7XmZIcJQeL4Zuyu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8xkU8A95AYI0megCSsumgUrrANuVz8h6eZBHJSnNp1XhDVGmj
	46uY2Q3nx8jHguDA0xrwRP8KES+nL+/2r1GCE0g9c+Hm30Gpzhw6W4yz
X-Gm-Gg: AfdE7ckW+oRid+5SN/Fv6/n3T1m8CZyZ6uTfcMqmY2k8iCseN/Aymuwtzug30wucBwO
	Yw6uoBMFytyEgTUwUsZbWmHfGtCowcnnkqyOGfSA51nWWipo5eTseofKOvnRtExoxD0swhkf8ET
	VYzZIOQ5VZ0+2hp1CXNZbhEw/iXR7Ny6TRQOy3tku7qtNik5c/RrgX4LxxgLt90RKNsDKHXPb7U
	GrPcu2c2eBfRdwEGsXuab4tUMm/xir9hRJ8AWmKr9qSX5AC/11qckNKUf7HNP/ckddCvQqk0ErW
	ERAKhcyHlQ8OoZFuT6ozbUo5UB7yM7bVvoXweJjL4QNYW3jVWBey1U9vlsTwUX7fK+6t+m46j7R
	cXFBHq0Cz2CjcI5Gz8sv9YnypjjB3FgoBL63g8+AduRG9tx6D0bgCWd66Ajj2iP9hFnB07Bzz2v
	nZzLcySiAWCBlbtD1Jv4eK7JRN5HLIWhItqEUcoHzn512KfOSDednJMwk=
X-Received: by 2002:a05:690c:6013:b0:81e:9ba9:d37a with SMTP id 00721157ae682-81ef26000c1mr4140177b3.50.1784273467762;
        Fri, 17 Jul 2026 00:31:07 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef4012c89sm3352097b3.1.2026.07.17.00.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 00:31:07 -0700 (PDT)
Date: Fri, 17 Jul 2026 03:31:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Octavian Purdila <tavip@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
Message-ID: <willemdebruijn.kernel.22b04ee9dfdae@gmail.com>
In-Reply-To: <20260709183315.965751-2-kuniyu@google.com>
References: <20260709183315.965751-1-kuniyu@google.com>
 <20260709183315.965751-2-kuniyu@google.com>
Subject: Re: [PATCH v1 net 1/2] soreuseport: Clear sk_reuseport_cb before
 failure in sk_clone().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> When sk_clone() fails, sk_destruct() is called for the new socket.
> 
> If the parent socket has sk->sk_reuseport_cb, the child will call
> reuseport_detach_sock() for the reuseport group.
> 
> Let's clear sk->sk_reuseport_cb before any failure path in sk_clone().
> 
> Note that this was not a problem before the cited commit because
> reuseport_detach_sock() did nothing if the socket was not found in
> the reuseport array.
> 
> Fixes: 5dc4c4b7d4e8 ("bpf: Introduce BPF_MAP_TYPE_REUSEPORT_SOCKARRAY")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260709032007.9E4D61F000E9@smtp.kernel.org/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
