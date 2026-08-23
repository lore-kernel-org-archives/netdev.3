Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03724313543
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787472996; cv=none; b=Pq3vSc+8K7Z0cJ4n9lZUrADeQgH0sZXmO0c28eTWvf0xaNXXl0+26eqfqODBQSOUsQltxS5dm3oEDi6WyRKMgjYL1HW0wMpNCN7Lo/Mhg5NZaWbiZ9fJOIPV8MPqm2Qa18zm3nJrqp1B5Zro0qB8y6dtyWyJwy+SN520D3RDYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787472996; c=relaxed/simple;
	bh=BhwbpsARyPxk9fWPXCp8zQNF2jqsCU6NgXzTYhgj2IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dt6Dnale1GfNvdJ82oxjVJFU81BATzjXFwDL7Yx9vBXot8CPkE3zTlBLn821K++zqUlcm8Ito3MJI6teACMjk4RafKyLKzvNCnjhOmgSbgGL1Jbtc8h6/8E1boG+cZyW/QwbO8yf9bh5+I6DzZRRjXln50fTUdbmD8mPRUUjgSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZj9b0KT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZj9b0KT"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47de008b020so1284897f8f.1
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 01:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787472991; x=1788077791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FPtVO2IqXJnahImnb+To18BwB5dcSt8DZxfA0Asvvp4=;
        b=oZj9b0KTBEW6hpjjPhQ2XokqbXeJBPMONv4WhnFHls+XpbA1bPOhLFbejop4C3Chif
         wO3MCWhSFQnIKNXQLUzmNi3qxmax7qrcrKNcmMviSCGmFCFlXw+9yg39VZgF1O//NBWG
         dACSctv2Yr+J/b4gt8GpExK7njzmAxEBWSTV94LzzCAsOoH1MrA6HTUNyuUHjVT5hdl9
         qIMT1/d9xodEjGYS+e6g6zTN6C6L8Bjt2fsoxf4U1rgwLQdIlBO+MeZE7LW2cXe2tOeb
         q+boW14fM7lqboH3EN7IhYSSAyn2qTiI2LAAWHM2R9nK71WQPMpxz2mw+R7RNhH78kQu
         DAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787472991; x=1788077791;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FPtVO2IqXJnahImnb+To18BwB5dcSt8DZxfA0Asvvp4=;
        b=E9pnzNsB/64Oq58InBWNFZqOpIx7ICnv1Dbheq6FF9ZxEpdpIImj6V8uHOImQ/tp3+
         Ob22M4UlkSn6k+5LEgQ9VIroN6vGc2qKri9xUht3JNGMUFJQHI/oHjeaYNrAFlu97xUA
         SV+fmxOysjsbG2H9pckzY5jrfWv8y27bAg3xk1GhxgBEDOTwifA6no2hpaWpHv27cJl0
         ccY7wTNI5nMY6m0T3f9CetHMBpueGI1FHGq7JMPiZzSoDht9pE9q4Jl9zNFDjRqBKWhu
         aruasgJCZ0BVIscWlYnSWMpPdrHHBv1h/pWgjRtyHdt5IsFse2Qjvm6grph3BLEQUBeW
         8XRA==
X-Forwarded-Encrypted: i=1; AHgh+RplqBoxVlgbdlbihW4ys7Ubyhn1mEY9RwRnFkm6DyDPnOITaQu8UQtsk2QEkHGX0wMjNcmEFDc=@vger.kernel.org
X-Gm-Message-State: AFuF++lKx/m6aMGnP3t3HB1uRxLZ1shdUjd5P+v307CIZlVWaeSJODIc
	gV/dH+uY4URSzwNX9PeMG+7pn8D7PK0OzFp3Xj3equmtWch/CWpKe8mk
