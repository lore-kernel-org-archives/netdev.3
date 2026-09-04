Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63B408035
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511693; cv=none; b=M7X1hKwtbSU/9HN/JrXWkm6LErzztlL6YeJXLNR2WfpFBC9HbVmu7rW2o8VzJJQjMUcQ68CZvkPQq70PwLfNUhjqPI/JmcEqpXjQEmA6YHMbBU12f5rFtZN94RZP3O4jhKgkIhzwr/1SpR2pAqK1caSCKsZf1fD0XY4zoUA+7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511693; c=relaxed/simple;
	bh=XnBBG6ir6fVOMX775oB7i/w4/SR4joQ9qDcp/WWzSTQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TUM/rG7kqgrZekaVZd+Cj2Ja2RhionuMGolH6xfnOF63rRGYegGitybZhiggEkV6oYfNP3/WOUW9L6o9q4QeB93v+RUsvkZt30cFV9qMcL4e+3kWoCHlu2/Q26wltkTeKJYySOlqmCud9BZJOjvo9R7gpu1aVxtgk7/K9F3WihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org; spf=pass smtp.mailfrom=sverdlin.org; dkim=pass (2048-bit key) header.d=sverdlin.org header.i=@sverdlin.org header.b=K4S+YlPe; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=knD4+JQN; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sverdlin.org header.i=@sverdlin.org header.b="K4S+YlPe";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="knD4+JQN"
DKIM-Signature: a=rsa-sha256; b=K4S+YlPeJUSgzMJiQ3ekJzCapzqja5yvGnZt5A1yc4cggvCdQteYxN3M1cJiYOMRKNohplCCkkDqzqh4JO0bw6hebYA1UMHwcy6wns5fB0ZSWcNbgOh27PPm1hO0xVf7DKVr13OMx+STz4HFfG3FMBxHx0WES1mYixW4PvXq+BQd+2c7xmAyuwOj2q/c+ed419IqDqDBKCKMSaDbo/jDHBDd6zn28N1usfdd6wRH4Ow8GJBpe5Eem6O0DaF8Ed7TONZMSDMFtBTKMtKWYhh8wpRiD5hFPXq1az+iWM5I9e/1VVHipzzD0r+0GUJH74TV0QIiV/GYmKtTOiDmFbzLvQ==; s=purelymail3; d=sverdlin.org; v=1; bh=XnBBG6ir6fVOMX775oB7i/w4/SR4joQ9qDcp/WWzSTQ=; h=Received:Subject:From:To:Date;
DKIM-Signature: a=rsa-sha256; b=knD4+JQNfBNFFpGoyoyVn/43uMAqjtirPZM4iQUAmngfYwEHWzFG3dGNTdIYwvgKbvjAEA7pmcVJlSZTsxlLFJEfE00a0S2N9dpN07q73414gwkNfIWRSWH1XhqW+797YOzklbZmm6g3k9hzbEmRXwk2k7+vsLvKRZyKqpZbB0P1dGinZIDRsqzVVEaoITrLla3UInviWxGaDjn871SVoO/5cAfObt9m5M9PAqZrQ8U6qMDf0YF4SFBKkLpGLho2i4x6+N/TM1ZNZ7JXb8Vz5xLKWW9LVTYRnTeVv3YLxX2mYAGj8QbuUY2XwJdpTSq9JkVgcUTxBfs3hWZ+ztSLBQ==; s=purelymail3; d=purelymail.com; v=1; bh=XnBBG6ir6fVOMX775oB7i/w4/SR4joQ9qDcp/WWzSTQ=; h=Feedback-ID:Received:Subject:From:To:Date;
Feedback-ID: 815097:39668:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -935562145;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 04 Sep 2026 08:48:08 +0000 (UTC)
Message-ID: <4f3629686f834ffa8c6698a41fafda5b74b5de12.camel@sverdlin.org>
Subject: Re: [PATCH net-next 17/33] net: dsa: mv88e6060: Remove comma after
 sentinel-entry in match-table
From: Alexander Sverdlin <alex@sverdlin.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 04 Sep 2026 10:48:08 +0200
In-Reply-To: <20260904043724.2955444-18-s-vadapalli@ti.com>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
	 <20260904043724.2955444-18-s-vadapalli@ti.com>
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
> =C2=A0drivers/net/dsa/mv88e6060.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
> index 9c8ac14cd4f5..64bf3d759d17 100644
> --- a/drivers/net/dsa/mv88e6060.c
> +++ b/drivers/net/dsa/mv88e6060.c
> @@ -362,7 +362,7 @@ static const struct of_device_id mv88e6060_of_match[]=
 =3D {
> =C2=A0	{
> =C2=A0		.compatible =3D "marvell,mv88e6060",
> =C2=A0	},
> -	{ /* sentinel */ },
> +	{ /* sentinel */ }
> =C2=A0};
> =C2=A0
> =C2=A0static struct mdio_driver mv88e6060_driver =3D {
