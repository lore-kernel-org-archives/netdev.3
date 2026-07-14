Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744F448CFF
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033920; cv=none; b=EO14gtPDRUWA3QTDqosBHGOfMJIITyQNELs2hTJdW3XrHT+5X4dytEmbXlD//ihqYzq+1adU9Jk5rRMUYcvQdZ6bOwEQ/rsZEt9Tx9P0yr5eYtXEvmpdmRN1fM6sZayRxOftRqGuWtJEbROLHh8ZmafT6j92vdH2L8QInXAOVkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033920; c=relaxed/simple;
	bh=zodWS7rv1aDgcuPkzbqACdUmH3WWZLSmb9HJQdCdNTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XT6cqC7R0Hc6K9OrCiMcd8B1KsDLqsmyupr4Py9WOIT6wRQ/Ma1NRPGOa+XgoIe/QcH7y6Hh53I1RnOEV35MIzQK5xTR61TxkJZFsteYFD9mL2vnrdIsSuCgYfiEZr9f72QyYhsqe9UrE4FzCaK4cCsq2pX9U2VUnCUCkweyjrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=sNKcInuH; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="sNKcInuH"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c86945164so33981411fa.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 05:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784033915; x=1784638715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LFB0TEAvMFCr6jHr2OUldXZ9xrpx3f7gJBKNTJaTmYM=;
        b=sNKcInuHSrzfnMZNWQ7jrzoaZYi7udGugtrUx7kAsLngaOINg4VMEz3QZm59ETPbkP
         G4jN3WG+zF2WKM1WJorX93KPeO5lt8meIqO4NNWYOo3lCdd3mHIjXdcKARocpNw9idmr
         gAp0RvZm51j+xsHH40AQFHPKKspveEPQc4sdZNZmpzJHS73PCY84qFWZ6h6xLa17Xhav
         CMFcDyJ77ivh4UFHEMsxejeF5eMN+pDSE6RLHFfWmhrZxc6d17bH+yOO4jJ97TSqPs0G
         9je/EXDV6Z7qcoAO+qHNXV8va1Quo2xfiv46DWiM14VrmC8bBH++KdyBALOPqRGh6lw0
         0KEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784033915; x=1784638715;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LFB0TEAvMFCr6jHr2OUldXZ9xrpx3f7gJBKNTJaTmYM=;
        b=ehV2XH5K59D6HiSa6SUdodVAbKeYh//0Ivwo1sBYrCssoMUJEoiYCv5HGVtrrbKbSX
         0rOyesB76RH1hq8xyxYC3qi0z/ep9iwuO79X5bqS2HgAotHmbgwv1hPUqeB4Vekn4GAo
         ES6/RopCvAiI5nAPh8XEIqn+JULx+KfqqdZlvtZXlDlKtRE7+8m0eNHBmv3hHoWluH8y
         Liji6SOF7G6qGaccdMegp9XW/F3Kt7Pq/bGQxNEDEoGfkPvyGRC4+F/+wnfaHHn8eLS+
         aLZnWV8fVdrLvjoVyQEA5OA5pxUWKtfXDKQ2d/59NrE6d4VoYo4BIRL/V8yGd0FlH+fo
         dMlA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7IbeqGTUaZA8Mu9SddQLNCaEtJ/ZDSyyw/wIPbpEPKh9qnTVhmw5nbCd91J2d+fqowfLc2K0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyje9pVqJzq2O1JMbVUbRfE5c5UnGzoz0oqMGh3WuuV8powIMvU
	w6lQztIBVjTH1INc28bys3jZ28AOBqw2IZcEtbr9jB0zo8WqTfWfn4EVjv5cH6ZUG1U=
X-Gm-Gg: AfdE7cmid9WukcnSVmbJtyNCS8yewXm5sGQJ/Y/AZO44DzTPWIxyvPPBbZMrK+oWDhn
	G52JGSwnqPyqED8p1abmf+Mw5mt13ytiRlzMggmJQlm6Z0r9c6clX6vZGRdiSu3LU54ZxBAhu+i
	2sl/5ju9iDKjumaTxJyyssxUXKackHMtQR18qsxMJGdkbqtVXTMPgvK8BcTQ0cpk9254rETJW5w
	Xym5s4Sx4Gl7cUqTKwweIcWs4EfIU4cI6wYk4TwzEQ1MgT44EQ+6U6fmJDGmsDvE+iW8hnn5AQK
	2icwiD9OCmcL+zaI1pFQgRaICPUAXsH94I/Jmg9nhXV3cHh8fDAZuG/Jm4VYdu2uyw4N+XiVJTP
	QQ9TxZJvrupg+aJI2mku6iLkBAyt/Hv67hj94jqC4w4VoU25xS+f96/UmadYWwCPLEx8i8PTk2u
	S1e3BQpY2i5I/JaGx3DgNjiP8=
X-Received: by 2002:a05:6512:8395:b0:5b0:1760:fabe with SMTP id 2adb3069b0e04-5b0236651e9mr1956976e87.15.1784033914770;
        Tue, 14 Jul 2026 05:58:34 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01caa66cbsm3482896e87.61.2026.07.14.05.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:58:34 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:58:30 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next V6 3/4] devlink: Parse eswitch mode boot defaults
Message-ID: <alYycEavj752bHjD@FV6GYCPJ69>
References: <20260714061731.531849-1-mbloch@nvidia.com>
 <20260714061731.531849-4-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714061731.531849-4-mbloch@nvidia.com>

Tue, Jul 14, 2026 at 08:17:29AM +0200, mbloch@nvidia.com wrote:
>Add devlink_eswitch_mode= kernel command line parsing for a default
>eswitch mode.
>
>The supported syntax selects either all devlink handles or one explicit
>comma-separated handle list:
>
>  devlink_eswitch_mode=*=<mode>
>
>  devlink_eswitch_mode=<handle>[,<handle>...]=<mode>
>
>where <mode> is one of legacy, switchdev or switchdev_inactive. All
>selected handles receive the same mode. Assigning different modes to
>different handle lists in the same parameter value is not supported.
>
>Store the parsed selector and mode in devlink core so the default can be
>applied by a downstream patch.
>
>Document the devlink_eswitch_mode= syntax and duplicate handle handling.
>
>Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
