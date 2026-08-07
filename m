Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211C38D3ED
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122287; cv=pass; b=KICbp4DcqtW2/HN2ml4pYW/3pJPtNqn2I0GkW98zWsLVsq5gp3Pc1NK4dhVpEGuPzNWGUkGHJt2c9pctLVuJdkGlT+54zOlI5ZoudIjBVrOXbRsECUhhVoUBT00IqCaqe5iBDXHgm/Osa0/JWhQr2Fp+BE3hxeMYnE9XWDlKx0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122287; c=relaxed/simple;
	bh=zvrCIymmtK/Ix6DbPpatPplYquEvVymP6m+/iiepH+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpyHSGmyExcd5b17ANGDtUmaEkZK5AV6o7AIwoLg9ReuNJZ2SJjBefqAsUjUVOxPeY67KWZ5W7UyCwX4n1+soSv+zEg4mOJWZ7SK+UwpT/AQA8pi6MVw1zQP1QHofbKJnBNg56KWs9KERdfemmSUyDpVrZHJF8xKJzZ+0ZQFwdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2JZRulk; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2JZRulk"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f84023916so3339854f8f.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 10:04:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786122284; cv=none;
        d=google.com; s=arc-20260327;
        b=b5cXAfMdqe+F8rb09s1B3df9VhiOcFo4T7+XwzLm6pagQwOOgoCx2r3wglJu9Yp7tg
         3IdVttDs64s13H2FrCjr8y1BKXPoHok7g42LQNnfaFcG9SRLd+ssw9eH2aTQaTl6KiFp
         iQuh65cplYcnZCS77PXJNWofjsBZ+taH+c9ZQDBBUpTMV0bxL6ASyrCo1K6wR0mzVOnT
         SRcB5tx8vnwQAG3d4c7kF1JOUVtl3lwqJ7BGFUBdeqBgnS4NVVBER7Qb4LhXydVHFghU
         CJ4ZCwmlzEAmLBWBvDTvoSSPI+Itd0ZJ//RwDkHM2UYYJL0QgVUaXt6eCORKqNliM8uZ
         ludw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zvrCIymmtK/Ix6DbPpatPplYquEvVymP6m+/iiepH+w=;
        fh=D/5iokcbYBJmkpmly1DJKuS6bgV7BI4lmrFrBEOUauE=;
        b=ro8k5AmaZeMCEg73jn2wjgmpeyEYuJLIZpi3HjdE0uiWqsMFsdrxHD0YhfvKbvRiD1
         E2iEcToFBlbelbqpugrvd4qVNa2e5HFtHCmMZH3KKzUugtMu2coAaJgieYcJNc8DtVgv
         QaAH3me990B5YpgxgUejmlmwGXq2K2RaEV+lvURnKr/KjiRCrMxr0FjKDOqi1dmAB+Q5
         0sYqf3Fp21BgXvgEHnDqLPmof1ylR9f4luXCW9NoicT5PnurYNwwo7+Ikbsm4ejb9QH+
         A7BbSvVYE6tw+Y9wuuDh4TrbbiigEfbR9ugNnyzpVk7zWaNKrWssjnp3pj2jtkPXFoEN
         P1Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786122284; x=1786727084; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zvrCIymmtK/Ix6DbPpatPplYquEvVymP6m+/iiepH+w=;
        b=U2JZRulk2NupTy47BViUQIVQp0LPXNedSPF4gMKa/P/uZAWfCwsQNPKPl7UyUeGlz4
         v5rZgOW/vlYhTcbnvxfTynwK6uBGSEErgIoM0XW+kLeP83tHc8AmpKyYAheukzF8oEXZ
         7VKo08URHIBhe7k1m0huEM6W7pYYnfIbatUtuxzrObpUHhkxJoW0ERj+pcwak8G6qd35
         xQvjski7/xSD5rkZZg6OElP7jVZfRbHGr5Y/SxS99eQYefun6doos48cKWPHvf3u2Khv
         4Im1HX3dVwHcUG9U8QTaaLlUou6rzapWy4gxmiNbwbGdB8kerQc7an3gdpEWdAFO5fFM
         +jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122284; x=1786727084;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zvrCIymmtK/Ix6DbPpatPplYquEvVymP6m+/iiepH+w=;
        b=Lk6g4iKsa16/33j9dsi90tKE1Q78nG0xedndmex9HtMudxkOT+E5cXlHflk23ChB+E
         yfqyPC01dXAnY736ZFqmBUjhIgU0uqp4HQXfqpXQaKK7YDXXfJcb743fbqIMxotJUr5f
         qcbl2csgD1e97k94dBjxBmYCdxB8zESN+2ExQ6UU5JE4bWmiMji1rlgEB0/D+jMFsRXo
         HNCnuGYlDjXEl+ttv+pMSx+sz3yQ2iRE2iE1gTVOUFQVVCGUU9xVNprG4LsYmBRUAFoc
         qCaJTHXjGHcsQx4Oj0swr8xk5/HgfgGHQaO4T+qRBIjwwabo0FO5w5UIlE8dm8ErwCpk
         bjxQ==
X-Forwarded-Encrypted: i=1; AHgh+RqOZf2Hd7JURx90tqUSN4QHLVyotZxwRPIrzQND/HvNjrNUGXsfQO8DMxAnwKx/9aGAQcVyMeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Ri/uZvwDzRxcyrbxTBiXFdEPyj02CQZzvohvTpS5RguC4rTy
	TyaReUEE9RSQpkJt0MkLblTPY1GS/vIc/QTpCFQzBQzqwBB1DJK6Mc9KXTdVhVefebRsnsT7i86
	yQEBp/gY1Mi++iWCmTCRTMOb5iEmswxs=
