Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F413655C0
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915383; cv=none; b=jXmTZbIA3YSWlgQMKjULQJRU0SwuxpQHYG1cp3NFTqtHf303mI1n+idU9Y8x5i11TaKm0qUMqcJZDt1tTgRIZzn2PkdSbBJHvwa5DDraMCjQ1WpgPSMu5kGORatIwA3o98b7zoYnyAoa29EvwEvCnpR+2NeRJFTedUX+fXIoNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915383; c=relaxed/simple;
	bh=RYeJLcEXZBYLu9LHyzUJOKDLaD/9TB4gZSv4Hp50zSk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=lYxWTZVAiHym9uyPfWSIJA/cbI1xI8Aim3aKV+0rKbjJoGhDdbUpyGsQCILHoCeWeh16IZRnuvU6fFtzPYJGgZ7+zeriDG9GmKN/mDs2DI3u7lw3KNw6F8M7KNQNoRZ4OqLKfJNqa1IpncBBKGGAegFBWo6VE1SM7+XT2s88Ax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hJw+Zv45; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hJw+Zv45"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 788414E40F30;
	Fri, 24 Jul 2026 17:49:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3462160395;
	Fri, 24 Jul 2026 17:49:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2362211C129F9;
	Fri, 24 Jul 2026 19:49:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784915377; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HlIDVmN4+8wTeXWnEkv0c2nu0cFswC79Jtcfr3hB4dM=;
	b=hJw+Zv45qG/7ivEv5oNfwub6roM7CypRXxkV8GcaTD8dJDeb6ea54giDj4v7O+NgJ2KNxU
	HaByFVDq4ZVQzqvPelOvY2kDoQVTBY+p0efNAQ95tD//hj7yKrLbLnZSJ1YBr+UySz5E2m
	isVxeZvEEX/U/5/mt4JP1OQT/OILH4NU+nEpuvdWQpIpLvpg4J7WuLAOr6U3hdvRj7QLPh
	uHROIlQaCoIJsSWPRehmMkWVulMQJ0xclQjfjP4/QJ8VTP5Jjwyt/u3BPY3OeLq2o+2o42
	cUs+SqZcEm/a3vdCHztlrqSfjAp7LGMRDOGzpZsZq7YaYvCoNDqI4IxepCnEJA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 19:49:33 +0200
Message-Id: <DK6ZOYLXSHMC.17JND945LG2HU@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 1/2] net: macb: remove unused ENST Q0/Q1 time
 register defines
Cc: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Vineeth Karumanchi" <vineeth.karumanchi@amd.com>,
 <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260724043257.2221030-1-vineeth.karumanchi@amd.com>
 <20260724043257.2221030-2-vineeth.karumanchi@amd.com>
In-Reply-To: <20260724043257.2221030-2-vineeth.karumanchi@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Vineeth,

On Fri Jul 24, 2026 at 6:32 AM CEST, Vineeth Karumanchi wrote:
> The ENST start/on/off time register definitions for Q0 and Q1 are not
> referenced anywhere in the driver. The driver calculates these register
> addresses from the ENST base offset and the queue index instead of using
> fixed defines, removing the unused macros.
>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>  drivers/net/ethernet/cadence/macb.h | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/c=
adence/macb.h
> index 2de56017ee0d..a11052565436 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -184,12 +184,6 @@
>  #define GEM_DCFG8		0x029C /* Design Config 8 */
>  #define GEM_DCFG10		0x02A4 /* Design Config 10 */
>  #define GEM_DCFG12		0x02AC /* Design Config 12 */
> -#define GEM_ENST_START_TIME_Q0	0x0800 /* ENST Q0 start time */
> -#define GEM_ENST_START_TIME_Q1	0x0804 /* ENST Q1 start time */
> -#define GEM_ENST_ON_TIME_Q0	0x0820 /* ENST Q0 on time */
> -#define GEM_ENST_ON_TIME_Q1	0x0824 /* ENST Q1 on time */
> -#define GEM_ENST_OFF_TIME_Q0	0x0840 /* ENST Q0 off time */
> -#define GEM_ENST_OFF_TIME_Q1	0x0844 /* ENST Q1 off time */
>  #define GEM_ENST_CONTROL	0x0880 /* ENST control register */
>  #define GEM_USX_CONTROL		0x0A80 /* High speed PCS control register */
>  #define GEM_USX_STATUS		0x0A88 /* High speed PCS status register */

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

