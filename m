Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E295EEB3
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939979; cv=none; b=JMTyo9nHMAZU8FjKUApQOUi3ljZibCtjQLe+7RbWBGMdCGtyJ5cv+5H9TyByzct0WmoFxCVpSyIsrCAUU3IxNrDDksSexEbpdS/LnEFndqFLtTKYX7/udRqaoM+/C8UT181UtUnfiFZKh3F02RFmBnz22KRlaQESO35bkwIytd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939979; c=relaxed/simple;
	bh=8LYqQzpLG09bfqLEtTjv93/ItDF0KoR263B1JWwqryo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rzzl49N45zTVapp758LvvbGOKyXG8ZaRGxmjViXJTpxBN6L8Eh12ROVyGjBsjghMu+FSgEsf6wvtsglkigL0KkkMB8/Uc0ZCP1nNUBp/mGLPNCQfPZM0Uv6cqJ5Tyg03vw1hngB2WEnkfQ+ZivxRhh8oqurDgnbfzVeC5UeBIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=BEw+sOu4; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="BEw+sOu4"
Received: (wp-smtpd smtp.wp.pl 8947 invoked from network); 1 Jul 2026 23:06:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1782939968; bh=nxIp2ejdqDSCnNtY6qeUSmOQz7mNR1tzuNm8WC9oE+A=;
          h=Subject:To:Cc:From;
          b=BEw+sOu4abFD2lmkpCivxz2cYXGtPpO45S2HhDa3W8+6iqdY4ok0QP/XcBeE4WQ6n
           iQL3Ab8zKCKIHUArI0tKsx0KUWkIzX1Rv+qPmo6GL3XBsWIGDCYV9BfWIOdjH2Sb9j
           x4hRjpMyuEmAEyg0s3K8XLCN3NCXKGDapTH99Q6NkTT/reIQ9auDRvDRM9EsLpAkYA
           Roo2Hwnz3bN+YuvSciIYgERN2cHfe3kBzMLXfbLCVa2GjvjPjbB3+Q3N8gxjz7e6/q
           rc9yRzNKYzLaZDbT8wjLNf9vljuN77b8RkgNwYCCSb7qLSxkNNw0MVIZ5jfybx6lbC
           i76e6m31it3JA==
Received: from 83.5.235.152.ipv4.supernova.orange.pl (HELO [192.168.3.246]) (olek2@wp.pl@[83.5.235.152])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <mail@birger-koblitz.de>; 1 Jul 2026 23:06:08 +0200
Message-ID: <8c0381cc-3612-4ddf-85ed-df09bd0a9dbe@wp.pl>
Date: Wed, 1 Jul 2026 23:06:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RTL8159 firmware
To: Birger Koblitz <mail@birger-koblitz.de>, Andrew Lunn <andrew@lunn.ch>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, hsu.chih.kai@realtek.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <20260505-rtl8159_net_next-v4-3-1a648a9c4d8d@birger-koblitz.de>
 <20260701171327.2916132-1-kernel@jfarr.cc>
 <5dc0e654-0bdb-422c-9049-94ee6d8867e4@birger-koblitz.de>
 <8f349e00-1710-428d-8c70-5d1b1f4d42f3@lunn.ch>
 <6677d82e-2b8c-4173-ba6d-6743a5059bc1@birger-koblitz.de>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <6677d82e-2b8c-4173-ba6d-6743a5059bc1@birger-koblitz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: fb1e7a58e08da6673ff10da37636e03b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [8dPM]                               

Hi Birger,
Realtek recently released firmware for the RTL8261C[1]. I expect
the RTL8159 has an RTL8261x PHY built in. Do you know whether
the RTL8159 firmware consists only the PHY firmware?

1. 
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/rtl_nic/rtl8261c.bin

Best regards,
Aleksander
