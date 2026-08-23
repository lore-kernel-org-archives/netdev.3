Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695A22D7A1
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787478676; cv=none; b=GboEdwedlUW3mrINTcZ1b7/mBu89gcCN22gM3iBcP18X1L4ZC6Ifhq4L87z72COj3InVuCG7BLg8Yhe/o9WAPR4HzLjg+0V/5YnqxwSXK9OiORvD3w5k2aXFrr/FO6lZOjcpEA0HdsZN1uB+c36ITRvYEYZJy3Tg6F0tR7cbdTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787478676; c=relaxed/simple;
	bh=f2tDc1kc1ql6btFzAAkAVLGQZw4wnVLkJU+tyy6GTfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpcvWk2lKnSo90mgDGsOzkqV4MZc+tiTlQXsoSqdVjtiZzjUM4Y4/vUdWHPPrI6oWz2tQcF+9iZDrM1cYZ1jLmRxQKbbhT/LGyWaqFCWozqBI9CaEP1k0SKT+NMenn3KZC3H1EqJcyo0GIGqzDw7SJxcw66k3jE52/DyC+EDDFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCd0WebY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCd0WebY"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4980dc26022so16567155e9.1
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 02:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787478673; x=1788083473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wvEAMY2RkZf7PfTNiUAYI3buU2kMNo488twu/BMu5lo=;
        b=QCd0WebYqSZqXXxupF0SBWzWnMk8NRMVEiEyAmiCIK1aae6mHHOoFPx7nJC4RJutGh
         CYLPwt022YxzQsDXYlgnqaCds+piW6DeD9lII+9At8CnCzsPEouYeWFcBqosPZQMerSJ
         vmmLR2byDxIvcwbUNVmSfFSUCTKSb0UkRtzFq1GurlaDAMkFbdmmgtc4+68jfZv2OxPT
         J0IiCMQ0DEno9XeCe3XK1xoLLFxT78FLIEhjh7J3+h5c7LRDGulnnQxd1YC90TWMC2vO
         +J7KpWJtpYIt5p/by5PuNDlesJG3DSJ2GpQxHfIBgHVl1xCcZumIqtI3Is3fTetNEVux
         U3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787478673; x=1788083473;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wvEAMY2RkZf7PfTNiUAYI3buU2kMNo488twu/BMu5lo=;
        b=dGi3CFJ5+r+k93EGhTWnlnx+QJFM7qOdnJLVONoiV7GQsbSKOn/22b42CK/JQO24Ez
         tWTElwLngXkXlNQ0999B67t8HKoR3VDcJiwimKI8nB+Fl4aCQfPg40FJYz8tjYDdCwzi
         5Hn1utHaXXjWKv95yClQoGZTiKuzsqQ0HnMIpBUWhkqvxl1FdR+Q+zx2eQJIov1icK+Z
         YKo9MAtIP7hUWH/V/SyeIDOkGfWYCGNYpGCQLE3Pzn8jDUhHOUvutn65J16GHlqPbepy
         cJGXD7FAWDrVH58u3SfaLku8xv8nZFLYssS2fGJuavg2GW2aKWUHAqY0tyl/DlCx4d9u
         OShg==
X-Forwarded-Encrypted: i=1; AHgh+Rp1VlqGEMT7WfU7lGi9XSgGhi55glN0aYT2WwGkTLSGvhbjqhp13ZrxrdGLvWSjSmtlBY5JeME=@vger.kernel.org
X-Gm-Message-State: AFuF++kZ2oT7qNz0uHQOvXOELbC8yGVTyEQRocIY91LmT+a3RhmdQJl0
	2nPbwomxdadSls3NSZ730+aVS9OCCunNKOuJYnxulDYkPoDpRzeHFyTZ
