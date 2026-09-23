Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D43E49DA
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200577; cv=pass; b=PhHK0eca81Z8jSOhQ/pQKuWc1ywn8FK/yzUWAwvMBMGT/K8GBLBjMk4l6jv35D1F+iactuI/jfplZIuagAAKZC8SGgoamuYP+FpwjohtcRmrD6fYc8ylpi7L3hybi+2gPi5K1Pe2CBsdh/geZSj7PiqCMvBlCtt5ycYs6xboI94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200577; c=relaxed/simple;
	bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcLpsh7hSb3hvE7sht8lW2RGCaC4P+K0BcRVqxR8PhOi+KTO05h58stMOnk4CpTzjyHVGoMVuq0z668VWJuuOIwuF1ElnPkWpxXkWESirJ47VGt+yczGk3dr/0yRHP9pJWZnW2L6r2DSZEgGi5lg8lXf123KeldLwgUW5IKN8eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jhERV+ah; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jhERV+ah"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd046b87so1116605c88.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790200575; cv=none;
        d=google.com; s=arc-20260327;
        b=e0ea3y3w2OhMrYEhOgQn6BNuDg0KPcANnylm8sbg0ZXzyOoI5GbLSTyIcerdOaCrfd
         YxRbm+tuF5UOhdtQJOEX4pS9s9AokBd/4QaDx3+/pW1ee7pRWBrRBNCljRd9wvyVC/r5
         91fG0LixNC3G82SVonI+rhQVFI+aJIrsTf5HUXWp2XvtOQ/Cm2oVqj6g3sj/FqAoHN1D
         ncY3WBXlNhmFjjMUHybDaWe9TOHF2BGB5nkyHCC6hstJEzp70geresNqZJdEx7K+TASF
         bITOrnOjhaUJ5uxlivh3JzQ9E/lA9Ni2M1TJO564cZsSDC7TyaPDmKL63l24lB6xRgpz
         Yyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        fh=9Phha+/kRnwySNZ6eMCFuNcbMZY44eNUDeGX6H6kNso=;
        b=EzKuYNpPkwvPAZYYVDJmFf4nyDfa0TzKUQ8+JJqlGdQfggtL3UuwDCaID8mQelzq2d
         XGsjICGylRRuQL1dmiNkzfsiTnBJR1jbiMNMTu/CI9gSnc1TZzha09Ujot8pix/1VzAY
         4kAhwK4mSyQdeSC/eOXDq9tL+KStGu0rVXwD+pMnj/SVZvA91BFxJn08mQwdZ2PBWO4I
         lv4SiAFdwO99Z8XIISaUQ2bbJksCiLpgfauufSFm/HeqSDU3Ak5uTf0Yk58ayRCWbAAi
         82DLiZMeGaNp0d1pZZ7GIbg3oAO1fgkngt4WIdk/TzX8uOyGzN9cWoG727WPq8mVK+rk
         S+hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790200575; x=1790805375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        b=jhERV+ah1j9mGBVR26USwokD13NVpSAg9JCUjcXwBrC9p9Vr1rt9W0pi/t0hrVDOxu
         aECZTtKGvCBU+cOSEwl/QMsXNxyYkQ4SqMlVP5ZVbswwp9E7RdF/dTWkzexYYBLl+WMS
         vzChDhpFxb8m5Iut/lOzhKMXX+uJ9RMhJy1DBFpz2UXx5FO+748j+Qic473ENwe7Dx9O
         vM3xZC+jcyEakt+ZgT+rUXx9tG/1e0nJOfmt/gplmzGF4bi2E+fkwCE36deLp738jK6Z
         jGdFb6iZhsvc5hfyKP++Wqv6BLZ/QPI9H4ehfb+Mwcg5xFBHjd/t2rTI8pGhqBEDceHO
         Wojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200575; x=1790805375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        b=v5CzaETbhiJ4avx67JI8jDF0pgbfvIJYaRZr525i1hMRSSsdzRXaXotzYsRVfRVSpt
         TYcypvBLi1IFV27fCJLL8kxdzrwItT2ZSXgEps9ljDLSpA3VleCV5Ug5Mlg8jon/sHNG
         qevOLx429YSLiDxw5jzZIwqCMfFNw2SPEhPCf7GKxMpTJ2oGtcksPDsdlkA1e7oHqb5O
         2iitFnOY68J6FUenie5qzyBCVuwP8gjxOHE19fjZ79cWd/zITFbQ+BaDZs7sLh1uShFH
         3xOsqo9rGp0R3wHgtA6kyOeKEwsw1PjnPsc5m6j1H0FPvV85A7G28GDHJ3Rn7zeOHGZi
         XQ1g==
X-Forwarded-Encrypted: i=1; AKwUvBxYifuuCsI7mIt2SWN9wAeEk+4TtzeZIjHys+JMVAAHFfRvuYc7T2Z28Wv9bjUORAQLo/gA+GA=@vger.kernel.org
X-Gm-Message-State: AFuF++kbMffw/uZeq3uHfKaWKqptO5DO3xrLmyq009630aHrw1TdltWE
	KLJZDyLh7H2NhA+Kh59jngSkTKva6soaAPlLCXdld2b0E1xeRmVuSNAMYmieU0i04pYCS5G0Vnt
	alRuPXhXvNEY9++vevHp8XlA76vE/AwI+UttLGBH6
X-Gm-Gg: AYBFou2uhUinWCBqEL/1tA9E4pAaPI6gkR/meP/q04A/CxpCT84skTOx4+7lJUGjwXD
	Y/4/JZZ7eCuYuWCj+1zGT0sM7j3OhPlOehzu/mESQYEgGQ0bVHTWtWLG4GFZBF9zWtiUZ/nyB3t
	QdF5PEy/g3ZROwP5rAkCNOXp6hRahwi/PswMbMt735/uQDdNHzFTAUhpWf/wn9yrJRKjZAuTUKE
	/Z5aj+3SMKKaRFevlQCHra/4gBAf4CoJbl+k8Uz/IPyGW3bt99k8v3RAwHKM86TWOk7vyRt1Q8D
	HcPoomwFo2D3qv+ujj280FyHMKg0kIBLSZre0FVri6b+qXB/cIo7vTjJxMVDYBmmSoXEvEv5Qst
	YDT+G7LNC0ChPXInxWfi2NHNHpdjv5MgTCxpofIio3TBWmjCI9WeJcTCt2LM/EF1i9YVquXUCeu
	uRU+hEro/BCxnzttoV+069RlfYLypjFgGT
X-Received: by 2002:a05:7022:7f0b:b0:144:fc5b:2121 with SMTP id
 a92af1059eb24-1450404ae72mr299833c88.17.1790200574381; Wed, 23 Sep 2026
 14:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com> <20260922122721.3568295-8-edumazet@google.com>
In-Reply-To: <20260922122721.3568295-8-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 23 Sep 2026 14:56:02 -0700
X-Gm-Features: AcwNN1UWUSy_lx2AHJFjvaY6A3c0oHWBHfbbzxVQVy2Suh__OfqRbZYSRYG6LtY
Message-ID: <CAAVpQUDu7ANPKOfgw=xsphS7BvBr4fdJ_+k5z28ZMK=a4j+bcQ@mail.gmail.com>
Subject: Re: [PATCH net-next 7/9] nvme-tcp: use sk_clear_nospace()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 5:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Use the new helpers instead of open coding the SOCK_NOSPACE
> manipulation, so that TCP can later maintain a cheaper private
> copy of this bit.
>
> No functional change intended.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
