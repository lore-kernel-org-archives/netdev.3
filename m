Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1853C10A1
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403543; cv=none; b=OUcvf8/qVTAL/Q7TdS1jy4aZD0eWxFAhaWCJY/UX5KTrbUbCB2H3G1tuJ3SY/Ts5jYeff4gHzcJUTKW9MdFcxNBG2UPNI55H3dflDhiDzOdcsl0qOE3X9fbbqj2whdzqBHv3gDgHjrvIP2m8NIvQ5VPDe7dYVrIrBlraw5vFlAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403543; c=relaxed/simple;
	bh=MMGFYiSRGCfXXvhbe4EqPnTRXDErXMy+5ahTEUrC3TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVOgi/FUCjUlUxyqwztVal4cDD4d9Ih9AkdmjxwwrirC+n/+f0xfcX4J3sUqGGbwbkU6OOeOvVi1cmo1JyOMzAdkN/AVvkR7Jz2VY7CF47lQAnqpZgtcR0Zbnf9ktUp22rPVKD4sRyC787gUVZ7PsUS30kwHu6dO2gs7SbgCwt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAQ/tll1; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAQ/tll1"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2c7c61b5292so741095ad.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782403540; x=1783008340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbyGDtKr8zhRSq43d4q3VePAfjy9Kgc4Z0EbXkOItWE=;
        b=CAQ/tll1YT/hrTkwentqxfVvWfdp1/4AaA7sS4WbDZSWcggj9pUb5f8i5OihDwUgkT
         VQZZhnvYNCUGtpOWTHTuVYUiiU2rPubJTtDmPYWGuCe8w6fvxylVnzrNe9qwqKmF3eYW
         Fgm5NB7V+t/X2iWx/WmEehMoifHOi8iOif47D7yCpMD6u5GS7gEDLgIpmAcy2tzDr5xv
         wJAY53ywo5o2gFU321lVkjw5RF+CJYDWbPneS3WMD0LzrSNwJQ8/Rydkg2s+OLcR3kdC
         IRjWAu+fP96aw5hE/fl8bUDelwvjdJ7BFFTOIKr6IiTH2gXJe5UU5a5y8wnBXhJtO2qh
         qrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403540; x=1783008340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbyGDtKr8zhRSq43d4q3VePAfjy9Kgc4Z0EbXkOItWE=;
        b=DAIC6itjehOj18v202aHjQLMYfoqe9EbGfmHT9tUnU/1nfQTd/f/CxTSdqt6yQuUEY
         8uOL+0shKNB9oCYdK9ELU0bSENBDvwO02OO/4fRC1VyuQ0PKd8rUE+n8rqz8u3lluAU1
         b5oC51DpjI8B6yfvgaDRh9xQoQXZFWqIDW2+yLCD0Lttpn+Ti/B+VSB0qkB/xVecnjsV
         ETBuuvoQ5hEnOj2L7PIxZfI/tXfQY4FQIbWgCDBOPx8FFgP1EzJuJ0ik6IFEDYIAXlUl
         cgpVrSXrot3aJf/9WX6b6wdXobCnn8MdH6O80KZr3Dig/dGB3PRXQaYHZUXIw1OGAS5b
         Ch5Q==
X-Forwarded-Encrypted: i=1; AHgh+RojmTasDrBsF3L5xcVCSJeQSDiLW3B7In0OsYoM0vooC8OsGSQqMv6KJQmxt1vf0EarLVElV2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRzKAKgO94E9aPvJ+8MWLEYl7yWVbd5kWYaOr7+rPiISqIyPUI
	FNhLlwIZQ12pRcwjy0YLLtLsB8fiagPAPpqNnQUqGrj+7xip85rgqbOF
X-Gm-Gg: AfdE7cllhR2jY5lvPiLzbvqsd8Aq8tTYnDvKimmDuf1g7imxiuYFSX4rkqcv7knsMHG
	0XEiH2U5QI7G9Oo57Iu18ZGlVbJu/2CCEv4DoLkyzDHUhMRLrRaQEFvzWZFdvln/voZDM7R7kvA
	ypLqms83gRSpsGGTNE7PxgUe4CLo0bkoujrb4BLL7tb5w6RlRoJ2GVrL/iPHQOrEooa2Q2JvXsi
	praRCBgkN9Hp6No4CYoc1Zsutm0khf392gHvuDU8egQm8fX3HZRP/5tJzrdKSYOvLQw/CiQqfv0
	023UaelbmqjgfxvpAu1vWs6eORd/J1+nHcWcK6Xk0/RfomKCK+5xargUa8CMS3NgkB1cpaY72V3
	5cejAExScb2uBguTY9R5NW+HeY5kceDuYjBgj/Q8CH+t9lYkoZXIqBDGjWGw9VCGQ1KKKY5796G
	fFw5Kp+Q==
X-Received: by 2002:a17:903:2ec3:b0:2c1:98b7:ecf3 with SMTP id d9443c01a7336-2c7fca71861mr35878665ad.23.1782403540185;
        Thu, 25 Jun 2026 09:05:40 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ae6e4csm23397675ad.24.2026.06.25.09.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:05:39 -0700 (PDT)
Date: Thu, 25 Jun 2026 08:48:51 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, 
	sdf@fomichev.me, dongchenchen2@huawei.com, idosch@nvidia.com, n05ec@lzu.edu.cn, 
	yuantan098@gmail.com, kuniyu@google.com, nb@tipi-net.de, aleksandr.loktionov@intel.com, 
	dtatulea@nvidia.com
Subject: Re: [PATCH net 2/4] net: add the driver-facing netdev_work
 scheduling API
Message-ID: <aj1N3ZSLweFvA1W5@devvm7509.cco0.facebook.com>
References: <20260624182018.2445732-1-kuba@kernel.org>
 <20260624182018.2445732-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624182018.2445732-3-kuba@kernel.org>

On 06/24, Jakub Kicinski wrote:
> With an extra event mask we can easily extend the netdev work
> to also service driver-defined events. For advanced drivers
> this is probably not a perfect match, but it makes running
> deferred work easier in simple cases.
> 
> Expose the netdev_work facility to drivers. Add helpers
> to schedule work and a dedicated ndo to perform the driver-
> -scheduled actions.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
