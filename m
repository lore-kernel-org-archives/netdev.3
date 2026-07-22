Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5D33E5578
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753782; cv=pass; b=kl/WmVoNbszUUn7RilTrgDFq3IeEOgpD65LUYVlUtM2yowS3VnDc2QNb4D0hLv1ZSZxAS+fcIQsvPRIhkWEgg9EP7v3TQPSd+2tJoD0Rwc1GwaffUk6G3YjOFTqVylHBkdkXvK+07P7ILhGMU0IxVgG4Sf9T9GR/oYpGRUXivho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753782; c=relaxed/simple;
	bh=0MTbgq1KWJc+1GNluOa1ST11CPqFKW1ipwKVFiUVMh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyQl2FRSjMu4JoZA9JcX51ThrTHohFVfTVI9YCbxTJNnW6OAFJo2g/Hfq2fm4eipSot9tW5iRH0vF6P0Mms9JMMXS59uabC7+a3ZnNejbuxoQyS5f8TcMf0jPJ2ma5nnFGl+i94ytaJLwsqTPLT+JPtKoG5dKCxlTMFQTGz9CXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUDE5mQ2; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUDE5mQ2"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495509b08ebso225e9.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784753779; cv=none;
        d=google.com; s=arc-20260327;
        b=qLIwMJDU0p/ub0k69tCisNspNAJjljXXAa9rXdlWZy+ZWk7TMXtJwFTMzslhrB3iX1
         opvcoJJwmgj1cKv+T61PbMSzUo7D6uhjk3a4ihiulCK/qjk6BafYuiVgDDHnFM2aRzfw
         ASYau1p529p57aMOhQzmrrV9k9o4vvnixc5RFJYC8BrVHQQCD4FPZUd0RoXpisj+qjtq
         nLLyQOYCQsX+pd96QNSO/p3NX0mDgV1+5P2wmHRcQLELfUNFMc+cbRo2roCPqZzowsEq
         WlGo1i4wzQ9nX30lUQSzmTW8ArT6of1ZyEgg7jmJghxSY/wzDc0op9Mp4PxMXRmNT/7d
         CowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0MTbgq1KWJc+1GNluOa1ST11CPqFKW1ipwKVFiUVMh0=;
        fh=Vs+2hdi6g1h9AqT1eb7QYmZlqMG5O6wk1EqtC+aZ9d8=;
        b=gRQYJOhXcNgqFwJUrqeBpoMrxLuDXtXbJPqyuZ7aINmHVHEAMdFNptOgQPkiL6RWqq
         lWVn4VXSqxR7sWUyp4QVo/eR1s6k2lY8bv/1o3nzr3LWFdxAo/ukSr7izABobb5uGf+T
         Yf647Et47piYd1SIqHhYRvrohns0MRFJIpqMfOPkWl7qi7bpMCMsMkjrJ8Eqf27gOwOM
         2wto8U7lstr5s29qL801QbVjftTiptcmDC8OKwZRNNtVwAQgywY3CRHXQMFET58bGAvs
         nHCOagHLBh6DUG/aDBxzmR5LkFlhZ6XIgaQRvPVmOMQ7HrYiDLPjilY7NxBW8evjozS4
         9hqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784753779; x=1785358579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0MTbgq1KWJc+1GNluOa1ST11CPqFKW1ipwKVFiUVMh0=;
        b=jUDE5mQ2pt7iMN2CLkjDAkjGNG21X0vrsGDxpguPwAfu92TDlVqdLXgeHtkCkNBToU
         AhMhG1MzMS7WZcOnNXlfqd32h3I9kAwpdUJ4xeHJzcAm4cfZ2Fg2gEx7OKBlscPmiq++
         o0Uw1Qj2jUGYLRXEWV8jKrgj0tRIlzQU2y5nPvCRRFm2qZ9LDJx3AkjL5Ib4Gpqsv45z
         r0UJXHoAzxMvtEdbsY1D9qkE/vtHtg+/gp9dndVd/S34AuujFUdAmHrLfYgK1azwd6fJ
         OWuPgLdZ1IGCswo3dTkSr82VDUoWNCTSXQitWzUstUL3EaMfpRc1tKDTuIIKQ9kiTJf/
         XYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753779; x=1785358579;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0MTbgq1KWJc+1GNluOa1ST11CPqFKW1ipwKVFiUVMh0=;
        b=O1M/bL4xEIHKBellIal7e3HZ+sgN3MzQ2iS01hGDDPYagvIVkLr50mm2iAbevVfqPN
         7mbd2xWWN8rl2l7DRJmBzcc65w5nK5UdAV8n8rNBV9d3JCv3wbwA6+zDQr+25/B3VCe5
         E/C3458Py5exTMqPa8vaMqAC0zHhIK9Zf3H3Q6WT/YE+AOAIM6qvnvCVeFfNwPse4wI8
         /Xmj2iugHSRcfd7D0sc4nAB7ecISbqbhKS3pVOEclYwm0W9bwP4sD+K5qF/WPb+qrOmP
         PEzQO5rwNWaEEDzaRIP+s3iqjYrwKn7Av8g80+PMJEKIKpXQrt6bSeXMp1edV4SKclyK
         GpVA==
