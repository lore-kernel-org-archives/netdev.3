Received: from a3i436.smtp2go.com (a3i436.smtp2go.com [203.31.37.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2737837F8D7
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.31.37.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815510; cv=none; b=dxzzHIwWRwOdSXo3C86YDrHUoROLUz7vdMY8lyKkqXZoh+QTaHEkzwo9uc8pbGkx6bhSGsP63b29zh61wuT7KOSTdVC9p2s8T3l3lZmV/wOwFs5J6EF8z2lOmzymvdnlahFOtpVUp1w9gn8UpnMLSZCPB+7npgLP2Lv4wbLVyH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815510; c=relaxed/simple;
	bh=f0d9N6IafB8skdxz48jXvXkQWS5Kv9Nmt6cu1pI1Los=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ahrda7+WpIgZQd9QkQIjGPxbZb3d7ka1f6Wp4pIiGN2bmviAxV3YT1EKPSYO+z1J3NT5U/1DSi9j+HBrGklM3rFQ77HIMW0nYel93NRBUCbADlMs02/c3icFh4Q4VABs7ciJsb2tn1x3yYeSGh06qiBMty+2JqvoXo0U9QhSaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dilluti0n.com; spf=pass smtp.mailfrom=em840244.dilluti0n.com; dkim=pass (2048-bit key) header.d=dilluti0n.com header.i=@dilluti0n.com header.b=bGGvgmPK; arc=none smtp.client-ip=203.31.37.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dilluti0n.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em840244.dilluti0n.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilluti0n.com header.i=@dilluti0n.com header.b="bGGvgmPK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dilluti0n.com;
 i=@dilluti0n.com; q=dns/txt; s=s840244; t=1791814602; h=from : subject
 : to : message-id : date : list-unsubscribe : list-unsubscribe-post;
 bh=swfREcWzbUc9YguPvLBn7KVwu8JKkdzAIGtWqZxHnlE=;
 b=bGGvgmPKpZa/cKFDCpBrlYxWbXHOG1eJM1xj80qdN5YqQZgzo4Vf7ZQo347d/J8v3AmPs
 3te5e3NBo8J6HB2jZ7msQazokjcWO/iYdIfikFUBDOspoJ02BEOuejePLjcgLrWtzNavDUa
 PUGuXVru5upbwVRkgR9wZ2aaIh7dqsOhqnmF537DRxCD8QwidaCJJ7Fb9Sva9PWFTpjO9Z6
 3Zl3qzCsqw50PrLnY94zTAaM6ZeCBkoj6XuqtK9V3Cdpw0mGdpZscz1cfKNvTpImuVm3mm3
 mWW2FXhxpeJ1hyUi1cxLYbAGI3LBVOo6ssfnm8dLIuj32+15OB48KQ5Os6yA==
Received: from [10.40.244.132] (helo=dilluti0n.com)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256:X25519)
	(Exim 4.100.1)
	(envelope-from <hskim@dilluti0n.com>)
	id 1xGGpM-4o5NDgrvDQO-gDnJ;
	Mon, 12 Oct 2026 14:16:32 +0000
Received: from localhost (<unknown> [10.42.0.2])
	by dilluti0n.com (OpenSMTPD) with ESMTP id 717ef196;
	Mon, 12 Oct 2026 14:16:24 +0000 (UTC)
From: Hee-Suk Kim <hskim@dilluti0n.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, javen
 <javen_xu@realsil.com.cn>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Daniel Golle <daniel@makrotopia.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] r8169: allow Giga Lite fallback on RTL8168EP
In-Reply-To: <dbdd5abd-f1b1-443c-adc3-6ecdc95f4854@gmail.com>
References: <20261010135356.85454-1-hskim@dilluti0n.com>
 <dbdd5abd-f1b1-443c-adc3-6ecdc95f4854@gmail.com>
Date: Mon, 12 Oct 2026 23:16:24 +0900
Message-ID: <877bjnc8cn.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 840244m:840244atORciv:840244sMJrnW1qeB
X-smtpcorp-track: vCO3kS8EMixF.2-ZKrEhcIdwr.xM5k6gu86c5

Heiner Kallweit <hkallweit1@gmail.com> writes:

> On 10.10.2026 15:53, Hee-Suk Kim wrote:

>> @@ -5619,6 +5620,9 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
>>  		return -EUNATCH;
>>  	}
>> 
>> +	if (tp->mac_version == RTL_GIGA_MAC_VER_51)
>
> Any specific reason you restrict the functionality to this chip version?
> In the commit message you describe that vendor driver also supports the
> 500Mbps mode for RTL8168H and RTL8168FP.

No, just that RTL8168EP is the only one I could test. I'll include
RTL8168H and RTL8168FP in v2.

> Also vendor drivers r8125, r8126, r8127 include functionality for dealing
> with 500mbps mode settings. So more chip versions seem to support it.
> Hopefully Realtek people can provide some more insight.

I've found all three [1][2][3] do the same as r8168, so I could cover
them as well. It would be good if Realtek people could confirm that
PHYSR reports 0x30 for a Giga Lite link on them, since the vendor
drivers read the speed from the MAC instead.

They also set bits of OCP 0xa5ea when 2.5G/5G/10G is advertised, which
appear to enable the corresponding Lite modes (half the speed over two
pairs). I'd leave those out of this series for now, as I'm not aware of
a use case for them.

[1] https://github.com/awesometic/realtek-r8125-dkms/blob/9a152bf920334aead090d2fb4d91f67a84923123/src/r8125_n.c#L5948-L5980
[2] https://github.com/openwrt/rtl8126/blob/27721fbedc45897cf1f155f5eb44de76962a1ba8/r8126_n.c#L5009-L5033
[3] https://github.com/openwrt/rtl8127/blob/f80bc64922ac76f90618f61245fb29743c018d0a/r8127_n.c#L5330-L5359

> So for Giga lite (500Mbps) a wrong speed (1Gbps) is reported to the user.
> Not sure whether we want to add a SPEED_500 constant. On one hand it's a non-standard mode,
> on the other hand it's apparently widely used in South Korea.
> @Andrew: How do you see this?
>
> Alternatively we could add a notification to the user if Giga lite is auto-negotiated.
>

For reference, the vendor drivers report a Giga Lite link as 1000.

FWIW I'd prefer 500, just because userspace would show it as is.

Thanks,
hsk
