Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04694E3254
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790723615; cv=none; b=VoMP0L/xClqNwvoTlLeeuxLS0I0lF6snUamir85EsMtb6lWX1Y27ve+1WXgAx8903XfY5AXCKAsVKr1V/O31tEFDwC4BnuSySZB4L+nN6nGDmS0V1uKbxHWPHXSYDxeIqQQwWOocQdaVoC+jW8LHvcr7bSztVJQmFsc9OcDdNHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790723615; c=relaxed/simple;
	bh=XIEY32W/6MFskFcdYDmnQYcCJnPcJ5eAtl20vIeGctA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8BzuZWc3rxdX8NX7GVIGuPWEIsiOAluNxTRmPHGt16tdR2XHR47JY7sLgWZWxOoCQA9JQf4vISu8X91qL9z/w/z5oqLfeOC2S5Xdv785SLm7VuX5/pF9hMsMITKAUCsitmvzc2eWChWOh4QzM+HDEv1QGzWTRqz54262EeDg9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=SQpH1NPY; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="SQpH1NPY"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a48e359e0fso1195464a91.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 16:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790723612; x=1791328412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iu2FY06cIBJ7op43/g8hAlSSeLFMSuwtqMFeIARMq1U=;
        b=SQpH1NPY96fV9pPARaHYxSDrLWtuDAlYYQmDR6A5+ZOwU81NlkaD2C0qNsAXAFtMJR
         RJ+KoV39agJRP3wHJDawjS++sCg+AQtKewV3RmBFMJrMK7UoI6tEH6sJsiBMO/dw/L9v
         Lc+cSlFgW+Gq3Nxhm8dwYRdcco8OCkmolbuPF4sFoy3EfRaaZDPkO3iJEJ5HTT1DrRQZ
         iGplC1y9puO2cNY4k3/Xyn0vGAa1OSXsW4ulcuJnE8ReBs+EhmI6iKOoj/z50xJA1E6x
         9br6/aOBtU7hWDc6XEItEfrHKrp7vPGJFoysfwyC8KhNkU/T6P62V3RtNGniGIupQKSH
         vH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790723612; x=1791328412;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Iu2FY06cIBJ7op43/g8hAlSSeLFMSuwtqMFeIARMq1U=;
        b=bGcrX/snrVKlv63o0nka5hInT8Pucbu7UdC+LROmhWbwJx17CvVRoEQA8+NNmWXh+p
         AJj5/2+NSwTmKl51Tsk8Nb6Eg5spgFBGW6Iky2DtgZjo7xQtU3naV47TsLKR+430FUyL
         yum98JIAekKuZZHNBb+ekqV83CZP6m/4klQGIKTqZXLFwbUiThJv7nPttJU9BW0GJQCX
         /G+SzMLNhXJYWYfIKUBsj12geAOn4RMTxqUHbGlqgYtlPYiP+fRspI6fhb1CPZJhOHpk
         8zDx1+clJRH+jhiK/Z4xQaSj4l7ImNdgxJlyUm8amdGegUJZfVJiI7hUC9aTpN72SQGT
         Tvow==
X-Forwarded-Encrypted: i=1; AKwUvBwAg3WnBRwM/xNr+8GstBs7766vYaa/eOOTjxkuryrkxA2c0ELMKzpavo3ldu0r9SFzT0m5qDw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQ8K/yWE0ljt7bT2gejS3US2jxQ3gvdKekfZpZOq4q17svCWnB
	DSrgNdYF52anr11qlQ0JXAyAq7ZtO5BMXQ8YHiTgJhKdsCxMdNl18oZsMJqOfno8KSY=
X-Gm-Gg: AYBFou2I4uZq3yB6DC8+l6r8WhGFspeGUXXIzmnULsHw98rCGUf7Gqxb2wmLdIk9gkg
	ZKBmS+lizurmfkXjkuDKYeHYZ6slCq7TgN4ozp1ok4jHsaV6eztATI3EakR5AS2+FCj24aHqf7o
	QZUYKg7VdUYKZVHVe6u9UczLpwfqxKim7FiOOxml8enpDpNDutNmfaHupZWKHtlA68q6IBVr0EY
	nmzJk1xnUjG/MXqqiYQ4pG7F24KE9Xkj/wM83VC+tKBDiwZ2QR0sQHP3AKLPhY4UU8X/uE4JbHE
	kXGTjL/V5skMYckyK3B8iZVOvwk7ra9sPiuCTIV2janOz/J3xRi+uvJgYoM5NTTrj1H2PyZ4QM2
	s3Wbmj+EnGm587CxpDSxIsOYQ4+SuIU2AEu2nktsx7I7j7Z9LMHfKjzYWgCoNgvfg+pcAxedY4e
	gQSLm9akcdM/0GjWuzzLnQ4RreQQQnKxWJIL/FkbOgN/VmsihjoP3a4MkO6DEbx45XwhlFiWivA
	gBHxJBgD45i
X-Received: by 2002:a17:90b:6cd:b0:3a4:a3e8:22ff with SMTP id 98e67ed59e1d1-3a4bfd9ec43mr734665a91.19.1790723604565;
        Tue, 29 Sep 2026 16:13:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ca3f3d67sm152927a91.8.2026.09.29.16.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:13:23 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:13:23 -0700
From: Joe Damato <joe@dama.to>
To: Filip Balluch <fballuch@redhat.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000e: rename init/exit module functions to avoid
 confusion with e1000
Message-ID: <arxGE+eYEmkxNQ61@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Filip Balluch <fballuch@redhat.com>, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260915122639.64936-1-fballuch@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915122639.64936-1-fballuch@redhat.com>

On Tue, Sep 15, 2026 at 02:26:38PM +0200, Filip Balluch wrote:
> The e1000e driver uses e1000_init_module and e1000_exit_module as its
> module init/exit function names, which are identical to those used by the
> older e1000 driver. Rename them to e1000e_init_module and
> e1000e_exit_module to clearly distinguish e1000e from the legacy e1000
> driver.
> 
> Signed-off-by: Filip Balluch <fballuch@redhat.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
