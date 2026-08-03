Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F4376A08
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765080; cv=pass; b=A30nRuG0ZCmtqmA6e+wzbeC5hBTgKwJL7ehuY8rFYgXUGAU8M5BexsWzSV7hAWlUS+72TFf3PZVUB0DclYr7/WJvnHXBOgxaXzBcmyOYSudVeOhbGK/Zamu15/8vKHgoZKzns42/enVO6Px0AbscsKe+44MLD9TDzG7R5omdJkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765080; c=relaxed/simple;
	bh=seG5o7SMz3zsxDo/Fh8QqjpglXzCQRppEs127hq7NT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBPJCt1XGeXt9IGXVqkMJu83Hi0Lovn7QGVg7Qg6BQI4NQjeBG0yhz/T/3M8CLRzDqf407UPzdgPAi9Ri1r3AlgOSc97jUeWvpz3woIX/wB/kaxPrTecwKYKg3yq0W01KBssCV4LRBK6xc5VYhn6hSw3vfjOXdZq8gVpry4FE4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnyPha71; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnyPha71"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5bf959b820cso2313276e0c.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 06:51:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785765078; cv=none;
        d=google.com; s=arc-20260327;
        b=gQKTRsSLrxCiaaiuGU4ioe+U5r7rtlDsLjkcXFl50x1RcfwKAHnq2WL48F4bM/m0bQ
         Y2fxC2yLzTtZd6J6DneLnZK0h8S2laOBC5X4HolAxDDWvw5RV8qxYL4NwaHNxfgWYl/7
         Mg4SiacgM8z5VKNT3xdRokwC5VZIXwKOTp0O/fTqQgMHX1TwGuhcQkxyub2APIEYkReC
         iHpReBvI3c09LOedShH/ogiyr28nJ1vlpN/AmPkDRwvw+rTB1AXC1jHwjMxByP7bZ9e/
         QbkiSIg+vjUez3pnkbg+HwUNlqlh8JmeedozrvC8jKDKSGnmH250neWd/b05HwBmPmso
         eqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=seG5o7SMz3zsxDo/Fh8QqjpglXzCQRppEs127hq7NT8=;
        fh=46+skefXUCjqsxW6pUZbpG1xlZj8ZU3+LAcZg2LONAA=;
        b=SAV+KQS/GUCEknpgA5QTOz/YHfBq6kbzYlfeI9mI1+ak3FOkYPQlJVzNeqJauPHNRT
         dNaTFO9SlXjw5S02j7j4Xilo1EA/gtwxsK4BXaRKZkvw8/dnwuhoPwf0qT5E1SE92U9W
         e0MiIGw9xNKxmvGOITGbNmZcgdtPDLHRp8mp1lJBPzAx50sAyvGPdWd+jE8O82zh6uFX
         d56DmS2ThAtMoRqxIcJ7IqthbaR1lisdkl6yGeeRVO6THCI4lp7tKvfZsfZ5sWAWrNvu
         sr2N40E+KR4b0h7b8TW8Tg/NI69zVH7yWes0eZPv2QxWivpvnJ7HmGRFj/hewkRe7Ls8
         HiQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785765078; x=1786369878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=seG5o7SMz3zsxDo/Fh8QqjpglXzCQRppEs127hq7NT8=;
        b=lnyPha71tejdsmlVF8ncYKOuvoSTMaUleHooh3RgX07ZDhS0nFc0kSL6Xde73BkbnA
         Qj/UAZQB6qm38ohWYC7+g9+Sy3hP5qAYWcK5MNh8Leuvj31ixXgk2MvCuGcpLtt/ysfP
         uWAmugk0A5u35XjvY89OLbR9bxJKjHT/QuaX4b0d78Sq4scMKL5sel3eACaaOu5thkuG
         oka0X6KosKWJz3YSXCz7dBOZ1D8HN99CZ5MRqjRee4K0MVm78w2VryoItwqLbARWPk0a
         HmlXH0c4bRugO6sTzsQLtjzbicyEUXGgUHE7c3gldoIe/78l1dVNqQfNYFDoPf4HZGsp
         /tgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785765078; x=1786369878;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seG5o7SMz3zsxDo/Fh8QqjpglXzCQRppEs127hq7NT8=;
        b=BZfvLFSqqyfwihFM4vywp98gp5XGWB8iOOZDVTt+O7TkMI2xC0ZgPLRaIeXYkOdvjA
         uNzi0zeV3J8bDjiD2zCjPYM7pvOHnjEe10Y/H/PCohFFE7A+eh99DT4i5i+7duifGsVR
         x/Vyi8YJogna4cdBrXu+rsS5xRb5WY//2ZKuWWgcMUW3pZN9l5+Xrs14um6/+4VzBJeD
         RERy/Vd33D0mESjn0sSol5sroauAVvbC2zNXZUcVuF/S4Xxg4j7w+yTmrvyPXRVyvq0h
         vKmUWeNcTfOLo9HUwXFvhe7d4bIPElvoOqcocsyN9IocY7FQKBV/5vWm8yT7WiYNd2vf
         7Icg==
