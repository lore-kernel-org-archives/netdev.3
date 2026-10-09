Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F783E557E
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581058; cv=pass; b=G1B0Uj/OUhXYxWvKJ4Pl4GAxJz2DXrbj+k4ZMv0BdLiiDDDRvodVaBooF93XcpO77SpRtDTiUkuE27+YWRHbZnww4czM2UK2gLJ54cooOcvtVI8bFh/vwOWoB1KixfWbLif5Z2P2k9QrobxXxEEyb+X2CstjVhXPwuzCu+iZHNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581058; c=relaxed/simple;
	bh=mozIcxnttMuBerZr7muY1MA9s+09XZ0iafUEVW2FWdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soahgz2XSM9PDfRaH3kWdxvqiZovI4zhotrD+S2FmzZ3kYMS1W+l5xH5ki9iUOaa5nDO0VsmVDQt6ZIDecNiWbHiHJk6EBzHMfIQFD1wKksk+abKE15ANub2736w7CBSSMFrft8/rTCAKW+7hkc7475v8uQpHaXw/DvTGJ95ffU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pV/tt/2f; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pV/tt/2f"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15354aa70e8so548476c88.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 14:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791581057; cv=none;
        d=google.com; s=arc-20260327;
        b=II+zW4NCd3aL0sglRmr+CzhrMN1ql36Qrt+kPkP17XAgGIIGQmC2fkNyfVx/P1bY+p
         BktXhrc2azt91qz5lQ3/r6uBnKVrVYLkRC4Cdf/kr0uH5AxIK1Zn3hTnhMoeqrp3I5NJ
         JvruLpuPxBEr+QG6lcdQN8D+xDH8UZ6TX8AUzH8qfwSrGTMIPA1ZuVh2K2o3dXfmJLnP
         mNcC5H30Xo8QGY2ZpRvxrsMoNL+AZVCQ2RAefQd9NWzWgZNalXXGZNQ1W8NedBl5JT8g
         Ob5hIz1GsNeJ0Xr6iWSSm4UMY/AdzW6sfG+aYZ81AuiPjzAjWuXksYMqOikj4hGcaReT
         1LXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zqL268J7XZEssG22JT3sRv0E3q65DzbxPLXlXrFzGX4=;
        fh=10C2tsekx6oB+iYzH9xiePdr3aOxy5m3VNFXfiPphos=;
        b=DVzOIzyFPyuXnI95phIP2jblbQmseSr/QcR7F+t8RKl6S00fEw/qo/AxWvapnd6OHc
         S962HiWdp/f8oVmIBaRT0TAhn8i0blAZtBxUrPOcLVHQstq8TEfmssfxYnBvXkg93Bem
         Vt/hs6+VBqeI+yL7EOnEchHDtXP99nC9nheRildnEAA6JfwF19tboiGO7ChvNw5nvaql
         pWqV6AVWquDj94u6pK2y2iXE0xyQOFMel58+Qqru7MdFpm7JoyoKd148Q82/WXzOijxb
         xXZnyYmPi9kiZu6XVjxoSFQn6Q8c6/knJGXkFlHS6ydid56iyVhQbUAzZrM3uSEKl2xx
         JQlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791581057; x=1792185857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zqL268J7XZEssG22JT3sRv0E3q65DzbxPLXlXrFzGX4=;
        b=pV/tt/2fH83pewMrd0dI3YclYYV2xES29aTHVvTvhs44JNS6CA7UkgQBKtNr7q2uLj
         es3j75fTOSDZRf3AInYL5FfYF0vzwCvkhEhotGAuAnxER57b7YcTEeag9RIuI3Bz1Z/S
         6bLSxFRzB9kQP54odB+d3GpV2xNRZNu7m5CjWII8GSlsxE7KT2br5g9bDOC2UKaO0JOL
         u9PjIPZcKsgvlSIB0dFxCbCkbeI/ESYyAV1AxQtlQ+ddcj8iJ0VbE+kl4YAZqShjST4N
         1dw2X/5+Y5X0q3ik5N6FDC9q/hAz8SJup100U9aHUXd7pa32sxQsAFFo8pUzava7I4Lq
         7ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791581057; x=1792185857;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqL268J7XZEssG22JT3sRv0E3q65DzbxPLXlXrFzGX4=;
        b=ojHPE6F6lcq8cPt0JnwaBRFiid4uD9rxcr9axztO4qaIeG7j8tde8wYW0W4hVFtT+S
         wvDf8ykZAPprX+A9ubDxRMpqTt6J1SmDqhgFTCRyD1C+vO8xDuZZ9IlR9mk/bhIh7X21
         Jb/PvqhHtv9xpE10BjcrfoksNuSunSJZOETnHAYh/y+RMxYA1ACtJu+TUVMCVmwx420n
         /Qnanm5cxCAeBBM048tuTDC0yeiBm8ZaCPgyjU61fbvzEhv2XrdVxY17ZOQ0l9fFYgNy
         oVW20slgdimf/WsiVTqkWI/+qOT4rglgEhQupuvHuUG0rraDx3pNWzUNf+0OTAdn0JHH
         Uh3g==
