Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1A279DB1
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 03:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048192; cv=none; b=NuYSvej9pUYcUr1WrswRqA78pCKUz8NXi2MvqUy0/lWiiR9CKE+H30WVvAyP0QZo0XwvX5MD/AVlFmRYh17FgbX21oj5qb+BXMqSSwNWdVx3uOAqMoTJo88MgX6U8B1czvN6W8xP1cf8yICzDPU1QK+dQJlvXhmmPDi/XdAbBy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048192; c=relaxed/simple;
	bh=RzFOag5CHicLMswhXD5eT0XX0xDFqASebsK3QgKd6QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L94a2cy6WrQGvV1KmP26fVKFJaPzj1kuCnoajhungDX3Ol+A9I+voAnLJG22dY9oFJkSDRw7UvngBVdd0QM49PPEjbdSpAHqBx61oXGaxc6K3JtNDbgECIAwI5m9uNIcyMk2dlS6LMn9yU49izvj/aLx6QVh+hWk7nXWRo0IhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpR0kmd6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpR0kmd6"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so487297a12.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790048191; x=1790652991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RzFOag5CHicLMswhXD5eT0XX0xDFqASebsK3QgKd6QM=;
        b=jpR0kmd6hBsXzt5kU2cIRrMTCQ0mf1ox/8z8ElW0OttJvGEoTd7mvYKGsLCKg81/pV
         JgtxOtrS9/ZmfhE12DjVfiJxbI13Ezzv+AqqrOaYdq1rh2sESudCuY5bQzDczlcnj16R
         kjPNxWNAixPgrsXKsbWUFr33xYZf2S7/2KFMQxlkZ/+jQAKRaLexsB+4Palc/4ghI6aV
         1Sjl+vKmuIeIuWCukbnhfiFzV9US0pKdNv9edWIQRkL53smo+yJhaIKqtIau55tFzbuS
         v4MaVY2IINus4RO9I7CePirdZy55vCJHujX5D4E4FZi8o/j5h27EGB7af/Gd24qzpcil
         AH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790048191; x=1790652991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RzFOag5CHicLMswhXD5eT0XX0xDFqASebsK3QgKd6QM=;
        b=LBUxqCIEWo7BuqXn3XKPLXhNfiEYYCQ8M61HsYYtLTNWqYUKhP3PYTUxUvLPHPc6AH
         ySnC1WFqFwT7Ug4iP+JDawIyk/ippMIWf7gJmLUWvXR71UgNeAXg6MxeSZKaV1ifP6FV
         45dC0ctjjrypVsqCn4sRccPR2pXYAVOPoLd/2TNHvHm55Aoyw1XL8ofP4ovswom3KBNQ
         zraxVFU2CPCOio7JoTAJVicn59eEqVtrxuBIXaJmbWLiReeu4SFmSKCbB+v/cm77GJj0
         vX65L8YlUqNF+EA8K/+r4wA+u6BjFmBBiizoqhLQQD2Sl2bs6zbq87fX5qscWTQ6Wqjc
         l+hA==
X-Gm-Message-State: AFuF++laLHmXTeh8C27yizI2q+3xuyuJgG5PY6hiQHnYQp+8zlw4dsrJ
	StBadBHTUOdfWGNOkWDXJ+vAoUDRSTxadJSTAlviD4Q9uFroKzH4770a
X-Gm-Gg: AYBFou2WJa6T9YKtrHy7b/rpdaHS8lwgadWBP3xK3HZzcGJtwJXkTt8RjpWkAiL58UU
	Dra16ufjkUjCeO3J2uYDMpDX9q5QAl+7kHDc6XJSKXCuzkgdOMqpB9FV8lmpdir4kvzWoc7XAFd
	K8URB2u3TXV2m9iGakeMihO0+cTu8yELA8v1x16swIjPjuI/z/uIFpHnCQPSA8lOUClyu/9jkWY
	TrlIU6QILJ3jHioj/wKpSpUirNgkLYO3AFuPrjK03lxXbpf3JfyC60dsYpSHqzbFBDrBpacAxwQ
	ow5oVm83M57hV/Urd+NmPyxeD4mHJA+DBeOqJf1qUD7HRM13FPeaOGZmZyE0M0DsLnBewHP8sLH
	L4qOn4UHO48y2crSJixPjPVYvwRvk4lppzV1FsrJl2PI9NKT4DLG3edxdIHHelh6e7Rea7pW//F
	PCbnUz6peJBMfZK50MhsYnpr1EZFXIS7t0gK4f8K/8YT6QoPegC3WiGKVfWVITD9ouedZ6
X-Received: by 2002:a05:6a20:72a9:b0:3db:752:f89f with SMTP id adf61e73a8af0-3dde0111e01mr1467764637.2.1790048190604;
        Mon, 21 Sep 2026 20:36:30 -0700 (PDT)
Received: from localhost ([180.184.77.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc756b48cfbsm150925a12.24.2026.09.21.20.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 20:36:30 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org,
	Dairui Zhang <zhangdairui@gmail.com>
Subject: Re: [PATCH net] af_packet: fix integer overflow in prb_calc_retire_blk_tmo()
Date: Tue, 22 Sep 2026 11:36:27 +0800
Message-ID: <20260922033627.1443968-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <willemdebruijn.kernel.1b65de0a75434@gmail.com>
References: <willemdebruijn.kernel.1b65de0a75434@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Willem de Bruijn wrote:
> Code Looks good to me. Thanks.
>
> As Fixes tag do prefer original commit f6fb8f100b80 ("af-packet:
> TPACKET_V3 flexible buffer implementation.")

Thanks for the quick review, and for the history correction - the
unsigned short truncation detail is exactly the kind of thing I
couldn't have known without your pointer. I'll respin as v2 with
Fixes: pointing at f6fb8f100b80 and the pre-hrtimer effect
described as you outlined, after the 24h wait.

Thanks,
Dairui Zhang
