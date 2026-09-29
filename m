Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0B4E4319
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718528; cv=none; b=uR+4qw7K2ZlMYVPylvZ+qkoONA+Wohgt8cGNXg+qSiLk+Vey/ueLl8FobdKyb0xhRd8zt/PR5s7eAxTR8VJuRgHvXrCbHkqwmaSUgR/TFCotehbZ5arLG41/lGyAytVk4FzJS6tjtoflzAPsSe3dagf4XHztRbWhlVhiR8sQek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718528; c=relaxed/simple;
	bh=jEAlHCaf7HwrBMr2fEr3XlegkapBlO+MtAspedqTvo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2pqkmdNYsuyLR3fFjQqiI29fPkmHzzaru060/AtDw1RhuZstsz8u+lo/U9PVMIo8D8azJpB4oHAe5ApMWxh8+So6rVHwapqwHF20cXSjEVEs1rRm3HzgGxeM/vlagJvwRiGdPdwncPISAuBEs+o0bdOzHyu1A4vEePeEkWg2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=GqpdP/Gl; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="GqpdP/Gl"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-881a3a28e72so1525006b3a.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790718524; x=1791323324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GnGR8D9Ofu0keKVSYqoY+bfqxp7ik+ClHNVT61CMuqY=;
        b=GqpdP/GlEJvVvytyTk4nqQJmNitdCQD0RMVjVLvTfBNan8AkB3HO9RwtZTdlOUKYZP
         zjlceeV/o0uOKUpAcnuK44sBIWI0kkx4CrNICwDpLNjrbAJL8KjqwKkT71bTCjz3XDY1
         0elXE5glbbzsRagBdQAZmV7L05J6zINy5f3Bc6CLvwu6Ntjoa2f+sTpOk2yotzvmjn62
         Q1ZwSkpQbVzbmTjksZdGp2Ka5k1TyWRk3lw9XCGL85vCcTaR4J8GcwvERslRiGzrMHEV
         AMmGIpjuHIIbkeQeIVEb44s36/M8Ur9DS7cSLkECGHxjGpfjUdQPeOy/9RbRjuOA1WXJ
         z+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790718524; x=1791323324;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GnGR8D9Ofu0keKVSYqoY+bfqxp7ik+ClHNVT61CMuqY=;
        b=kpJXs7lx4yR3U/j8H45u+yMiCjI63W/04+jo7fbY/ux7yj0NgSU1VB3nj9s0X4UkbG
         ODqZSZHyRFRkrW+xFJRbJa458AV2/JNJa7re1zC6lqqW3kes7QWXuyAGD+mNL0yApC9Q
         3475M2jt74QPBDjB3s1bZgBdyaVrxP8vOdSnhhIU5/LE2bwBeqFKxJ1LRopAxh0fd8n+
         PszKBjJE/uEorODuKP1tv8aVR+CiO8J6SE0rUAU54dPI3ilyQvbyIRu5x+ZfkxMzJRc+
         CsoS6VLmcSU3pYy+WMadTRbbtnhkgOW66mY2tFqtLQGYquGU45ElQMDJzOJZ7bfk1ojH
         toOQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3HW3vQE7iBqmYVxz/YnXPjggJZEKEnTPFFA+ilhXCzbhnYqU/Q74BJRvfOyqbe5VT72FHIH0=@vger.kernel.org
X-Gm-Message-State: AFuF++mxmVek6is1Lj1Ss261+AkjDP2lU4xDihaq25D+jNf7bz+1igST
	5BsG9R13KipB3nk1axbzOJEEBG4AExDoCWD5V5L0TVYTfi90sS380LNqQvBpB53j4Jw=
X-Gm-Gg: AYBFou3cyo5CEbEW+ZW1Usku0EIt3Eq4eAdGYDuLn6jGI99JFAp/vBGGCAKcg6BFwLm
	5H3P6k9JAvry6Ldj36gpjag275AjxTdg2Ad/Eb71BhS9sEFAafpm77P+d1xGiindyCNpEttaW1P
	w0usvo7XZa8y2nKZIT9Rn3eHsGarRsp4zRGqkygtaQh9HDu9Qa9rg68ySXCgCiC9CEFx/lELNEL
	N6Uy3uveT0z1t3Kmv4GDLlhQ3c9vXFJ1PbE5NBc89ISCxVuL9wBeniqCccybTy23qVWJNMo7Nko
	QZ/6znr2WNAvW1VenXNfaaxhJuRnq+7zsDctJFzXkE17T8BsruEELgyc3hA9xxbbZvKanD9GGFh
	SIB/HnjlD2zAhXJP7u+nVE5pRJN6rZRWIsvB9acKvaCvcAkUfKv6bLnXKC1K05oRFi0Hb+J+gU4
	zaTY7/TWI3b70LsF3rLPMVJgKzeDvz/QxvtQvQmKsahuSOLW1YC9z1YnK0z8deP079Y5w4YZ5bS
	dXytlmDiii3bNPP25BU3gI=
X-Received: by 2002:a05:6a00:3005:b0:874:705d:f63e with SMTP id d2e1a72fcca58-886c48b3682mr475937b3a.32.1790718524401;
        Tue, 29 Sep 2026 14:48:44 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8868ccc884csm451233b3a.50.2026.09.29.14.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 14:48:43 -0700 (PDT)
Date: Tue, 29 Sep 2026 14:48:42 -0700
From: Joe Damato <joe@dama.to>
To: Ayush Yaduvanshi <ayush37735@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net-next] atlx: fix kernel-doc description for
 atlx_tx_timeout
Message-ID: <arwyOuM3q36/q4RX@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Ayush Yaduvanshi <ayush37735@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linux.dev
References: <20260929101714.51579-1-ayush37735@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929101714.51579-1-ayush37735@gmail.com>

On Tue, Sep 29, 2026 at 03:47:13PM +0530, Ayush Yaduvanshi wrote:
> Add missing @txqueue parameter description to atlx_tx_timeout
> 
> to eliminate kernel-doc warning.
> 
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
> ---
>  drivers/net/ethernet/atheros/atlx/atlx.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Joe Damato <joe@dama.to>
