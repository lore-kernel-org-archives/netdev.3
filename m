Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A64C37C916
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084427; cv=pass; b=GAIoUtAMFZ12aMctxPAEzZGLILVC9Qgh4dG9z7FycUFwIUJrn2pqoE4zPrNvQFKmI94laArhKOsEJU+zpLuZEW+ailoU46Do50MJuLpcGSfq6fYjWaBK1F/zLRrJGaBig29MEuS5jihg0/3m9inOYvKrLT/3Z00QwijC4jboTDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084427; c=relaxed/simple;
	bh=IuEretd9v3mZ+fYukt5hJT3lAR1DloYAF06eI95YIWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3OEZRVDLOXy+LJyhEd5iB6wpMuNJ+IyWoBV2OsqfLXCNFoyk/BrxfEL9ipyQgVW/KgjNeyDAQw+OfhA6z+w/zX/yx8a6wRi/HdVyH/TmEVwCacS2JVqdmj14H/1k3/nFTYnIfWRkDe6+UWAamEQI8EkOIJ6kkI+kxrAW/dUrk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALFEw0l+; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALFEw0l+"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-698c0ff45b5so1874361a12.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 06:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783084425; cv=none;
        d=google.com; s=arc-20260327;
        b=cwzXiwfUO+VdMnm3g17I4Y209KywQZQ1WLZIZhn+3aKtECmLEBeIXM84SGyVbRsdOF
         WOihjMAuRvWEXez89NbogNwRBOdcqqluhQJMJ25oJr5hdapZv0BHmf5f9gKM81pIP6XW
         Jm04WjsMxpnMOH5VDij1a3DvsBtF9592vJuPJvjScpHzELAdBGp6y+6AEzFZ2ub6QlPy
         3nELqq9qNsnePB2SiIgVRVRp2fhddZq7ZEmFTTCeMvMWBN88HlvY3yC3/MFzvJzW9P8y
         7E0Ye7Z3DrZ530b0dIX1HAzy72fAy7m8TCNLaoLp73ukSHHD4r4LovvEVU0c6IZyzP58
         8BcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IuEretd9v3mZ+fYukt5hJT3lAR1DloYAF06eI95YIWU=;
        fh=9sNp3ZOcXiKtXbaUXvuIERjaRF9xrHpSG5UhQ55XEHo=;
        b=hPgwrbuf+G5o3Owvd8jlohA/x+bHhKTndo9a6XhlBOE+IOQ0vFZIGuBpWBz7Bb6QU3
         eDBFkGbjib9dYAlZ3iRcHzvG4RaKr3XG+X3PT2Xzmdu9ImQ4x6/ssuBDGX9wtnWdJL0n
         S7xGoKxyzHMV6iVDn2RJya9XuODihfIBWX2swlzw6SZfyJXGdt4X3RrBPmRSTBrhYEky
         DGOFJWAQuYMXu44QhpRwovd0LBrpj+A05ZP6Yubesl5ZHuubSo1tbZZqBV1/LxhdvcYN
         yjUsGZ+hFFw7miH8d6O5bNy6bj/q28qjUEPRen20pdQQXRoXaSxDY9d3NW0DlIR98UDj
         kiIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783084425; x=1783689225; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IuEretd9v3mZ+fYukt5hJT3lAR1DloYAF06eI95YIWU=;
        b=ALFEw0l+jUZsRUgvrhg/LjVNQ76rzxq84feyFUf9IWgsGt93B5wk5w7/W6P/+/+3HS
         Ok5Y2ov38wyHgZGXxTMXuXtAyel+GGOiz0NFJMKM4yyEC71f0Mr0+hqVIZZDlDNjdgkk
         24StFPLg0tZS3167KZRbqcrcI1rrpRros7LVXE6eKguCm9IOA+AcE9KqaEWGKjpZehe1
         KF8xD765M1YeW3wJKS6WutWldWYaTysvGV4U6RC1YsfuXGJlx6ss8PpLW5laAooM7elM
         jr2Q07a4xQnEcP3s1sDkPKnTTDCxQmJeGRgtc/73Hh8jBUbvyIbQbuxdzfzazGEH0MEC
         uTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783084425; x=1783689225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuEretd9v3mZ+fYukt5hJT3lAR1DloYAF06eI95YIWU=;
        b=ruqF56/4XBYeizxhY8eK7dWCnhWRnM6+Ly06syDgBModXgyQb51SPtRhzrmn5APTwc
         wbwYleiAs8AFCWWvGqZ+dh+Zn0cgAEokQXA0I+/VygeI8tL9ipoqkgVOWsbdKz6PKDKm
         Ob0g6mtCIiBfQGuV28v0bzHAuXUaS+8KV1ySWrZX56lY3wMnHBUNrB0q0kdM7jl2V1nn
         9h8M2xQqV93a9HIt2AGKOjsvgKNeUKCoytn4G0mhuh409YtS6n8bXf7vL/hAoPyyo8g7
         u3e7+FGzig8KJC/7hfBcL4lHOz3ohOnoNLSnxpqppuWOvcOh3y3lbbaf/wRAmkfwbCme
         5nXA==
