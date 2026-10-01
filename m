Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215CD366541
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829513; cv=pass; b=ey3NyxhOWCMO+OU9x81XBnnCg+IHY9ACtovhSXHxmn8ETfpHpT6VD/jkG0z02dhUCY1n915o6m26vgMqyHLb09zxZ2ldO36aBF8YQeob1R4x8JSJF1p22KpwOh6qQgYf8ktMbB6ZDhlJctj3dv+S8jVu6P9Zh1QPhaa0e4JU1lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829513; c=relaxed/simple;
	bh=RzZXfiD796BISLE4d54SM7rERI/SYqzCPtyXD48JKMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlwgfJGe3ujDw6kRF3W4748It1rAOCfC0yUAb4snt04Se2iBPB1/E38WYrYp9zzyph6MGt1cYKhGdzfX4oTtBOv5YY2ydLTBlwGGV+wqktVV+9qhN6dUgTy5K/PQBHmQNOIEPbTWbwC07Dj5CsefpFtqVY5/vBFY6+8OCjNihdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxm4Q/aH; arc=pass smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxm4Q/aH"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b590a5b5eso2922030eec.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:38:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790829510; cv=none;
        d=google.com; s=arc-20260327;
        b=hpNQcr0vhOjrm/ii/MkvHlsfX/3qzGk7kMaaa6G0Qnjkil3u6Pc6KF5j1crAbMpSch
         ZgzYXm+VXcNW/1wXXHwicpqXKHfyFcto0lwSMec9OkgulpjYKRufoXF7hZX8EXATjpDe
         6KZ8z2hwkdg0Y3u4xrnqrv9gXR8cJSQa1HHHNQrzlQ2BFgLD5KHE4uDi8D3hpl8s3j4C
         ENjQ+OLPOmaQF79IHZSgV++Mir9iMhlRihHqoDP8JIrtwnlnPTBJ3HqzwIBVepT1XqG4
         FZYF3knk6cPni/QOCeqD+L52gNmmASyqW08Dlu4QJZs/8IG8ZWzhah47Q3mJPLsJ/E5L
         lJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RzZXfiD796BISLE4d54SM7rERI/SYqzCPtyXD48JKMw=;
        fh=zHEOjLhZ1a+UvdtQOklMe2Kh/ptQF9JxJNbZJ2yo7k8=;
        b=ZJjqwS5dhmT/YrS++UHlDK6QlOHDPgHjiC/0C0kzJPusUHRpBkaCIRlVjxc1fi5ht0
         zIO6R73GiWABjH7+rv9+9azyBLr7zVPP+lkoDhUagwp96d1uPKYi8uwDb/jcPOlIZNT1
         4ko1iEF5UBx3guXfIiZSzrjnrmNBMl+Cw1NokmIGTdLsNxGbk38NWZqx+oOKGU0Z63KZ
         jYbjgX6im9KiUZlxUjyk6R8Fr2/JpN9+t+gxPaSOr2aBF4bwQGwp1vWCxOAjMNvCZYHa
         SzNuSFG/DB/QU9zlyZ0K5RnMwatDL0dnJuCw8KTAqwD2nb7kGVI6kaZS76fTu2kB6Sfi
         7kxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790829510; x=1791434310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RzZXfiD796BISLE4d54SM7rERI/SYqzCPtyXD48JKMw=;
        b=oxm4Q/aHHtjIckSdR1pLOKeqyLX0OMGyF2aYHj1zgxq1jAcax71VpqLs+cMVqb+zlB
         0xh9jybedlrK5jDsC33dlXfJjsnISRuGwi6Z0Se8ls49+Xj/m0JgcDr964LDMpPTXBQX
         /yDcUbmn9obEkfzCmSF1bFIzzr8/XJxZNiEo/9AA0lsRLMG6UFZXeMOdIhG6GwUOJa7f
         +jcIyYQjzVIvWQOlAKme0sopXTi0zPJ+cyojivzQfKdilJAbLHBkVu4yZIKjhvb7nC0i
         5rBiV5hjbTIHFlCyF/wBe4CoGL7F6ATXg/utTBLWr1S/ph2PGaxQL/HHA9UYse+bwyeC
         QevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790829510; x=1791434310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RzZXfiD796BISLE4d54SM7rERI/SYqzCPtyXD48JKMw=;
        b=0rkyV0PIkw5SJfO0JfnRvWi3AhGI/QVKQO80ZZQgysD90RQs/PUIS8JHRAtBHsO6SI
         pzLgfG0fVsh84s230CmU54nXwV34wG77OyOuXcVOV6eIPjiflpeMZrZpfSw/fnNVsuhN
         VHrwqId4QqxH5lBW/nOQWfkleIk6g/LnXZf6cX7ngo6L6M1/fCVn3589+qkTxTecOj+1
         7hvAdX++9losTI3epG7YmB+I3Hgdzp7qYYyRhZGbp0DgXXTyV0n4u0L0t5MCqnTJIKXI
         3+Cs6NotvgKel5G9Er8puSvRdoAi0jgeqKap31zOPnJKrqd9YwMRvV6Z4JLOeQ0VPk9Y
         4fCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWf1YlEqGj9hfEUQklNl2BasZ5zWYF1w5WkAxZPzN/UpZuAA4soblH3lDwgVbPqPzgKd0cWUM=@vger.kernel.org
