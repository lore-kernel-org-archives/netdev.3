Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B12F224D6
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782954052; cv=none; b=X37R2po/aPgYOA7Lp2BSNaGg65hIp7jKAMGFW0yaCLjcMlBXT2Bp9paMK3LMcuZTXsEYZlBt60+GmuRu3AKgTxMFBI4Ai/fSKjyXGxLr04+aVddEypRYKzTPLMP3q5vEiq6dn08NRk+ehRJ6ihyZ02ya8sC7dwZgrk+NUauBv6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782954052; c=relaxed/simple;
	bh=JSdxwTjGuLjPKD2MFftoxTD6yZmcAVuXoW0ZxbMbcAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lsg4QZxuNNXVHUOhnLq6uWaB/uNds+kRj8bTNsqwOW9hswE7DeHhUdryawJVa6aGA4D8zrpzZShtNuelfg3pzUWHHooIRm95fC2t+F60fAtPsRRSWXSZgMtU89OiWAn9UGJo1QEE9Pbrkj4fuoeqyWHmMp8HvoTCiHtaPrCPX30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=Yx6XpBeI; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="Yx6XpBeI"
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=Yx6XpBeI;
	dkim-atps=neutral
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 3CDE3406
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:00:44 +0900 (JST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso1313455a12.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 18:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1782954043; x=1783558843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYVIvz2xiwDyxGktXu2b/BOw3jOsNJ0bfYAQd0mQ/PY=;
        b=Yx6XpBeIQeCInVuGNYy37XpP0BGaNv2NqGWOPrSSjdJAw3mVBpLB18fP/Yhucho2g4
         x64EIRYjSZtsWRJuOmI7XXt7yQJNy3mlZkoGleMOVHsiD/1Qt9DjKxKnCy9f9VUjr6em
         pJZBVcZpgwO1h+R37a0VzqZj0jj/2stUTIkbOq1WhcDQbkKBRKnYfNzBylVcyGz3R28n
         7xvs3oMDiXlc40qlfkkyEc7GnyFTdC+INgOZUEihWewngGpQF4RrMqWR/ojuqpr6Qwa6
         IiaPiC34IIx3cE5l4OSCxA6sLhN55ooe9MwAsE3dlgE1F0iQNpEKvmZLYJdFL4Elfppt
         cNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782954043; x=1783558843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYVIvz2xiwDyxGktXu2b/BOw3jOsNJ0bfYAQd0mQ/PY=;
        b=b6uhyATc9oAJgzqIJU2NhCJJ39PBz4GaOF2wEQD0h5L8feWPtDPJ5ifyrDkJqrTVHu
         e64+sy/a0gB/Jb+fVinoeOUZ8+BWeAGiGDX37+L5QySB46lmfE6DhOv8sbxfJsEMdrU1
         gzVppkWTWxKVKF41xdaqTz4msGUKdeh4/UnVudTMXq1bfufZeHC9hFNOZYqlcx6piXQd
         BvAvWdSD5w1vWL+ufU9U+3QNpb+qz16TKq89WtG7onZrMCcTcw+QCXDwi+cow5bnzHnP
         vHDnQm1iOyRuE+e7PEJWTh0LS3xkoPbuaXokJSLc8kpJbfVFjFE7oMMMZX4FeHOJGFbt
         8VaA==
X-Forwarded-Encrypted: i=1; AHgh+RouuPziLpqHoChN4KwaogYb1NldWWqQFLVSTLBmJ1r+y99uvqwBvv7m+tVuP2yMv55AVuWTAoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV3l+RMEZ0nDzGAdfB1JQpD8iE/KBK8QSy3hJvfh9zzlFZObmb
	3rbIyDqgx1dClCocJzRvvovFRfjpnV1tULx6hZP4kD9JrteCiHI/8Qd9IxjL2bkBxIj06FPrtE2
	HVABKJ2e9HJb+NvPSrqON+PM5WWVUnPW7GUlTC5KXjV0ySoE1qUv+ePJyaIs=
X-Gm-Gg: AfdE7cnJVZHPGQKLHm+h6lzLqJk1YJn27CchrP+w+3chPtEHurABrxgDam0/o6KEXRF
	/Osk8Ujc1tXUxMBnH5lOpIakJ8xNk35zeUh9tIJtC1Mnm2wgOAY/zGjSx7DZxfBoWgO50nIKEuo
	3vyw/zhPb2UlvVAcNezY7lu0b0ekDJRvnJMC/O4ZM0LceMKB1ukg1tuvE/bApVlnbhvNt3v84ya
	vg8X0c7/rmEV2NI/E60Ox0cNT0GozY4wYB9rPAZfIHdLOqAkVNqzw0Lw6czRcL538ldT1bFNKJm
	/yscGgTamoqRm6tUbHlJXuZ6+CmDIniRUOXOptxTaSEzk0xNELqDI7KtHpzphAjK2HK21dNqhBt
	anApNTPEzbj/dcmWC2cEP6aC7PH407/RRWdFJwFRVfgF/c52RdNdYQR4cDhE=
X-Received: by 2002:a17:90b:17c2:b0:36d:689a:cb27 with SMTP id 98e67ed59e1d1-380aa22b082mr3768071a91.24.1782954043100;
        Wed, 01 Jul 2026 18:00:43 -0700 (PDT)
X-Received: by 2002:a17:90b:17c2:b0:36d:689a:cb27 with SMTP id 98e67ed59e1d1-380aa22b082mr3768041a91.24.1782954042395;
        Wed, 01 Jul 2026 18:00:42 -0700 (PDT)
Received: from localhost (sodcd-04p2-40.ppp11.odn.ad.jp. [203.139.65.40])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-380e16057d0sm86255a91.8.2026.07.01.18.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 18:00:41 -0700 (PDT)
Date: Thu, 2 Jul 2026 10:00:30 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Keenan Dong <keenanat2000@gmail.com>,
	Han Guidong <2045gemini@gmail.com>,
	Zhang Cen <rollkingzzc@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH 5.10.y] net/sched: fix pedit partial COW leading to page
 cache corruption
Message-ID: <akW4LleEw9axSYaB@atmark-techno.com>
References: <20260630-cve-2026-46331-v1-2-c1986f356f26@atmark-techno.com>
 <stable-reply-pedit-cow-510-20260701193800@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <stable-reply-pedit-cow-510-20260701193800@kernel.org>

Sasha Levin wrote on Wed, Jul 01, 2026 at 08:38:34PM -0400:
> > [Dominique: plenty of context conflict but the code itself could still
> > mostly be used]
> 
> Thanks! However, the same upstream fix (899ee91156e5) is already queued for
> 5.10.y via Wentao Guan's backport, which brings in the act_pedit
> RCU/percpu-stats prerequisites first and then applies the fix nearly
> verbatim.

Oh, thanks!
Sorry for the noise, I'll remember to check next time.

-- 
Dominique
