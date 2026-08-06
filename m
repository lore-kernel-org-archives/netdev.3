Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B313988FA
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027802; cv=none; b=sVubTmTaw+NVDTJTUVxMXtM2DeNCBlWLDsQYSrG7fqBmlepjfNR6RTS9aH6hejHp+UDhEZthh9aOEi4ctP3P39cqc9I5CxtRP+stOgt3y3DZcPUpq+Cg2iuQHlZjN5HMz3VLtbiMdyDHnqSdy0Rgso0Kwqgt5fn0py/VqAWEXDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027802; c=relaxed/simple;
	bh=wU3Zo8eLf+pl0uq+rU4WpSbveeXAvh6zUHJqb1ND/50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9/Wx0qTN8Q8iDBFBk5tW/vtUxSmRq9bd1Hm0IaqvRnmHpHSVxhQwQLdgrtxEW6OwrQjYS2d1k+aHrgGxIPk+re9I+DmjhLMnu9uSx1ZIIMAyv5OUmZlyRJpFYruX0p+IT1DGaocEaSrxpM/QhOv66+jIjvbJ9X6woMkMk3asyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=qUGQ5KUo; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="qUGQ5KUo"
Received: by dvalin.narfation.org (Postfix) id CF837200D8;
	Thu, 06 Aug 2026 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786027787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nk2LetbE720VUwdle8IicEzzXoq1sgzpA9D6ECbMgKo=;
	b=qUGQ5KUoTXO6cSsCUvSD8mojzSCKzUF8shS0R9gMFVVqy6Bbk+NWMuMvh5ErOH7XjWy2aQ
	rn9L+cOqodI3fG44wguNJAW1yqhhBzq3UOL2HP9OPC4Z622fR4nf4tzOuePE1nvc2LSV8Y
	7feWK12VKiZF59W6JswvCDafZ25n6ms=
From: Sven Eckelmann <sven@narfation.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Subject:
 Re: [PATCH net-next 00/15] pull request for net-next: batman-adv 2026-07-28
Date: Thu, 06 Aug 2026 16:49:40 +0200
Message-ID: <13090442.O9o76ZdvQC@sven-desktop>
In-Reply-To: <991957eb-65d1-4b3b-b903-76459127c124@redhat.com>
References:
 <20260728133918.643267-1-sw@simonwunderlich.de> <3386526.aV6nBDHxoP@sven-l14>
 <991957eb-65d1-4b3b-b903-76459127c124@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6161773.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart6161773.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 06 Aug 2026 16:49:40 +0200
Message-ID: <13090442.O9o76ZdvQC@sven-desktop>
In-Reply-To: <991957eb-65d1-4b3b-b903-76459127c124@redhat.com>
MIME-Version: 1.0

On Tuesday, 4 August 2026 15:16:54 CEST Paolo Abeni wrote:
> Please be aware of net-next commit c82ff94592fb: the expectation is that
> submitters reply proactively to AI review comments.
> 
> Specifically it would be helpful an evaluation of how critical is
> problem reported and if it could safely addressed with a follow-up.
> 

You sashiko instance is not sending out mails and AFAIK, there is no mbox 
download button for the Sashiko "replies". It is therefore a little bit 
inconvenient to reply to something which is just on some website.

I just wanted to go through all the accusations in 
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805143200.722098-1-sw%40simonwunderlich.de

Regards,
	Sven
--nextPart6161773.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanSfBAAKCRBND3cr0xT1
y/JaAP9kbzFvnPeTMwGKyBLlt6CYOZnJ7rJsp4UkHgKz3EVY1gEA33wM9ZOGl/Yb
Hz0MjjnZh5yY5541p9On6dsgRjqt5Qc=
=htMl
-----END PGP SIGNATURE-----

--nextPart6161773.DvuYhMxLoT--



