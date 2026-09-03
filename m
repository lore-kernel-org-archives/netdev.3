Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CA74C6F15
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447641; cv=none; b=crWrg7rYa55hRp4kIr08iSZaozc6bddCqwG8NEQS+CDK0KkgwpqNAwRRPapQKthspyqmKYu7lP43UT4WSdrysRtjbp49oMfR9S2X28jqusIEInFs4OMHyx9KDnmQ3yGaz0cd6OrxRdGpLHouR1EaDeePtwpiEu/uoac9MZdQWb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447641; c=relaxed/simple;
	bh=rEiGuSHpvriUqLhToDYgt8FFSKdOnEQptXqAy0J5nV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHKAYdHYOUnd1C4EjkTh1A2HSvHhAuL3SDkfzIu0BffMiBoe2DqMHsLPGOhisZDCTdnnXbptMpmSIt7Z03KoEldW3g45ceQf/eDI7haiycHf5hcVo0pOQb+ZGyEVLOxoZS7LvC7lgYk/lYzSTechf3uqkxUVCavsJPt06wkNsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5c7d4c663e9so1536007e0c.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 08:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788447638; x=1789052438;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E7IpOefrxKq1W8FoUG8547LazHe9zeJ3Q1wTKXTvt3Y=;
        b=G4XxkubRWLYCKdGzqDBkPrDq71f7mR7ghjv11FGMConsRhpMYZVSusQlezEdsz1oor
         W1agbcVPBozLrzkxiiKsKa+xrgg0Ank1xt+qV9ZeWiEyIgWBy/2oZ9qZfwsHXoERoCuM
         TexN9CDuXDnFN4c/PfWD1uJ3tY7kVJzbQIBm+3ynm9fMIVBxNOd4sOhNhP9Ei3jat9H4
         yqO5cLJuUGAmDVxuGmhgiAyuoZaXDx1b+9vQFMps8D5/+MStD87CRmTwwe3HT9YbjMD0
         15e3Gmbd0zOc3DM0KvVIT++y9VJIKJRIqTgYYDYNNVwkPpGB/JmkG2bDeccvnSKoxHQ+
         foVw==
X-Forwarded-Encrypted: i=1; AKwUvBwKY19PPtrXg3VA6GmHKqfZ5JqM5h+4zDP9VecPPzc9pY4dRTuVfLBzGQ78BUbD9FJ+bjwcTgc=@vger.kernel.org
X-Gm-Message-State: AFuF++mc8r6skOa1ESqUkQ5WTkMnjULQg+7V8PtyrFGJVWcxqTwgXMNi
	Lf7F8sdQjNN1OZh5KV5BMEOdHQikJ1lAG7raJGLJTmvi8cZiGySO64rAc0lX15uktUM=
X-Gm-Gg: AYBFou12yUsnT719gXUyf4PEzGJqRG1Qw37HnokKs6URa95ypt/SZl6ltj490hqdTUP
	UZNDu2d8S3Vdz6bW7vkzq7lm2YizjmeYRVDdPlbZeNOmoP31QTrNL//Ki0AvjwL+qHHCtk2Nmep
	QQz209YAlqD6wAEc4fNTnzEg4Jc4Kd3xZKAlfN51plZawtnODMAb4QyddKucpWC8BspBDi2X4R3
	otDMbngy3FCKRnkePgVEWyJpk5qGomjirIlnNloGhWN/meHPU78LLrwIsBVeAEqwBdKP3hIW27P
	/+wyfKtrDkbLj/jWusWPmBYvXIrVJbi9sgupVWNsmMhcc37fUKNPoXgdbQtPtUP6pebpz4/xMJa
	wTuQmDTudvobnuSkdKKzk4/u2ljy12rmKxVJ/kBqs0dKnXdHgJ65196J6NzuJtRROUzyLqS2Bxr
	34cco/DbeCmEfW39Un3rn0cAeOyglbx+AX4NMEMd13YpQp5Gpo+31Wa4qlaiz1awyDSSxZnam53
	nSRZiIpg9Rhm7ne5AT3Mw+lQg==
X-Received: by 2002:a05:6122:d96:b0:5bf:9461:91d with SMTP id 71dfb90a1353d-5c7d27b5697mr5568673e0c.5.1788447636755;
        Thu, 03 Sep 2026 08:00:36 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7cd5da30asm4664925e0c.0.2026.09.03.08.00.32
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 08:00:34 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-77bf3334d14so1706683137.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 08:00:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzg1JNX3cz1ee6B6djA3mIeM9oyjQmHSAS/VtolFGQnNsMnHcqDzfL1ShqW0C7s6HodV0FJlTM=@vger.kernel.org
X-Received: by 2002:a67:e704:0:b0:77c:6bdc:824f with SMTP id
 ada2fe7eead31-78a1f1d4903mr5471476137.1.1788447632007; Thu, 03 Sep 2026
 08:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e481b6de46cecc6ea604ae165272c667274cc621.1788437140.git.geert+renesas@glider.be>
 <abec6831-d344-489d-b70c-1e5dd4d43c2d@lunn.ch>
In-Reply-To: <abec6831-d344-489d-b70c-1e5dd4d43c2d@lunn.ch>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 Sep 2026 17:00:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV98HRJEy2s824VTnXXDMGcfuMN-s0RFertQ4ymjPyp4w@mail.gmail.com>
X-Gm-Features: AcwNN1XbkTCwkdzzCUI--td_POZtF6rqFVqNEudn1e6PV9_tB5kgdfNf5dSHIDE
Message-ID: <CAMuHMdV98HRJEy2s824VTnXXDMGcfuMN-s0RFertQ4ymjPyp4w@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: ti: davinci_mdio: Drop commas after match
 table sentinels
To: Andrew Lunn <andrew@lunn.ch>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-omap@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Thu, 3 Sept 2026 at 16:38, Andrew Lunn <andrew@lunn.ch> wrote:
> On Thu, Sep 03, 2026 at 02:06:47PM +0200, Geert Uytterhoeven wrote:
> > It does not make sense to have a comma after a sentinel, as any new
> > elements must be added before the sentinel.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> net-next.

Bummer. I have added a check to my checkpatch wrapper script,
so hopefully this was the last time I made that mistake ;-)

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
