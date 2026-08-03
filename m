Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03A3A6405;
	Mon,  3 Aug 2026 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786672; cv=none; b=HqS8Ibyu70DlO4wEjFKWliVjoyUuZPY1ACf0DSq8BKxaEBA1f7GKKQu7OcMrXL+aLOYGlOStyFbL8QS+BuOZwpJXJL+aHbI5jJ9vSvfVL+pWlri6Kev2TFug2UGFkZDgGvqg5RLpx6UH63UTCpirIWqWtUF76Pbb8YllJlKGw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786672; c=relaxed/simple;
	bh=ihOk+Z2xm+66KEzuj3VIharPQ8TE6H2Pv6FakMMmgxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfr/wvw4LmdwxWu5m1lgqE9ddkxz3dYwliPunFzKhURV0KLik+FsTxqnf2uNMs12+K1I6nqPESpb6sH/7CUGnyO8VXod3zCjVBNVuUq1WHFADT3xkVtAcUXLfIM3WqXEatwTyl1sU5m4V7NRo/KCFQZC6xPOTgmB5TkILXGvC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URJ7/siq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URJ7/siq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5571B1F000E9;
	Mon,  3 Aug 2026 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785786669;
	bh=q3hwnMFgDGFCuJRAXL8oGqWOBTJI33ph5sUSaM1/MFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=URJ7/siq1x5v5FXaGH5mw6h7Wq7K/lLEqrBnQ4M2Rz2Q33AyEHeQ8POFZumXkhTxP
	 PbcbpOoUbm/o0ejVMKVYThjcBc/5pzCBIjlv+TYtjOIgik0yJi9aZhk7YdgmvYC64n
	 QOA66GvNtuCWIlTb3bnycCgw8OFnWdOlpJuWUqGJBJ8HnBvAbnXFjNdQfjG1fgRl2t
	 dF85vNAxNhin0BM68QEguGAocsfVR6tjxcE82doeGzvRhziaTrEp2s2zLffQ1QWcWK
	 oAIVAHTPzEdusNs7cnvs2CRJei3w84MRagjMzOqsm/Dt2RcZcGSvbXRVAyZn1K4Qhl
	 pFNvgiFe7UsVg==
Date: Mon, 3 Aug 2026 12:51:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Edward-JW Yang <edward-jw.yang@mediatek.com>,
 Richard Cochran <richardcochran@gmail.com>, Chen-Yu Tsai
 <wenst@chromium.org>, kernel@collabora.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Irving-CH Lin <irving-ch.lin@mediatek.com>
Subject: Re: [PATCH v5 00/25] MT8189: Add support for system and base clock
 controllers
Message-ID: <20260803125107.76bc9c9a@kernel.org>
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 01 Aug 2026 13:20:46 +0200 Louis-Alexis Eyraud wrote:
> This series is a continuation by AngeloGioacchino Del Regno and I of a
> previous series ([1]), that adds the clock controller support for
> the Mediatek MT8189 SoC and its variants (MT8371, MT8391).  

Why are you CCing netdev on this? None of the patches touch networking
