Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB11E1C2324;
	Mon, 23 Feb 2026 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854874; cv=none; b=UpfeiHiKJqO56EB7q3uMnaVi5vkTJNHNNqfN8amYTb5v0NAW3hktd0V/HJVqRqfHm8+bi8+jd+jnSzfzypjADT0lgKhGZNywyoxw1fMOk0SkTyyAn4vvlSJCO6LE/2pLiXBy0JNUsJh7cP1973YDw6V/+lVcNJBpUqHpHWWSXJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854874; c=relaxed/simple;
	bh=wsxrGT9iiPD6ZitFu90+kuRPo6NfbN5RrwpeDZ7GNQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMw0QEk23ibXmJtBEmMTmWylm6NqI6Yg4tmBZW2k/Tc0OAIiAHz+9eZwaT7+eTc5xtMP9k69yxFAX2/1yQf5ssIPx67eZPBOSq8UNjun/OU8fWvSzUfS7wBoQw6/5zqC225aUU0VlJynixktbLmTrbbcsZBJsucUNSNnfT9ixPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AlMRZCcN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AlMRZCcN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1771854871;
	bh=wsxrGT9iiPD6ZitFu90+kuRPo6NfbN5RrwpeDZ7GNQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AlMRZCcNRh1z6NRy2/I17Dm2/sYYtXapstkwgNAT5JC829doMkVfCZu6bzBply4mX
	 Z5V6k4Fugil9Pbk1jTOoN/oVEeqCfAKqRT6IFKDIziyaucxhMAd41jYXXqW7jof677
	 m0mMfBerf0M5K1EAeqrIdfXRJS/x3Bi5RLQslWTpMP/myCyMmu2Sx78PopsHOkRg5o
	 H/O52ahKyojFXDNplvjDFYJUmk8ft5TTBoJujoIoALlB0oZxnqE3hsUdIzuhOftNBq
	 DfnF/yKg27joBLxmlkAJl7pPQ1DW9pvBgJOzHRgZOaVPAldn1YCSM7vOX8Bt/2/G1z
	 L2GiCzzldb9Dw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 559BF17E043F;
	Mon, 23 Feb 2026 14:54:30 +0100 (CET)
Message-ID: <8030ee40-5972-499b-b693-b26fb7ffe7e2@collabora.com>
Date: Mon, 23 Feb 2026 14:54:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/18] clk: mediatek: Add MT8189 vlpckgen clock support
To: David Lechner <dlechner@baylibre.com>,
 "irving.ch.lin" <irving-ch.lin@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
 Miles Chen <miles.chen@mediatek.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Qiqi Wang <qiqi.wang@mediatek.com>, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
References: <20260202062840.342707-1-irving-ch.lin@mediatek.com>
 <20260202062840.342707-6-irving-ch.lin@mediatek.com>
 <4b22e998-b38e-4452-82ce-1389d7086a04@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <4b22e998-b38e-4452-82ce-1389d7086a04@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/02/26 21:49, David Lechner ha scritto:
> On 2/2/26 12:28 AM, irving.ch.lin wrote:
>> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
>>
>> Add support for the MT8189 vlpckgen clock controller, which provides
>> muxes and dividers for clock selection in vlp domain for other IP blocks.
>>
>> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
>> ---
> 
> ...
> 
>> +static const struct mtk_gate vlp_ck_clks[] = {
>> +	GATE_VLP_CK(CLK_VLP_CK_VADSYS_VLP_26M_EN, "vlp_vadsys_vlp_26m", "clk26m", 1),
>> +	GATE_VLP_CK_FLAGS(CLK_VLP_CK_FMIPI_CSI_UP26M_CK_EN, "VLP_fmipi_csi_up26m",
> 
> Should "VLP_fmipi_csi_up26m" be all lower-case to match the style of all of
> the other clock names? i.e. "vlp_fmipi_csi_up26m"
> 

It *must*. Yes.

Regards,
Angelo

>> +			  "osc_d10", 11, CLK_IS_CRITICAL),
>> +};
>> +


