Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701359;
	b=ImOU03BV996rIPBTFB9QJbzCCzd/zlEu9+JEyjgS3QnhucLEONVHg83d7uRhMha0qCJ3
	 MOZWK2jgHVXDNFIubB8olZEPJzupWkzli8fgFBXUxnfwLKScmjrd73oiAzhqsPwJxyA6D
	 wS9iqnpVBp+lgTpduyeLg81jUV3SRVar9WZyC8QfkdDZDoir37qD3WcjfzRode9a7Cnct
	 rRfPMBZQiSNeQyoaVDHDSCcuLezS8DYYDvGK0RqfBT0yZ9SvKKkKh/+D0sZGtatQLYyZ1
	 UfkzIv99giGsauwHK/tf6QT4U4cLEKL4jqsQtCUqbC8p1hgf6mtzeaE6KjKo5DkMrLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=O3SMo0NE3DLwpih2KEd64CxyKuLYy3YU4G3rWnR4pLE=;
	b=2qTXLo5VoVpToy/xRSky/hfLiaKuoGiHMTYEHfHfexcyy+JU5OSb4ymqpMcxMGsROw6W
	 c11RVGzXD9hC8RytU533sBDNcHfxMDweXWibwas7wYZFeV+zHF2NfrG402JkCMwejGOpZ
	 dJMUc7/DSMN5j3+dkuxYSQFk72LEHNOoRXGCxAL8dnbxhGEJkFdHO86Tk8RUHk3TnEY5h
	 UG9kAtXU9gle/cevt9/OaiTaJffst6z5b7PavEXf8T4wIRAhpKOliSUTPu+ExP2xfwOxu
	 v5A6MAUlrHQmbTRy9ZYah1ra9JHQoLp4VIBqziwFTr/y5JlUMaoz1Ik7yB62vK2LYVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="exiE/1Qo";
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB2606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EAB2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=exiE/1Qo
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so213515e0c.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 13:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792701358; x=1793306158; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O3SMo0NE3DLwpih2KEd64CxyKuLYy3YU4G3rWnR4pLE=;
        b=exiE/1Qozj5ypis2bDJhhKzYBSjGcr534nMvbfngWGniIu/6R9Msw+nBY1APTgiVbP
         VaI4PxOMSijd2+vhySeJq3GEoZSarPiWPQGzEby5iuFK6MtKqanox11GJ+Jze/cfX62N
         +k+SpSqSOeiSoXrvGUvbSlwPb7CDXlWhgviiWi8Isv8yTipm1WAql3Lt6zZUaojCSjJJ
         AP6anqAQT5EW82wBMgUKG7q8rJehluPiL+rwJ5XvGd4pivv06qzSnSkZyQMuxKvL2M6x
         rQzdST0Jscgv0KlF7yfN93Thj0XqFo+VSBkvsV3pe6gq8fSLci+GwE74fPoZjvqn9nyi
         OzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792701358; x=1793306158;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O3SMo0NE3DLwpih2KEd64CxyKuLYy3YU4G3rWnR4pLE=;
        b=tO8OB8XbG952phIkzzeqyJAP0xNPoGCcdgt0y/u36XUqoi6ZPRDRqLPZ4RGutYs1Ox
         yVjHZC0DrlEDncKdBRAsDtpKyUO3wIzXgX8Tv+DUvkLy2OPP1lRLcmoQeBQgoaQiu+W9
         1oiB17IVpuMi7SLaFna5/RVWN03opxtllob1Fo6SbU/Q4MPODc5BhjyRfirBMuZbVkpb
         UA0LmNXimZwYRdROyliG6X1d1zMqGNuGM4TwOitrttgQpx7zH2g+mcSWPT78yaniEDch
         kvhSp6DEehRTl/KwhDM3YTlQL3bRUgYbsszGbOIa6wmotzWNXGYXDzyYkjoYJw/kPRf9
         0bFg==
X-Gm-Message-State: AFq9FYJn2/NKLwFHT8Be0Xmuz2Bk+57T42ofQBjcdLiOXze9sjR56sR2
	WLCvoyME9dhaOJxk2sYA1xpX2O6e9VlMJ7CF2zFZW9X8POU89V7k69aM
