Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793189518;
	b=XjggpM5nweutRXLPQxQoOixvU7TT1HXX7sxrHbOrNbZyp4PjDK6uIQN5Fm2v5/ByQO/4
	 PbZVZMwBp7dixolSQuJ4Tc2iwyitrDNLBbY9mPUNTZhktGUVsU2imQIJWt83qA260UxqG
	 SnlzKA26Reqzcu+NKfYxowwaTJ5AyfYEeaV9vb9ikBayJinxjLIPAEdyqmFeeOSahM/If
	 ndr+MmUPe8NMTAwu4qRdK0M1ErPn5viYeQQC/W59+00UVZJbh67YbGUWEq/dU1dSsCVYB
	 lPltt2cY8JEhyS75o2h4jds73tyzcRibCvrKxdqO5aHt57R2wwjKEY2EhehL7cIoZ7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189518;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=Yzm5KfrMMhSQL0Yf78me4QaQ2CKP9r2dKDG+lFJrjjw=;
	b=pyhmXXqVer/2P58k/5bMXKTSpoXKmS4bTQYSdJ9r2WvlfvDGTCt50Sb2EOApmlTrpLqY
	 hEKB46M+YPvCWzcRr2ZDxmLp+wZg6X1Wv4ufwsnjdnmMzJM/FbjCUH6wYWE9HGA/OPVNf
	 x0dRmhe8BxSD1a3vkGutc3+XOcghQNlNWdxd0FfU9oadcnaYaY+tzgBbOPAqd+3ZCaBE2
	 o0apqndf8x31MInmLgVXKWZVzimMRhI8Hkr4TILjL5it8KjdVKM/cAh7fnqF04/UaFjEk
	 auxTkKZeDqWA/HDLwGxZp1+GJ06M1QvKU5+wkScWRvzl9YK11jYFdWvn0Zul8jwtlBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=JVGkergG;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E62606A31C;
	Wed, 28 Oct 2026 12:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58E62606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=JVGkergG
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB6FF15B5FF;
	Wed, 28 Oct 2026 13:11:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793189515; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Yzm5KfrMMhSQL0Yf78me4QaQ2CKP9r2dKDG+lFJrjjw=;
	b=JVGkergGGn/tJs4X7LkEAPKkZk34QvlpZPHWX5xQEsoouO7CwrWUR9a4q93k4ERlhvZPve
	GcV5paJAhqfBt/coxtS486lXuJEkhbUOfMXmGgegDtgi5QbIPgyXAdFEuUkTcbW1dANozs
	IETk7PUFxBsNvIodov/HwD9NfX4JiBWnrCJnh4xpnSi7pXEwafabe62NRFC3rxsXDWSxzh
	WPOWj7H2YfFPfz01suNcwdD6YuvmY91NDlKLGdTWWjVmL3GddiHH0mKAnnM9ny6Y0BCvaV
	zoDpfObWYO7RqJE3woFv7a6tIOD0mvnIDpuS2JiQ1f104r6yWQthKEyLsNgKLw==
Message-ID: <64c2291a-f9c8-49cd-965f-5bc735f1b4fc@cjdns.fr>
Date: Wed, 28 Oct 2026 13:11:48 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 3/7] net: dsa: mediatek: add support for passthrough
 mode
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, linux@armlinux.org.uk, arinc.unal@arinc9.com,
 Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 naseefkm@gmail.com, b.larsson@gmx.com
References: <20261028011317.1557238-1-cjd@cjdns.fr>
 <20261028011317.1557238-4-cjd@cjdns.fr>
 <d4564675-fa56-42df-8c5c-cff14f7884f9@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <d4564675-fa56-42df-8c5c-cff14f7884f9@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 28/10/2026 03:07, Andrew Lunn wrote:
>> +static int
>> +mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu);
> Please don't add forward declaration, move the code around.


Sure thing.


Thanks,

Caleb


>
>         Andrew
