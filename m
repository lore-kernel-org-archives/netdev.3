Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885459;
	b=ddx3/Waonfh0V1Bk+zLN5+ARBQwRzi1Zv/2c3aA2zxN7HqWfMuty5JGUAebwMzSEcHD5
	 a7mWO5lt+vP3ATpqj8JR3q9qasI0CRFM4QUFlc6fLjMT+VgTiwIwWmSjP+g4wdlYp6ExS
	 kEr79lwDcVpDvxl7/G7EnwSHNBfXU6pzti+HtqgTdc85bYxXMOdBkPNBEgVTp2YdSJ6ow
	 IHygTADJe6HZ7/r/ZWPmlut8xYZDVbXUnNscVBT8OpEq63wcDEmA2H6gv88/YVxJaQM69
	 q8I7vrRXOQVmAw+6gDq9VWUYyd1RGPIufkMH3lp10YhrKhbnJqtzZ6oaT7bbTXXn1EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zGgD8jFSgU9ZTP9p7BKM21Tg7V8OBfUDbvlCylduBuA=;
	b=wLYxzs+VqEu39OCrVdd6Sz31XmkjL9UO+THftnpxhdzOrXmuiWcq4zkrirTJ5LjD6kdZ
	 tbqBPWOzhSctZylGlu3Y58MzB4upqFJCTD4EAzTpaMQB4sIixR2UgIu8pgfNtl6fdVkcH
	 VVuBi5eNRXoQ5j5a8pAMCO2TRtSLge9JkWldMKcImE8Q5lP7JK/VQTLhrSjGDs/GG61v+
	 1nJq+e0VZGLn47Ti1eKU3eKHs45a4kRb6H+sUUKRd7aysZVFdI6pMC010V6gtr+D0FS9y
	 kzvj1zszzFzm/ZJAek4B/XTLC/n2qUdEtCeZNhfaYp1K0MW+gXJnSz8QwoVBJ8OmjBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cDMa9Iwv;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA1606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19DA1606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cDMa9Iwv
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b58cb69927so328005a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 05:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793885457; x=1794490257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zGgD8jFSgU9ZTP9p7BKM21Tg7V8OBfUDbvlCylduBuA=;
        b=cDMa9IwvPOyT3vhpOT3++hDSwtCIEIza18FdFLcHwzthwsi4C09ik/hsxCxR8NAel+
         T5hGuhh3hvjQJs+hxaIsdczKblQj06e0ZNLVyKieH6LPJ+RyPqUJpP5/DEHGT4W1fvHX
         NbdSD2jHtxxOR73lczf4ChnrQZ/53JfqSrRc1hOOno1s2EJM0+TVyRwor433+GJ3Ia1v
         wDSrbVlJAD04FgWle9cJUsOpY1EPiPBG6HilIDJiPgsnRWOrz46XUNJUO+/pQR+W7s/2
         XGyln919MqxaKZ1GhJ8R+5W2NYvEprm9GYHQSWLANm8mR4c9oVqGQitPaUCfkk9qMZ2Z
         gl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793885457; x=1794490257;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGgD8jFSgU9ZTP9p7BKM21Tg7V8OBfUDbvlCylduBuA=;
        b=BEh6uf+5jMIO/dXD6rYExz+FW2KTIWOs9lBWARuwyx5xtA6qdInJboTenXyFJWo0ka
         tSewo9gVHZx16DkSzzcFdiVQtO/bE7TK++Z1cxgKU0PP38ONTe6iX7WURpWJdqseWj7s
         LNE5DRHZZlgVSKkk+ozEyJbVXkhPOoOmyKr3/Ir78hL2UzhZVIqdG3r0dDxJ6Gdor3by
         f/H0OYp1ZcUJk7JVilieVVFvm6V6lQJWCTqJZj0r4Cn5kjOREvP7GxrDw9N/kfL0IJom
         /O4oVvYS3Ce5ZFyjKQ+0ARtvVCx+8iV19u32P38+ZpVkBDNXN0SQAZbhgxqKlR8hQ9Xt
         tJ3Q==
X-Gm-Message-State: APuU4Z/6uWBN9ifxGO6d6LsCAPqEsQ6AoDONpEkwKt3wMy3fBwYFJhax
	nlI7SxH+PHYEBAJRzjifT480JTMEHrHvHVSk1hsYJY7wioiV62+h07K2hZLge756OYM=
X-Gm-Gg: AYBFou0eADiZJe2IHdjiMlglzAfT2genMPLYKH6zrAmIrCUSuHMx8xQainqS2YLqF+O
	0+qfThkr4I17BR74k2YWxqxY2c5cWWcIri/15i9RmxFf6Ym18A+XieTu2GuSJEzUKYV7Myn2iEz
	DZdZOXJRSqA1hbmGdeuIb3gQdx8OcEjY2o3qKevIir5rVhA7YzYFlV/5/2XLTGVaAE3OijUvI5z
	49jDPidZanqIOO8c6EzvTzG3EzJ605SOKletk7a2mrIaIDI7DLPWMGWBpqo7m7+ikbIVl7Nex3e
	0L9j5EqnOckQ7OwvFg+1xCZdWB5kIVH80xkVhgmoRrp6Zep5KHS1DdaqEuMVOVsgn9LtzA7rOQW
	Cx5SVNUoUt5E++x96AV8zZo+DbamTTSFQfrLnBB9AnHVUNVh6NVj+XbEaCmNf2LbKdH2uaO0skp
	9/yxgkut+PWJXyh5MuHqixKq1ntvWwGJwowYyEJMbR+J0tuTvd3aR2/gDi74CsleHXWJPJ+OYbe
	Ba1mm4pxJnnPaVRrg/IGc7g0uxQGSeolsANz5RLo2krIiCvbslAMFznRZvzqbNGDvXY/xdXEP8K
	nYEmk9xDby9TvrraYxxFpb2yecDcruHIV7KzFN0+TmzV6O5vVTZwCUjz5llDgvkdUb9EDloNECQ
	AnjTXlEwwHG7sBuE=
X-Received: by 2002:a17:907:ea8d:b0:c49:c3f5:8bc with SMTP id a640c23a62f3a-c4d2065af79mr209949566b.10.1793885457372;
        Thu, 05 Nov 2026 05:30:57 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be. [194.78.224.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e46a44esm172684266b.59.2026.11.05.05.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:30:56 -0800 (PST)
Date: Thu, 5 Nov 2026 14:30:49 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bpf@vger.kernel.org, dsahern@kernel.org, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next] docs: netdev: fix iproute2 process
 documentation
Message-ID: <20261105143049.51af15a1@stephen-xps.local>
In-Reply-To: <willemdebruijn.kernel.a20ae72714a7@gmail.com>
References: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
	<20261103092226.2e8ab229@stephen-xps.local>
	<willemdebruijn.kernel.a20ae72714a7@gmail.com>
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

On Tue, 03 Nov 2026 09:44:53 -0500
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> Stephen Hemminger wrote:
> > On Mon,  2 Nov 2026 22:35:56 -0500
> > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> >   
> > > +
> > > +Patches are tracked in patchwork under the netdevbpf project and delegated
> > > +to 'shemminger' for further processing:
> > > +  
> > 
> > Minor nit. David Ahern (dsa) handles the iproute-next patches.
> > I stick to only iproute.   
> 
> I know, but there is no separate delegation in patchwork to David.
> 
> I assumed all iproute2 patches would get delegated to your patchwork
> component. Is this not correct?

Right now we correct it manually. Often patches target the wrong tree.