X-Gm-Gg: AYBFou2bWa2SNhyjwoByz4fi2VYyC6XF+YVejVIoltox35I6A6ytLYevPipT6uV/9ta
	pVqq0Q4gmf3pE1SZZzRa56Xl7jmROptzCjQNVn2oxF+4wCNMa9qsDuljG69WUelzBbmMC5krXqz
	+iThwTHBcYFi6HMB49m880EaOz2bHHcSoHXhfsR7sUs7W5LiGsG3LzmgJy4xvMzTjRgWS93mDnj
	2GVkBSVtRoMcLNcSHTHl8bKV52/URYdW49Xp2dV6CWJOPnQtbgCmDV96t/In3DZhlThXe0MMLA2
	POAeR/ZqfGqWdGSr9yHDM79Vuu1T7t8n4HGo3yuEqtlKOAmZ2E+SNguFTMPhRM4eSJmOzgFMlgZ
	UAImEGw1bx44W3EbynKzK1XKWDtVuSQxU6bZIrOedrnWQHIHXNV4UTCSlHwIEYOkXoDicXeItRF
	6H1y5FHItCyloaPLFDcyUFtgPMTzeC2lWF+TWeDimo2IduYoBcQgAGpzfh4t/01itwJzaV09ByR
	yrbcf7JPEDcPhAW3vYxChZ12MkfDnhOQCa75VIEpN21nVUtZjLXo/mxiz0E8cdCzVyenAz2+Ocf
	ZZoUxECtfvByewfcAVGbdIcnN2B2Hl1x4FDBU39+ewQKqIwWbm9KYOyTGfO1xPqIt/ub15xhtnZ
	MzHPR1RhwpYCP/3s/QBE=
X-Received: by 2002:a05:6102:5708:b0:7cc:2c52:47aa with SMTP id ada2fe7eead31-7ccc2c697d6mr355449137.0.1792701358326;
        Thu, 22 Oct 2026 13:35:58 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec13f674c5sm218083e0c.16.2026.10.22.13.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:35:57 -0700 (PDT)
Date: Thu, 22 Oct 2026 16:35:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Todd Bert Freed <toddfreed@meta.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Cosmin Ratiu <cratiu@nvidia.com>, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.fe159199a64e@gmail.com>
In-Reply-To: <CADh2yMydLVUozaXJR=uvkkw5AjnxYhFs7V4dUAkfBs66i8D4ZQ@mail.gmail.com>
References: <20261021210200.788191-1-toddfreed@meta.com>
 <willemdebruijn.kernel.31749cef483da@gmail.com>
 <CADh2yMydLVUozaXJR=uvkkw5AjnxYhFs7V4dUAkfBs66i8D4ZQ@mail.gmail.com>
Subject: Re: [PATCH net 0/2] psp: drop packets with extension headers in
 transport mode
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Todd Bert Freed wrote:
> > Todd Freed wrote:
> > > While working on adding support for socket-less psp associations, I
> > > noticed that this case was not being handled correctly. It will be more
> > > relevant with that series, because it adds udp support, for which the
> > > psp nexthdr will be taken from the inner packet.
> >
> > Just curious: what is the plan for replay protection for UDP?
> >
> > As PSP depends on the inner L4 for replay protection today.
> >
> > FWIW agreed on the ext_hdr conclusion in this thread.
> 
> To clarify, socket-less psp associations will apply tunnel-mode psp encap.
> So it is in this sense that UDP will be supported (not e.g. adding support
> for udp sockets with transport mode psp encap).
>
> That being said, UDP which is PSP encrypted (transport or tunnel mode)
> would be susceptible to replay attacks, just like regular UDP. Except in
> the sense that after enough time has passed, the packet would not
> decrypt if received again (operator has rotated the keys, etc).
> 
> Not sure if you had some other kind of replay protection in mind.

Got it, thanks.

No. I'm just slightly concerned that casual users of such a feature
might assume that the security protocol handles replay protection.

