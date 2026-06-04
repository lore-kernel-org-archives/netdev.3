Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF2E3BBFB5
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609864; cv=none; b=TWU9ZdWyYwBakhyENJw2kOxIV7S0fUepULbP+FIresKppTWQuOkuRRTRfZXjvrDskjfeu1XJswk3Uo6RCHlx02sgm1SwzOJ3q1XeeQuY7HX+krmRlFMM3d4kbuAs0YggHHZIQZ+gqKI6mRkVE5JFtL+E8VOeMDnDYwIUFKTw84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609864; c=relaxed/simple;
	bh=ZWDSpacEFEQZGnIVBEbJF0VYYuNfWke7vLWrwwZT/Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qx18FaFTcE3qnoRsgi+s81u4tQ0wTkhncgE6A1/rLsZV5Le8pykdQkjQ+eNaQ+aiANibCiNh2+5vuKZLmxyqMLwBJH7A3KfkInG5OK4fLjgEujGLZGpWAdKs9KMBQVWWaIvpqFR5h62RQ7Z0OSap9S4kaOqwAohxN9AzioGYNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dRf7fUJe; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dRf7fUJe"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-becfa735b9aso173980066b.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 14:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780609861; x=1781214661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C0rKRLQ7b0xQkDszK4kB86a8NKDdPGLBrBut9iuJxEs=;
        b=dRf7fUJeliZyWswD3Ft4J5zPs01dN924OXgHm0hSUCbzQDRPN+8dYw/MLilXfI22MX
         V+nyCB8KsfKV87vyVp6wW6RXgqYGJsonF/rpgAMzf67nHZsmg7X9/Vicpq/rf5kGSMHa
         nnlSM2RKVvLSXyCkFqc2fqxyhBOg1zEbLBSD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780609861; x=1781214661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0rKRLQ7b0xQkDszK4kB86a8NKDdPGLBrBut9iuJxEs=;
        b=Xxz4ncW7tXE01uE7t6s3e+0gHMfrTFwxNcH4IohivKAVCY5psFEoclBgi5cKj6pk2F
         RqUonpKMhvnU7WRz6IMJur+smVPJMm6z44pQAkqTAt5BFvVCYXaGMPRVLIWtiqPndqfy
         qmBmpSNye/qyYkIMBd/3EnOO/6QUdOK3qy6Ukj3bUjggwnHs4MYPPD00uDodQAw+IPgD
         vqy70QCaWfHGRTzzlr75BoX90B38Nl5xg2zfVbHWlmbtU6xQmmMqxIC36YJYQ5EG7N/J
         XPueqP44OulrnqGHsSEx12w7bECZEehb3zFXAbfsmpgPEwx1zRdvYKMKeeHOEKs9u7Ma
         m6Rg==
X-Forwarded-Encrypted: i=1; AFNElJ86IKWXT1KKu6/69kkCVHlDnrlPSPJW1xhZafyyzmRDM3ELdfJCg36ihtjKOs2VUAuofaAYMHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzISHiiS5rfUCbGXPMOmlJbTYcZ4dfhXtF/XSGrKdOGBpAZGbq3
	7LJx2vo1xzCine+GudUA4jHvnE28LLhQr7MKP3ZlgtSpFoPcdJ2ZDLu87iSG5Dzjb5hTN/UcZGA
	UUXP1vXDb0w==
X-Gm-Gg: Acq92OE6UYSryLlfl6bGLp/CAEEIPjOcR7ueYUwXGdVrPY/SNJY+FWU4I6/PgC8FfBR
	G642tOaivpK1gRiRsofJEXaP6yQ6CDX2Y4sRFLj52h+1U18tOd7TKUobwa/JJznUULpB6tCNKoF
	jz8V3NCyZxfk/XW2CGZ3Bz155wR6PyxksAJxkbmb4pba41v+FI1HOIwDqcVZpfox/i9lvy1w/mh
	E1aDra17ClGPvZY7wiYcmi66UAM2tLAKcTe2Anp1TUcLupZ/nNCPBlf5qvdm57EuNWhSYiwOKzG
	NsPbm2j9n7MbGaoadndyhDvn6TKKUaM5LkC7koAXlPn2js8R6+AWl+JzJUF6VG5XA6stiCKoDdg
	bR+yVNYXoqO/3r5qezCX1xhbd7vOlBRbFEwjlPJX2G6L7da0mc4ZcENGMA4yyGAalVHy2ZI1NLo
	pUDi6/q6DD+QTj6uSNXIV6XW9L39VkbO8w8fhG9v9LdwDYusZWwH1V3iicfblL9nLTN0jLc24tg
	ji4dLVRfxI=
X-Received: by 2002:a17:907:c518:b0:bed:eb8b:d404 with SMTP id a640c23a62f3a-bf370866e4cmr26327266b.16.1780609861321;
        Thu, 04 Jun 2026 14:51:01 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e051b0sm359091766b.31.2026.06.04.14.51.01
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 14:51:01 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68852b58d87so2063395a12.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 14:51:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/CnoF1UKHsdrICrHkyGsc7ntzcdvBK5f+bzVZ54qZ3HSeULNtkJcFvsM2qgA0aJxIe/ACdwws=@vger.kernel.org
X-Received: by 2002:a17:907:a03:b0:be2:dd37:facd with SMTP id
 a640c23a62f3a-bf370e6211cmr21551966b.20.1780609388179; Thu, 04 Jun 2026
 14:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
 <20260603211736.755139-1-safinaskar@gmail.com> <20260604100609.6b37f500@pumpkin>
 <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
 <20260604183829.63c35fd9@pumpkin> <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
 <20260604223216.73468830@pumpkin>
In-Reply-To: <20260604223216.73468830@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jun 2026 14:42:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
X-Gm-Features: AVVi8CfSQTIVkCCY1e0qHuDIqCVA2aM8un_0a9-AOfB95snGVQXFlgTgq5lonE8
Message-ID: <CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: David Laight <david.laight.linux@gmail.com>
Cc: Askar Safin <safinaskar@gmail.com>, metze@samba.org, akpm@linux-foundation.org, 
	axboe@kernel.dk, brauner@kernel.org, david@kernel.org, dhowells@redhat.com, 
	hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 14:32, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think riscv might sign extend 32bit values in 64bit registers.
> x86 and arm both zero extend.

That's different.

x86 really doesn't *care*. If the caller zero-extends or leaves high
bits set randomly, according to the x86 ABI that's perfectly fine: the
callee will only care about the low 32 bits. So the high bits are
simply not relevant for the ABI.

The Powerpc ABI makes the the sign extension part of the calling conventions.

So if a caller doesn't sign extend a 32-bit value, the result is
random behavior - if you pass some function an 'int' argument, the
function may end up looking at bit 63 to see if it's negative (except
IBM calls it "bit 0" because they have to be different from everybody
else)

            Linus
