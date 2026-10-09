Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D9237703A;
	Fri,  9 Oct 2026 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541324; cv=none; b=t5mYkESHLox3QM1WWxnpO9WNQ/gFtpFPJ92YCKYemgCav7NWALaOCZD5dSO3ApFQsNGO8NZERBohbvyqckM2236ieuCULqjqMxkkAQdxS9Xdb2j87l9lcynjBsuEvoEPVRL4DDOmc1s4HjUo3q13G8rcABAnG5MxQU+PM9QZo94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541324; c=relaxed/simple;
	bh=L6Sx1vMqZn887cz8nzz3NVsa3a/Jl1XdxBzm+2Vl8tw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Rk0eapXBdVcHleq8ZJOvYf8mYg/GUDvvaPBd5RFfR5OBrHCY+LnrDUlUT/nyhI+Vk2W+t+xxDnRYh8WXT3I2TIAD17RoMZa3zQjpiHV83FojpYyN3EZFdmlt9st7WRQlOnJUn+BC///7T60+7z7cpYVa0gp98FYgXL9OtKkVTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=HzPle/X7; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="HzPle/X7"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56277A1551;
	Fri,  9 Oct 2026 12:21:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791541319; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=x6Er5OwemVXE3Cgg+GCVstZcbgHQ/IMeEURjTMuCJxQ=;
	b=HzPle/X73MRESoEmhjJEUNq9Z2UYkNNnUIytV7fpLYtD0ZthWz+CuNDXVg9+cmXz2NJU+K
	khEEBKfJoK8qZGwlx/ktK3DDVwW/k3PKMCT/vXCnvHuB6+dVZfuXvte6Usb2576210EFLr
	DxtdGUpjDLoIpZ25DwK/Eg4vOfAay4UlOidEhjsvuRFm9pqbN9D0pdjpoYr2n7sKEOZt1p
	I7vVPPFG+J2JC7TY7CqDUeU0Zi1wjIWiJ2nScycUuF7yUh8iOprt+zcDjMgKvKytQalmSn
	sQ+LOKIs65rCPGHEniSobPhKPoViH5wj+eGwhI2981JyleTl/eaJsM/iiMuYyg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 09 Oct 2026 12:21:58 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sinfo@kernel.org
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: unshare the skb before writing the
 control block
In-Reply-To: <179154086308.2527009.8212996211776873499@kernel.org>
References: <20261009-nb-genet-shared-skb-net-v1-1-c6d0a841977d@tipi-net.de>
 <179154086308.2527009.8212996211776873499@kernel.org>
Message-ID: <0cad05a0d355a6bbde0f36d0f252d56a@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9.10.2026 12:14, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

Raspberry Pi CM4

> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
