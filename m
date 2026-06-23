Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A023CFF46
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211150; cv=none; b=XRlNZYta4LPmAp4g7a0KyWzKkFAc4gx/gN8FDDFS/cMwdrzQSsEbJ95vWIDQE5DhqNVd9lWWBpcuVwu5/JANUdWkCtO+0Ei6I/44Hcqcr9OhgE04EjWEvOMq4CfGQIZ3titzCYEL8OiskREGfN7BDKjIOb0E0CgliwT4qKuwWnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211150; c=relaxed/simple;
	bh=I2f6itwTgVHCX/qr45W8+N4z2ngD71bJbg3yfx+2XOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iutocpQXdLm8pdwj8PmjaEOzzhiVw0TlS/+2CDP7j3I1ue7kPaQr3a5m7pBmJUQ5IVADXp8u0GOes03ynlcZaloNKgYWN6yHlC6X1XHJY5FSQ2MRVFnUzZVegxXPgHQKteqNpnEZymWsx3V1JhMi6L7elOsJJ7Th96h0UsSrq2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=gLi/8mGf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="gLi/8mGf"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef6565cfdso2357975f8f.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 03:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1782211147; x=1782815947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zbiEUPgR8Q+kRs3L0RvVWt3vrLWa1fdR3yr5B3/v9/Y=;
        b=gLi/8mGfPDn7KVQRRpmRP+svMHEn8VXcXRpeI1d8qg7cP49+I77aPTF96mde50UoYA
         Dt2DJJwnpUfI1BKYQ7YVTyxSEDkZEhd8iWQ46VW3LP6mBTVGlGSSQfRrXbDSfkXrE0nU
         UBnI05Vt3zwNnJzhY/O1QUGsjXt+p2gjOzgjEFxNLC3nF2Uo/M6fTRQJTt5R2ejhHMPC
         tnxK4Wq5b4ppS9BtUPRGTePQ6H0CkO7WulmXo3jDpFmrM++k3WnKZx+COpPwfmtyKfon
         xVnALc/r3bSesxj6TvU3bnxysd9JN7i+KaN2Dn3cG0vQgI9YpiKi06aBXkgbJ6dNSpxE
         /4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782211147; x=1782815947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbiEUPgR8Q+kRs3L0RvVWt3vrLWa1fdR3yr5B3/v9/Y=;
        b=B91rupW2EZ7hBcew40XcUV/4wV9Rfl35NFG1fmjdd/IM8NgfXVGbrxCFiVZ5Y/wk9U
         mSJpZECQTED5g0lrF/2vj9VtQjAzcAS/nMVXsASwe55feft0AcobNsXZ/DNECkqX38El
         L5rA0SZgsdOcBvvQu3pfoa1QI0NPl47408hshy2bUfzPLSgY3a1L+P/PtB72EupOKqbQ
         t2b/HVk4a6WHVdpK7ghn3FhKfnhy0HtWivQplxXT4zRXTUtCDyYxRhyry6C3M2Vvn96c
         kV+xRh9dYd6IKsxgCj5UE6CjI/FZ34hl8lujeJwu5i62I0TLgWPN7/gbMy4dSoHEABMk
         +V4Q==
X-Forwarded-Encrypted: i=1; AHgh+RpXAsqi0UKPKj7wjHNeyl0jZUkMrfuWM70W7E0NKjbcoLEq0UfriLS5U7vJiRhIzFmPPXRxqKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvKqlVXcldOXcWb9JbagS5zrYbCSgIHef1BHnaoTg8iAYUo77
	/B/WlSGaI5NlIcnk4KP5hmkQli61T7us+a3zkMZIW4e4tlwNAZYj4VXPk7dw1fVOqVI=
X-Gm-Gg: AfdE7cnBOu9ZhAUMJ1FZy0gTxakhcBqhuLg1RmuCx3H1ltTBqTe8QvpkRjLZ+nfwHRx
	71EaRLf918iq8rySW5WI74rxFh23Zo8aq0lbeuPVlgNQL4AQfvsgfjTP1K6QOCElYjHu4GNQllU
	eGymjWq2XkbLH2bC1XcArNGOgjoSyo1Xn4FsT6WfO1ufLJSZBU7e5wUpWEPGgEcrLmZu7cFTh6c
	bWgzw8FMGsPGRw2epkBRK/WQWFPGLIAsBTP1U4rFh2/6QjQBkgd9ArRiOXeyGma7XQw8jtMp3hV
	pk9qX1EQKZPGu7EnWvMyO8y8HhumAn+B1t6RsvZyUhCaPvKQr5c7H+VLqpSOc9H/xRTVckCv2UX
	xprU1oVGuQ1/XsHb160mwAI/6oLMpEJC4IDJJIiqzy2vMK7bik4R953yBhWtGBtQFh4G37TlZFQ
	SlB1YfbbUsMgLzJVO3gDan5A==
X-Received: by 2002:a5d:584e:0:b0:45e:f631:2c73 with SMTP id ffacd0b85a97d-46660743f4cmr22028124f8f.9.1782211147248;
        Tue, 23 Jun 2026 03:39:07 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4e3esm32983815f8f.8.2026.06.23.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 03:39:06 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:39:03 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Jacob Keller <jacob.e.keller@intel.com>, 
	Ziran Zhang <zhangcoder@yeah.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rocker: Fix memory leak in ofdpa_port_fdb()
Message-ID: <ajpiQUaVEHujX3Jm@FV6GYCPJ69>
References: <20260616013245.7098-1-zhangcoder@yeah.net>
 <1446e974-0df0-4956-b2af-7a9403da3c8d@intel.com>
 <61892bd4-7368-4cd8-b360-0267e5c47156@lunn.ch>
 <20260617164411.2a8a260e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617164411.2a8a260e@kernel.org>

Thu, Jun 18, 2026 at 01:44:11AM +0200, kuba@kernel.org wrote:
>On Wed, 17 Jun 2026 11:26:46 +0200 Andrew Lunn wrote:
>> On Tue, Jun 16, 2026 at 04:29:59PM -0700, Jacob Keller wrote:
>> > On 6/15/2026 6:32 PM, Ziran Zhang wrote:  
>> > > In ofdpa_port_fdb(), the hash_del() only unlinks the node from
>> > > hash table, but does not free it.
>> > > 
>> > > Fix this by adding kfree(found) after the !found == removing check,
>> > > where the pointer value is no longer needed.
>> > > 
>> > > Found by Coccinelle kfree script.
>> 
>> Is rocker actually used any more? I'm not too sure of the history, but
>> was it not added as a way to develop the early switchdev code? There
>> was a qemu implementation of the 'hardware'?
>> 
>> Is it still useful? Should we actually just remove the driver?
>
>I think it came up before but I don't remember the conclusion :S
>We should either add rocker to NIPA or delete it. Jiri, WDYT?

Remove.

