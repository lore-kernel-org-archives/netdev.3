Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E174248B1
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238608; cv=none; b=KzNhMfzqv+nx1M00rrCarWJOfeRpdD8I6bv8rkp/GTtlN4aUb1idErTWqiQLa7CBFQjqMdU/L5JsBSHTHKzweYRURRhyAPKdEDeNGBg4hB5Q+Cz4pRlwR4A8pG4jEPEgrVGO0NfcYis1sAMj+L5/0uRE+kgPb7hTaiuH9nA7lrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238608; c=relaxed/simple;
	bh=etyOxhZtuIAJwlcg8fQ7QuNknS3EtiZbY1soNGp9BIU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkrFR6SbVyBikxkFOb/d68pMbU00foeLiRq79nskij+V+6Gussuz+iKEHp3Si27HnoA9WHYSPgIWvSH6BPceAP/RH1KpHQWJ/J9EkCBw0XVQ+JUkCE9VV33ezNu/QsJdGQheYtE/rhoGN+xrMCAyjvlUYr0+f3oqiKQpBp7hEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=tZ+gFCJz; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="tZ+gFCJz"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso1981780a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 04:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785238604; x=1785843404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/HtC2XnkozbL1BOm4MB4z4Sheq8vJSJof34ikV5vSyE=;
        b=tZ+gFCJzAGWg50n2lqlTPVzqEn94rQgvyQvceweBomUtwRm+d7lIFDy2Pq+WaxFKPj
         XY2GCftHxAcD4bz2DHwHR7ZgJafmqmSFj2rnmXG50JsDvYckdSNBcQiaxJV+joze1U+3
         icJPyL6BI/VC7AJBdIBUwADebm9O9qscILmt9ilCHws7x9msK28mDkDHmaLqbR9N2i1v
         Mr8XA1/iDQBVn05n+w8gBQlljwuoiAHebWHJSBzpveU+fWHYubcPtPIej481bKmKcqgY
         MQYarnhMEcXLXdRkVdMjkVLOKe+mQNVQKUihbDNCrUrsLT80euceBsqMXNjlWWDV5wzs
         cXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785238604; x=1785843404;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/HtC2XnkozbL1BOm4MB4z4Sheq8vJSJof34ikV5vSyE=;
        b=ca213a+2gu17pW+Ulb2yJcy8ADgLGTpdHrbKoP3nvA6i8tZzm2cy+TSeua0tjdehcT
         bCLKkp5wVvmtYkENwoiEfWi2BpsrTaxy1jLB1R3fdV+7VhEkY+/0mBMHt4pnjmXFhl7D
         vX/X93q78cQEGtCOW+VQcCxn+Y2rl2hby9ssf4oZknhnbxcxUzHmaTw2bRcFMnPd8G6x
         fs/uuUyT3nOncmtI/rfeQl7CuOzqw+YNCQmf6+aSpAQpB4njvvXqmNgu6os3dCCmgOwe
         67dnVfLS+n5GWnfw6fTecooY3nZztqNv7f+AGo5rCBMHvN1nrKouucedXagCmOm7j4Yz
         PWlg==
X-Forwarded-Encrypted: i=1; AHgh+Rq+tIguJbHRvP/nvfaiG4Keq2EHMrgUNtD1tU9G/X7bnPvck0Tc2jviPUgpBdUjHrhABGyuhjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNOIFFETc9PiadxlmCy0oWrDGc7ahTt3eM4srXaT8jM0nyYMgv
	DPAgrvj687dngKQ2Br8myMNhmBToV0szOhjaRH/kkCP75nKd3H9eCziJeNC6USsozxU=
X-Gm-Gg: AR+sD11jZWCwYc8Z1aEg9I7+jOc+7zMBCzAGfOH5M82nW4Sl9OGg7htHXpJMhUz7qA2
	ELSzeTTyr5WWvYqbh4lPWRDsFldoJIatZE2Kogueims806H4BC3GOVI09klL4kRoYlAbfEiRl4L
	VAmf9gwZGxXtW4EhAam6ymM8awQudy5xTXYKkwQcVEDtRoMGNNeAMS0NXVeB8aYFt7adOiiEaZ0
	aD3o304f4zeX7BE+zhyEKXm7pE1Ag99RfLch8hTzxiVY06NNUWP77TGIVXgvmysI+u813ENY15K
	m//8AEiPnaOwiBym8hVa8WCcmv0GYcKNcz8LTJ+BOaCyz9PzNG/gDT3cNCfeBMnSlHq2cCnKiGp
	zdLAR04MNTBw5wslDbS9GIQi8ST7UDYEjkrIszmVRrowDG3SdKIvWwjuINmCLiA+6DrA6ScK7PE
	9TtM8cJFdbpslrI4N8rmIDHOK9UCJRFvyfOEJNCBGPp+6QHrdThZmhU0jy4UexaZpzGW6biQ1Dm
	MDRyCXUAA4rV8+2pA==
X-Received: by 2002:a05:6a21:487:b0:3c0:9c19:65a0 with SMTP id adf61e73a8af0-3c8ba63bac4mr2823692637.72.1785238603787;
        Tue, 28 Jul 2026 04:36:43 -0700 (PDT)
Received: from Metius ([103.158.43.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548efesm44173814eec.14.2026.07.28.04.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 04:36:43 -0700 (PDT)
Date: Tue, 28 Jul 2026 17:06:36 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Joe Damato <joe@dama.to>, Steen.Hegelund@microchip.com, 
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: microchip: vcap api: Fix possible memory leak
 in vcap_decode_rule()
Message-ID: <fgtzc4qsfhquom2ipslp6w63v7v4m2gdglo4rzvgrzjbeoq5yj@67lizsbkscr6>
References: <20260727125757.134611-1-nihaal@cse.iitm.ac.in>
 <ameUygDr01/ZvnPD@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ameUygDr01/ZvnPD@devvm20253.cco0.facebook.com>

On Mon, Jul 27, 2026 at 10:26:34AM -0700, Joe Damato wrote:
> On Mon, Jul 27, 2026 at 06:27:55PM +0530, Abdun Nihaal wrote:
> Not sure what the style guidelines say, but the label err and the local
> variable err having the same name is a bit confusing.
> 
> Maybe you could make the label "out_err" and update the gotos instead?
> 
> Either way, the code looks right other than the style nit, so if you resend
> you can apply my tag:
> 
> Reviewed-by: Joe Damato <joe@dama.to>

Sure, I'll change the labels to out_err and send a v2.
