Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431596;
	b=iK5K+oAQkhQst2uxp/EFE1EAA8d7LZ4u8IKFSgF/0jPvKdZcWyeLIk+A0+xNIaX2VZi4
	 dom7GXPUu1rQvmIKPxV/nL4mUpl9IjW+7qZbfpoZ0/qvPIsQ/ln/uSQP+5hOsNlXkhZ91
	 KXX3zIsKtr9+LvybhqdVIms3XlGW59Jw8bZoqSI/aigT0/Miv7Ny5q8WlKPBHouBlu6yG
	 HoRBUMBZO8obViFOKth7yHSuiWS8dQTtmbU7AM7019UlOpMIPioRlRjtC85O0C1d/Rjux
	 ju1Fe0IAc0giOlPTlUk4oxrwNGFH+PVLQKeKdOWICOxFcEbcYXfpdSEolyCG6mvoHiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431596;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=8VPZkjdc8vUbwn23vxfk3djmQX72u5g+/jUxmmAER4c=;
	b=Kg4UCKNAQ52PeFp3xlIQhgpArJmJAtHSn7l0HMcMq9a4i0Ch3RRAVpvDxRKTK3QinnR7
	 AZBNRV/2NGTVJWmul4+hViJdB+fcBw3OLijh48im+7bTxzJTLWNvPsB58tvCcrkzP6jUV
	 OjmWojDxdLFqlYszaMsolPXsTM7u9P0HdWNT73SQTWyqYbxCj9HoSacVX+wzvgwX5AvRN
	 xmib1ZUXo21b2ZeoVj+iKNftc4wwIbukK4/bHpE07rDQbepEAyBK+34L3KZa7ap/QR3Ui
	 fxfTmw4pc9WvEuesZsVMp0v845c1FaL1IfrSBB32hkqpm2e/dmR1fnau+sqbC8XzPgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1gNZdM2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8F7606A320
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1gNZdM2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CBF1F000CB
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792431595;
	bh=8VPZkjdc8vUbwn23vxfk3djmQX72u5g+/jUxmmAER4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=T1gNZdM2br7hh15SWIer8laSE+LCoVsJC2XPN/8AdFGioUlL3u0WKCnwkaQklbNwn
	 aa8ucixNUscvnMrtntZJgfk5OQ+gUm/b0ZTnu5mkb6Qro8Rz6M9PiOSZ6awh1BnWOD
	 nAnts3NE2QZjrOgfLy8BH7fbWuELzzY0+s76EHFZWNmdrXgMXWdIRv5CR6+5jHw6I3
	 /A+2Wv18YkLO0Hw91CGLm0dsuHwYvxHQjhYMNSEiBJ7HjV1z99OoPOW6A581SI90GO
	 dgIuikzheUIQ7h5zOv0zuAUkcmkiIEIG4E9wSW/HzYtxKPmlARauzUsq4RDy1TiLOo
	 pElbVuQXcC9Mg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-483c607ccb4so1485405fac.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:39:55 -0700 (PDT)
X-Gm-Message-State: AFq9FYIttub53/dlwgxaaCbqg6XbzHldgCtccx0iGuYnN5srdwp4TOam
	cttQ5qRqjPbucuMU/zaEHMG4Y4TRhQZqQVKVU7jzJmrEqnXSRVhUTUo2xYi/RXTMS5oijnytlq5
	+7vCCTMX06RH8L7BhSB509xBioi9d6og=
X-Received: by 2002:a05:6870:8e0a:b0:4a2:ddba:c59 with SMTP id
 586e51a60fabf-4a7579e4421mr6513102fac.21.1792431594614; Mon, 19 Oct 2026
 10:39:54 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019140337.2886875-1-idosch@nvidia.com> <20261019140337.2886875-3-idosch@nvidia.com>
In-Reply-To: <20261019140337.2886875-3-idosch@nvidia.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 19 Oct 2026 19:39:42 +0200
X-Gmail-Original-Message-ID: <CAL4Wiir-o7W-XmrZBRN9UK3R7=KQzWDJ+kf3NNh6QanwMHSYkw@mail.gmail.com>
X-Gm-Features: AclHuK88Tcv30DyyUf2CgIzwUi9cdhNCXUM4oiY5ae2QtuoxcUkjaQ-R7VRTaBc
Message-ID: <CAL4Wiir-o7W-XmrZBRN9UK3R7=KQzWDJ+kf3NNh6QanwMHSYkw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests: netdevsim: Add FIB notification tests
 for nexthop objects
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	andrew+netdev@lunn.ch, petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 19 oct. 2026 =C3=A0 16:05, Ido Schimmel <idosch@nvidia.com> a =C3=
=A9crit :
>
> Add IPv4 and IPv6 test cases that program a route that uses a nexthop
> object and check that two notifications are emitted for it, with the
> second one carrying the RTM_F_TRAP flag.
>
> The new route_nexthop_check() helper follows the same pattern as the
> existing route_{addition,deletion,replacement}_check() helpers.
>
> Without "ipv6: Hold RCU when emitting route hardware flags
> notification", the IPv6 test case passes, but triggers suspicious RCU
> usage splats. The IPv4 test case is added for completeness.
>
> Assisted-by: LLM
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
