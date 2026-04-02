Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9376F35F8B7
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153863; cv=pass; b=OynKjs9e033PQ1IqFOde42Mm3pmsNZEhlMnJRmKedKw/lzgYUSLay+KeK2D05RBgLifZTR8XD3H3Qvp70/HUll05pimHyKEseJBbr5xzG9EzLzt8GJKfEnsT0H71F6oqzSxnVytH+UaxqMn//WW1wyK3SofLQwUelGZec4pSmiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153863; c=relaxed/simple;
	bh=UzeTID8TvfzRO0ZTqLHzXNSmnUg5WytpFzJJVtQy7Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPTkWUZIC4cDMANpad1i4dClkSbx8MnL+P/xKQtNlYJ6jUFnFkuqEIcLw/HdIWxuynszaoTKDlGsyoAMP+v5GnKlqPf0AjuzTfcbpquBKW/CEsFkoG0vLg2qaf+g+4bJdc3FcLjHPh91IBKRc0b6/tkFmpjvDQ9RuEfcmGsWjmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX77Y+Kf; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX77Y+Kf"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4645dde00a7so1737408b6e.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 11:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775153861; cv=none;
        d=google.com; s=arc-20240605;
        b=IgTxvd2GnU3hSgljMtrCbND9BoEbNKHjWXVmol+ELgsNIcgdP7dtjRKPNGIH44rU/R
         h0zmPY04E8OAEqiaOXq11XzV1MruOzltuer8H1ZQIDAvtF1gMNLbDL8CbTXdK+6zoPbA
         WNUw7TbCFHhnaWt2UNPYo6tXBNApBMk2OTj8R90rrGKv2DfoQnEcBESeodF/1xaZkcCd
         +U4BZLJUi4ocS4gDJ5FRD59E89BREUp6opTsxl5U7Gjvcr+hmcbH+6SsOKJjFT2ePo9n
         rkx4kSBEakICWtm0hF10j6CwwPKsKGPT3vqG4BMVsYa7RLsOnW8YbiyH8x/OJTwlpRyB
         RwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UzeTID8TvfzRO0ZTqLHzXNSmnUg5WytpFzJJVtQy7Ds=;
        fh=sL/NF5ryEgfLDVRgfuubhZOHXFp10eyxR/kEIprmbi8=;
        b=iq6wj2r0aBIoOFT8IuCd4EFsK9wroI0RyvIUmjPb8EYCgg0yGnst38zdcj1qwpZ2id
         UQ4MzAkno0bROL9hM5obxHwPrtbaChpWg9PnueDOObxK6W9W9qR2cJv7o1wTPddOAdsx
         WqQCk6BhgLvITUu7P1JaJhesUm1GA2G/DgaDjqlBspLMfOYzKoZi4SUBSsgOUxPSKOzQ
         2RcrQxVSgONLaX/ccYALc3jQg30GqlKwnXkC17pIdqdE2HfPFA1pim2LCU7a/WC3D8Wd
         jlWh8HN0DW5GrFeJ4ALJwHIS0cqo73/oucQAyIPC7VTZFMNKn76rzoVAa6E/2OzrRqAd
         U4Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775153861; x=1775758661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UzeTID8TvfzRO0ZTqLHzXNSmnUg5WytpFzJJVtQy7Ds=;
        b=fX77Y+KffVQcJIsC5buewyfb7wmNnBc/6SeoYd+Bf3T8dW/W+Xp9zmiZU++yisJqHT
         znB7RhMm//OlcqG2y4VDb7FIcfQYfd62gf0Ak3o4oygD+WUsO6EntN34kKoiFE4iSoqo
         KGJYG1R86BV8IePQICWCIeK5tYASLjcYGchV9xzytStjm1dQN8sxCkl+agCS4wdf3oYM
         ndac8SZ217J3iA748zVqj/cjqntXp0S31IWvrNSCTje0uiAyeBr9rbXU+MECBlUvXyEz
         XoC0FtJ6LHkuYfxIBZ4jVbmj9BBTvL2ml7M0AEpxki5vgr0xn8zjXcUxRwe4PuaTFFUD
         yRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775153861; x=1775758661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzeTID8TvfzRO0ZTqLHzXNSmnUg5WytpFzJJVtQy7Ds=;
        b=FrJ5wI6CMgTTsQMuAYE9XLE6/evEAIGLOwKNMhXyEoU4M0RXM88QeSWBfcFJk0v9cJ
         RkOBso+nJGk2CvpLmw0+ufMfDW41HgGnMAafnYwrWoA6dtW473ulOxm6ojRyLa47PIGd
         pB+3drTL5UMobMrmUyHHs7D96EVqKsIVKsDejS8ibIPvQPfMz2by0INhGTlavokz58rq
         wEVMHJs1Y4CHxEml6lDF8kVdM+SjuViEgLz+g/EKUZ0hCNOF9RMYMzP6NytU1Ncw2W2q
         Yny+Jq9DVplRMl1RdbGwzGHNfPCJKLItHGJkdH2HYvXu/2xYz0vp6hvVN4tu7FXYIPRW
         xknQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD6MZDwciuryxJUd0jddflSisMXljGMlFJizcvXQhMLUiHICRfXbfXdGh8Lw090fe6v+Y0KeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymsSRyQrIlJarmNCSQJrE8XJDdpri5ix4WPtaJZ12rK+8OMEEM
	uvx4Pv2cVfPonP90MX/25DVkTOf9NwNb7EzBKWv1LmGqSLKXwGAjsUoqAO+sZcWEUIfTZzTepeX
	lmdTT2Q/RDqsKakCZZ0WOzyY4GV9VQ54=
