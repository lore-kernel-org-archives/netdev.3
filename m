Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513632D7FA;
	Thu,  9 Jul 2026 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605808; cv=none; b=S6xPdHZMFwHPRbKkGpRrrbPPw0H313wSBfvqOydXSFPq3Hr8H5T8TJTqbr8VKo8dnidAfGroVYSsNNpbf6lA+DCKZBz1oDXMjE8w3v3TDoboPRc8cb7arymHu7JBzjOabLLhcyk+ARxh9SEQn4PUbiido5t/VqKPUDWD17EazZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605808; c=relaxed/simple;
	bh=yVSnZEVcy9spm4rdo+byWkY+QKt71zHBH4RF78ncWlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIoJmicRbkf1he/K8h9uYrX+QGeykJEBUeAqhFBSvrugO74nhVkDhzi6sb75sH3/nNyTSORlm3gWGhS/CLBeFmraHZCMCk8yZAxmnunNZxeGoQy6l2s5pBP0AANXvzbRnWx+aFgyDjyk3O9AvFDLfCEZLDTBvEy7kVvMlpaUcm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=q1NLO/Zz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="q1NLO/Zz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783605805;
	bh=yVSnZEVcy9spm4rdo+byWkY+QKt71zHBH4RF78ncWlw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q1NLO/ZzaHubJycWNSHcGpkSS3Z/RLPXQ4lJGV44i9oQRQecM1AsGOkWaecaK2Qvt
	 JEbT7GADU73edftlarYx1dwAJqsribnBdIcvJTHvssp1bGo6xeoYJqmDQ4vVlIHKXt
	 lVmvdu91UVhSRlXe/peqWwYBPvY4aDSpiDid3igeYXs1gnuazK1Yh3MCQSIGeMT+eC
	 yUZPorrQ0SzAo70CgQpfs4P/8OG0WpMifcHEZnp0E9EEviUuZUr1xHfDnAd9lE77nE
	 Xy+zctRkkJ8eBNJDDXcUIm0d1Cr7fofhaB5x+ayy4pAWTyaMwmckQv5TVDkj++rFaQ
	 jF0YaUTlCVnnA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DF04517E0521;
	Thu, 09 Jul 2026 16:03:24 +0200 (CEST)
Message-ID: <7b726b55-475b-4801-9974-596f28ec1628@collabora.com>
Date: Thu, 9 Jul 2026 16:03:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/18] dt-bindings: clock: mediatek: reorder MT8186
 compatibles
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
 <20260709-mt8189-clocks-system-base-v2-4-2926da3db6cf@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-4-2926da3db6cf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 15:42, Louis-Alexis Eyraud wrote:
> In order to prepare regrouping several Mediatek SoC clock controller
> dt-bindings files into the MT8186 ones, reorder the MT8186 clock
> controller compatibles so they are sorted alphanumerically.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

