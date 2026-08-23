Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845197E792
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787472704; cv=none; b=YrKXKnm0mtMe08FIjmSndnD5aKWrAU7C4SqVHz+QPzBVVQXZkuk+Px2UubtCJOsS7z/b+bH+NExQhss0ryh78oV1r44oQqc4SIykmk5a9SfZZdC6TbqTHV1TfAtAUEo6rKdxsEDhQ5NFxS2OAdOPOe+z5V2m7RnsHABxgw45F8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787472704; c=relaxed/simple;
	bh=Rd4EE3XYzr7VSs/X+/vrVBS1ODg6CeHiRfdOAqi+ECU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZZAdkbLqAdCLroU+nMkBVf2r/VkBB0eBuCxnsv9XgEoc0YKqRrUcNBHT3PpSvv8f2C6ZgucUhZ8IKRL1NlGehiwUms9dlQXUU+Kdd2kSqTFjB/DNntV/KDyBPeN3jq54y5e0DYx7a+QOjo13PxwLolc67slY0GIw8LlR7hbQWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+9nyvFB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+9nyvFB"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47de0093c42so1964280f8f.3
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 01:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787472699; x=1788077499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oAs8Os4guZZM4r4YhT9hwvHdJywXro3jgAjf2xZLwWU=;
        b=j+9nyvFBOi8YeZlOuuszNEP1XIg5c2FgUIeskll2+yVB8ri/OGXHSH6V5QGkR6lE41
         bY8eUMwSOtT6ZYTKU21xZ51gvvnmcLe2GvYe2b3Aw4ppVl63V2gyonV5iL9FxrtjTihd
         aH0rubkHFEnlAwKzdUibRZzgn5VYFDP+H+Y1gI+nGfCYEfwpKp6A4uvVo39Go17TmA9a
         lrW4G9FDYwZUfE4uR0tECgI+Zz3JrSTouV0AUGUQ5UDRr+I04AegwJ9OnxioPouPvzne
         ibOBvyXWuKx+SxtEwvzgxp1J9t7+/5gboFwUp/jnvN8uX2QXJ5VMN26DgGqkFGZx5Qci
         D8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787472699; x=1788077499;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oAs8Os4guZZM4r4YhT9hwvHdJywXro3jgAjf2xZLwWU=;
        b=Exe5J8sWmxY5kTrEgKG1AISA4hKEh7zVv+dRnutmA4jCoWo5DhAeDFrhgsARAX68J2
         +HEbxOFsjmQHWX/k04Mz/J3Y6rd7dPV+4tPrxf1rPlkpW6VdKIQedHWr6wKCImMJhzgv
         x9N6N9N2X5NYpPIF1cbTlze/sD0xa3hqkOfTNOQKY8P65YokRe1qMtvayED0JqQtf9J5
         f6fs8Jv8HXSD0Uu+lVWcmiNX+xFVHHdzlPtmwdQHJbVmjC9D+SFuGiN6UffqAHS6YsV5
         kyfaOBTnRzGBlYwBgtLK4jBUsZKbWQVXo9YLrGR+z8XJbm0uD8bPeqdoXb+8u6nI5/0Q
         sdNg==
X-Forwarded-Encrypted: i=1; AHgh+RpcbPjCStBVRh95U37V5F/GAtAU2n3DzryI5h9v06i7ofdrb9P1hdMsBOzmKR3KGIV9NvSMLt8=@vger.kernel.org
X-Gm-Message-State: AFuF++lOWEdwbh9z1cM8JvU9d0fxdxF2h70kp3vAMB1+c6E165QYXCIt
	Hjq2M6FKKqInT/DnlA2v6fJFkygcnIseSF5XIxrNWb627B1j4ycVOfuZ
