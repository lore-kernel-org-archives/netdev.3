Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871244949FA
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714728; cv=none; b=ZIgeTrPVQ5opAgEQSvnXSqa/vNocFyLcSKz4+SIJidSHAeCJalCyWexIolt/3/oN/oUcUsGSex9kqYknbUxturU4dNNIUM3/Jt/CqzRxgh17I4PiDEneDbLgzEMQ7UMzajUAuog5owPa8e1+pA3WXQFAshAhMRsG4h6KwJSDklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714728; c=relaxed/simple;
	bh=GFOQA5ZaYIdLp7nDVuoMcdf1Qjw6plAGcxortgT6azo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2EcFOZam5/vGBDkgriCqEGGK+NHtjzi4sudmXP2e7c+UWF1fzC9YVyUlQfAbrmhlYhlIITS6mzlCqVia+SnoQ+xSV4iBVA5Gmn1/ObtqU9QMVrx/YTelzHqR4qaCuy6tDkLtj5RGtlcQon8qZxxyOrCFIgMgF0X3Tfg774hGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoSPkqgq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoSPkqgq"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47db714766aso3451196f8f.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784714725; x=1785319525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KMj9zc3x6l5zmOsetNs8oaLqxVKGtYD0hQY1boXGGc8=;
        b=FoSPkqgqMoWg1IC51NgGXYnL/YOjeOJ/+XXygkEsKAoZIstqxygamqXIo+ZWkPhZQc
         ZeOwa4ihJlvmng/lVJDmwAXW9b0dGX+ft/1uNtnW0uPcOBGNOUlgnzDyHe5cKnhHw8ND
         ozHUYwmgV+pm2jmbFWhzsOVJgJ6R2H8P51K+ILlefStMdsswp2jzx2SY6gWGTrSk4hH5
         D3hXgMh6Vd23g8MxKthhhxrDMowNA1NZUbgymlNOCqYwhs+sPT1Q+Qbr0HZBVwjRNi5+
         Wit7IukaQdZtGCUYTG13opK9UJi+okvXESBNvcSQuAM2zZuWu/hGnkSAo/8UygP+sO1J
         7vfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784714725; x=1785319525;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KMj9zc3x6l5zmOsetNs8oaLqxVKGtYD0hQY1boXGGc8=;
        b=jjf4HOKRSFFmyrU0fZHAoWLgjo/JEUIHIHlpnrtSGUlsvjq0DUIrUPtUZpSqREGiuy
         YCLIVt4zDYlnJ1tfAMfILDbJPJeD42C1mO6xuMRjLsv3/7WZeirHfBTjWtR5hf9sDcam
         v8iCUDJR7rqcUb8uaHwO0TlYIS3Ak795fGa5B2OyaexMUd9D0yfvIZrCWczR/eIbYUEC
         48itSquBFrjXx/MvYragOe58hAnhLrwfYaiaFXTGpDE2orAncUCZiUGBMRKv1iYywGRj
         reiAAHubXwdA2H6383oFfeb8ml/6nwGG655pmswEMyZv4XmYDhTuWWa/Q7h1fgIjDISb
         wU7A==
X-Forwarded-Encrypted: i=1; AHgh+Ro/DHPXSmBJSgX/3hh3GNbJSC8E7ADdwy2KXulvBi0QwjcTp1zD4omGssvZzhEIpUPJ6ikW4zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT3nNvDn6sWtn2XLB3IifFdWHP09tNWVpgQ0KBw3CggyoNqZfa
	2ctNTInp2yO28YO+eXWXT7quU3IP2eRjjvuXL15R9rwQ7kAwsn80tIQU
X-Gm-Gg: AR+sD10t2QPELGTkdW5MMeGAyPD6r7+2wxSqylarwUrp1cdHva7/lb5G+oAhSQQKhS1
	sW7wVxmoxLdUruPky6qBi211cSsS0yLcBQxow5pIosWtk2bF/nfl3jggGDB4GOhBUDAFeeqBXGA
	AOODkAmin31MPblis0BXjq98BYBPzZgtVW/kZPlDyqVBJp27afEm2KdsBlehDLBqKvacJSQNMvS
	pZiv7ebvhppTDQnkzBdTHKIrjW1Tgx5auvFp1l/BT2HlLZ0Qf8gmbhLDeyUgLU9H8HJ79gUVvpW
	0UN7s90rzk36TuOe1WwOwWZv6BBNM0uMABRRemJurmsqxXGOTAgOzpmW4CJnFrxIC1Zo5Jo3yMM
	HXodycRd+DEHfjeWnObgairWQu86nRbaq5I6ljKSgMlKG1ruFLuVrbH6S0UqACiOF5rCtOlkQfr
	0oPyOOA57TsHarLgiET71iyBurTxNDaeeJbn3s7jYCWAdxetWM2Q==
