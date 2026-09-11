Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7661DA62E;
	Fri, 11 Sep 2026 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128250; cv=none; b=cS0P1McsCFbK0lodseaKnJWo7nqBmfzjmK7eLHblNsv/rxb4RByvAoWFrFVC3am3QZaLGXGs8A3AaIUt9ZYygSiq+ShF0+lZKS1TgM8MoUlK90dXvGjVQsr6lg0DH/BZl2cd/Zl6S5m+wGqoCM+o0FsLQG4ygkPRS+6xNjRjxX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128250; c=relaxed/simple;
	bh=7grE8TXH7rz421+I7t8o0T1EjXIvpMHfIdIPR8Pwgqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMJbFoMpzCNOU76jmwoDcuS4qaG2c0AofE0n/teI3xNbplMShCKs6ZHnO+IaS2MQabcBcLqDgBBmCgW7DuP6LNSxJ7td60046YALQt4+GkcRoLUqmmPJlqParHt0DkUAEyaSp66afL/mKx/IvWMh1dPl3GIjFvxmieRc42C1ou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=jIJSbCGN; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="jIJSbCGN"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F273422D66;
	Fri, 11 Sep 2026 14:03:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789128245; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=JWjPhlAZgiTgvDtIbhGLmFKSScrttT/O4nlebYZTq4I=;
	b=jIJSbCGNgOtF1okwZwZz7W3TNqovpvufn1bP4tfZBqWGrKvQs27AdLg+/WNuSxLkBNCRT8
	7g6PBwjjFphxmz0cE9mnewxnDuvcKJhpeUFefLwNquCds9br+PcMrSNPgHUXJnlUvQAuzo
	7mFwvWjbk/MLyk1IxAC4MdtDXppikqQCqKAwLxShMisVQfPaFjgBfDRXFCPA2rlduBnuwe
	7mDJ2ZPsmGoVXel0KdptjNY53m1XjIPSUDBDpUN4yKqvfiPaotoovgPq/Wq2L+gA4RirEn
	za8YhEJsAJoSfTHi8CsMBYjOci0SVc0uW84h/Dm5PrMUkNTzPzAWQ6CEUuqgDQ==
Message-ID: <c16418fe-a9e9-4a10-b435-98c07c8a87da@cjdns.fr>
Date: Fri, 11 Sep 2026 14:03:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, dqfext@gmail.com,
 SkyLake.Huang@mediatek.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
References: <20260909213250.3184238-1-cjd@cjdns.fr>
 <20260911103910.4123567-1-cjd@cjdns.fr>
 <8396aeb6-c43e-453e-a7d3-52349b93c528@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <8396aeb6-c43e-453e-a7d3-52349b93c528@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 11/09/2026 13:58, Andrew Lunn wrote:
>> +	/* Clause 22 local data. */
>> +	ret = phy_write(phydev, MII_CTRL1000, 0x1e00);
> Didn't i ask for 0x1e00 to be replaced with standard macros?


Oh no I somehow re-sent the old patch. So sorry, I'll re-send in a minute.


Caleb

