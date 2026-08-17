Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A98F24A044;
	Mon, 17 Aug 2026 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967141; cv=none; b=WazjKzt1Tbt84MeREp6+MgUf5HQslzObi8sp70x47oHnXGIe4Ku/TpHp21NCFua6bMqJi5SWYnTuSYoc9YAwYdXgyhIz4LP5qp5oa69U6oj5XOk1qu++wH/HqdKy2yrApsB75OXwZ/MQ4KYgm1sP8jnpUYwVsuGPp12Lp0fWX+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967141; c=relaxed/simple;
	bh=dNIGP4g3BP3MKwvWJHgaw5ag960FIzSOdPTFANcGGeE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qf7qmfPF2A1N+E/jt0fHOVxi1Og566y0JQhbWaz6HX9a7TyTg+WWiX8QLXT8bEJQRiPYIB2UWteGZT+gMXQrJ/acSGJG39tGhNtguPvhvMlQ+FQ9GVyhsaBAqKpvQGqprsmitJee8uN4pvHovxsQ2+2KVXQ2zabflTxjf5Kl7Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UPwRiEh/; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UPwRiEh/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1786967126; x=1787571926; i=markus.elfring@web.de;
	bh=dNIGP4g3BP3MKwvWJHgaw5ag960FIzSOdPTFANcGGeE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UPwRiEh/AnqUcjOaL45hTsoMCuPPukKHX/M+u8rwmEBCc31Gh6ptvmX3SjlliLPo
	 kcWrBjgwQDVJmWLBgWHnsYXMMdrdgqg7q2QILBl4mkqfuwZ15nseCurDB0PFL6OQu
	 rfP5jCya7WjuOqGZIYpduMD9u7iD3c1cbh69NdB2wdECpqnASB+LKADnZV7aMe2lh
	 NhMekZWhhHKlBm6tQN43ZZqQcFikPZuxspvjp1ZaNUwNsK7cVZZh9r1wySot8baao
	 IDhVpxHqvLwCTuhHLaB1PDBx9IaECg7N3ERBbf40nx5oOpTOotE1jerp95D6yWJ5z
	 H0Yt2MhPcqaTvu+2eg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MF2gM-1xBHrR3tYu-00An1s; Mon, 17
 Aug 2026 13:45:26 +0200
Message-ID: <4ba57d20-93da-4f89-b28d-64322a7e40bf@web.de>
Date: Mon, 17 Aug 2026 13:45:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ramses@well-founded.dev, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
 Jiri Bohac <jbohac@suse.cz>, Paolo Abeni <pabeni@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260817-bonding-last-rx-v1-1-9da6f7fdf812@well-founded.dev>
Subject: Re: [PATCH net] bonding: fix initial last_rx vs ARP-monitor slack
 window
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260817-bonding-last-rx-v1-1-9da6f7fdf812@well-founded.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kPVN8/oZk2OU8Hp7JIuGqOV2QUtFvdkezmSPukMxIoImiJz/vnM
 3BYV+HTO4NX5GwJjQRYRxeALZRlrGBUPzEVozPmF1Tas3/oLf0193Hmt9eVD3hwmd3E/LJ5
 3Rj5aXGAOkB/B92X6SJB25DF8rIzKxSsW9rcGQEKrEPtX5uXWdb5kNx5s1H4TzyAbXBDNek
 PPpaWKlcjs4Qhe8N3Fg1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n1XrLrW7xBA=;px0jfnPQB+XZ/47LsIvh5JOqJ/w
 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
 FSrRVZg==

=E2=80=A6
> Signed-off-by: r-vdp <ramses@well-founded.dev>
=E2=80=A6

Would an other =E2=80=9Cpersonal name=E2=80=9D be more appropriate accordi=
ng to the requirements for
the Developer's Certificate of Origin?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2-rc7#n396

Regards,
Markus