X-Gm-Gg: AR+sD13f7R/Z9zc/XnvGqczpiHkNo3qIHLhvYlC8RJey25BMx8RVL7hqx+Uz/hONsHb
	YK6aWde29ut8XBL/Ler3rf/xUBAUviN7XtyKGkdAAw4KLoYA+fOPmskUrp/3pj84ZHMOWKoLYQ6
	yM9G6YbPGUVq3ZWA8BLDkaJQUBD6/OXuOFksrXCpzo9wamMx1ASwLirSgNULoO8ENjrD3AjwVhk
	4PrfCiUB7grSEeVrz/ym2Eyw8l+ixImHC6rVwpgCRcT7pKGPbU6WcqyoCUF8Swq0Tyw2Ajwnhsl
	boQuDsV+HIKjUeEdYlwH2JJAYATS1g17l/B8Ky5HW98SUSBi5JYO/tBfDPM/ZUvISoXQO8mVvsM
	/VGNkMij16symy/THv6SWDU+wKTPV3gCcg89lIbhRMhXlNZqEnU/M4iZQTT9pMb1zgq3tMcme41
	Wxf28+PquUeCwh4+ysE+gdN1nRCWgdnuUgBj38vGxeXqtslfVyNAA8soMSXyUjUFPe3wvU+E/Gq
	L9Xs0+ujHm4aphcFWvZlQinCw==
X-Received: by 2002:a05:600c:a01:b0:499:bdf1:7578 with SMTP id 5b1f17b1804b1-499c19bfd2dmr85924005e9.3.1787478672407;
        Sun, 23 Aug 2026 02:51:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9c0acaesm4597451f8f.29.2026.08.23.02.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 02:51:12 -0700 (PDT)
Date: Sun, 23 Aug 2026 10:51:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] r8152: simplify loops in generic_ocp_{read,write}()
Message-ID: <20260823105110.231a88bc@pumpkin>
In-Reply-To: <4a7604ab-c6ef-4552-b63b-3e7146ff42d0@auroraos.dev>
References: <20260822202155.18632-1-s.shtylyov@auroraos.dev>
	<bf541361-3d57-4e53-8c67-78b474b420a2@auroraos.dev>
	<20260823091131.0254d6ab@pumpkin>
	<4a7604ab-c6ef-4552-b63b-3e7146ff42d0@auroraos.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 11:20:30 +0300
Sergey Shtylyov <s.shtylyov@auroraos.dev> wrote:

> On 8/23/26 11:11 AM, David Laight wrote:
> [...]
> 
> >>> In generic_ocp_{read,write}(), the *while* loops look very strange:
> >>> the last iteration is executed differently to the prior ones, doing
> >>> some useless assignments before *break*. Move the code for the last
> >>> iteration out of the loop bodies, dropping the pointless statements
> >>> as well...
> >>>
> >>> Found by Linux Verification Center (linuxtesting.org) with the Svace
> >>> static analysis tool.
> >>>
> >>> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>  
> >>
> >>    Actually, scratch this patch -- it's not entirely correct... :-/
> >>
> >> [...]
> >>  
> >>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c>>> index f61686433031..de9738bdce85 100644
> >>> --- a/drivers/net/usb/r8152.c
> >>> +++ b/drivers/net/usb/r8152.c
> >>> @@ -1431,27 +1431,19 @@ static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
> >>>     if ((u32)index + (u32)size > 0xffff)
> >>>             return -EPERM;
> >>>
> >>> -   while (size) {
> >>> -           if (size > limit) {
> >>> -                   ret = get_registers(tp, index, type, limit, data);
> >>> -                   if (ret < 0)
> >>> -                           break;
> >>> -
> >>> -                   index += limit;
> >>> -                   data += limit;
> >>> -                   size -= limit;
> >>> -           } else {
> >>> -                   ret = get_registers(tp, index, type, size, data);
> >>> -                   if (ret < 0)
> >>> -                           break;
> >>> +   while (size > limit) {
> >>> +           ret = get_registers(tp, index, type, limit, data);
> >>> +           if (ret < 0)
> >>> +                   goto error1;
> >>>
> >>> -                   index += size;
> >>> -                   data += size;
> >>> -                   size = 0;
> >>> -                   break;
> >>> -           }
> >>> +           index += limit;
> >>> +           data += limit;
> >>> +           size -= limit;
> >>>     }
> >>>  
> >>
> >>    I forgot to check size for 0 here...  
> > 
> > I don't think it can be zero - assuming it isn't zero on entry.  
> 
>    Even if so, anyways it can -- if size % limit == 0 on entry...

Not with the 'size > limit' check at the top of the loop.

David

> 
> > David  
> [...]
> 
> MBR, Sergey
> 
> 

