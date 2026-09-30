Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2E31F984
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729278; cv=none; b=rdzN5u3FEyNXKZgIn9RKW5gxKrbw+owBh2L9yWOSZULaRZupySHBcZRRT6lDnWtK+1VVJVOAOsh42Lmla4rtd9WqrV/sX88N7sn/ZDwJfXHnRc819sFV71fH40xnQKI2/X1C87sD/JF79wA+xxCEUndk+EPWqqqFqJL18s3LN0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729278; c=relaxed/simple;
	bh=IkJ9vtM6s7ZyhaUSNWu4KEIRoo54ySib6eoHDno0ZzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtIG1OZNoSDe5JyR+7Dwmd93ynqRp/Ztetxhz3ltFiUSFfBkDytX0oO4dinybwI7yjnOibX7IUF7T8cLfCQUWX0i60V1MzSNkVikKKqgG9DGVOgdsZJmz2x9Qf21o6gItnV9o2WZ2zOc/nNn9b+0cAdT29s3MJMMSCq14V+uVN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=SN8deThB; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="SN8deThB"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8633a38df87so2003860b3a.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 17:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790729276; x=1791334076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=40g7gQiOI5yVws2P9bf3jH4EWpMijZlz7/Un3g1hMDI=;
        b=SN8deThBfTLAfxUrRXB8NfVFKSg9BKBgSG/I1r+g+TtwdY0D7V/IRkCTZX96sa+J0X
         8ZKeCS7kCi3JfcjJfBxvGMm9lsBKjHVEz50fZXJ/Q/6bzMOnpaApDANQ1Q/nLLlVBYr3
         D/M916tqwvnRiQwingSCKNlvUuhDCs88/oaIAudgv8ddcBzY0rzDIOwT0rdJzoaqBoq5
         Ho46T91/dZ4XJz9ghF+3sGEX21313eRIMwuPDDivStBzjtT/mQ9X3xjNvk2w1X8MJmxl
         NX9gQEZgjTgo0Qjdt430U9ArWSIISZkyvIQpmFlFj1kQRetxkvACFNI/g5viJEGUKNws
         /I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790729276; x=1791334076;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=40g7gQiOI5yVws2P9bf3jH4EWpMijZlz7/Un3g1hMDI=;
        b=LIcbULgEhZM6j5kvGwCUjQniUooCSymXJ5dS64Bj8+LSbO2znP+TBPhC0FISbNF/Bd
         dOoikaK97IDid+QgJM5siO2aeGd1j5wdJgPzkSyajXkgmqk8GIMYWzkX0tsE/LN3vsOC
         /oj2+vSrO5bd9WuOreuzHZEhnVMx8J++FiSf6WNJydVNQberCrQU82XwTAWb7UKYiwyZ
         /9QGQrRHEVssDh/atMlTXEro8Ml7Gg5dsONxjsQdjDgRIXDFHQ+aZYnpg4sIWRqvuMrf
         BNpT/At2F2nO59E4p1LaVLesUdVHQ55G6cMIudkC1miM2kdN6o7zZpVIH7LyJcNwAkEb
         1OqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxRQpqq+HXbKuJG56nBpo8rHsfoAS/31mfIphR75JIkhlr43OPAuuSdRbOT1NkBR8nSqhGBYI=@vger.kernel.org
X-Gm-Message-State: AFuF++nNoBooWeR/pd0YJ2/d+9Ke/ZWXzTEkkQ2nzmABDGxYzPaClabQ
	OpuyqlQG2xd13mTBUL5CjcQYWBDD1u3drW+41DG6RuHasVokY9HQKPGaExd0BefIGoU=
X-Gm-Gg: AYBFou3/yVjCRHUTiTSTUwOOM1BCsnfnKH9XESPVegEIIqMtiqu/0Ryx/fMwtPwYR9U
	fjkvyBlfm84FLvRHqb84EG1TDbDZLw8E+B1gxXR4xPQmIpzj7g4iQS2ZCV2Pj8HHixW14ovP7GC
	ueHY+OfaPUiqPpDObxSO37hF0FpuYSIulAGGZX4D5BkVpSL0PTtHx+L60WeIW2beVAlmC3TNCVz
	yfolJSi1ZB9pvQLLunjMJJnRXbqQntBhz9FHZdYP6S1Nz6pA9gy9O145cL74AGPQ3NpiIFsMVvR
	N0WxcRHjAKLpSesn+pMT050gM7IhBIDjJm4oWkOd/If5BIP43VTMMVtXJ9xK5kWdFMNX1WZDWWX
	qXSiQn/b0mN5X32hzjSht2f3JshK8UyOCEjarJV+ZvOk9+kXFKgrRJ8kpE37zB4faZZ2Dk1iAZ4
	gLBdAUCl8oyugvhfp/7OaJmqC34pidQhsW8O0hvIdQeqJs2hR1B4WF2hoHxYUZKQZHyVlcWKsQP
	pKT1RfIPDtT8dKOPUIcAIk=
X-Received: by 2002:a05:6a00:1906:b0:869:f065:f499 with SMTP id d2e1a72fcca58-886c3eb14a7mr659287b3a.25.1790729276326;
        Tue, 29 Sep 2026 17:47:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8868ba02d02sm560259b3a.21.2026.09.29.17.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 17:47:55 -0700 (PDT)
Date: Tue, 29 Sep 2026 17:47:54 -0700
From: Joe Damato <joe@dama.to>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, sln@onemain.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ixgbevf: fix xfrm_state reference leak in
 ixgbevf_ipsec_rx()
Message-ID: <arxcOtu89COHAncp@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Wentao Liang <vulab@iscas.ac.cn>, andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, sln@onemain.com,
	stable@vger.kernel.org
References: <20260917111418.2148632-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917111418.2148632-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 11:14:18AM +0000, Wentao Liang wrote:
> ixgbevf_ipsec_find_rx_state() returns the state with an extra reference,
> which is handed over to the secpath on the success path. When
> secpath_set() fails, the state has not been stored anywhere yet and the
> reference is dropped on the floor.
> 
> Release it before returning.
> 
> Fixes: 0062e7cc955e0 ("ixgbevf: add VF IPsec offload code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>
