Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB641A918
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050009; cv=pass; b=Z+f+WJh22le+0NSQNU7yylplYy6ZIg3n8nKQTP6lhzks/SvLiLguULULrXlXRIL8drBLgxvq5sLtD3sw4S2+TSECIF8U2t56e8mcgB7lHn4zABs3N+pA/f+DeqmO620eHJfiLElIjuqQ7/V3pYVyTFEBu5g39UrP2dp6NnnOI7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050009; c=relaxed/simple;
	bh=nr3TTEjqFzRrrWN+cPXVFVEBNjpzQCKp/KHwCXYQPIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9o+ubv+pLniF37Q0Eb2N6a737ppbwsoqvVxA0PuC5DIh4TN4qMj9gN4RSgcIqhnWy//5or5ducMJjg6P5vpfymAJIAMwBR2YCNuwMCl1pj4pdrrnzXWxSem4WwV2DnKDYf1FEfPGB9KV2ff82nVcwobFn8oFJZ1sJffgwu45Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vj2FwKGp; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vj2FwKGp"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cacef7d299so9015ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 14:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050006; cv=none;
        d=google.com; s=arc-20260327;
        b=e2eEbHt9T5W6Z7Tenz0bM5ylnrrFzWYQzlAGUudA01EI/okgsmazOjfwxlFyUd3p2S
         leURiOVie57fG1rDfwwuUU+NPUO+jl3RPqlMhRcIF2yfyoyjYouzVjWW2OuGDsfZbYoD
         141+m8tpgcoDaYtEmogZI/LJFheB+k4xIR8TifgSUVJ8YbbSF2I6sAE7fGt1P/ALcLP9
         IktqY5ihmwSbJLQZ0SSWI9E8/I1IyNsHwHwG7ZtSA1Ugo5hVO8hertUe0Rb2vNA+WLR1
         QtYyMt6wsNEm1/ricVjl5Rxi77+YXrf5IFTHpB/irpRqYinHSQWonE5ajs191W5U4Rbs
         XPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nr3TTEjqFzRrrWN+cPXVFVEBNjpzQCKp/KHwCXYQPIA=;
        fh=yTYzHmnr1B5+GGzLzQABnUXmsXy/GUneDJ7UnyoZNkI=;
        b=BUqrMLBzJ3W3P1cQIva2tTVFgz4yuTLN1TONcz2Ret4wmNKFkQ2L5T8dZV4Qik958i
         eime/dnV2ahPRd9nq763t8ZHMVuV3eHxtQiestQj1Ur/8iEJGFuDk4E6UdDoBe+97zAm
         TJwrnWHDK+fanNS5UkoXGeqGoWKg8SZRHmWroXLKedkrC3CKD63JBoXnhoGUoLC1Lrta
         WU/F5B+vX4dULjjsyucyhqeZl8eOclqXi3H0yQn1kHEr59bH/QPVikv+Kn2cAItShqbd
         Xm/i6SSaGUrWmATIUtUOSdBc5EK0mjPoC3mptnjGB/ezcQpbyQ8eg1UA2XWMQ7NxKs7Y
         Ailg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786050006; x=1786654806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nr3TTEjqFzRrrWN+cPXVFVEBNjpzQCKp/KHwCXYQPIA=;
        b=Vj2FwKGp8ZKBIWjrhVRAVwpi/Vx2Q3XKa+aIRmF7TvG6MRtoNLQ09SUfKvzEzRQ0zy
         K2I9LSCwMu+62/lyj7GnrDRE2KFC4ZJDl8az5TB2Ig6nI7BPviKG8t94X9uuD/jsqSs8
         H1Nc32FF/SVb3Zp/eOvH8MNOM1F7d3MOuID72EH55rQCzx/7u7TG0uNOhD7oJXwTHT9o
         2PYZPIcIXAvCKPqnGUF14CtQCzln078MyceAnuqc48A9JimbCEc5L/cMOERWPIbUI5/u
         ICs8rgPAGmoN18xjZ0bxqPNeYkoN8EQVnuBkQLRfxLPTLlExVZ83ZhhNMWehi0hbdkJV
         2GFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786050006; x=1786654806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nr3TTEjqFzRrrWN+cPXVFVEBNjpzQCKp/KHwCXYQPIA=;
        b=L1pFpp0lI39qBaTzNJQ0IgbgGMPtsk2ycEev6VLqE605X0hafXvTp9IoAJd/59Jb5q
         OPlXdByuGh+seC2wd17t9tgMb/NaZIeBm2j+2UTXZDWHH0Xv/xfd32auUJDyYb5fdCfD
         hdJOKyrQ247TLC06B7S6TzZCEHNFyljDFAyAk4FOixB8CZk8r5nFtrdIHZC+8N+koe9Q
         qQAsbyqFIrC2msstI7c1rPYvVmGs07oNyu5xPLZKCq6UgV5KBeY5pBlnoKBW82phDDKb
         weKBhpwsxleW3pM12CX1TE6XezO4qriOAodsnbVvj/ur4pEW7mTCKWcgOtUg6LJXqaJg
         TtUA==
