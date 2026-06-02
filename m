Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857BA3DA7DC
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409237; cv=none; b=awNPp4HZA/1zsVji5Dm8mdK4I54wqqaCtuwRyh3h6JmL6fNs4uIBxqXjACHhAmrVH48isX3fN+p9WUmLCXp0ILo8vQK2Rte3zOwT4KIHpQ/f7iqkUj9QmC/2R/FLoYsOYEPCpmejHFoeEII60RtU3PXSl5TPOlulDq9b7YwZIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409237; c=relaxed/simple;
	bh=llc5H9WBHGaxlcUbzKdk4lxBlagtHnWVxD05or7i6o0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoaJG7XJD8ZJ21T55EwRVV1FLaIkta4ioznJX5pmGsezDcxx16YkDmBNnNqwrE3fZo1eYMD3Y5mCW3K099TRSRrNiJBRMp73jR+bs+GbSLmGc7Q7CCm9NB6olhm9q41M1U3gYq2DdsH8M285j2DbxeKOBzC9FROBL3KUUfyETN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbkPcLak; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbkPcLak"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49068493267so66115885e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 07:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780409235; x=1781014035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySKFRHOtwilW2CZ876p5LxsR0YIkNmJvgodgRlHIUfo=;
        b=RbkPcLakCPipOO7j1h1DnMZ4888DX4wyESYSAl5TjMk0uQ5400EuSAcXs4S82+NvFk
         8uC79L/jKF6So23jtLL7Lq97W1jMIFqDLGG7gJJ5LC1aUCBLG9YPOmLD8/dcTkPS/HRz
         SK4XbIHl8q2HylV4ppb3afi6y3a4ZcMYBLd/YxiQiRveUtQZ0qR31vDQ9scSdMG2B2CI
         RcetsBPvNkxZJkRKruyhg6I0GdZRUFXD3C3bAUbRmL0mxoo4UtjojhqECaR2tpCj6q6N
         NQpZ36vdOGF1FEaHBYirp8Fo0Rt2dcfa7AtBstDaugMdN3e8TW8SZlpf5IOEpxOf2jwn
         vYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780409235; x=1781014035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ySKFRHOtwilW2CZ876p5LxsR0YIkNmJvgodgRlHIUfo=;
        b=jA/G1dRRF895A3o6hqS948ePQT0bOV3LKOuZGqh7iXiZu7qeePX8BQfUYmTXTWOasP
         VUK68sP2Mmjrcx2TzG//AZxSb8vuZO3XuoNvyTqOO9X0CDjIz7XEYm3VcRUd3rZsZLZa
         aLVelEOtcJ4PJOt3VS8jP8AkPeQn3jqBKIET+WH5CaUlml9Ry8Xt683itErydqkmxelJ
         gh+NxIckKhqsYT3GDn0vzt33AyFxSFPeskY/DjzJa9IdTDjRi8VZ+nfNR5DO84kerrVI
         l0t4KYx9vHx45rbyaLbiOoXBd2ztXcZFXWUh7I2OJd93BbakwucvzWX0nUow6nsoqBVd
         v2lg==
X-Forwarded-Encrypted: i=1; AFNElJ8jgiqmLCd4cNzy5IKHQ9GlwuoVxghDLJ843RYtms2zrmUJqZe1L37K4XpUkIcOSTl110Or2ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YytYrF4SQHXGE24/JDFjWZumw2gUIEbRz0Onup/EdmQGkSzXwLT
	gbIwS0BeB7ENXLyaKQuKvlrizLrh8IfUVgCecK+eXYlpdPCx5xcne1p5
X-Gm-Gg: Acq92OFLHzfbmAouMsObW/3IMTmWuur+7np33S9+AGSMqquve91sY+kjqEfDzH11/3I
	P4X1cn1gBZTAUj1fWMGpSs53+gMwa99cMvrPGCgIHHVXD9qEbhReGFkRG9m8HRvcrEqI6B8YTlr
	vDX6yB7TOawZSWLu7J95a7R+Q4Kwooao0xnq9N6B7+75lk5ftpk3KeaBiFPm3Oe+6Twv5pScSfh
	EaYyktpCUXNGthKZjPIRkEXM2KafWQM0Ck9m55X/lSaGSsGbOqxvFE9K19GGfZBdjjzlzBmLUPe
	UEx/fc4pG63wO91avXv7kNI51mgq4UpIw5Jw0FKA/yIkqfP9YuyX5WAI/bzzvy4tU6nmvhf0kpI
	/xAe/8tuFxd3AbFEPFer0ZY0SS9XnOf5U3p6ZFxQUFH7roROAi6rrJU1FINv8qVBZlCWvpQpLQg
	V5DhPANUVNlEA8qPfEoK0flr815AcZFoPny+6x5LKBA0ECGybEv1sPUftbVkuFx3PxHD+8sno=
X-Received: by 2002:a05:600c:2a8a:b0:490:44eb:c1ec with SMTP id 5b1f17b1804b1-490a293cf3bmr198249765e9.27.1780409234775;
        Tue, 02 Jun 2026 07:07:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354bb62sm32057112f8f.19.2026.06.02.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:07:14 -0700 (PDT)
Date: Tue, 2 Jun 2026 15:07:12 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>, Piergiorgio Beruto
 <Pier.Beruto@onsemi.com>, "parthiban.veerasooran@microchip.com"
 <parthiban.veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS
 size in RX frame
Message-ID: <20260602150712.5b28d58b@pumpkin>
In-Reply-To: <cf87ad90-6ba4-4132-a1eb-beedd796c168@lunn.ch>
References: <CY8PR02MB9249644F900471DB8417134683162@CY8PR02MB9249.namprd02.prod.outlook.com>
	<cf87ad90-6ba4-4132-a1eb-beedd796c168@lunn.ch>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 May 2026 16:50:35 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, May 29, 2026 at 06:41:00PM +0000, Selvamani Rajagopal wrote:
> > When MAC-PHY appends FCS to the incoming frame, FCS,
> > it is removed from the frame before passing it to the stack.  

If the MAC appends the FCS to an incoming frame it must be removed
before passing the frame into the stack.

> 
> What is missing from this commit message is an answer to the question
> "Why?". Does the stack do something wrong if there is a FCS at the end
> of the frame?

Unexpected padding ought to be an error.
If anything tries to parse LLC frames (with a length not an ethertype)
then padding is only expected on short frames.

Even for IP a frame with an length that is otherwise too short
might pick up the crc bytes as valid data instead of it being
discarded as invalid.

More of a question is why request the MAC append the FCS at all.
You can use it for error correction - but no one every does.
(A 2k frame has 32-14=18 crc bits for each bit offset which means
you have an 'average chance' of finding an 18bit error burst that
will fix every crc error. If you find an 8bit burst error that matches
the crc error there is a reasonable chance it is what caused the error.
Single error bursts are the most likely errors and easy to locate.)

-- David

> 
>    Andrew
> 

