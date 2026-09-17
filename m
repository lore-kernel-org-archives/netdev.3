Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF2630E85D;
	Thu, 17 Sep 2026 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611547; cv=none; b=rsAgCuzVV/FzCinG9qYK7ofd5N4/Sn7K0zYnOKj6X1wKVWL4S06abOEY18We0N25E0YSh91Gg1INh6MGndpsdOl3UWVw2Nx894YXz8v7DbWX365Mw+CBh1jtkM+ee3s8/Cjx658E+ZSjTvYFJkj08tK8eRD5btq6A6XU7wiwfmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611547; c=relaxed/simple;
	bh=DV7IrZzhW0ZJOvw4MA4FduMyWNZzIwGfbg+jo4e5oKQ=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=ZiR4vGyGuBfQBhJp1HnqDy05Unwbg2ENHuWcGdOk8mFa9ox8ELT3zHpa4UEmMZsL/0a/jJzEozAHngLb2FzSREkodZPvgFornFm8ubUOJlXXkRxub91f2qpkr5BmQ/nizNKJ4aBZocSD0WiOKHCJXuwBBmdhVrUmcKkWerEF6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=QWz9KlBI; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="QWz9KlBI"
Received: from webmail.inf.ufrgs.br (webmail.inf.ufrgs.br [143.54.11.45])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 4E8C012025C;
	Wed, 16 Sep 2026 23:19:00 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1789611540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4LJ6JTQUP6RLFPqNwfrGT1IcCZq1bI1TRPH/KCzkZ4=;
	b=QWz9KlBISBRi07H1qGFRuzmtt6YlXS44hBRUR87hlGReT3cu9nQlKx32TzJp7z38Nmstjd
	ru1gpYYeQ1kBoWMtnAkKcCg9dOUAzLgX7M9lfdZUp7WNkGElKVi57at6I7ZqGpdsACB0nz
	bbgsfDGbVhFK7bmf+450zpRKQqyekQaM1etqE7CLgTcZyPai3LA9qCOoWGErlrHJcRmMti
	jcplFRczC0OO4I/Nr3kS+2fn7Pxpj34w+HvnSukIQEQbDMuc3UrZUw6OMqje5H5xF5cboH
	ctp1mFMt2ecew1obuB4e08rwxdtyIIW2AQiCTkixRHeqMlAZ46vdX9hibvKMCA==
Received: from 186-210-028-117.xd-dynamic.algarnetsuper.com.br
 ([186.210.28.117])
 by webmail.inf.ufrgs.br
 with HTTP (HTTP/1.1 POST); Wed, 16 Sep 2026 23:19:00 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Sep 2026 23:19:00 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] r8169: release firmware on application
 failure
In-Reply-To: <fcaf8c8c-f6df-46c0-ac9d-7924c732283c@lunn.ch>
References: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
 <20260916152444.167196-4-matheus.aalmeida@inf.ufrgs.br>
 <fe23c6bb-2cdf-4641-aae8-25b03b38be42@lunn.ch>
 <4ee3cd8a9a299d504fc95ba86a3f387a@inf.ufrgs.br>
 <fcaf8c8c-f6df-46c0-ac9d-7924c732283c@lunn.ch>
Message-ID: <cc15edcbf76e8e70c89dd5ef5d838c3a@inf.ufrgs.br>
X-Sender: matheus.aalmeida@inf.ufrgs.br
User-Agent: Roundcube Webmail/0.9.5

On 2026-09-16 19:02, Andrew Lunn wrote:
> On Wed, Sep 16, 2026 at 06:15:00PM -0300, Matheus Alves de Almeida wrote:
>> > If the firmware cannot be written, is the device dead? Should this
>> > return an error, so the caller can abort the probe?
>> 
>> A timeout while applying firmware could indeed indicate a PHY access
>> problem. However, firmware loading failures are already non-fatal,
>> and the callers of r8169_apply_firmware() do not propagate errors
>> either. Making firmware application failures fatal would require
>> broader changes to several r8169 PHY initialization paths.
> 
> But you are making such changes, returning errors up the call chain.
> Why are you making these changes? We either assume nothing can fail,
> so we throw away the return code, or we should assume everything can
> fail, and propagate the errors.
> 
> If we assume error can happen, if there is an error in firmware
> download, isn't that fatal? Should we even care about care about PHY
> read/write errors if firmware download has failed? And since firmware
> download is probably the first thing to happen, if anything is likely
> to fair, i would expect firmware download is what is going to fail.
> 
>    Andrew

Looking at this more in depth, I am leaning towards keeping the old
non-fatal behavior.

Right now, firmware application failures are ignored, so the device
can keep going even if applying the firmware fails. The TODO also
specifically says to release the firmware on failure, which seems to
imply that continuing without it was the intended behavior, and that
releasing it was mainly meant to prevent retrying the same failed
firmware application later.

Making firmware application failures fatal also creates a state problem.
If we release tp->rtl_fw after a failure, later initialization attempts
will see no firmware and continue without retrying it. Avoiding that
would require tracking the failure separately or keeping the firmware
loaded, which would no longer follow what the TODO suggests.

At that point this becomes a larger behavior change and could possibly
break hardware where firmware application failures are currently
tolerated.

Because of that, I am leaning towards keeping the existing behavior:
detect the failure, release the firmware as the TODO says, and continue
without it.

What do you think?
