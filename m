Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794123314;
	b=MiGtR2CdX0l+W8ablmwaZel+6HfyiKbRHOpuJWNyGkWR5+VDFR8COGNPTKMwWzhySJuF
	 O4KjQrM6WcQ2COBoSmk1YTMSBSYhpv11J+tTuUHy0rZ+eOFc2FyvM9eUXoWGti1PGHOPo
	 aJOImTTia/twe5hP3KXJb7rpyfeHITp//82WrxSdU7KwFScTArNWt6Ia/sf4x9DDNOfxu
	 3urngX78s7n1FXt8M1g2NqdzUJlLoWNrGp+UycIr+T6vJNQFonZUO0SHTmYGj0VNXul7n
	 OyiGI9FyJW0frx+xLtaiX4PLubIfQ2mGAqtU+IdFv41XIzSpulS9OjWzixp2XUGiFlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123314;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type;
	bh=airxadynoljcG4WiKcNkLwGnwk/Kca8utG3nG0W1M3E=;
	b=o0QQg546SD7y0JOJzGCJYRPwqDRNwcJ4Ur8GD1D+deGLA866Iry6BjveWaM0rReRhZcL
	 9cKeJdcEE6E7j5WNP22zEn1UZ3zMY9mvIat7PgxSh7UZyJ/vlX2s/YCa6W7r0uWkWxBj6
	 pUHr97p0v+XlGEshfRGugY3cHjguXT8kRecoRWYTmBBbIYDScfEqurW4SPxXtV9HYqqp5
	 W29TARuz1wyZ3ETTfscR+R1h1P5ABbU6mbXdhLWI21SUlR2v2YfIa9Q8wVpYTZIRMyClS
	 PolMJbIaKr0FjRsgwX1CBn4cYoxGqnq6BU7Hj9jrkliIQ1kpaLdnQmmsb7tF7RpXthw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=DjwpgHpt;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25316606A31C;
	Sun,  8 Nov 2026 07:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25316606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=DjwpgHpt
Received: by dvalin.narfation.org (Postfix) id F226A1FE2D;
	Sun, 08 Nov 2026 07:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794123305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=airxadynoljcG4WiKcNkLwGnwk/Kca8utG3nG0W1M3E=;
	b=DjwpgHptia91IXmOdK5mOSl4wlpPl5hSzqvTdud/KdG7x1dddYV6jbjfnYV5jFsp6K79eM
	xgMAnlg41nKhQzlRIqy/ToDyrTgeaSc00rV+DEFSg8P/30LlWRaSJqimgXQ7OtPxeCM674
	MZ+bGp2bm2KzdfWLZsRYHW1uKc0o1Qk=
From: Sven Eckelmann <sven@narfation.org>
To: =?UTF-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net,
 syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com
Subject:
 Re: [PATCH batadv-next v3] batman-adv: tt: batch BH re-enable during TT hash
 walks
Date: Sun, 08 Nov 2026 08:35:01 +0100
Message-ID: <2056587.PYKUYFuaPT@sven-l14>
In-Reply-To: <20261108000137.822325-1-omermetekaya0@gmail.com>
References: <20261108000137.822325-1-omermetekaya0@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23304117.EfDdHjke4D";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart23304117.EfDdHjke4D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: =?UTF-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>
Date: Sun, 08 Nov 2026 08:35:01 +0100
Message-ID: <2056587.PYKUYFuaPT@sven-l14>
In-Reply-To: <20261108000137.822325-1-omermetekaya0@gmail.com>
References: <20261108000137.822325-1-omermetekaya0@gmail.com>
MIME-Version: 1.0

On Sunday, 8 November 2026 01:01:11 CET =C3=96mer Mete Kaya wrote:
> Each spin_unlock_bh() re-enables bottom halves and, when softirqs are
> pending, processes them inline before returning. During a 1024-bucket
> TT hash walk under network load, the purge worker can be repeatedly
> interrupted by inline softirq processing at every bucket boundary.
[...]

I already told you that this is not directly for net or net-next. Please do=
n't=20
send this to netdev@vger.kernel.org or davem@davemloft.net. The scripts als=
o=20
tell you this:

$ ./scripts/get_maintainer.pl ./20261108000137.822325-1-omermetekaya0@gmail=
=2Ecom.mbx
Marek Lindner <marek.lindner@mailbox.org> (maintainer:BATMAN ADVANCED)
Simon Wunderlich <sw@simonwunderlich.de> (maintainer:BATMAN ADVANCED)
Antonio Quartulli <antonio@mandelbit.com> (maintainer:BATMAN ADVANCED)
Sven Eckelmann <sven@narfation.org> (maintainer:BATMAN ADVANCED)
Sebastian Andrzej Siewior <bigeasy@linutronix.de> (maintainer:Real-time Lin=
ux (PREEMPT_RT):Keyword:PREEMPT_RT)
Clark Williams <clrkwllms@kernel.org> (maintainer:Real-time Linux (PREEMPT_=
RT):Keyword:PREEMPT_RT)
Steven Rostedt <rostedt@goodmis.org> (maintainer:Real-time Linux (PREEMPT_R=
T):Keyword:PREEMPT_RT)
b.a.t.m.a.n@lists.open-mesh.org (moderated list:BATMAN ADVANCED)
linux-kernel@vger.kernel.org (open list)
linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyw=
ord:PREEMPT_RT)
Real-time Linux (PREEMPT_RT) status: Supported:Keyword:PREEMPT_RT

And please don't send two versions of the same patch (series) in less than=
=20
24h.

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translat=
ion-table.c
> index b9407ad..ebeb486 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -36,6 +36,7 @@
>  #include <linux/overflow.h>
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
> +#include <linux/sched.h>
>  #include <linux/skbuff.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>

Why do you include linux/sched.h? The correct include would have been
#include <linux/bottom_half.h>


#syz test: https://git.open-mesh.org/batadv.git disable-bh

Regards,
	Sven
--nextPart23304117.EfDdHjke4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCavAmJgAKCRBND3cr0xT1
yxzUAQCPh+tkFcwXUPoojY8YRA6P6UDSSmVLaC6R1TyE7dJV7AEAiT2yFIAt493d
X6ZVH6EpyS3xikpiG9xhQ4+RFWx7FQM=
=4L9N
-----END PGP SIGNATURE-----

--nextPart23304117.EfDdHjke4D--



