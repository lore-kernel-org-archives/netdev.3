Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DD22D97B7;
	Tue, 15 Sep 2026 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494596; cv=none; b=BtZcRGboljXHTvwFmDv3u0h2Kd8THu4EFq0pV6MFAKvL/fAJ7y4789CbtjINN2mhhrOmvLeNLgGGjoawvca9VZ9CrC9XuxaJm1QFeqjCT7IXoTkqdQkFUiguwaOUH4hEW4Aom5ciPz8Vta/Nz7KE5+ht2SvwNopSKkzaJfvCOkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494596; c=relaxed/simple;
	bh=cOQp1tjuX4oXoUO13x8/aG1Cwm0PyCPSjVlnBN5Ngh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ibmxkx1drEOnMrO8t81gif78RKCg+I6GhhhY7FVPAJT8Q/EjLzGmSmIvmIS/cICbuFLFgH+EsS5r3hFk1bsWLxVh7YFH6pNBQptUuFNqXIM7Tb5Il+4JVLLTKv9jM/ozV90cu/HUJebge7o32uYrVkkXyMZTUkVuTs9goJoIqbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=SwFstTK8; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="SwFstTK8"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77EDE48F729;
	Tue, 15 Sep 2026 19:49:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789494591; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=TpLpxzKfFRAl/RHqoLxPPlY8U8TXJO7qkDVKFfcLlVo=;
	b=SwFstTK8VAtbxjApfPpsr5Xgb/VFsfI15YBZird1oXSvq0qFZbTVE6CNVBQ0TXB+lAABvG
	PmmDBB9HLjHIanTcGNGwp/HEBClNoF4QNenRNr9AgX6uu6FmcMnZCZ0rfhvSQfA60vn+IZ
	NdUslVNDLBPunXavLiiuLDa/gVGSMBRIm7uTFL1QWpLjhparjG4e1etfwkTCOE2WVZWm2z
	JyKfwMOATgpjLDktIo9wdo26Q58ToLRUnLEuUBTOL2TjXC8bKFL8VQ050kGBRBSNaPLPcH
	w/SjDKmjg4eDcgVjTChHCeZTb7Q2FxnE2DXh/2pXKXQXz/HwLkZIW1Shw4tlGg==
Message-ID: <4529730d-0089-408f-804c-57d7c4c68564@cjdns.fr>
Date: Tue, 15 Sep 2026 19:49:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 7/7] net: dsa: mediatek: support EN751221 switch
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, linux@armlinux.org.uk,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
References: <20260909140346.2861572-1-cjd@cjdns.fr>
 <20260909140346.2861572-8-cjd@cjdns.fr> <20260911170850.05cfb134@kernel.org>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <20260911170850.05cfb134@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On 12/09/2026 02:08, Jakub Kicinski wrote:
> On Wed,  9 Sep 2026 14:03:46 +0000 Caleb James DeLisle wrote:
>> The EcoNet EN751221 has either one, or two, onboard MT7530 switches.
>> Every implementation of this SoC has one switch on die with the CPU,
>> but some chips - notably those with a "G" in the name, have a second
>> MT7530 as an MCM module.
>>
>> The on-die MT7530 has 4 FE ports and 1 GE port. The MCM switch has all
>> gigabit ports.
>>
>> The MCM switch connects to the SoC switch via a TRGMII link from port
>> 5 on the SoC switch to port 6 on the MCM switch. This link undergoes
>> calibration on startup.
>>
>> All known devices with the MCM present do not make any use of the ports
>> on the on-die switch, it is put into "passthrough" mode in which all
>> traffic is shuttled between port 6 and port 5 without alteration of the
>> DSA tags.
>>
>> Add support for both the on-die and the MCM switch, and calibration of
>> the TRGMII link between them.
> ../drivers/net/dsa/mt7530.c: In function ‘en751221_trgmii_pair_setup’:
> ../drivers/net/dsa/mt7530.c:593:12: warning: variable ‘default_taps_ondie’ set but not used [-Wunused-but-set-variable=]
>    593 |         u8 default_taps_ondie[NUM_TRGMII_CTRL];
>        |            ^~~~~~~~~~~~~~~~~~


Whoops, got it in v2, thank you.


Caleb

