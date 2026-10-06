Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AEA424646
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294295; cv=none; b=ZbKNZeztJT8TsjMIoJwRSUt5MpOo2zF3h0bUnwlo0zHmeCRO8cQTv1c5GvlxWzYSbIwhInGcglrVeZF5PgC66zNHVs2GgefabxoIsHtzMpSS8h63kwaJbUQ3OsQsJoKgS4YAD3YApoWJx9ibwq+QhwamuAR4Xwk7BecaWPAIXX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294295; c=relaxed/simple;
	bh=V6D+x0smronF3g8z0odwioKw+hnp+0IegOI8i9Pr8zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7C4GwDQuOToV+QvOIrgtjY7HdgnNRY2xchJ34ROmQZZ1im24xrnH/3M87HroOcvWdbzaviYBUVhK7rnp+Vt2RCD9sZE+49CBxos1OkyNT7N5oBjkAG0RPRUmsUdZ93PUOkc0rtkaEtTDuYB3iZHBMsapux3rvT84+X6fEllF10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2kERUVC; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2kERUVC"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbee846deecso2106778a12.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791294294; x=1791899094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6D+x0smronF3g8z0odwioKw+hnp+0IegOI8i9Pr8zs=;
        b=R2kERUVC1lPabWV9cobFOVlan2aLLZgbvkkjsf9jNYMdbMLQ4Jcv+i3ofAfkFj2bVJ
         MIP2y4QQ2iLzwf40ABu7ip2SCEI32+QQ6sB9MsCwtistRdxJkc+7QaI8jCaOptKF4ZGO
         EdkBfFaMMFWodY3TBp0vrtMYQJwKpjXr7XrMB1pjkjHkEuXZGucCmHo7e4ycaY/7RI+E
         UL0T+A2fj/wPQtH07HdnLLxv57ppxdnTbfqK4xDOMqPNHwY/Vh0j5wl23z9T6SaAu2Dr
         dLooCMkh4nrGFHpzwK8V3wZ3NJ1yGUcuy/4LTIDVpvsKrCooPt6ZodO4urvCD7l4XtCL
         G7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791294294; x=1791899094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6D+x0smronF3g8z0odwioKw+hnp+0IegOI8i9Pr8zs=;
        b=eW72IUbU9MxU86vCPwZFU1IEp3bgQfBBjDW8YYx0wXrr89N/g/HG3lx4aF+T7z4Iat
         TQbj3OGN63LVZAIx4RJwRwBJyejgeo+VQXoTvPWW+w38JxWUdyEiPriTAM7fjoCWpuwZ
         ycWAsvqRUnjOpOjQXhmd5B7Gp9bIOrAN8IHXOMI4sp4JDXEcR+oqEb98me5pDSneGukX
         TRUX/7pWXHDoXROtSduIwOh524kvR9ptBa2M6D205zqpr/m1rQLjv1Vn4H/gtzpw0bI2
         dNjUbLwZ5z0pUH2X202zS7XZZyeIwE1lB3Dy1W7c5nwPXOyogvD8TDQSTa6bGuUJ7+1k
         fRWQ==
X-Gm-Message-State: AFuF++m+4IEFoTt/5j37NEhleQU5aODlSSQz90NSnTHY264Nldy7oSNX
	NMNFoyJ6z42MaeU40FlHaqyT/5T0MBki7raaI7NHN0jNV5qpZJ1OlZUp
X-Gm-Gg: AYBFou2efrRO0/VQIAJLEqN11LM+l6I+9RiPeKqJ6lAsY7rOIPS55Svi9+64yzOdalJ
	SFhtjdTSJr7ESjJKoZ3tM1OYGlNzK/YR9lRaFOxhVa3lGU4EMLLJe+0PX7REoQ90gOdSmS5hnwT
	EHwNvN9u1KFjqPeWJnPOgLqiaprNZ79sGLNtmLq9poNpdma575IIiFXDNbDBAMMUoe+89gwnP4W
	TA/55zpBkMZ5x66G/1q/kL6Qo32/YL3gX1IvG2BeZn4fo28hvH5lDWZKtIv7Egn19xztdkFBMBp
	RtZxSkApYj9StKKlJFcg5fUJiwnt/zQqUIP4oPwCZ26HSvWzqryftmoRjUrEb/iLfhS8PzWTFvm
	xpLBtXsZUz8GTH1IyKbswXXOKsR1cYwFcHEmQYRdO/3gJ5HJkCiTpKHYF1cC0RnD9jQMjpSkf2K
	pzI+QT7ZEXPs6DOvmhoejvsXyPvu2NTIBVOpW+P645wrvG4laeYO0CE2Y4O2Cl4a2QXTZUnE4x3
	+74xYizt4Dqr+2bKg==
X-Received: by 2002:a05:6a21:1b8a:b0:3dd:a197:ede6 with SMTP id adf61e73a8af0-3e0d6b61e4dmr9572185637.53.1791294293744;
        Tue, 06 Oct 2026 06:44:53 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0968d432sm4911520b3a.6.2026.10.06.06.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 06:44:53 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	stephen@networkplumber.org,
	razor@blackwall.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev
Subject: Re: [PATCH iproute2-next 0/2] bridge: add cfm command
Date: Tue,  6 Oct 2026 13:44:41 +0000
Message-ID: <20261006134441.3696739-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006104249.GA643161@shredder>
References: <20261006104249.GA643161@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Oct 06, 2026 at 10:42:49AM +0000, Ido Schimmel wrote:
> Please elaborate on the motivation: What is your interest in CFM? Are
> you using it in production? Does anyone? Who needs this in iproute2?
> What is missing from Microchip's cfm tool?
>
> Looking at the kernel log, since CFM was merged six years ago, no new
> features were added and the only bug fixes are for issues found by
> static checkers and LLMs with no reviews from the original authors.
> There are also no selftests.
>
> If nobody cares about CFM or uses it, then I would prefer to start
> deprecating it instead of accumulating more code that needs to be
> maintained and that nobody is going to use.

Hi Ido,

Thanks for asking directly. Short answer: I don't run CFM in
production and I don't know anyone who does.

How I got here: I work on BFD (FRR's bfdd and an XDP BFD data plane)
and was looking at how other liveness protocols are handled on Linux.
CFM in the bridge had no iproute2 support, so I wrote it. I didn't
check first whether anyone needed it, and I should have.

Testing it, I found the bridge CFM does not keep its own timing at the
short intervals: with a 3.3 ms CCM interval it sends every ~5 ms and
declares loss after about 8 intervals instead of 3.5, because the
timers are delayed works in jiffies. The ccm-tx period also overflows
a u32 above 4294 s, and interval "none" with CC enabled rearms the work
with no delay. I think that fits what you describe: anyone running
the short intervals would have hit the first one.

Microchip's cfm tool covers configuration and show; what it does not
have is being packaged anywhere and a monitor for events. That alone
is not a strong reason to carry 1300 lines in iproute2.

So I'm fine with dropping this series. Horatiu, do you know of anyone
using bridge CFM? If nobody does, I'm also fine with deprecating it,
and I can help with that if you want.

The same goes for my net-next series "net: bridge: cfm: notify
userspace on CFM config changes", which only makes sense if CFM
stays; I'll leave it until this is settled.

Thanks,
Abdul Wasey
