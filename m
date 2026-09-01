Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B312B431A5C
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276915; cv=none; b=abGPs2jsceDfh6L3xL99IPeuS+4z3yV+r5Vov3uoPgqIAlYbcST8x2TaDvr1IMR3ZndKhZzafA3LRWQBIs5NnlACZJIFVUXmVrxkrd9XtUbwA1HL4KrxL9k5x0nWWiSQr6TArEyrBlxmBGShTV2S68uBF5PGXyHToRh31waiD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276915; c=relaxed/simple;
	bh=kdgQj/mUkyRR8HBLGn0DxLiyjpequvkCMjczfVTXcyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIFUAZFVdrINzlNro8G1cNA3CKt3HSGTgi7JEilXfoWzdLRE68XUnH5D7PtZch5v3dgrT0+yAV1zKwjyOJPXDi3XAe7fAA0z14+CqWIAWudVoyDOatA+zexEfvf3hWbXUC22pv6RoIE815K20GAbyhOZmVn0XBgMjQz5KhHf3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=klP96dwS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="klP96dwS"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso51957615ad.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788276913; x=1788881713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QmL927KZZiS/GQHjvKa5Xv6rRMC1cROJujnvo4Vr8Qs=;
        b=klP96dwS0uIPkrJjasBemYGuWusxkZAAyTZx6gAFr1a9dkqIUUUaLj4OBsLZItR4zq
         BqfyxeO2zJrP+Y/8WAJDVIz1m7PiwCGInklJVO6CE6kKX1Zu33bCXuUtFTTSvjKpgnI8
         rEjhIp7LCupkscSLLL+E/4yUv6hklfFu2SANSOXl+oa4qIRBOYvJxJ4RbTQYuLT84mtF
         mxhsxKPAJV72RDDoomuZmkJfCG3r+DHDQQDaasHJwSEfrCpZcO7qQyy/vBPn430DjtaG
         fYNgJiEcIlTc/YsuLgX6cDyExV+yciy1oE7T/1FMkSu2KhzYfsE5smoa4oS7xBTQSGcJ
         +GQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788276913; x=1788881713;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QmL927KZZiS/GQHjvKa5Xv6rRMC1cROJujnvo4Vr8Qs=;
        b=JgGUB+EXWFtkQuCDaGJ90C1zKM1bfdGMpPex63dEpMAg8Dpw5+NdAGb7xatWJO6MqG
         Jf3/aQbHFai8Fpf8PV2SUhhpSLfUaNWtds99v7H8JSDq2mDW4r9ZLaWER+FoO2tYO9La
         iJKlGbyIeAnH6KREn5zY9fwQAYppY74xv/vEoLKhBnY0H+bM3hCYO3RZJNK2Ea/VyAUM
         +/uJiBW6Yvz7M/g7H64PEYYVmOVizXZ2qeJP+E8zZvK83AMOEFWFsIswUtSGUGELZS64
         mER9AyCuZd9ky9Fcki+FUHDxIr48hDxtOFAfjMtz2G2x17mX6xRlCQsbvnFH19+WzESM
         MWbA==
X-Forwarded-Encrypted: i=1; AKwUvBxN1BOSkDlDAnyiAXkspf6YZfuDxgYc3CmYAxFC/lzaK/as42/Ey/9XT3R/B7A2brjymhJeXZk=@vger.kernel.org
X-Gm-Message-State: AFuF++kmx29PqNUOFZR/YZ1mC/PTwpBqxImbytrBc6kjdtHAO0AnVqMb
	SdZMUfUqi2j0M7gJX1fAXBslULnW12uLylKW0/zjGnOD1GAo+c/GBM539rsqQrMrYiBDqwYeBy7
	Yc4XEqEQ=
X-Gm-Gg: AYBFou2bhunkvriz9c9RaR0P/aqIzvNT132gPgA1Ajg49iHOacuQcMNQo6/DaG0rPvp
	u4DFCf5Dm9dYo+mnji6fu+nXjepZyuNx4yR8VsuL1BJ8fE59NouspxB2+L2wUcLp9xemQ54o7tc
	mjxMzjVGvb/Jd/mtX+TQ2w8Lu5FP8wR1gjCv7PyJRBOhQr7d0eqmGwoXClxf7MpiYAPxsmlehcJ
	Cnip5CHbmF3GTAXDrGQMJlV4dY6x67KMz7byl02KIniub2VUX1cuxcsPbFR3eVzjTXhAAiCri3b
	0d0J4qP+2XcHuJ9uZm1bOYo7+SnnqIO3ELUlFXb4j1yykkXreJQFuMBKSIceGEL+GCyGWNp97Rr
	1eBdSz5aTymettNZ/R0C9/MUkMjDf27Lx2LReFhyccCqJqHHMK/iReqgzb+Zqz2IZKT8V5/uwz3
	eMMGbQQUNHG9p6COebqlVfHyhrPYvBPJFK9oyqJPg5HQ==
X-Received: by 2002:a17:902:efd1:b0:2d6:f988:398f with SMTP id d9443c01a7336-2d74df00b5amr406227165ad.12.1788276912795;
        Tue, 01 Sep 2026 08:35:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:57::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd386eefsm929635ad.28.2026.09.01.08.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:35:12 -0700 (PDT)
Date: Tue, 1 Sep 2026 08:35:11 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, willemb@google.com, petrm@nvidia.com,
	linux-kselftest@vger.kernel.org, noren@nvidia.com
Subject: Re: [PATCH net-next 3/3] selftests: drv-net: bump the timeout to
 15min
Message-ID: <apbwrx8c3ZMdHI9l@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	willemb@google.com, petrm@nvidia.com,
	linux-kselftest@vger.kernel.org, noren@nvidia.com
References: <20260831163734.1121891-1-kuba@kernel.org>
 <20260831163734.1121891-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831163734.1121891-4-kuba@kernel.org>

On Mon, Aug 31, 2026 at 09:37:34AM -0700, Jakub Kicinski wrote:
> The XDP test takes 9m30s on the slowest NIC with debug kernel.
> Let's give ourselves a 50% margin and set the timeout to 15min.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: noren@nvidia.com
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/settings | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>
