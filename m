Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44975257855;
	Mon,  3 Aug 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763168; cv=none; b=qn093ac2QiWveGJI8jqs1or4a1HlcHgGGP8aGtqhdv7UIphx0AJ/u/zfvFcH8aKGZHlIP2ynp8RA6HtaYsYnHeSt5i4OBJ29qIzdPjAwqj2QJ9ir7oW1dZUSNGrie9C3e+Vunf5RtcjsbbC7zz34vMQQpfyc6vZbRTa6wHykzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763168; c=relaxed/simple;
	bh=Ax0JclV9lBJSpt9yrcSnNhityxu0lRUfIckVcvx86y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XI4zMs/rRR0taFSnaXlCyf5WCia4Nv2824ryIw5q5BGq2wpnnkysACRRfnNFNMA1FPJ6I1QtgIog8vHkDfEOLoVV7MgAgUN2SHi+5h8Ot/U/BQtkmyv0083GMkLgVk+RI6gX5qr/rTdDDFUYTbIxBPt9W7NYh2Ku6XC2oRQaO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vvroB6fn; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vvroB6fn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=Ax0JclV9lBJSpt9yrcSnNhityxu0lRUfIckVcvx86y8=; b=vvroB6fnrTimG034vwrLmJghE4
	reSPD1LosE0S9NKy7XhQ6h+X7B9UXst88ZSsJT6nDP8BuW1OU4rI5VUhSRlQXTj7NPS4wUbcgYWEr
	QJsc+PSPH+pJxwtRKs9cZLn1u4hmWHLdwUbXW/woz5aVku03QA5N6aEUSbhAm3gHEMhm4SaR003XL
	fwWOXN4Cwdgjd5PEhQ9w4R8Ad/w4hlmfqbeLUXNnCx49x3UEdjnrL3c+3v32UJxl+txlA9//+AHCC
	5X3PLVQwubzv8Yp8pzCyyVVPTR377L1WDJYL/rNG5n7o+I9myZamn7Qkbtk9+/PEsU1DuJYt4kQqt
	q3BAgzAQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wqsZK-00CO11-3A;
	Mon, 03 Aug 2026 13:19:03 +0000
Date: Mon, 3 Aug 2026 06:18:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: macb: remove unused ENST Q0/Q1 time
 register defines
Message-ID: <anCVKleezh_5oWhS@gmail.com>
References: <20260803062834.3865755-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803062834.3865755-1-vineeth.karumanchi@amd.com>
X-Debian-User: leitao

On Mon, Aug 03, 2026 at 11:58:34AM +0530, Vineeth Karumanchi wrote:
> The ENST start/on/off time register definitions for Q0 and Q1 are not
> referenced anywhere in the driver. The driver calculates these register
> addresses from the ENST base offset and the queue index instead of using
> fixed defines, removing the unused macros.

The removal itself seems correct - I could not find a single user of the
six macros anywhere in the tree.

> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Breno Leitao <leitao@debian.org>