X-Received: by 2002:a05:6000:25ef:b0:47f:7c8a:ede with SMTP id ffacd0b85a97d-47f840a007fmr4146900f8f.5.1784714724465;
        Wed, 22 Jul 2026 03:05:24 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bdac28sm4582498f8f.16.2026.07.22.03.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:05:23 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:05:22 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "John Ericson" <mail@johnericson.me>
Cc: "Kuniyuki Iwashima" <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Cong Wang"
 <cwang@multikernel.io>, "Simon Horman" <horms@kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, "David Rheinsberg" <david@readahead.eu>,
 "Andy Lutomirski" <luto@kernel.org>, "Sergei Zimmerman"
 <sergei@zimmerman.foo>, "network dev" <netdev@vger.kernel.org>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, =?UTF-8?B?R8O8?=
 =?UTF-8?B?bnRoZXI=?= Noack <gnoack@google.com>, "Paul Moore"
 <paul@paul-moore.com>, linux-security-module@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: unix_stream_connect and socket address resolution
Message-ID: <20260722110522.710ced10@pumpkin>
In-Reply-To: <9c437c7c-7919-41e2-9161-fc94803a9b34@app.fastmail.com>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
	<20260703073948.2541875-3-John.Ericson@Obsidian.Systems>
	<e6f54c5b-2c92-4772-b2f9-5c21e2ec50a9@app.fastmail.com>
	<20260718215855.07284fb1@pumpkin>
	<85991dc3-6fa5-4466-a0cb-b407291cdb44@app.fastmail.com>
	<9c437c7c-7919-41e2-9161-fc94803a9b34@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 16:37:07 -0400
"John Ericson" <mail@johnericson.me> wrote:

> In case this is useful or interesting to anyone, I deep a some history
> spelunking, and the restart logic in question seems to date back to
> Import 2.2.4pre6:
> 
> https://github.com/tbodt/linux-history/commit/7d4fc34b9bbc0a14d3e5f6b2f978373422e1ca8a#diff-0553d076c243e06ae312480cb8cb52f1cebe1d80fc099d3842593e12c9e0d4f3
> 
> ---
> @@ -673,9 +703,25 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>  	   we will have to recheck all again in any case.
>  	 */
>  
> +restart:
>  	/*  Find listening sock */
>  	other=unix_find_other(sunaddr, addr_len, sk->type, hash, &err);
>  
> +	if (!other)
> +		return -ECONNREFUSED;
> +
> +	while (other->ack_backlog >= other->max_ack_backlog) {
> +		unix_unlock(other);

This unlocks the socket - I doubt it makes sense to sleep with it locked.

> +		if (other->dead || other->state != TCP_LISTEN)
> +			return -ECONNREFUSED;

Those look like potential UAF.
Hopefully changed in the current code!

> +		if (flags & O_NONBLOCK)
> +			return -EAGAIN;
> +		interruptible_sleep_on(&unix_ack_wqueue);
> +		if (signal_pending(current))
> +			return -ERESTARTSYS;
> +		goto restart;

Since 'other' was unlocked the search must be repated.

	David

> +        }
> +
>  	/* create new sock for complete connection */
>  	newsk = unix_create1(NULL, 1);
>  
> @@ -704,7 +750,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>  
>  	/* Check that listener is in valid state. */
>  	err = -ECONNREFUSED;
> -	if (other == NULL || other->dead || other->state != TCP_LISTEN)
> +	if (other->dead || other->state != TCP_LISTEN)
>  		goto out;
>  
>  	err = -ENOMEM;
> ---
> 
> My question can be basically restated: why should the `restart` label
> not go *after* the `unix_find_other` call?
> 
> Cheers,
> 
> John
> 

