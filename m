Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD23ACEEC;
	Wed, 10 Jun 2026 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080278; cv=none; b=N65SWzdzt/xL4HZ3eAPau4PmuK3mFHLfRMMofEuQ3Q+iTd7LfzRkKWswSe6J7S1iz8KUdhizfOKKN1ScqCJCAk+jO8sr2BDlqZVtdCWNHPD9ruDwqq9OEFkbZvgecGBzJbG/N0H2vKwu2/ENKWE/K52m6+IfQ/4+LWS9LQH04ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080278; c=relaxed/simple;
	bh=jTI+HIFny4/bth3PyE7ERPfvANuDmHYLce9vqdQxTKE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dmUOIGWwwT18+rbIqtKCe0CO5b3n6Ci0ZBwPrXbbmgTEM+8BO4ZpokXxREpbkTFCeEyE3iSfawt5fCCnb8LIJcNLySh9yD+kGrnSxdDSR51pGeUvx+wNHUu8rBeIpEn78MVeva5IQs1HTHOSlXMty42Co71ny6cTuVbuuF4LGEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lWvP8vUk; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lWvP8vUk"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gZzWZ5yN8z9tr7;
	Wed, 10 Jun 2026 10:31:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781080266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Klrgs6S1L7vyN25nRg842jZqnd2p9mAU1kL/Okh4r2g=;
	b=lWvP8vUk+/Yq1piLALsm6ZrhFiE/iK7HqSXmQgTgi4Dpy1HU8z/83dIVf8wKs96VjYHyJ3
	SqCHixavV22sESbcCmwqckKzLsEeuYnFJQu2Uz/KSqUnosc7ezrLnKiFDEuVz8uReoRGf+
	w554SrnIpV3EY2HkBwvcEFPFWG1OiJxAip1KqbUGCizfB/5v7vcruIrI+0fMU/POWYR0Ia
	NTB51AUPmn7rUYGaAr+XAhEqOVvXa/YB0VLmD4yCrt0DLT+tcldvs63gdP4SBUJmsv7BEe
	jpt9DsneikbnvYusyCMr+X3lvVb7uy5ENCkH1r2Np/V77g07FXLi6rMvknOj4w==
Message-ID: <c80c7ad9aa48dca8799ed2e76b1628aa7bec92b0.camel@mailbox.org>
Subject: Re: [PATCH net-next] i40e: Use common error handling code in
 i40e_register_auxiliary_dev()
From: Manuel Ebner <manuelebner@mailbox.org>
To: Markus Elfring <Markus.Elfring@web.de>,
 intel-wired-lan@lists.osuosl.org, 	netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Przemek Kitszel	 <przemyslaw.kitszel@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>,  Tony Nguyen
 <anthony.l.nguyen@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Wed, 10 Jun 2026 10:30:59 +0200
In-Reply-To: <f0b4e354-9ed7-43f5-8ffe-97019e421c02@web.de>
References: <f0b4e354-9ed7-43f5-8ffe-97019e421c02@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 9bb7a79ae9e476ce094
X-MBO-RS-META: inxwp8m3dr45e16ycngz46gfm9ofxwch

On Wed, 2026-06-10 at 10:20 +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 10 Jun 2026 10:02:58 +0200
>=20
> [...]
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c
> b/drivers/net/ethernet/intel/i40e/i40e_client.c
> index 84a97ca8a6d8..389b8b83afbd 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
> @@ -304,15 +304,15 @@ static int i40e_register_auxiliary_dev(struct i40e_=
info *ldev,
> const char *name)
> =C2=A0	ldev->aux_dev =3D aux_dev;
> =C2=A0
> =C2=A0	ret =3D ida_alloc(&i40e_client_ida, GFP_KERNEL);
> -	if (ret < 0) {
> -		kfree(i40e_aux_dev);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto free_aux_dev;
> +
> =C2=A0	aux_dev->id =3D ret;
> =C2=A0
> =C2=A0	ret =3D auxiliary_device_init(aux_dev);
> =C2=A0	if (ret < 0) {
> =C2=A0		ida_free(&i40e_client_ida, aux_dev->id);
> +free_aux_dev:
> =C2=A0		kfree(i40e_aux_dev);
> =C2=A0		return ret;
why do you do this? There's no functional change, right?
is it just readability?

Thanks
 Manuel
