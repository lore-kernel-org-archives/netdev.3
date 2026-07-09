Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279042D46C0;
	Thu,  9 Jul 2026 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605711; cv=none; b=ffh8xP6yDluQpl2hVxsPLNOO379nrdtAOsrqiqT24KCuR7yiyd+XU8cpKBAaEXVpwT8zz6Kpgc1njSkxVlUU9xGcab/NsEveJBLYgb0YPrEPPSWuknZC/IuAF3sviRNVFqC65kxBBpwzcDM3TdUkob80f+Gf5LW6MgoH/AQWsKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605711; c=relaxed/simple;
	bh=bTAQUL6Sz2StfMPjLEbTGPEW7jNnBg8BscHUDvxQ2Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNX6X3+Z//E4vfIBkk1e2yn35yixfd1WhiDCqUB4QhXc0Dk8SuKiSnR0GBg0xTuLcEi7jppcxHA5ne1rWoSMTsqwSdFhsTVjVmVyYAwBjdaDib6EtdvXhdZqKroHmucueHsB6jWcseG2UgLHMZTx+J6UqLUuVCvUIiKIEAMJwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oDCz25Hs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oDCz25Hs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783605708;
	bh=bTAQUL6Sz2StfMPjLEbTGPEW7jNnBg8BscHUDvxQ2Mo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oDCz25HspjPFTUPqt6RTLtFKqujzSvoowoOarSysRd6Dsd+sflH8XHQ83kx7Qhoxo
	 gS63sKeujE2TjRKoKusyOm4tVw3WwR5k/3xmsgDvxrOrIwREUlK5ZyQT7/voKANhr1
	 jpw8lcuBGb7ISHo6vHBZCYAOSGDX5jU80wd5MF/Kaf25j2M9IvYWgXRAJbnKJ9bsB4
	 zMMjY0JykG915nqU+/1WO9C/PqUsJf4lTnb5no773V5YZF0p9EKz6Fk2z/L0XUuLRa
	 cY3fBWMQpiCKd4KKbWFAviAtmEm/o3g8STtCwP+cYuH2c26xWtL9nUq95yTqo5J+U2
	 nVjXv/7ifljnA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E2D1717E0D53;
	Thu, 09 Jul 2026 16:01:47 +0200 (CEST)
Message-ID: <ff0f6f05-8445-459e-9c21-13f3dd57c4c4@collabora.com>
Date: Thu, 9 Jul 2026 16:01:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] dt-bindings: clock: mediatek: Make
 '#clock-cells' required for MT8192
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
 <20260709-mt8189-clocks-system-base-v2-2-2926da3db6cf@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-2-2926da3db6cf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 15:42, Louis-Alexis Eyraud wrote:
> Both MT8192 clock controllers dt-bindings (clock and sys-clock)
> document the '#clock-cells' property but do not enforce it as required
> property.
> As clock provider nodes should define this property in devicetrees, add
> it to the required property list in both its dt-bindings files.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

