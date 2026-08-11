Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527A22F8E98
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454956; cv=pass; b=iwynnRv8ynTjz0Jj/PhBkGunha7/ou+MzzFOy8EANNlRspvcqyLSEuGBHSkkJQcQuUgwlBtZfjoxFmAarYRxXV+Ex1XVesfZdLOBme2PeHARYkn8lQJp1/P9rzwal4nqIVtLhKy0UNsK/OknmVid3P45yBkDegUwBY9NQU0IqbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454956; c=relaxed/simple;
	bh=eXKKt0bULLINK8Io6u6FH9ijgQntZY+ARM1XH7mV7ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tt4JdjvOtw7A4B+9bNAIKaaL03NFqdcu61NikTem39VrlN6N91XLWXmLAW+U3piZ1ecf+ydqkbxrwE30fp9NOE65G33HP3PwWMvOddraae6rJk28t+K+5MVWOENnzk1753s+0QbrmCfqGIIkHcGmARRuL9mz0WRBjYIgvn7Vl0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFV0nybA; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFV0nybA"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4a475bd9ff7so401744b6e.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786454954; cv=none;
        d=google.com; s=arc-20260327;
        b=nK4GcbxynmgUPZul/BioeOQOtl1Nf53+LfYEQFcXWOTvSU++022JHmVz4nWHPS/YZ9
         c9LLH1ejBUbBEva8AG9Kh/4Aph1wNbl8VPosYDWD16NdvKvRh4PRXlpaby0ZRyJJoNCc
         2WPWk/B4Ne8XMV3nSXrrTFKxCqQdsw/1jX+BGl/JVCF4cWJdRHBXdFHH95G7Mdo7OP87
         2Vlyc6s2gnE0dcTkZt01xMiDm4R5czAFQ/+FKVdcGc8058BmsD5OGUvpVqKxtcK29bdm
         a/pKrWppgqak+BFYsuoF3/7tdqXZy8nhXjLgICvqzhv5FuuZ+nS4uuEV5/G8Um9JX/L/
         zBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eXKKt0bULLINK8Io6u6FH9ijgQntZY+ARM1XH7mV7ZQ=;
        fh=hDN00jaCTnimr/japWjUyw0wu2sDK57B3eWN79Xducs=;
        b=ozPQsjchwdCZiPUf/zpLnN7xP0ddEGOpcuvaCzjXRz73qvIAhpnhTDxT9QigGzAC4z
         2wRViVnAGC1cNnBxo/a4YJrlxPbLM4eJxmiabhcrurgQB5aKKZx2v48gdlWPMFi7FbHD
         atZ28/t0RmIhNJBzJ3hoB4l8tEpQJXfgM1E1O/Ak8Olwu78cDhQF3l5ps6o3ikd8i1Uj
         HePtjBVGqF1LXOqyu9lxsrrAV7/cvJysnf5ZFfjBt19O9TvPsTw4LpeCknl4mbKT4cS5
         1BWx5+lqwZBYbmFvdZlKdlGCXjAAI/69x1lmVxPVwQxAu5eXBxAxhZMjBw+FDJuwHaA4
         ZZ0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786454954; x=1787059754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eXKKt0bULLINK8Io6u6FH9ijgQntZY+ARM1XH7mV7ZQ=;
        b=NFV0nybAjzmMXsOcliDCEa5jkL2W5tMQZbsCj2ozGoyqan1bokEQoz6WCvOr0iboip
         WlT2/wTZVX0/TtUWu8EpAyA5A0tej4meHndhXohpHWqoigZgqatqGxVJO8KEwEhX8hW7
         W5gl3gXK/4pRXx1Lb7y2zkK9X79L1UByQL8qXRMkPcS0Jqk6ycmpXg1KJdkTNkBxt0xT
         RkkjAftgIK1jMwJkZC12iUEx5JgaNozFafgrjJ3yl49GSfQUNLj7sw/apBOyLM1ZqIdX
         i3DrmMbW5fV6Un5jXsFKqQpp7koLUP82zL6CeP+WgefWlQOANKbnhyn9NE39D+k9HhpZ
         xwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786454954; x=1787059754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eXKKt0bULLINK8Io6u6FH9ijgQntZY+ARM1XH7mV7ZQ=;
        b=n6SMt4PuOE/eTdJT4cMpeocTcufOMq33VXukQcPPD42Y5k2gtSmgm7CXpSNyug9RDq
         KJgwvTuCZsruzZvgAKqWOU3vInUL875UxMp6lu9JczUr8LTozvHTNdGvgED/WTlkgGPL
         CyVvnFlzwSVQCk2z/lIJbQh0uEvGsYz6BE7ix5GAZCsf/vChbdmyY+pZa0Rnip7eMrLm
         tJRXSbHS+Fp+pT/Fx+BiLwwt6mwMYVX9mF8znyebd1Lxm9zZqva4/mML/mA1jaov0exX
         ZRfNf22xti4F4ewkxkTGWege2piVw2y8v8SQQ1Uaa2yKFTi4/45kLMvYxDVPwJ5+atCv
         Evow==
