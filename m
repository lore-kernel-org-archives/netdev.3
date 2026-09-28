Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAEB410D15
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790579939; cv=none; b=pQL7zmXWuigJnN32YcJb9jBSSfXSCJtYIYZw6FjWIyOKbAAlfmMhr6xL33JwGcUhX2RvAHu7TUtm1Ee0ay07g90FIV0e/xfYpPaHKozC5LvSScPI3yjwBcsjiMtczs6vGNI3wpbrwFV6MK+rZdjTtzrKv1eUPKXBsxSfD5HqfJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790579939; c=relaxed/simple;
	bh=kHIINSvSubOC+f5ChAlO6oBCool9yMy7/Q1zFXdnT2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKG6/12EbsrLg9Pioro1NqpfECgYayNij7y3rkrtej4NQHEhw/sIbwRnCXjs539FxJCgEZGyshrnw1aqndMck+xHDpj1lAs5+Yn41I2Hma0DvFWtsPLf7p6DjGc1+1VuNUmt7b9Ft+dMhrYD7Edf4MVx0SK2s2LXTDXOjL0J3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ITUSOQjF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ITUSOQjF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 56D4D1A0FD3;
	Mon, 28 Sep 2026 07:18:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 21E58601BD;
	Mon, 28 Sep 2026 07:18:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A879E102F1E76;
	Mon, 28 Sep 2026 09:18:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790579933; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=9ev1RphJmOUwTwyP1Zq1ADAaAbeAIOq+4OhI9af6F6U=;
	b=ITUSOQjF8Or/MddMYmkAfGrRpGJFB+t50R0v/RALVTMUn6bdVFoa6B02oRNTTSgva9y3H0
	HuXtZpygzofKnNumRcfAg6UvmvoklYRh76irvYhx3nJIcTuq/SG8qC8mxHs6afUYK1jAjO
	4Y6kNsjEc2uJxbN6uERvaVuZUPJ4wuNdOY+Gx8TMvlPYmc9G5Of4x9/o9EEwQ6OVTjt6Ax
	BPTgEmiZzDgg0eU/lRCOMVfZW38i99XzpDQCzErX9u4CXSlmrxzOTZWWtDnty9+oVrlYvq
	1DixhozDTnTuU1dqgfO7IAtopMgaI2lyl7o73Xb6AaLpyxZaGKVLT39xkodqhg==
Message-ID: <2cd3b581-2f8f-4e46-a487-a03a3c45a8cf@bootlin.com>
Date: Mon, 28 Sep 2026 09:18:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: Don't set or get RSS parameters when not
 supported
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
 thomas.petazzoni@bootlin.com, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260926093343.292181-1-maxime.chevallier@bootlin.com>
 <20260927154603.47253d19@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260927154603.47253d19@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/28/26 00:46, Jakub Kicinski wrote:
> On Sat, 26 Sep 2026 11:33:41 +0200 Maxime Chevallier wrote:
>> The RSS kselftests fail on stmmac, and this is partly due to the driver
>> reporting bogus data for the RSS ops :
>>
>>  - ethtool -x reports an indirection table and a key while the hardware
>>    doesn't have any of that
>>  - ethtool -X fails with -EINVAL.
> 
> this is net-next material

Fair, I'll iterate with Nicolai's fix.

Thanks,

Maxime
