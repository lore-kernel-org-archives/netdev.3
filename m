Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C1221FB6
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532675; cv=none; b=YgjAgXix/tPCBgTJjri9VJm8jdQVWXQ4Wb3Ld/2xsflYnHWPfeed9DqbRz82HMuj8TAwRkSHlCQz5P/6BJbF2yPss9amL7vUCAy1WsqIQTsDijfkIasN9H7aKwQhgqBJWasAeTfF7AdOoKhXBgZ6DTspNzzzcvdhsXMd9wJYB9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532675; c=relaxed/simple;
	bh=MiXiUIs2ptSQbYwUZ2qbvhUhqOFqhMYho0KH0pV7c44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEqRMlLhU3ly4Acka88veYgBBhB7YE4L634HHfjUq6W7soclyh4lqF7KOetwOz5+le2wBkoQp7p8Yu/r0t8ZuCumbr/MUh0x0K5R9JSsmfXUMrbiryEPFop+kU9vFI5OCx5AJhwLnhwvSSjgUPi9WIlt80gHIyCmqXNgrqxlvjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YWk6gscj; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YWk6gscj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BDCD8C211C6;
	Tue, 27 Jan 2026 16:51:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92292606F5;
	Tue, 27 Jan 2026 16:51:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ADF27119A8695;
	Tue, 27 Jan 2026 17:51:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769532669; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MiXiUIs2ptSQbYwUZ2qbvhUhqOFqhMYho0KH0pV7c44=;
	b=YWk6gscjerrfJ1VRAL1zMsEgeqjk/egmEJXkM2NUUxCw7gkEKbMEazVLkUeITYTKGP18M3
	YSqhz2pwQ94+UQme/1n1yimxtaJnhub1jbvbDpfWTzLnlS9+jpKOFjlAlyCaopWFhP4etH
	eLkL4urNbcTY7oD8iCCsL35dgvweV4lYJK8JlMITgfnNXZ4XOhj9seoi9hu8YN3X0i76UE
	iFedursQdHqnuOUINa0KEQGyw4LuKAPb67qzZg2P+OF0/52eWUNdnlwwdKZTKdHYYP0zvI
	ukTr+G197sTAVbUU2Nr/n9To6oUL211VBw93stGjQCbrqxwX6LXhhdDjNNcXDQ==
Date: Tue, 27 Jan 2026 17:51:03 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, jianhao.xu@seu.edu.cn, kuba@kernel.org,
 linux-kernel@vger.kernel.org, marco.crivellari@suse.com,
 netdev@vger.kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v3 1/3] net: liquidio: Fix off-by-one error in PF
 setup_nic_devices() cleanup
Message-ID: <20260127175103.19831bd5@kmaincent-XPS-13-7390>
In-Reply-To: <20260127151241.1144039-2-zilin@seu.edu.cn>
References: <20260127151241.1144039-1-zilin@seu.edu.cn>
	<20260127151241.1144039-2-zilin@seu.edu.cn>
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

On Tue, 27 Jan 2026 15:12:39 +0000
Zilin Guan <zilin@seu.edu.cn> wrote:

> In setup_nic_devices(), the initialization loop jumps to the label
> setup_nic_dev_free on failure. The current cleanup loop while(i--)
> skip the failing index i, causing a memory leak.
>=20
> Fix this by changing the loop to iterate from the current index i
> down to 0.
>=20
> Also, decrement i in the devlink_alloc failure path to point to the
> last successfully allocated index.
>=20
> Compile tested only. Issue found using code review.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