X-Forwarded-Encrypted: i=1; AHgh+Rri3flbC+Iget87syQVzqVUKKPQ2lrhOIy9T00ABl171hBzAfqQxm1rGfOkh543p85Rhfh7uZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlaVcD0aQ5V2tnidnbDPXGBilQmtKygpOMCZB73cLYG5ibDlvp
	lpXbvw9nwO+mvQ7MkDFgywIRRgWjozFZMOEODymMDkBE2WTdXqHcsXHZ2XxmseV1cWQG+odid1F
	okZC3Yg4eg8locGuyhtB/xcR5l0xO7vI=
X-Gm-Gg: AR+sD13E+atc0dnxVa26b65gMmwYFckb4wWyc3PHcYlEmajUUL2izjS6cZ7gj/Et/RK
	fHrvDyOJKCySwPXIg+6IbYXeSjLYIOAQ3w0M8vo9KouAyUo4CYSZRMKVZmKO/NRpksRP4/Yegyh
	pORuj7OAp3eocRnej2WmahIzgQos98znFwK/QtwM5r7nb45hfau/5KKlD6lDW87GkHPvYA6qE+y
	aAwxwcgfvLswyd3l7ie6z54iesp0tFZwVv/C0y6EmTLeRry7JkZlbkxcf38A5WSYaaVwsoZMony
	gsd7ofgxlGhM/PwyapSZv1VNorKd5Gr/mMzkmg43o3DT1DbQxjCVoJSO5JqQ
X-Received: by 2002:a05:6808:690c:b0:46a:7ab9:c338 with SMTP id
 5614622812f47-4b1fd8dbd08mr1113850b6e.4.1786454954091; Tue, 11 Aug 2026
 06:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810-netcons-userdata-rcu-v3-0-f65557f769ce@debian.org> <20260810-netcons-userdata-rcu-v3-1-f65557f769ce@debian.org>
In-Reply-To: <20260810-netcons-userdata-rcu-v3-1-f65557f769ce@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Tue, 11 Aug 2026 14:29:02 +0100
X-Gm-Features: AUfX_mz_hulfx3Os9esMFs-N99crPeFdflUFMh7MJO-oYPdFh_lNeKJ_7E69zcw
Message-ID: <CAGSyskV0naEEDZ1oYKz5S_2mLnwODATLy4Ej1OpE7XKcnag+ew@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] netconsole: publish the userdata payload
 with RCU
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 10:36=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> update_userdata() takes target_list_lock to swap nt->userdata and
> nt->userdata_length, then frees the old buffer. Since commit
> 7eab73b18630 ("netconsole: convert to NBCON console infrastructure")
> that lock is also the console's device_lock, so writing a userdata value
> from configfs serialises against the printk core emitting messages.
>
> The buffer is immutable once published, which is what RCU is for. Move
> the string and its length into a single netcons_userdata object and
> publish it with rcu_replace_pointer(), freeing the old one with
> kfree_rcu().
>
> New userdata design:
>
> 0) Unify the userdata fields into a struct netcons_userdata
> 1) update_userdata() no longer needs target_list_lock.
> 2) writers stay serialised by dynamic_netconsole_mutex.
> 3) reading userdata needs an RCU read lock.
>
> No functional change intended.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>
