Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B326ED3D
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778938871; cv=none; b=jSN+jBAtq+kDK0NwIRxMN8mxMKl0N1nqS9q9LKuIuahsDpsW+MXWK0PuoJrFKAgH01RhRIsgrYPTOfPux8PzbCoExxqiGdv38T6v8h5uJ+h/+wTN/lxnZcHAWpCPV0gMQeolx7l0mH6QeV5sGsC13jwZctGfBz70VgIhlxvRP+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778938871; c=relaxed/simple;
	bh=WCt3b50bTtKkZzsevKEsc9yR17Tz2MFXOfcS5e01mXY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kLdsHWG1/jQRJ1NUQnNrmwz0ahZ08lYL9wExI0ydh1DJBKTyrZsWbbQhln8Pxb32Qmy2/VloMytW6aRfG2kKJC0EF+04yOBaXdbtzCy2NraPG7Ct3q1kLkbk2Y2+Bu0kLwupoB2dmHoUvEkRNr2F/UEpSOpzbnLtqoE+xSsULFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEMZFeD1; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEMZFeD1"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65e39d1dd38so332080d50.3
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 06:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778938869; x=1779543669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEODD4rDv7CreJ46zyM98ddmC9t8jMACKmlZWxM6fIE=;
        b=IEMZFeD1rNY78/ei0gTrbrnIi52VkecjBvNC26g/9EecrAaTnmS0Bza0L4W8t2jCAl
         cQ3N+PcsIFWfS9S5IAAbdDfXAgWHNhVODCIkZWTrNUkBI246Zgj7hWRyXza6ND8obgYP
         sUIFdfHAekc6GORGW7b/t1f/OoTytfMAVszcalRyNEJ19xWlcJXZr8RJ0feWD92UvTdl
         sMyp1Tm9NK7/PIGqK3gx61NzyIhZ5uN/jFXK3CruIMgN/BFuQFIi+r/KI+AT32758J5m
         YOTfsHsdVjRc1nleVPMqqFnLZ8h9ycKXSEdMOB/VwI488qK7SOZiC7m7cS3Gf14fgsiA
         fAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778938869; x=1779543669;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pEODD4rDv7CreJ46zyM98ddmC9t8jMACKmlZWxM6fIE=;
        b=c2HW7qbIkxicgxSxtqa0dS4Hidjt0JViwQEL89HPiM0fga0TSQ7mQftRkLCLoGOiJu
         EKUPU+ysFUVmFoq243SSgzBV9RCpVKt/IfbbL7TfAorbalTtLMrl7IE/d4UbSoSfMElT
         e44HYQO4KSIKbsT+w5zBQVvGrWChyqVPSIvSz5GcHYeV4dOQC3rEil5kcz+x2LuXYrc3
         cTbu5TTAh4zHOAIZq8IS0BBD9i9GVrMiyE1CrHjJZvHLorV3OHnwmHQ0iqFHDfpzC6gi
         01RIq+32hlQtD7aafDMHomH1Bkl4q3cbfwTzh9Q4dZxgwwJ6L4WJx+XV0PYyIg3vyole
         Zh1g==
X-Forwarded-Encrypted: i=1; AFNElJ+Mju4AZnZnKBDm274rtbbm8RiWZvHnkhVDtiPXYsNNvrI8BkjLQlcNNHhNdkBOgXoC1qC7e4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy+VF8FF+fahGH4laJ/nGAAtxTvKmTJaDGR2vdWSPBBNTsjco0
	WnYp/IS7vjOvMWbCnZsLfVwxgxVX3JET9Z9az8j1xGeoqKYf7vWxUnMs
X-Gm-Gg: Acq92OHV8YjDFkAtNjLv9+Mbi6+ODAhGCgKoHZdfMKhCVaT23w2t0r+zyvG3EPwdBHg
	cbuf6oC+I4rmDHW5Alz0M47/KUsLL8P8vC55TwOW+tKt7ZtslPThRDFq9o4KCqwXM0Hx00bEjXm
	R6ENZEEnFLDpLmaCWSA3Dz2xLQlLKBOUbAxc7P467UMEl9P7sDNDi1i7qpgcyjzwoxZoeVNla7H
	+zC9sSChPdO6LR0TpJ6NxBAefObbRE1DdqcVAkNJUmCtwIKVX//mwv6a2KXQK7GZfQ/BSdFIfOM
	2NXfiAVmB3x99ErDRpetZKeA7rIOqxsH3SCTbPCOKO2s205ouV2wCyy0rNLb6cTEDau9dUdFFLg
	fBqZE/BgZe0ecs3aVRuYglYLQCLKI49fVNcGe9dRHVqVFZx5n0lOoM1D9jeFJ1kPG0yf7d1Y+pb
	dlu14Pb9HGo7khClNX60ccYz/sNzI7jgErtDtbei7v8xvtPozm4fojpB0tnrvSZKMf8+9Iitm0V
	iij
X-Received: by 2002:a05:690c:6081:b0:79a:daf7:c4fb with SMTP id 00721157ae682-7c95c6f6c02mr86221947b3.50.1778938869570;
        Sat, 16 May 2026 06:41:09 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f54c29ddsm44414217b3.34.2026.05.16.06.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 06:41:07 -0700 (PDT)
Date: Sat, 16 May 2026 09:41:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Qi Tang <tpluszz77@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1c02e791312d@gmail.com>
In-Reply-To: <20260515175522.0aafbfb4@kernel.org>
References: <20260514035802.1540395-1-tpluszz77@gmail.com>
 <20260515175522.0aafbfb4@kernel.org>
Subject: Re: [PATCH net v4] ipv6: validate extension header length before
 copying to cmsg
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
> On Thu, 14 May 2026 11:58:02 +0800 Qi Tang wrote:
> > +	return (ptr + len <= skb_tail_pointer(skb)) ? len : 0;
> 
> This is probably better written as:
> 
> 	return (len <= skb_tail_pointer(skb) - ptr) ? len : 0;
> 
> ? len can't be too large so unlikely to matter in practice
> but technically ptr + len may overflow and wrap on 32b?

If making changes, also time to replace the open coded offset with
sizeof ipv6_opt_hdr and opt_hdr->hdrlen?

Or perhaps better left for net-next.
