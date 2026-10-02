Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E06C23B634
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790900214; cv=none; b=vCgZH3mQ/e+qtVm6/BTWyyg43j+yt+lJeu4HupXicUc2QyaefrmiACkhDNm1Y9nps1KzKKYvtTN1eOyTY3G85Um741YuxeSftI9ybTWONb36NTNg47H/1/r527k0PhjGWubTugcY+MalTozioyX/sOWcuqfUKMWb1NXPkOR7nr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790900214; c=relaxed/simple;
	bh=q+6Q4y6H48Avufnw/sWDV+vkmXuakE9O0dv+vfnCP1Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Peedr1jVh2OeUKk5q42QBnR3nBreuCgX/e/B1kzJAhZz6/Ul5axL3kSiwHTdQshGidG6iAcnTsoHaAVYgBc21EN/T04AiY+iyv7yYCKBONhWPlsSVW/JEdT5rMPfq5k4E3VKVPdrs/08+Xmj6NJZiQT5DdKsq+DjN3R7BXRixho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxdjpzR2; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxdjpzR2"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66d1447e2b1so783901d50.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 17:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790900212; x=1791505012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rOgGB5KCdvmsyYEL6jVLup/+Bx353wLBXoi6WGMPE+0=;
        b=UxdjpzR2UzzLpH4PrgCMKqbUj3yzCWVRe2n+6F3CacNyaA86Y/3bRKTVQ0p8btAvFT
         eBVXKiBZT5h0gH0jMpSlRgIbxIFGcEz0IK8VknxwHCxnJPhp2UvMmqg3EIvCYCzKaacL
         OrU1LkKzuuUykcG9q0tzOKYCbg+qJ7SMyHUlBI1/t8rYAJiC5kWiabS34tlwNYH+ol2F
         BVF7XuFslARhm9WWHw2zzb7c0SROzsDcmZ/xlPSpgpZYF1lJnBaDk6dDOimPkfJPJvYy
         efKcCpVIkg7HgvX4yf6ZkgcpPFwGLzuX9SbKknJDXDhvelJIwqJENKnp5CswY49c31wy
         RQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790900212; x=1791505012;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rOgGB5KCdvmsyYEL6jVLup/+Bx353wLBXoi6WGMPE+0=;
        b=XvHbofw2Tu7j1z22tjHiCqvqGjtMuQ3wvL2AIheEGarztfl1UQ/W9YKy6Cx3gaaDHS
         sUs4PI6zcF58i3APPWRh0jdmxE3bMktFDlxhOW5b/aRKbXgThQ/zLHFEeWOUV+90WGBk
         I5LU2p2+AfhKm2dUVWbkTDGK/gbbj0dFAkI+3djs21APi4vQvjapkF+Iv3acQTSXsdDI
         ywuJxVRmhUqMojUjHPBacQNjWoB50XlIykLDqp4IVV7TNCHpWinTjgXtEH5kTLK15uNF
         NasDE0E9+ywFg/uZSH3gwEqLyyBehSwk+ieAj+Y4DDErXqNLCCEbZj8/dNgqeIseCHMt
         F8AA==
X-Gm-Message-State: AFq9FYIOd2OY8LOfnofHjbGrBBwss9uLhAOvVajcHQrTppEwehpLn1Bm
	A+dcik97MLojtmn6JJQqgoNa/cuwK+hs80esVJ+6XIDCAcX8r3i1o/qL
X-Gm-Gg: AYBFou0yd6Y6i4eE7fQvYw+6iCX4uZUfgiYBD/e5RsgUxWoHyHJI6P0B5nU2k13iATa
	fL4ECv/5wty2fbeisAkLnaGuDNl9S9ejwDkuKQcR1Qkx9J6jJuo40PKfUwLHd72BIJ4n4efQvtf
	PNUIGPIERpZwk5i0wDahy0IXeJOETOu884M3JBJCcxishYIt6U/M04unH3xpgqaIQ1TtNdSISgD
	nGyZgYP0m3wvVVlzYgAHpT/XUREH8d0fpKy3J2P22j8/mhn3zdV2keamfMNB5wM8S5/B/FAZGev
	xjZJRRyglOuXCB9mrQrg46MvsS8gnPhwLFORPzE5X5gh4SBNydqpJ3OhgWNfnEYDURApGrLDVHd
	ocrID4+u13RAzzB3c5l+ni5VOA5syVwcwps1D3NUxxzIaAKZoR96GoY5+PKnp9R7wsMIMBwJZYA
	2qokCbUU7DYKMsr4mDHuDioZvFGDiTzrhdgQNPxdMZib6RsrgcCKo+QmCUADaH4+1NyhyqnVZNw
	lrRB16aJLKLnOXQWcZQXdo7FhZrAyHSmDZ+hNElHKhV1Xz6ceoN
X-Received: by 2002:a05:690e:24d1:b0:672:c99f:5f5a with SMTP id 956f58d0204a3-67691115553mr1514703d50.8.1790900212088;
        Thu, 01 Oct 2026 17:16:52 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33ee086bsm3230397b3.46.2026.10.01.17.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 17:16:51 -0700 (PDT)
Date: Thu, 01 Oct 2026 20:16:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org
Message-ID: <willemdebruijn.kernel.678a05ecc978@gmail.com>
In-Reply-To: <20260930-psp-defeat-v2-1-f266e7447129@gmail.com>
References: <20260930-psp-defeat-v2-0-f266e7447129@gmail.com>
 <20260930-psp-defeat-v2-1-f266e7447129@gmail.com>
Subject: Re: [PATCH net-next v2 1/4] selftests: drv-net: psp: swap closed for
 connected sockets in assoc tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> Future work will only allow rx-assoc and tx-assoc to be performed when
> the sock is in TCP_ESTABLISHED state.
> 
> Several assoc_ tests, as well as dev_rotate_spi, test using the rx-assoc
> and tx-assoc uapi calls against sockets in TCP_CLOSE state.
> These tests don't involve sending or receiving data, nor involve looking
> up psp device by dst entry, so using a disposable disconnected socket
> was just a convenience. These can be replaced by a disposable loopback
> socket.
> 
> The loopback sockets are IPv4, where the sockets they replace were
> AF_INET6. This doesn't reduce coverage, since the assoc handlers accept
> any TCP socket and don't look at the address family.
> 
> Some users of rx-assoc and tx-assoc on closed sockets are left if they
> validate errors that are returned before the kernel will check the
> socket for TCP_ESTABLISHED.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
