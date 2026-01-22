Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6782E2DDD
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092801; cv=none; b=MfQ3EGi8ISrX04FCeOAt8sXMTkYbee7JIHMLXz9eos5+eIp+9ZY5937xGh8O/bchhe+yhxCpaGeqgZVv84/9fkGJqEe+hquiIfCNu75j9eGzffRt2r4AkkSmQqewTgoD91d6OAjBhYc+cSRhkgEvbqwvlMxV2i6Cu4TBKx2N8h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092801; c=relaxed/simple;
	bh=nIWuU59G3w1O3xm/NNvlor/i2KtNWHpneh/VTerga9k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BEtJp1FemEAS6qWyoTloYBHhhwnVq44AThnP1kHqvLIY9BjMORhDSJ57qza5l4WGI1yUpl8kvhw+6eg0lltUIAz5WV1OPwnxd77rQHrxz5mymwDfjvNxva64US0HAxijwlotga2Mg8/u1kCyWxVpCogU3fkVxjkLbsFY+JxzSd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RmAMyAFL; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RmAMyAFL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C892BC21AA4;
	Thu, 22 Jan 2026 14:39:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EFE79606B6;
	Thu, 22 Jan 2026 14:39:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9ADED119B8229;
	Thu, 22 Jan 2026 15:39:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769092796; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nIWuU59G3w1O3xm/NNvlor/i2KtNWHpneh/VTerga9k=;
	b=RmAMyAFL8t/pJgq0rUnWYQKrGzWaNsxwGcTslK8ddVYCzJYLKjzq7huXY0loZg+5U+X74s
	nUtoHaeridH0VPCKJd1/DXKS29gjPIIBhmxCtAtJjOd2fyoeYIjMLctpa+lerq3soIiJYV
	toT6ts8UxzZ9DSGJKGX1FEO1hq3SUnRw6wD22y1SNFCvNcrwYYrkalP4Chlu9WBpXFV59V
	LOQZhstUPsStvz5ovhbm+etA4Ot0DU2Qda2rXDyBzJoFN/ooEqccDV4lkbCTot7P3Rnv/0
	PL9wqehctTm2TmJmTLMqTpbTUvZfDlhVbGc6GMmRvd/JUA4nE2kxu/+vaXzv6Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 15:39:51 +0100
Message-Id: <DFV720NVKS7T.31AL827EQB1G4@bootlin.com>
Subject: Re: [net-next,3/8] cadence: macb: Add page pool support handle
 multi-descriptor frame rx
Cc: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <pabeni@redhat.com>,
 <lorenzo@kernel.org>, <claudiu.beznea@tuxon.dev>,
 <nicolas.ferre@microchip.com>, <theo.lebrun@bootlin.com>,
 <netdev@vger.kernel.org>, <edumazet@google.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
To: "Jakub Kicinski" <kuba@kernel.org>, <pvalerio@redhat.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260115222531.313002-4-pvalerio@redhat.com>
 <20260119193622.1255610-1-kuba@kernel.org>
In-Reply-To: <20260119193622.1255610-1-kuba@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Jan 19, 2026 at 8:36 PM CET, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html

This page indicates the prompt is at `review-prompt/prompt.md` but the
repo never has had any `prompt.md` file. Guessing from
`kernel/skills/kernel.md` it seems to be `kernel/review-core.md`
instead.

Agreed with the LLM's comments.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

