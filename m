Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEDF4CCDE3
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830189; cv=none; b=S1/QotE/xJAcpwMR166J7ZyBplQZl+QjgiWykJyVllNaECM+gMxUTQ2sTA0iXb7BdVDaASQfd3IoXKzDS3YVgSLpiP0PWQCiZlhMhOlGgoMyN1hBQYfKbEAJa8D/GI7nvuTX5uJ+x6gLGfzlAxsO3CV8bRvhp63kMLZfkVejfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830189; c=relaxed/simple;
	bh=HRAEX0icmzNcSwNMcvS3r/mqfS55EjfSaWC9s89g4Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/YtvjC0QXEE4nJGmVKDXZUA+d23uXF+5hdUC/MvJqTZAy2a/zxAu+fb2VeS9I8+DcStLSIHH7JzxBiHkCx/a4CidbPiEGDhlXbM+PLRNlnrzCHKDZPDnt8XMmyDPB74k0/Y0+jRl58o5H0nTubcMHqoNfqYJrh/9OQYeKTcQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=nlKv/x+C; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="nlKv/x+C"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1399526a91.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791830186; x=1792434986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NNkP45hU717bcOi5CRDm9mafe1wW6i7kblo6Qb0SPug=;
        b=nlKv/x+Cu5V+AuJ4npJrdNsyvCq7ENXW2keINz3KB8i6y7m0iGAgOKXEqQ8wPe6aFI
         NsL2GtYsQvxyaXBbRxSiGmfgH/IPhWRLZestFZuFhKF1JXEmhy0A6Az+48tbb+OaoRRS
         EB1KDVBYh1qLzyh9I1qHCOD+NmrsZCAF5BMak05z31GJFYXeDd07QP/UysYjvOK0dMMX
         qcWdqJ+cQE1Br/KISdZ0dBwqVdG3nhUKh878RF7F2RA6t0KAUlaTiqQPU380KLyexYPP
         8wxThHewelPeopQJmlqgEP80nykQcGDsAJLmu13WkCrYs7ZcHKQieIPYWbqiApLNIJGt
         u/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830186; x=1792434986;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NNkP45hU717bcOi5CRDm9mafe1wW6i7kblo6Qb0SPug=;
        b=usGnXby3cBtZGQrswwTxyUi3ez7AzRkYxLJJdM3KM2e0KT3xorXNGqmuG1gVE50omY
         OoNoZzO54haMJ0jEnOIRUIxFGp1nfBogWvxRfia+y1fsxiL8d7NFdNfXfk/Lzz/8ykE3
         ofe1c7tDyC6zh6LjtQlYIqokaf13ZVAZ6baH7aWALLZhS2it6os/3gd2Ff+GOCeGpZe2
         h1O6MJvqWmgUs3Ul+pkbCx+Ca74Zw23DF9ASq1C170AqYpzukIKxzr7oG2x0FgX6EPOW
         C63bbDX11Ryq5ZygUbH10xgwiCKvXhaF7RsFf2zpg0i93H5a3dDH4bNGsxvCxcSBe4KR
         f6pQ==
X-Forwarded-Encrypted: i=1; AKwUvByI5c0O8ghLy4stJxnxJVIyNMCk8iJTCdk77+AE+Ckko9WrXtzkCMJPV9yr1d3oMhCll4UuCNs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXY61G9CMWqk3fpF+DOL2V4O2V8RoYy9jn7z/EXj00Kcys9x74
	ZSRL/YcMLiWW2P1H9UMh2r1AXokWPKeiv2N0NL1EYPUIJf/ePHd1qmss9uw3MqaKe6g=
X-Gm-Gg: AYBFou0l9s3revI1+Xp7ikf9O8fD1JHcWZ0edqTJjWWUOoLYCJcZXdkzlU1zKynaAfk
	jFeXoYRfa0AdX/BNkRFD7AyxyduSxEXd1RRC7p3JQ69/o8Vtmd0FReVQ6Ya0jcMTmtPDYm+8va7
	a5jZKcGj20jkg53Vd5IJav90MrIbzQEfmL3JKsWYuOGHLTWRm6YaxwG7B/02NeBHDCIUqZUJYgl
	6XaO+lRHRMlrX3VVa00jTkzpxOczDjeTqGYKqqzpG7dwbJplOPhpjiKVTWlhlCW57cI2FU5vtA9
	BZYUQm58WMwBGeELarH8vyAdGcgohNFEg3a/ZSG+GUcFz04n/WpwWhuj77bYoyQB3v88qauTaCz
	JSyDJuXmj9Z68fT9th8ncszlWnLCB0+V1syM+nhEC/HDdfFSYxdENpDvDAV8k30HiBXoQhWTtTX
	38o4iaMmfLXjM+OJcIRkVHj3Tsd9FOjLRLfZW3hGlMugvWObQu46GAIjqst7EfTXvBsEKjKdha3
	8+cn8X7dfJA
X-Received: by 2002:a17:90b:4b92:b0:3ab:36c4:b506 with SMTP id 98e67ed59e1d1-3ab3a3a1b41mr9754602a91.1.1791830186199;
        Mon, 12 Oct 2026 11:36:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab396620e2sm10547325a91.3.2026.10.12.11.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:36:25 -0700 (PDT)
Date: Mon, 12 Oct 2026 11:36:24 -0700
From: Joe Damato <joe@dama.to>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] devlink: Fix accidental merge error in nested
 devlink docs
Message-ID: <as0oqO44KD97Sa/I@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>
References: <20261011090739.746757-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011090739.746757-1-tariqt@nvidia.com>

On Sun, Oct 11, 2026 at 12:07:39PM +0300, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> The referenced "Fixes" commit accidentally reverted a correction
> introduced in commit [1].
> Revert that mistake.
> 
> [1] commit e504cf18ef47 ("docs: net: fix minor issues with devlink
> docs")
> Fixes: 3bf4c5970ca8 ("devlink: Update nested instance locking comment")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  Documentation/networking/devlink/index.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>