X-Gm-Gg: ATEYQzyGd5il8cP5yRXLxwiyFbtn4m+Nla+epqe8G0K83ewNDBbMlQK9LKwCJ7xRWIN
	0eyyw1Xyg2Y5idLHMwPN++zfnhGnhR48i2QnY1CsxUcgl9uHW6eaef+KouqZhnRfF67ymZarXvO
	s2dDubyAtiB6QZh5r2vdHy5ayBBYbKhPFX0IKj5FhfjUnfImwGGYJeFF6gqzPGX1J4h4eC+kJTr
	cmwVRGDLTffZYh2N/y9R7Aic9qnc/c14rJzWpV+COvV4QMGKIvFXAxXUhC2PPzlqKGEsdL+sP9O
	NO2oEp9HKoUmx1HXwMbB29Jn6NMvAFZUR3nrsK31w6S7TmdS5tVJFNJOTlsB8y1r6o9KghyjFj9
	mSWEmxaWi5UFVLO4ynCw56Nw=
X-Received: by 2002:a05:6820:5389:b0:67d:875d:c83a with SMTP id
 006d021491bc7-680f7e9625dmr1265844eaf.7.1775153861359; Thu, 02 Apr 2026
 11:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328213338.450601-1-nickgarlis@gmail.com> <20260401194553.6e8a17f8@kernel.org>
 <CA+jwDR=9UgxAW828FF4geu8RukGyi7OLTS0ShVr4S8-36SWamw@mail.gmail.com> <CAAVpQUDPjpiC_rSx+ry5o0KLfEWPg4VEiN60ihkF9NwrOX_n1Q@mail.gmail.com>
In-Reply-To: <CAAVpQUDPjpiC_rSx+ry5o0KLfEWPg4VEiN60ihkF9NwrOX_n1Q@mail.gmail.com>
From: Nikolaos Gkarlis <nickgarlis@gmail.com>
Date: Thu, 2 Apr 2026 20:17:29 +0200
X-Gm-Features: AQROBzBTKSioxvYB4_7DPPTf352Ak5A8VJCWJYz8m1Qyx-oGr2jJNXzJoXtvF3E
Message-ID: <CA+jwDRkFfhVC561ob10p_ZitbcpgZ7_uq+AVgM9efB9twoXgZA@mail.gmail.com>
Subject: Re: [PATCH net v4] rtnetlink: add missing netlink_ns_capable() check
 for peer netns
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Let's focus on the fix in net.git.

> Also, I don't want to hide rtnl_nets_add() in a helper.

I've now submitted v5. Thanks for reviewing, and apologies
for the detour.