X-Forwarded-Encrypted: i=1; AHgh+RrFepO3FGUJ6ZanB/dunsCgl0FwUYhEoH1zQ/ak3k7sBkvAWxFFUoxKQUeivbN3XL5egDZTeVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqxC9smDRQd0zaiBULFlPEe4DM1lAsmOjHCVwZhBEvn08eCIbu
	Tx3l3c8HoV6KZRFLWe/OUGw8j1Vie5SmqRUCnCqjueXILXVZ1H+cYlntRJ/xGLWEbrNKT4C2sCy
	JHtH9daCcCIvyuSuoYNV1jxOlm7eN6d4=
X-Gm-Gg: AfdE7cn1i+3ure9ovZ/xuDLg1lu7nS6m2Q7NGSU+8Vmy8r2gqQVoH4jR4wKuZ8eTnia
	koorbH3okt0PUL8RfHIQDR/Th+eVcOlNNk4JRVINboAR+x+ajWLGY3nYg2kVNEftQb9iXlFDsyO
	162YORfhKZgbuvvLFSPGZ58SKOCRlfKYMjnNSJdJBmqdnvBfS7rc+Jn+HMNoqyIflssP/0sLjmz
	rbCVfwpa7YFgDdKJ9v5X/vTJ4G4CgqE07LfZ4EndOYjBnk0Fzv9FRMcyXKWVKLK68XPL3T2ZtQ7
	HnC2FFw6
X-Received: by 2002:a17:907:9307:b0:c12:686d:f673 with SMTP id
 a640c23a62f3a-c12c9f71a74mr218109866b.30.1783084424549; Fri, 03 Jul 2026
 06:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5@kernel.org> <20260630-rtl8366rb-improvements-v2-1-05eb9d6a37f5@kernel.org>
In-Reply-To: <20260630-rtl8366rb-improvements-v2-1-05eb9d6a37f5@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 3 Jul 2026 10:13:31 -0300
X-Gm-Features: AVVi8CcPe-POJN4Xg3Q8oz5MxstsmX4xNQAukMrn22DtoWgR4JZMuKbrdlJMukY
Message-ID: <CAJq09z4X-+wNtFaCTKFnfvn9bpTjLU8y=drd1gDnWjyhr04ppw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/5] net: dsa: realtek: rtl83xx: Make learning
 optional in join/leave
To: Linus Walleij <linusw@kernel.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Mostly to make it possible to add rtl83xx support piece by piece,
> make the port learning callback optional in rtl83xx_port_bridge_join()
> and rtl83xx_port_bridge_leave().
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

I know it was already merged. Anyway

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
