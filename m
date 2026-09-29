Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB02A47141C
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718154; cv=none; b=qnSIMavNJP0WF4+Dgguc965ebcTeIPskWUQBRo4tWiKWGw47XbqK8R+bW2sXD0aB1pqytXNozFYXwVh7VGQiXhCinAPMi6bkKsMCiHClsh2d9+Xl+KUfiXwrNRSXC8zRI/6zT2SFH1i7y+fjSo6zEyz5Zu152WN/vIUMXttcuDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718154; c=relaxed/simple;
	bh=vAh0olsRx5ABWuvRNHU1s7TXHPVpxAOLHBxwtRzERqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcnaAXemj0YMbKPzaP8z/Ocb2PPBNAMJ0NH6danNsFQKU+09T8iy1ZcYCXZmYXALci85v2k3Xu/gCoqhFnxo7z7Kx2qPI4pCK4Y8KCVtg0tOuKl2kQ26crBATaqPXYYfoF4wH6/o2Ge7PP0xHIzZKf+g63Tt9aTSPFNJpKU9R7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=gvjhd4xc; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="gvjhd4xc"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2d747f05ffcso22281295ad.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790718149; x=1791322949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6oioSubLVdAHgriYty5R95qbHjT0ztj+ARCI8yRsl/I=;
        b=gvjhd4xcX7qrIGeva7UV9QwYHFqt6DsXJkhy5vepGQ9fqwSD/O0YbjGovlutemqdT7
         AYNG3JdOCzDPhgJPJCFmGrzSpkpFIzykDL6yk+3ySJrBRKd67MR+iZjWwhvgfYdD3EYY
         0XuW4yKAqMSpbqMjUmxXzAnDCO7aVw50HTbpS4sAdKlnwDedPxIdbjYS8E84TDxRXO+R
         pzuEPlmkEU4hvqddVFizKMtPNnMEgaWjF6FNvmrDyyAdU0LnEqXuXJi/Vtj+xOyYkIrZ
         dEyY8UAquwZvrJ42pPq8ifvnXHHQ7Pc/4EJuaFC35TBjUPDRxW3dXOtP7k9bj7YbU59B
         iVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790718149; x=1791322949;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6oioSubLVdAHgriYty5R95qbHjT0ztj+ARCI8yRsl/I=;
        b=piZlS8wjGpU/Hat7m+mCQhmgHiGv6YIzhpo4kDFMrdPc2vzh5UMp+GFQFBKPOy9aas
         RLNKKX1zIGm1YT+Nd6ImhTYV0pJ1BA+Z6+gl8o7hVw9O7jGSuEzIjhDQEaLtfwCtqi5u
         PsTsIWk9Y9hH9/mVNJjF/ci6Lw9+dc7JV03hmjwIRKpATxwTzlFb+XeXKuBGnEHNnjuc
         XTH1ILACUZiX9R62+o6cxOE8TNo2Q2IlEl1+twKNMXXJpi3W8VCJqcD+Qx4pz5WkrY2M
         iIX9wjsKsOqrbYn43cSEPqgNxoKHkwoiwEaxlCR0HsZjSgZv6KS7BiI+Qm+QnHwYivP2
         9I1g==
X-Forwarded-Encrypted: i=1; AKwUvBw5VvhkSA6/mkdrBjoqqJNktzp7/wY9LdsS9Us/cRRpy1IZPVHLbTIt3bUil/t5P9T3GnDTvPc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlh0B6zMTnYqbq2DWaj6D74BzuJ/WB5A/1VNi2ccEEt7WbSrrO
	sK5x+r8mjI3LJ1jZOXrZ59HXKOoOly4dyfsXE8qPEK90qpGe3E2UAZqmw/ibzQ0jSxs=
X-Gm-Gg: AYBFou2zv2GgvqnBLo0bjPp6MPEqCWaxWwy7ZGKum/gcL5sF7+/i4uEweCq+q/T0yBF
	VDdQFU5L3V8vQC/AIpPyjyPPX6WDcqLkpd9hOVjnQHgZVIH4BYZNXfpF5ayPO/vU4RD2fSmpg+r
	lCJUB+ZM4Jt4xOcqL4/aR2mwbbqZcCykEo42cOw4VwKY8oqvpXvqZLR3veKT2mlTF8lfTs8mgaD
	TYwxcHep3yQ81wfDuehi6Eigc+53r9kV3OvCcECers4xiq9KlrOTC67u1HsBpvGNXzKZHUYPSts
	9rkWcdqH7dyio31ADgUDYq6TMC0Ec4lo+qK0FMXjn5n+Ykkezq+lzbpQL0siNLES6qs+2JYhMLM
	aCB2gu628p5kyv7fataSw7raw/V98n2y9jloLrhUGoyuGLH2ausbIHpZTE4kKKmsdzaX9Y4jss4
	H0mdoMIWmdCapGbI3x+WMhCGC6oSm27tx9CJ9IG5QJvEWYYfuCu7HGKaM4u27oGnDxs8I5kwkuO
	0DjIKSv3YQ7
X-Received: by 2002:a17:903:8c3:b0:2df:9d04:403b with SMTP id d9443c01a7336-2e2de5447d3mr2955125ad.32.1790718148606;
        Tue, 29 Sep 2026 14:42:28 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2dda537f7sm1327195ad.47.2026.09.29.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 14:42:28 -0700 (PDT)
Date: Tue, 29 Sep 2026 14:42:27 -0700
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
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net-next] sfc: fix kernel-doc description for
 efx_ptp_timeset
Message-ID: <arwww1y7uMnBmh2B@devvm20253.cco0.facebook.com>
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
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev
References: <20260929094211.48125-1-ayush37735@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929094211.48125-1-ayush37735@gmail.com>

On Tue, Sep 29, 2026 at 03:12:11PM +0530, Ayush Yaduvanshi wrote:
> Remove excess @valid struct member description from
> 
> efx_ptp_timeset.
> 
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
> ---
>  drivers/net/ethernet/sfc/ptp.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Joe Damato <joe@dama.to>
