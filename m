Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE40283FC9;
	Mon, 16 Mar 2026 23:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705379; cv=none; b=COLICHOSDzT3IHaEgdbGNuKdAHA7byWo5eDqtoGOUoszm4JrelD4ux+xv0SVHp4oQxwV0WU/perNTVjlzabLA3qlQhx2RIpE9VMO45/ddkDttFJLw6u994cFetxIxyyi17ln77L++hTXY+Uuj4Q8K9XTH6bkvDeNDR5PMO6aox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705379; c=relaxed/simple;
	bh=DgUYXuvJ86+JYxo2mtsIoUEvcAZLFFLbFq+gNWjLwRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhQwqItUVcau3+Trl8FuLvCjF3EjwGkbvwZNC99fSKICMeVfr2umrI7ExMHO4k5ZcHO7R6M5rS+3iZzsoVdsOuCA8w4x46FOmzM2AtzwfxIB2LeK11r0jDlSzb+W48gXvVH0F9KFbXbyU2afkNuwxbrq/GQ9wxyt0LcPYWaIJOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKsDff31; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKsDff31"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEFCC19421;
	Mon, 16 Mar 2026 23:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773705379;
	bh=DgUYXuvJ86+JYxo2mtsIoUEvcAZLFFLbFq+gNWjLwRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GKsDff31hLtRGtVRmZ+2v+UYPqgSNd2Y3qqj3wX2qguePy5njWzMCP8VwxtllPI5f
	 zvUYx9QYYAbJH8+5fGd2eIGE0AVyHeF8ZYSsELC1VyybhXsRbGyAyPum0vRMb0o7PM
	 /fWeN3papac5J1amlCIPxN44ruI8CLotmBaHi2uwDugRT05RtwppIWXmKBH0l/I6OO
	 sg33C1w2ksYSlcjIPKA3ZCGDqfYjTGoWRYFhzWx5SkCsIweWDuectyBHdfYd77TiEm
	 /XqN1QDpczIW4rxwyTH9kTLrDrwFEv2hrKOcRw2UJjfLhyrZAukV2+dBiUGzw4R1wb
	 52Pa9tep4y5WA==
Date: Mon, 16 Mar 2026 16:56:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anas Iqbal <mohd.abd.6602@gmail.com>
Cc: jonas.gorski@gmail.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: bcm_sf2: fix missing clk_disable_unprepare()
 in error paths
Message-ID: <20260316165612.4ffa7830@kernel.org>
In-Reply-To: <20260316132547.1274-1-mohd.abd.6602@gmail.com>
References: <CAOiHx==pVOOtvOb3eooRGt8EcwjTtkY-33Nn+Cu_m3pu2gVtpg@mail.gmail.com>
	<20260316132547.1274-1-mohd.abd.6602@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 13:25:47 +0000 Anas Iqbal wrote:
> Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
> 

replace this empty line with a --- when you repost
That way git will cut off the change log when patch is applied,
which is what we want.

> v2:
> - Add Fixes tag as suggested by Jonas Gorski
-- 
pw-bot: cr
