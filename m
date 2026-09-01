Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CDA486E67
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281934; cv=none; b=r8KoVqNKa3x4jiJOJklr1boJ5CmMGvQGt3BZONLYLJD7qirhRcH34I8YJF/aNbX1RG0HqAJmHptaDgb5FwPzlFHbp0ArwJlGbZixIcxBdoP0r2UmwNsJBg2CnAFk4OUFm/IBiVptqhYRK4oCRC0afrm5L/SDn/fcegoMXayQQAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281934; c=relaxed/simple;
	bh=uIz5rx1K/SA43HGILAi5upIgcqW6ki0nGezHroACuMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9GLKN9GlDeD5Tajvt3BX1MpaPz0AAYIIaT5z4epZxjGnr57HGmylTDzEBhSxPSiaW9DcHFWkpiNc3AN/5KeKUfIWbyjtmhhaYPJiD+O/KWeCMP08m4T8puPF4fQVycBzf3MPUtrsp8dp8F+m3jZhDcxkLCkH9EdIG+yo0Yus1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=2Apw/sTX; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="2Apw/sTX"
Received: by dvalin.narfation.org (Postfix) id 9F4E320514;
	Tue, 01 Sep 2026 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788281926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DtZ2AI+Q2XbfLWjnjRO3xCWrHcosBhGIgl6xdZITc90=;
	b=2Apw/sTX66lMNmRexvDC5FBqxbtLYmr7kwwm8I3Fj4bct1BJsZHD6Y+yCYTCWlpEz9r5vh
	nbetMyO5KQ3xqRmYfpBnLYTZNB/Ha6ZFCCSDE48AbPnq4vtBvQrxyq2BZR4kVVZD4db7Wv
	3TfRe4PH2DCrYxz+e6baRl1iEXX0x1M=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 netdev@vger.kernel.org
Subject:
 Re: [PATCH net-next 03/15] batman-adv: bat_v: fix bonding candidate selection
Date: Tue, 01 Sep 2026 18:58:44 +0200
Message-ID: <7993419.EvYhyI6sBW@sven-desktop>
In-Reply-To: <20260901135959.23F6C1F000E9@smtp.kernel.org>
References:
 <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-4-sw@simonwunderlich.de>
 <20260901135959.23F6C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3975166.kQq0lBPeGt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3975166.kQq0lBPeGt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Date: Tue, 01 Sep 2026 18:58:44 +0200
Message-ID: <7993419.EvYhyI6sBW@sven-desktop>
In-Reply-To: <20260901135959.23F6C1F000E9@smtp.kernel.org>
MIME-Version: 1.0

On Tuesday, 1 September 2026 15:59:58 CEST sashiko-bot@kernel.org wrote:
> [Severity: High]
> This isn't a bug introduced by this patch, but does the throughput comparison
> in batadv_v_neigh_cmp() overflow?
> 
> In batadv_v_neigh_cmp(), we have:
> 
>     ret = ifinfo1->bat_v.throughput - ifinfo2->bat_v.throughput;
> 
> If an interface is provisioned with a throughput override via netlink that
> exceeds the signed 32-bit maximum (2,147,483,647), subtracting a low or zero
> throughput interface from it causes this unsigned subtraction to overflow.
> 
> The result is implicitly cast to a signed 32-bit integer, turning it negative.
> 
> Will returning a negative value here incorrectly signal to callers that the
> optimal high-throughput path is worse, causing the mesh routing to prefer
> suboptimal or zero-throughput paths instead?

Out-of-scope for this patch. It isn't even touched in this patch.

Document it for interested contributors in 
https://www.open-mesh.org/issues/470

Regards,
	Sven
--nextPart3975166.kQq0lBPeGt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcERAAKCRBND3cr0xT1
yw81AQCey2BgJHvde7tyg158eax7jbXQh+8leL5KknCd7tYc2wEAopvjq+gzqPKH
x4ME2Xv7/8tJnODhVKFSaD7pW0v74AE=
=oJf0
-----END PGP SIGNATURE-----

--nextPart3975166.kQq0lBPeGt--



