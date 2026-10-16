Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBE257845;
	Fri, 16 Oct 2026 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165837; cv=none; b=KXQy9KKWBnFkzeF3vpiUAvEIcD6zpLt1iipnGSSZ5ZR9Bc6Dm7qI3XPGpXFzoYASqx7Hl8Zn3rOA1N1RHZaw1GHIUdJkHwD0Y4Ifq/i6F2OnKsVX3UvBPMaBoTFeENwEwDWFnR7CnNR8szYNyQ9z6A7vBHfz8ccNx4sKKav1NFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165837; c=relaxed/simple;
	bh=EQRmU6Sr5j4REVMWye23mnyXQcCCUDct+ihHbCHqm80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+aDFcXSU+vX/ATQZ6I9zd/8RPiGbPEU1z4itodS7CtzvDxoWMQJSLelGhcruLUPYKGwX8Ka+EEbDLamZJHgAymCTozGz29dLrBQZcH5eF8LfSK3Z4kOzAoe2NwNFmxB8A7x51RAP30Q784PR7Xu6XURsMj1ip0naIsDCzJ8mN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=F+c7Ty5M; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="F+c7Ty5M"
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id 811F32404D2;
	Fri, 16 Oct 2026 17:50:30 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 46D052407E1;
	Fri, 16 Oct 2026 17:50:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1792165828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8YCP5jGBgTmgTQAyniXagzF04gSlvO3R6wmBiiY5pM=;
	b=F+c7Ty5MHDd0atKwWzhDfKWcJntgAtNzQsV77d0FIqrMPpMEUlNoPio5SEyFjS5eG6BwL3
	hgVggcRgjThz3bFX5nV0bRGYNIYYKOyq2kZ0B2+8jvzWULCzIGRMx1PdIEPYUKsVEp1IR/
	ZJ7vgR6uAgNl0dNDhjw5Bzrj2XrpbkkfQzOfmjw90+lbixQzPLUxtP9jp5Ju+MqaEzKAXp
	i2U3kCPtyjbDJmv3AkhdeuONzShZLu3TRJ9Ui9HO+bszoB/LOa53oXNG40wFF0sRq4DzYP
	fugPIrPWNadO3CLvWlGgyXaTDDpMLY3d5J5RwH7bzB7gM0Rc2E2JGvpDwElZLg==
Received: from [10.35.35.107] (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 7066E2404EF;
	Fri, 16 Oct 2026 17:50:25 +0200 (CEST)
Message-ID: <892399f9-0fcf-47e6-b07e-434410afc694@tk154.de>
Date: Fri, 16 Oct 2026 17:50:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] net: ethernet: qualcomm: ppe: Fix queue access
 and port validation
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, jie.luo@oss.qualcomm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, quic_leiwei@quicinc.com,
 quic_suruchia@quicinc.com, quic_pavir@quicinc.com,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20261016150140.929729-1-mail@tk154.de>
 <179216336717.408196.3512649985663407159@kernel.org>
Content-Language: en-US, de-DE
From: Til Kaiser <mail@tk154.de>
In-Reply-To: <179216336717.408196.3512649985663407159@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 88f7fa
X-Rspamd-UID: 6224de

On 10/16/26 5:09 PM, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi,

The multicast indexing issue was reported by Sashiko. The oversized
bulk access was found during follow-up code inspection. These issues
were identified through review, rather than an observed hardware
failure. The register layout was checked against Qualcomm’s QSDK.

The binding issue was reproduced with compiled example DTBs and
dt-validate. I tested the fixes on the Ubiquiti UniFi 7 Pro XGS
access point (IPQ5332).

Thanks,
Til
