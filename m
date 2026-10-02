Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042C93D9020
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790973612; cv=none; b=krjdMO6N2LHVlxT+U2Xfuu0bjiOTKzMApaaTJgW5UrU0WX+xFqsBtbklmqwGL16q1v/UciYrQx8vnHTdbNJ4Gw5XFj+Ck8zlb1n8BGfDMRcAlN1vppYhUemPRLsa70ATlZ5QNS1tgphpERL4WwQmP+ySiEYc52IAU00dLZKDZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790973612; c=relaxed/simple;
	bh=NavU9oD7boZye7A4i5QSk8+AfXIDy/22rXB6+09Jnyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onBW8RghJKQg4LDoschg5qe9J7KXAAurMrNyv9u5k8irwK/IeKDLmubJpvtava3E9WKz49agitQuZsW5yGpJwGQU9E/6Om1cd64v8YsDnF43oX/E5cbOROJK59YYXoRWX2tWO6TiXY8ciRrYkFQ7ezIbzkffrhC0iGZhjAIwV8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=rRyFqmQh; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="rRyFqmQh"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so296052a91.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 13:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790973604; x=1791578404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GBk5NF+csDO854jJyGJ+AcXtXH9ziwL4Hlvi0Ps7aIY=;
        b=rRyFqmQhlt+bfWV9H75Tc2409iwlcAaJ6OSqzrChT59BS+iUl0zlanQ6S/A6Wc9FJ0
         1XAdalZEY5tAtdkzoU3ZkcPiqmswNhInbgNGpK445GX9Ipf9L0clH1j0xq4tMzVdhmfm
         XuReTN264z5U/bkXHDc0+oprioB/X69gI2HiOX8exNAndWXaiH5201ycwjw5fRBp0ndq
         QL0jRUGMuxSSc5oWiEsBYcsaCLAYafp/VowTDw4L4P+Fz4UjnoIJCDiYZV1FixjbUVYn
         C9gqzo03rXPfYJFC5o1cDSv7HNnZQ6Pxclu7MiapaYWWzNq0aDG4+DMpx+RT3VDXsaWb
         5k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790973604; x=1791578404;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GBk5NF+csDO854jJyGJ+AcXtXH9ziwL4Hlvi0Ps7aIY=;
        b=A8Budsuu22i3bLZIFQyjx/Ux3vUr9rQphri3/MSerJCeEiF57GUvsaBuISPo+CkPmK
         OeWNEzvkGcQmCh70yDnvHkLbMlCZB2Hprr8YIVtstsMxGR+PTvUfx+doW434jBucQG8P
         G/UbJsh8RrPxDcldAZnsf45/nYllop1SNle/swDevm5VK6Xqt9NgkJKKeHuoUFfE7P5h
         uA9vNNUWwZYlZ58VEYQFDZtR/x3T6M/0o9rkRdFA1hLqGwZbseEqkwuyqaYWsJct+pHD
         Lb/l9vIJXmBOfEutnpusqf3IZW/ztwYBYBj/qqNsBHOhAlHvuQVlWWAyOICq75ulioN+
         VnaA==
X-Forwarded-Encrypted: i=1; AKwUvBw8jALLS09cCqR2iYjICTzIOXOKtP2wyzK8HvFNgcMFWVdM6DM3xi34Jc/cS6Sj2Y0JVMzn9JE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDdVCo9vm7NzAGtMv8e1s4RKKiW2dYTXRu77IOfZHbQjwQMaXW
	oqKolTbUch6cuzmOM0F6z5aLGNIuNIC3l8WEKlnHzcq+FH3qQSxB2N1JbsAj2TBkeQ0=
X-Gm-Gg: AYBFou3kl3zIsmst6tLOP2M5wF+WAt+PcXcFPLtZC1R3DabeWAjgrDMfNqRrXpwBeyE
	wvsOMTDl+c+9KZbOXXGHUL3PiHVdEH/ez4SlbBRZjsHceMdPW+UV9Td+RsCfv9F8Z3mS/BDgUYP
	ImsIIRZhqSgaNdQO08TsuN/2Bk1zpjfRTXtdX+7OkEX3mlpW2pXcyJKf5Kb1qANtd4zyZ2vhn1q
	gbgDu8EnzSJt8HW5iYUmBnFYVU8HBX8BpnJOT7NSyEx/0nPhzhmXsILkulbj5DDpg3EixjnuOCe
	l7VsXkaXnl4aabV2iGiOcnVRychpAIPZT+Gx2lMdFGfjJYgjOgBibT+5LFgwcruwBNNCTnRxmZc
	ps8cuMMfDpliUk6Rghl9P5g3s4rDazbqXmAteBBpm+yXT1y0pJC1Wq+WMmkRCNLHAPc4wR2lb6E
	nB9eqCm1B5qjNQ91fNzliK42tOJHoX6ebHMhOkFJ8Z3csu3Q3uZndCmyK9rvp1X8UNq1w6r2Rwk
	cdpD8MjX7s4Ig==
X-Received: by 2002:a17:90b:2f45:b0:3a4:f146:5440 with SMTP id 98e67ed59e1d1-3a6ce98e12emr4072581a91.60.1790973604642;
        Fri, 02 Oct 2026 13:40:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:57::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd135d8asm2467823a91.3.2026.10.02.13.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:40:04 -0700 (PDT)
Date: Fri, 2 Oct 2026 13:40:03 -0700
From: Joe Damato <joe@dama.to>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 4/5] eea: unify return code variable name
Message-ID: <asAWox4qWre236ie@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20261002100035.863275-1-andriy.shevchenko@linux.intel.com>
 <20261002100035.863275-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002100035.863275-5-andriy.shevchenko@linux.intel.com>

On Fri, Oct 02, 2026 at 11:59:22AM +0200, Andy Shevchenko wrote:
> In one case 'rc' is used in the other 'ret', the most use 'err'.
> Make the latter use the former, id est 'err'.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/ethernet/alibaba/eea/eea_adminq.c | 34 +++++++++----------
>  1 file changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
