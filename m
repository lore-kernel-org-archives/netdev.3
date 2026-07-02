Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62E3A9638;
	Thu,  2 Jul 2026 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016804; cv=none; b=B7uT7yyTHLoy65o2maq/U3sYAC9WJR9SfkdWR3x3ceXaObuvjKGrMRxJTbUJykcRr5lYDFKSNMHURqX1LiXR/+1XNve/16jk+pg71UVHTM6M/9lchuKoUfbg0lNaG+8GHH48/ARDzkE+lVYLVKKb+o55fWI17exn4+0W6mZaLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016804; c=relaxed/simple;
	bh=lSUFzsE7mplyxqUi4aeaKIQaZI131WHBeCE0MkbU4WA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQT2kmdibDFx35ejsSkFGWkBix6unC/boyN2dsBuOL1cBKfdWxomY3wX07kwnsyediuZWngU03v4vRNdRC/F3nNUUdON8dhzRmPy2h3q3c+DSXypR9Z3qKZzovou1g5n55sqOyeF+6kvc3555ZhQvHXWR1oFrFzKmSw04B/rsS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mWkU9T2r; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mWkU9T2r"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4grlhb48c7z9tyx;
	Thu,  2 Jul 2026 20:26:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783016799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lSUFzsE7mplyxqUi4aeaKIQaZI131WHBeCE0MkbU4WA=;
	b=mWkU9T2rLnuYlk04/KIhVLpIlQDcVlV59YSh2X2VcSKCQVsL/VYn1dh9Gvi8g5QU8+iJt1
	smIf3ISRSzLo8JH0Fhkl/G31BgmK7R9gLFklGdMMtB/OSQJUj47yv7WzBXqq4ijdxl6zoQ
	Xe4lmLGS5/Q1m9qG94ehQEDSewftcKwCV3p1e/lxpJhUrPkEk0+0q1j9dGfVbs2M72KivZ
	++0HWzylphfIy9UXcx2SkkXA4Pg6DxpArdmCOUydLelvSx42izJcDHH22gdpU+GnLNbP3B
	zsYRR0jzaeN58DqtVcs01KO9ESasUZZwBjL3S8GIDBdX81KCRQmsJNQDRfQigA==
Message-ID: <7f05292b2d95d75dbb30c076bdfa2f42829ba191.camel@mailbox.org>
Subject: Re: [PATCH net-next 0/4] net: usb: move exported code to usbnet
From: Manuel Ebner <manuelebner@mailbox.org>
To: Oliver Neukum <oneukum@suse.com>, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, 	shaoxul@foxmail.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Thu, 02 Jul 2026 20:26:34 +0200
In-Reply-To: <20260702143142.890654-1-oneukum@suse.com>
References: <20260702143142.890654-1-oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: wy76t9hcbi3coe5jn3sgm7gf9tgnzndk
X-MBO-RS-ID: 2761a2d186326e98263

Hallo,

On Thu, 2026-07-02 at 16:25 +0200, Oliver Neukum wrote:

I know this mail doesn't matter much, but i can't leave it as is.
> Some drivers are reusing common code originating in other drivers.

Some drivers are using code from other drivers.

> This means that two drivers need to be loaded for one device.
> Also maintainability is reduced if changes in one driver affect
> another driver.
> Shift common code to usbnet.

You can add my=20
Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>
to the series.

Thanks
 Manuel