X-Forwarded-Encrypted: i=1; AHgh+RrYQO42VTD+xIsiZVV3lAdOgCrJVcqx7mtfcgAHVq+teMMVc+3kTVTIaYOuO3V5u22tP1kn4+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoOD5Wbg4SuDwFdjoNpmI7icNr3BOHIyOD/GzgwUa+7aW1medM
	VsWAFNH/LMGLjI1wTa2IzbEG+S7FSNIejobzVFoRNagjrVfDg4a4GnS4wSXSlzd2H2fT8/iyCwk
	yrRmb3DKLcdjKjxMFHn6zZnKCvBt7BLE=
X-Gm-Gg: AR+sD10e4xu+J/fkOEopzXaIDKYiRHwgc1lu4hFi7JO3PvQZqcYnGF80tKkMecVlwAv
	lzm+JEGmlNaYb6KwmOrOHPCmoj0Y81z+mlFhodxNDB5pJHDlhLCxFxXOkbJ9T+WWo8iJu7rVf5d
	amw0eupp4VT5sR034sS33CoZhsRYHujPb2rPwiNs6iQKGh75nYITFN7q2b1+mhWePISUMFt6U9j
	mDYdN5IMeSzhsJWUzCiV3piILTyIG8Pl99Q6WYs6sLWpVSHWNhPhOGFlzrJfM9RUSplxHVIWYih
	XPm7JmMtlZF0wJKVugJWWF7EIZCGBhXcmT6Oz41u7lWo/x9U9+xUoWoYvaHX3bXyFJ3NnZOiqI7
	L
X-Received: by 2002:a05:6123:a7:b0:5c2:cffc:2c55 with SMTP id
 71dfb90a1353d-5c3873abbb2mr3309321e0c.0.1785765078014; Mon, 03 Aug 2026
 06:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714133909.82424-1-vimal.agrawal@sophos.com>
 <20260715055311.90403-1-vimal.agrawal@sophos.com> <20260721140911.2e12e60c@kernel.org>
 <20260724161759.0d6998ce@kernel.org>
In-Reply-To: <20260724161759.0d6998ce@kernel.org>
From: Vimal Agrawal <avimalin@gmail.com>
Date: Mon, 3 Aug 2026 19:21:05 +0530
X-Gm-Features: AUfX_myxWGdpffQXwHlYQQlYLW7sAOb8L67wrjX7hLA_9sWpmHnsWmxl2wIdJWU
Message-ID: <CALkUMdQY+i6yQYLb2VqVeN2fFTWMpRa8Vufr4gGGUxSQh5dhyg@mail.gmail.com>
Subject: Re: [PATCH v4 net-next] net: neigh: avoid calling neigh_forced_gc on
 every alloc when table is full
To: Jakub Kicinski <kuba@kernel.org>
Cc: kuniyu@google.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	edumazet@google.com, vimal.agrawal@sophos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuniyuki,

Can you please check if this is fine with you or if you have any more comme=
nts?

Thanks,
Vimal

On Sat, Jul 25, 2026 at 4:48=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 21 Jul 2026 14:09:11 -0700 Jakub Kicinski wrote:
> > On Wed, 15 Jul 2026 05:53:11 +0000 Vimal Agrawal wrote:
> > > Once the neighbour table exceeds gc_thresh3, neigh_forced_gc() is cal=
led
> > > on every allocation attempt with no rate limiting. In workloads with =
mostly
> > > active/reachable entries, the GC walk traverses a large portion of th=
e
> > > neighbour table without reclaiming entries, holding tbl->lock for an
> > > extended period. This causes severe lock contention and allocation
> > > latencies exceeding 16ms under sustained neighbour creation.
> > >
> > > Add a pre-lock check in neigh_forced_gc() to skip the GC run if one w=
as
> > > performed within the last 50 ms, but only when the table actually con=
tains
> > > NEIGH_FORCED_GC_LARGE_TABLE_THRESH (16384) or more entries. This avoi=
ds
> > > repeated full table scans and lock acquisitions on the hot allocation=
 path
> > > while leaving tables with few entries completely unaffected regardles=
s of
> > > how gc_thresh3 is configured.
> >
> > Hi Kuniyuki, are you still unconvinced by this?
>
> Looks like Kuniyuki is AFK, please repost this in a week (Aug 2nd?)
> This patch is the oldest in our queue and it's getting close to
> the auto-discard threshold of 2 weeks.
