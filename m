Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35563A784A;
	Wed, 23 Sep 2026 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189286; cv=none; b=UaoZ4WMfLsraI8bP73/6xYepQtW/hGqXmdygD0+r76QlMd84P79vvl+02GressiM1Ue0qRlEUs1WhazTyRNNPaStmm7+rIJk/EdnAfuwm2cs6vkmKG/1X05CpYtMuuquuOfWE1JuwKj+lANFiiIYqqdMO/zKc+jCPl99lBRC9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189286; c=relaxed/simple;
	bh=k8EZL4KxKCQis9I0X+aPXQR1BWe8+Cm7B3eUYTKLaZ4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NN1/OZq+ydKV5Dxz8M0DiCZVxD8LhBzAQX9PFEmTcI0u5OV9WC1mWkME7B+jBMPztXHszlDX7CW2aNm5W1fDcFCNjonMk+8Q5Nw5+h6/SDI4v850Wym+7aDK+OhCRWjv7poyTkV8x7TGALep5XkNSS1PW/CoZw57/1WXhpH/5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pO2R5SCJ; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pO2R5SCJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1790189254; x=1790794054; i=markus.elfring@web.de;
	bh=k8EZL4KxKCQis9I0X+aPXQR1BWe8+Cm7B3eUYTKLaZ4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pO2R5SCJ161+rxG6SfFWUfAz5PWyJ2+YaKsdAgM40QJ1XtNBwLrX+vhR8MW431yK
	 TPbNx6oQOvieBC0yoYshv1HuCbESJgE2rR4lFNTTMuJ/TQhyipNmhwT0bwOj9zmkJ
	 ecOpOFy3qrmibv6NjwRa+U6wHdzzRe4AV60V6Nv0kxRZXjV+bVUs5pBWInQaxSOIN
	 OtJX5EoPFb3EGnaPGx4NwmzTzKrOvOJCBjmBrTH+VkcYbAIeBsdKtWGHuq4ZWXSfb
	 mQg6v3CAPyxmDzTmOgp13702ZL2IAL+ShaFvuDijLJHdqE/VcZbXXNRinU02O5jr/
	 dpvFSmR6fZzsMjAqcQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAcpW-1x2sRC0ZEu-00HYaW; Wed, 23
 Sep 2026 20:47:34 +0200
Message-ID: <b5330257-f5f6-40b5-ade9-0a0a739bf1fc@web.de>
Date: Wed, 23 Sep 2026 20:47:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ginger Li <ginger.jzllee@gmail.com>, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260923084055.65091-1-ginger.jzllee@gmail.com>
Subject: Re: [PATCH net] net: dm9000: Fix a recursive lockup in the TX timeout
 path
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260923084055.65091-1-ginger.jzllee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Otr/KzyE+Wde8h1tqQWVMhL0pz/ahPTtieAra3PIt7YU/8pqgCo
 DPYb/U/KjhDBYzmtbpQFldrCnz3QagsSavtJGcMiEDQRQjbfp0QG3uylyAO9M9DRkZfMUVy
 00sLvGBnhTvxFpqyO8SrA+b01JdQmMOtPeJ4XmYld5Mk1XBZnBm7w4DmHRJUme5MJYprBGM
 9xspa4+3kLGahJ98WLgAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wXwPlxxGJAw=;vQOCvc0AcO3qqUEMEjNjkKkJe1U
 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
 Nl0tIk88nXUlerlQ9e1g8XYdBIYzzMysz4g==

=E2=80=A6
> Fixes: 6741f40 ("DM9000B: driver initialization upgrade")

A longer hash would be preferred for such a tag.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.3-rc4#n157

Regards,
Markus
