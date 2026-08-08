Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F674B04BB
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786170402; cv=none; b=RshfyXQSjkXixkIlE4POWhYvi7q5nRlqZHr6jctLmGLc9DyATPLMAXQZlBcz/M0uW5yLr36XXzMdwpmBS+O7Y2NcuY51+1SYgOGJsAL/upBNuEy7nO16yKT8ogLD6CjifO86LpyIOxN0H1QBzzl4YPblkVL60Rwe2embz6+Xxl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786170402; c=relaxed/simple;
	bh=qtBFllAz+p5PJC/LQ3QUUdjCCSGJucmC1kQ61oLXxio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5obX2uG+cqrXrL8IcOzdSnsTqywzg0vBj55pMZkFnCUdgasCkoU97NlvmVixAWjK9RWoqe7BgrP/THSk5MM21A+lrgwgMQ6NPJI0QNvXMb/uR1kQeoiTiTsecjh+Emtpn6tYWGEqaW8ZuPfCW3396pFiLpdiPM7ZqJkCy8XEws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayPlr+/4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayPlr+/4"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cea3004256so3554165ad.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 23:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786170401; x=1786775201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NIaIillW/ES5KIua50EkDl/Ri/Ln0jxYV+0KVd83QO0=;
        b=ayPlr+/4k8Omm7f5exWi1le/vvvcx5Dkv5XthOXuNngZDA5qdYmTEPI92Sdt3+lOFh
         GW+6XB/P0sd2vZvXqNCJ1qm3/NvydKwCO26BGbNCX5sXqlsfHG43nmce9dCgCobvKzRN
         M5K16BgfhxA8Rkpshru+ngjYIWW6+zdxF0a0uDGwnFE0gTNPDgffMzOiwwchFgQtpjWB
         vftjHfFafewcrZW3BfOPFSV0ZzYuEfusWpj6jHszCqS4+g3lK/UxlCWwW40e80TQKFLT
         ATKXiy19mA5xQsxC4STdSSp2+zzW//0kevyrcmPjZz0ASQ4TPZ93lHE7gD6D1+PhfOFD
         7KAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786170401; x=1786775201;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NIaIillW/ES5KIua50EkDl/Ri/Ln0jxYV+0KVd83QO0=;
        b=sR8Sqd14swnDBDZBBR7Q/pppzJhDKwrTpvClUr4q5M3Vc1wiGaMx49CuZrNOJEob51
         24TdBmvJERYlGgHlW8I1CeTV0J/VmZBSUCMBxKtWodXW2hpKjfefa9nu3UW8KFFWqurC
         1O/QFMWl8Erl9gGjm/9lMb1utYqAWuHNonMYppMOnhShuBtYrzg5kPsVBZB/8+tcCiPt
         i1DTA96EFA0woVe53//8v6sfTpO4RZzZU1iX5cpB1hKnFQS/546NpgXafhYaNxV0ILwi
         HVHlgkAdQ9VHRS6b/H45YJjFrfc2eKf/JVjxzCGfiMuczgoHDEXu4s2bGY7bPKVJrB+H
         6q9A==
X-Forwarded-Encrypted: i=1; AHgh+RoUI/H3l0I9YyvbFvHE6KqsD2J0sRVkISTVXkvk8iuTuMliRlYpGw4QR7kQTICy6Dv8bzJAPJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLNR8QWutMr0UY3vuhbDJSZhtuyrJv4acbHGo0ZRcUcqo3fEHA
	zqGrCALp5IywewgWkmQz3Yryyf/e2tQMVLd6FxyE53sEquZmAh5gIf4m
X-Gm-Gg: AR+sD13VlIkCQs9n7ffZav9VZNZCAiEfqlTtRx84fvZlc+tP9kzTgHzfDNQwBAa226P
	Sx46HPhNBVbmMW5QYpImQFbzCxMEM5IfFuovXdWca/LsEV5zZ5HCCrtUw87vlZOPOCyC7q1VzIP
	7qSfCSX7A7FgDIvGS8ODBpTGO1tLXbqTxwaPIcPHHqha64IS5fpL1EvhpINDrCBeSsW0jVY42VS
	2AGMFXicsCx9QouXit8XJjBhRElwr83KId4wWISc2aPOCG01sia1dK/t6dKKPPM8giczuqAkDA1
	YybBTY40CY5tRVOnwEjcTuEXgvVZqW1/p6GQKNByznzbKcD4af9+IJw5E4sGpXsYYkYteYCu5mw
	13PVQBb68FeD0qRIXPCztWrl/gR85l5TAm4ElLhliyyY0+acO/8QTW/Om7A7ESZa3yPiCgik933
	i1XtbvvewkyA6Ri4yb3yhion5wzKW+8xTDTHPlqH8xwCjhX8H3/5AP38o=
X-Received: by 2002:a17:902:f54a:b0:2d0:cc92:f7ac with SMTP id d9443c01a7336-2d0cc9302b2mr308403715ad.14.1786170400784;
        Fri, 07 Aug 2026 23:26:40 -0700 (PDT)
Received: from fedora ([203.175.12.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4fc743sm15991535ad.80.2026.08.07.23.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:26:39 -0700 (PDT)
Date: Sat, 8 Aug 2026 14:26:33 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Qingshuang Fu <fffsqian@163.com>, Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qingshuang Fu <fuqingshuang@kylinos.cn>,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: Re: [PATCH net v2] selftests: netfilter: conntrack_dump_flush:
 remove unused variables and fix typo
Message-ID: <anbMGS9TFOEUUWu-@fedora>
References: <20260807075928.64326-1-fffsqian@163.com>
 <anWgQSbZWK6D2ONg@fedora>
 <anWyMUFvONx6k1d5@chamomile>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anWyMUFvONx6k1d5@chamomile>

On Fri, Aug 07, 2026 at 12:23:45PM +0200, Pablo Neira Ayuso wrote:
> On Fri, Aug 07, 2026 at 05:07:13PM +0800, Hangbin Liu wrote:
> > On Fri, Aug 07, 2026 at 03:59:28PM +0800, Qingshuang Fu wrote:
> > > From: Qingshuang Fu <fuqingshuang@kylinos.cn>
> > > 
> > > Remove unused 'rplnlh' in conntrack_data_insert(), and remove unused
> > > 'rplnlh' and 'nest' variables in conntrack_count_zone() and
> > > conntrack_flush_zone(). These variables were declared but never used
> > > since their introduction.
> > > 
> > > Also fix typo: rename misspelled conntracK_count_zone() to
> > > conntrack_count_zone().
> > > 
> > > Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> > > Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
> > 
> > > ---
> > > v2:
> > >   - Drop Fixes tag as this is a cleanup, not a bug fix
> > 
> > If not a bug fix, you should target to net-next.
> 
> We will handle this though the nf-next tree.

Oh, good. That's more reasonable.

Hangbin
