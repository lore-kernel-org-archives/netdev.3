Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EEC4A43EF
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163118; cv=none; b=HmA8fSslXHeJAFqZXRuBL02lIQud63AwpFkB5yF+nyVetQXZxqdd4jLSCJaMDnQd4z8nyjVhkF7W9mxnlBnigbQm/Y/tW+VGoFOZ3+VLhUXRlix69EPmr+4ydEWXhfQuJwEmHE93jl06Sx2/Ysp0WIDl8xhaU5tXODFn7t8i7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163118; c=relaxed/simple;
	bh=71K72IULwWn4R1b25sucjqqIwKdh/evaTwDeeawCaxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X889uZDU4+722v954T+r5fPRCIiBu3hRD3kZrUBCLMEoS29Hqla5pzAMWQsQvn1OSWzBRS4KnMVhLG92jJw5VLXn+j3DEA1xIDQ4Vt0A70QibzeCS4OZvoBnf7jE2w+ZkNOOe8qfs0wUgNl+LpD3wfrcmWT2S4eQqGgYBN+2jt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEB0uDJz; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEB0uDJz"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso4209395e9.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789163115; x=1789767915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+cBvQuHwe5GCeT0Z0DzRPvSTiAVCj7vg+Qh8CRMXIPE=;
        b=lEB0uDJzUYFir/r5ouEJTZGtrgmJ1itAIlFuUSN4ZQPZ7KzXbGFKfKX54QTz7VUl6/
         CtSNk2mtk73+oiK3iQydS8A+1jAxcFH1RXXjAh2fduca4F1f9XVytsea/YhA9wwnribG
         AjSjrpUTyLRPymu9k2ZZtNTcM2E4hJszqeTfjNiQINHh5DuhhabaObEaWxXNdeVCJU4g
         VqONOOEW0KZdx6IEwh4GoKWjcK7gzuay7HFyWsGZiJzXFnwKniZ/dhKqWT/tlac56M7X
         L1s85wbPXqnG/KvDB1W35OBuuB/B7WREo51q9C63JwM2HEWtDaD1Z0gHPWYaWXmG6lMi
         rkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789163115; x=1789767915;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cBvQuHwe5GCeT0Z0DzRPvSTiAVCj7vg+Qh8CRMXIPE=;
        b=Q91Zgg/eAYRqd5ruB6fhN2wr7ofK+pGBCP0jEaDz+JAZPWR0KUUhv3ZjF65WmzEz+Y
         E0j3Zv38iR0Z7sQ9aJ/JL1imutPEct6W2Lk5yDpw/XeXTPyKuY+2ydxIX95fBVeBqqL4
         xkVx2HEfMBHA10ZLSVbz8YnJZ8f8e9IzOF6Y6rq32gP5LCbnvsY/+2mFqxl3OksiiJct
         QDB4ozGcS7UpEj5h/10oSX+0IIp8N/qPLF8v7puTzko55yQLIJrRc+m51WP6ZQRvQd0r
         b3jqGUVnLYwJMXhdKk9NtYbm9X7a/p1XztPHPoOq3+eiQUNVn7FlxB5y83p0ZZWJi6qS
         0P3w==
X-Forwarded-Encrypted: i=1; AKwUvByEyWE0oP/XZkd3Dw9GYFC27y1UK4tl1oXNgQRzacT8/74qfb3OwIqFJJs4dCn2mIIZY2+RmkI=@vger.kernel.org
X-Gm-Message-State: AFuF++ke8gCzQ4C2XsyMkhS0oGNdSvwyidj0Q9Z+3Pta/+sPVZb7AAuL
	XTi8kudMOWUvicDXaRHqWnkUnRWrlRk1daNkivT+g0wd7sfxyAweSHVQ
X-Gm-Gg: AYBFou360AnewlbGMiiqqXjEOpogoBNzinQkv1dN05iir0XtQ2lU28bwbmq+kESU0ch
	pYtPL4lWWOd8D3h7E/srFDufTYB4xnFysV9utKwSDTfedmXsxAT22FC6/9mc1Akc4TtvD/Gk+nT
	1jw0eW3YihBuPYetULBvSfw8cm127zaPQp0Yybk+mqHtuJBjQQ/OMhPAhWTXPOAJmEEUYRsAjIA
	w6IM1xSKgMfNTKWWZpvqTHRQ7OkxcrmK0yEDhbApWr4yY2U3xmN8hRLO8GDvAyBSr6DO4KAYx3f
	x4fCzR7FDD1cod9w1tJjP6lNgxPx2CRe9hxvTmxussX7ZSzhmC4qgJZ27+Dny568xaoCV+DnI6C
	xPQLrYHtpwdnTSrKOpFzqoXx+HoebJao5FPkAfpX8GyHb2gf2BGdprC/CkkY2Km+neN9UiihsaP
	RHMu67UyQsaIBQfCCogEhWVY0GeRZyCEUtIpoIqakJERx+VxR7u4qfqtSVriXXcEM8S8HWLxSUW
	+bHMJt/aV8NnzOZjrg9hNdzLCmkwzJt9jhQRsO7xMM0Pgs=
X-Received: by 2002:a05:600c:a107:b0:49e:663c:c69f with SMTP id 5b1f17b1804b1-49e663cc929mr88097525e9.15.1789163114788;
        Fri, 11 Sep 2026 14:45:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e62cffaa0sm35777015e9.0.2026.09.11.14.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:45:14 -0700 (PDT)
Date: Fri, 11 Sep 2026 22:45:13 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Janis Edvarts Lacis <janislacis06@gmail.com>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, liuhangbin@kylinos.cn
Subject: Re: [PATCH net] net: vlan: fix vlan name truncation
Message-ID: <20260911224513.1fc3f0fc@pumpkin>
In-Reply-To: <20260911163543.204203-1-janislacis06@gmail.com>
References: <bb5eeef9-a78d-44c2-a8f5-2cddd274d3ab@redhat.com>
	<20260911163543.204203-1-janislacis06@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 19:35:43 +0300
Janis Edvarts Lacis <janislacis06@gmail.com> wrote:

> On Thu, Sep 10, 2026 at 10:56 AM, Paolo Abeni wrote:
> > I'm sorry, but I don't think we can accept this patch: this change an
> > user-space visible behavior: ...  
> 
> Okay, I see the issue. How about a 'solution' like this: we use scnprintf() 
> instead of snprintf() in two branches that can have the name truncated? From 
> what I see, the only difference between snprintf() and scnprintf() is the 
> return value so there should be no functional change visible to the user. I 
> tested the W=1 build, the warning is gone if scnprintf() is used.

I think that ought to be considered a bug in the compiler options.
There is no real justification for snprintf() and scnprintf() being different
(especially if the result is ignored).

David
