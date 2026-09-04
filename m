Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531423F12F9
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511521; cv=none; b=MadvNcOVMAi8qRc/7oL4NS7yhq37FuVJN29DCu5NhuEvkQhcK24/9hhKM8lnTZpE0CxKfTQBEexpXtlARRKdpHSpTP5fDdaKkHY4os8SE0wz++6hL6GPhHd1o1ZjRd0m5DEOwEe4BWMRnuFYu5cGnXV4AoO2iObfEKGBB5ZPIR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511521; c=relaxed/simple;
	bh=RsHVk47pfRw/X0BzJydKqenz2Cyy9riFK5FXM/cyiZo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L+uuW9kOJmXc00kIkrJV09A/jR0DxSOG7/Bu8jBPHEZA853q7OszxSKStBi2kyYGy8QTDO6Po1XRvlz+JYUfoElQk0cji2dJlpZ7x6WOTf6RgYZwva08Z+nv60fRMRrS2ux0yHkEw/54jGhq8qkOInl6auEyV20JKOa8ZpWAD4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org; spf=pass smtp.mailfrom=sverdlin.org; dkim=pass (2048-bit key) header.d=sverdlin.org header.i=@sverdlin.org header.b=EkxvcqXJ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=HEyT7cF+; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sverdlin.org header.i=@sverdlin.org header.b="EkxvcqXJ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="HEyT7cF+"
DKIM-Signature: a=rsa-sha256; b=EkxvcqXJUotED2akpKr+G9sc1HM5mP3STjAjPDxMepMj9gsfZ3uWb9gAfKbj7V2aoVFUqs1hbtw0aAQR1dxnccEQy3i6ho6oUXXN2pagiakk39oHQOiQlvB9goL003JPOG+ebQ991/2StDyB6bwR0Hxh79djxAOI2IxpLBp//bEcsb4dz48RX5KimB5bvjWD9djF7hUB3sdYOJ1Coha7C9RbYws6lO+p6/hmtBuXnRiuNGXQulsiWXfO/b5skJdO0isBeQgjufN8A8bQFAP+u2PBjiqijlWoroeNvOCatvCGQ3Kva8yNkQNMsxy6bvDT6ASHzXOzwQMOVFstkiVw+A==; s=purelymail3; d=sverdlin.org; v=1; bh=RsHVk47pfRw/X0BzJydKqenz2Cyy9riFK5FXM/cyiZo=; h=Received:Subject:From:To:Date;
DKIM-Signature: a=rsa-sha256; b=HEyT7cF+hrmZBr/5K5M8Gtv0ijrESPhg2e+bjwirdYTly1pBPEXs6yIRqYm/R4n1XKb4RQydtHueQyRhdBdQbr3vLaRuxGHGSRWxTkM6nX82DlSftnKHvvPoWpIHEWPAIPglWdOPWeSih5knaTC7cAUYgxUM6IQcxJIlO03o9TPaaik6+72+MXIKhn5/T8Abdk2ZlajwUwLvHl3cSWnDSR869eThVwXTlzqVD9ukEfJvGs4peYvwLUSehKt5qsqZ48DEsnHPQOHidOxrIsle149AdsnoKlSzMjIc3VoIlz68kv0m7L/3Pmz3kJGCp+vEBILCBUlQusdypQbkr/RAxg==; s=purelymail3; d=purelymail.com; v=1; bh=RsHVk47pfRw/X0BzJydKqenz2Cyy9riFK5FXM/cyiZo=; h=Feedback-ID:Received:Subject:From:To:Date;
Feedback-ID: 815097:39668:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1559663149;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 04 Sep 2026 08:45:15 +0000 (UTC)
Message-ID: <ff52bd408755600284f1225f70c546e786035685.camel@sverdlin.org>
Subject: Re: [PATCH net-next 28/33] net: ethernet: ti: cpsw_new: Remove
 comma after sentinel-entry in match-table
From: Alexander Sverdlin <alex@sverdlin.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Date: Fri, 04 Sep 2026 10:45:15 +0200
In-Reply-To: <20260904043724.2955444-29-s-vadapalli@ti.com>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
	 <20260904043724.2955444-29-s-vadapalli@ti.com>
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
> =C2=A0drivers/net/ethernet/ti/cpsw_new.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti=
/cpsw_new.c
> index b6e25a4658d1..07832cad5e3c 100644
> --- a/drivers/net/ethernet/ti/cpsw_new.c
> +++ b/drivers/net/ethernet/ti/cpsw_new.c
> @@ -1875,7 +1875,7 @@ static const struct of_device_id cpsw_of_mtable[] =
=3D {
> =C2=A0	{ .compatible =3D "ti,am335x-cpsw-switch"},
> =C2=A0	{ .compatible =3D "ti,am4372-cpsw-switch"},
> =C2=A0	{ .compatible =3D "ti,dra7-cpsw-switch"},
> -	{ /* sentinel */ },
> +	{ /* sentinel */ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, cpsw_of_mtable);
