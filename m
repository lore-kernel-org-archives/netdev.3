Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092171;
	b=vWviR6h/5rlcaOFVy1VB91tyVNpJVyfBbGtwAg41dPrqjwkgroPhIfxSOzvygKsSB8G4
	 2hx8Scoiyw86urdzy/rai88499kpbd5tMeGLj+a0qzNOcepwHCuz5LtXdwc+qLQ732+OV
	 Ym54d/XVz9LXKheJeZvPU0TKlzNaEyOFiPIj6P00F2H6qZ6YRAbfj2MglOAtK8Kd0BKS2
	 x3sewnHBYMWhdG+06//Mj/Wq7A+DoPJdmNFtAiRju7/iA73vOFOwfLHFR6oZ9GoYCZBGB
	 Y00pUcaU5GzquN1WrapaCwTUFfFJ1hh6Oqu7dvaZ/PLZT5w7f/GYXvXqqz67ZXChFWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092171;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VT3Y5OvSFbO9QB1vLrL/JDIAFG6W923q7UqKoS0saRw=;
	b=yY1SD7KENbEsXvDi+abVSOGdFQb8vPvVo396VSYKrdjvjTxHzSKp/Cojj3WLJ2DKmVcm
	 d2ZlGo7pl3HzFmHK7jAWE1vMG6Y1ctRlfdMGn9xKmNHYLyG0jdOTW1OVVvcGVdHk7UHHw
	 WF03XMw4lumoIr2BFNGCDRfJnOhP0fkXmpjI40Pxz1qSnX0kZaVRjOCtz/Tzf6AV5C+Ny
	 1bAHI3o7xFLhZgpDzD9+ACWs8bPCxbahp1Vt4wQSkUTDPwv2GbiV+37xjbwVQ1MPptFve
	 tPT9qE/SCYatCwy5t07WxxwISxPDQn88blke30fumt3YtM1tB7VNsaMAzMf3Sjjy/6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gL6g0cDE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3785606A321
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gL6g0cDE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692E71F031E5
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793092170;
	bh=VT3Y5OvSFbO9QB1vLrL/JDIAFG6W923q7UqKoS0saRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gL6g0cDE/fM1YcljoA1aZnBkluyETfSVdCPCFznt39+S1LfqX3W7PXafW2wNDlgYC
	 Hu+y4trakWqb+ewn7BqriCAIhkt0cawB9tPQ21k4vGD12sliSPExBxINuJxv2rQotr
	 vNDOCC/e1xCvkCGiWU8EzPqlORFljrhhZ2/AIe1AqHBZgJ2kp8cv2NPWpscdff3UUQ
	 vA8WqiGKhwBKQUj4QIKqzNunDhvnOAIJ4Kl6wTo1DiCt6gDREEwwCyQKCJkGGfTZpw
	 EBg/NC6iNMSupxIDQeZ2UmHxXbGEwAfzhWo5W6tsOVBigBCnOwL+4lY/WSBItmSvb3
	 AO3lKl6893s+Q==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ab07d956f2so25436671fa.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:09:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByZthv0QSqvWT8hoGyz9mgDezKKDx4c4HjadoGKmw7BPCaBTP/ifSdjsDy1QBO2nT832x87QAE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyrAHT3zCB9jzM/ltOFWmrSdq2gg5mXqFUQumiMOgf5+gKiLPg
	mLZUtuEHSkST+XvJBHTkE9S31zOxt4NhPpWG2tpCqcNTAZCKsDnHeK9lgh91z15SZSn3EMxZqrw
	wFaIiEcNW516wDinT7lLmfMIryDuHHZ4=
X-Received: by 2002:a05:651c:1444:b0:3ab:5423:dd80 with SMTP id
 38308e7fff4ca-3ac6fce6af2mr24493581fa.9.1793092169187; Tue, 27 Oct 2026
 02:09:29 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027085200.1501599-1-xiaolinkui@126.com>
In-Reply-To: <20261027085200.1501599-1-xiaolinkui@126.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 10:09:16 +0100
X-Gmail-Original-Message-ID: <CAL4WiioJcbB9gB7tbBcwLdRUPG=zX-5B-7G5=oMXGiy=f_WLSg@mail.gmail.com>
X-Gm-Features: AclHuK8EVwFrXUj1qFMsxab1jfMHpLxrzYP4DKEcT8xEm71gKtZLAmqWJRAV0jE
Message-ID: <CAL4WiioJcbB9gB7tbBcwLdRUPG=zX-5B-7G5=oMXGiy=f_WLSg@mail.gmail.com>
Subject: Re: [PATCH net] net: bridge: netlink: do not clear the vlan info dump error
To: Linkui Xiao <xiaolinkui@126.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linkui Xiao <xiaolinkui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 oct. 2026 =C3=A0 09:52, Linkui Xiao <xiaolinkui@126.com> a =C3=
=A9crit :
>
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>
> br_fill_ifinfo() assigns the result of br_fill_vlan_tunnel_info() over
> the result of br_fill_ifvlaninfo() or br_fill_ifvlaninfo_compressed()
> instead of only running the second helper when the first one succeeded.
>
> When the vlan information no longer fits in the skb but the port has no
> vlan mapped to a tunnel dst, br_fill_vlan_tunnel_info() walks the vlan
> list and returns 0 without touching the skb. The -EMSGSIZE is lost,
> br_fill_ifinfo() completes a message whose IFLA_AF_SPEC is truncated,
> and the dump carries on to the next interface instead of stopping, so
> userspace silently sees an incomplete vlan list.
>
> Only fill the tunnel information when the vlan information was filled
> successfully.
>
> This was flagged as a pre-existing issue in the Sashiko review of the
> net-next series, which noted that the VLAN fill result is overwritten
> before it is tested (see the Link tag below).
>
> Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
> Link: https://lore.kernel.org/bridge/ed1de95e-e112-4076-93f0-6f7668e657ad=
@blackwall.org/T/#u#5
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