X-Gm-Message-State: AOJu0YwDuPI7cUN78lhbL5iDQIEO9AXXprEv2yH02j3jfN5YniBVEz7X
	g+D8mT6wuVyOd5u2y/MlcvHUQ96TfHHzbWBDgJAaMb35CaNRwZNtSzVF9ft5uAamTzN5uQNTRKm
	fVyO2M0q4TLGfiAARl9fe0UyVp56/LGzoZX+Q4l8n
X-Gm-Gg: AR+sD11ZRaozYg7zJGaP3VL16h835YaOXzrEb/i2lhAZInPRmm6xK0nUZqEReP2XIrw
	f5XTYLxP4DW+NoQGO27hnpW9iK+aZ+BG53zboBPpbuS2tSIVrq2DsrmmplY1U0c1R4hUgoTbPju
	4abbynkwSgQTjdojR1OwPihSk0nOTc1dMC9cu7NC96S4Hx59BZ/eKBDNU/WvOz3xCWO4H6HAIKF
	KFIjVzaIL9IvjHiiL591mOthQMDJzS4A7g1xJwQNFGWfGpvg35cVndzC8VA9VCca57kLGPRS4MT
	vyyz/j+Po3FaVZb4kPgWxNl+cLm1Rbcx8oxHLstoZs/jyvb5MYwzk+OSH2e/LseUN3sy5Db6Kv/
	FbrrtMGUr2g==
X-Received: by 2002:a17:902:d4c1:b0:2ca:e0ff:eaa0 with SMTP id
 d9443c01a7336-2d12024e012mr1715455ad.2.1786050005384; Thu, 06 Aug 2026
 14:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803181852.491437-1-almasrymina@google.com>
 <20260806121631.13175f7e@kernel.org> <CAHS8izP=mgsdxv3AtjJo9JY5OHC17zeX-VbPPH_gFF=Ndb_qjw@mail.gmail.com>
 <20260806133435.38c34e31@kernel.org>
In-Reply-To: <20260806133435.38c34e31@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 6 Aug 2026 13:59:53 -0700
X-Gm-Features: AUfX_mwfch4NDc4wFCxGKUTkco01WXZ6MdhsrQ5uDE3VIJlaVnA_HqAXXxdO6so
Message-ID: <CAHS8izOU2pxfQH0Wo1DrqajOb54wv3Y1rMryGpwjNnoUsEufew@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] selftests: drv-net: devmem: fix 5-tuple
 flow steering
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 1:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 6 Aug 2026 13:05:49 -0700 Mina Almasry wrote:
> > Yes the test fails, but it gets past the flow steering configuration pr=
oblem.
> >
> > And in the code, the change looks correct to me. If flow_steer is
> > False, then we don't pass the -c arg to ncdevmem. ncdevmem is written
> > so that if -c is not set, 5-tuple flow steering is not possible (the
> > client side port is random), so it falls back to 3-tuple flow
> > steering, which doesn't work on GVE or any other driver that supports
> > only 5-tuple flow steering.
> >
> > run_rx (devmem.check_rx test case) doesn't have this problem because
> > it does `flow_steer=3Dnot hasattr(cfg, 'netns')`, but run_rx_hds has
> > this problem because it forgets to override flow_steer at all. This
> > patch fixes that.
> >
> > To be honest while looking at this there were a few weird things. Like
> > I'm not sure why the python arg is named `flow_steer` (it likely
> > should be 5_tuple_flow_steer), and why flow_steer setting is tied to
> > hasattr(cfg, 'netns'), it should be a proprety of the driver you're
> > runing on (unless all in-netns drivers will support 3-tuple flow
> > steering).
>
> Could we clean this up and add explicit test cases for inserting
> specific rule types? We want the one-sided-tuple format at Meta,
> falling back silently would be a loss of signal.

Do you mean forking all the test cases so that we have
check_rx_3_tuple and check_rx_5_tuple, etc? Won't that be annoying in
the future if every test case needs to be duplicated twice? And
potentially again if there is another deviation in driver config
support specifics?

The current approach is that yes we have 1 set of test cases, and
they're supposed to auto-detect if 3-tuple or 5-tuple is supported and
fallback silently to what the driver supports. check_rx and check_tx
currently work this way. I occasionally find breakages on 5-tuple
setups because they're less common and fix them, like this one[1].

To be clear this change is not intended to break 3-tuple. It's just
porting the bit that makes check_rx work for check_rx_hds. Whoever
added run_rx_hds probably did not have access to a 5-tuple-only driver
and missed this needed change.

[1] https://lore.kernel.org/netdev/aDXbNuCPNKRYYVRk@mini-arch/

--=20
Thanks,
Mina
