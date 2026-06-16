Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229C23750C9
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615488; cv=none; b=BDy71e8vuFcvfZepvqBwqZOSGejRTNKOIAK8jDoox83c6tTHmKGkCdKwFnI1Ly5Ajl2C9UbXepawgs/IaFkEyYaL0FeylEPI/jh0A6qHFEVB1c4uU7grCEGsZ/+PG3I+fOXSCCaJC2vaMw/n6ktJU7KLLUprPlvC7Yq2b+3qxX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615488; c=relaxed/simple;
	bh=acdlpr0O5PbG7pgRnSsZA3RtNDPjjCyFnU20NWH0VVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tqo7O8RSkxWt/TRcw1dnX/Ub0n4nuDnizgB7D6h/ebZMHeh7EP95MLaodFXkRVYFavZ6+hb3xHRbv7UsIh35yF3kkbwRnvgO4cb7nN2PSU17EocMvM15wSTRlBTUIxNWHrzpBliZAPnVQiedVmGd0DCQJ2Dzye4HGP/mOAND7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7UQ25D+; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7UQ25D+"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-517760dc3c2so29730561cf.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781615486; x=1782220286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zx2lGgEiI7OLb6B1hq18r3Qk+gWhVOfcVFUI+bRfnp8=;
        b=H7UQ25D+wARqkb9eBEGN6tmlA/5UNWuC4AmgHoaVDmZhHXUfS7zB2wqPgTgaFmZkFd
         cscRy72moxh/NTooEXhlh/TUVpAvvEQXFDaDn6ioxMgLmvxJoFIbDA+RqR+G0id7fPNQ
         MueozJ47XHNEJrYHyp9yL6j2fKg1Rt7uyELR8jCNEl40H5Wia9ITJ8gHE7wgW5n7Preo
         +fUUYJ0AakycZ3fPGwoSIU3Wqu10txf27wQLV+BAKkIabw4B4++XXSQghUpDBRRa8L9M
         vsF2P4Q9DsEhR3pqmzf9XucksvS1qQwMoWic1UEvEZTV6vTNYrViFnHOeLo8/nTohh8k
         xtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781615486; x=1782220286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx2lGgEiI7OLb6B1hq18r3Qk+gWhVOfcVFUI+bRfnp8=;
        b=pPxhrBUFthqRCeGyAdM8pZ1Obc1HjCxMueXvWa+/d/Ug1cAlZLbvaUTYF9Z09kSgXK
         dtCqBa/4c0ytP8QJ2UKwaXFQhGT611Yg4Tz6v8GIOQp0lVjSjAKOFzE2hlWGrMMItWv+
         j447ODeiREJ9Ia2HwE46LSBSd15slafvBixT22+qhq7Xblq7jEdXuilax6XlmcgjcApZ
         9xVOGbGjWj10iMzg0mQYySlXfpe51JdI6sWnVJOgCvbb/UaYFuuE0RduBow5/74xlfey
         babA38XU+aIJi831WQN/hLBaKERR6eS+YaU0VeAK5O/WhXVmmHOsRocTvdNddv9UXRop
         dy4Q==
X-Gm-Message-State: AOJu0YyTCiBZmIwOgZjMjtk2YpT0LqRGDQ1KcEtq9Er2P7kv4skgQ4VR
	SLe0KiWNfV+7nRadJqbA6/aJpOm+zZBX5xBKjuME9lsxi2jRK+jF/crM
X-Gm-Gg: Acq92OEBekWTx9RIGFkZ/VZUSP6iDPjL9w1RQlvaBPxWGlLvxhKPa9NAvxRClQbeg8E
	gYcvkUetbRTasscsrov/asLSZ7hrXCvBocadiCj9QfbddTMRtZWQ381tMPQLpcs5WImp2cdDUhf
	iR2Zrri2L36H87n35z1u5c5Tf5w1KMfTlQRTL0r5GrrEaf47OUNpMIzzLfrx6DeueCAYXdqrZ5d
	UM5u4knzRj4Ehx+yz2hOAnxfWjF6WXVfWRiZohWlJyuodBB6ElQ7lW+vfRbYImw/v3dgU5qk9m0
	gZrZV1nX7232KeLz+Qcja7ZuPjhy8HBZYUm+veEYblTjT9Id77v1Tll7mrAsPlRnhS7TRblx85v
	WzY7a001jSkcKfPKPBG4+bbmPPmz9AjuA/VAI6oC13L8DFM4/srkcDbvsInr5YW66a/9sx+lKJ7
	50ET5tATDN2REKf4+n7CDtj587b2ha+t21UH0ll1W0SXmyQNz4r95z+ck=
X-Received: by 2002:a05:622a:6113:b0:50f:f0be:dc7b with SMTP id d75a77b69052e-51991ae9b6bmr49146601cf.39.1781615486142;
        Tue, 16 Jun 2026 06:11:26 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7a2227sm137779781cf.16.2026.06.16.06.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:11:25 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:11:18 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, asml.silence@gmail.com,
	dhowells@redhat.com, willemb@google.com,
	Jungwoo Lee <jwlee2217@gmail.com>
Subject: Re: [PATCH net v3 2/2] ipv6: account for fraggap on the paged
 allocation path
Message-ID: <ajFLdop/sMA3gmyW@DESKTOP-19IMU7U.localdomain>
References: <aiq3f7UZGFp0F3MV@DESKTOP-19IMU7U.localdomain>
 <aiq5VQknt1QHcvio@DESKTOP-19IMU7U.localdomain>
 <20260615133945.6e94c2d9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615133945.6e94c2d9@kernel.org>

On Mon, Jun 15, 2026 at 01:39:45PM -0700, Jakub Kicinski wrote:
> On Thu, 11 Jun 2026 22:34:13 +0900 Wongi Lee wrote:
> >  			copy = datalen - transhdrlen - fraggap - pagedlen;
> > -			/* [!] NOTE: copy may be negative if pagedlen>0
> > -			 * because then the equation may reduces to -fraggap.
> > -			 */
> >  			if (copy < 0 && !(flags & MSG_SPLICE_PAGES)) {
> 
> You remove the comment because copy can never be negative with
> pagedlen>0 now, can we not remove "!(flags & MSG_SPLICE_PAGES)"
> as well then?

Yes, I checked the arithmetic and I agree that the MSG_SPLICE_PAGES 
exception is no longer needed after fraggap is accounted for in pagedlen.

I will remove the exception in v4 and address Ido's commit message
comment as well.