X-Forwarded-Encrypted: i=1; AKwUvBywtJZG2qQxWtJVkGvy9dntluJcAqglPJ2xdekEkq+to11gtE5I5nNE9Dl6HIt3ulZp7VQIbfM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzW6Ck3YlZ0fu61ZIl459fPQ9/O1wYKRI+zjNpY/zM1BmmKXSI
	WM/aJp9dp0xHoAnfgdOaLPqf7PMkCL4HzFUDDEjoiaJBr7yOab9gxRlCnWsS6oIkTlOwPpou5qz
	fR3z7FAwsMffLFC7YIzyHp3xv61OLzwB5E5SAfD/XaCGcZutuWNlPlOka
X-Gm-Gg: AYBFou2etRwwiwNvIQ2oLzW3FmR8Z5VfjDwYF/Gt4fDiUKoE/1knMUHLx1RMjbJN0Cf
	0QkyUHfPWoT4XQy5ST76XLBWT4ypkSs2ug5JuzzdiMiwrEuK6Es5kwxPo2J+nEkBjrsDAYNqWsA
	1kqtIjATmwV1G9gkcXoCj9f6ilQ2/BwYiCJq5598Ks6Bw8CmTf+JqrAyfTdT7q/CohWYxtdP/30
	Yl2a2Jahj0SF4ZqBWa5KLSbQ+6BsNxftq/MJG7WwlX7TOxBXGcpmO0jxyoj87cgdhZQU6OToUFD
	cOcqBlcGDItmWVGC90PNAtHLYFOMauQ21LLDPNmsHhGiRbOP7cbt0+RfwFjjX8O7fukcywoFRUw
	70cjPGO4qrbYpt3l82tLLjpWgCioboVJcyFqKTuNMb5EFYkZqiUJXsP/32qN1nNvjZrOW9mjqn3
	giEhsTUMfCspdovsjxId7U8JE/4A==
X-Received: by 2002:a05:7022:b054:20b0:144:f47b:58b0 with SMTP id
 a92af1059eb24-16a62228bc3mr4188069c88.47.1791581054829; Fri, 09 Oct 2026
 14:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007205827.467974-3-johannes@sipsolutions.net>
 <20261007163616.1088d364@kernel.org> <CAAVpQUATko2Oig53r1+VHe+4Y3fFeX1xOw5RAnXtUAGwvQoB5A@mail.gmail.com>
 <2688563455012eb80063ae014f78230b10a14710.camel@sipsolutions.net> <8575c0d3cf58e56300313482dd1d4d74cbdbf4f0.camel@sipsolutions.net>
In-Reply-To: <8575c0d3cf58e56300313482dd1d4d74cbdbf4f0.camel@sipsolutions.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 9 Oct 2026 14:24:02 -0700
X-Gm-Features: AclHuK9minOGg6iZRYnVefHf6o9f3hjqkBhKGphgC1AFdNnbrzna3x5tbjMc5wI
Message-ID: <CAAVpQUCUGdJUK0ucjwJpRkjMQ6DGgZyswBSadOXvg7_gYDSLwA@mail.gmail.com>
Subject: Re: [GIT PULL] wireless-next-2026-10-07
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 8:01=E2=80=AFAM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Thu, 2026-10-08 at 09:44 +0200, Johannes Berg wrote:
> > > Also, I hope we could remove the long comment in __rtnl_unlock().
> >
> > Couldn't we remove that today, by just __rtnl_unlock() in that place in
> > cfg80211? But it's not exported, for good reason, presumably.
> >
> > But that's also irrelevant, because indeed after my patchset cfg80211
> > doesn't do that any more:
> > https://lore.kernel.org/linux-wireless/20261006100655.2687533-21-johann=
es@sipsolutions.net/
> >
>
> FWIW, I double-checked and didn't find any other code in wifi that would
> do the rtnl_lock(); lock(); rtnl_unlock() ... unlock(); thing, so that
> really is gone once I merge that series (which I'm planning to do after
> all the net-next pulls net etc. settling this week).

Thank you !  Great to hear that :)


> > OK so I (likely naively) thought the idea was that most things like
> > netdev registration/unregistration eventually move to rtnl_net_lock()?

Yes, and hopefully readers (lookup, etc.) will be converted to RCU.
