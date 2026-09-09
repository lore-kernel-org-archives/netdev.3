Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EED4A2E1A
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948336; cv=pass; b=s276KDM/CdVAJbfGpWZA9TImaskBKk2GiWTBlM8GMTXo6BJH+rLg4B9UCPj52gZ3GcGV68Hu+3F+30Jcb57EDaEcctGwTOLBeNGY8pvtkPpwxE8wjtZGz4xQ4zKhpplWGom0d34Y8wluUH+0KQO0d9k8GNupZjblQYvqwJLdjW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948336; c=relaxed/simple;
	bh=Qs6MOo0ipbx7jwU40KRVH3VbId5c+se0y+w18KEpP08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyV4hWY/Vb8Z66frz7x7FQgy/XNYb4M3JRlf7HJ0+aISDknUbiNmEm3GZNTAGdTrqbs96QHavmHZNkSXnsqli1exT5gvZCaHb564PL1bmDei6VFhl43bMLSausUkGk0yzHyElgn14LpLY/YdeXJOCs9v+LJNDejh1CHH0ONElC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Fyh67PfP; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Fyh67PfP"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-852c481415fso6949988b3a.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 03:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788948334; cv=none;
        d=google.com; s=arc-20260327;
        b=GWabAMw8btyFY/ELBpVojpHLiSytRU5Mnj18ryLE3FGNZ1SVwCvdByKgwRpimhyE87
         qsTTWpWOpwe3yAfdJMrvu13Pa5weUrMNlRN5DOdl0WhcHQ6k4hGulNTHKu5Y4gW7d0oU
         sK5AWx7rwI0xETPV7ODUwD0j19qNlwQ5zNfMgcC0KAK+iNTCJbFu2UiNyTw4K/mYO9SB
         4BfdhNberCag2L7zGB5J+wYrOxrb2T+K37zHxkhsIDa8q+PA1PupGMs+XIirAPC070UT
         0RwzfMwZLrleRE2TZqv8uaUg9U51uR4KZwU+hSHMEgG0q4Rn/cTYPE0AZxs/x5VNJEVi
         Q0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H4NnU3M9b/3b6iNVJB4nDxkla8ekZHTTUWyoEboJwMQ=;
        fh=S74tJcXTMFiUbx0B3JdLTBnONPYQ3Mg9GXaGgRJFoRU=;
        b=JgjlUHZyX9Re2SgWjOY154x0M2tYMDR4kkitqWLsZ11EVXttQBMqxHDs8eqDhSIHLY
         gc+kTKFKDBnnlIO4A1uIBuujXxAu+GC/8LJ0BzuANaQqmNxQ6NPWPaBHzJolXg0TGFzK
         s76Lsz6T8oIlZtRzYbsMsocqCriCif6fqHMREf82Ty/xyAVcVLr8JCDF/rCL7DHq2Tmo
         yRDmj6Al/sT0sOxYu23CXPeESmYhxq0SOTnijTSXV4nmcf3kJJeJHkj9Wty5yddKge2K
         X0VgyKUzl28x1glF5HmdqpILJecpzvJ/k6/AiAdNhv8H4OKE485FFO0o2lYA7VX1tSdJ
         ttmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788948334; x=1789553134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H4NnU3M9b/3b6iNVJB4nDxkla8ekZHTTUWyoEboJwMQ=;
        b=Fyh67PfPES0WDZ9cuGkdzPUfAb/BXY2KURx51u1wdu8e5Tl6ZZNBpFh+EqcZZx7lTA
         8NPTp8/HzX1M90Nwc08bVnAk1tGvzBHlu7BXLvpNxKzVK+fQGfwoqyF6PX3ls5Augf2I
         7PrJancQuLGvRwcbf9QigiGfTuZb/EANssCYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948334; x=1789553134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H4NnU3M9b/3b6iNVJB4nDxkla8ekZHTTUWyoEboJwMQ=;
        b=hO1ynimJ8YAUMCaJGy9+qzy8+ixAZrkHVts5PNdhpdOY5yTQbPIOf1y3LQeU748Gcx
         ijDJ5aCjMY3/XCOoXZIA2LY7nbS3v8Sbz0zc/0iJhSRPy6kGvJkvbZePS4kNRFo1g5AR
         8HEYle6zlH8X/RtI0NusAWlU3ADFRHSRxgV7GguME8sADJQoFXLH0bNECAR/9VdRb5oo
         U2IKNSWRKbCqujWtS92GA5IJDgzwL+IOQ2KnGpksH+4aDwVrR/oShVmiO10hA9/H8fU9
         vmvg95dgGkvZ6KQtI2Ro5U26/l+wEB1JKjWv6WD53InuhHpTkCEOGTqZI5rUvEfFczIR
         KH1w==
