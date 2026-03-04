Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657BC36EAB3
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631879; cv=none; b=ib8io55LLlOnyhGBUuAU0x3JUTvHYl6hG5YfbfUohgeXu0i2+VtF4UrrN+b7IFMJ+rV4dXIJ9LkZEyBG8yxH11He+Gxy3tuvK0JquPcL/ykUNrYXlgIJCxZliufz06HUMU8uCwsJhoNWIuqrCLQSaHl0R3qMe0AjtEF8E+CmXjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631879; c=relaxed/simple;
	bh=mb8/E7r/JHT4CQjD5aiSO/ltiDaZnTeNfRwQiOerju0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7/l9apC5BYj3GB/PGnhmg8BssPgW2H52f6b+SRQB4kUjOQe2XybTwfs/SzcrYsnkC7PSgISIEJPaVfZp4uRbhC33CiHaLWHqskopKDqMoR4rcLPGhPQ94G3FZm7lG/DI3pc9QDYiet99+SPLsyTx38N3PwNuNzoAuPZgow8exw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fkv0RGbc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fkv0RGbc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BCA1DC40FBE;
	Wed,  4 Mar 2026 13:44:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8DB565FF5C;
	Wed,  4 Mar 2026 13:44:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43275103695C1;
	Wed,  4 Mar 2026 14:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772631875; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=S/hqJ4IhKM0l73wJs15uIccMo9eVsjrJwaIKX6REWAQ=;
	b=Fkv0RGbcDbiuVXq6d4OtHGvPeWZkrInwUEVZzQduBAme/+ODBx3RzKWU7gA/osOI8dQTIl
	k1jn4b+9EudsQegtGmE6CQBJOsEPSHlCGaiDo2DbSHvulz3deZTMCD6yg3epV009a+DcSC
	7Mxh7pwoC3qozp+5QHoMfDfbwUQ4fYeEcgQoucyp9cmT1ywpGb7pbDiiHrlYe3EBC/9BuW
	55Km4akBu1GdXRVmDn3ARK0fGL0SZxtPe3kvPJp63f5zZcVZ/9TBoUgAefTGSfV9CnA6xP
	PxZbXgTI4ke/2OuvZe6qL59t0LMCEXVXRTysROwq9NAFLdU4lVdt8ByS6dliIw==
Message-ID: <97647b31-61cc-48f1-bd50-f2e749c0c209@bootlin.com>
Date: Wed, 4 Mar 2026 14:44:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] amd-xgbe: reset PHY settings before starting PHY
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 horms@kernel.org, Shyam-sundar.S-k@amd.com
References: <20260304122305.812541-1-Raju.Rangoju@amd.com>
 <20260304122305.812541-4-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260304122305.812541-4-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Raju,

On 04/03/2026 13:23, Raju Rangoju wrote:
> commit f93505f35745 ("amd-xgbe: let the MAC manage PHY PM") moved
> xgbe_phy_reset() from xgbe_open() to xgbe_start(), placing it after
> phy_start(). As a result, the PHY settings were being reset after the
> PHY had already started.
> 
> Reorder the calls so that the PHY settings are reset before
> phy_start() is invoked.
> 
> Fixes: f93505f35745 ("amd-xgbe: let the MAC manage PHY PM")
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

This looks good to me,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

