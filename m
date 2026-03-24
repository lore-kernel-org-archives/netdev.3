Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A20370D7D
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369365; cv=none; b=tIudwOfNa+QTUbkg45ApI5ds9QPxuzqFUNcNukhEs1h20pYzDbDNPiIQiu3DEtqNuQxfXWAMUfvBSNYr8fIbgPbKgS3xZOFHEnrMqYEgkEiE5tNgOsPuKm5me3/fp0PjM+FWW5e1kUbVbHWnSXQxVPY5jwhH6ymwL8ccZ1+glTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369365; c=relaxed/simple;
	bh=XGOnOjqTLdQWwmrhazoiZbuqcNrINAFTqDpbZLJfzUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2JrifKJj5fcKR6xN0ZubtgYG17RpNGvob09zBuj28RoolzMq9pfYZXTxNZdJEBKzuNiIUy+97tJUtMoSLCTR/z9HFpJxo/+DwU3gaOqCRc0tcRqxHDtUkBQZ+gJK4/Hgqk9+7S1a7Wly1XZdKt3fXHGwylFt/rYiWTDOGSCLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=bnT48NLp; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="bnT48NLp"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82735a41920so652928b3a.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774369363; x=1774974163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ9mj3vaFMCOsa7WRhM26VuPZvjL2srOCWlPUtQDcIQ=;
        b=bnT48NLpgMD2HtegNetWWl+X71RXj7CyJjvSQZohTD5GmyV9Jpq4AhM7gGhMmS789k
         VWnp88mbK7Mtzw80nPDHYEjW4Pg+gOJsKMWZm6T7nIkT4FngqaYjKzL6Jlo2FHnlMY/N
         uavM76fWOE/u4zhC2Hs0wGADp2u8mMRqi0Qm0CIDH4CekdqIIeU0cq5dVt4uu4DJrPpo
         RXFRl+XQmIiZNnJycizCsQWL+fQCyEGELRGP1eDcM2gJYxvB+RQGKhy5jBBBN2CVFp+C
         Ivy3mwk3uMH3f0tAHAg9S6eEEN85CO1vqNT+3ROCBsOSW9+mpEezR1NYYpuNN0ex8IiI
         BS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369363; x=1774974163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YJ9mj3vaFMCOsa7WRhM26VuPZvjL2srOCWlPUtQDcIQ=;
        b=VdRRQfsszTnYPmAqs98316EwV3vGDQPl1LfcWHp8EnEvME4aPkXADz8PcW/OGAqz3H
         5moi+Rc9y41KabSvawSifMM3J3hfUZV4pYSiaOmRWlUnWOV/wJdPRohGXF88vSSqdRtA
         t1acwi6aGfq2yF2KGm/+J/oXCK6JDFgzQKekruIsEBc4qOIJMZh5uigVp5qLM6rl+V9n
         WOuAQLUimt+SF6+TRr/zDXEwbM9YGcUU0HPy3UMW5SazUvLNrnL2E7pnnaeRF0xI3t0Q
         0T07V3MqwIdNbvfBRhwlN1xBPJ1uiGXP4v1tTjqKnLET5WyAkS3LubU7zA4pN3DK/khq
         TQAw==
X-Gm-Message-State: AOJu0Yz71Llq60Zru+luNwuhTcFcVhz0omlekYzeNYoIeZOqqcXfMgrE
	khzx//3XsXkHEbM47Mfxx7aMUYcbj0MVBS1o+gbnoYr1hG8GpGFyWtq2173xf3RqCUQ=
X-Gm-Gg: ATEYQzx0Vjwxr2SNqLGfgVSzQKFJzrbjjF4h1ULn8kEphnqHc/n1etSqF6ApfjV0YIa
	p85ZMo/L06CAgdPWwdKE6Dmt2nDTMLy4Aqoej66ChbAtf1F4K0moJkk95vecmuHzAJmubj2Pi7/
	1OIvUC1DVIxpWfP+LWJupuWqAgYXxHbevIZG1NF9xulZ8g/PrDEjHpAy6NWrXyGaUHEmqOTh8Sr
	fK4l4bbrEvsBjZh/Zi7v51rsWed/OQUINiEXhMznpyjU2jJR9YRDYVsrVi53V1oMVbY/NtijcXR
	r6gb6V/3BSUDRTOO51AFg3IBDAmsYYxXTX8vRlfEy9Hc6SoPudYHnoIftqN0dfN1WmFolfY5YuC
	eYLAsOWoAC5glhEUFh5D10n76lHgqVcveq6gk5bMEK5QynC0G6YmHdM81NIYnyXqXoXh/qHFGG5
	gxatwZ1QNpNuyXCEo5NweXQr5a70wH91jw1QQ=
X-Received: by 2002:a05:6a00:bc05:b0:81a:b602:daf6 with SMTP id d2e1a72fcca58-82c6dfbde34mr179808b3a.48.1774369363488;
        Tue, 24 Mar 2026 09:22:43 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bbeff2sm13122867b3a.20.2026.03.24.09.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 09:22:43 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:22:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, Ivan Vecera <ivecera@redhat.com>, Petr Oros
 <poros@redhat.com>, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH] dpll: Fix missing notifications in monitor mode
Message-ID: <20260324091912.3c2eb618@phoenix.local>
In-Reply-To: <a44724170d2c5e288062a923d93c3eaccdac97e3.1773340441.git.aclaudi@redhat.com>
References: <a44724170d2c5e288062a923d93c3eaccdac97e3.1773340441.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Mar 2026 19:35:47 +0100
Andrea Claudi <aclaudi@redhat.com> wrote:

> When running dpll monitor with output redirected to a file, notifications
> could be lost because stdout is fully buffered for file redirection instead
> of line-buffered like in interactive mode. If the program is killed or
> crashes, buffered data is lost before reaching the file.
> 
> Fix by calling fflush(stdout) after each notification to ensure immediate
> writes to the log file.
> 
> Fixes: 656cfc3ce05b ("dpll: Add dpll command")
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
> ---
>  dpll/dpll.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/dpll/dpll.c b/dpll/dpll.c
> index 846ad4b0..84f68f76 100644
> --- a/dpll/dpll.c
> +++ b/dpll/dpll.c
> @@ -1936,6 +1936,7 @@ static int cmd_monitor(struct dpll *dpll)
>  				       strerror(errno));
>  				break;
>  			}
> +			fflush(stdout);
>  		}
>  	}
>  

Applied but moved the fflush into the callback.
