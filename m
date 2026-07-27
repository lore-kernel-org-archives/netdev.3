Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3719F3939CE
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166033; cv=none; b=YKzbzBmNKpPD7fKUoQtsyB8KPkjK5DWK+nSerCPbNy43XbY5mRhWToaD6uZr5l13eaglxHYy7iyBDGWNAEaH8yDK3cR0nFeZoYzUxMD8l0rh2kWARdhwnqmMi+HtmsTcMUM4MrXhngGmWaoWKZ/9nrORfELzMmvDTHcEnl13z8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166033; c=relaxed/simple;
	bh=txN3mSbG7frTJZNYqOM8nY2RH3YX8pqXlV+lQaEsCnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fgsh+40t0Vqj/d9ZC/oaNJS41CMdk0WsujH7F96YC7g59VAW9ZCp0YNXqu8UsyiiGD/UD54ISmK8b3GHLa3qHtbjALS8Mc9p9mn8qk5ahnkQj1XNRHy3cXX1fgJRILS358ogL4NxXLot27Rsfsxjim/Md8BugW7ZEz8pdrV3IhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2FfkMlt; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2FfkMlt"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc7a345f51so23767015ad.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785166031; x=1785770831; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vj9kdGELpsTS+ePCX6BKO0wAnslS+u/Ovbd7+ieC1CM=;
        b=B2FfkMlt3nstB+PBUlYXYFjHjqZjfsK4m90QEfcqX2nOYYbpQi7A7YddO1n3OcxePr
         iuOmZGEiYBA+u579DXj3+skTn0zQnpBqm62DYShSp2NiqJ7cjR3vXqQcbVF6tGfqZDUp
         i+rRlAUHWwL/WzGnXRXVSBoiG8CrtKDjrk3zIpbB738mne1lVYLuNG++N+sMix6Ngtae
         t/9GrTgnMfY54aU4uX43fZ3wyHkUe2GFJjbMHHA8GBySAsRcTW5eG0uKC+m6AGFNRzUe
         Q9K+cxJV5sx8pLp4e7MPJp+2AaaomR+5FXgsPi7DMedl+AL51WJXntQA7JwgezwzuV55
         mPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166031; x=1785770831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vj9kdGELpsTS+ePCX6BKO0wAnslS+u/Ovbd7+ieC1CM=;
        b=CToizGYmD0MDevN+ku58G08R3zLzNKE+bbt6q/CCoz3SIVwcmeTZU2Dz0Co9GWyUCQ
         HrD2ocmKtGsJbU1zsx+8/QbqoY55SDGfKzPM/Sv9OxPWRovZaD096ZZefLWn+m55EXS9
         rP/BUIYLmD56F/g4GtvD/FZ7+Qbiy9MOwAuaL/jpwyAtUr3XO5B3T3rod9Asax//7W7n
         V2e7qGdj+FNeu0Z5Nu1hdao3UkEed4YHbCfBs5Ls9o6pfBAXxyOJTappHbS20Oauddau
         8BnMh8Y8vJcG8LZuyZmya9VzW8X4uwgkpYzQz0Hv6I7Xjg7FEIljye/GO/E+xZXSoUUC
         tYmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq2WCNj0e9JdUSQMn1Mr7d2NlStebgUJ+jIwDNjbykQSxaff6dC9Rw5cGb7GxA2feUWQSRzQL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDeISHk6ks5vjVifpe+t+6aIPexVCU5TW5uOU3vC4Y6F4Bi59W
	svTGPSjdaUrX35evArz9TVPPf4O86SCksyYqXhwZ2ZQUNulIfI9izpO3
X-Gm-Gg: AR+sD105H+J/8AaeQnuu6hmjcapJgqzAafm5kuOX7zySg9KpSluo/HDJCfzZ5OcPmlp
	LUWqx/hiuQX4sCHp0561oZ4K4d09oghSt17kryP7LtPTsIPi3YxQhU2GwEKpjEQJATYB+J3Taop
	pu+GC/FLdedm21aerrxlSBD5OHj+xvO4UFq0srOrupCUmiHwvs4pTum9LxHcLzeRfnu80XWVoUL
	Z4OD488ECbQRkV8I4PrbE/snvTc/wLt8j0q5r1wSXilOjRhcWFEzHL0tdft6wrLo62x684loyBK
	Fr2K99upNmMMpl4C0Bexf1eGZJrb3XI99w/KRwrnCJjWFgKwIvTbRGmFsB4t/hZx0g8CQUwI0M8
	7UuGGzjl8n6YumNwB9WsTBfx6/MoidbddeuXazkozNDcUAQWoMxZ/p0mwbElx0IHo/rIT+iE=
X-Received: by 2002:a17:902:ccc4:b0:2cf:47c4:3d1a with SMTP id d9443c01a7336-2cfde795b85mr84030495ad.3.1785166030515;
        Mon, 27 Jul 2026 08:27:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfe1ab9c71sm33203245ad.73.2026.07.27.08.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:27:10 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:25:12 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi.denis-courmont@nokia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com, =?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>, 
	Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 4/7] phonet: pep: do not write beyond optlen
 in getsockopt
Message-ID: <amd4UqADkQNkPfsl@devvm7509.cco0.facebook.com>
References: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
 <20260727-getsockopt_phase4-v3-4-e89627544639@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727-getsockopt_phase4-v3-4-e89627544639@debian.org>

On 07/27, Breno Leitao wrote:
> pep_getsockopt() clamps the reported length to the caller's buffer with
> min_t(), but then stores the value with put_user(val, (int __user *)
> optval), which always writes sizeof(int) bytes. A getsockopt() call with
> an optlen smaller than sizeof(int) thus reports the clamped length yet
> writes a full int, one to three bytes past the user buffer.
> 
> Write the value with copy_to_user() bounded by len, so at most optlen
> bytes are copied, matching the length reported back to userspace.
> 
> Fixes: 02a47617cdce ("Phonet: implement GPRS virtual interface over PEP socket")
> Acked-by: Rémi Denis-Courmont <remi@remlab.net>
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