X-Gm-Message-State: AFuF++ker9VJRSKER/gv20M6XUESCrG0nt8uRcHZV3H2yxAgwsd7P3fa
	n7vrgtK1lceypCwXSqbvJyHiVuJV96Zaq6iojEHJmG4EwvyTOKcpcHrfKHRynTrE/FeB4fp+VL1
	wm9jC92dGUwktq6xK2l+kxN2j2+fFCIORs+e/m6MX
X-Gm-Gg: AYBFou1TX3VX73B8H/Akr+DADC6z0hKBh6mzqaPDWzohqgPNblZRZCFTbV/0JNwmnPy
	IKbCFTd8eJxtx/m49A2Bn68h18GJvoKYnM2HV7VGWPg+gUzzKTKrwoVgoqYvrLNS/V3fuclnFpe
	soeqfMlIre2mIoOxsK6nrXNPRqLOV3xwGy53UnTA/+TzG8KLzaeNipJYUGCN6uqH4EXLPzMx9BU
	D1wE9LelKcmkGRb1JbxxYckyMjvSpQtPYXalVe7bF7vsJioa2xjs6KK3yRCO5Ny46K8uFcqptg2
	rXuQtUV/E53kxecyDZHrb7n9VjgSWkSq5y4kY2EREfAQDgI59IrXb06P3GJbd4NXT1g3++nr3Ka
	EuTASm+9a8XAh2/gc0WkUo0WrRFH1TEbmdPAuoi5+098w
X-Received: by 2002:a05:6a00:4298:b0:84a:646f:193 with SMTP id
 d2e1a72fcca58-861633ca7b1mr48778621b3a.0.1788948333754; Wed, 09 Sep 2026
 03:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909070336.32979-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260909070336.32979-1-xuanqiang.luo@linux.dev>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 9 Sep 2026 06:05:21 -0400
X-Gm-Features: AcwNN1XRsCSsVSIJECxCc-1JgLAJouQ3Cyvq8feC7J8tsCQrA7yQNPwNFlVqu04
Message-ID: <CAM0EoMnZ6AwTX45hHAkqe_tvY0jpeMhzz=c9jhduzzau2Qn84w@mail.gmail.com>
Subject: Re: [PATCH net v1 0/2] net/sched: fix action batch failure cleanup
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:04=E2=80=AFAM Xuanqiang Luo <xuanqiang.luo@linux.d=
ev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> Failed batched RTM_NEWACTION requests can leak action references and
> reserved IDR indices when cleanup encounters a filter-bound action.
>
> Patch 1 fixes the failure cleanup.
>
> Patch 2 adds tc-testing regression coverage.
>
> Failure reproduction (key output excerpts):
>
>   python3 tdc.py -f tc-tests/actions/gact-rollback.json
>
> not ok 1 e3b1 - Failed action batch releases a bound action reference
>         Could not match regex pattern. Verify command output:
> [...]
>          index 1 ref 3 bind 1
>
> not ok 2 e3b2 - Failed action batch releases entries after a bound action
>         Command exited with 255, expected 0
> RTNETLINK answers: Resource temporarily unavailable
> We have an error talking to the kernel
>
> not ok 3 e3b3 - Failed action batch releases repeated references to a bou=
nd action
>         Could not match regex pattern. Verify command output:
> [...]
>          index 1 ref 4 bind 1
>

Thank you for providing a reproducer.
For the series:
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> Xuanqiang Luo (2):
>   net/sched: act_api: release all action references on NEWACTION failure
>   selftests: tc-testing: test action batch failure cleanup
>
>  net/sched/act_api.c                           |  9 +--
>  .../tc-tests/actions/gact-rollback.json       | 78 +++++++++++++++++++
>  2 files changed, 80 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/g=
act-rollback.json
>
>
> base-commit: a401a9d547c50ef34db1088cc1fb9a201a7af657
> --
> 2.43.0
>
