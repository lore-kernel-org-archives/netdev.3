Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC24A4F09
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157473; cv=pass; b=BxjebnFSPSQ+yTQLhfZq7IJ3pNcPTYfsQ+doa8xGCE0OE+wcKARUKKe3yujFScHvVhH0deOZMGb5/ZB9MnWWQm+sGSjBpsYPf0p3kwfBFdEgipK1D/BtqPpJ26wfC4cU/qx4EeJZ2Jn+ct5l0AVs9bnMfegME9n8IPKTWoGgfdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157473; c=relaxed/simple;
	bh=7vSGrATw8OiP1xs9dIzVyOW/1pb8qSe4yANpRII4cbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvsINYPLmh83wTL97LkjiILHgr0ASKiOUOrrSZrcQyMUntKkNCCjsApPc3jmy0sIBAAzoN5Rcf8RvlEOWuqb+xBNjtjbo0l9CmvszUFlOBepL3DjBbYeB5+OuxR8UgOYqJLNJ9gi8EpUxy+he2RXLIVgKbq4fgg9DMM/kGkQNBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmhiU3iT; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmhiU3iT"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a777d4f321so55215061fa.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792157470; cv=none;
        d=google.com; s=arc-20260327;
        b=q2g3yyDD8N0U0YtjoAZipoeZB4soJlqipAUcJ1psQ5+/2TXauD4okXvOQJfLeGrREk
         Yd8IAHdGrdKhbc2tPmwTFltqnFK3Y4BAcbvw7BE6Z9POHhkgJh8HIFLM8aMo3j0ViJS3
         S6tIS9pbaShfs59hicF8hSEpuqfErRsBNOEIblx3r/x65o0yMVEMh1Wa29Hym5ifkd7k
         iPIMK2rFbBUTlR/WMXV4Guld4F9Pgz9qwRhv9rEKqMWZ9mquE0g3QBU8agkZzPw3AnZT
         pbDv0XkDjc1wEJjl6vV4ZS7rQNmiFsCaPZCEdGSBWZL4LJWa2R3gbczR3MSTNrAfV4AC
         NgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7vSGrATw8OiP1xs9dIzVyOW/1pb8qSe4yANpRII4cbI=;
        fh=IUtyKwrR7+Kp94hOrV6uiyIxT4NT1mcDNnXhyOnarLM=;
        b=pUpa/eKdNZqvLt4+4SkUE3tGeP/lgGVTutueZDdGo5yjCf8AnxO9QYo/B+geQyZjP/
         H9QLxovg+5/EqKWXdYaRUci77Fp2OOCFu7JxfTzFX3+JHSOsEfcEySvHKSxwt05Gz+Ug
         IvlW9/JraIXX3f0H909bZsx4CIKQpJCmDfeawPuSqvJIMShYCzn9A+17A02YI6LUnuw3
         E0bCtNMfY9ALZycsgiveBH9ap4/q9UM4jLw8tSUxyD1IWC4zJHDVFl6MbY23M+Zeslbz
         dSbVx+q4UEpDel4C0EB7ZSrYgbP3W3myTpZvHAfIPaMY3MQhZJGEjW2flg1lJU7DIkwW
         x6Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792157470; x=1792762270; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7vSGrATw8OiP1xs9dIzVyOW/1pb8qSe4yANpRII4cbI=;
        b=SmhiU3iTtEO8oyTs+3mydLekqmQlUF+n7S2VcttqUDTu2PUoXpIcte1+33rzh42U3r
         Uyv2lyBGZUykP1y4Y8QsAJsw4Ral8iry48n/mWYmufIaB1qiAtnbAGSxVGHuquabPeBt
         yBNUoIxF8ole1DpUbKwZZ+KFvu8ghBvAaCFdjzMU4UPrzYOPjAtZmlrYk2ggoJGRs0bd
         TfcKDOwF2KLjMX+OUWFksev66U5nLJ0rkrZCOPLSItAfmYBf290g8WwM+oppNlWKvxLN
         adbJ4ojUCxF2JnvXrZtkrkBDebZ3qbE8GKp6bPzRFSXNEfV29U4ubsio7rMrQBg8od2o
         nItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792157470; x=1792762270;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7vSGrATw8OiP1xs9dIzVyOW/1pb8qSe4yANpRII4cbI=;
        b=ZLPCd/vXBo8UH5B19Jsz5N0bz6SvggWcClkJvPRK/1E9D4H+WIjFaFlXQTlaQwDB4T
         RjhssTYxbARchry/FHW2dWcrHh7LKXGsc/U3meXjF8UzFfBbQ7mqqSkFHeswz6z3pgg6
         va8m2BYq23/vfS6Jt1PmEkozfNd8JcXQvhdodaAHYsXpuSXQeo6rzK5prO+5qNb9z7db
         XaDjokyxVh09lhL46Fnl6j40mt019RsUx3o9ix3PGbMnrk3HUwyDdKLBOABlTYqcoXGF
         kQEqXZplcul2TKH1hLI+hO2tdkrhIozAB0pfc93B2HBmSoTOjAyrbrM/Plkep2ceDi6N
         pqqA==
