Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889915;
	b=Qzuo8BhB2hDUooZFjvMi55nY9R4nPu2KXeStnnljG3cm5XndMf04cP+TNM6CEyFk6EW8
	 Vx3xz9hHK2ZU4hl/9sGARQQ5czlFZqfzzES0RElGx77gKknynSfBJqlq4N1zjIWWvKSWV
	 FxD/5etCHsaB7rEYscvwIywv9uB/2nDARFlZPqqY/7a3Th5CtDlCn7kj5R5jtt43lVkfx
	 cIDZK0Tu86bXfTLZ5lPUEIiNIQfXVlX/H/NHuw5qPImLswyyq+uA28xVD3JUFCS0okz5A
	 mM9rYGGVqpbtdX2bALmz3RICfPwAZPp1gpVMzhj2XsyX6Io5d9ZfR1JG01D8pKzW4uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=i7BrofaPOZ9C35pnwUvUQZbjQnwmUAOZMnHWHwRv8+s=;
	b=yjO2fXUbPm1tZPB75ZNrTEhjdX4VnwsNdHVUCNGk6Tpf4X9v/0DwOlLW5NW1v2zUSfPm
	 88ijjhAPvBriX8fhQ0V4m/z9inY8UU7HqQDDB8ETjKrvzJ9/ZEn27ymM5qzMGZ2o+mfgB
	 07UO5HqBTN/dXT9Ux2zdkhjv9fsvJmRmA4b6bK1wgY3hI/+taqK5aEcgiaxEh3HeDdJ4L
	 XTakI26VzxG/B0jjH1jZKQsXuASPgIINfiq6ccUDhU4NNZPI8guaO+IU7JVaxoe9LSDM6
	 NnLNydnmJKbl+ZfY0qsGReWzvSV8Ncf2GCPXoKEfVPSa0KjF+IUyC/IKHvID4iALDLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DOtb7DVA;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFAE606A331
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 14:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DFAE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DOtb7DVA
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso3975685a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 06:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793889913; x=1794494713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i7BrofaPOZ9C35pnwUvUQZbjQnwmUAOZMnHWHwRv8+s=;
        b=DOtb7DVAE1KdSwUcKf+S7HY+4uPzSKWdw20wVji3De+y7UvPOcW1G3cyx4+Xjr1TSX
         6uqn80eBvev/J1PyQz62Ck/u3AtHmahePqGSnhEXTR5kuMMs+e0kSitH/ILh0FWiu1bE
         fhWQfaB8wdZg3/0yZkDYGizm2JtEiIrqbGVN7XTy53zADb869v6geSVzOf6J0x2/MFwK
         CdWm+eyVIoAdA0qQuv1YylicA6WrKNyq/9+q1M1IntexK9UrIQrDRsMlH2wSnYMEZJMD
         SD1Hgt8ND5lz4ooYUjbG3mxQMxPnkxem3PvvXlPHDSnNOzhyoKoCubfXAfuk6D+WSnv4
         xmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889913; x=1794494713;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i7BrofaPOZ9C35pnwUvUQZbjQnwmUAOZMnHWHwRv8+s=;
        b=VO8fXrteg4TucAjmR9BEkOitZ/2EhGbnzYiqEivS18aCKBPDzsJE9BQye6agPZ/nOW
         fUfRQi8VdYmV1gjnu4Nigg1pJ0FyaPx824fv9Tosr7B3a/2IdDYQANnnJuCKJI+OCkbA
         z7Cjfiqr35XQrnKPj1zsaoSHzGUCpMRhjdDT3o3wBxDdhMfXoCCUIZwdpRCRV6KJYhAL
         X59rIwtjEjgtpNQ5jBqcQReYtlU92mCjuDLe6R2vQ8UkVXqYh8DiYOFyZIw5Yc1GRThh
         92vUsJ2+7jSqPu2xYmubkXWAUunVXJV4ivvFqzciO8HACbKsu9thAzsdOrGdmqE8MbZS
         Wq9Q==