X-Gm-Gg: AR+sD137aHO+vNQy1Fg+7SkoH1xr9crAw2n9xNmPr/lrJD3Iw8izklmHRuBLQGOCNkf
	jWiuTQMYFQuAAJ74o/Vyht+WTfCPX6Fte197YZIY4smvMrR2qVCGAizfeDQYFqhaUIRkZatAyyJ
	hdy2fHP4Uf1swYubINjLZ3SM1xBnwfGmhpkvl4DSWL2DTl+2TBpTA8dUOpIPkw9lJqmfGljpyjI
	c5YfDOVuANuKBP+Vri4bO4024N3nE6eues1vlnwiq1IPUVWIdN+dqRA+/wMXGgm72brnxwI0npx
	Rg5CS8A7OcibM3kfmY40MPjPVxIdi454kE816tboCDYBcwnuVRow8Q/FjxmaQ7W2f6028s8v3dJ
	2o2mt6Gj0GtCE95E3f7+lOJi3HP8wubD3UpyC1fRoH3RSmZBXt+DU4eMk5Au6BgXBMOeYVIogK7
	gvKmrivCQ0UCZXMjyOpnOBeek/QUnbe+1gQOHLcQZnh5EE4VWLb953yTMgqg4IoPFbIDhhc6aGH
	mThEp7LFozDQGXwn5BgLSJoow==
X-Received: by 2002:a05:600c:4e4e:b0:499:b01e:911c with SMTP id 5b1f17b1804b1-499b830d697mr236154815e9.2.1787472698556;
        Sun, 23 Aug 2026 01:11:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c35a1aeasm46040645e9.12.2026.08.23.01.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 01:11:38 -0700 (PDT)
Date: Sun, 23 Aug 2026 09:11:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] r8152: simplify loops in generic_ocp_{read,write}()
Message-ID: <20260823091131.0254d6ab@pumpkin>
In-Reply-To: <bf541361-3d57-4e53-8c67-78b474b420a2@auroraos.dev>
References: <20260822202155.18632-1-s.shtylyov@auroraos.dev>
	<bf541361-3d57-4e53-8c67-78b474b420a2@auroraos.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 10:52:12 +0300
Sergey Shtylyov <s.shtylyov@auroraos.dev> wrote:

> On 8/22/26 11:21 PM, Sergey Shtylyov wrote:
> 
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
> 
>    Actually, scratch this patch -- it's not entirely correct... :-/
> 
> [...]> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
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
> 
>    I forgot to check size for 0 here...

I don't think it can be zero - assuming it isn't zero on entry.

David

> 
> > +	ret = get_registers(tp, index, type, size, data);
> > +
> > +error1:
> >  	if (ret == -ENODEV)
> >  		rtl_set_unplug(tp);
> >  
> > @@ -1498,31 +1490,24 @@ static int generic_ocp_write(struct r8152 *tp, u16 index, u16 byteen,
> >  		if (byen != BYTE_EN_DWORD)
> >  			size -= 4;
> >  
> > -		while (size) {
> > -			if (size > limit) {
> > -				ret = set_registers(tp, index,
> > -						    type | BYTE_EN_DWORD,
> > -						    limit, data);
> > -				if (ret < 0)
> > -					goto error1;
> > -
> > -				index += limit;
> > -				data += limit;
> > -				size -= limit;
> > -			} else {
> > -				ret = set_registers(tp, index,
> > -						    type | BYTE_EN_DWORD,
> > -						    size, data);
> > -				if (ret < 0)
> > -					goto error1;
> > -
> > -				index += size;
> > -				data += size;
> > -				size = 0;
> > -				break;
> > -			}
> > +		while (size > limit) {
> > +			ret = set_registers(tp, index, type | BYTE_EN_DWORD,
> > +					    limit, data);
> > +			if (ret < 0)
> > +				goto error1;
> > +
> > +			index += limit;
> > +			data += limit;
> > +			size -= limit;
> >  		}
> >    
> 
>    And here...
> 
> > +		ret = set_registers(tp, index, type | BYTE_EN_DWORD, size, data);
> > +		if (ret < 0)
> > +			goto error1;
> > +
> > +		index += size;
> > +		data += size;
> > +
> >  		/* Set the last DWORD */
> >  		if (byen != BYTE_EN_DWORD)
> >  			ret = set_registers(tp, index, type | byen, 4, data);  
> 
> MBR, Sergey
> 
> 

