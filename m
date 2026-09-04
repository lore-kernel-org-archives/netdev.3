Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318931E840
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511661; cv=none; b=i9UhukPsSz/iigTwKYDVZz4ciJ3TuhuVOnNKWAXQgiyp8H7G5WwMaVWtozG/7owG2KejnM8+8t/LTPJOio/B8wy+8SARgqPgfbM8qP9s6eEm38uQkznRxSW3PEUOU2lIAMDgijnY0aZaKmN4Z+yolGruuDSdpJ6bdfuX6k4MYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511661; c=relaxed/simple;
	bh=JVNNIcGyXhA8QOSHP8rQNopOqo2m8XJ2n869xK0uHMY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dkFqkNBsC1dsic6GQETvrxncfeEgyf9hEo7plxhGXu7RRy67xEZJiKwkHxucOybL9f1r5mac8lnV8m9LG7oaJvCiVd4ZGRN7+aQRHzhjoaC4w6yCu1p7wAb54rnhtMvYd7hT8pl7a3PhOEqU3Pe2NKyJxM+n9i1t9AlzAVCs4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org; spf=pass smtp.mailfrom=sverdlin.org; dkim=pass (2048-bit key) header.d=sverdlin.org header.i=@sverdlin.org header.b=hnmvtf/H; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=HZ2xoTsM; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sverdlin.org header.i=@sverdlin.org header.b="hnmvtf/H";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="HZ2xoTsM"
DKIM-Signature: a=rsa-sha256; b=hnmvtf/HUYwJ90qT8fABvEythiJ4ILL0usBtKUbrrRRtO8DCJRFA8O1BZyctio0y9N93qEY7yovJCpzRngtXdqD7BqQzFtKWO5LtY7F4mt7I0N6l2z9PQ6r7kgCPf9WRYoLYIbdRK1KXOQRCwrxLWEHRWyz2u5SVEvOJyyjc579HBhqkgaV/+/bfMgqk2wS4ycQfJKayVfLhvNrWnjtiAd9HnX94856Wo9zOmgIl0HGkWRiyi10WMX8ULzkg7H4BJ/6AuYOtb4DRX+MuDJK3kSnWrfGlWmrgYu5GrR3C+L/OZMiNAK5E86tyOaktu72oXpD0EtZly3Jla/N/wcxKyQ==; s=purelymail3; d=sverdlin.org; v=1; bh=JVNNIcGyXhA8QOSHP8rQNopOqo2m8XJ2n869xK0uHMY=; h=Received:Subject:From:To:Date;
DKIM-Signature: a=rsa-sha256; b=HZ2xoTsMUpG6lhq0VPbJi5ab9HdYS1lzZXe4FzK7Qo6E5d6drTWEVu4vWmM2nnxtq4cpGAYnywj3uwiPsoFH0BQ76lILtFxPHDmG8g7KZgFlzlmwWpAPvHlmUMVc+2ITU18f3wKgBQ29OR8hgeTV7JmbvW/npTG3JE+r/6epZCeqgm9nGcXWqeMyrVKelRnSkINfQi3nLgzWD9A9eIkdghclUNLty2gj0h+q1rywOxqMpv5tBFipHrVUmyqKuNcLceMCfRk7l+m37Cb6F+BlqYKd/wO7nJqRJBAKqCYSLd95upv7sGMmTpey8d6DUrFL1lA0w8joxOYx9F1DwltmBg==; s=purelymail3; d=purelymail.com; v=1; bh=JVNNIcGyXhA8QOSHP8rQNopOqo2m8XJ2n869xK0uHMY=; h=Feedback-ID:Received:Subject:From:To:Date;
Feedback-ID: 815097:39668:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -277384512;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 04 Sep 2026 08:47:36 +0000 (UTC)
Message-ID: <398cb835c1ccd7889b832753beb408ba25c1c2c9.camel@sverdlin.org>
Subject: Re: [PATCH net-next 18/33] net: dsa: mv88e6xxx: Remove comma after
 sentinel-entry in match-table
From: Alexander Sverdlin <alex@sverdlin.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 04 Sep 2026 10:47:37 +0200
In-Reply-To: <20260904043724.2955444-19-s-vadapalli@ti.com>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
	 <20260904043724.2955444-19-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-04 at 10:06 +0530, Siddharth Vadapalli wrote:
> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>=20
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Alexander Sverdlin <alex@sverdlin.org>

> ---
> =C2=A0drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx=
/chip.c
> index 80b877c74513..f8aa93e9ee18 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -7513,7 +7513,7 @@ static const struct of_device_id mv88e6xxx_of_match=
[] =3D {
> =C2=A0		.compatible =3D "marvell,mv88e6250",
> =C2=A0		.data =3D &mv88e6xxx_table[MV88E6250],
> =C2=A0	},
> -	{ /* sentinel */ },
> +	{ /* sentinel */ }
> =C2=A0};
> =C2=A0
> =C2=A0MODULE_DEVICE_TABLE(of, mv88e6xxx_of_match);
