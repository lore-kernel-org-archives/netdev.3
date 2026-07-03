Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8913790B;
	Fri,  3 Jul 2026 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098661; cv=none; b=t9he+ZgFY9go/ydsiHVuwl68+LlZ3YRGCfH88+RCyS1qsvTXtNazpsPogCE52NF6rAlWyAUUIsCWZUds9F3hwPT7UpAURKLj3gvFYB/h/jwm2+EbLvnZ3bcLo1XDBoTWsYntOzmvDeHXXaKgjWtBeJwrMvkZsXT491XFZR1B9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098661; c=relaxed/simple;
	bh=SEfbOECHAdKd83Z5IkP2W3jwSNcRYDhl0qhI0MI8yTg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=uKt4Z8Yw9zS2oQmmxJ27Z4RjgoyxZR543CTXvQugweUahFmO2LFeSgc5LSSCbQaBdEarSjmzpOjzdg0BNyBWrOgnDcrkVZV68nqFbQknAbvOTj6E9v2BMPadL3tgoEKzd5VIUnHrQGqFEPGG+W0/5L1rEr6I+UeWBtSl3izLyKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zpw7WSx8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zpw7WSx8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0F3681A0E1C;
	Fri,  3 Jul 2026 17:10:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CBD8860300;
	Fri,  3 Jul 2026 17:10:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4009102F0D61;
	Fri,  3 Jul 2026 19:10:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783098655; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Vl/CpkA15dwhlWKWUEJmdCMHqy3wFCEAENf0qKRdApM=;
	b=Zpw7WSx88EVftjo9ghC4KRZ8LKx++T9mOU8X/aoCe9irhfrR3BsJVErM60W5lIGDUKkMkm
	t+n2B8KtWEO4ZFXRhflphQMPMKnUadnUyYvJxFxCz0aGR2fvB1HEfCAS660YPCsfn+5nfR
	z+ldhjq4MKY9vO6QEU1ziNsSSUYeSSr1HbRNuMm2rDxsXAaCZxGC0CkzfqhceCWCp/S68C
	VFw3nAiSdC08+kwA4/WplaquwL+7Zmnwu3sZ5Gd+PRAqd8DjQD7W+r+5dSLWr14cVpXUhb
	5z6QQ4lOfzimDAnX0XLUhWYZ7pimgd8is46TgaqA2ZHS9aoACAkTT6gc6Ek9Wg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 19:10:49 +0200
Message-Id: <DJP3PVA1932B.3CPW2F5QYOAXM@bootlin.com>
Subject: Re: [PATCH net-next v3 04/15] net: macb: unify queue index variable
 naming convention and types
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Paolo Valerio" <pvalerio@redhat.com>, "Nicolai Buchwitz" <nb@tipi-net.de>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
To: "Conor Dooley" <conor@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-4-00268d5b1502@bootlin.com>
 <20260703-monogram-unable-2eaeaf79676f@spud>
In-Reply-To: <20260703-monogram-unable-2eaeaf79676f@spud>
X-Last-TLS-Session-Version: TLSv1.3

Hello Conor,

On Fri Jul 3, 2026 at 1:34 PM CEST, Conor Dooley wrote:
> On Wed, Jul 01, 2026 at 05:59:07PM +0200, Th=C3=A9o Lebrun wrote:
>> Variables are named q or queue_index. Types are int, unsigned int, u32
>> and u16. Use `unsigned int q` everywhere.
>>=20
>> Skip over taprio functions. They use `u8 queue_id` which fits with the
>> `struct macb_queue_enst_config` field. Using `queue_id` everywhere
>> would be too verbose.
>
> I'm not sure that I agree about the verbosity, and "q" isn't a letter I
> would naturally associate with indexing, in the way ijk etc are. Perhaps
> in netdev it is a natural choice however?

The question wasn't much if q made sense in netdev land, more about what
the MACB code used and to unify the naming convention.

                           Before  After
struct macb_queue * q           1      0
int q                           1      0
u32 queue_index                 1      0
u16 queue_index                 2      0
unsigned int q                  4     12
struct macb_queue * queue      29     25

`q` that could be an index (5 times) or a `struct macb_queue *`
(29 times) was the most annoying to me. As `queue` was often the
pointer, I used that.

`queue_id` or `queue_index` for the stack felt too descriptive for no
valid reason. If it was green-field code I'd name it `qid` but that
name doesn't appear anywhere in MACB so I avoided introducing new
jargon.

If you have a name proposal I will probably agree with you and go that
route!

# command to extract counts
ctags -o - --kinds-c=3D'{local}{member}{parameter}' \
      --fields=3D'{typeref}' drivers/net/ethernet/cadence/* | \
awk -F"\t" '$1=3D=3D"q" || $1 ~ /queue/ {print $NF, $1}' | \
sort | uniq -c | sort -n

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

