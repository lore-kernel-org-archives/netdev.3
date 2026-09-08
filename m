Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098AA581257
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889582; cv=none; b=fBpKvDFpqxKPetRb+x6yiRpRuzleUGrjLll5GiHV+HXqMTe3w7x7m4lUcl3Got9StaoylPBm+MKKt6NrAav1oVJ0BDrtU9Tgq371qzqW74IkJO27kSrrQe6NA7sTqy1NuYj8LNflysZM+jW87i03VwiaCi7eGZKhVwJI6+XWXHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889582; c=relaxed/simple;
	bh=oBgdqVoWnh1i0wWiieHGMx04K8R2TvYaQCy+rEeI4Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uu3q9GeKIGcG6lJYIzZebCFDTgkjd70X4Z0W0R90IjBgzFjrmnDF1XQWNwkJg9IFfyBUY9JSPLNL0Jslsp1nhOHp69sR3HEOKfA+1QDljn63etcem9skOeGd7NkMC+WdlNLadJxCyCKYofFg4huuR7DUIACQQjsiJFuvIn9NY7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeggxOVZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeggxOVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E931F00ADE
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788889580;
	bh=oBgdqVoWnh1i0wWiieHGMx04K8R2TvYaQCy+rEeI4Lg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jeggxOVZX/gIsuW1wotf6Pm6tKGQrTDpF2fZwkU4P7K0mI5I2Kwrbgedm8ccUZWH8
	 IqJ+oeafnDe7xEe+uepw6PQFRIhiyyxx7lAhpNfvYsADUD+OIZ7T7jmR8V9AAFLKF8
	 JLB8tDLg+jEIYFDmWdHmWSp3lY2WA/z+No/b0YnuH6QEVyJ3beth1jVEkkkUUT8Hvx
	 ycU00Di0ZZzbilHjvNEvUEXndfOVfH6FJRU4uF1z8mfW+QwH3g8b7jzfuRuo2QfowV
	 q2tOfUnWTRCiP/SNmNR7Uk2SRveQ6a4Cf4QEE5fVMg9sG47lb//lcZcMstz8g2XpiH
	 fwlNblp7r4Alw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b568dae0e8so3618002e87.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 10:46:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxexSngTqva7Mk894fk0kBo1T24eWbPpgQqkmxEzx0mrmqyZpmwBYpHzxPyeMf2ex5S+b/ldt0=@vger.kernel.org
X-Gm-Message-State: AFuF++lD8Sz6B4nSZ4TIFyUAxjCCaOvFW6QH54Lphtvqg8DmnifgNBea
	pAYIbeOTRQBiZpjaLPtvJZwDSV3ghNhV6O8JKs5uBS7+G/fOrg395mhMJ4YJV6uUWEPk+6MxrjW
	WX4TqPKZTDBd7ZkjBUx/oFpMxNrOYlu4=
X-Received: by 2002:a05:6512:3a95:b0:5b6:95e:87f8 with SMTP id
 2adb3069b0e04-5b61706cc71mr5245982e87.24.1788889579225; Tue, 08 Sep 2026
 10:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e@kernel.org> <355421f8-63ec-43a4-8982-01312f79dc6c@redhat.com>
In-Reply-To: <355421f8-63ec-43a4-8982-01312f79dc6c@redhat.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 8 Sep 2026 19:46:06 +0200
X-Gmail-Original-Message-ID: <CAD++jLn54xi9y-obTPVHSYoM=qBXtvMW6+OGWSMrYHTfzWXM2Q@mail.gmail.com>
X-Gm-Features: AcwNN1WKhh9o8Ywwj2bBaEqoE8Q2euzZYawibv_FC4ydKy2YmVirlsnZ6VmKmgs
Message-ID: <CAD++jLn54xi9y-obTPVHSYoM=qBXtvMW6+OGWSMrYHTfzWXM2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] net: ethernet: cortina: Fix RX budget accounting
To: Paolo Abeni <pabeni@redhat.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	netdev@vger.kernel.org, Joe Damato <joe@dama.to>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 12:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:

> Sashiko has a couple of comments, but the first one is a giant "this is
> solved by the next patch" and I read the 2nd alike "if H/W is broken s/w
> accounting could be inaccurate" which in turn is not a big deal.
>
> @Linus, note that the current expectation is for the patch submitter to
> provide something alike the above feedback.

Yeah I understood that, I was just not fast enough.

You analysis is correct AFAICT, I will however comb over
the feedback trying to fix up also some of the newly discovered
latent issues ... it's a bit painful and fun at the same time.

Thanks!
Linus Walleij
