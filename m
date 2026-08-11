Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8208136EA98;
	Tue, 11 Aug 2026 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434432; cv=none; b=DF6FPAa6ZNorMNpueXNC8nxziQn1OT55XMJcu/u7ggaMq4qmH2SscjlsKgwZNNTR+SVt1Kya3N4fr9sscEuHaDC8dj7ZFmNKfzutpRkJSfr4MXLXvcN2X89A7Ejsa23LKuXFgbTejWOnUUeXoNCXi7Vaw104rX83cMnzvpFOPXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434432; c=relaxed/simple;
	bh=+QCK5Qihpkqt3y4Ae/K5pIwq9DgY6Rn4MzCxoPHZvxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWojQ1hGUoxKrXhcSeZ2Vck7l/VZCURfbF9yQgJbVSVa/L6STP3obLnh0opSaHNKUZTjf0SnUFBr/WleyL25aQ0veHBx68gzru2kow5xEq/m3KOPFdzNx0U56YRf0LJ8Ry6MPDbB9LcoUfeIbdDW+FVkvJgv22ctgmLOYN9ghls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+mH3Mbe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+mH3Mbe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24181F000E9;
	Tue, 11 Aug 2026 07:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786434430;
	bh=+QCK5Qihpkqt3y4Ae/K5pIwq9DgY6Rn4MzCxoPHZvxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L+mH3MbeWxRuXyfRluwmePo17Fn2kvPvjuV18TgBKKb7lpLulonJefqDPidbdGilV
	 SlsgacejIQtagQTar87WxmjevVWQt5xvUvd743198kvMHot3f/edFaEE0/9lIE5/3n
	 qiykarziPHKFxzGVFJKd//TGMC6WPiAUgqmZX/YVF+18kAzjOm83FL4ONPe4qMCL8A
	 3k0Sk3FsESI1SVACKmK2hjwwKdk2wEmVbRWlQ4m2usZp2+qWT9qeMYHCJMply1BnL2
	 t/x66OQMGQgbIsdX1jYoR+qJZkIipy6v+8tPb6ekNFe4QFNegvCuHQDvoeWCg7KiS5
	 rhYVxgMWUi1QQ==
Date: Tue, 11 Aug 2026 09:47:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: David Heidelberg <david@ixit.cz>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Luca Weiss <luca.weiss@fairphone.com>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev
Subject: Re: [PATCH v4 4/6] nfc: s3fwrn5: enable the PVDD supply
Message-ID: <20260811-simple-impetuous-caribou-1f8596@quoll>
References: <20260807021001.239389-1-jorijnvdgraaf@catcrafts.net>
 <20260807021001.239389-5-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807021001.239389-5-jorijnvdgraaf@catcrafts.net>

On Fri, Aug 07, 2026 at 04:09:59AM +0200, Jorijn van der Graaf wrote:
> The controller is powered by an externally switched PVDD rail. Get and
> enable it in the i2c phy probe, before any of the chip's pins is driven
> or its clock started, so the chip's power does not depend on whatever
> state the bootloader or platform left the rail in. Boards that do not
> describe the supply resolve to a dummy regulator, so the existing users
> keep working; they gain the regulator core's dummy-supply warning until
> their DTs describe the rail.

Last sentence is redundant - we know how regulator framework works.

What is not redundant and missing is why UART variants do not need
supply.

Best regards,
Krzysztof

