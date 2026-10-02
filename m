Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9644EF145
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956320; cv=none; b=MOiIdFDSlTSrHNJK2wLVSxoO7biLzQYja3U+BV4odsstyd02dwGZIGpR5/ETOiDmir+AhDXi/TAzSSglIKozcXCR1DLQQ9CcfkskCcz/R9AY9zCJrBhDHufhhcJqIiDVOc9424HFWuL7T4thA0IlvbrLpUwEwWjJRS5zo6aEfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956320; c=relaxed/simple;
	bh=pAdbd5oNKYolkRPMipRW3CRkFm2Npf/kbRnXmTveOvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyZ59LHK667toj5jo/5AkJH3awhUGPN8V8O6FiWTQ5T2lneiPOmnNwFvlpj1/Rd4ZD5LIjFwdGXzA1Iynn8cc973g/9m8hDN4ibWqfDIGB+rgocL9gf0HbE12qUJM7tBUJEJGMwpEX4o7UU0UsNF6tZrOi7cWK2BOk11NiNK9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EUz/GYl0; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EUz/GYl0"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e201b7189so9775266b.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1790956313; x=1791561113; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YpdQsR3CN4x5VZvlzQs+4AwQH09AxXpGs8Q1TofsmI4=;
        b=EUz/GYl0RarMkS4/PqPHbQzVMoWHQVRA1ziyoYbhA74FRYsCTNituQzz8HeyOxoSv8
         E7nu5N/o4VxfH7lMfWLQpxRUvPnrJTlTQot/1Yi3oRkjCIwIy+ErB+B8yvbmUpIInrIU
         9wMCIqhvHE5+3S6SzBtC3WmLjkwxuZ0MzrSP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790956313; x=1791561113;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YpdQsR3CN4x5VZvlzQs+4AwQH09AxXpGs8Q1TofsmI4=;
        b=lVhCURNzWhidp6RY20Fq2D3SNYm5vGhTt+r0VErjK+Y0sHsJd+4J62A3zwzpIO+/OZ
         GuFYSychRvDE6pX84pPAbX2zXz4VJLbAxSbhzMS48yYZxJoIEX7CQnWYuc7LqmQJFAe7
         XQR4tKznB7Lx2rwxr+YAqA7a8fT1DJH4RF5WFPrXn4mKeolcCAJb8bJhtJJl2SYaP/+P
         w3eZljjzJ0gUqPmzzocvzGEzoej/CRvf3OGPPGlGQgUZ3O6ADtVMi8S8Z/qcRiXjvEJT
         3LAQeHTtZZfzDK6apmfMEOKHRmz3dO9OwJ8lNgtXrw69abISy/+C30txq0WIyKyWcgUh
         GpGA==
X-Forwarded-Encrypted: i=1; AKwUvBwSIFSTaVgwT0s1edYbf/mUHUANGmLXxcRGmfYfX11L1W5g5goup4AJdpN0r7emIxPUk1UVY88=@vger.kernel.org
X-Gm-Message-State: AFuF++k0JAdOe30VbZ/r9P8dYqQ1eWdv58EIJzKH3AXvj+J+sH+MmrY8
	mZRTbRCuqhjjQfwC/qMi6UY1pwJnl8Mt1R44saFHkM3J8eEaVjkaOi2MJX0/8Dqxach9m9aKe15
	3100dH7Y=
