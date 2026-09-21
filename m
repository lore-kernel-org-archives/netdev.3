Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6944FE2F7
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014770; cv=none; b=l8A0NvH9aVceWFTvF6rOdGsItk8Cb06gMW6UyTGWA3tu1YjlsGiNdznDsP1CyfGzGM1ax03Kc3nUAWqAKadN/DzRpKbczH97OKeSVbbMb33hS8M1ZrnNKy+Bg3WODV/Csbh7domzgfMiKL7u2wOqOV2/oIeDqULq6j2A52J2+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014770; c=relaxed/simple;
	bh=8SOK7b4+RHwgrDEN4NWIfgnetoUHukLJ8xvvCPI50C8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/TNy54md+n54WyzhXwNomqZeD3IzAL9u0Zu69Z53oogSsR55yc/owBWBh9C5bhGAadFUhQc5R7VNEDuH+HgyfK78JiZh0rfc4eI9PmS3h7AmeELZK69HYz88S3GVQBM0rMBVw00HQJXh1KrXU6ggt8bCUiiobQupkX3BaHZtbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=agfE6jnq; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="agfE6jnq"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd5cf03so3234798a91.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790014766; x=1790619566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AJPQyzX/Wkk0kOsOXOqZO/LlRwi3EkZiLjHZ4oL9XAw=;
        b=agfE6jnqz2GUCf/D7JzNG1SDlq+VJNbHsFJP3kV0aJMnISZdLt1pf3Cn8+uDYC+rQT
         YQDkLxPmC5WW1aODBrviW3Ug2lmzaln5LTDPGEgplTWlvmc8FCn+1xnQDOU1+kYyCfCy
         HOU0P9HqWUPnGj2f0CulTZac9m1bbxGZotBSyia3jPM6txR23iNNergfXETmH78SB6+P
         RLWDNHwWw80kFSufr4IgM9MYzX4hdJswRqfJr7+PZcHPLW/867laAMP9ElNOKgsgghdn
         przS4Q5G4U2wDNf+7YH09c5uWy20GXgOfH0+zUXvSxVTSFb0Ht0L6C5vasp6BB2/pJ5d
         HN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790014766; x=1790619566;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AJPQyzX/Wkk0kOsOXOqZO/LlRwi3EkZiLjHZ4oL9XAw=;
        b=GtK5+J3oVTUNl0RSo1G8yg1RBpaaW+EO+6PtHuGBCv2dxG/phydi19e4LeIBdRt3UY
         83Wqm45vit2kHizzfhICVhCLEsRu9NsDNtoDd1H8ynE2X+IK1N0z4xcobsn+hY0oD4DF
         NWmojGdvs7HoQGXGk7pESDGkiE3NOyhWbdT9HLLmJYpWJSkvLmD008ThR/s9yEnafGxN
         9taZVJQHh/gQL4PqfKi43RVsq6W/M6Lo5Hhp1Wk6q/Fg7vtzJnY/fj9ulItwhPpPwbzX
         48K3BHY6mz2VgeY6LKIyJn6eJTOvvdYhyu6V2RWGvvSREbFRo9cYysEOd9RFtCPe0eho
         kAmg==
X-Gm-Message-State: AFuF++lm1OjtqUrcEZNDOLU5rujCjBmfWx5eVKcjUthio4QTCulOMiVF
	vtC/DM0YpHCGoE/o/lPHHc37/KVfQtvplcAV7MXUch/pATn2hMHUOgqwY2Lcp/itRLg=
X-Gm-Gg: AYBFou0sM4zYK0nQBoqStNP+RgzACI7B++91PCWMej+7AFQmW4+LEK/Qqb9xtnAGGCb
	4GmhHsXnkFlU+mnqf14OYmPLdVgjfJLjLo1+aJUBhbiHHFBQXANE+34I173lIIelk0B/tfRf+Qv
	hOrmfv8i9L+xQHSIsUPynLLje6RYf7STzW7fOlo+s5Qv2Bliw/ke3zxP73QNeHAq4aDdVUXnZ+0
	77kdFxc8ybMjB4P7aWbVx7ymzDZCSyTZIbstSuH3dlmXL63RRX74p8zWpkJH/FGMDL4tvKdzwhJ
	lmGMI0YW4l1Eo/wTkOkmmBcu8whO7pDLiSmtGuo1zSGSJ43FjvP+TpI9AKn0o/BvFqN6oWZlc1R
	XqKzqHt2TT5M0cBnZHcY/dU0PRGvSCMmarrEXRevjSA3vlJr3z2a1MF1QCUn0R82cWj3+Ex05gR
	1tINezBme2zSaet238DxLkYVSVHgJfe5uveRRRmlYU1/kg+6uYrx6LepOA0bsewMMHmSkMVKAy/
	0LU0HxyiFC3SDqBzT1HMe1DUBzhiDSZ4bdRqWd1
X-Received: by 2002:a17:90b:57d0:b0:39e:6c69:f479 with SMTP id 98e67ed59e1d1-39e6c69f5acmr11572630a91.56.1790014766468;
        Mon, 21 Sep 2026 11:19:26 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0320b6ad5sm4531998a91.0.2026.09.21.11.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:19:26 -0700 (PDT)
Date: Mon, 21 Sep 2026 11:19:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Hemendra M. Naik" <hemendranaik@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, vishy0777@gmail.com,
 tahiliani@nitk.edu.in
Subject: Re: [PATCH iproute2-next v6 3/3] tc: correct tc_pie_xstats field
 documentation
Message-ID: <20260921111924.2cd405de@phoenix.local>
In-Reply-To: <20260919061254.39678-4-hemendranaik@gmail.com>
References: <20260919061254.39678-1-hemendranaik@gmail.com>
	<20260919061254.39678-4-hemendranaik@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 11:42:54 +0530
"Hemendra M. Naik" <hemendranaik@gmail.com> wrote:

> Correct the comments describing the delay and avg_dq_rate fields in
> struct tc_pie_xstats to match the values exported by the kernel.
> 
> Update the documented units for delay from milliseconds to
> microseconds, and for avg_dq_rate from bits/pie_time to
> bytes/second.
> 
> These are documentation-only changes and do not affect the UAPI or
> runtime behavior.
> 
> Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
> Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
> Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
> ---

Header file changes are done by getting patch accepted to kernel.
Then the headers generated by "make headers_install" are synced
with iproute2. We don't take changes directly.
