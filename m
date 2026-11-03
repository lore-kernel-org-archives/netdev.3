Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793714868;
	b=OhqRJGd6zbj7mH1n1aUbvC6amijD/86xbNeq1xj6WiNDGsipAoZpSfDf7IsX/qKoSmk/
	 X4tPBNWEKDGRTcP6mzaKZSbSmSUIAQeNbk7DAvxQafrS0TUVMY01EfVU+oqZ7gcaHU4mM
	 H/DOpawrYKWXrd1AXkRnjGqtsdmouGir5CWQednekSQQOn9AwvmnG6ewaWVP3aFvoCAyp
	 /+1sFtJ/I7NiSwsdOq6LTQQm5e5r6P8F7iW8jBMw5weJV7OQF7mCQaBqB/e2ktWOJYaba
	 uUCAM7b7I7GU/Pncq0LK2fh3VifffkrBNxUI3yjcILsDHBojnQkKmIXvHIGFlUQaAcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ff3dJqAvXzLV6Jf16Tus2rrJ5Wh3fjFVBip1hlsQ8YQ=;
	b=vGNjokKNd2ANyHbiKfc+9dFMTW52ZPqqayJNw98ys6hBr0hO1K5TCWjSD7yyWSBsk8/7
	 nEWs3H+SfvvY0O1ugA42z4GKwuKjbJ7UqSVyzC+c7iQ0WnQ40a9BoBbX2AzZ9A4bnMlYv
	 RXHP3Oz+XVurVUAIbXHIkUeS7Ejs6GXeLaVjmr41sFQZBoxC+4/pxe7WA4JUyXeGuoxI5
	 7T5lzyDkOigxMdAPBmgJ/lp28LVEAWD9w8GYz0jKPOsKFjxyMbS9hCSv+nHsK3DkkL3TV
	 fJoybZiAcCIIU63TIH5YiHNs8fp6CNGxpy890o/bQ1PglLJJgNtXeJEmv8ggXu6H1TQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IjrhUmyl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E92606D807
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5E92606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IjrhUmyl
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-56431524c22so902301b6e.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:07:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793714867; cv=none;
        d=google.com; s=arc-20260327;
        b=aPrz+f9Q3x+ydRd2bfNRLHNvyOo8EOlstDKaQh50rYVPtHdWY0WXkTfqAcX5qYf+F6
         UYRxQBg7BKMNrkit7cVxLsyGKCJhdNu75HB/0Eqgr07A12y7EYa4h/Y7pHLiiNiKFT7M
         3jXOl2biMKBQQr+7dFPQHFt+I5MhwFm4GgQ2n32EHlhckoswyXqnsNpRwCN/b80z4lxi
         oeR+96Wy28+WJZb6uuInVSAe4EZNw7RKERLyDOVrg9PMvVlMjMRRHJoNnFAp4r4DA3f0
         l473TVgz4+j+7+jjJR6AZB5T7N08kLfkiAXsA/dn+4Fg7NM08CPGHe/+K5sFt4KFmo7t
         e/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ff3dJqAvXzLV6Jf16Tus2rrJ5Wh3fjFVBip1hlsQ8YQ=;
        fh=apboHd9+R1dvvCkJdZDZKmUVNsbKVTk7ZyeK9b5N4V4=;
        b=mFyiYRVl6WIQfmMICRcHhLr4G8KlAD/WiuJu6XDog/L6E063MhhRvmLYkSrfjYyl4b
         +dahKABDtMVoGJ4+dCxSyUN8k5cOK3vEUaVWT4rIvLPZa7dlCXgWV2zCt6jWVVunX89J
         fb71yrergOMu3A9Lambed4PUX0YsOkWvrfjzexahxWo9tUFErzN4bFuVFVlO5QNiWttp
         X+ur2N8hGynUFubrwMzr9Afaz43OwYcRhd8Ho/sb36BvxgVDS8h2hlG+Q1//e+d74Usm
         rI5GrVPtDQ5bWtGQ5UdD+5y7fva4OlK+UhTKVMJHr4nOjDmXyH15CP/Gu0BIQPzzfsOI
         zmSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793714867; x=1794319667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ff3dJqAvXzLV6Jf16Tus2rrJ5Wh3fjFVBip1hlsQ8YQ=;
        b=IjrhUmylo3IArRdOzsQ0pKYUWUHIRHFcyd/gn88ZI8ZpzXcUNvyo39MYXhLx6KsFRI
         B7rnJkJ3e7vRib8CUnMvC+ugEX8tvu4cvzIbgfV3Fd3JIPzdCzh3nQ6qG9CB6xsInCy3
         NqM56aEWkqTj5LHQxh8dTJUpy7c6vhmWIptp/CY7W0bADdNbFn6WVH5LWu9KmWFfWuUF
         w8NuJekHZ/vISm1ufPRrQGSbej1Y5sFaUUxlB+bZnLBThLj00UWhpVMjuIK3R13gzqjx
         zSoOO+vyF80hFJ1Nv3C624HSfHSlewuRoikqqEgiTDhea2b5q7R2/dtcimjQkpTJs6W7
         ET/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714867; x=1794319667;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ff3dJqAvXzLV6Jf16Tus2rrJ5Wh3fjFVBip1hlsQ8YQ=;
        b=LOkmQifb1LwYPadQzvL0BVqQCIOINSj7p2vGKUitu43bfgURSbOY2o3Mj1l3xfhEXK
         Mo/ysbAOJt8Dd/gQ+mEkhl++Z/cHMPIhVlZUeEMIyf1a9dm/kUgFPYfdi1YZa+dUcGYb
         /aIpCWdLbu1i5+oJeQqZr9EFEP4M6kCssyRKy/fXO7852yDHplMxh5btSgP++9MBKzSr
         HaqCcDuVIS6s0gVj13UFMYierPT09asu/aPgsap+4FSJ4tSXeWxLKIbY0/7X5EJT8h8W
         V93UYEAo3JhDvYfUfWgitVvk2P1InTW301nafT4AyfVJj2ZJOxibjqMwxPT+7nLbdXYc
         QF2g==
