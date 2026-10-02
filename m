Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9564DAFB5
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957314; cv=none; b=hHMAhIwZx/Kf1McPgc+lIzumFWiWS622Vj5Vrfy9lZUv7BYJnjFFw6JHkVcJDooldRiRy6Y2DFnTpRW5Jzf342qlWpEaMoDiHvtG3eutQpNTp4LgBcHlMCLHF2DcbaQV6ctLNZC5rNn4RmAv+gcSYFMe6gV104mAzpXWm02D95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957314; c=relaxed/simple;
	bh=1QYQQnDrB7PAjzhAF72VLNqWW9giadAEvUdmZOgL8ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kn28xHOw1CdYfeC166yBIS86tJGootof/qWE84nNZETcZv0W2br5AVjbFhrOG8A/QwbDs+7ZzgEO9vpLWbKDJh9MUytz6XgEkVPfnbYlth6TG+he46Yf5HasXYATN6RLEJMF4BCyaiSYBqdD2k0CsmQ9SHRXRwoLKNfvGq9xAKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=eQOmPX3a; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="eQOmPX3a"
Received: by dvalin.narfation.org (Postfix) id 9BCF31FEA4;
	Fri, 02 Oct 2026 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790956793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1q56wVicCIloc+W4nKmUHYzwS/UjZUx+5MI4DSCe5A=;
	b=eQOmPX3aFxFzhcddhOT4Bmk7VKAlD7QEgRhS2mbiu5636n8A3dru+TWaHbaRwt3bWcEDyp
	Ax4Q4h4T4NRXkI3jjP5n4lA4kyJhl8YqvOu+YJLsrTMcVoGSPhM5N/RcWGIBC9Q9t6PkOi
	Aq/NYh+vNBOjIK5t2PMBAxr2KBxkyCc=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject:
 Re: [PATCH net-next 1/9] batman-adv: bla: avoid double free after failed
 backbone_hash alloc
Date: Fri, 02 Oct 2026 17:59:50 +0200
Message-ID: <2427933.ElGaqSPkdT@sven-desktop>
In-Reply-To: <179084942612.434549.483028329310521943@kernel.org>
References:
 <20260930094558.3723766-2-sw@simonwunderlich.de>
 <179084942612.434549.483028329310521943@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5106887.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart5106887.GXAFRqVoOG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Fri, 02 Oct 2026 17:59:50 +0200
Message-ID: <2427933.ElGaqSPkdT@sven-desktop>
In-Reply-To: <179084942612.434549.483028329310521943@kernel.org>
MIME-Version: 1.0

On Thursday, 1 October 2026 12:10:26 CEST netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Medium]
> 
> Can this sequence actually happen? batadv_bla_init() has only one
> caller, batadv_mesh_init(), and when it fails that function jumps past
> batadv_bla_free():

Even when trying to get sashiko to stop complaining about something, the other 
Sashiko instance will just complain about the opposite:

https://sashiko.dev/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=6

Regards,
	Sven
--nextPart5106887.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCar/U9gAKCRBND3cr0xT1
y/4kAP4kuH/5O3QRxPjxIrzpsKnwdB5IbO5OR4G5ThyIU32qMAD/SW4QPrjupRd6
oJ3/EfQRQz8LFi5MnDT7s+vBXEf1aQ0=
=6dmz
-----END PGP SIGNATURE-----

--nextPart5106887.GXAFRqVoOG--



