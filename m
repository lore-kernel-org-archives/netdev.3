Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9886392C3D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110989; cv=none; b=Gu31p9uGOPH4arkkdaSZp3qq6SjaNMhfr7n7fA/xlKnBkKFIU2c2Ffh14qyRPLXhh927Q2BXsW+g7Kqzhm4aqH91Bb5P+dZhFpGPSxiz3I4eCPoCwvhG8qAO0gZyMz+Y/NdGc5OMMA/cFcNIoH5IgMWnofLu+Q39ua2n0pJ7Xs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110989; c=relaxed/simple;
	bh=McfjPJzKwS57vSW0MyNDedyv+QITcO0lgUUipuZFNug=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sT3NEoAC2yWQh4fDow1V83lYMxCZTvEsehDH0A3Gb8RHI2wzrXjKT6mA2qDfp4lO6kohCy1dxbLM0H7S7/4rRXmOJnJAHqhLN2SbU6FWbI14VkESF6teX9OJWup5UK82xozoK6xq4R3SKaQVj5KXdMMuuZ4kuzuBvgzQFhKD16U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec6vOWnT; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec6vOWnT"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7942b9663f8so12772317b3.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769110979; x=1769715779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McfjPJzKwS57vSW0MyNDedyv+QITcO0lgUUipuZFNug=;
        b=Ec6vOWnTZxK96uMv/baHyXYgYsJd5k00BAlNnFXEFZw+IoVcccsfkDqnQgYXxhQBtw
         n7fDumY2ogoA0WpEtXl9eU77JkMeGzXhZwC6e8FqNQ2kVrehNb/kvKnDCzXapHB0/CJ4
         BPgQGPDZPh7WrtD6LoQllzCE+dSYAjNtXpMj+ZN4TS0FGgVMtHzV/8MoXwt4gpBGTbFW
         +JlJTFQzpSU51m2yghyZAv9u0E2QxinTNvEbgYW9LRS0oxBitXpQyUFBj1EGu9lwRPc3
         ps2IbiKTQofitPY89nW0njNmn4JwEZs2BJvCVuXeValNh6lEo6GWn7iR+b/GPClhVfbz
         61lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110979; x=1769715779;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=McfjPJzKwS57vSW0MyNDedyv+QITcO0lgUUipuZFNug=;
        b=g5OoMhajTszRRRxemZ7BpR207KhisT0Ylw+E9+n15UXMJ/wt9snA0IFhX19XRC+XKv
         +vyTtWXP05Ztxfxr3K6gnz5y1Nj586hsJN7HHcgYCotOI0nd5smwOofGMAqHufR5liM+
         K58EUfmfKcymvbYtJ8P+JQYBusU91cVes0/UTl6t/BBY6b3Zqn5iVnLY9eCADQan6tlU
         4iAgPsVDVec1HGlKLQFQ6p5GZNPSNjGLgB9iyfFnFr5GqyPqvLK+kdZaHUZhLMjQSxMp
         4c4J210m7pUMwPXuiB4hPXdgZIgsla3K85kvkxp9g3iY4U1UKAwABLS5Jo40J8FGxn/w
         gQZw==
X-Forwarded-Encrypted: i=1; AJvYcCUvH2KZO50ARs/ALerlnafHwTCtIR9VT66mhjQOGTtVMxlgMn1apDnF9Nd/djEN236I/+kf1iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqsUSSDcJJqGSFGz5fCz9GavunSM45TC6WERRAAvMP8nlbzupF
	eq7i4EnCnQe6V42Bnto/JW/YZ95uc9LgGCPK2JVfn8eabvrpuAJaeMn1
X-Gm-Gg: AZuq6aKqEutodI4WrlAW/isWgRAcawJrj3erop3pStAQBp4p6rYmfJCPuo6h+e+PBQU
	CHG6tNRztXRQOew7F43aRXci+rdDIOWBoY0UQyMClSR4EhQ9gDhWYhANxm5lRVfevj0IRZVgifd
	BjHNXyJaMia0XO3ogaGw/gi+jee5nQB2MsgxnUKjBP4F01zLbOd2bLZ7fv2625YtMWlLtvtNIAb
	B/Q1q5f4agPU9E+8ebfUva2/r1Bm9OYEdmRNyVcrRdrDjRk40DoVotEUz17mtT+4f07YoAcbB0V
	IuvS94FdtWlad2tUAC6kAaifdLNoY70XaK1fTDiPJMciEdQ/AP/F6C6ouF7/XAkkfWXNgyfcUIo
	duklxMTEhsO1O+mn7KSCCW9SMVH22YerxywbXb8GDbU8AtKusoQ9Ve6o+AuC71OIF+IJG/B6/VA
	rMB9+oTO5UXfr1CN55n7hC1ACEzAHtshCL0NziGmrnx4NCyO7faCiZm7/VXK4=
X-Received: by 2002:a05:690c:c509:b0:794:2c3d:7947 with SMTP id 00721157ae682-794399c7302mr7365507b3.38.1769110978900;
        Thu, 22 Jan 2026 11:42:58 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7943af1443dsm678977b3.2.2026.01.22.11.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:42:58 -0800 (PST)
Date: Thu, 22 Jan 2026 14:42:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Srujana Challa <schalla@marvell.com>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 pabeni@redhat.com, 
 mst@redhat.com, 
 jasowang@redhat.com, 
 xuanzhuo@linux.alibaba.com, 
 eperezma@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 ndabilpuram@marvell.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <willemdebruijn.kernel.359531d88f721@gmail.com>
In-Reply-To: <willemdebruijn.kernel.113a625cf37a9@gmail.com>
References: <20260122091527.339180-1-schalla@marvell.com>
 <20260122075206.504ec591@kernel.org>
 <CANn89iL5s+egLhothNtnQf0jtAeftezUjNmbuXtUWgfVV3+bzg@mail.gmail.com>
 <willemdebruijn.kernel.113a625cf37a9@gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Increase RSS max key size to match
 NETDEV_RSS_KEY_LEN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Willem de Bruijn wrote:
> Eric Dumazet wrote:
> > On Thu, Jan 22, 2026 at 4:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > >
> > > On Thu, 22 Jan 2026 14:45:27 +0530 Srujana Challa wrote:
> > > > Increase VIRTIO_NET_RSS_MAX_KEY_SIZE from 40 to 52 bytes to align=
 with
> > > > the kernel's standard RSS key length defined by NETDEV_RSS_KEY_LE=
N.
> > >
> > > I've been meaning to bump NETDEV_RSS_KEY_LEN to 128 or some such.
> > > Most modern drivers can't use netdev_rss_key_fill() either because
> > > core generates a tiny key. And the devices support hashing over two=

> > > layers of IPv6 for tunnels.
> > =

> > Seems fine to me. Back in 2014, RSS was limited to 52 bytes on all kn=
own NIC.
> =

> What is the purpose of extending?
> =

> The current length is sufficient for standard Toeplitz 4-tuple hashing.=


Never mind, I should read better:

> And the devices support hashing over two layers of IPv6 for tunnels.

I'm hard pressed to see over 128 B of entropy. But if extending, might
as well go to 256 B right away.


