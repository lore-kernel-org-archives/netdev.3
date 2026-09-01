Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400F472530
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303111; cv=none; b=Eiop7Qc8c+Lnz73mUXs2Gd059m6TcHe/RBEpa2h8dalGpvJThg6+b0WsNs060gnqFlAlKb2JppwAeazLJL/DSBx9V/k4GJ1JDn91SoCtqe3kgnG3uTY+o61e/vd6KmchaojdXVkJ2POm8q3lesRkI4F+1pdXLOKo12lHfeX7+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303111; c=relaxed/simple;
	bh=/5lOoQn/mDsstA1mXTaR80FDLGOQtUfHPCMBsmFrSww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHoVhUU2OvPPwW37P1CnJOMHi/5mEV7Azj6agU/Vz8+rKtl7h/7AfM/65QwgGokptrOX1OfDdw6zvpyOq1m//QAwlQuCRIJbyU+QzPIdXo/PUCItIyUYx40InewTg2/bvk7SSw53JBCWwb5nboLFr4Tl286Q+snPTSbPYigNj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQThtlyQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQThtlyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F631F000E9;
	Tue,  1 Sep 2026 22:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788303109;
	bh=04PQ7PwF8BwN6+0AXT4/IL5HT3xsLobMDaNacAj5NkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SQThtlyQ4zDD+cS/sbBwwuqRFHzYRt56VPLNSg5fq4ECwPze1vrjXimCU31TwrGOb
	 o9LfH8/CNIBdAEryGZaE9jaC4+p8iR2Rxga/SvNPmZkyrEM9n6Rp15ZthUoT8CYW1H
	 eybNSPKXFkVu8UkxJLXPGOpDF5wIFql1J5phyvb2vNRYkR8ImfUQWTOipuRKXXO6Oc
	 ZwdR+4bogAlXXZa1+NnK5S+W8kYJ2Yn/N/oIvDRnaCwuVlApL51lV7UzEkBVdNZFmZ
	 ie7Fy9wo8fLVqxr8ICUgvIARpaySm3pnOxcLh24Em7YLascNLbxOJGC7o4j4rA4yCD
	 +vD9ZsdcnA2LQ==
Date: Tue, 1 Sep 2026 15:51:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin =?UTF-8?B?SmFixa9yZWs=?= <martin.jaburek@suse.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com, Fernando Fernandez
 Mancera <fmancera@suse.de>
Subject: Re: [PATCH net-next] selftests: net: add IPv4 and IPv6 same scope
 address order check
Message-ID: <20260901155148.48043e16@kernel.org>
In-Reply-To: <20260901082200.15570-1-martin.jaburek@suse.com>
References: <20260901082200.15570-1-martin.jaburek@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue,  1 Sep 2026 10:22:00 +0200 Martin Jab=C5=AFrek wrote:
> Introduce two new tests `ipv4_verify_addr_order` and
> `ipv6_verify_addr_order`, to check the ordering of
> a set of IP addresses after insertion.

Please fix pylint --disable=3DR and ruff check warnings in your code
(unfortunately there are some pre-existing ones here, ignore them).