X-Gm-Gg: AR+sD10ru+ouFEds1nsn6mp92lci0lqYnd1gc3tq0kN0wWre+csEvOftbj+DITUVl7a
	yls8ZqIjhbfU9attZeTSQrFSt62AUto6IpG8cixrYS0lAxZcadw2FvMTEht7ckDj8lbCWMqqdKk
	Qqw81cuIOz9f+sNjWMxVd7paXowiXm3mEiRL/WE8842XSJH3X9SWMcpYc3b6xJMai01SOCzwxCR
	NVJPycw+Q5OFw14d4Ep++f5oVH9+kwAok1T18dV4shGpAKCJhR28v6EZjwIwCX+FN7VB4b0fkBr
	RyrJzXfJ0Trps6NkIdqzOfySo5u4fLKOSrcO1UAjdllu+k9pLeD5bv+r0+bpU5U6qGPm9dp/cwk
	AYqykkWmyCt0+RbNOGN6ZGQP2gHhCV1S6GBfwVljCG/yQLDynROh/hb0HUSZL6ONQcxXzJDvqV+
	RV5PFLiK5e8yScAsxnqkRhVY+j7d/Bidl0ai2+aBdmelY57fKzDRsyvW10wymng7RvRn3Iu6LeJ
	Kd7emSkGOPherWu4CIMCNfIDA==
X-Received: by 2002:a05:6000:4683:b0:482:b823:cc3a with SMTP id ffacd0b85a97d-482b823cd2amr24472494f8f.12.1787472991003;
        Sun, 23 Aug 2026 01:16:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b78eb4sm4281631f8f.13.2026.08.23.01.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 01:16:30 -0700 (PDT)
Date: Sun, 23 Aug 2026 09:16:29 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Sergey Shtylyov <s.shtylyov@auroraos.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, <linux-usb@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH] r8152: simplify loops in generic_ocp_{read,write}()
Message-ID: <20260823091629.1a8441f2@pumpkin>
In-Reply-To: <20260822230326.5d642593.michal.pecio@gmail.com>
References: <20260822202155.18632-1-s.shtylyov@auroraos.dev>
	<20260822230326.5d642593.michal.pecio@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 23:03:26 +0200
Michal Pecio <michal.pecio@gmail.com> wrote:

> On Sat, 22 Aug 2026 23:21:54 +0300, Sergey Shtylyov wrote:
> > In generic_ocp_{read,write}(), the *while* loops look very strange:
> > the last iteration is executed differently to the prior ones, doing
> > some useless assignments before *break*. Move the code for the last
> > iteration out of the loop bodies, dropping the pointless statements
> > as well...
> > 
> > Found by Linux Verification Center (linuxtesting.org) with the Svace
> > static analysis tool.
> > 
> > Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
> > 
> > ---
> >  drivers/net/usb/r8152.c | 67 ++++++++++++++++-------------------------
> >  1 file changed, 26 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> > index f61686433031..de9738bdce85 100644
> > --- a/drivers/net/usb/r8152.c
> > +++ b/drivers/net/usb/r8152.c
> > @@ -1431,27 +1431,19 @@ static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
> >  	if ((u32)index + (u32)size > 0xffff)
> >  		return -EPERM;
> >  
> > -	while (size) {
> > -		if (size > limit) {
> > -			ret = get_registers(tp, index, type, limit, data);
> > -			if (ret < 0)
> > -				break;
> > -
> > -			index += limit;
> > -			data += limit;
> > -			size -= limit;
> > -		} else {
> > -			ret = get_registers(tp, index, type, size, data);
> > -			if (ret < 0)
> > -				break;
> > +	while (size > limit) {
> > +		ret = get_registers(tp, index, type, limit, data);
> > +		if (ret < 0)
> > +			goto error1;
> >  
> > -			index += size;
> > -			data += size;
> > -			size = 0;
> > -			break;
> > -		}
> > +		index += limit;
> > +		data += limit;
> > +		size -= limit;
> >  	}
> >  
> > +	ret = get_registers(tp, index, type, size, data);
> > +
> > +error1:
> >  	if (ret == -ENODEV)
> >  		rtl_set_unplug(tp);  
> 
> Looks like it could be shorter still.
> 
> s/limit/chunk/
> 
> while (size) {
> 	if (size < chunk)
> 		chunk = size;

I think you meant:
	chunk = min(size, limit);

> 	ret = get_registers(tp, index, type, chunk, data);
> 	if (ret < 0)
> 		break;
> 	index += chunk;
> 	data += chunk;
> 	size -= chunk;
> }

That is the usual pattern...
Although may you need to be careful to stop min() bleating if size
is a signed type.
Changing the loop to 'while (size > 0)' can be enough.

David

> 
> Then it could be do-while, because we know size > 0, though
> I suppose compilers may figure it out themselves anyway.
> 
> Regards,
> Michal
> 

