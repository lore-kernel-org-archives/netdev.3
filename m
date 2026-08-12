Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF45322B6D;
	Wed, 12 Aug 2026 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564836; cv=none; b=Yb5i/gn5UORtAmaQxxeyd2na9K9iVlLDWhxXlnkToIi3lc/LNC7VJWfZnd3QSshRJiQ7WsyTwPfOFzZ/5XTP7VLRG2BQgN6UoCzjMpO9HN+ZFuoqopDyZXfzWSpw/4rMGhO0vWkj0aJVpwimFcfPbMxpIp4Od8jWhFL94AX+rpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564836; c=relaxed/simple;
	bh=2wRd+aPJlwwv7YwxJ7bJpzZlu/1OimrzKxof2GzOPjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8gP03twjhgnu50OK7WkKWLNtfkePtrSo22ZpWia+f6oqAczLscsrJNWGNlmpR6PlIodHYx3HkDgWq++seVGreD3W57I3ipUmrBT5vDxWPSHP3t2DDbDokpFtEI4lQcCrHLPWEs5h8yHSeegM19F4r3v/J8UNJJeOPndZPDKmco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=cmkk+XH7; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="cmkk+XH7"
Received: from L30177.local (unknown [IPv6:2a01:e0a:ac2:22b0:f846:40e6:d9d0:ef5a])
	(Authenticated sender: vjardin@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id B5912780383;
	Wed, 12 Aug 2026 22:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1786564832;
	bh=2wRd+aPJlwwv7YwxJ7bJpzZlu/1OimrzKxof2GzOPjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmkk+XH7fU0L1DKRseq22kv9GelW6Jb9db7UICymCgw+cTxGQcdHOPjvNdnHYBdeB
	 p81anMbgqAb43+mutwETxXUMFTxE4WYX9uTwGfeMfXXY5HRd2o/809HZ1UHSZI0/5Z
	 yhNIC62XM0a9jn9lRrXzTu1UJ1djpWLSdNMDSLHxB6eIKMilDIfw5+3WjOE/FOA9em
	 0tuIMIdqNbxaVVYYrUZbkGErpMKAWUk3Z+DNKHs4ETItr1D9YaQo2rGJEAmZfo/cAp
	 rkAnd8SKhe1Nas1D/4JVd7UNdciFYZr+W5arJemiWD+y9nIvPcYzirlWd5PUWmEPJT
	 rBPhOW0myTjKQ==
Date: Wed, 12 Aug 2026 22:00:19 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dpll: zl3073x: add ZL30643 chip support
Message-ID: <anzQ04ySyCbjQPD5@L30177.local>
References: <20260724-for-upstream-zl30643-v1-0-ea93ba4d85c8@free.fr>
 <20260724-for-upstream-zl30643-v1-2-ea93ba4d85c8@free.fr>
 <4CCA3CCC-C687-4658-8ACD-BC0CB3294A39@redhat.com>
 <amuE9yIaBsFSgRhL@L30177.local>
 <760d9664-14f6-4cf8-af55-699ea3021b47@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <760d9664-14f6-4cf8-af55-699ea3021b47@redhat.com>

Hi Ivan,

> Yes, minimal reference frequency for zl3064x is 1000Hz and also
> supported bandwidth range is different (not relevant now).
> 
> So, we need to
> - add new field into zl3073x_chip_info that will describe minimal input
>   reference frequency
> - add a check into zl3073x_pin_check_freq()
> 
> Let me know if you want to do it yourself or if I should do it (I would
> send it along with your two patches).

I'd prefer that you add it, please, cc me so I'll be review it.

Thanks for your help,
  Vincent
