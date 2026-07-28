Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7594746B5
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270017; cv=none; b=cwkeuMEIuwNJ97iZ2f8eB1qHDtGUsm3YntMTIFa13BOkPyXBlPEwiEK00zggg92M30wovb1QaNSkMIbg+fxufIufobFDAjkrDUZbTJSLUeXamdzGRxhizunraIJEwRbMLHJKn/IkWlwx4qJpRa+pfuG6kOR1lW9S3PPGuioMhVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270017; c=relaxed/simple;
	bh=D+nhhvv1218VgidFbo/0YwnGXRqEXjLG+fgEDathqdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMz2vNiP4T3K+RudmaHKafka+pdmeo0YQ0seey4WUR2x90J3CksysHTz0s5wZz1y0KE7s3QTOWiqm96XnDozUDbQ9bcaeEt3e0PDbeXB/9ZRO6BenlyVuIBcu0oMaOSzKltP2wklYUBDGZuMhbiTEIuE43fFQCauLNQAGFwT44w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=CL7JyGBW; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="CL7JyGBW"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca957432c7fso122211a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785270014; x=1785874814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LOhzP2d286DYx7eoihTbEFJ8xtMuw9JwJBNd7fuXhcc=;
        b=CL7JyGBWDmMgGuPbLN68VxS0fJxh42fJkHlbjfmuudGg7Oaj8cphoriHl4j/fRqo5f
         WHD+pLzbFuMatYtqR7j6CZRhytKt7pFONXy5pJQ8ASnEXoVysgSBBp01k+YTn9ZHHGWy
         NdKIs+KDrJ84Kg/742+WtDHFuk2m2MySEPNHVh2T9PhwJvUvU5Fhj24TJVNyXrZzRtCv
         GGvwVz8pzse4o/Sv+XVYCqm5Qz+XSSaUimpKkx4GexPrHERYdsviDyGobpx8I8CF7dX8
         35R1S3W7JV3EIqEbTXhy0pOR8VhPG7fj5GEqm204QpoESc95W8968u3gnGM2I8roQrqh
         BXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785270014; x=1785874814;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LOhzP2d286DYx7eoihTbEFJ8xtMuw9JwJBNd7fuXhcc=;
        b=fxg4ZCBXo6RcEdTRL7ofZ7dVbe+8Y2+g6YZsW8Eene2ELwoFw29hQGh89vq5G7Z5cN
         Xk8W0YdHUG+MXaJlwauS9GuB0ca7bd3iVPakXEz3wuEQqKDX30Eep7DYfwlzFdF3dbqY
         Wh98FyA7dPgM1nOIrI29v4q58ma9+Yxir23GsmwoTbcjyrEidmLa8irDqURuB85W0ZnI
         ExlBOTlNxwowkMpzguKBJ6gTlx42I8Ec+eglDJvngmASz7OqBtgHCN7Ui989lK54xrXR
         N4VnJJna/UvPjZW3obNb6XrE3qeZA4c+FNIIKIwJ/l8W/W8mdeHALUXK7OHW+QlKYDuE
         F8Pg==
X-Gm-Message-State: AOJu0YxjgG6yQZhBUhdL7HQJOvwiooDOl0w15HIEtwCxhf6KDsqdPEsg
	wsQfgb3qFKdx+MF6+t3+VJExb3+OJfJZ3KTy18fUMx6k7dasfd4eqDXLt6JKz7k9Og9hDiNA2jV
	wS+ip
X-Gm-Gg: AR+sD10LQsr2p/QsPFn2qkBFKCpxwf2sk2cKOe2orRuJ3viuIOiKLRhg6Hrdn0aZ8Xz
	N8iR9cvyBj7R/2xrSqz5tKicAdp7oj7CkurIRlsAHbaQi2s/B8IYcw841h1FYXvS1e8KBlzl4q/
	UX9dxVrNcE/kK4WtNlpy9mTWjERfXm8O3vM/1BUka18dLWkMsemFzO0umVEC0eVxnrukrAotvGI
	LAjvg9eC1pfk/kSXpfiiHlSYvPQijM7gHdm7EIxf7n4PACktIIKM6Ee1ghEw+eLO/RkxVhzKm/o
	9PT4XXy9shFTOhdWdpv9fZ6pRrP/tEG6BKA5bqRrQ9Y4xDaAMyEUtIbli2WZ0GKassgMHpSbNlZ
	DUHRKTQYBZbydm9pylLr3/xx+fKe5+oJUVipL92BTDMzOOqvifV1WZ6SPLVfJieGxbdj8dy4o1y
	YTdZUOA+SlhTI7LQJyAgVZYVMIZMrEXLvoummiRamtHOY=
X-Received: by 2002:a05:6a20:430a:b0:3c3:7dfd:22be with SMTP id adf61e73a8af0-3c8ba5ad552mr4945628637.53.1785270014186;
        Tue, 28 Jul 2026 13:20:14 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e72643a12sm2873241c88.5.2026.07.28.13.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:20:13 -0700 (PDT)
Date: Tue, 28 Jul 2026 13:20:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: John McAndrew <jmcandrew.nc@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Vulnerability Report: iproute2-6.19.0 Stack Buffer Overflow in
 print_queuelen (CWE-120)
Message-ID: <20260728132010.756efcaf@phoenix.local>
In-Reply-To: <CADCQVCg_ppRbJfmE5QDS0kDwwfMLGKDn7q8V+rbs0_=HCmbbsg@mail.gmail.com>
References: <CADCQVCg_ppRbJfmE5QDS0kDwwfMLGKDn7q8V+rbs0_=HCmbbsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 16:03:16 -0400
John McAndrew <jmcandrew.nc@gmail.com> wrote:

> Dear iproute2 Maintainers,
> 
> I have discovered a critical stack buffer overflow vulnerability in
> iproute2 version 6.19.0
> in the print_queuelen() function (ip/ipaddress.c:173).

Hardly a vulnerability. If attacker can control the kernel and feed
bogus data to iproute you are already pawned.

