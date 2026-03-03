Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBDD324B27;
	Tue,  3 Mar 2026 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545108; cv=none; b=LJryFkBiDds2FZmxlxmQdGrtqgnGtgELYojvY6oxYjR45i2Vr3KmyuGoL8NH4UP77cAfRqNT8OqIipXPdavND0DH4ohMBkI+o+SYzJrPI+62m1iJ0tcmjPrfOUxi8tJ7mAD4uA/0tCGUELLekZPgzhnUSYegzqaobvlSY7cf2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545108; c=relaxed/simple;
	bh=rDVzuxgJEXtCRZZ1xCN0kX1QxeN7h7mj0UkuWn4bbwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvFCb59EcWXiWl9jKlEfweULruI7+y6awR0P6ph2VZRRpp9yMoLmlZai74v7fQ7L3rN7+nX1sVpOIV+wVq/sJMsPTktX8U4BsWPjAWJWa2rnDAI2jdJqPFK5aIxjh7UGeoHr0g7BkvN+R3UCG75CGG18ExbsSYwb/w2rBwT73Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4LDBZPmK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lBEyQk8P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4LDBZPmK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lBEyQk8P"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772545093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDVzuxgJEXtCRZZ1xCN0kX1QxeN7h7mj0UkuWn4bbwc=;
	b=4LDBZPmKYMrMkaPbCVywO2f3s+eYFA984rvFUndjVB18nt16AhKieNdKRpe8qkXfvl+ssE
	O8Dn79K94qr9J7P19d6iRQkBh2L9olhXM/vYKyFxqaTMiCXvaOKZybh7XE9pFRV751mS3H
	n9/gpb1zPzMQOMyUZ+m3YMZQqJkMK2JPiZ7Am3w2H73NhMyI7jesIoekiyfzvmeDo7tptE
	y0YNPrD+DaxThz0U5m8F//GOoOyNdBkY9eD0TBifQxYojVgBomqi08plios9MrESUFkwzX
	EnrqatylNbhsUO8s6RwrmQMVP+nvK6vJ06pZQZDqgicL1Bl26/PR4gjXrn6tEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772545093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDVzuxgJEXtCRZZ1xCN0kX1QxeN7h7mj0UkuWn4bbwc=;
	b=lBEyQk8PaGlnn48Bha/m0Iv1tc+mdAuXfNtqRyogmn0XZmB1fSdSfLl1MphKBw/Zxpsoxg
	i7nXcoi5WxknxtCg==
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Miroslav Lichvar <mlichvar@redhat.com>, Jacob Keller
 <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next v4] igb: Retrieve Tx timestamp from BH workqueue
In-Reply-To: <9805389e-9ea4-4e7a-a122-65f733ead33c@molgen.mpg.de>
References: <20260303-igb_irq_ts-v4-1-cbae7f127061@linutronix.de>
 <9805389e-9ea4-4e7a-a122-65f733ead33c@molgen.mpg.de>
Date: Tue, 03 Mar 2026 14:38:11 +0100
Message-ID: <87qzq1rq2k.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue Mar 03 2026, Paul Menzel wrote:
> Dear Kurt,
>
>
> Thank you for the patch.
>
> Am 03.03.26 um 12:48 schrieb Kurt Kanzenbach:
>> Retrieve Tx timestamp from system BH instead of regular system workqueue.
>>=20
>> The current implementation uses schedule_work() which is executed by the
>> system work queue and kworkers to retrieve Tx timestamps. This increases
>> latency and can lead to timeouts in case of heavy system load. i210 is
>> often used in industrial systems, where timestamp timeouts can be fatal.
>>=20
>> Therefore, switch to the system BH workqueues which are executed directly
>> at the end of the IRQ handler.
>
> Thank you for implementing this.
>
>> Tested on Intel i210 and i350 with ptp4l.
>
> It would be great, if you shared the numbers. Did Miroslav already test=20
> this?

Great question. I did test with ptp4l and synchronization looks fine <
below 10ns back to back as expected. I did not test with ntpperf,
because I was never able to reproduce the NTP regression to the same
extent as Miroslav reported. Therefore, Miroslav is on Cc in case he
wants to test it. Let's see.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmmm5EMTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgvQWEACMXEkyWc4oiQvvfpz+VFyPGHKQWZR3
nTb4r2KTU42t75o5ukOCAq0+hpgtgd7H5VD96qwiNHvacfd4IvKsP4/DI32LWSqw
yRqH6M49S2/LSZr7fYtkdfLjY5VOGzF41b/abAgVoXJfn0yn6/NAzGc9kgGfQKXR
uSidNO7GJzcwzvzxRChYtcmIMq5NrhXZsG46r329VjFEsLplOCynX8+wjsDT5Jhh
iVmXfxNmY96zbrueIgCAWyCXQT5xHWe8pnSPgBna14q60ygXF0STN1UhrQNi4WK0
oCjWSzivIF0jmm/zXwOcDlmhbOwOeHEwPf/4G5YG8METMjdURwmZ6JbxYWrMr0SM
soGF4idZ3Eeh8prt50kqdE5/N8M018gR8AvKKQecwCqhYx5imXikIcteFoIVsXPs
y8hOJU0/1yN0xGpn0WVZ4umyujoDiL1Im/eZK1bHDvaJyD+5g+YwaUPw05q2XcRQ
+SJl0fNYSKkg/itB3pkygIffLpIFQO5ip23gEDAS8o6wIAZz8gZnh7CbgwigB5+E
m9Pk9EquSCM0xdJidOoK9Od9uqlBloZolCXFEPAmnEIJtc9WYBjLiTcfshCNnfBW
IIFaov3rdq5td5Ul7TD0AwwN7a+bc3NBo48ijFFjq3jwpWj+4vGvWiXGqPM3286b
Tf7yhlSENlmJJw==
=TRL7
-----END PGP SIGNATURE-----
--=-=-=--
