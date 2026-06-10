Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC633D512
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102001; cv=none; b=V+7O9rTzZqBH8feTn4WDRvXKbNfNAf4Q38hJW2L3/uI7AUQCkfb/8L7D6aMFj2D/U4CFqU6Scz7/YQqxw8c9IMpJx3T5Z9hQughdBkMw92D0IHvc11SQgrVYVJOGrVXPqUJ5IJqhPM7/zHh9V0rQQ1ykZyo3G9V6mDck8MF74pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102001; c=relaxed/simple;
	bh=KtLqtw29AM5Ta1AihRVyjUJTyXQ+b+M7+YM7RlpLZTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YE/tQTxlVJ9B9bUEx5VJsNx9mJkRvapeWEM+JWnQAaOW+KSMDbBkLeLf073TR6iryfZok815W4yOyzl4l5JD70duFQXPAltBglSJGfOryAFTpVmmXyWvHbvB8fepouE8cOOMod4F45CIjty42DpatkCBA+QySKD8THChseHr06E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvoB3DhY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvoB3DhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCECE1F00893;
	Wed, 10 Jun 2026 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781101999;
	bh=Fia8PofUXKD2hlmVvWSxA9/AR8mvTDrBL93VXEWtVU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OvoB3DhYOGe/3hJLc4FpwRXLA39aJ9je9c6TluVLLy91v7Qo5Jd1CKpvZMitX+Mri
	 gLNNjLJDvrlMTD9fCXXDeuj9V6h8DFpukv9sJIOuCoaZD3wNDFNnuDjWy+TjuF9J7e
	 wF+BDMhPBlLoMxVjYiuYj/ZDcMEDkEWiARLgyBgwCej/JxbnKXPwD+PFFhvmM3m+wR
	 AlMRRhzhtlgsfk0dcbN0Y+WGOplaxwcSlzi+F8FTGXYbsFiaijnih8x/jCF80VEtmI
	 JjuWriyOHIVS7wXh7j4Y4zs7lIgb1LVfSC1JHY45pnWQhd7tyE35CwkKEhtcKZxsee
	 mafobteXgwJ0w==
Date: Wed, 10 Jun 2026 07:33:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>, Ralf Lici
 <ralf@mandelbit.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 0/6] pull request: fixes for ovpn 2026-06-08
Message-ID: <20260610073318.4a28ba31@kernel.org>
In-Reply-To: <20260608150741.3320919-1-antonio@openvpn.net>
References: <20260608150741.3320919-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jun 2026 17:07:31 +0200 Antonio Quartulli wrote:
> Please pull or let me know of any issue!

The SoB checker says:

Commit 588d0d2cb66a ("selftests/net: ovpn: fix getaddrinfo memory leak in ovpn_parse_remote()")
	committer Signed-off-by missing
	author email:    yanlonglong@kylinos.cn
	committer email: antonio@openvpn.net
	Signed-off-by: longlong yan <yanlonglong@kylinos.cn>

Commit b19512620b80 ("ovpn: hold peer before scheduling keepalive work")
	committer Signed-off-by missing
	author email:    shuvampandey1@gmail.com
	committer email: antonio@openvpn.net
	Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>

Errors in tree with Signed-off-by, please fix!
