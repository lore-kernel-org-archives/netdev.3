Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A7384CDD;
	Thu, 30 Jul 2026 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442245; cv=none; b=Uyz1cIuJHzNRi1J4D7Fc1dkQeYab9CYNkTroxoAWw1VUM1GvyOjsioW2kK63I+vGxZDhFHGEEtmeoE+OUI/TLLvJQ/23YLILQhxuqjpRyFY4/8vsJp9SS8z5Zs7UCKOlyHXBS0a/NXKT3popTdk37u47f+oqRAExFP8X8uaknf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442245; c=relaxed/simple;
	bh=7CkqkO124DyUKoB/FOEN+pVFfKm2UeI+TBJtslv8qPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8Qjz59t+Evc+T1e7VIFSDj5FiRpHvq9x6P3JvszGmtEJoAkchYyUVwsjcyOYs23pY9Q2zSzxX+DYxkWo54TXCG7lWfnBMtKtAD5ki99E1Begjr24/1t5+YBBOmukhPUYkOd566zmNLTilgdI9xSbdjpZEStGsrkUGraXXIoL88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKjuKMT2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKjuKMT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9941F000E9;
	Thu, 30 Jul 2026 20:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785442238;
	bh=sokq5D7tI+T6oijSo/RXj4RLHZm270EHMfSXqBxtpdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GKjuKMT2OGLzF6EwLDZzZiZlCPDNuXzonsXiQQBADZ7Zg9je+xB6t/802/s45ZN/J
	 2QYABUoM2JDYkus4bNYaXhTm8uR5r+wfpW3mdbDA+q9G3prX4isOKIrl+YhtyNmBwI
	 EuNXdVxHqxhWvaH3pIzVvqGgLy3gbPuG6H+a0soVJ1gFDH+CpaexXOCTwYOB09Fa0G
	 GR9AKUDAq8O0TfPWZD3IoUhzP9ivrdM9BduBIXqcZvFQU0G+aY6nscgC403AKpLaHV
	 qk4+sNOrCZT4ST1V+1Kelql6IBYWny3kiVCYZbtL+5uvq6icjkNGP4g/cg6YRydkub
	 KIOWdhidtPh0A==
Date: Thu, 30 Jul 2026 13:10:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>, Qingfang Deng
 <dqfext@gmail.com>, SkyLake Huang <SkyLake.Huang@mediatek.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 5/6] net: phy: mediatek: add calibration
 logic for AN7581
Message-ID: <20260730131037.3d7c4eaa@kernel.org>
In-Reply-To: <20260724190811.198339-6-ansuelsmth@gmail.com>
References: <20260724190811.198339-1-ansuelsmth@gmail.com>
	<20260724190811.198339-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 21:08:08 +0200 Christian Marangi wrote:
> Airoha AN7581 require dedicated calibration and specific tuneup to make
> the Ethernet port work on specific HW PCB layout.
> 
> The calibration process is similar to Mediatek PHY but Airoha PHY use
> Software calibration process instead of making use of EFUSE.
> 
> It does also require some complex table for TX Amp compensation and
> multiple register settings for EEE and 10/100M to correctly work.
> Also the PHY apply a different TX Amp compensation table based on the
> SoC PDIDR version. Such version info is stored in the SCU SoC registers.
> 
> Add module version as suggested by Airoha to identify the calibration logic
> with a specific version.

Build warning here:

../drivers/net/phy/mediatek/airoha-ge-soc.c:1508:3: warning: variable 'shared' is uninitialized when used here [-Wuninitialized]
 1508 |                 shared->phydev_p0 = phydev;
      |                 ^~~~~~

Sashiko/Gemini has some other review comments so please check before
reposting:
https://sashiko.dev/#/patchset/20260724190811.198339-6-ansuelsmth@gmail.com
