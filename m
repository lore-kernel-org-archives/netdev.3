Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B593254A8
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043171; cv=pass; b=oMNZQ/bEimz3CWQoyUbBkLH1pNaLyNiSb7vUOaF6fO/pyBxKASbM86EMsshkkfyyU7ciMpcPQjcMv0L5YhmlZFl3brQWexysFZQ+hvWd7Dx1f6Tv7N5fjprllFj7fz9pdjmju3zZrkYz19y6VDFiq7GaYfyFK9Es6yqraLhmZPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043171; c=relaxed/simple;
	bh=UEaKqlpg1S/qgYKAuWWYje5xwb8CJQleJ6eVFFV1h8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIyDeOlnS3+XycKc54fZcQebwUd04tztVlUDVQmBhG/NYP5Z1zipEg4tCJRJZvYXhridZS4zzUUq5669bd9FOA+EBtb/G8IbqyzdHvsnKQp+AET/cZQxGBqa0+zXT3HQq2bDcmcgUNxlRBnjdP/xtxKab116w4FwLyLAJLU/iHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Spb7umaG; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Spb7umaG"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab19127so3938583d50.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790043169; cv=none;
        d=google.com; s=arc-20260327;
        b=GkhKdUm6sfIzJc7FhnTk5uunTcc5Ase0SEEIzSRCNTAoPSrEVHOt99wk3Az4zsPWPK
         +Jt7jREEzh2LobIUd3PT5JbejuS5KxiYB+1CNK6kGJXy/gwfjPtIeqqRamiiCtgjpnoy
         VDRQF7PXyAmefy3ihUMnHI7+ys4aQAu8eDTcp80I1dQ80XPZ8EZnrGiozMxjACJNPbJb
         KZC8vdWP8+Y8UQhi6DJHz+ZKeAcuuWdjtrwAx1b23WlJqt3TpKxvuMEGwJsJnjE928eJ
         amj8A5K1gikM4KW06ItEjKn9Z89E0HVjRFmM6GQasTqdrQumg+KJp8/DIyAKz9swppyN
         S3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UEaKqlpg1S/qgYKAuWWYje5xwb8CJQleJ6eVFFV1h8k=;
        fh=3o4HvPK+JZ8bB+DQwDxO8wxxKHShy8IxtEZ9s7n+SBo=;
        b=JVzyvQz60yGZeGTlqaVuhqWzRBTXqeUxurO69Q5PYD2F9vAhS1L8hJEpJEfeusyloZ
         3Z1a/BfVByYancKjO54oZNSQYuNUvg7/8i2Dr21Awd7jzvRHtslp6sgpLPtKGlm7e0KC
         hGfUbNlUghnuiD8NttNc91VOblU/HTLwtkws6Wga1/z8FoD6LiWBSrYBHyzt6vfIIDqV
         Tm0Gsys6BPk4WGWSyp435vWRqV+9JQg/E/gszlN9yEWvRJxQvhj+Jt4OrMyF0TRYilx7
         5ONMKgnJpt+IAWlwXuvUMos13N12583fIdEBySS1qTGuCINxATxSM3h5pBwKNNBdwYqI
         YwTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790043169; x=1790647969; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UEaKqlpg1S/qgYKAuWWYje5xwb8CJQleJ6eVFFV1h8k=;
        b=Spb7umaGVHS9WmfBhptaLE+0kwzfkWnwdXBdWpFB46nmupD9rwL8ITFCE8xkzJs5Re
         7vnpaufiSCHcnfxbYPQWhGb0aZodlPkgCyCNbhgBz2Fz36u+8GE2lRgHPWAYnwFPZUJD
         cwri/DXltIwkuPF0aFw/0lMhTIbqfnrBZbab6AEHwoM7givrKohwV9vQ3buuO2TmpmBz
         mF/dJSw9m+j5nDwSTokckcnjcFnM/7mHIDhQsBM1r9XDTrELwUZXsdVr6BuHSMtuAKy7
         C2I+WTPaZNpOjAs/LZs7kuRFVAI21D9hScg4cMEh1yq2aUi5tMD7grDwOUvMwLlzLnN8
         oEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790043169; x=1790647969;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UEaKqlpg1S/qgYKAuWWYje5xwb8CJQleJ6eVFFV1h8k=;
        b=YuuPDH5Ibxsgncu10CSX+TaDqjqTSs+DXhhLU6QxRFCxBN6mMdhDa58bC3TTrA4Xhr
         yTKfwMB2k6e+Uua1GTgIN7ixXgOy6uRWzSj7BBI1D1qpIlOFEAQ8KiBhlPpd9X+PSnU0
         lGmQLHCTbvFb1UmUaDEOKM0l3rwpV3D2dxu1hsCsd1ypbiSA3ASUsQj2rDEH9D739t3b
         L3yoGKoSB/uqoP6WEp46uEI1P5ZDd+fPbpMSbpAOMqxS9zpCxp0WZkIBp4Z6D2dtsPSk
         uF5/pIJ2SHKH9aEIG9WpvdSyHBEiWT91ywKPG24p7V20d+NkhOCQxSyH+ftH+mOVEB+C
         HLlg==
