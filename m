Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6CB221546
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786286145; cv=none; b=ZV5Zc/7in1I/GMTezhJI61QIa1wcU8eJJYkEE0EepSDoXa6XKoWHLNIrmscbSVFzH0PA+Uyi0kCsY2MTiCKn2FW2PPgc8iYSwx3Mya+ecB4vsL2VGAmhQkjo6WT3W08mUGEFA1BtaPfv38l+m3NUY8qU1Emnev2Q3P4QolVHtTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786286145; c=relaxed/simple;
	bh=EwBznaVXv/GonOL8yX+GQ9+QJSwI8u4LrGtx5Fikk/4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JtIkXFYoONSApyP4NaNFwlBGwzO0fOzzLh/HLKI5cjk/oWPnkrVEiohEd4LzO7gOfdug+sQFF5bvt3t5czHRN70UCoEOklwsch7Sy0EIdZUy6xC35RhCLvAwctq1u2tCN+fwNZHZa3Ziu+SKY6paMVVAldxbrAJaTN6MmS22twc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5InN8qZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5InN8qZ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47fd4531020so541953f8f.3
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786286142; x=1786890942; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YYlAKIWzs1TvfB7xQgCTpmyRtf3Bl9uF5fd7z3Y9sBw=;
        b=m5InN8qZczTNyLfNExFnEP21tb3SFRY1Tcv/onvOwS5M71l5Q29EJq8py92+sMYY0z
         yYanDQoRuUr43h6JiaMDc1K4z0EwYrx/3Ml8sm0Lnr6MxZoMHiwB+CyT+RP6TjzonnsG
         SJNX4AFgvmh1ZUeSv7/SnA09o1Vqh06RgQ7K+Fin2ysyfKntXYdb3TH/1evisfKCGqWf
         mVNyqUrjPBah/QVo86oFFlG/ntct8s5K6Af1BV7x54DDHprPrOKhMa3y5Kc4vXU8rxzB
         rh8jyM/4NR/rYKHOzJHJCMsC89qUaB+8tpb/Ybod4eYKzCH7M6hjTd/xj2+jtOqpO5O+
         IoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786286142; x=1786890942;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YYlAKIWzs1TvfB7xQgCTpmyRtf3Bl9uF5fd7z3Y9sBw=;
        b=Bn0/HN0aOeOCUW/ND4uzdS1eGKIgeTmsp9BfBng85u6h2yHYJCk947ZK+pPAXxygTQ
         fVof9cJwqcDg8VeLxNznNdXgSaObWTj7JoVV661JuIFqHbLKTDPmstwZ3M2Lta1MEE5T
         JQfbhjbo4FZAoPPG39Rgu/aCUvHHEEqCSL6ygtI4PAy9clXEgN+htge3uc0GDJLX4BE1
         tBpnRe7fryj9lbJsB+2i3XKhW3Ouce8aFh2P/xJif4j+tNaBIRvhjfITuzYeD4LriDMD
         q5MjlKZYpWdtvp8yf09FwI+xjkxnv/qMIABXLmH1tCi1Vuc63nnTlwDF7oZjkCDL88XR
         chsg==
X-Forwarded-Encrypted: i=1; AHgh+RqPWzq93OiACnq7SCW5MC74s80qUIy6w1r7913eNHrJ03Q+qquTSWnq8UDUORi0JVjwH5MOzUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxReX3P88jqCj7y95xCEK1ioQ4CQfPimYY3IPso1+clInQRBr6b
	b1JMtCirWKjSVCi3XqKqmBj3edtyKywcbG3jHXsutVnVAQC6DkeM+2gd