X-Gm-Gg: AR+sD10KKepgToSYZsNr54dq1h28BJzvuHhv00do2pnloAFPjcE4DfqZ5hDRp+Bhfb3
	AvSQ0tny3ppkq9iWtHmv1iQep3m/w4AjDx+oTjpg1B9dEDDTF4oDmChiq+piGpK+5P/4T6VMXtu
	CU5EXPKTQsfTTs62citOJYqUCDlBr8n9PX4Bwqkiy2qTK++UuHNolhv4Shi/2+xmkmG2PrDRRfr
	ztQSWs83jFm0LaPPaaJZ7JNOPI931LRaDt+JBnUfiJQ+kwcb+fbqzoWA/Gn2JYP6Fa7HeFjScn8
	Y4MU6l6m3TnwtCd8jxA01ZyNkDy/puVDBozOpDTBqh3SR5LNrWBWrwrNoIH6HvIPfUN1T1HdIm9
	Mn+Rp7KHShJr3LHwYfEgeNLVeLfs=
X-Received: by 2002:a05:6000:2991:20b0:47f:9ac6:c9bc with SMTP id
 ffacd0b85a97d-47fec4e2905mr35190960f8f.2.1786122283745; Fri, 07 Aug 2026
 10:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch> <08f1b0c2-2b09-4c30-b95a-02959d409a03@trager.us>
 <38359a70-ebc7-49c5-bae5-0d3d7bf82fac@lunn.ch> <CAKgT0Ufpp+AVrW4raMw=_PEWQdu+dkp+9xhrt1se2G7=CS83iA@mail.gmail.com>
 <SN7PR11MB810921E7DA70DB3F6FD1C41DFFE82@SN7PR11MB8109.namprd11.prod.outlook.com>
 <6e905826-779a-456d-a37d-7602a37ab6d7@lunn.ch> <SN7PR11MB81098D82A7B377E0AC439979FFF62@SN7PR11MB8109.namprd11.prod.outlook.com>
 <cb7921f5-cc9a-49fe-9561-cac903cf611e@lunn.ch> <BL3PR11MB63854B0A4AA33A718D474C6588F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <BL3PR11MB6385517EECD04C783E9DC42488F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <26d44b09-d72c-4e23-84a6-3d0ea4a521ef@lunn.ch> <705f6fcb-e0e2-4898-bf83-78c38f32f505@trager.us>
 <BL3PR11MB6385468A86BACA1D8EFEF2BE88F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <SN7PR11MB8109F7A3F491E20701BDC0DFFFF02@SN7PR11MB8109.namprd11.prod.outlook.com>
 <46f714b7-ec6e-4b26-9ff8-b7f27f11fe33@trager.us> <SN7PR11MB81091D62922BAC1AF7A553ECFFF82@SN7PR11MB8109.namprd11.prod.outlook.com>
 <SN7PR11MB810996F17CD8513F4CD57371FFCF2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <CAKgT0Ucz8FT0EvdUMm=dUS-Q171ZuT-i-n+mahJV3OvQnOMkyw@mail.gmail.com>
 <SN7PR11MB8109B6F350AE2E5BC02C6E1EFFCC2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <SN7PR11MB8109AD2F25C4DE21C048C9CBFFC92@SN7PR11MB8109.namprd11.prod.outlook.com>
 <SN7PR11MB8109BF8590FC789586C326F5FFD12@SN7PR11MB8109.namprd11.prod.outlook.com>
In-Reply-To: <SN7PR11MB8109BF8590FC789586C326F5FFD12@SN7PR11MB8109.namprd11.prod.outlook.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 7 Aug 2026 10:04:05 -0700
X-Gm-Features: AUfX_mzPHZ-O-JhgXwKBP9_KCYzwOzPjKw_U8G4K0BkAREgiSA1jCx0SPY3Ry9o
Message-ID: <CAKgT0UfEgu5xFts82j4=qFCiX-JnNVrtL3MUEhffpP7B_ZqvWA@mail.gmail.com>
Subject: Re: Ethtool : PRBS feature
To: "Das, Shubham" <shubham.das@intel.com>
Cc: Lee Trager <lee@trager.us>, "Srinivasan, Vijay" <vijay.srinivasan@intel.com>, 
	Andrew Lunn <andrew@lunn.ch>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz" <mkubecek@suse.cz>, 
	"D H, Siddaraju" <siddaraju.dh@intel.com>, 
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>, 
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>, 
	"niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>, "Wirandi, Jonas" <jonas.wirandi@ericsson.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 4:19=E2=80=AFAM Das, Shubham <shubham.das@intel.com>=
 wrote:
>
> Hi Andrew, Maxime, Alexander, Lee,
>
> Just following up on this point.
>
> We've added an instance field to handle multiple PHYs/components
> within a netdev and included examples in the latest revision.
>
> I'd appreciate your feedback on this approach.
>
> Thanks,
> Shubham

Honestly I would probably defer to Andrew or Maxime on this as most of
the DSA stuff is much more their wheelhouse than mine.

Also rather than submitting a snippet you might just resubmit the full
patch with your changes as an RFC as it provides the full context on
what we are reviewing.
