Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13CB28B4E2
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 02:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604780; cv=none; b=hPsc46Ij9YDX4OKAhIhFUfo3GTk92md1eDQBu35OBHQvrryMHc4FzW5N3lh4w1js/yS/aWTHnHYBU+kNyPpercTIK83EiIeTaHQMIHIN+pa12AM1BQNcntTR/laXx8CNoBKwtBpVTbejCD4CC62cmjiA64Ykd5wwl0ksefh/efw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604780; c=relaxed/simple;
	bh=Dyqcoo3l1nUDiS2sC0rr3LvrOLDTeVtTXp4q+Se3w7U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Bi4KFrbFXWzgz5IaymNc2pHzZdxNsXVoDhwcXucgflPhwhUrLM4oSD1thnK2BER9T1ei/e+41UWa2jQ08rCn+Dtkp0huiMG/M+6WGG97BMRWCaypQVjYemaKhRrDkwqRPIAYRhYmNOM0oEAPA5wbfKHqgqdlSRpLcRNjZ9tg0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iW0JAQoN; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iW0JAQoN"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7961e04355cso22837847b3.3
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 18:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770604779; x=1771209579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzmTmGA9U4NoHGqPknBLmfObKJ7TSgXNKWJaNi5i9mw=;
        b=iW0JAQoNEjyVIt74uTX6YEW8f7CawiIJI5+TOTQzZ3PZPjMfo25MyJXUbCp3qDhS+v
         On2NKGbWV/F3TsJQ0D8S90E7d+TohOYO4tJyFjOkUzJyMHVmoYtc7d/USggQmlJdX8yF
         +6tD2m+SjUtiSyNk485wE749yreVi5GJoBg+t9dkQ11/jZcq8D4h53O5wUWwJZQvS2/D
         N7DajpFHf9VlW/2uXoOs1B4gNW3bDQJHdPSeb3RM5O0LZ8gH+1e+h0fYp9xdv53Mm6bP
         ngwsrbs+Ko8JHMH8133mY8Ino9beAIQiH65FMoGvemrdBmQ3j9HFC09EEcAmf7dl39wn
         d6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770604779; x=1771209579;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzmTmGA9U4NoHGqPknBLmfObKJ7TSgXNKWJaNi5i9mw=;
        b=woN8EFo448GdJozP7KSjIOIdyu+IVVzwswHdA1ohe9Etjpvm2divQwop8fcQ4gZK2E
         SsyCffvENT76emA/1+Ka1uh15D3jTAkknGC+i/sKFtqeANtRVpN95BjNhG0T0zRJ7dP9
         PsUL6ZTZcdJpxNSubAKWfKVHrXLl6/AZUphBgNQM/03nMjwhsacIgm5CQ0xnquQksVQW
         82pmvMiVBZC7wz3Xqo69y84A/LaCsRUSnFg1ms9tRxREY/2ORD6eMsvnmA1q8uDj0rbD
         ZZnnDqlyzc4x4Ae/eW9r5kRmXY/FFUfKshL4/WcsPoRFrStGiaebOXLh/bsuhyG9bU8i
         QnaA==
X-Gm-Message-State: AOJu0YxZZVwyALGtfaldEyiiRe/FUNkm8xhA9/Fr3Sp0fhXaJf0+IauR
	utlmWJhE+Rpj760NVq6diExB8d3oCtn03N6sgv4jtlTiO1XTQo6GeFSX
X-Gm-Gg: AZuq6aLcOEkrk4Ls6LgL/FsRFpwPQWqDxhtHUFsiKFpR547CKLoI5o5QVrclDqKI3t8
	ZwHUKzzIzvf6ne/F78Jehkyp+igeCYD7tLPCQT/lvfCTjfgoNdiCyElzrK4TbZJ4xWDTRCouuey
	N/Ig2Xyp5HtGvgFn8tcrpgCNjVT+u0KPJB0wzHSXHHKnpvFp55Uiqliv9gy0H5c6AQXxlVrVRho
	241dKXc5jj8T7LsrarKTlAzqZc6ix6nBz3Oe+wIAkVVX4NMW1WyM78+qZwNgrpS7r+05Akgbw+B
	9cocwTNM9b9NGLfQ+ARNq2CG0qwV6KKp+jsGc4MBgiqZJE3yUVUm0hjOpcgRkp/jKThzdsAmVgr
	KlQKPk1ngGctgFz/kdJ7FNIxnhRPaZD2ZuOUzQlj5p7kWmoeRmoeF0UkBA3mkRLbs0EEPezkkXk
	WrJ1L70lHUWWe9MnE0VetwtCPVV6knIXAH6eSKIf+Q1T/Lst73CiBPrx56CFU=
X-Received: by 2002:a05:690c:9b0a:b0:795:616:434e with SMTP id 00721157ae682-7952aa91578mr105276447b3.16.1770604778920;
        Sun, 08 Feb 2026 18:39:38 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7952a1d9b38sm80237017b3.27.2026.02.08.18.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 18:39:38 -0800 (PST)
Date: Sun, 08 Feb 2026 21:39:38 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 donald.hunter@gmail.com, 
 michael.chan@broadcom.com, 
 pavan.chebbi@broadcom.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.743811e01cc@gmail.com>
In-Reply-To: <20260207003509.3927744-7-kuba@kernel.org>
References: <20260207003509.3927744-1-kuba@kernel.org>
 <20260207003509.3927744-7-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 6/9] selftests: drv-net: gro: use SO_TXTIME to
 schedule packets together
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Longer packet sequence tests are quite flaky when the test is run
> over a real network. Try to avoid at least the jitter on the sender
> side by scheduling all the packets to be sent at once using SO_TXTIME.
> Use hardcoded tx time of 5msec in the future. In my test increasing
> this time past 2msec makes no difference so 5msec is plenty of margin.
> Since we now expect more output buffering make sure to raise SNDBUF.
> 
> Experimenting with long sequences I see frequent failures when sending
> 200 packets, only 50-100 packets get coalesced. With this change
> up to 1000 packets get coalesced relatively reliably.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Does this require having FQ installed? I don't see any qdisc config
in the GRO test.
