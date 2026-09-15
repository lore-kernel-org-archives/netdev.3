Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD323D291;
	Tue, 15 Sep 2026 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789432318; cv=none; b=IE1NaQ/+tiyokvMbYvBGjaqSCTqBBalg7x5MPrCbclZYgD1zX8mArDkGQLXFdbhaPQ+usTnBAAq9yuS5HlGBgvqFQIfRpoxouT6wyB6aS9bp0V4bFp0zyJSlUUtBGQjzfvDtL+jdDXWeAPWBQ/iaB/wBFfDTbZlPJ6i9A4W0rc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789432318; c=relaxed/simple;
	bh=sY6bMaTpXESau2d/M75SaU1PfxkMpDynyb6srGQeOvw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPwmMopsosL0a10EA/uoJA8m6huXSFO+NCihfUw5NnAla1z2yWngn4MwuUFqPaMfSHZjBmQ4tTCG8LALoDuMiGdiQKK9xvI/KE8GavilV/dThnX4A4Dem7mpHwMbnfwr+/DhpAbNVVPOUpAqd0Vd0Hwu359XrATyHXkv6RmWyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEL9vKIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEL9vKIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B304E1F000FF;
	Tue, 15 Sep 2026 00:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789432316;
	bh=UU45ueYNANHKCoTHCzynijqhx5gR1gE0okx2/IbB50Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aEL9vKIKtGBOJFuXt3VvZDz19kapRYQBSP5J1zmib9HW8wRqnixLn13geWAWk6Mfn
	 Dj8OK8vSqLa2mQrkqwKGsiY0rzMy8k/pzFvhyi0g+AX8t2v60p5FOtkMX/6/LThocZ
	 weQGLmbzChu6C94viQ6zvgGNc82AG77fi0rcrJK8CZMTh7/phUa0ar1O6cz2EhExil
	 +/fNwtg1nfaY2NB/ywpdsrGm+QxkMt/d0vQTQiEsc/9+EtcH64caeriP9kN6ZZ44fc
	 Zuj65EE+xNdqkPpffgqQ8eXhTcdMgvnuN+15uIauhOcWsLp8pWBXXGx+2pnteid8z9
	 c4yf298GvdXTg==
Date: Mon, 14 Sep 2026 17:31:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ali Firas <alishmery18@gmail.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 razor@blackwall.org, roopa@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/3] vxlan: vnifilter: account VNI node and per-CPU
 stats to memcg
Message-ID: <20260914173154.24b4f4a9@kernel.org>
In-Reply-To: <20260909092645.3105263-3-alishmery18@gmail.com>
References: <20260907141001.GA708129@shredder>
	<20260909092645.3105263-1-alishmery18@gmail.com>
	<20260909092645.3105263-3-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 12:26:44 +0300 Ali Firas wrote:
> -	vninode->stats = netdev_alloc_pcpu_stats(struct vxlan_vni_stats_pcpu);
> +	vninode->stats = __netdev_alloc_pcpu_stats(struct vxlan_vni_stats_pcpu,
> +						   GFP_KERNEL_ACCOUNT);

You can make netdev_alloc_pcpu_stats() use _ACCOUNT, I reckon.
Again, no Fixes tag needed here, this is really not a serious issue.