X-Forwarded-Encrypted: i=1; AKwUvBwD6UNmLYiDirh5SFt7U21U1InryCXFcssNsQGrvmpv7tQqxgkuSYfoGwLotIxiEfW17PLveCw=@vger.kernel.org
X-Gm-Message-State: AFuF++nPP9Yl7uo5swIdmUnTd+14/igEAiyeBuwdPQrW7f8m9u0daBXR
	7bW3kJfA9H1HqgXRaDMOcNrXmkz5TpiF9yEJ4TKlPBK+WVnFncb5ntboP52/OAD9/r2ghnwgBjE
	8KOj828IZyt6N5VYiEcCmu+XUSscGd2s=
X-Gm-Gg: AYBFou00U5ix/YoQfP90D0tpUMaOc0cEJgAFA7oeBH8RNTukdW2SeMGJALz4YSM0Ziz
	v1cx0l2KLftCcR8k7NQlJsCLSojPCijR6me59DIwaB4wBv6rbq/hl89U3KGaQK5kRdxwv5PLDmb
	hDLZneG+aQ9nnFOXe+lEgnt+7ceolr2KZ39V/cmY3oBw2FbSgb1Gg2N1H6OrBvdQSOg3PI7bMz0
	iZY6DCGiUfFcLdynMPPqWg4xAhPNWutzwZ6anBWJkXZUgQ7fA6irl5leqlp0chFfeYd1JtHzPT6
	fYL1f5ekVOlNhz94pZH4bUm27GHR90WDWZdboTCIVXX0WAYnl/p5595jT8GqOaxoArQC
X-Received: by 2002:a05:690e:128b:b0:672:a546:64a8 with SMTP id
 956f58d0204a3-672a54668a7mr3570659d50.107.1790043169134; Mon, 21 Sep 2026
 19:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921154202.471662-1-lgs201920130244@gmail.com>
 <20260921154202.471662-2-lgs201920130244@gmail.com> <179001756287.8372.475254242129499819.b4-review@b4>
 <1804a859-371f-4bfa-ba48-d5cd26819cd3@kernel.org>
In-Reply-To: <1804a859-371f-4bfa-ba48-d5cd26819cd3@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 10:12:36 +0800
X-Gm-Features: AcwNN1VAnINknji1fkt2WEpdwkqP4l6wafMfAOYzvmtdGrYl5oQg1J8YZy6n3vs
Message-ID: <CANUHTR9BSNmmrMQqXNd-qap2qoOxWf-ZtGAaV6icw4wpFaCFSA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] net: ena: fix PHC cleanup on probe failure
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Sang-Heon Jeon <ekffu200098@gmail.com>, 
	Dawei Feng <dawei.feng@seu.edu.cn>, Amit Bernstein <amitbern@amazon.com>, 
	Netanel Belgazal <netanel@annapurnalabs.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for your feedback.

On Tue, 22 Sept 2026 at 06:02, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 21/09/2026 21:06, Arthur Kiyanovski wrote:
> > On Mon, 21 Sep 2026 23:42:01 +0800, Guangshuo Li <lgs201920130244@gmail.com> wrote:
> >> ena_probe() initializes the PHC as part of ena_device_init(), but the
> >> probe failure path does not destroy it before freeing the PHC private
> >> data.
> >>
> >> The normal removal path calls ena_phc_destroy() through
> >> ena_destroy_device() before ena_phc_free(). However, if probe fails
> >> after ena_device_init() succeeds, the error path reaches ena_phc_free()
> >
> > This part:
> >
> >> without unregistering the PTP clock or destroying the device PHC
> >> resources.
> >
> > is inaccurate, see my explanation bellow.
> >
>
> Don't waste your time. This is AI slop agent posting (one of 500 more of
> postings where agent does not care about replies).
>
> Best regards,
> Krzysztof

I would like to clarify that these patches were manually reviewed and
audited by us; they were not simply generated and submitted by an LLM.
However, I understand why the recent submission pattern may have given
that impression. We sent too many patches in a short period of time,
and we also failed to respond to some discussions in a timely manner,
which made the situation look worse.

Many of the recent patches, especially the v2 revisions, are
corrections and improvements based on previous review feedback rather
than completely new untested changes. That said, we recognize that the
way we submitted them increased the burden on maintainers and
reviewers.

We apologize for the pressure this caused to the community. We will be
more careful about organizing patches by subsystem, preparing proper
patchsets, and following the kernel contribution guidelines before
sending future work.

Thank you again for pointing this out.

Best regards,
Guangshuo
