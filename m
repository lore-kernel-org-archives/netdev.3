Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378A62836BE
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237564; cv=none; b=oYEBef7SM4L55fP8fnV/HQkYbTg2A+MSxFQy6tI19ZwcuyyvvSJTWfrgrn3xlXdtPo6DyqcmvkmVJoGGehIqAG6YmwTCcHCuRZtPrgAX0ZjbqZz8bU5vahTH9/p4+skoHrD9m/Jj0wWUDr7HCZ9jRy8shG4umJKabN9gpRQKq0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237564; c=relaxed/simple;
	bh=G2cQyFqV6NqHle1zXvig9YHfmP88TuKCHI3sxoEArUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB9nuEi6iAywajttBO+2h9MrkPBDzN/lgCxbdmUwXnE8GSASOqab1RZ8cTEH3dg9Osq46vl6kih67hzZiYHzXA5ne/2Ex9GC8aRHCgzKIqple9Cdumciu4kgaTLVg8Nsn057sbbOHRr7lCP15tjCWbsps6cN4dfsNb5yaFA3etY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMq6KULb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMq6KULb"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b1cf1212so724557f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773237561; x=1773842361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPOPtFUqlstAzruiSZyXiMnwzSiIuIi5KKsAasJI+Fs=;
        b=LMq6KULbtaD2cWjCoB17/YXBKseMYJeSJPzqDREpttfuLZXi0UitrhZDTA6Kk1eYE0
         X0QYuXSR9HSLAI1fa/hSFyWvdU7Hy9+bygfEcSh2shEhs0o6PqWZ2x9VdMaNJoZtKaIq
         N8Ne5H33jwjp4+82vYrQY8DvoPcY5kJkvqL6K+S2QejZ6bE8BNPo9/qW1MAeg5yeKufx
         cViox/YzxHXIyKKrRIhjPPyFbIrgXje323D2mqeTPivjheScWh8HjfHZq4Sn+b6wXWyP
         EGUdZ0qgSzkC6i8NZCquYQFXrOJVVZ2++ILsmylRTwc0rAzSeQjhlIRjRNr9hONTw2mr
         8oQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773237561; x=1773842361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPOPtFUqlstAzruiSZyXiMnwzSiIuIi5KKsAasJI+Fs=;
        b=VUd/VW+gc6/88OkN/4kngwvrJBVkVPDWb2pEBFGMZFgCD3/kCaPoF6gSLbLkOJ3DcQ
         WRGZOZ55WSCRjKgLY2CMVGT2+PIeqeopCkF866GU1d2i5Lw7CmQxsYBwqJikSH1es5ZL
         bh4mxObKDIUrMpX2yohRjW0mFZSCrfZGjcVGjrWOHoDK5beSFwWvu6UgIjbLrt+OjsMV
         zwz01j6tuhCu5fLpZso0XjgVgwh/ryWYjCpRsAKY2vObfSVjcCLDnVN+j/XbQOQH3csl
         uauJamnS3cUkluEewRUmZ0+hCuQE04vwmDSh4nqXt1P9dNZuyRrZZ/5ktuiHr/bc5XW/
         rMwA==
X-Forwarded-Encrypted: i=1; AJvYcCUVQcupH2vX2GBNNSU2ytplI40XaLeH3YJ5bcYknLgfbc9BnYgKNA54wuQrQx8TdwMZMSzske8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq32cI9M/jzGAFstXh6w8e3j76/X8C1szPiUHobBac9Fi5lkiV
	+MTAMmX/f1HMlAXa3BAKwK02YMI/MVMIR7HRur2Ncr6n60hw3ssadjaq
X-Gm-Gg: ATEYQzyLJVPzFvRRAwXs8JObNXTsj5U5N2bPhZFQqppaAOC/UaYs+tDM/rjSxoiOxrh
	S8WRcNxN7H9N+Uu+8Q51MUBRs18Bm+pEJkFwXL30O0BrXxnyOWVXehbFHHcbJaA+cnt6N13yaTM
	xoqqt9xOUifWgYroWISZIogfH2jkhgSKhnnLw2Z2jQ5iU04VYPcmC5CATp+TufHIdEq6McyOpZa
	Px1tCzli+xYRUVNrZltfEyuQXa2Hrlx7ANPI6Tzop1G0EW8my1r6mSaeL/DMvGJqUk849L32iXy
	ppCeikiCQx1xbgf5Oyp2dKTFeXAZdQ3oHmLtSa8rkImd9s32tAiXa4w2fEhXkR/2dPgs/MsHsua
	S+Dh1WEfy3efnmJGf3hQFyP1pQxuBnner3TaXk4wSVzXSj2DsDg/mRRbgh1dz327yBxT30y05kj
	k4NxexePuTBUMcXg==
X-Received: by 2002:a05:600c:37c6:b0:485:385f:674d with SMTP id 5b1f17b1804b1-4854b10f586mr24611365e9.8.1773237561199;
        Wed, 11 Mar 2026 06:59:21 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d00a:e00:43cb:c21c:efe7:d225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854e2537c3sm24287555e9.15.2026.03.11.06.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 06:59:20 -0700 (PDT)
Date: Wed, 11 Mar 2026 15:59:18 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: Fix error path in PTP IRQ setup
Message-ID: <20260311135918.nvruxzwhlktqfaiq@skbuf>
References: <20260309-ksz-ptp-irq-fix-v1-1-757b3b985955@bootlin.com>
 <20260309-ksz-ptp-irq-fix-v1-1-757b3b985955@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-ksz-ptp-irq-fix-v1-1-757b3b985955@bootlin.com>
 <20260309-ksz-ptp-irq-fix-v1-1-757b3b985955@bootlin.com>

On Mon, Mar 09, 2026 at 02:15:43PM +0100, Bastien Curutchet (Schneider Electric) wrote:
> If request_threaded_irq() fails during the PTP message IRQ setup, the
> newly created IRQ mapping is never disposed. Indeed, the
> ksz_ptp_irq_setup()'s error path only frees the mappings that were
> successfully set up.
> 
> Dispose the newly created mapping if the associated
> request_threaded_irq() fails at setup.
> 
> Cc: stable@vger.kernel.org
> Fixes: d0b8fec8ae505 ("net: dsa: microchip: Fix symetry in ksz_ptp_msg_irq_{setup/free}()")
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