X-Forwarded-Encrypted: i=1; AKwUvBzl4HVDyIydPOeD664R4piVuWaRRmbcwdbdOOmD5yFIGOUPdpt+J4NI58mcZRrrAKLDc5aGMto=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDlLwgeculGtM5+GVo4tcp9wI9kqhN0u+1+FMSQnO91spcV/y/
	acwPtV0uruQMydnagdWXWBFfm7uJWBmGddT4omQndf8XrbtCrQvsVH2PWpQocit3QGxyCQQvb6C
	DeFhBsQMxydu127NMT3Ktqh6TN1+V8/Y=
X-Gm-Gg: AYBFou2GhdECHTFxbNSqjednVCMhQtdB+mCRgbOZhrbsY4fKD83mtDr0hUD7jvZ+kiK
	s/zcjgHCHl/8QSN/amEB4agrVgJtdZtCDfAW7T8ZyiQIqa9WKIQlLMWe175vo+UJDXY4RuThGb9
	d0d6t6LGpWPDsF1j3/Pc7XHnM3f/0nmNgkVsuOb7oq7BkDz1LExJ5pTjV0u9kbUBO99qbXrU2K8
	TtbHgj0kegCxfJ28mJLYlRMAAb8ZX5qeEkNGgpIf8w45dTLtUQmnI4DfJS9rDZoNvZ1oPUayG7T
	Yva+YA7oqWnI/M4tA/6bkINRHtp+29/a2POkdJvPHk1GO3fcsUp2pPg=
X-Received: by 2002:a05:651c:a10f:10b0:3a9:849c:b169 with SMTP id
 38308e7fff4ca-3a9c55cd2d5mr35171861fa.26.1792157469757; Fri, 16 Oct 2026
 06:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016045849.813696-6-oss.patchbox@gmail.com> <1ce84c99-7f55-a146-7333-4ad791434097@hisilicon.com>
In-Reply-To: <1ce84c99-7f55-a146-7333-4ad791434097@hisilicon.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Fri, 16 Oct 2026 09:30:58 -0400
X-Gm-Features: AclHuK92JpH6uH1vJ--axFEUId5jRlivHf0QixSYU0dCBZsoLZYYe7ajIOxpcAc
Message-ID: <CAGG=RgDgreAd+dSc=XwkuduLJZfJuR1AJr9pXSd35aQoLQdQTg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/4] net/mlx5: Don't free CQs whose destroy failed
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ariel Levkovich <lariel@nvidia.com>, 
	Jianbo Liu <jianbol@nvidia.com>, Alex Vesker <valex@nvidia.com>, 
	Yevgeny Kliteynik <kliteyn@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Oct 2026 at 02:59, Junxian Huang <huangjunxian6@hisilicon.com> wrote:
>
> Are the buffer and object freed somewhere else later? Or are they
> leaked forever?

They are leaked; nothing frees them later. This only happens when the
firmware is alive but rejects DESTROY_CQ. A device in internal error
still frees everything as before.

Freeing them later would mean tracking them until the device is torn
down, which seemed like too much for this failure case. I can look into
reclaiming them if you think it is worth it.

Thanks,
Yuho
