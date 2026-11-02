Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793592224;
	b=vdYXKYBV0lDZiYdSOsM99wfPfG+Er0CzHR32IribKp8My9HM7BkudiZdap++H0r7HvOO
	 IjaWrpMGk5L3bAUigzmByMiUYveyTubk4hFvsUR11lraezDCf6rBLN/OPm0BZztVrrSK6
	 LXlDtAVRujPlbaXyJHmqz7UyFkNp4d4HYLO8mmiqfPobLmHzLorHkgLSSMRVd2kfz/yBu
	 seyW3ModXEMBZ4rNla/lFfwVtZiDg+H3XR4LxCQa6lFhBiDBhMzE0lo3uhlMJDLZwD3yg
	 nNCVA7EHfl2065RdiH4iLMknraypJelK+aJ06k6nfInCsVwzp4OBTGEU0objLX0sefA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793592224;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=wTsAHM77lcB0bP9i+ePrebONUw/58fDsvo3achhO/jM=;
	b=DAVy+IxlkEV0xYv2s6j4FIkFyX8L9FON4DgNc/bvcYoioCMbqU/PHWdGzESBM8UE8sl5
	 xKIG9QQDPLfDinBuE6Zxeo76LoaGvBHqrzrzAtDoCh5Z9NEXttMZVczHm7kd3pwjxiP0M
	 JRK/CZti6STF3aVoWevLGFDYoa3OPm8+z38OoBH4n+1BDYvLtlENbD6JCHffEZC6boj5R
	 p5vtJheFzp/j170VVDMlphKZaA6w9t4b2w6kXtHe53WUM97XSFO8bOsDGbhfB9VfPJk6H
	 buMNp3azD/rXSfAxdMR6wEjIVnx6abI+ulOyS9+/LzL3otNUxuvaPoPSoffGr6l70Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeconstruct.com.au;
	spf=pass smtp.mailfrom=codeconstruct.com.au;
	dkim=pass header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XqxtgMze;
	arc=none smtp.remote-ip=203.29.241.158
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9FB606A329;
	Mon,  2 Nov 2026 04:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B9FB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XqxtgMze
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793592220;
	bh=wTsAHM77lcB0bP9i+ePrebONUw/58fDsvo3achhO/jM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XqxtgMzeDPgwCwPFzRFBLbEboxpm+5MEr3r5FtVmgcta9YNoWuFxww9CgnEqqwOTV
	 l1zS8CAL56VE1l1y5wb2Lb1mabzop5ql/0tbSuL9SSYbanxgslnlQUkMFPP6E+jVvp
	 sfpaZPFfNwKhdiI/zkEUSpjpjZHU9CMFvB30t5AIjlagxD6sE44X6bIKuP5BYaT9nz
	 JR22CxQ4fFqhVh/O37LOlYLDWGqapn57IFol+VH+6lwCrknbrYkMCyBJe6yGHtLTy9
	 3tRRUWVDQxw3DMfwXFmzYiUkjFm06qNIc+UPDS6L83mO7CLZA8FPzvvv2zMO7dmbt8
	 PjtO16/piol5w==
Received: from [192.168.12.105] (unknown [144.6.157.237])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 62127648D1;
	Mon,  2 Nov 2026 12:03:39 +0800 (AWST)
Message-ID: <e83e3ae9505a60b58acc960b3256b5970fb5cca1.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] mctp i3c: Fix locking in an error path
From: Matt Johnston <matt@codeconstruct.com.au>
To: Bart Van Assche <bvanassche@acm.org>, Jeremy Kerr
 <jk@codeconstruct.com.au>
Cc: Leo Yang <Leo-Yang@quantatw.com>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Nathan
 Chancellor	 <nathan@kernel.org>, Leo Yang <leo.yang.sy0@gmail.com>
Date: Mon, 02 Nov 2026 12:03:38 +0800
In-Reply-To: <71e0a880ffe7a83237e501b07884bf54343e76ca.1793296780.git.bvanassche@acm.org>
References: 
	<71e0a880ffe7a83237e501b07884bf54343e76ca.1793296780.git.bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-10-29 at 11:00 -0700, Bart Van Assche wrote:
> If netdev_alloc_skb() fails, mctp_i3c_read() jumps to a label that
> unlocks mi->lock although that mutex has not been locked yet. Fix this
> by returning -ENOMEM directly. This bug has been detected by the Clang
> thread-safety analyzer.
>=20
> Cc: Leo Yang <Leo-Yang@quantatw.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Jeremy Kerr <jk@codeconstruct.com.au>
> Cc: Matt Johnston <matt@codeconstruct.com.au>
> Cc: netdev@vger.kernel.org
> Fixes: 2d2d4f60ed26 ("mctp i3c: fix MCTP I3C driver multi-thread issue")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
> v1 -> v2:
> - Return -ENOMEM directly upon allocation failure instead of adding a
>   free_skb label.
>=20
>  drivers/net/mctp/mctp-i3c.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
> index 4e857dd5df64..5f225999d715 100644
> --- a/drivers/net/mctp/mctp-i3c.c
> +++ b/drivers/net/mctp/mctp-i3c.c
> @@ -111,8 +111,7 @@ static int mctp_i3c_read(struct mctp_i3c_device *mi)
>  			       mi->mrl + sizeof(struct mctp_i3c_internal_hdr));
>  	if (!skb) {
>  		stats->rx_dropped++;
> -		rc =3D -ENOMEM;
> -		goto err;
> +		return -ENOMEM;
>  	}

Thank you.

Acked-by: Matt Johnston <matt@codeconstruct.com.au>