X-Gm-Gg: AR+sD13Q9HfbVAS2d18r3SdQS7WPAcgrw1Y+JKbUZQvrrmzbXazWmjS0cDtvAbBjP4I
	KJDMdzPVIwE4kipsoPdZVXBHcS60CfNPSPGDlC3KFeWuk/3NuK4qI4bRAxLnsM4Qs+f48tbUBkj
	piBV+nXnH4qk0ijRMn4kSEZZQfIge8wCrNFK3G+tzFVx6iZY+QcS3eJfDEwslL7Y5rJ9+qG7qOm
	/CqxMWM1CeTPziM/72H2EdwEMYXH/4QP0CHJhBKHyfAO0k6UNcwGOHkS+s3+SEeXNSD17VB221h
	YNA9HdwnIJt1PNdFYU64xU/IdtRRy4M2nQFvqhnIJ4HQqgulalydYxlSpGPnL+Ie3FWzj4sWtC+
	wBu3KX/MS12OCENmU4QrPxkKcQ5e590ySX7CnVoVCRjKCE6cCx56W5WNaIbPUd4pUd29102YD1C
	rRsWKY6oxdyrMhqGxEDq75mCT+tet6xp3BFmmXyUUikEjYKcesrdb0Vdpi3gWFBKr8yQ==
X-Received: by 2002:a05:6000:29ce:b0:47f:93be:dabd with SMTP id ffacd0b85a97d-47fec634beemr38517831f8f.28.1786286142353;
        Sun, 09 Aug 2026 07:35:42 -0700 (PDT)
Received: from [192.168.1.225] ([81.187.78.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f8f33sm27797833f8f.27.2026.08.09.07.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 07:35:42 -0700 (PDT)
Message-ID: <b31153a6435579a7ea3c61b3ac49d325075e87a2.camel@gmail.com>
Subject: Re: [PATCH net] et131x: propagate EEPROM readiness errors
From: "mark.einon@gmail.com" <mark.einon@gmail.com>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Michael Grzeschik	
 <mgr@kernel.org>, Kees Cook <kees@kernel.org>, Jacob Keller	
 <jacob.e.keller@intel.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= "(The
 Capable Hub)" <u.kleine-koenig@baylibre.com>, Alan Cox
 <alan@linux.intel.com>, Greg Kroah-Hartman	 <gregkh@suse.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 09 Aug 2026 15:35:41 +0100
In-Reply-To: <20260808194347.813242-1-thnkslprpt@gmail.com>
References: <20260808194347.813242-1-thnkslprpt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-08 at 22:43 +0300, Avi Weiss wrote:
> eeprom_wait_ready() returns a negative error when the LBCIF status
> cannot be read or the device does not become ready for some other
> reason.
>=20
> eeprom_write() propagates this error before starting a write, but
> currently returns 0 when the same readiness check fails after the
> write begins.
>=20
> This behavior was introduced when the EEPROM code was refactored to
> use Linux error-return conventions (from 0 =3D failure to 0 =3D success).
>=20
> Return the error so callers do not treat a failed EEPROM write as
> successful and the function contract is maintained.
>=20
> Fixes: b802ce0c705f ("Staging: et131x: tidy eeprom code up")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

Good spot, thanks Avi.

Acked-by: Mark Einon <mark.einon@gmail.com>

Mark.

> ---
> =C2=A0drivers/net/ethernet/agere/et131x.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/agere/et131x.c
> b/drivers/net/ethernet/agere/et131x.c
> index 1b465a167672..4b6a579e9c66 100644
> --- a/drivers/net/ethernet/agere/et131x.c
> +++ b/drivers/net/ethernet/agere/et131x.c
> @@ -567,7 +567,7 @@ static int eeprom_write(struct et131x_adapter
> *adapter, u32 addr, u8 data)
> =C2=A0		 */
> =C2=A0		err =3D eeprom_wait_ready(pdev, &status);
> =C2=A0		if (err < 0)
> -			return 0;
> +			return err;
> =C2=A0
> =C2=A0		/* Check bit 3 of the LBCIF Status Register.=C2=A0 If=C2=A0
> equal to 1,
> =C2=A0		 * an error has occurred.Don't break here if we are
> revision
>=20
> base-commit: dd057113ac7ba5bdd2aed3d9405305911152f911
