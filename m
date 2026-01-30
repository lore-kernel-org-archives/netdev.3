Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DD735F8CF
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794174; cv=none; b=Ru9CtAbdZKtb7w+97zSgPA2/h+h+j93JbquLFkI1ytW91fjRHfjy7EALb29Gc9Wk5icgUhiPPNoqX3e28n6Far9qP0GXkf7DmJvroZwdu8rbBbrrAo4Ebbajk8J0C6+vHJ1h6bQglZUvIP9wvsrn9iybxWIns8kYxFSZvkI54mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794174; c=relaxed/simple;
	bh=Wrv9Y4I5ydqMJdrJ//SUPBp+6pAY9NDi/k6uVfxPm/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPTZisw/9ck9iE+14enIY9eLFMquMcjIu72J2rGGZm03laP/KIL5mA7iCAhmRW5pshKVykLvlqOriVLiJG1NDx9AqUa9YyaH+xM1Poce3r9mvqwiHA79nqWM60uy/7H79S9z3F6A/etCOCKbRExsWbxP3EhjMmCnU3beLyksoRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XVPFzqWE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XVPFzqWE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 863CA1A2B3A;
	Fri, 30 Jan 2026 17:29:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A8BF6075A;
	Fri, 30 Jan 2026 17:29:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97C22119A8875;
	Fri, 30 Jan 2026 18:29:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769794168; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BZzFWgEUHdwooMtG4TuZHw8S0x/mQPwXY7nuasg2QDI=;
	b=XVPFzqWE/z0q/vA8cfnLwOCF3GNHBAMElHHkvpKxj31B01szcfHhv/MKqqagCBZ8AupfGP
	iJnYgAFQPPqjQz2LP7F9tPLSXhQ/rveMFz5B1N3+K0PJTHrk2FIjdlIEuMWQ6nEoy35VIu
	fGu7Mpkvbtq2hLUetqyQN58STUftYZ1PBBZ+NbZsE2+H+nXU6U4z6X2rRJZh7AbmyIuUWv
	jcKaGmFoFFRS9yFM7L7bkbIVuuA5wPQmKwXIPbUig+QD8Q6t9z6n0nK0TnDyodFKE1FDdk
	EgQqGJaF7h7V+QOEE/qTXrfJRJrssg1ZsYssc42w0PaeeYTQTsBNqNZgyGvmjg==
Message-ID: <9dfdeee0-7758-439b-a2a5-a7f243427cf4@bootlin.com>
Date: Fri, 30 Jan 2026 18:29:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: stmmac: clear half-duplex caps where
 unsupported
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aXyRlFw7ZuhRPiKo@shell.armlinux.org.uk>
 <E1vlmOQ-00000006zuz-0ffN@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vlmOQ-00000006zuz-0ffN@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 30/01/2026 12:10, Russell King (Oracle) wrote:
> Where a core supports hardware features, but does not indicate support
> for half-duplex, clear phylink's half-duplex 1G, 100M and 10M
> capability bits to disallow half-duplex operation and advertisement of
> these link modes.
> 
> This will avoid the need for special code in the PCS driver to do this
> based on the ESTATUS register bits, as the support in the PCS is
> dependent on the same synthesis choice as the MAC core.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Gave it a quick test on socfpga, as this impacts all variants,
and we seem to be good so,

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


