Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C843C346A10
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789947; cv=none; b=YCwaO0HMYS7Y5y2U5RlwtaK8x+574jgXKh+u6z/dQfsECt6AKtu96ipgyRuW8XwaiAsg58uqamKvlB3QdFCjf2F/2076WrBQGdR+u9kNBUTtn/7LBhXLgPMB+5rT2R7ZbTEeurlUFPzTJ+KQG9K0aJUS4CZdhvD2j+F8k4SFzQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789947; c=relaxed/simple;
	bh=rYSOOXpkoFJdrL1NPSf5rkoWzV92gzYi669jEpsYvls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdrLKCpNuxnp4BOqkykCgCccjV6wcvdTpavUgUl3HvQjmslMsSjqf9rPb/q63bWumcQVfpiO7Dn0SJo/U+S2+fVMujk2GJm5SwK2t3AVp2Dq2SibxfkdRKQyb3wlkbB4ZCyQZINGB7shPhDSB8AkC1c5SHLHcaO670KQQq0+DRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9nx1fic; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9nx1fic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736BCC2BCAF
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 09:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772789947;
	bh=rYSOOXpkoFJdrL1NPSf5rkoWzV92gzYi669jEpsYvls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y9nx1ficr4tLVAJpDIwbmxaDuvFATOp8+NdNFrfTIhSeRBmfa86WxRCQ2yQ5WiciP
	 E8pfJCGslVsjSoBdlR91Sw6Uy6pSrA/mAxCyAni1UdetJ3cXC5S4o7CSWMT9XB7gZR
	 +YbBDcQc0WkXDPKV9vrgfmj/5ZboMyQas8OWq5W2AQTFq3Rd+bAbvvaLHCxn0C0YFr
	 1yPRPOVqMI3I7wExc6JgnCfIY9Sg6EoBspfHkd8RwC+wU1EZ/43xXNAxFI8MkJQ2Iz
	 9nDRSBOG+z57sYKpBt5KeJHIeersx2fjsGAPi5SfRXFhZkyy7r/kx2rrZCD6WB8Jqj
	 GHs99goVQhvxg==
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64acd19e1dfso7701569d50.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 01:39:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQz8woQE6SJbVrh/8EHVR0H0wLAycrHhpcfewAu4PCB9i2KeJsrCAQT+rzl5sCydrbreQ5bOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhA5gP2N1TvG5/3GxdiJPDA0f7KpAkRb5Nf3v/vi//JghiW6Z
	h064NcIceliTbyHER3R+/1iI1RSuBB4O4jk0MEKfytGGV342TbHB34gIeYgzJ7sSq87n9m1Del8
	5n/Kf1bHbOBCmrrXuDI1d0627dzSwapg=
X-Received: by 2002:a53:ee57:0:b0:64c:b098:8046 with SMTP id
 956f58d0204a3-64d1418ee0emr1203778d50.32.1772789946680; Fri, 06 Mar 2026
 01:39:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7187C401290C256B+20260304084808.440955-1-xujialu@vimux.org> <D5F95320CE72E20A+20260306035539.2443355-2-xujialu@vimux.org>
In-Reply-To: <D5F95320CE72E20A+20260306035539.2443355-2-xujialu@vimux.org>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 6 Mar 2026 10:38:55 +0100
X-Gmail-Original-Message-ID: <CAD++jL=sj=DCuRvOveVeUo1RWmS9ZvA6YqXNjOQf3qhvyRzL+A@mail.gmail.com>
X-Gm-Features: AaiRm53NeM6JXBaMsHRX5zNF9kdjR-GGQovZIV0Smv7jXgjQSEjIMK3Gzrx3URo
Message-ID: <CAD++jL=sj=DCuRvOveVeUo1RWmS9ZvA6YqXNjOQf3qhvyRzL+A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Remove <linux/of_gpio.h>
To: Jialu Xu <xujialu@vimux.org>
Cc: brgl@kernel.org, kees@kernel.org, krzk@kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

n Fri, Mar 6, 2026 at 4:56=E2=80=AFAM Jialu Xu <xujialu@vimux.org> wrote:

> Convert the last three NFC consumers of <linux/of_gpio.h> to the
> GPIO descriptor API, then remove the deprecated header entirely.
>
> Changes in v3:

v3 looks great to me.

The NFC subsystem is orphaned, so I suggest Bartosz simply
merge this to the GPIO tree at his earliest convenicence.

Yours,
Linus Walleij
