Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A893264CC
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093188; cv=none; b=NBn6L3hCq5V7RHf9npLFev4/GSdBHEayN5QLcNeDsBDyIC2Aj9ncHLaNI3Ez/FMEYlHAIcU+qBqqJUPMcSZ4g+vuJ3BI+WPvfcc21JMs8FhdYxiyQ8t8ubklI0JVs56McTqi2/RdJImq2EW0PsLNP/bkff0OhYw5d2Dc1DgGfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093188; c=relaxed/simple;
	bh=fFvNsLhha199OotYo0quLtlpCAq0uiox2AqskEJlh2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xko1UTsuFonqE0D5XSyE3UDFnHuTmSzfDS5jedExUnYH4VJS5JuQ9c//u0FP6hJLWivvvpqXB/v1q9gEp5bXTomKWqga5lJhd+U8CU2t4EmOMwyNwhn3YPk32TohYhEc7QyJc2bpiaGjQwzwhf+muyFids72a4htLfusotnXWws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrxMK/Fl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrxMK/Fl"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad21f437eeso1679085ad.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 18:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775093186; x=1775697986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=crvac5GNsvhV8fP5KBRwJInEe3qXMRAYNJlxMQ0YphE=;
        b=UrxMK/FlUjbREfYw7iNN1PTNL2JytczOlgZeDKX01cvqjVRQOfNkqbHEuTXx949cNC
         NueeEEEOnQyr2Sl0ZoggKHZooD+/ZU3ppYYCuCKKIAtNfAzPpktPUSYmQKW2HyyZ5UBe
         wFRqGg2pkNrVqigt/Pfi4kVawHwd+tEQu6YxC1CQFt4KqELgPw0Yg2CNXVUBbK8D9C+3
         SUTKHbU6GOgxtEwWhonK3l6IWx2q2JvNBTp2/OADKCWcVve7QeaUARU+fDgjf4atSsBx
         4RXi8nNEw+rYVzsUq1IhXr15KgJPdGxAO9X8sVzxex2bN8q9b0zX0CnQx1fuMX6wEcsO
         JThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775093186; x=1775697986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crvac5GNsvhV8fP5KBRwJInEe3qXMRAYNJlxMQ0YphE=;
        b=hjLHEFPHthangCI6DjsFk6EEAyUUeRbGzdiMLTNKm41VN1RNmtEtDffW8GbGxXSDtp
         YrO7DnORkZVJj68OywgC8tcgJZCpZdek10uuSFbn2MAXkQ6DFnD6oB/Gm3so1q+9kCFM
         1EJLvdErHQBH//wR1/F6Nbi6nlHutQe9GJAPjTittPI2mh5dRyFPdcQudn6YBXCN2i8K
         wDKo2BMrt+zkurhZZeQ2vCvn9VupFKVE2t+quVd6/ReroBMAfaml4k4TC/0Pz+IWXgi5
         wuLZd3bJ2TUBhUla+OixB0OrjEDjlXHh22b1R7hNmhSjzmL2YxKLF9BcbRx+UCYZGY1f
         bdwA==
X-Forwarded-Encrypted: i=1; AJvYcCVicarsz88sHlAbt9P8rbmwbYdTRKtwboaOqojppu+K+WZ48yOVXF5q9tJFXW/08RxtOHPQgyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRzBCVmdWedypb7c/JZqFaveQCNYnGp2VkrwUD5mo2GrgjiE8U
	yYQ7uh5G+E8PrL0sVnv6FxxBjcBoeishkSRnCGNDjMQ0SPZLWO/SuXBH
X-Gm-Gg: ATEYQzzk5qqNdjqO/DgNHJC925T0tkZE39REoa/cfM28xQzyQbnHDPsgftY1NII6yvX
	yqA97djT6HCdDKSC0P4T9QzV+C2EmVA0p9515kGGZjWtNoSQuikWulSaqFt7i+5hFlvTSd9IbtE
	F1c15ruVcoukCCnOuI03V4SrgFuWfeHPDvR5pjvafkMkkV9atGUIn8lxIddllSqijjPjp13lzZo
	rQ/Fu96l+Car0LtR8QjiNbeb+pX801Ob74of2dH6zaWeRPTwmwm7NewDgsOxOe0X/+Gbp0/hsZh
	L5ZYmZRWSWniDK8qEX01vhF3mhmQc7wxnApTdGcHSfxsuRUFOsUaU4vZZ5Agtb3XLKuGgk9SVWw
	QXKEM7FmAXBthFjGWusp4qbzr/2OVbuC2yxMs11BaxzBOHPImcfwFPwHhMN67oZaQAlnZu8Yb2Z
	jd22JYFfAV+xOaOutYDlKqkm6OPPU=
X-Received: by 2002:a17:903:240b:b0:2b0:91e6:bc18 with SMTP id d9443c01a7336-2b277e0bd66mr4557705ad.14.1775093186327;
        Wed, 01 Apr 2026 18:26:26 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d280sm10176925ad.17.2026.04.01.18.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:26:25 -0700 (PDT)
Date: Thu, 2 Apr 2026 01:26:18 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] tools: ynl: ethtool: use doit instead of
 dumpit for per-device GET
Message-ID: <ac3Fun6L-9MiTYUV@fedora>
References: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
 <20260331-b4-ynl_ethtool-v1-1-dda2a9b55df8@gmail.com>
 <20260331185028.45dffe3a@kernel.org>
 <aczHkqj_0ErqCfXS@fedora>
 <20260401175117.1e4a5e6c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401175117.1e4a5e6c@kernel.org>

On Wed, Apr 01, 2026 at 05:51:17PM -0700, Jakub Kicinski wrote:
> On Wed, 1 Apr 2026 07:21:54 +0000 Hangbin Liu wrote:
> > On Tue, Mar 31, 2026 at 06:50:28PM -0700, Jakub Kicinski wrote:
> > > On Tue, 31 Mar 2026 11:56:11 +0800 Hangbin Liu wrote:  
> > > > +++ b/tools/net/ynl/pyynl/ethtool.py  
> > > 
> > > We have converted all the samples to selftests so this script is 
> > > the last piece of random "PoC" code we still have laying around.
> > > Should we also move it to tests/ ?
> > > 
> > > If there's a reason to keep it as is -- could you please add that reason
> > > at the top of the file for my future self? I'm pretty sure I already
> > > questioned this script in the past ;)  
> > 
> > I have no objection to this. Will you keep it as it is when moving it to
> > tests/ ? Should I wait for your moving first?
> 
> Would you mind moving it as part of your series?

OK, I will do it.

Thanks
Hangbin
