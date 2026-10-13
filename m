Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A791A5BAE
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791851042; cv=none; b=kSF3KYQwsJ+8b94ihw0bDGRw5RAGwkurPIhvMbkEo+gfRuSzv7Hta3j+zMk4OkMGxLx8+AS9pt6InTvVRXmZezgck2sbsq/zWreTejgWLDsWdqfHXo3uWEQpF+nux3CEh3V1Voxd/YRre8GwV7Y82cOsr3bUutj/mBvfkgYwl1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791851042; c=relaxed/simple;
	bh=5/tFrFjZtJJRgyX16hCc72CyTBmhMdAcLlkT/kduD30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPxMzxkTU+9Sc4yKTDJS2zQ+XuIiofxMK/VUrrsfLgVd7L5cN9757iYnleYSelM8MH2HR87gNJvlGLt79OXyCBOFLI/qh4EqdpEgrgyk21shCEfDSI81na7cD5/iqoYPbj3LfoIiviP1IfhdUXiqof4z/t4ZmD3a8tAZPf5en/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=bgeqX8Q2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="bgeqX8Q2"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-88c72646f03so1074903b3a.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 17:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791851040; x=1792455840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AC61oSTr2+dFF8xf1avWCTLRFRhVmCU5AtDo1f4FM9M=;
        b=bgeqX8Q2iFwxW9zCFUPE6Sp2vVF12cUnX4RPadvoSLpn/b0rTgu/O3ndwVN/qJcoyf
         4OAsB3XIi8BOubLIY1+ke+6BElLvkQflTMk5c1DfZXGBtRdBmPPigF5OIKqp3CgNR9ep
         R6JmAqFIvyUafnI5Ov90yYn2WJz+VHl6NIM7MsJQeraRMIJcK2YW4xzFcU+9pe3eHvBU
         aIV0ajCR5I94bcDd61Nd22PWWyeYSLELg0/7rdH3bRNk0++IfIB/PhAzx+UThv4pKC8F
         sUU9sJdC6L2GI80YonFQpKTNdcivokPQzAB2hHZvZAfk07krIIWuNpbr+j3qQmg6QUCW
         ax0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791851040; x=1792455840;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AC61oSTr2+dFF8xf1avWCTLRFRhVmCU5AtDo1f4FM9M=;
        b=D7vF9jpnS1oSoP4mA4+qWhKnTbFM0pYBaXmHWfqr8SdUa89MMtmAerjHahz8ObU+x4
         1KhbrwHXAHfkbDp+++AGRfKEfsGzwMGJ26jUI1GGr2k+cIWOJorYMkaOjLalGEUS1J6y
         ECLjUOc1Er+wgNUu2U7eCEeJtLnxDrOKCqpIDwTD+fxKUs00S4OUQWDda+zgobzUhUXQ
         G67YnGAybOfsUj7b3ohOewR7QcWOePg/gKNWbomzOQ7Zb/2Tp3EgN82AKvE+2SK1dzdZ
         OADmmu+PJVJ4xFjSU4r0aoRnLupN9IhkstvVxvO8hbk/yhi35NkAsR6feuOhNsmETFdA
         dvwg==
X-Forwarded-Encrypted: i=1; AKwUvBwMkQoZHN/temaYbOvQSGqwHzJxtl4E4Yrs3e853NoBvz6tSVIG7ZLyjYiNUlK/2HdmYR5IzJk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCBPcFRVWI9SGZAQ84fXSLESYAhLL6jtNbdYjfgyn4AUJhdsDL
	8witCykNeKIDy5fy7lxgI9mWA1p8c1W4x2ymwA0MfUIlzigioas4QdMxMpRHYVq2Ys4=
X-Gm-Gg: AYBFou1XTt0mNabKMSE4vHaOVg+ZnyCjE6UM6FRLaZRXAMuUbAuTKZOlEOsDPtR+Eni
	OUKff0PtIeq1HidrFPXv73Ec2wVc1P2OtxxxvXQarDKRZngmmO5Bjt/lxO2mLlmqxKmQQMbT3nb
	exa4jH/656dMJQ2m5T53u7+l3hdDg3vQJViNHpI0le5Xto1cLLMeuXSlwvHS1zU/tJj0rxjAQZ5
	pnqgl78l03RP7ql3fOlQuzEzLTibP2jlJ9AGSb4qFBP45fWB1Z7p9dRJuVZByo82sxFZwouIJr1
	SX1Cpvts8a29nzjUfpvSsjTIkovg/XL/DkuwMZDMnNhYWzIu9O8K1HRCRhzEbf16T/wy6eIeTaE
	vah11AC2lwTaXbJyFV2dWvvvaFWpnaW6BMNCZQ4AKdOiMr+CFrBtHKEKVH+bkWVdLudFaWwG/D+
	5nGc0JzpKn/q3FJWL+wfFBqW3oUI9dYJz6FF4LjF8I2PaYqQ2uY5UY1gm+ou1/9uZ+NrvPUf00q
	54H9yAs62G00rU8NzwYIUs=
X-Received: by 2002:a05:6a00:e0a:b0:88d:4b30:1c11 with SMTP id d2e1a72fcca58-897c3efd912mr9114570b3a.6.1791851039888;
        Mon, 12 Oct 2026 17:23:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c3107398sm4436615b3a.17.2026.10.12.17.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 17:23:58 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:23:57 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v3 3/7] bnxt_en: Refactor RSS table check logic
Message-ID: <as16HS6rmHLuKFwx@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
References: <20261012220827.340998-1-michael.chan@broadcom.com>
 <20261012220827.340998-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012220827.340998-4-michael.chan@broadcom.com>

On Mon, Oct 12, 2026 at 03:08:23PM -0700, Michael Chan wrote:
> We have logic to see if we need to reset the user configured RSS
> table for the default RSS context if the RX rings have changed
> in __bnxt_reserve_rings().  Refactor this code into a helper that
> will be used by other callers later in the patch series.  There is
> no change in behavior.
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>