X-Gm-Gg: AYBFou2ro2qQDhoGZ7+rTjjZtDqas5c9bnr2zjVeZle+vR2xXN6G0c8NF7gaekaIJK2
	byoXGX8/b2jvwX6/YrUfmO4htbvqklpbcQqBavSfRMqn7/h6zbghjxJfe0k27gCAMhAeNM1+7ER
	ZSJ7uw1bwK+l48PllqOdwOgJuCn7ZOb87LmVD+yKFSqBDWvulpiDHzdtWK4n7pbK/H0t7xAFhhF
	cLvUS2vLciU/SmncK5Y08T15eFe2p7JjHJvOi4SbpqHRTTpxOwl5qz5PD++423WeuBdtGNeryQu
	OZTWB91Ci1VsLwb/JNJ384Bvl3ijkHPB7wJEMWxuNC/ZZZs5p0Ijy+qPWz98a7+Ddvx+0QWOxjx
	I1Q+a16KeHM7uF3i3qjaK0GuH0FTojlOUizbMuXELV90IKa0iVqI7hjfeXP4Bzrt4Z2cUmkiWF/
	j3Wpz9KsJpcW3A1gSY973OT1+HZlWuJaq2ImmEC7tLtLI+bY343UkGjG7esxJbc/fuetcj4ptBD
	kKOPSL7v+Hmq29tUzcxNQr9ltfdTxxU+U3vDsoSTRxoei2bNFGBPAEJzaoX
X-Received: by 2002:a17:907:1788:b0:c26:36c4:858e with SMTP id a640c23a62f3a-c2e4af3f018mr234244366b.25.1790956312594;
        Fri, 02 Oct 2026 08:51:52 -0700 (PDT)
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com. [74.125.228.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4ca4d8a7sm103507866b.1.2026.10.02.08.51.50
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 08:51:51 -0700 (PDT)
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e201b7189so9769166b.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 08:51:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxZiFWU5fcTBkv88o6cZ7Sl3X6oPpMkBeg8pepD2K7err5M6QsNVr9CjsJ/vP0tp8ZIPUJZ5qo=@vger.kernel.org
X-Received: by 2002:a17:907:720e:b0:c2e:3e3f:e1e9 with SMTP id
 a640c23a62f3a-c2e4adbbb17mr251802766b.18.1790956310475; Fri, 02 Oct 2026
 08:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790917676.git.zcliangcn@gmail.com> <62774f8c6cbad549d1a95f88df99ab7745d7f6b8.1790917676.git.zcliangcn@gmail.com>
 <CAL4WiiqWwV+8JaYjsHrWDvoSt8Ng01xs9Orv4xhRpFAvhMnD6w@mail.gmail.com>
In-Reply-To: <CAL4WiiqWwV+8JaYjsHrWDvoSt8Ng01xs9Orv4xhRpFAvhMnD6w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Oct 2026 08:51:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDjOnUUVjJsEgH7=N5yEQTcSTuvHwaQJjdxkqgkmBUFg@mail.gmail.com>
X-Gm-Features: AclHuK_Y-fPHErB3_u0yNm9tslRbegeI3VlXWVSR7cqqfdTO-_AY2cxpgdLmLUU
Message-ID: <CAHk-=wjDjOnUUVjJsEgH7=N5yEQTcSTuvHwaQJjdxkqgkmBUFg@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: use random salt for netdev name hash to
 prevent text base leak
To: Eric Dumazet <edumazet@kernel.org>
Cc: Zhengchuan Liang <zcliangcn@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Oct 2026 at 01:20, Eric Dumazet <edumazet@kernel.org> wrote:
>
> CC Linus.
>
> It seems this patch should target net-next, local KASLR attacks are
> not a serious concern.

Correct: local KASLR on its own is pretty much a nothing-burger.  Most
hardware effectively gives it to people one way or another through
timing channels in ways we can't really fix. So KASLR is really only
just "some bits of randomness against remote attackers", nothing more.

And yes, filename name hashing shouldn't use anything really secret -
the filename hash is much too simple and fundmanetally cannot be a
secure hash - that typically you shouldn't use any *real* secret
hashes for it. Using a NULL hash is not uncommon and typically better
than using something you actually want to protect.

I think the most common use of salt is the dentry pointer of the
parent dentry pointer. Which isn't great either, in how it exposes
bits of a kernel pointer, but it basically ends up being similar to
KASLR: at some point, local kernel pointer values typically *are*
something you can probe with some time and effort with timing attacks.
We try to not expose it willy-nilly, but if somebody spends the
effort, they can do cache and TLB probing and it's not "cryptographic
security" and never will be.

So yes, don't use anything you wan tto keep *really* secret as the
name hash seed.

               Linus
