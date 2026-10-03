Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2E13515CF
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068737; cv=none; b=TpymcPp8gn7E6JiRSkn6t8rpbZuhgdwBVJdtFd/hGeNv575hMFmZKVXSkI6fgCu4iIYsNIZExZQtj6njDAW7eVBLgPNrtiS84pxXRYTWminZ7FBu+Z4i0swUJZR62n7RZUWCbYHgHoF0QqZKoQwNWaR55oSbEQMs7VdO/LnaeEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068737; c=relaxed/simple;
	bh=Rkky40wGVQtWpZiRdUGCgO6wPZ8GvQJgk1hyFS74oPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHxdwZjrX8A+oU6Ch2sQmGLWibH5tskeqPdHEZNB+ZIByP8jkIYwED1PX3CAm7WrAlEB+f2ANHlV7xfbvNZm0EZT5or7q/JS+kJmgx4KiOaaBLyUQNtYNS84ll//0yojxT6C5V5b6SaFvvwt+4Jnrzp2frBjcJ5Dm/yclyrpzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQyWCSf1; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQyWCSf1"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-344447f9c3dso307608eec.0
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 16:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791068735; x=1791673535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nAsZ9nqlfLC/NXKIok2LcpdNpmbchDX1EXb8UFtVzig=;
        b=NQyWCSf1N0vFbniJEPoFBN13bijVhblM4hn73XtK04Wu8bowpb3WV9+9J7nNK+BVNB
         fssMNJ5p0Cc1U2KOF7Jt09aAWwUrZlqcFagGcuXfiJ+CaSQSPMsSB5ffrXSsPP6QYPPp
         zhGL6G0HK14niqHiAtt6PR/unJeXQRDnRv7FBmsKD6VO/fFlsApGFoq2edaEZTgUIIum
         bqpvuxR8gTFdW8q9UuHgbHOrb3cVikbboVMzrD/7oLTxCwuQeX0QqD+qJiumF4wy3Ity
         5emPwSi1Ks2doDl7xKimI6L6RLTJxWYHjSZIe2EBKcSlYjozY2J1feofH3slvxD5bqrW
         Wwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791068735; x=1791673535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nAsZ9nqlfLC/NXKIok2LcpdNpmbchDX1EXb8UFtVzig=;
        b=BtQMF9jaB0YB5ArA/SElJKVD2K02J/9jFh3f6Pu+H9rkTlUA+3EnYHXgNDdTloEmNO
         LAS6lGsMIeDc9zvpeyixsK4uACZu9TdLW1WzmeaG3jPyPlncKYJN/ZcRP6cKkAVHoM9c
         GrA8vJcnAkT95Zs+CEOYcGKL3RG2oiLz27PrgHAzA26A+X2hGOi6rNsIxaWdPe2B9Ydj
         s4ls4GVvkZY4Gh3bg3Ghivl9B9J95bPw7HUUWTu/XLbI0QSDateAfOJx8gKAld0OMgc9
         RjMSAanVchCW2B07/fzXc0jpejsZp4dp2ilmYbSqmkEzDzBQeNAWjL3f9wHbp4tIfEEq
         UpbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWGxsJVK8v8jYIPvkmV0ZUVRxtOSopAXLj7tc160FalDlaeLuqSLm2t1Zem9xZ1kkPZ2BnRD0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqPSjuvXIuxEjMbdmu1JzujdNjiMMKRI3bofjfWmZdUFwbydb9
	9qonmCcrk/84/4m34g96/1FwRGuaoAGkgxblHe1mPW1c4P0iPIckl8/I