X-Gm-Message-State: APuU4Z9P5P3VSzrwyDvBjA0s2pEc9JqpyOF6EELmseMGrENXP/KYaw7V
	uIQhpdQaGk0RWI/ghAKAR+CbDolaAE13DFrfm1anDFujiW5jY4OAbPFQmVodAlymF1w=
X-Gm-Gg: AYBFou0dH3Yko/fnqa9TPfVvPm1991Z3sI6fDCTEF4rn/Jg7+O/f6L09qmhJ9SZrNjm
	7n5FyAgZE+vRkrRVSkdNeRJltmvQkghfhJW+Q+NYZAed7Q9lPl91i62f4PxZXvWOjWBhZr7mLy7
	YMAVIQyX9l5oEOczLrbvEnXl+EwzH2yDio/kwWTkiK7J5DITBd64I8/6UVelRMYiXvtBy8TC6np
	Qk0DuR4WcszsTvcGiga7mv+k/RMSiSQ2T7Eee34n568w8yK4qdtpJn5qDMgZFtYuABf+k7ftA5Y
	0c3agHUcdMqyLrRIis7D0gYJl0TJFWLzOWlkjCK1PK9jfOIuGmPajXdh7nWqiCSP8TOPBLJnXhW
	tWwbnD83MKx5QYVFGTyEo/6dJKFGrNnxfLyFGybcq+W8tnPB0hUncLowpY4liw7vUM/DY1CXSPU
	wK+iKVR00mYovyZS4CPgJzFoF59KpTPRaimVi9LnRtGB6xmqcDT45dM+XTSvZhKXcyStlYDLpQ2
	MUEZIxeGU45il0PHtE1Cf79A6TQEpJbqDT6agaoMB0CZ8sMLLIYKnK8B2WbBygdqnd3vCpOUU48
	yu4hVyRGLCZQpx7MN6BG5sPIzUQ1n+i81PnA3Gtw6qF9T7LsRyoNmncyrmSHAbrTSGQV74LxBJo
	b0EyhHFrsMBx3Ti+wbEGnNAM7wvCEJal2ijt2
X-Received: by 2002:a05:6402:4010:b0:6b5:82ad:18a4 with SMTP id 4fb4d7f45d1cf-6b582ad1997mr1243917a12.40.1793889913024;
        Thu, 05 Nov 2026 06:45:13 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be. [194.78.224.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac94e8bsm1697782a12.35.2026.11.05.06.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:45:12 -0800 (PST)
Date: Thu, 5 Nov 2026 15:45:09 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bpf@vger.kernel.org, dsahern@kernel.org, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next] docs: netdev: fix iproute2 process
 documentation
Message-ID: <20261105154509.1cedd84b@stephen-xps.local>
In-Reply-To: <willemdebruijn.kernel.213e1d84478e4@gmail.com>
References: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
	<20261103092226.2e8ab229@stephen-xps.local>
	<willemdebruijn.kernel.a20ae72714a7@gmail.com>
	<20261105143049.51af15a1@stephen-xps.local>
	<willemdebruijn.kernel.213e1d84478e4@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Nov 2026 08:46:22 -0500
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> Stephen Hemminger wrote:
> > On Tue, 03 Nov 2026 09:44:53 -0500
> > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> >   
> > > Stephen Hemminger wrote:  
> > > > On Mon,  2 Nov 2026 22:35:56 -0500
> > > > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > > >     
> > > > > +
> > > > > +Patches are tracked in patchwork under the netdevbpf project and delegated
> > > > > +to 'shemminger' for further processing:
> > > > > +    
> > > > 
> > > > Minor nit. David Ahern (dsa) handles the iproute-next patches.
> > > > I stick to only iproute.     
> > > 
> > > I know, but there is no separate delegation in patchwork to David.
> > > 
> > > I assumed all iproute2 patches would get delegated to your patchwork
> > > component. Is this not correct?  
> > 
> > Right now we correct it manually. Often patches target the wrong tree.  
> 
> This is not about the trees, but delegate on patchwork. There is no
> delegate dsahern in the dropdown menu.

David is dsa in patchwork
