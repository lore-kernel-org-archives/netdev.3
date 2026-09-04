Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB99407CF6
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511904; cv=none; b=ttQvawrg2omwyT+lni4zJeOSgdh5+PrN1epLYMeexKC/NxS/Yr1dA9Yb0TLFvVh1WQu7QK+C3oBVtvLAst2ZY8KCLgdhnkkcBGuZkGciS2MRQq60albZ/xOsNIvjycScs5v1ttfMth21YwR67BD2R8ixdE7i1X8S3T8r6KD0mJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511904; c=relaxed/simple;
	bh=bcla8FCL5pVhdmX3lvYc2op5w63vyIeCniXSQqa+3i8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F+u0KuPySKhCu5K+wbdRQClh30G27Ugnl9C+67aKQX/8CIiF0OiXX9o1L/kZOz1swtBQLvrF6pwuXKms0/MJ2QaiATPPrf0yP8Z2XFx0U/7IsLz4AnvHe1jYlZ7MtK49cOicUm7wv4jnMNLH+xXWI2AOhxiw8XR7hi2q7gTaw4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org; spf=pass smtp.mailfrom=sverdlin.org; dkim=pass (2048-bit key) header.d=sverdlin.org header.i=@sverdlin.org header.b=ljWXFw/5; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=g6V+hr65; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sverdlin.org header.i=@sverdlin.org header.b="ljWXFw/5";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="g6V+hr65"
DKIM-Signature: a=rsa-sha256; b=ljWXFw/59jJsalIAiULC84K7q1pvZc6WcJztLbJ5ETb2E8qGtYhRSHqozd5JDeptVvT1lab1Y34Jcr15hnmzNyiZoXaBs1Q7yKYD4d3BlZMS4BqnIksmRO7GEux3pkSlb3iMWPySOWgH6l3g86hDX1HeBUOQuhRID6p1/oEvNXnWdilNb/5YIhl6eBzB5FUO1VAuvKTxaIp2KSlmFmIhNQC6ucx0ZPetHrPn2Qzx6T6k47cyspnHN1CcOvqnXpitbEEfO7fIAsDczZwxZMAZqUmf2BS6ghmOlHhP5qAXbbwX2JFauA+cGtybc2pJLqAMaTLyixvMzwMZpH07Y5GaCw==; s=purelymail3; d=sverdlin.org; v=1; bh=bcla8FCL5pVhdmX3lvYc2op5w63vyIeCniXSQqa+3i8=; h=Received:Subject:From:To:Date;
DKIM-Signature: a=rsa-sha256; b=g6V+hr65yLMhvj/k/yF1hWeafiK5Xk8dqPbN+0bPG8eVruPnjVTxitIc7tWJ+i24qzdOKQAoOcq2eZpfomIwb0U6ZjwmG3x7nhdd0luDuRwNoYYQqsMeRPMulWUDwSB9YEjDq9BPfcQX2PQGg92yem/1C+xXuZWFBb51nKcVKE4nCXn9KVHfa34fE/5wfrfjvNYYrgUoM+U2ErKZZvTilKEoSfq5vu0pcyDa8O8Bzy7sqjkxZ9nToxrh8HY6D0PPqcNA0H1BzBaXgNVUcZnxPfazujDo28SpnGBLUPeq2i1TOAbSofzy2tzIWykkX3/rlI5x8BXAM+/XnQxSaeXyhA==; s=purelymail3; d=purelymail.com; v=1; bh=bcla8FCL5pVhdmX3lvYc2op5w63vyIeCniXSQqa+3i8=; h=Feedback-ID:Received:Subject:From:To:Date;
Feedback-ID: 815097:39668:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 349704320;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 04 Sep 2026 08:51:40 +0000 (UTC)
Message-ID: <e2c9f5a8fdbb68fe9e6f795640f41e0292b236bb.camel@sverdlin.org>
Subject: Re: [PATCH net-next 13/33] net: dsa: lan9303: mdio: Remove comma
 after sentinel-entry in match-table
From: Alexander Sverdlin <alex@sverdlin.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 04 Sep 2026 10:51:40 +0200
In-Reply-To: <20260904043724.2955444-14-s-vadapalli@ti.com>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
	 <20260904043724.2955444-14-s-vadapalli@ti.com>
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
> =C2=A0drivers/net/dsa/lan9303_mdio.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/dsa/lan9303_mdio.c b/drivers/net/dsa/lan9303_mdi=
o.c
> index 0ac4857e5ee8..d3b5062905b1 100644
> --- a/drivers/net/dsa/lan9303_mdio.c
> +++ b/drivers/net/dsa/lan9303_mdio.c
> @@ -157,7 +157,7 @@ static void lan9303_mdio_shutdown(struct mdio_device =
*mdiodev)
> =C2=A0static const struct of_device_id lan9303_mdio_of_match[] =3D {
> =C2=A0	{ .compatible =3D "smsc,lan9303-mdio" },
> =C2=A0	{ .compatible =3D "microchip,lan9354-mdio" },
> -	{ /* sentinel */ },
> +	{ /* sentinel */ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, lan9303_mdio_of_match);
