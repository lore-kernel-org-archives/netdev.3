Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41782233927;
	Wed, 17 Jun 2026 23:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781739191; cv=none; b=Y0ur+QkYbVpttYmuxMWXk87i7EnwizztBo5VsYSYggBaWib6cHLa3wP4IYCGc8BqzvQ8V3Ymw84FUr2lz/m9g3fUjEutk0Bgm6mtbXojvClNaqb4q3sqenTcIM10Gkd1pZRn1/VB0k54AkSJTEeDaGpoG5D9kPAkOVRugR7szM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781739191; c=relaxed/simple;
	bh=gSRScAjoNruAA7mK7nwgGLD94bj30iuT3rfSfEN3ER8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnjtwDYjxKrDgA8h2rR95xXy5JeE39zFsR332502Sw1+CTGsA/KjiW2O3/zpFHSUrDPadDuHhZM/+ZonBMBd5IbWIuyUUjtQQkrrsJmKxO61h6rq703+ILnXqQgJbjEgWlG9ui44aCQXVYfEoAbKHMYb+ucaPHAYqB/8y1QjqKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe2T3+LF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe2T3+LF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F221F000E9;
	Wed, 17 Jun 2026 23:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781739189;
	bh=YWz9pOu0z95gQdi03IszD/naS9Day5Wu/VQ664au8oQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Pe2T3+LFNY/fMa5+jNaVg3nuepf49NwYd1eFHOXe7WNCx44+Rhd8XCwnBuBwC5Byl
	 S6VIAfVAH7k76Mt/B9tR9yCiYTb5VlON0K/TfSk0XPlgpEGZc1KOXC8F5QvdM7WTQK
	 OWKPRWJQ9KEPhz9mS8FWUutuXEaV08xwV1+nKSb1Kzcm+7xPHEcButWaHcxEA2lyEU
	 vdgFWRnAQoTZQBTFl93kiXD6l2jpyGS6b/VaO+BPwNNtzb/ZFsd+P2o75vLz9GTR15
	 1SahyIPrdFybmbc72ehxAPkeMouxkrGhqtNQchnuWFSNZ0q2MsJFeXYv4NV4FNCtDe
	 vgS5lRWxjd30Q==
Date: Wed, 17 Jun 2026 16:33:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tn40xx: fix netdev and NAPI leak in probe error
 paths
Message-ID: <20260617163308.2a6fb097@kernel.org>
In-Reply-To: <20260615064256.1068059-1-zhaojinming@uniontech.com>
References: <20260615064256.1068059-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 14:42:56 +0800 ZhaoJinming wrote:
> In tn40_probe(), after tn40_netdev_alloc() and netif_napi_add() succeed,
> none of the subsequent error paths call netif_napi_del() or free_netdev()
> to undo these operations.  On any probe failure after netif_napi_add() the
> NAPI structure (embedded in the netdev private data) remains on the
> per-netdev napi_list while the backing memory is never freed, causing:

it's devm_ allocated:

	ndev = devm_alloc_etherdev(&pdev->dev, sizeof(struct tn40_priv));

you're introducing a bug instead of fixing one..
-- 
pw-bot: reject
pv-bot: slop
