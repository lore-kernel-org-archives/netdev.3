Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E169B391E7A
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 04:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791781091; cv=none; b=nb+T/wTVcNilfbkgXOZZA+6YvHklJUWKhckgUWrKfv2h8yOJERQAfktHvpKs+WPkZPyjwPJddxHIn3DwCjjSE351Ds7yAxCPoXz+y2pA5VDmT86EnshuTIwxMmtQzycTck8k8b97rUM8B5mry4CyaQA9TlgdX/hbdCEWD+gPufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791781091; c=relaxed/simple;
	bh=unQ8Kv3Fy+buE9N5m0DeZVnQ6loHexCxxXoC2t0MmFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7boYM7xKL8oyk5HV0FnrN0NSogSIwwEJ/jkABNP81X5lJ9ebq3Jy+caBBQEeUsCn2xIn5JifHvPyucm6tOyWu8r8snctSZ8ZTwuOaMeC8tGUslpgnzklaW8R6kEjc8fKf/7bRrbVQyv3iWI99dht/pNtmIRsEaGwHeMyaZW/to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp2cRVit; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp2cRVit"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35829219da8so1368395eec.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 21:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791781089; x=1792385889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OPxwWFgnfVFbchTbdw0or35TN+U5yCxRRFvUU5bcKZM=;
        b=Yp2cRVitNSlNqdGxhTzqznvtp50R0HC7g+MqHapP8Ur7R4J95+RCUhOHeSqa1dduR+
         cwmCQVTQOReAMbHovTYBraiOTXwNIPy0LUAssjdFTGlEU3Ua0eAxrnFrAHj/+IweXkIl
         ScF+9p23+ZkQa8+wno0ExUprSKDWdElK8Qa101YL1KWsMsJkdpr6i95nXKeCE8evhtKv
         O8SksGt9Q2SwJ6w4k3r+Hfs/4kLxq1IdqtGIBvYShFnUWH4wR2ZdNKal1V2NSnAe9eDE
         G9QweBcpMnAuQYe9U/p5prP9nZoEbnalnX6WL1jiBuYY40BEUP3oe2dGFW87m+t4tgnf
         vC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791781089; x=1792385889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OPxwWFgnfVFbchTbdw0or35TN+U5yCxRRFvUU5bcKZM=;
        b=0dBXJqgA1wYjozenhLsEs/5n0DUcVLhk5k8U/7o15/RwB3tTIILxrywnbWwDAiuO8J
         Qlumd3I+EvBWiM8jvAYoVvwTRtt4rgGiYogbI8Nn6jJFGhevpAujlOlwf9vTcdSiJxnF
         KLNXb3WuJdSrnXwrnISxAXDsqcJ1DCieQvHFCWW2q5yyDpcTPy3gasRXV8AGU2vUsoUT
         7hX59P9SjXzknhbKqaEW1tinKAaau4tsUpU7hJoPLtgZo9l4+rTo3kgSQ77c6BOcyXCi
         K5gOrUoEA4Lq/vzbEPt3WacsHxdCONBW7YUViYlLcjBB4l6959XRTuvU3T/UZ3z4JIIa
         dELg==
X-Forwarded-Encrypted: i=1; AKwUvBxidrm3vJ6yn5MiZcCC8J1rBx+gx7lxzqpoD71jmfIbs2C66EDYcgC5Hb+eZQ/nxMljhRUVwBM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3rtyMDD/IUvlDA6zTV4HOzwS0CygXn/iO6ZuxYQwwe5iDxBWg
	h+gVL/BfMW5uro9JIBw3Nf7DwUZmbeprgDQjTyPLuoL3O6gLw43JcflB