X-Forwarded-Encrypted: i=1; AHgh+Rpb1F9bpmlHnNlnOzy8UGShiBLEmrYt/O5pYhjK7fIKmczbNnRo8+WjXiuAAhdxOtTYQ/EFS3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLKS4Ul3UpAUEwA8Rg07MryxvcAfy72GMXmYHwblVG8sxs7D0E
	qt2jCV4i2HEz6WaARPm30Uz39zUoyP4R1LbjJ3lM1IwK8OVum5m7kTzkmvv/PlyDEOGoqyQd8u4
	csI/emsgZ9XKK+4fhUxx3lVUlF3LhwDkNvv7xWTrD
X-Gm-Gg: AR+sD11QkJKmTYeJZKW0L7YDL9YuijFOxlE5O7uT+hx/0w6iunwhTGxBsU/0UXTyDsG
	lJn5t6DT1rqIl/4/5YAS2c4YV47yot2COrB4NaehQaFBZGGmC0O4veBQX+y9iwQkdhRtwJjwcu+
	QzOT6DmriAEzAKQ15hvve1bThEYv+Npkfvw/OGGKwHyeUkBNz8zzuAwcolRIXosi6bqcMxpMfrb
	/Ph05Gxzg9AVF/91XtFWMcGU25+VB/pQ/2yVKAQ/YdE6TXZAU1zEKrV1zj1lFH8W6UfNmcZw7C7
	7n3tPuIoNubI+csNHapuUcY5Kmy88gLYnNOpVXSl71WtMQ==
X-Received: by 2002:a05:600c:5691:b0:48a:5618:b4d4 with SMTP id
 5b1f17b1804b1-49573dc9ae6mr112305e9.1.1784753778589; Wed, 22 Jul 2026
 13:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701192210.2997769-1-tjmercier@google.com>
 <akbPrI67h5btdI44@devvm29614.prn0.facebook.com> <CABdmKX0-tubji_pBiaZbePrxVLA9qkw5ez61wyzjDz8-pko9SQ@mail.gmail.com>
 <20260720161052.394687f2@kernel.org>
In-Reply-To: <20260720161052.394687f2@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 22 Jul 2026 13:56:06 -0700
X-Gm-Features: AUfX_myw4NptciZFfZOOPBu4oBVvGbQZBM1IcnixNVaCyjE3vDvwDLKrGe7BnIM
Message-ID: <CABdmKX3EkDdauF4mPaU2B=5Sfas1q4W9NbPi-1nC1-4N-yhb2g@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: Open /dev/udmabuf O_RDONLY
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, kraxel@redhat.com, vivek.kasireddy@intel.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 4:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 17 Jul 2026 09:29:40 -0700 T.J. Mercier wrote:
> > > Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> >
> > Thanks Bobby.
> >
> > Shuah, would you mind picking this up?
>
>
> Please split the networking part off, networking selftests must go via
> networking trees.

Ack, done here:
https://lore.kernel.org/all/20260722205442.1894665-1-tjmercier@google.com/