X-Gm-Message-State: APuU4Z/6eV2eEt8oahvhXXnzxPRqPxOOWxVIJB2MnoNuxAYHTVXPQeVo
	L9DJzwok/u+2WLHSL3J1USTeiFoe64zm0aGdWOsIZBVt0lFxKoaPJlIzbX1RN5oCwirtWIADKCb
	FwbDBFLZWecda/1Mh6J8JRY5YnO8HdlE=
X-Gm-Gg: AYBFou1z6/XbI8mZzqIBkKV12lYcGh+uQKxxJnuSoH1L9h/2p875xR2TLHaSbevg/w3
	CwAOjDTLSf7ZQK4WJX1jakGiVRrkxylV/gknjv4vA2UlHX+9q6gUseEZriZJnbhFDKQO8g6pNz+
	L+j7K5nNqmR/TN3F+PjBwqdVCmbC4QhEE1UgongQd4CS2pu/8ZoAl5jINY0qzqo2p1m8jOjm8Ja
	hyQDlXzPnfJffblZtIUTJDSYqT4jbvRIvGdDD8WqvCndQHX59oYpli8giUdklReddCIqzO+rUDE
	RNObn33LaGN6hyhtDOywGnNvEfcqguAtzbfWynIqsLiKRl31iO9OJ0fVVsb/M0zxpfst+4Oid3p
	9b009nVC1ZztKUIVzn8V8hQN+CFKsBoTzZmXNGfCkJPiZh8LoS2MxkQutq9Nq55cEr7ws1bg=
X-Received: by 2002:a05:6808:4feb:b0:55b:f890:c1d4 with SMTP id
 5614622812f47-5640dd9d633mr10549294b6e.29.1793714866562; Tue, 03 Nov 2026
 06:07:46 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103134705.867613-1-mmyangfl@gmail.com> <179371403595.488859.12039825341832560119@kernel.org>
In-Reply-To: <179371403595.488859.12039825341832560119@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Tue, 3 Nov 2026 22:07:10 +0800
X-Gm-Features: AclHuK-7jsvpM44334h9J14sjGqovuYQG5qPvLWnBWEdJcgZzhgWRX_ThjxspjE
Message-ID: <CAAXyoMOhZUCzawqorR6sOKcRd+J_h9QjNKRHd1Y9hLWKApY9KQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: motorcomm: Publish a consistent MIB sample
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 9:53=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Sequence related, cannot reliably reproduce.
