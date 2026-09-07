Received: from mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCCD35C6BF
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761813; cv=none; b=W7QsjC8HYBjhZppmNMZcf7izlKfpdV257pKUiPiwhWQFT9gTfrpEiKBC6mrSLXWTh2jj8eGjRohIwdFpoi5a2FWrZ0YXUSPZCO12hF6OCjq3r2MJk1RmYdXVXRZAbqOO5qHlBkdYqv/efAAgpiPmO+eETROC4LYewxgp3xwpbEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761813; c=relaxed/simple;
	bh=um/5G4Ktg5bYB4/JmYOtP+jNUERGAJTRJYD0oR1JWK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXhJO2Uuusg8X/mlLdJX2oSC+/zeOQ2m2nr7DHATAb+bODvuwqhHJ9xhdFMxlYSf8N52wGeG3Bpa9dTFYsQYvfBnCWovuD3Zz+xoYsrMcVlRbqdx0/nsbL9HOnNZDyjidrMQA4KWdXomrSpkwabnVqca0mkgrKO589DFHieCDx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NjLpTG1J; arc=none smtp.client-ip=91.218.175.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NjLpTG1J"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=um/5G4Ktg5bYB4/JmYOtP+jNUERGAJTRJYD0oR1JWK0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788761809; v=1; x=1789366609;
 b=NjLpTG1JlRw2/g0gx8leRwJWDpdI75WLX1LsXFajbv2ihaF8Lj31ry8kzdH9QrTgbeVEr2a+
 0K8a1XX2CBfNsV4+zV51j37mszE0ErfPSiMrVFKmIZuCzksM8SXXPuIFiHvuiSHcknbfIkJc88F
 8I0/0hOSHyQhF3UdT6hazDWg=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a8b123c8c6109945;
	Mon, 07 Sep 2026 06:16:49 +0000
X-Mizu-Trace-ID: a8b123c8c6109945
X-Migadu-Flow: FLOW_OUT
Message-ID: <55e5864b-a292-476f-a6c4-20f89412abae@linux.dev>
Date: Mon, 7 Sep 2026 14:16:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: phy: mediatek-ge: disable EEE on the MT7530
 PHY
To: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>,
 netdev@vger.kernel.org
Cc: andrew@lunn.ch, daniel@makrotopia.org, dqfext@gmail.com,
 SkyLake.Huang@mediatek.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 sean.wang@mediatek.com, olteanv@gmail.com, yangshiji66@outlook.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260904202800.3410838-1-vladislav.karmanov.dev@gmail.com>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260904202800.3410838-1-vladislav.karmanov.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/9/5 4:28, Vladislav Karmanov wrote:
> The MT7530 internal GE PHY advertises EEE by hardware default, but its
> EEE support is defective: with EEE advertised, some link partners fail
> to establish a stable link. On a 2-pair (4-wire) cable where both ends
> advertise gigabit, 1000BASE-T training cannot succeed, and instead of
> falling back to 100 Mbps the port loops, so no link or DHCP lease is
> ever obtained. MediaTek confirms the hardware is the root cause (Landen
> Chao, 2021): "EEE of the 10-year-old MT7530 internal gephy has many IOT
> problems, so it is recommended to disable its EEE."
>
> mtk_gephy_config_init() used to clear the EEE advertisement early, but
> commit af3b4b0e59de ("net: phy: mediatek-ge: do not disable EEE
> advertisement") removed that on the rationale that the DSA subdriver
> already performs an early disable. That holds for MT7531, whose
> mt7531_setup() clears MDIO_AN_EEE_ADV on each switch PHY, but not for
> the MT7530 PHY: neither the MT7621 integrated switch nor the dedicated
> MT7530 IC ever had such a loop, so removing it left those boards
> without any working early EEE disable and the link flapping came back.
>
> Since the broken hardware is the PHY, fix it in the PHY driver so it
> covers all users of this PHY, integrated in a switch or standalone:
>
>    - clear MDIO_AN_EEE_ADV in probe(), before anything can negotiate
>      EEE with the link partner;
>    - call phy_disable_eee() so phylib does not write the advertisement
>      back on later renegotiations and userspace cannot re-enable EEE.
>
> Auto-negotiation then falls back to a stable 100 Mbps link instead of
> looping at gigabit. Tested on ASUS RT-AX53U (MT7621): with a 2-pair
> cable on the WAN port, a single clean 100 Mbps link comes up and a
> DHCP lease is obtained, where the unpatched driver loops.
>
> Fixes: af3b4b0e59de ("net: phy: mediatek-ge: do not disable EEE advertisement")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>

Acked-by: Qingfang Deng <qingfang.deng@linux.dev>

