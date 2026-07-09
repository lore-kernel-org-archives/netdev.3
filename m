Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C3223392C;
	Thu,  9 Jul 2026 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605713; cv=none; b=cyq5sRPW8ou4x8L1sAXvjkZa+ArpHMtFH3KpSbECnN3S1V4K1Bqd3+LLb/gJgoWx2/adJ/qj6f9BBt4ogeQqo18QU+RiGUNGZsWDM5PFZHBzOAsCmWNcZrCff2pbv9f7Aqa14kjQrJMooOdck83aQiZN2FN3c1x0PhXf37tzNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605713; c=relaxed/simple;
	bh=8SkAR/Ab8XsPGdgW8BYCG02vOqkW8k+veVBNwe9Ul5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dooEX38fWZLXma/o6Mq5qosjF7+8w1/ks92dj65owJXmLkb2KhEACwMidoNxTY+324wtecwU/BhDULJLfV8F+lxs/kv6W7tGkBj4EKcs999v2ivd4i++aOdC1sktKi4+hv/73BEtzz2rAZdlFCjiP9Nt7r8tNXqtUujCH3wXhGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eZ+WEEEt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eZ+WEEEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783605710;
	bh=8SkAR/Ab8XsPGdgW8BYCG02vOqkW8k+veVBNwe9Ul5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eZ+WEEEtNdm44adPY3hOzL/+043uJYdbKHMRPcOv/18YBSEdZMoRnvyyqIL8/9Zt5
	 8fs7GrdxwcKJgwbDNyUcMYbBkx+ZhCs0ij/p1PX0UeHb8IPLBcNL8lTEr7vLCq+DVO
	 TTRNPt+MsiNJ6E+tfrSZPcAh9pn8TGJqfm1uiz71RYzV9ajbnG8D7furdXlRu9ovaX
	 clxJ/Z1QYFaE+9JVTpbx7GrjX1Vp74T6aexce8p5OinZoYqF/3i8vRFiSP4gvaj+T7
	 EzW3N7xkMs+JUCu6VOneil+AMeXom/GfEu89VRtlJGLFu0YRKjHX/WqNgzYiJ7TqEO
	 A3O8/cowCQsNw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7569317E0D56;
	Thu, 09 Jul 2026 16:01:49 +0200 (CEST)
Message-ID: <fe7dee8d-afe9-441e-898b-695aacf1aa04@collabora.com>
Date: Thu, 9 Jul 2026 16:01:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/18] dt-bindings: clock: mediatek: Make
 '#clock-cells' required for MT8186
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
 <20260709-mt8189-clocks-system-base-v2-1-2926da3db6cf@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-1-2926da3db6cf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 15:42, Louis-Alexis Eyraud wrote:
> Both MT8186 clock controllers dt-bindings (clock and sys-clock)
> document the '#clock-cells' property but do not enforce it as required
> property.
> As clock provider nodes should define this property in devicetrees, add
> it to the required property list in both its dt-bindings files.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Though you could've done that in one commit, or just skipped the additions in all
of mt8186/92/95 and went directly for the new one... IMO, it's ok as you're showing
that there was an actual mistake on the bindings for clock controllers.

Same comment applies for patch 2 and 3, btw.

Anyway:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