X-Gm-Gg: AYBFou2wBVXX3eIEkFshYnlym9kgDBYdzzNrT0RJnUvyD6lnGOcDnO5fnAf34UGLOem
	wLvyTWGWWZthygNm5Ra7niwaPG5NuQqgUUg864lHmGBIIfGQ/A0iHTV9S4xPZZ4TwJc6Ih2vpY/
	aQF8PrfLEg6YL+CXj+PAF72oGiygnpuPaK9w+LnYun2Cd+RZ43t/z/sT97zm+GhtWmnjcelmEV5
	Uh6tuFf25Pp0/8QQfHUkpKRr7UiajRQn9vFhkQ4ny7yAowKAR06qO37Wk7eCmUnjkpVutKtPyXe
	YvgK78xDEKlVGIsDNGfYEvMxj/Lkaglf4vz+2SALJPRE6A4PKkSggZI/52Z/UJqMxGuORW0Jiyh
	rKnaa6bojlgUvdHimXoFMSE1cUY1bdUZApZgsM/B8FZ9eYuvsJhLoMfrqfulKi+htxHSdVDCOav
	zB9VKExqLlo7UDjJsiE1U6qSBhEr0k63PRDMoK9d1i7IpiT41KBOiusq71FTq9LUF1IMt2P7lec
	mshdleh4289tkmKTfMABrxtIYschBmeTLpUGvVzBw0WPc1Lgk4iEfPm/ix5eg==
X-Received: by 2002:a05:7300:fe81:b0:343:bcfc:fd1 with SMTP id 5a478bee46e88-34f219aaea3mr7391278eec.39.1791068735023;
        Sat, 03 Oct 2026 16:05:35 -0700 (PDT)
Received: from s1lverbox.orsomething.local (47-144-201-183.lsan.ca.frontiernet.net. [47.144.201.183])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127021706sm57043eec.3.2026.10.03.16.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 16:05:34 -0700 (PDT)
From: Jean-Paul Sergent <jpsergent@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Jean-Paul Sergent <jpsergent@gmail.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>
Subject: Re: [Bug Report] fortify false-positive + real overread in skb_metadata_dst_cmp (geneve, gro_cell_poll)
Date: Sat,  3 Oct 2026 16:05:33 -0700
Message-ID: <20261003230533.1650829-1-jpsergent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026-10-03-1-daily-reply-0028-re-skb-metadata-dst-cmp-fixes-tag@kernel.org>
References: <20261003005449.2675.1@jpsergent.gmail.com> <2026-10-03-1-daily-reply-0028-re-skb-metadata-dst-cmp-fixes-tag@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 03, 2026 at 06:33:09PM -0400, Sasha Levin wrote:
> I've queued that one for 6.18: 6.18 has the counted_by annotation it trips on.

Thanks for queueing the tun_dst_unclone fix for 6.18.

> For your skb_metadata_dst_cmp() patch, the Fixes: tag should be ce87fc6ce3f9
> ("gro: Make GRO aware of lightweight tunnels."), not 69050f8d6d07 ("treewide:
> Replace kmalloc with kmalloc_obj for non-scalar types"). The overread predates
> kmalloc_flex, and 6.18 has no kmalloc_flex at all, so with the current tag the
> fix would miss 6.18, which is the tree that panics for you, and the older
> trees, where the overread is silent.

Agreed that 69050f8d6d07 is wrong - Ilya pointed that out earlier today as
well (our messages crossed in flight).

Looking at the git history, the options_len equality check that prevents the
overread was actually present in ce87fc6ce3f9 itself. It was dropped later by
commit 3fcece12bc1b ("net: store port/representator id in metadata_dst") when
skb_metadata_dst_cmp() was refactored into a type switch.

So the overread was introduced in 3fcece12bc1b (2017). v3 carries:

  Fixes: 3fcece12bc1b ("net: store port/representator id in metadata_dst")

Since 3fcece12bc1b is present in 6.18 and all active stable trees, this reaches
both 6.18 and the older trees. It also means the patch applies cleanly exactly
on the trees that have the bug - in 4.5-4.12 the check is still present and the
patch would not apply there.

Unless you see any issue with using 3fcece12bc1b, I will post v3 with that tag
once the 24-hour waiting window from v2 closes.

-- 
Jean-Paul Sergent
