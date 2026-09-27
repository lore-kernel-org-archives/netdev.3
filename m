Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB6D3C0A0E
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549286; cv=none; b=bvOaJ8dlXNds3EACiF0k0Ivk1kqmeF7IQKLwGxxrFQugegGkcfQLSIk/Lg1T6AfIykFYaOHNagfo9yWjyKX2LxLJWWwasJVDm0yIVVyAtpcAU4Z/877EVchGNGNn4mAha7LAySFHe/DD6r6kjSgBwuN7lSGiAiv7ZalxmFpSdXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549286; c=relaxed/simple;
	bh=n6hooRnOnTgPCOA9TDYzmiq+CfHi3ISobseBdHl95cE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KweZkBGlbHtxP6Lr+IP0wGN+4hf3iF2nbqLZ1IiM4f/lSq1N5GGnMu/6Xx3Jj1G/TJRLxhRQwTNcMoh9xAeGD91iBDTiUea3185seexUnypZ1VRkOSY5xWEz4rm/EKn/U3JPYY/JElcpwb9CKKf5UZCQghIbCDEkpkqYOIKPCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9eQBPXg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9eQBPXg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEC71F000FF;
	Sun, 27 Sep 2026 22:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790549284;
	bh=FSQDvDenHDyD3FocPOdN7haa9926tMSzV+vKuh5i+x4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M9eQBPXgC2dwnlJtSc6JsNBxXeLTj0m3v871L8QzCmUVkfggTlO7bxhdo6INJhz7l
	 y/hdecCfn/xv2jSL2zukqjvI7dbrqtvsYBgW9gUy3uJaMpNYPwyj1MMiXNq/jj6FIL
	 2/i3SGcRG72ppvKRgOuGeNeGDrUgu/SHKnGzxr3KYbH3Kioe9vMp7XDbhb6dw9yiC8
	 /k42WyTPUwO8VhsbvbxHBWtUY+z5yYWhHabuhSBya5ge9KUQC3JAmd8nGgE3qEBPfp
	 hfhJTEKEZaz44YCzwKIHC+uKgdevOI1YPz6FOnmQ7Sz581Nhz7Q/YHM8/Jm6J7DdS6
	 PLhYExDsiHeEQ==
Date: Sun, 27 Sep 2026 15:48:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jari =?UTF-8?B?U2VwcMOkbMOk?= <jase@nocloud.org>
Cc: netdev@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 rkannoth@marvell.com, sbhatta@marvell.com, bbhushan2@marvell.com
Subject: Re: [PATCH net] octeontx2-pf: Fix RSS indirection table size
Message-ID: <20260927154803.4b4bdf35@kernel.org>
In-Reply-To: <175cbe50-741f-4e5d-9509-98dc4a8365a2@nocloud.org>
References: <175cbe50-741f-4e5d-9509-98dc4a8365a2@nocloud.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Sep 2026 12:14:37 +0300 Jari Sepp=C3=A4l=C3=A4 wrote:
>  -	rss->rss_size =3D sizeof(*rss->ind_tbl);
> +	rss->rss_size =3D ARRAY_SIZE(rss->ind_tbl);

The diff looks bungled up, could you send with git send-email or b4 ?
