Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B854F1A76D0
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744184099; cv=none; b=ql/AoWh0qGj7qJ9++Y7ld2QgR9LSdgUzd4BTcSV89Z4c1Ky5bpHaPqrmJr567K5lb6lMFsBZAAcFVLXKSelG2AFwuiH0Kbbe13YTeaQUmzsFu6M8NGPhq/peIFXKXgZXnFQ9vJUd9aNglnS3XmOUBQUlQLnMNGGc1UYDPVWZXTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744184099; c=relaxed/simple;
	bh=3Rpg891z+3UjC27eUKE7G2ppuFvrdfEfv0QNyim7Iqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5oHztitIaHbzOmMSwVtg00PezgrpsBrSQwjzUvypShhRWvbkUNUp+l4TGo9WA5nri2J2x75u63cYSMDD0R0f/wpWctvNKDiDVh6zqAhBaVxy5HYQt3FZvOLOLKGrL2KxqMbmlRst5l2JXD60cOSSNHlRC8AkYTDUFh4qJUenls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Zuta+CwM; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Zuta+CwM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1744184095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Rpg891z+3UjC27eUKE7G2ppuFvrdfEfv0QNyim7Iqc=;
	b=Zuta+CwMISorjRBF7zGq1uKFk3ofzLC8qBKIeQWajRCKaOREUCQpMUEgk8oQ5qEhSiuhYI
	KYMOan7PrvtB6Hn/Uz4p3np9/r5CAyz9SqlhAGGraQDKnKUIAPXfxbupv5RJabKeQVK9+0
	mmsCMefY9RCHFTyy5wj9IDAxa+M6uY4=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Subject:
 Re: [PATCH net v2] batman-adv: Fix double-hold of meshif when getting enabled
Date: Wed, 09 Apr 2025 09:34:53 +0200
Message-ID: <2159357.usQuhbGJ8B@ripper>
In-Reply-To: <20250409073304.556841-1-sw@simonwunderlich.de>
References: <20250409073304.556841-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3680858.QJadu78ljV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3680858.QJadu78ljV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org
Date: Wed, 09 Apr 2025 09:34:53 +0200
Message-ID: <2159357.usQuhbGJ8B@ripper>
In-Reply-To: <20250409073304.556841-1-sw@simonwunderlich.de>
References: <20250409073304.556841-1-sw@simonwunderlich.de>
MIME-Version: 1.0

On Wednesday, 9 April 2025 09:33:04 CEST Simon Wunderlich wrote:
> ...

I think I will just go back to bed - nothing good can come from this day.
--nextPart3680858.QJadu78ljV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ/YjHQAKCRBND3cr0xT1
y1EEAQCfRd0boJbcgN7RfX1v0tTb0/lZfv6fHvSpnKx+9XAaUAD/S9mwtgrq4m8G
RBfw53Q6KWrIGSuFkc11DHEY+PnAXAw=
=/6oa
-----END PGP SIGNATURE-----

--nextPart3680858.QJadu78ljV--



