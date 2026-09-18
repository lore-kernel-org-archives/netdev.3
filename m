Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC6425B08D
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789772618; cv=none; b=eJlW8Z7uoXGMlBlLfsNY9gS7lTsdBPfdfRiWkYzZDZSLOAT0Nib+GNNwJAioNtIO260rlxXk10hRPn1D4rFfyhFdRzSZj+W2UjjFDVZ/CoGS9wn7CcYeTBV+zesU4XU5SPVA5Tp9QyWPyVJf7TQSXetfI1j3PtrGIgNpeQbBHJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789772618; c=relaxed/simple;
	bh=Ag31WG301/ShadTpa5dRbVVnw+XUmrr8H7KNNlqSCqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8ZsnOwWtWrOWtxWUkqD70EaxV4iZxCRwHLpeDtShgzGQMBqpN4xTARpYgnu2Ic3rYFjRsLE4uIYDGbSRCjYGeN2XXa7EIAPWIgWgLvu1s2DHWlsRDlMkvOIEnt40CZ6EWRD182KBpYVn5fKemOTmOzOrx6xiwYEF46f9RMdUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=LC3YmWzi; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="LC3YmWzi"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea34f01so1071347a12.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 16:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1789772615; x=1790377415; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cxr2TwzREjEnFDLvjUopvgMY8InQ0AKsNfK+3vVt0rM=;
        b=LC3YmWzinKLUMu8rw4lr3fXks4vCw8MD+IdhqxTYUvqFbKB2HQm86O8pCCFgFuDnbx
         KcVgdMz7HKQKNLv8B81auaYg+fcByzBs/Qz4Mm3ct7E43c72YsE9m76FAbWgKvH2BBT1
         0oxKA7D/vLchPNvFWna0xw3TjONKzxrqWjZXzQzZMBGPD2aE0/KGvw76iph9ag7s1E3X
         SiePLkLs/ZdRNCesfgNFSze1v7HiEo2vVWVbHqgsMgGUtVq7fSIAjXlpFYMgNAH6/NCU
         wBgyhqUVMUtl4OKJiWtr19ANXlyKHqNUmPzn4cyfHLNFzx+//8hppnKGb2XJnu8ssT6t
         7AjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789772615; x=1790377415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cxr2TwzREjEnFDLvjUopvgMY8InQ0AKsNfK+3vVt0rM=;
        b=qkd6Jao26i2JLipEpfrv3vvYJ0NnmhV6cstWw2Qdha+jfafsj9WtuDFfCP75mFDEF1
         Q0VsWLmslWzE1Y+SMuxp/rtDxpl3950Q4UuA6heajPnH3R2pTx/NO5Cd7E4TkT/F2ey0
         qZ4yotg1P2fzUAnJINGKCCdUZ/eRg2592dH07RD9w5jtRJDQMnWlm8VSjJpPomxbzbny
         gA0h+kgdreBd3h82FBymupl1Lff71zmsO5nxZvk3hxSZpE2cpPmqX+M+BjAF53JC34x4
         5jTJT6MoJX40nsVp3xb0IB8YMeXqq4jiae0u1C8P7TSTtg1RYqI+Gn6oQ11BHKYHnMqG
         uBiw==
X-Forwarded-Encrypted: i=1; AKwUvBx2yszHS5srBq22qrtNhth6H6Hw3wnuWsJ+2WnWbP8y6Dea2HBcg52/PRU8PgvMV4HjzFsoK5A=@vger.kernel.org
X-Gm-Message-State: AFuF++lDH3aK7drHVNP84/nENy3uk2m3o6c8plA6qWV8yZndDfv9RnVs
	9wO8/YWyfeW1tIMdQLyyoS3tbvK/seMhE6YRzb+Fs1w5YjNcYCP29zlUSIYFyBSd3lA=
X-Gm-Gg: AYBFou3+/5HvZhJoz2W9X9YmeAGl62C7lw5bObwD1Zry5OnnSytTTKdmJRVZPZr8/6E
	Z70RaNz78DdEUE+rX7y7aMFqjp7ls7QL/MoWYJiuVIWfuk5vjtQNm2DdUIyhnPc2J9yZOeRTnkQ
	ld9egf8cveothUpAzdiRVMIMBB4SRxA5I0u1lVdN0JYGs8gSuHcTX32l8yWTYwHcx3BizM4HFR9
	TewyJAC7DPK8f6bHAFAFBELfAKK71XTElT3sR3fZmXunyIPP7dBPbYgIqvsCGuEYTabNYEKbIdW
	NZSYCuC2GFhLghTQH5VGO6+PErXQrNKWhscYOrJvuOsMCJ3/eALCB8CRzXRqeQiO0W4usFERvYn
	pBGSolGnI8E58pl0lFHliIUknkH36xUDpk7A7hFcxAU1Lf+ydxIVVX9i6PyQgSYnJKe+UHE+mcO
	SvBKToXqkN3svndv/Qp5csHVF8B0Zy6KGxlB8Sgfu+7L0jmwFVX6BB65+tvRfx3/c=
X-Received: by 2002:a17:90b:4b03:b0:39e:6c69:9b94 with SMTP id 98e67ed59e1d1-39e6c69b24cmr1436649a91.57.1789772615034;
        Fri, 18 Sep 2026 16:03:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:57::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb427casm1418570a91.17.2026.09.18.16.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 16:03:33 -0700 (PDT)
Date: Fri, 18 Sep 2026 16:03:32 -0700
From: Joe Damato <joe@dama.to>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Sashiko <netdev-bot+sashiko@kernel.org>
Subject: Re: [PATCH net v2] eth: fbnic: Avoid rounding zero ring sizes
Message-ID: <aq3DRKLjJW+8MmVa@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Sashiko <netdev-bot+sashiko@kernel.org>
References: <20260918114641.1281172-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260918114641.1281172-1-bjorn@kernel.org>

On Fri, Sep 18, 2026 at 01:46:40PM +0200, Björn Töpel wrote:
> roundup_pow_of_two() is undefined for zero. ethtool permits a zero ring
> size to reach the driver, where the minimum-size check should reject it.
> 
> Leave zero unchanged while rounding nonzero ring sizes. The minimum-size
> check then rejects zero deterministically without changing the established
> behavior for other values.
> 
> Fixes: 6cbf18a05c06 ("eth: fbnic: support ring size configuration")
> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Link: https://lore.kernel.org/netdev/178971206933.22033.236948278674126701@kernel.org/
> Suggested-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> 
> ---
> v2:
> - Preserve rounding before minimum-size validation for nonzero values;
>   Sashiko found that v1 rejected values which previously rounded up to a
>   valid size.
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
