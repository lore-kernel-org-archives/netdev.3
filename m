Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F929D294;
	Sat, 17 Oct 2026 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200258; cv=none; b=S0VA3v8DN1vEVbn84AR0UokMbWRNGCLAOiiUneSQ9crO7JLm5qXIIFkD0X9CT4gVAS+O0OB2cdqou6TQAwnmdbMbyXz6kfCisTy1ZwoQPh/PBFUW5JZcQR+RFmtHE43x73weWRln9VC7ryV9dAnVw0aG7l6EUme3lXg9QENZGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200258; c=relaxed/simple;
	bh=WQUisSeF0O0LuNkimUFVjMwO1jyGnluPFHK1gQPwZWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPrlDKhpd8BOVFx9UY5gtTP8TsXkDoyxL0RJLvDa7sVfCh17qnMVan7q8CFJf3om5UsjI1ZysZDtaUrTj44XYFaFKGpqQ57IjokKW6VFmNBu3UmgPm2j/5xjRg3mouAxCVYK0mUFUymGH9/hZYXqmOiMRn7EI1GicEx7MK2Qjr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRMc6DTd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRMc6DTd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8004C1F000C4;
	Sat, 17 Oct 2026 01:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792200256;
	bh=5Hcz/1d7zm5VCEh69lD6eE40r3K8pPLFoAq0gPGeRko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cRMc6DTdzvgslpWqD0zfs8kIyJRQCWP7kgPDFuWM26VPBW1QJJmairHdhwSp1s9Bh
	 KuuKIVUOrlFrk7EsycirAjZV/mUzZls0bLdAOFvgW7nVgSaIv73kMWQnmn1FDZbFh4
	 VnfL27KKV6O/U/InS2aDwhR3plij6XD6C64r0UGRe4Xj4nXiyYtNyb27xaYLJFGSN5
	 pnQDnBQO6wFUfCbreXP74TSvpetT7pbD2XYrRv6hjHNnfZuF3RCMPJ/7OMkLRDiRUh
	 GMh8Nx8rHDBumMzIjaS7ld7SSU1JxoEHLbAKBQDvMTByje68J5cR8fcIz+tWAfCKzh
	 cbcTqKtcW+8vg==
Date: Fri, 16 Oct 2026 18:24:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Justin Chen <justin.chen@broadcom.com>,
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>, Florian Fainelli
 <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v5 7/8] net: bcmgenet: allow the MTU to be
 changed
Message-ID: <20261016182415.73f4f7e4@kernel.org>
In-Reply-To: <20261013-nb-genet-mtu-nn-v2-v5-7-076b6fc240be@tipi-net.de>
References: <20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be@tipi-net.de>
	<20261013-nb-genet-mtu-nn-v2-v5-7-076b6fc240be@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 16:20:36 +0200 Nicolai Buchwitz wrote:
> +	ret = bcmgenet_init_dma(priv, true);
> +	if (ret) {
> +		/* Retry the size that was allocated a moment ago */
> +		WRITE_ONCE(dev->mtu, old_mtu);
> +		priv->rx_buf_len = bcmgenet_rx_buf_len(old_mtu);
> +		bcmgenet_set_mtu_regs(priv, old_mtu);
> +		if (bcmgenet_init_dma(priv, true)) {

This will fail under memory pressure leaving the device inoperable.

> +	priv->datapath_up = true;

Hallmark of a bad design
