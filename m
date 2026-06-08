Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1B83F58CD
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932035; cv=none; b=fCliyqQHoxKt/929n0BNvfBfyjf5xZ72LEn/bNvvvH0MinYGGUN0yO22XwUc90hYnFnrk/zlfc1W9S74e4isrZ7EVntmhsA+NuDVhM6Vyd32cbGY+b524rOA7OivdbuCRx4EqiXEK3JRAnUeEd7rXt3ecI2U1HSKccKKExNisLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932035; c=relaxed/simple;
	bh=ZnokL9vJuxctPfHNgTo+3iEanPUA6hSo6tJpy1bofuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyvJj9Mgf+ipL5ZRHe7Q4ay44b4eZbLslcZy43aDmsDtJ8zfWzqBw8BiB9PE8WA7qF4ww8Nbd8nMDQAaMfMelGExH9nip7xG1+I2Us0b2HXhBpJTpU9slQtSTnrmb+RakIhNSxf2uieRb9YibAWMZDQhmFAJM/0uyfGhUXbzmYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgQWjCvR; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgQWjCvR"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2bf36a6905cso30598685ad.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780932034; x=1781536834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DuxmpmIdpH3ndJdoAYsRiekrXsSax/s+T0BD+ZCuUpI=;
        b=kgQWjCvRGmHB5CGibw2dnm+iNCj7BCCnIyydac20b+G7lnEvULBpIx2HdqfCtgGs8V
         GD4Aq0oqsg7aRf4cbBfb/PP6kBtA2zGo71aDEDn7UN4WScQoQn91zU6zeqafoF8qTzH8
         1/IRZDnGn2ZpUn26PUN471DC9VrdgfX69XV6JJaXHLU82Z5sNK262h8zvDO/lr0SRGUz
         GbJx/gAGptjug2t+54j4aeOF1sbsMDeTox4gXIfuqUyBR/Cr9522iwsYcLwpVhtMxrn8
         FiMrfSNVUNwgxcNYZcf9EDlqYV/4Tii+J/zs8GCq82y+npjnGkQBv5qOfWg7icVricrT
         FHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780932034; x=1781536834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuxmpmIdpH3ndJdoAYsRiekrXsSax/s+T0BD+ZCuUpI=;
        b=g3gYgyWaMOp/VljWKrcT0a1+4HGXNLui5/EEncJET8MH7MCxV+RoGF/Ac7boUYfSTb
         D/hrCphV5ladQjK70r9CKgwtf0v6ndE31UFqCGRxdSDaryMFaAMOvRu5K9XfmGLTysSL
         aGCCuCxE1EbgBz6KIOgRJS3eSp0vw4Wa/1yD3LVtp9yd/Ip9hPLxs7D+rieBsxu8EEVl
         ckdlnW/STDs3ZpOsp7E77UM9JsQWS9F2Z90TWOeZPe/bOzSOMpjnMsF2WQW73fAtfQ71
         LOMRR09r/8gFSRWDZtf01/ooMmi0iwsDJlmmjC5Pb+2bGoTE06jXo0KWyg7d/PJaRtjU
         o6rw==
X-Forwarded-Encrypted: i=1; AFNElJ+112thGc+A7+MOgigXPhtrkvzsb/iVCv/mEyQlzILYw85oJj8//hpGSZA01cfW9SVtG65IoQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/J6/tC5kVBjpE/ZEUFq0tZlN6vbS0cgkb1dotgE5YRTPOCSkL
	qUwyEp4Vho9MvANg1PPME3zgtB1qLpYZcLgiE6Qv5+yHAh/ZA/TbcPf6
X-Gm-Gg: Acq92OEx8YChNRddNtwCXQqHc5y6B82iE0VDKSVdxWvAbDswv5fNAnwt6YFPodoRJLj
	ox+Dq0W4B4mcMRovnMsx0Ih5MHsye0EkKuDyowpfOUffa6F+0gvz/TpU5DZ31HReztLVnU2IKtD
	bkhC4G8NB/NlXgmGuCgYxnTn5H9uSVn0ItSw/oIiiiX8Z8YV6rtNx4ZjMvRNLKgig0LiUfRKbS1
	vuNNvPN3dcf1InEeoclgCYv0pPi3RRn6XTH43HJOKnuUrU/1P1e5iEB/Q5/cKuk89nKmfw4AtDQ
	h2DclgKsWu6HLGNO/MR73Td/sGne+EIg/60EH6XBeVWEMDNSqroiDznwy52gXDDUSjtXd4MVjNX
	ynXQQD39QsdUe+8cvxNL/f+WAS4qLXe+yQDcNOM/0tGoR3nkiQS7nx4pTdaTL2Hyv/QpQH8ru++
	5B85qSvlxWXWFygxsCTRR1Joohjg==
X-Received: by 2002:a17:903:2f08:b0:2c2:8659:da43 with SMTP id d9443c01a7336-2c28659dcdamr30769275ad.4.1780932033845;
        Mon, 08 Jun 2026 08:20:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649c01asm192713545ad.74.2026.06.08.08.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:20:33 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:20:28 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, hkallweit1@gmail.com, maxime.chevallier@bootlin.com, 
	joshwash@google.com, tariqt@nvidia.com, alexanderduyck@fb.com, willemb@google.com, 
	jacob.e.keller@intel.com, kory.maincent@bootlin.com, jakub@cloudflare.com, nb@tipi-net.de
Subject: Re: [PATCH net-next v2 00/12] net: ethtool: let ops locked drivers
 run without rtnl_lock
Message-ID: <aibdpZV9mlUVsknb@devvm7509.cco0.facebook.com>
References: <20260605002912.3456868-1-kuba@kernel.org>
 <aiNR_GaST-NnkZie@devvm7509.cco0.facebook.com>
 <20260605170952.52c00c2e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260605170952.52c00c2e@kernel.org>

On 06/05, Jakub Kicinski wrote:
> On Fri, 5 Jun 2026 15:48:48 -0700 Stanislav Fomichev wrote:
> > netdev_ops_lock_dereference name trips me a bit (_compat suffix would've been
> > more obvious), but I do agree with the reasoning about needing 'a' lock..
> 
> Guess I hate long lines more than I hate inconsistencies.
> 
> This:
> 
> 	something = netdev_lock_ops_compat_dereference(&dev->something, dev);
> 
> is uncomfortably close to 80 columns for me.
> 
> I think the existing naming is as good as we'll get..
> If y'all disagree I can respin. I'll be sad but I'll respin :)

Nah, it's good. I feel like netdev_lock_ops_dereference is also already
a bit too long :-/
