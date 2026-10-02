Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3FD348453
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790973228; cv=none; b=WKi7fUHADvANy+jaznNM14tLSD4qZr0Pkfb45aKlKrE5N3KACbN85eya8Ixwa+gxNzX/1/GX9ilV0lsfRr7xSvOKTC9gkxlRwiKZuVtyFes62ECX5wZRvJMV/Eh46km+2zs1jJSV4yehdJZETjHzfFrvlz4gTrabf/9NS5iZ6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790973228; c=relaxed/simple;
	bh=u034o5ljXz5CJToLKeVCwXtqDGV74CDcIcp4GPXFAwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4LXXroie6JFSxF+gtN3YJZTiYMeRIimMsXNUbYcQTDOc16hMVTBlaM6RTpNAW4U2R2ULt6fO1fX6Y0Jl6X16aISgilbAvhYX3WZ4KmkxN3hAHt6tgdifPr+URKaPHraeU7Aa7kEqlcyaeMWhKdq+Ni6lBE5I4EY+xwEXa1RZlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=rBydKLru; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="rBydKLru"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0d2c37b0bso200186a91.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 13:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790973226; x=1791578026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H0lo09yz30+6G0Y3ATt3g2hzJILuJM31qXCKjPdHWfs=;
        b=rBydKLrunRF09vY1woEoY9pRijncB4yEl2/h0tQxaueqmhOQNkwTI37WoiY3mm5q1j
         KAJPvnNoWX96HONTpqoLOKqO9C5fSiHRD2Q0YjLbFaROZStMgrl36+mn+I5uBS4GBdhh
         zFXWtDQER+ml7vuBMjZt8dCueqKiGgdKEfOQiPVdRUD42tbdhNMey7M0EVJ6ikhvM0Pu
         aYi6sgaayFirxjB/tIUp/arwcZQU3Xn1b73Yy2J2uOUOI2f8XxjhHJR19gRjPF2yMFJ/
         jtBnTYCDouHO6E3oFEHQd3exTmA2vw1T6XNa+JITBxN3aqdGqyH1LRu1n6JkkaM494sX
         Y5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790973226; x=1791578026;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H0lo09yz30+6G0Y3ATt3g2hzJILuJM31qXCKjPdHWfs=;
        b=EVTgqpjP69+9169NMxsy96aoIzJAiFQJZTboHsWN1jRazqYCLWZwEv+r+G1RoE2RGe
         RDy7lk7kNGCGbGY6CR1CyJNPLjJNkUaqqC0AH2kzZ6SIAhCrejdKXwenv8xcbSE6cI8U
         9vNATYaInyQ50GiPht2NA80aqQqPo9ZHk1B3HrLz4c2gQ5JhAJkZFkeY+OmbaoQqXXkD
         01/BaXa/wGqKJPL0PMKqJs2k+b8GTphwKbkpcUdtKIkAX4gkgHw3VJOjMmN7CJUDwyl/
         x1FJogmQIuXZZST6pkzBBWtfgyAhVgrUiW/N/ZWaD7PDS0kqHtaIywA2Apsk2dwsMkv0
         +QwA==
X-Forwarded-Encrypted: i=1; AKwUvBzTLnDdKSvtc+n6Qltuoxu4wT8/i+MFdkcm5LQdupf86Fkh6kUYaqPRtXRUh0xLvf/JEbFTdw8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMHKv3ZqoPZo4yicnIF4mx4i8xpsYpn2fAfDCZkZG7Tn+A6HnD
	F+oyTaW22YOhoJkkr/sqR5Smpyy9welIXOeuZfYqE4AbzaOYCufw1nWi45YBPBacho0=
X-Gm-Gg: AYBFou0CmPfa2vir6Yx2RwFQDttZNKJjFwzFjDh0b7ja1gwRs9n/CK72oL68OzwNmAM
	uggluKgNkUtqcNHhaF4simxNK2piFucDFyMfdn6rk4/niuOewzDzpDmS/Dut1TzjxLdZYy7CeAe
	QMKPbdrmb34fClZwRukATbb4memfOmJ96zplsYknSZBeKFUb+7bakqFnastJUHmZcvLPo9saghy
	iYnV9S1VrjN0PPv3AHlkK/ajtWU9espgFSdb5AZArAWNA3l079L9rzSvtbBu2msMEvSJNZlu+LJ
	xJbVDxjGx6u8SSsMHbm7a4zhUdoo1TeHgOYmzxZzPP4gXOT6ifkGBsosc1yCgD+M9ufR5OANwO6
	vuEBQ8tEQQ8VdlmeR53udYAQ/s3z1L8IpMgBxHQV0MXfcApHb0jj/pPKhibAmKIldJJl7NH25zk
	ZtmiFw3/SXPmE0CD2AzLmm2GurYZHQfSJU8oc1yiGlSijsOyGb/Ja7a4dn6osYyDQ7JaypuV+O9
	e+yHufuTlYw
X-Received: by 2002:a17:90b:2648:b0:3a7:8350:3f7d with SMTP id 98e67ed59e1d1-3a7835042d5mr285148a91.34.1790973225601;
        Fri, 02 Oct 2026 13:33:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f47cb357sm10111101a91.17.2026.10.02.13.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:33:44 -0700 (PDT)
Date: Fri, 2 Oct 2026 13:33:44 -0700
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
Subject: Re: [PATCH net-next v2 2/5] eea: Remove unneeded assignment
Message-ID: <asAVKJ7YgvVMQSzV@devvm20253.cco0.facebook.com>
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
 <20261002100035.863275-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002100035.863275-3-andriy.shevchenko@linux.intel.com>

On Fri, Oct 02, 2026 at 11:59:20AM +0200, Andy Shevchenko wrote:
> The initial err is not used anywhere, drop the unneeded assignment.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/ethernet/alibaba/eea/eea_adminq.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
