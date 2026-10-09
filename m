Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433738E8BD
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537965; cv=pass; b=qnA0kGDvZJ7mocQOX80DgPlSxzoLCugqf8da90mRFjp5Kf77mLEe6PH7OCFRdWid2/q+JZfa20Xagga/se48BKRXswt0NGDYVZO2UPKpFNPtVAOjL7x4++O8dNsOJbgIxPVqHoaMMv7FGBdq7mcGw5uhAfXemSal/nwWeJr9XRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537965; c=relaxed/simple;
	bh=BUi3VVc2WGcdLLbUe0Vfuo/Zxj8KOZZ4l8VVScuoBYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILoCYhQUjiAcANhLCWqWUDSZW9Ttqljkyvhd8uLoGwTEi0zPYiwYdshNdgz0rOcT8rMZWICLsN8cIibYQNou5dbcQH9/WVL1a5uM+GNz54s9Et/0SrOQ1Q/KAAgEWOjRvgoG13TFMkxuqlle7KAI88xvWlqLfL9zXp/TW2QjitY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Yizhknq9; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Yizhknq9"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4d192643dso1820246a12.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 02:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791537963; cv=none;
        d=google.com; s=arc-20260327;
        b=THkqeioGdFdGzw1+tw4ma93BlmBMl/t7l2fFEC5MJKwu0RZg/NdbR5FOiOIDHGB9Lo
         DNF5i4vwa+/84Mxp9td0GY4NJy2I4/RK9trETefrh06pXVmdzCcgGqhbJDu8HX6p81Y5
         uu/bHa8ay938o9LIuKnCAdjkEEzyXWJTAp9okV8LyhR3PckqfedrP30QPVYy7UjXjx3k
         TYZH+v8OdSx4LrQ0aiCyj/0VZuspJfA/so42nA7gV44LU8y9PrREA6qqZAZukJ8A4Xnz
         XuMyj7eqt+UaOqmaZZUYjVQwTW4m0bHXb0CZjhQDEHpKU629s36a5b44LQuYHHEcSQlg
         Fh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r1M5Qqi3LRW7Vp0nEi2+b8JRST80YvkJ/X3Ikh1oGi8=;
        fh=5+t0ka9kLTbomn9Jrh1y8lkChSMvy0zFtedHvyFSri8=;
        b=b2DmiLuQVMaJShRezWdRe4TCuArtBVBTYgJw65f7iEPQTcRveim9ubInD4DAiiOZbd
         6NE8E6z+xrI+H4mg1ZLmq+5NJSqtECFh5K5LgdLG8RRJ5DfzFS+RwliMzyfmJbP9DcNv
         86mjMdBxVcS5Re6EktC9BVd7f7b6VR6wTQERhJZiA5TUmdFVeQI3wDyr1UQYLT1Qfn1k
         pq0igkXEkFbXwnXxPE9Gi8ZB8JprAzMZ5htbpZdGjsc6/5rhXoEHPDo7tkpNVjsSZydM
         Wu3AeQWTFF4MCD7bdVmqI3GyoeEVg+yNlNsjMKWVC/3xPpHa1Q71ebFw7EW/mnVXGdzI
         tuKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791537963; x=1792142763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r1M5Qqi3LRW7Vp0nEi2+b8JRST80YvkJ/X3Ikh1oGi8=;
        b=Yizhknq9buLEsLiPTUaZuy0J3ryZcP+yj77nPzsGFVPWUuBiKDqDEsg5qQ9tOvv80D
         mrBy6lFbVzqVFhl/GH3R5mYt9y1xdyBB86rHCf7siBNM8J10FNhj9Jh3rsC0Mb8wNHZD
         cWAd8SQMVx8yvPLk0yp8wsrc4MhZC/e7SeQRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791537963; x=1792142763;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r1M5Qqi3LRW7Vp0nEi2+b8JRST80YvkJ/X3Ikh1oGi8=;
        b=xcTvzm9mDfsssB3ABvbrj9uC8apD8REiZHxgMadaUX5L6HdzJQi9hGCUAl5Onn3+VE
         /+e5kLt6bJqP7My1lNdMSHYZiV7/zQcl7LFk9Ur1fUkWg5db9Xb0zQfBSEiAEbVcH358
         5CfnmW6GWj1iQ5FHkK3BlEdT2PMBpDpuVEpHUx48ScXhXyOrQylR1CXsJEqHBrLxoZx0
         Tj7KveT+NRWZSBiiAidXbxJMLCnSaYVCWokySAunJomKkxpEIcghW9IpTDs0npykOIWr
         KIJjQ/CbsqSz/x43DVeP4fZ73CYmrWfpwHHhcbu4r5UJeq0kRjAVv7iqoVB0o6Od45PH
         6A9A==
