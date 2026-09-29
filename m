Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3014718DD
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718271; cv=none; b=Em4bz4FFPAz98PBUK++qgO1fp1cHWuZvrVoFnIDjk4sZZWU1gN3SgDQiqlKNhUAwVN0S89dgcBk/Grvv8BckG9YrfFsGmh6+A/XmlHrHRXE/cQ5fis39LzEtLXZb6zbcPa5OHdRdfwIcUpNJ029fpd/i0P3UNWBKSAufW8VSmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718271; c=relaxed/simple;
	bh=sSS5ujNqwDF2ukOfHcgyrFNo6NxMTwMpa3kXviLIz/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWddSHnPlD02NxCS9oaVp4aDp6JPzvDVDDqtS/UziEFhb8r95uGG5vm8pb2cq2sgfYI1pfdrzkhBOOwmP1iT3WhNYSjwxPsnzBMgkI9ZShzKiXdX5PU88APBIBuuaMyixmihKEosWcrET20DaA/NhcdzSlNq1hUmvdvQnvvxbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=H+lzIbEH; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="H+lzIbEH"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24afso2439398a91.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 14:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790718257; x=1791323057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9q+E3Xh65cY9+ofmYDsNL60Gz/7NdFCbD28qz8ceGUE=;
        b=H+lzIbEH0CsH7v/l30swJkvpVn3XHKoSAo9HoKhEy2SEc7JlGBbqcFXxn7BUe5Ba+G
         p2+UxujFXJCKVImMUOocgIYGEI2VoeEyY24BVzm2RM2xrqacJU1xn1mPyFv1uogeMLKy
         UuItenqrVT3P2Yp8V2pLJvFfIxv9hTBeipU2Px8M11xBDIJzEK/dQCzQpUr1HMvj7sjW
         ZNRYHZPcpMthHDYaIylnS75EspGe7iIK6CCTiN1jyaBOroeAYJNAKJPXarNHF2GudH4f
         06+jJiOfvOP1yaxsEwqx1vUDRlM1cgEwhwzqfVGwRPZjXw814N954rjBAKVLL0F0XMhR
         Gt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790718257; x=1791323057;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9q+E3Xh65cY9+ofmYDsNL60Gz/7NdFCbD28qz8ceGUE=;
        b=0EO1N+kItk4Pj3Xa/jMKm0oBwYCLIjxfhc0I0YyG0yD60kuIkJkUMnaJOf+huHsp3D
         Ewu7Ist/Swo40axLLPU0d4PMinTyOj4tCMVJ+La1evgycWjH3gNdGOQvDJLaQKOzOnya
         ro3Zplr/lXFhXwB5xt9tFlnYAl08SI1d9uoqfLhYJw0A30RVMcodc0dbIb92NMJrappd
         l6PHaDISujT5QAJdbppahKXN4xUzHJi88fGa5WUXPXgfKZL5zoJ6U2z2Y7StvQ/7+bsP
         IH67umd/QcU74fqVjHxYNboFqECV081xpIgwzA7n0E1kxpDVd84jcXKhEn91KOurkrss
         w/qg==
X-Forwarded-Encrypted: i=1; AKwUvBzy+j2aUv7TH3Mw0LBXtp9cIdjoi396JEIdEYhyTv/9Rq4q2d/cX0YUmnFV3qgWcnyuhMLhYgM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIO2xG/UogIEiRH//1N2kRvMym5+9EcWd1hATHIPJ71fiax2WjL
	7TvpQXvpcYB6+Bi78m9aDt8Sj+mgZwtbmbqRjA3ZcV2LigahEgIrmOTV/fXRQUQDBUo=
X-Gm-Gg: AYBFou3yOa6LQC6d/hssOm50SCLnB0mKZA3WJLKrqWiLadbKhuXuXB+TIt+a7XdgoZY
	dtOy24OFtEOatxc9e87TmD/KVlA5DhMmVHD2Va6neW+4w7vDROJ07zErg4yo/7i/bXu3HZysdiv
	vqHDZHuS3mu9x5hV9Ru521oKcCElCeRcrua3+kXDb49RPY7lnX9+U8axEGZ9WS/JtZVwL3vt1yu
	2rZ0FdoFOTMF/MhPU8XlAWEam6d0aJgwfFzlgMffpoA+6dp70TbUrLZ/zTkkFNYEAGsqkj4C52F
	s2fMsMmL/uIt+KFhUNRzv0oBCcwbztuCewcA3LaubI3XoboklCBfEpwUYnayiT+YZOMwuPts+D7
	5QLwg7Ekvk6oPS3eRTSPiaqgUYKCCnhPO6SKoEPJ8mmlt8+AyFNRQqz3dIrL++/VDHGrE+MaBIp
	CzxBAYBppbup50NYx74fUr+36F8WbfklqGtfSSluVud6fxJIcSQ8amydl229wlh5MaGHz0qGkPW
	qohYK7zPvdk8VJ/jHApu7n2
X-Received: by 2002:a17:90b:5109:b0:3a4:b8f3:8192 with SMTP id 98e67ed59e1d1-3a4bfeddacemr290081a91.52.1790718257035;
        Tue, 29 Sep 2026 14:44:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4c6142209sm74299a91.0.2026.09.29.14.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 14:44:15 -0700 (PDT)
Date: Tue, 29 Sep 2026 14:44:14 -0700
From: Joe Damato <joe@dama.to>
To: Ayush Yaduvanshi <ayush37735@gmail.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net-next] sfc: siena: fix kernel-doc description for
 efx_ptp_timeset
Message-ID: <arwxLnscbs05f84x@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Ayush Yaduvanshi <ayush37735@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linux.dev
References: <20260929100625.50380-1-ayush37735@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929100625.50380-1-ayush37735@gmail.com>

On Tue, Sep 29, 2026 at 03:36:24PM +0530, Ayush Yaduvanshi wrote:
> Remove excess @valid struct member description from
> 
> efx_ptp_timeset.
> 
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
> ---
>  drivers/net/ethernet/sfc/siena/ptp.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Joe Damato <joe@dama.to>