X-Gm-Gg: AYBFou2JhMe7ZmViYg4Qm2UHbfrFRXX2nXMSEv0Va/wwLmA70bMuHPCkqNLz/GnlAQD
	i34RaDJ8JU8cwskF1TovXQNj4V/K0QdW6Wg2DNFL2SMcRpEfrcEN/6dHHwkQqbEisXGAbhX+bUQ
	baQ6ZSA0NjozqtrMOGJxCqqG7pByesWdebdyWqTGXHEn0DKrCRj5kl1a3aaABfdnuk7bpOQseVv
	3v8JRWd8by3ifh2aRAIY2OMJeZnH+7nTcEtZ+oyOV1gGKjyaxal/xysZK0HRzgdzpwul/O83eZ9
	9wZqskwjv9RvD232nXP7cIGTz6nUsrJmZzsWLpZ3OUW5x//Mrsp0agxQSeM/J9Nd+H8+VzZU538
	1G3WD3J9fU5yPOY9JEy9QLSq4KzjQGXZMFt4316P87f2YU3TQtUE7D50RNEnIz1x7BNcLoBwA7+
	ciGnksSnzkONPnYrrvXvZ1F4zo1ZEJN7twoKuSTcmYbFztsrdC+AP9IEPff2ChfnNpgvgcsexKs
	LGnmNk4cGuhM83NI04C8ZWWrFIEzag6s8ojq9pIuFzk6sW3A3bMVed/yS/z9ZDl/NzpK8aL8OvR
	ANi7bvDl9iU45la4N95Rk0A5B/JHwbHSuQW3PcPshdnEM3WxagksEcVAe9tgpLJJUiCoxTGRt2v
	6+8HZmuAuZ6qKNTyh6prd9Oz8LA0YTmKyvSLFU0Rq8ZD4O2qAIaa7xUE=
X-Received: by 2002:a05:7300:fb8a:b0:353:82a3:eb86 with SMTP id 5a478bee46e88-35382a3ef76mr16701172eec.0.1791781088584;
        Sun, 11 Oct 2026 21:58:08 -0700 (PDT)
Received: from FT6N242TWK ([223.181.119.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm32829284eec.3.2026.10.11.21.58.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 21:58:08 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tcp: keep the route window metric when SO_RCVBUF is set before connect
Date: Mon, 12 Oct 2026 10:28:02 +0530
Message-ID: <20261012045802.47339-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAL4Wiio1bAsM_Z2LEQz9r0-ehHoWpzTneWy49hd2FGeoVVEQhQ@mail.gmail.com>
References: <CAL4Wiio1bAsM_Z2LEQz9r0-ehHoWpzTneWy49hd2FGeoVVEQhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 11, 2026, Eric Dumazet <edumazet@kernel.org> wrote:
> Note that we ask to not top post on netdev@ mailing list.

Understood, replying inline from here on.

> 1) "TCP_WINDOW_CLAMP 4096" only holds until the first data segment.
> ... What the patch really restores is the SYN/SYN-ACK window and the
> window scale. Please say so.

Agreed, presenting the clamp as persistent was wrong. v2 says the patch
restores the window and window scale advertised in the SYN / SYN-ACK,
and notes that since a2cbb1603943 ("tcp: Update window clamping
condition") tcp_measure_rcv_mss() recomputes window_clamp from sk_rcvbuf
once the scaling ratio changes, independent of this change.

> 2) "no window scaling" is not accurate: we still send the option,
> with a shift of 0.

Right; changed to "wscale 0 (the window scale option is still sent,
with a shift of 0)".

> 3) This also fixes TCP_WINDOW_CLAMP being overwritten by a later
> SO_RCVBUF on a not yet connected socket or a listener. ... worth
> mentioning.

Done - v2 leads with the SO_RCVBUF-before-connect / listener case as the
common one, with the route metric as a second effect.

> A packetdrill test covering the SYN window and wscale would be nice.

I'll add a packetdrill test for the SYN window and wscale, with and
without SO_RCVBUF set before connect, in v2.

> It seems to be a net-next candidate ...

Will repost as [PATCH net-next].

Reposted as v2:
  https://lore.kernel.org/all/20261011111606.14753-1-jain.sm@gmail.com/

Thanks for the review.
Shashank
