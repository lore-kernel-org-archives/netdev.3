Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751FF379EEA
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705566; cv=none; b=DGvSat3ADThUkwhkZLYWja+HDvA3F/dhhriSC4brqP2SBVRrKx5UFbrV+KmiKknXSY/9Vnb6Lk2Jr8dezoN9nhjgeTZ7Tkt8LeDr+alWqClQ+LIMWZAi3WO5FmZM/VPvl/QZCHc1fRRjOk5TzKSH5gcyt1CDa529dkvX9XGgeu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705566; c=relaxed/simple;
	bh=L2FJVvoEporHcYqOd0eo5ZF7DRaOACwGLwAqOnbjmsg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OowBfqY1PRKCnIuY4inm8lOAAGNaSwupLVKFUlOXzgJswAl1ZjI30wY14BsEeMTDu82hzVyZmaLM8yM3KwhOUZPo7AerXIBIUaJTEtNw+WCA/nW6k/xQwAFxmj0ym/fgiKtyveWnktKcO7eDOkkLZpBlNdXIDSvXI8VGPc2fQro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=bp3nPlbV; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="bp3nPlbV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773705559; x=1773964759;
	bh=L2FJVvoEporHcYqOd0eo5ZF7DRaOACwGLwAqOnbjmsg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bp3nPlbVmyGqM48Jial+oojfjDRawvSi15dkq2qoX0velVH+YrPDv2FcNXObJAD+z
	 lx/nY2NCfmJdiaLTIp8YBUd+4VwdS/2iEzMZhsuoR1a65Q+yk3ayExUM4OpBNx4Mr5
	 P+jphX2RajTeK37uZKBoX9Jy3W1pAalzBw9Q43Q9tkkbccsVUdgYFjx4CKWYF9xvgP
	 cSzCW/EQCshDI+OjAe4tbHxbzCTcVdT9Q+YIHnFDzQ2rAUc5KBVIl4asFU0/qpFnpC
	 PA0gOYyUQFzhJZbyKa8PWZRC/ornVzG1HSiXuW6z6QLltRlZu3WbnI4DK5q5uAAlJg
	 7TigTwe92ql2w==
Date: Mon, 16 Mar 2026 23:59:15 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net-shapers: clear hierarchy pointer and defer flush frees with RCU
Message-ID: <Z2Z1ZHOKjrQYZq0NtO22IyUBriDT4l0Ek6pEAsTI5TRfETvY8pWlxuNXCfBaWdbH0daZqJ9Mcpp1PC2533-n-0oe07uPSvsUmWFLjYY8tg8=@1g4.org>
In-Reply-To: <kml9JrxcP_XGGG4SSCVJO6f8Oi9zTfdJg9NRVZyvu7YAd5dgDy-uBE2m1U6MVY-ponQRFLuWQ6z14W63DCLevPICexEWX_yMQcZrytxCgDM=@1g4.org>
References: <20260309173450.538026-1-p@1g4.org> <20260310192842.3c3b2070@kernel.org> <hHYLQqDrBCcK_2x6uSbGsBott3QuXe8o-R9tj4vNmw8UUEFxpzoD_PCMiHMyyOnySAtQbJtCAB8yVoCmWxzO07C02Q5o0J6fHu4NLEa-ggY=@1g4.org> <20260316161247.1f472be5@kernel.org> <kml9JrxcP_XGGG4SSCVJO6f8Oi9zTfdJg9NRVZyvu7YAd5dgDy-uBE2m1U6MVY-ponQRFLuWQ6z14W63DCLevPICexEWX_yMQcZrytxCgDM=@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 5d1dae45646e1df27042648a257911696d7ac663
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This will conclude my work on this module unless another high severity CVE =
presents itself.

Thanks and good luck.