X-Gm-Message-State: AFuF++l7Nm35+oIHhJOe99hQmJKEZMnyG1c3jwPokG/2WigSWG2YN15s
	mTTutotlPTyv/Pv6ZVFrKLfN70hCKdZgfR26x+xAKfDGTlrNLOC3dJwtwUXmCqiaAOAM2MSICmN
	+MGSVjemj6Z62oCRWLC/8s7B94vkHsZTxEM6MzxU7
X-Gm-Gg: AYBFou2rrjnbVX2706dTZi4tsSSu8Iz+UsncdH9vCqWTul7EobyTBVyjsFu9p5gzcxD
	cg+xL+A/F891PQQlApvkJ5hTz0lhyo1ITuqk8HghsQyyjJYWF1GtftuUvtio28lmJYj7y1JNpdB
	2qTWq9I8lYN2VRugr9S/3sZ1oA6A3BSx3LtLPJwzuKgpot2CTCsWUOs8QOtlktx6xmlkciHYXZ1
	tZ7vkl4kO+HbumyAfGNXPvFWnKSRBywznFK8mVtTYnmaGjpvcWb8ts5j+es/Aepp1Q5xnhfRzlv
	IpXLqH17BZXAKWikvtlg6SCSXZX2dDIlfjQRlTFkx1G4Y807hoV//FmWJkEiciQqiTBsBu4GiCL
	eBcEh5CF8f8W1rdF0Xv2ARraKzqxeUAcLB6GzZLTLR9HaYgsSqsQqeYIER7vKwKGR3Oc=
X-Received: by 2002:a05:701b:42c1:20b0:143:2984:6517 with SMTP id
 a92af1059eb24-14d33399ab2mr3673486c88.38.1790829509400; Wed, 30 Sep 2026
 21:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com> <20260928-work-unix-passpidfd-v3-7-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-7-532018a91b21@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 30 Sep 2026 21:38:17 -0700
X-Gm-Features: AclHuK9QRXzI8_0z1Op0JTA9GMdarUQ2An_aAKGGaGQjZXyZBTeygagsSXiYtsM
Message-ID: <CAAVpQUCf9+shzzU_sar=GG=E=FGvGpvQaY3ErTgQatmB=kSZsg@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] net: add SO_PEERPIDFD_THREAD to get a
 thread-specific pidfd
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:27=E2=80=AFAM Andrew Halaney <andrew@amutable.com=
> wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> SO_PEERPIDFD hands out a pidfd for the thread-group that called
> connect() or socketpair(). Enable workloads such as the coredump server
> or a broker to get a pidfd of the specific thread that connected to the
> socket.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
