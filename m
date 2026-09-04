Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11523A1E96
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511966; cv=none; b=YzKLsxCISLaqYoL+o4SV4LYWc6YaN1j8FDNF2STmPOGFWEGk3VuaB/Ka1yYzzSrPqyCzASVi4l6bYsk+jszZhsO18ZFgW1OHTBT3EFYVX+kVY2qcV5v+ZzYjS3rUA8Nzkudxsp6y2eTkiZUz2iQtZrXcWyGbvBire5B7WDi8PzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511966; c=relaxed/simple;
	bh=HnB0lAGCE0d3Btp4LE6O95A8lBaMPULi091taEQF07k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sFSuwIUyhSW2V0neOcAbi6DkPM8Dpo/lQgaPOHqZB/97eUXLJg0+ITzoqRvwfDRQkQ01dfBhPI3Op3SWiGOWFuaz2BBiqdGQ2/SXMtP4d/xLm/XHw3peiUKjtuzUtASQFL0rxztEA/L9cr2o3EDg3rxP3CezgYkaHHHO8bzFBnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org; spf=pass smtp.mailfrom=sverdlin.org; dkim=pass (2048-bit key) header.d=sverdlin.org header.i=@sverdlin.org header.b=h1nUhaHm; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=jXEHfK9m; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sverdlin.org header.i=@sverdlin.org header.b="h1nUhaHm";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="jXEHfK9m"
DKIM-Signature: a=rsa-sha256; b=h1nUhaHmLcUC13QVRatY8aW2KFKsbo4ZAKoP63Aol8lhQ4ni66yCkCVvWZSjMQGOKvKP2ueutvCKvij8TPVtzZkpq6CM7kfWz2QawLnc9ncjFXAZHau2bIU4XlRknxoeWdjhae2UwrZ7ma/8CS2p6v3PN+LyHMI26o3PFyYpTABysj5DcqGKIV8stV/kcM2ixVHdMKT/IP4HS2tCKfw+1eTAsrRJkjsj6/mqIOploiGtzPiYiAckt5GFNkoT8m4IJOYpy94w7wycGgoddffMyOnUXceTLQHSja3Alotzb3bsmzAN6YgEn/3dCQmsWvXobM9fywPkPwO2yYiQ0LSTkA==; s=purelymail3; d=sverdlin.org; v=1; bh=HnB0lAGCE0d3Btp4LE6O95A8lBaMPULi091taEQF07k=; h=Received:Subject:From:To:Date;
DKIM-Signature: a=rsa-sha256; b=jXEHfK9msW0SOHZ407cTQuPKxyHMYl4OG9f7+unJWGgxxOHjqMkVBkRNO83+/d/LNMBaVRT/pKmHlk+yWLPfzbWC+EZAbrJTwGwu2tTigIkxaoUezBt2bwx9pOhfPzLh3pThRCKXb3kPj/ufGpGrJUPEGV8sIrDUU8FVPgRo4YepKLjHexg/7XaOvNPS/Sj4LqK7pLmNvYgTIwjht9ztT1DvAonajxAoEwxb5Q+j22Fu8UXYkTjaB72+vQ+lsqCOVKvojhNDbqB4wkQmas6Kjhvs8FYLIG2BNXNul2zrumlndnK5I6AgjrCD3D56KolMpZeVZvUuXdG6d9X1a+T9/g==; s=purelymail3; d=purelymail.com; v=1; bh=HnB0lAGCE0d3Btp4LE6O95A8lBaMPULi091taEQF07k=; h=Feedback-ID:Received:Subject:From:To:Date;
Feedback-ID: 815097:39668:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1817499062;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 04 Sep 2026 08:52:42 +0000 (UTC)
Message-ID: <a940ff02c74b190f566871ea7274aa7520551b59.camel@sverdlin.org>
Subject: Re: [PATCH net-next 14/33] net: dsa: mxl-gsw1xx: Remove comma after
 sentinel-entry in match-table
From: Alexander Sverdlin <alex@sverdlin.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 04 Sep 2026 10:52:43 +0200
In-Reply-To: <20260904043724.2955444-15-s-vadapalli@ti.com>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
	 <20260904043724.2955444-15-s-vadapalli@ti.com>
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
> =C2=A0drivers/net/dsa/lantiq/mxl-gsw1xx.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq=
/mxl-gsw1xx.c
> index a1104b2f92a9..347e16e9fdc1 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> @@ -918,7 +918,7 @@ static const struct of_device_id gsw1xx_of_match[] =
=3D {
> =C2=A0	{ .compatible =3D "maxlinear,gsw140", .data =3D &gsw140_data },
> =C2=A0	{ .compatible =3D "maxlinear,gsw141", .data =3D &gsw141_data },
> =C2=A0	{ .compatible =3D "maxlinear,gsw145", .data =3D &gsw140_data },
> -	{ /* sentinel */ },
> +	{ /* sentinel */ }
> =C2=A0};
> =C2=A0
> =C2=A0MODULE_DEVICE_TABLE(of, gsw1xx_of_match);
