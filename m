Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEF7374745
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312548; cv=none; b=opkgiCBsZ8pLGxtLcGa10Ba7O7T7aA+dxSbLVAec3nwahZhZG/ruzm0YMgK+3R9D3LJzjMGn4OqQb4dE/8IF6XDYTJHTj68Lzc9Fj0L8Zoz1Qid0YY/EYSUtd3+qGkv44AxUchUR6s49FEkAaBOYjedvH8DZ7uBUGPOiSasyQuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312548; c=relaxed/simple;
	bh=JNn5clqejdT+zRoq24VhrDeevuyGBfvQGO7Y3R8uxs4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJTxYShPCX+2vJ5vjJRZgnefMpf7h6Kzg6weyBQlNPUxPXhz5Yt2nudX2VaL7gdA4vqISTN+LGYKQKcQ178R5kEWLdUoRATalegJqEg8HdI7wPVjLviSmm6FSC9vwK5Qd15ztjzFTB49toDxRGsKIZni/T0VPKuhg4udPz1eAFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=csD35pzi; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="csD35pzi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1787312538; x=1787571738;
	bh=JNn5clqejdT+zRoq24VhrDeevuyGBfvQGO7Y3R8uxs4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=csD35pzicLegh/9J0qnpZ/0xSUl5pxIW3tsEiYF49qb67X4Q8MsLSeHBUtqByDUrn
	 GgFFeNWyXxKmoSI8cHZ2R6r4i9Z1wDXIps10DPJQAebeR0NLBiSvTqZWyOB13IK0MN
	 jV0yluz3KLcHFFwuH+egcf65U32mPGIq4SuYuXDtf6aL8/acja/1rl3bo5XKZOezlN
	 oait6oSJdiXjV+e3EmDZzLvqORH/cPeQGCXiGR/eGM0CsKc8FZPvbpZ/rYeygmZipk
	 C6FqA2+PfZOq3KhSgsZClC7qqkr2xR2hGRobsQNCq+ctf3/l0sXWCH8SqwrUBEND4H
	 0CV7SdLoBX4ag==
Date: Fri, 21 Aug 2026 11:42:16 +0000
To: Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Hidayath Khan <hidayath@linux.ibm.com>, Simon Horman <horms@kernel.org>, Ursula Braun <ursula.braun@de.ibm.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net/iucv: drop HiperSockets frames from other network namespaces
Message-ID: <20260821114210.430509-1-hexlabsecurity@proton.me>
In-Reply-To: <e42b30ee-f7cc-4f65-8fe6-1bc6888829f2@linux.ibm.com>
References: <20260815-b4-disp-dc82fde4-v1-0-e83b10b22ce9@proton.me> <20260815-b4-disp-dc82fde4-v1-1-e83b10b22ce9@proton.me> <e42b30ee-f7cc-4f65-8fe6-1bc6888829f2@linux.ibm.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 70b134f719bcf27898a10dc27797fb8c16cd8016
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandra,

> I am wondering whether a check of
> +=09=09if (iucv_sk(sk)->hs_dev !=3D dev)
> +=09=09=09continue;
>
> would cover a broader range of issues.

It does, and I'd rather have yours than mine. It covers three things at
once: the namespace case, since hs_dev can only come from the init_net scan
in iucv_sock_bind(); the transport case the earlier patch went after, since
classic sockets have hs_dev =3D=3D NULL and drop out of the walk; and deliv=
ery
to a socket bound to a different HiperSockets device.

I went looking for the regression it could carry -- an accept-queue child
left without hs_dev, which would break connection setup -- and it isn't
there. The child inherits at af_iucv.c:1908.

One thing it doesn't reach, and it's why I'm not dropping both: the check
sits after EBCASC() has already rewritten the transport header in place at
:2073-2076, and a SYN matching no socket still takes the !iucv branch at
:1872-1877, which swaps the frame and hands it to dev_queue_xmit(). So it
replaces 1/2 and stays complementary to 2/2.

Send yours and I'll drop 1/2.

Thanks,
Bryam

