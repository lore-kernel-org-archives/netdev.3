Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB843CC32E
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789911997; cv=pass; b=LGzj88ayTR/XU5vycJfyLNpzzPni3VLiHut8ZKqNzVWgiuKLez5C7da0/E0V7cggtCUcU6GaCiEElb1SEo98DWYwDpRFazw5Y676IUQTS75+2vRViFz6bpKFGzY89mi0OSN9Maf6niqEAftwWDNQ3EgZytFjiEhg3XUerXTyuyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789911997; c=relaxed/simple;
	bh=GoKI1vGXcJ5D1y2Jg3o1IYUMORpwmXPIfiEF6PR9g3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAlNQ0suqKq4F6UPqjD7/NajunZWdkumfnyfRGb7SRWiekPxbvgK8Twl5QFOv4u8B86rpp2IYmu/GyZrr7Xskv2sd3UDw9IRoLT86rPVpZBD0xWb6bCftC4jCyfsZc2KwfpKJRKrlIoCCiMevC6+Y+EqkzOCsSIfuM+OKuJyDf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQXPeLnv; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQXPeLnv"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8686f46e4adso1859589b3a.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 06:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789911996; cv=none;
        d=google.com; s=arc-20260327;
        b=e77HnHyhY/ei24PSp8n6gD61xr+Z00Y+Ppv0VewZd/G7a9aw+edo4OXb84kxUF/i59
         JVHB3eGFpBxdBRb+y3VRNAEC3ER9ROkKLK9hOFfbwgTikh+48JKeM5P2SkHe1rww34Z6
         b8PjU4Go5E/C/czpyvVEWWRtDven597lUG89TfPCbLXi88dplkQTbfe6FtnU4LWbCJQa
         bYu9gL9hoIGw+8gJYDGS9VPqwvf7yB/6W6gCN04fxxcGGOGlG4ZL7SFybZPTQZAv2+Mv
         HG4stoFu4++rRkRw81hENkeACbjJgsJ9GgSS4sBU7rDa3ZEqRcG4bl80eYOr/jOIxDLM
         nA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5JNQACwxf15rHzWmS7EKSzA7iMkUpodW8goKbzSEnsE=;
        fh=lf0R9wIDpVO9+yiUiVRion1XjMy904G9NuZPz4MUHjI=;
        b=Oq3b88AOo0+TGRrjaH+tJO07gVDQfit+mA5UFBUMgGztGgTNFbUiG3P3layI8EYyGx
         RNq5HLVT66QIHBIBARGZFrz5fwpzv55wu4IcyopqolNFJr08jAzr2UYJxZT56op7m35m
         RdjXcrKAhXCqgTO8wEYFTvEqT7kR3VjyBPESWcb9BVz+H9+NBXCqUiDlTXkSbdVRUvQA
         w94ko4h7kVOXsn9W2bUXY1TCEgGlLpmTLvu7uIB5N/vY9nao0wVXrDqVbCldF8XnyvBo
         EyTTsMOBYYqEu1D7KA6abx6ve7SI2iupanPPtjnWA1SnmmFpkgOCLwo8GLxKdkkOkn9z
         kIRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789911996; x=1790516796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5JNQACwxf15rHzWmS7EKSzA7iMkUpodW8goKbzSEnsE=;
        b=oQXPeLnvcyvFlsCH7w6hqYEZJw8GZuzE7mD4T2hIHLp9VIEC8P60sCcHXVGnt5JKRr
         yXP+ejIohVMtP7prjM3qg6uVCBtMDJuHtiG45FKd842F434B+vvCyshdSC25uFtQJGTs
         w+BskJZNeLaLsd+MAtozjYq29e+1sfkQ8OQxAisowFiynTtapdReG8JtJh3OEcWUr4Zj
         4oih3Bf8hNc6+f8iCV9rOQNQOreViPiOm2Yrn/gOIrFTTbGIh9iu7PAti7tGCnhTDkxk
         JPmxL9quP5TyDM3FSoxbdJv5vEP3ySVBZEeIhdBcOmlU+PzNhPIW0z2pj9za6AJojvJz
         jYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789911996; x=1790516796;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5JNQACwxf15rHzWmS7EKSzA7iMkUpodW8goKbzSEnsE=;
        b=vSh7s2HmTxcbth7AhSsXRM+kbnZ7f8BaEyYW17RmXZzZGePTKSBCK3C39RIYpBiZU/
         aUNrai1YJC4mtwcNcHYIodWckWlLtE73d0YeDHQyTiK8zoNRzdyiTxv77I+ET2lbNVNh
         BfWCd4yKGtekkD8/SlM2iV3REj5xZyjv/eTTGZEqKaEwJPGU6+mb3dGCoIRoPPBpTNHR
         SyYpD7NycPk1GIf0Vok0h/pOYLCYavDCOieZ24JAbSfL5XOHiHQlzF4/DfcxuMvNe0Fz
         Q9gBclr0Sqy1lo8xI/viZnTjqaBfW97lgvjQsEny/vP6cO7/TZp0iZhHnjx9+0fLc1C/
         /wdQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4qCs86UmUJieW5GlIKlSIVK4wVWzkkfNfEENFM47aFAs6Jqtht2b6mpzXNHKgOfw1D7C2B5k=@vger.kernel.org