X-Forwarded-Encrypted: i=1; AKwUvByqZ2YtnF06YhflgqpTU08vWvrVjOy1HG1AHzkE+KEAwwlNmqdmoH1zIGX+rRdaNOzDOC1ZP0o=@vger.kernel.org
X-Gm-Message-State: AFuF++kfF1shOs6JIZCZonhnC+Zik0f1hexv0WA0CwgARoIeWFFePDWZ
	l+ea/CYSUqVO+wWO3KpG5WxjE4LI51XlRGhhy90IYBMyykotYHt5b3d1AVil3TqlP/4lgcj56ND
	5t4tLUJZY6dJKB8lQ/7erZjY875oqCyqPX2Y09rVC
X-Gm-Gg: AYBFou24odst7CfJNRUgTP6yOA8OQmubLHL9TDWs0asqNh1d9PXMQ/n7xPPW5I2hcmK
	H4Yq8DAkXKh2alO7mNPGQaquwcLbbjTMRTMY8WsN67MzU0U46BlmhnP0pQGl4sNHMlonMXPdDeG
	qFbrrryq+wXEQHW+f6s3Fh5zWKUc+ZVvPxfXFxFncHkN1CbVf2zsnRaZXdSmTZbUJwLmQBndOTl
	SrDpxTYtOX6Nm8f9oZMjrj8jhRbY4nLhELUm8U9E0XuGMBeDu63xtfinOFDXw7zSAtg5w0IgOPj
	AnmkJ2sUq2Ngg5DSUEOcMnB7qac7/fMNAPTShQckHPDqC22VfnrXrz65bKGF9UKixX3UBRMiizx
	jvmb6bRtRWjbRbHVG5/xgMlNZbsuF2KloGgwudSI4hRhg
X-Received: by 2002:a05:6a20:748c:b0:3e0:8887:7013 with SMTP id
 adf61e73a8af0-3e16bf31c6emr1030855637.74.1791537962911; Fri, 09 Oct 2026
 02:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009051930.3619697-1-acassen@corp.free.fr>
In-Reply-To: <20261009051930.3619697-1-acassen@corp.free.fr>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 9 Oct 2026 05:25:51 -0400
X-Gm-Features: AclHuK93AmW8nSnwQTG7lOamrpxOEoVJVjrQUrMwnbi8vokhGes7Or5WjNWmhpI
Message-ID: <CAM0EoM=tTsRd04oexDRBtErOjJchPV84eMC=5jD0LF54koHT2g@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net/sched: let hardware only actions drop
 per CPU stats
To: Alexandre Cassen <acassen@corp.free.fr>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 1:19=E2=80=AFAM Alexandre Cassen <acassen@corp.free.=
fr> wrote:
>
> This series lets hardware only actions drop their per CPU stats:
>
> - skbedit, police, mpls and sample honor TCA_ACT_FLAGS_NO_PERCPU_STATS.
> - tunnel_key skips the dst cache for skip_sw actions.
>
> With no_percpu set, the first four count like gact and mirred but also
> share their race with hardware stats updates when an offloaded action
> also runs in software. A separate net patch fixes that race:
> "net/sched: act_api: take tcfa_lock for hardware stats updates".
>
> Alexandre Cassen (2):
>   net/sched: honor TCA_ACT_FLAGS_NO_PERCPU_STATS in more actions
>   net/sched: act_tunnel_key: skip dst cache for skip_sw actions
>
>  net/sched/act_mpls.c       |  8 ++++----
>  net/sched/act_police.c     | 10 +++++-----
>  net/sched/act_sample.c     |  6 +++---
>  net/sched/act_skbedit.c    |  9 +++++----
>  net/sched/act_tunnel_key.c | 10 +++++++---
>  5 files changed, 24 insertions(+), 19 deletions(-)

For the series:
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> --
> 2.43.0
>
