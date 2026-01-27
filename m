Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DDD230BD5;
	Tue, 27 Jan 2026 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533450; cv=none; b=Xe4S55cx3A39v92k621bkW2DEwwfs9zszYWBrmo9/rAOprb4RUAUaxIek20GvT3VjcoNZLkGsotNaSv2yJjRzobjr9PmZO+4SSPgMYGKGlUF66DTuRxvrfRAqYicEya+IpUKUFeuN5THd4nhEY/rgiQ3wxjFy3/RqOM5292S8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533450; c=relaxed/simple;
	bh=CLbX10FOpGfbSRQQ1CxzVCEQDHooEy+rXOMRV/pi2eM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrurMywUkXRA5wI9I6lJmGytzIyJ2dpot0vpbXMldw6WleN28S0E2W0q5YK5GFJ8JeSr4QsG54juggRS9Aa9EQIvdR6ZAjYgNd0pRQVXRc6TQBYjcVWvipYOrypp4fzZpwwu/iCo6E7Oafawg2/3n/d3/k4X2mMoxusTXcGNvLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gF9Uvrx1; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gF9Uvrx1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8E0C24E422D4;
	Tue, 27 Jan 2026 17:04:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A0AD606F5;
	Tue, 27 Jan 2026 17:04:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CFD25119A867D;
	Tue, 27 Jan 2026 18:04:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769533445; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CLbX10FOpGfbSRQQ1CxzVCEQDHooEy+rXOMRV/pi2eM=;
	b=gF9Uvrx1Hx4o+3B4/naGi0evZIqZcwnBTW1dZq2qoXpxHY2oLfTcW4q+CwbIA9J4/yQ6kj
	retfPMDcEOJUs0tY9N4dV3SkkOlHv8TdwQkqsVUr/0jbtim78mxyIMRXZ+jDWj1YO1OJhh
	4CzYy5HvR2wet5EPTgkbIPRkiAMiX+Sdk8II+CTLBY8gGdDG1To1s5p7wxje3CXhr/C9f5
	so3x0oJLU/4A748FPV3PiDEvbK/oLJ7W7Ujn/fvRa9qSbgjoaZQ2lSy8LLvhIW+e4nj0rC
	6Fsk83PLIrmiP0eOnIAainUkA3z6VM9a0J5NXgGqrO2Dwe2WD5IE2NQ2+gEg+Q==
Date: Tue, 27 Jan 2026 18:04:01 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, jianhao.xu@seu.edu.cn, kuba@kernel.org,
 linux-kernel@vger.kernel.org, marco.crivellari@suse.com,
 netdev@vger.kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v3 3/3] net: liquidio: Initialize netdev pointer
 before queue setup
Message-ID: <20260127180401.69787770@kmaincent-XPS-13-7390>
In-Reply-To: <20260127151241.1144039-4-zilin@seu.edu.cn>
References: <20260127151241.1144039-1-zilin@seu.edu.cn>
	<20260127151241.1144039-4-zilin@seu.edu.cn>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 27 Jan 2026 15:12:41 +0000
Zilin Guan <zilin@seu.edu.cn> wrote:

> In setup_nic_devices(), the netdev is allocated using alloc_etherdev_mq().
> However, the pointer to this structure is stored in oct->props[i].netdev
> only after the calls to netif_set_real_num_rx_queues() and
> netif_set_real_num_tx_queues().
>=20
> If either of these functions fails, setup_nic_devices() returns an error
> without freeing the allocated netdev. Since oct->props[i].netdev is still
> NULL at this point, the cleanup function liquidio_destroy_nic_device()
> will fail to find and free the netdev, resulting in a memory leak.
>=20
> Fix this by initializing oct->props[i].netdev before calling the queue
> setup functions. This ensures that the netdev is properly accessible for
> cleanup in case of errors.
>=20
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.

I think this patch should be moved before patch 1.
Thanks to Patch 1 we are now cleaning the failing index, but we could face
dereference NULL pointer if we are failing in one of those
netif_set_real_num_rx_queues() and netif_set_real_num_tx_queues() functions.

With this patch moved:
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
