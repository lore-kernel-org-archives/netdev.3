Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405E3D75DB;
	Thu, 30 Apr 2026 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534843; cv=none; b=g36izSmFp/vLgWrtSz533mpcX8YQZ6M4cYKSxCr/phD36mHTkO16pR8MX2em4bDaViw4K/F2UOFNCt+L6/t/93sjgDwHdPBeHVRJ5I4abUvC+TJUitu4xHdRmPB5oRLL4OFNLFdjsor9L/wwCDqKOMk0lZBKEmLyRn5FNShRba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534843; c=relaxed/simple;
	bh=DbpqhBgikFhqeanDTgbXWWTBesPdRJl4WMBazV9sP/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecBtzcyeHq6s28mtSHZedrMHCWDg4fwhCHvGM+PrvcdG/l0eww2c7xkxanIV4hRa1VpYRYLAMlmzpIyS0hQGA5B2KEgnHpauC+5qmiMLf8LJBljJjzM98vPm10q4cfQybIMgLup+BTpzt7f3dx31NdAiCsgtMiRuwwrKG9zTXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=R0rS2QeC; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="R0rS2QeC"
Received: by dvalin.narfation.org (Postfix) id 10CBB1FF65;
	Thu, 30 Apr 2026 07:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777534838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5T6Tm8mn1JHMRFC8Mtn+CMd8n0ePg2A3I4KI2l1PNA=;
	b=R0rS2QeCbZsX3riHy7LG7YuYAQ5vd7gYDMFY/W+HjoTIOOeNKyBh443kjjMRPmsJHpQvsO
	bxR5mog0StlF0o+J/ijdo4EmDu4rYIuxR3bAILL45VX37Y6AoiSG8AJ0R5aRkWd5XN6y86
	pqCP2QpjyJoSD8H9jgi4QHnqIyZZPMs=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Haoze Xie <royenheart@gmail.com>,
 Robert Garcia <rob_garcia@163.com>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <sw@simonwunderlich.de>,
 Robert Garcia <rob_garcia@163.com>, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Ao Zhou <n05ec@lzu.edu.cn>,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Antonio Quartulli <a@unstable.cc>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 Sven Eckelmann <sven@narfation.org>
Subject:
 Re: [PATCH 5.15.y] batman-adv: hold claim backbone gateways by reference
Date: Thu, 30 Apr 2026 09:40:34 +0200
Message-ID: <3609597.QJadu78ljV@ripper>
In-Reply-To: <1857579.VLH7GnMWUR@ripper>
References:
 <20260430071645.3030702-1-rob_garcia@163.com> <1857579.VLH7GnMWUR@ripper>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1959533.CQOukoFCf9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart1959533.CQOukoFCf9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Apr 2026 09:40:34 +0200
Message-ID: <3609597.QJadu78ljV@ripper>
In-Reply-To: <1857579.VLH7GnMWUR@ripper>
MIME-Version: 1.0

On Thursday, 30 April 2026 09:38:05 CEST Sven Eckelmann wrote:
> Sasha Levin <sashal@kernel.org> picked it up for 5.15.y (on Sun, 19 Apr 2026 
> 21:13:58 -0400, MsgId 20260419195610.batman-adv-5.15@kernel.org). 
> Yes, it was not yet published or 5.15 - so maybe fell through the cracks.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/5.15&id=6fd37208adf6771125b59e1ae0452561024be4e2

Regards,
	Sven
--nextPart1959533.CQOukoFCf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCafMHcgAKCRBND3cr0xT1
y7V/AP9BMH0S8bDU+veLaqdqd/7YjiL5klqj+wG7K6SUqPoNAQD/ZFycWLIHLcz3
YaivZtqG9mnJJkSDo399V/GNymYUZAk=
=lQ4+
-----END PGP SIGNATURE-----

--nextPart1959533.CQOukoFCf9--