X-Gm-Message-State: AFuF++n44zutG1cgGHWKcdenVd2J5wMJq9mT7K/9BphO20JzJe45rAVR
	XC/fqbJr3j77lRdcwVU1Zgn0ymoGrG6bS5TSd3ZBRTqIe36Ck2gLuCOwvdjz2WbcIy5e3mNa10N
	gyJjn4FUejOqhGFmeOLQOHBZKOV5oocg=
X-Gm-Gg: AYBFou1zq9+uQcDYv4IuGpZdPet/SB31zLovw1h6m3BLiusYQXgBTM+55vEX1yU6qI9
	nsFXJ1AAt9ANdLJXxECEP0yjhhFCGS/PYDbqCY9M+dYpzl7AEvqxGo0g/FpwmN/ZasHZLgLhNpZ
	grSfUbBOr2Xa6Td/8EIc7NO+CbGVyc/s8abiynA8CoFl/HcDEbgWyTeAnoJJWMRWmn0Jyo+TLiG
	2W6ZO/y1tnoTXfx74CyR8b1Y4WUQGqbdY9ql7viyo6zyLakMuWp/xO0ghXy50PWWk2lTy3b24nT
	CMikymnT10P4vhT6ev4l3tH1sW8d+9F9lMh6D7uidymyRkPcEEryt7uYpdXdlnmXZpw=
X-Received: by 2002:a05:6a00:2789:b0:869:427:9b0b with SMTP id
 d2e1a72fcca58-874db4f4e46mr11966028b3a.1.1789911995534; Sun, 20 Sep 2026
 06:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918151405.716075-1-adrianox@gmail.com> <20260920063412.GA1777922@shredder>
In-Reply-To: <20260920063412.GA1777922@shredder>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Sun, 20 Sep 2026 10:46:24 -0300
X-Gm-Features: AcwNN1XjX2H1M9YCBSMoOuH9mbeQ4Rr2lvNNteqbG_O4Z_sKSwLPOSPuqscgf8w
Message-ID: <CAMGU2hXurKGhL5rhDQnT6uTKST=YhzQCuC5yHKZOpnmdV+vxRg@mail.gmail.com>
Subject: Re: [PATCH] ipv6: check per-interface proxy_ndp in forwarding and NA paths
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It does not hit any of the current selftests, but it would be possible to w=
rite
one that would currently not proxy NDPs, I think the following config in th=
e
current code:

net.ipv6.conf.all.forwarding=3D1
net.ipv6.conf.eth0.proxy_ndp=3D1     # all.proxy_ndp =3D=3D 0
ip -6 neigh add proxy 2001:db8::100 dev eth0

makes the initial multicast NS work but the subsequent unicast NS do not.


El dom, 20 sept 2026 a las 3:34, Ido Schimmel (<idosch@nvidia.com>) escribi=
=C3=B3:
>
> On Fri, Sep 18, 2026 at 12:14:05PM -0300, Adriano Cordova wrote:
> > proxy_ndp can be enabled per interface, with net.ipv6.conf.all.proxy_nd=
p
> > as a global default. ndisc_recv_ns() checks both, but ip6_forward() and
> > ndisc_recv_na() check only the global value. With the per-interface pro=
xy
> > ndp set and the global one left at 0, the router answers proxy NS but
> > does not pass NDP messages to the proxied target.
> >
> > Check both values at these two sites, as ndisc_recv_ns() already does.
> >
> > Fixes: fbea49e1e240 ("[IPV6] NDISC: Add proxy_ndp sysctl.")
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
>
> Do you have an actual use case for this? Changing a 20 years old user
> visible behavior for the sole reason of removing a TODO comment is not
> good practice.
