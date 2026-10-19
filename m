Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792453455;
	b=QjeXZEG7N0B3+xoyRuD8W66eBSJlA4QnzACJEarM9Uimow4fBY27LOUMMzMBe9Yz+3+j
	 +FnWN+kMfem88L6ECsuSMgOAFs1CNnxNA/xlZZWsZ5N5cNf3eLyt0YgHP3NEGlxK5hiyH
	 rt8QRBcaHn7Z2Uh+DIu5FBJ2CEap+khrHFZE0cSZvla5ZTCt2OBH5MpPb06+3O30Mz0X9
	 IpNI9yQSEuNoZrMIG6PIolv9WPTRzijFr9GzFNzXjDG1iLtB7fkjrtEO/mjkMRBuFubMV
	 RQyniTe/FE6FWEBS7M6xRCIcOVUnlE+su9SHrC1g/umBUM5yiGkEAsOK04MqzsOfoIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453455;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iWaneoGvSevT2qLDl/RQQ7ikbJCjiV85eIMPbZ/YnAs=;
	b=QojQBg4QNnKWsWEiYTMEdG1lbXOYjhU6PNYcZOylAGYItaRQuiCcl1hrclviYCWudBL5
	 d7SbQQyQefBPvtK0lXyzzxQrsF0idddjVqgCTu8er8wwX9Uj6dVSbuGDHXu7I18864y6o
	 Hj8n7eW3gaA5/rUyyqxZl7iMBLnAP8DodhZSMvPsODB4Rcy5+o646s89vg5fcXDU/3hgI
	 eOMKQ8YkacHJPskIzTkscuXmzgEigIgR3WyQYdhN6BTGZl0u45ZP1rhMR4GVd2+4HmLf5
	 WK3mdHxC7pp4pG/wiKoS0BmuQunPEExgZjvI0DAkpICS8o2sI65eQBusODjumR05/uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+yuYn1H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A700606A31A;
	Mon, 19 Oct 2026 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+yuYn1H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86951F000C4;
	Mon, 19 Oct 2026 23:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792453454;
	bh=iWaneoGvSevT2qLDl/RQQ7ikbJCjiV85eIMPbZ/YnAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I+yuYn1HdQwYwdD2TVn9uHXgbvRSznVKJFHK8A8UNpYSvcY2i26SC5Jofx9/x1GDr
	 HvMR1uFZftJcPQpIL0VzcDlnS7cVF55kJ9p3tllY8DS1QiyMsb6DvzqKdyur4tFmNT
	 jb2nRzYHWe12wLaHWsTDGVJHHt8zNRh7NWf1KYyXBXSn5FMXXOcIA3T9ESmRCw7L1f
	 3+rwdnFYRvEAYLE6ataCS9hTgo6S7P/mJ2VsHx42JCPPOJFHT8vtnamSgoaVa2sE0K
	 htrrHsRNUfAUctKh8dViHOrFq6lrCkC2K7EArXPx+46iitgtlI8wFINzEbw46c8dhQ
	 TnofILXUyff2Q==
Date: Mon, 19 Oct 2026 16:44:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Selvamani Rajagopal via B4 Relay
 <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Cc: Selvamani.Rajagopal@onsemi.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Parthiban Veerasooran
 <parthiban.veerasooran@microchip.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Richard Cochran
 <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Eric Dumazet
 <edumazet@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Jerry Ray
 <jerry.ray@microchip.com>, Ciprian Regus <ciprian.regus@analog.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH net-next v9 00/11] Support for onsemi's S2500 10Base-T1S
 MAC-PHY
Message-ID: <20261019164413.5d4c6eed@kernel.org>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d@onsemi.com>
References: <20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d@onsemi.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 09 Oct 2026 10:12:20 -0700 Selvamani Rajagopal via B4 Relay
wrote:
> This patch series brings support for onsemi's S2500 that iss
> IEEE 802.3cg compliant Ethernet transceiver with an integrated
> Media Access Controller (MAC-PHY)

You are expected to reply to the AI feedback, if all of it is invalid
(in your opinion) one reply to the cover letter saying so is enough.
Given lack of reply and the 10+ Medium severity issues I'll assume
this needs a respin
-- 
pw-bot: cr
