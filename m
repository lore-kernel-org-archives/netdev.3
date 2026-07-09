Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5B387363;
	Thu,  9 Jul 2026 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605835; cv=none; b=krlU7md6ir2FNDc/fGjU/trixYQd8piHaGc/ELqVzxBeK1uPCufb4nZG3AqiPW0v+3p6HDW5lsTpm/kMWG+Pe0bVu/WCkzac1Olcdfzblhm2IAwd8Cr5aY7ObBx5siopbVTedNK/x9R82kbz91T+YWM+hy1Hyu5UD7wx4YTMXNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605835; c=relaxed/simple;
	bh=XjvVRfcKcK2Mimm4SQHCDuE4JbyoJqNRUTqqp0ymYHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sw9MOnfhNXJd4dUO0gqnE9/oRMhegbTks9D2mkIYg0ngw9Uld8ffQyT9+iKpkNTJFIh1pmDudsRNmQ6F0gWR0TMZK/6ztQ3RoZwxTdIlEz8VAADaSvClghIz608/qIOF6xFKylxdY/2kO6RppuQ2TfSg/Bnj+Hq9NU3z6ZLppPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=axxhB02K; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="axxhB02K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783605832;
	bh=XjvVRfcKcK2Mimm4SQHCDuE4JbyoJqNRUTqqp0ymYHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=axxhB02KuIM+ZNdLMCoAwg37XbrA/+4D7/vcjclUz7KsivGjEIb7WTgNZ95WGZllQ
	 CARfzVIuXiXXrZIR3MaUaxQ0UeFz2tMCrCTNum76JH/Xw4QDmMZYVkxBB0tDuALThI
	 1AGRpetMNTrEXtmxfcyZpm09z2w1W1stT5jsp01SaMpaylROHWRRYp5Jhi4mqACUba
	 PMbe55SuLBN9/UEo4T5d51QfQQdmHsA8B6xhn9K/OibLN/7AUrBhXRLQgI0DRy/n9a
	 hgq24SOtA3dwAsD6LlYUeyYXOwTHfQ1n1Bd4ABmXU7vPKEFAYkUvIXgu5UvfWDc2Y9
	 jWkJ5zkJIEKJw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F1D6F17E0D33;
	Thu, 09 Jul 2026 16:03:51 +0200 (CEST)
Message-ID: <37250e83-39f7-4291-85e0-648c5a5c629e@collabora.com>
Date: Thu, 9 Jul 2026 16:03:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/18] dt-bindings: clock: mediatek: regroup MT8195
 dt-bindings into MT8186
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Edward-JW Yang <edward-jw.yang@mediatek.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
 <20260709-mt8189-clocks-system-base-v2-7-2926da3db6cf@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-7-2926da3db6cf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 15:42, Louis-Alexis Eyraud wrote:
> Regroup the MT8195 clock and system clock dt-bindings into MT8186 ones
> to ease maintainability and have common files for several currently
> supported SoC or new future ones, that have the same kind of clock
> controller design.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

