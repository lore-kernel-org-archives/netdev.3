Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA1B3BE623
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927068; cv=none; b=fex6or7941Fvkidfyny95f8BlA0uPprdwId5FV4j/hK258QcmWNIkJ4/LFAPotXADO2ehM0NQFH/RkbQpZ5ji+rJ5VGjyP6xpZvY5ssItm9wCNafk1q+rzBQl6qJUj5U0fg7vr6xF2X71bkTDJ1XKsmNuOOJwohqMn7TcYbW8pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927068; c=relaxed/simple;
	bh=2kfGFMMn1SkkcMGUQ+/A+N3nU9GKzTtSzZNGjnbV8UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFfUPP9ywcVvA7j7doCjuB9+/mxEE3O517QowYrpefR8ixUasIzdhZBwqKd8zOaWlpbnBKOGvXIZsrj2pn5fxWQO7z9ewDpeRp79NpvX1CJj690VI/4ObEsRlgFMjLnFzsCR2bTJ4Eo/Yoy6A3cpabvVJd6I4JWLk/SJvQH5F2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPxcD9Qr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPxcD9Qr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caed617615so10856795ad.3
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784927067; x=1785531867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VwUsmXLvkQOCrPIfr7szp1HeyxYyQEY+UzEyT+qGU7E=;
        b=VPxcD9Qrx4AknY0dVtRhpkrEgCpep9DrtNxIVk737TIXmegil0DLLstVRFtVj5dD6Z
         sMHs0/uLM0y0NcUvSl8YofUtmwdjytpIM+os2GUFIROoolH81tnKU0IBCsWi7KF9tReW
         Qp0ZbjPxWGM56BJQ8ajVbRbQC3dUE3vGoHWjc1OaFwXZAxdljORWOYizemLUW187A2Vj
         fc7X0sU5WkF+CpVcI8LF0aGqXkKEoPXhCjnYSOVuT/V7axcHUxGaEqQuDHoxzP36juAF
         rIjY7L+RhHYbPYypU7p55U9FeXse5FH+id8tU5b5kj25ZspbClyG6hJ8DhNxo1iUqBTv
         6ExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927067; x=1785531867;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VwUsmXLvkQOCrPIfr7szp1HeyxYyQEY+UzEyT+qGU7E=;
        b=HCOam5+gwa+I7oYFKbZr633qjRTwf4OoVOm41JLLsBRElOdZz1uab3efl5YKjFYHii
         raaoJPWnEs7gYCHxRpXKroTr6bYGDh6DNWYIpEeI5FmyIU+Dx71TL76i0BlzAdxeyOUU
         TkY5AqwNjvE4a8l1OLYwF0cMWUMDBsaN8nYxmSdBzwXvFTHD241QG6J+teJQPxTnccC5
         ycAL1qTj8kF9RXgHsaVXUG3R4dhEcKzYZ6IaPJUhVRAx3uTU+kBYF85DAHl6pCOAHOOS
         Ci2SmA/N830R8JdLTN4bCmrb0i55SapbjZ+i9bfikOgm7+jPP1UZtq/CtoMM7swoewk/
         8EqQ==
X-Forwarded-Encrypted: i=1; AHgh+RpovpWZ90boHbdvQMsyYP8btKf/TCpBusO4gExM/cyWqYVLEOjQs4SPjngWic0z8EBHYKRprPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKI/drtwTjWJskIczo5LUwyhbsugKfv2V7KR5aKXwL0BW79bH
	VUJq8nvEeVtOoW/pOvHb9OJJ44bnsczbqrCoge3SW9ubvwKeg1K8h/eS
X-Gm-Gg: AR+sD11Kvp9tWGMpTuHrhqTvfUB9jhstBZglwpQL4LAAKvopWetwVS+GgbzkQO9mKij
	Cggm0nQWgIMzb5Tha9WSIoKHm5Sdncg5y2BdIYZLO7sbeyYFmDMG/dNA865fUbbq02P65dNhcyn
	EluYwxa5yAPGwKFi7UqIZzvrHj3zxDeGOn3YQsQbSlWz7EU2gHUh3EYXt0BcTeYWn49tIFExyAM
	slFqpHpR8TjbleE8tyz/KlDUVnniyltQGppuBfJ7UnK7/2QFNbddjgAflGP/Llx2fcxLb38YE7D
	naLss9O52OxxshxVubL+/xeMNo2Sdiszq/VIG7sDOvoV1UcLiek50AY7i3nJtu7KDwgcj8KsNJx
	mqfGPlkHxHX21Wdl7o39RbxD0kNLHdkqeNRzTUo0TQ8v6CO81ud+Ugtw6eSzTdsFp8UKdtSGpYV
	LGXsrSJ77s10zLSCmYnBikzu/hFd3n9Zo4s8lc0JP+kTn9HZ2bzcdmIOSTA4xYx7S2aGdxueIm8
	qIX4PS93ofG+fc5sC8=
X-Received: by 2002:a17:903:2b0d:b0:2ca:d975:5bbd with SMTP id d9443c01a7336-2cfde7c4b2bmr712645ad.20.1784927067004;
        Fri, 24 Jul 2026 14:04:27 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2b8esm257875ad.31.2026.07.24.14.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:04:26 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:04:24 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, sdf@fomichev.me,
	razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
	matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk,
	Joe Damato <joe@dama.to>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <amPTWGX/3LHepYR3@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-3-34bf6fac941b@meta.com>
 <20260721110903.34840531@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721110903.34840531@kernel.org>

On Tue, Jul 21, 2026 at 11:09:03AM -0700, Jakub Kicinski wrote:
> On Wed, 08 Jul 2026 15:55:06 -0700 Bobby Eshleman wrote:
> > +@ksft_disruptive
> > +def check_rx_large_niov(cfg) -> None:
> > +    """Run the devmem RX test with rx-buf-size = 16 KiB."""
> > +    run_rx_large_niov(cfg)
> 
> Any idea why the devmem tests sprinkle disruptive everywhere?
> Disruptive means we take the link down, I don't think this test 
> does that.

Talked to Stan and he mentioned the original idea was not necessarily
just for link down, but any test that could be considered disruptive to
other tests, with the idea to eventually introduce some scheduling
(postpone disruptive until the end).

If we can get common agreement on its meaning, maybe I could submit
something into the documentation and update where its misused?

I'll drop it from this patch since it doesn't bring down the link (and
seemingly no worries about check_rx_hds() tests not having it).

Best,
Bobby
