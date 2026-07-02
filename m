Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CF8381E91
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013565; cv=none; b=YKSA2T8LlQZ9TtJhKh2x8kBzYxl+LeuQeC8eZgRjeFRKNY4ooZGt0NyPKx0pk02+OeZcxRFIWO+G+dHGl+VEy4iDzgQnl32Cp6j3amOxPYT5kq1B+oOH9rcj3DP86TLqkShFAEGA30G/25zRCza7iZLTB4ycoEqZU6HD7g95QLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013565; c=relaxed/simple;
	bh=SVU13DfE2fT6nkswzbMyYJliSQ2g5smcRYHE9U21wyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZ2rM9QGD48RZspL4CCa8bgQx2873GhhBcWYbkz87S/QUKQqiqjk0cJiGrHFy+Yi2fGWfeC5oQYYKjvGQX9msZwBi91DHe3Wc9iLnEJPfGlM8eWw5EKfm4puDZTOuzWb/JNJXIZ77hnRpfQdmVXRkSto4YYxrclS4F27wekE8yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QwGsMLQ+; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QwGsMLQ+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6992B4E409FA;
	Thu,  2 Jul 2026 17:32:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 30144602EE;
	Thu,  2 Jul 2026 17:32:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64165104C958B;
	Thu,  2 Jul 2026 19:32:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783013561; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=333yUrvHkRG3UJz4DC6yymWTSQQMoVp1nOXtAD9WMA8=;
	b=QwGsMLQ+DqpF5JZ+NnixOA+M8lmYER25GoqwC0efJeFI0li+g/47xhqrpPpCeLvv327DAE
	H8HwO/7xTB7AH1gUwp11SVVjBeRshE5MhDuDpPb8c/El1c7KTm9PKcOr6qQ9nUvyp/B+9R
	tLOgnqi/DPNBZKDVb7arIdKD2Hx9Q5URaDh53087/pgZqz2FrqV/8wERH2Glm5T/Thple1
	tZWwgzwEqkxA5ot/XUWLMut4saogTMrBQx//J/c13GvTIjHdynI5qNjsM5FFtNYv0KEJ/c
	zc5/cVQcwpmIcdGov9DBCe7VYlxhX7oNK7xfiVqg7vZ5vwelkHxac1OX2CoEuQ==
Message-ID: <74b45119-46d8-42c2-afea-e0f0bc340304@bootlin.com>
Date: Thu, 2 Jul 2026 19:32:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 06/14] net: enetc: simplify
 enetc4_set_port_speed()
To: wei.fang@oss.nxp.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
 <20260702025714.456233-7-wei.fang@oss.nxp.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260702025714.456233-7-wei.fang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 7/2/26 04:57, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> Since phylink only passes valid speed values to mac_link_up, the switch
> statement with its default fallback to SPEED_10 is unnecessary. Replace
> it with a direct call to PCR_PSPEED_VAL(). Also update PCR_PSPEED_VAL()
> to use FIELD_PREP() for proper field masking instead of an open-coded
> shift.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

