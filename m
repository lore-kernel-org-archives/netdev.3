Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E941365A0C
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769884872; cv=pass; b=vBJJQX/XtwFQlk9r6wbaQ5tbQXpAYL0jdflT6JtFbJ0ZLUaBpRzy8Y3Fugy42k3OYAmYnCtBrsdjGftj4gUkDPFryxRTv7dLQzUN09iv34qU81f67HE5GcvQ2Vs/8kfflARjD3XLMzjXlMd1MBx59WVjhi1rTGajG96FY3goJnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769884872; c=relaxed/simple;
	bh=tCsyq6uHBZmu7f+VMX3I8Leg76iME8s8qBPyEqw1Zok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAiUffQlaXo0P4C3NhrE+Z8NnAT2sBZa2ImvSAdXjvqIt+ivCZkktsN0+C7hW57JXtU+Ybp5KbV6uu1uCAeQqFfiZ+lBThAKAG+YZ5uh4mJB3/XqKpYmhayskHvfunqOJps8oFvRW69l56HyeX9ADIg0PolDe/ICVsX2QijEzrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lx0T8R3v; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lx0T8R3v"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6495d592c45so3123331d50.2
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 10:41:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769884870; cv=none;
        d=google.com; s=arc-20240605;
        b=CQD4MrIA11q/3Rctwe442fOhwVo1pjWbPiPc5u7IECU2HKOUDxi5NUV3mOnT9YrNJp
         xbe1E3rB8dYYu0fso6rtBA0bTIZH0aOLsYkgYsxMsN4rUIeTMe3bvgj9c5upF20YvdtN
         R2YQ6uiQQsngB6eatSfwUiAayWvpbNHYqIqNWKKFBN1d3EyYugds3gClV5zknBzUmYoa
         LOkP7ELbGbGLjC33oWn/VqgdAPdFf7hYX+m1/jzM/ds4PppsTg/fp/8QZZSGkS+eIaUG
         LniIJmgjc3P5OHL7lg1+2eJKKKjEI18b4EH2fETL401l7GWyEQuv5jJJYfdNT3rL/tMn
         4LZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tCsyq6uHBZmu7f+VMX3I8Leg76iME8s8qBPyEqw1Zok=;
        fh=DHYTVbfgPruzcJE8VbyQgp6sCpMJg/bqehLjk4WpW38=;
        b=EbeRAmqyJgk4KxXVffCPQ07Re6rRvnoiWq90j51mU5BRmjNV3Npi2j1icnzGeolS5h
         9ViWlZ36bNuNnojINXyaGrAk4NlK0zlArFPk+ZldwlgDZOr/GnRSb1SKQ/A4oU1KUu4m
         Iq4gAnTVvkZxEQ42+4kO4cdMsIAb0IQDQRroQbb5gcqRU3mC5rNxP1iaJttNAL53Kht+
         QpJqb4uRkRTVuY2hfbV3nevZYyXv0iX6kPqiGAkk66TQAgK+eMr9jaBTkNxK4El3qiQq
         aYDCXNQc20A90bLEAt8Gels0AnB7Gp8jLVTYcmT/dib8OvyMBJEXagSBgvpcd+l78MP9
         jozg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769884870; x=1770489670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCsyq6uHBZmu7f+VMX3I8Leg76iME8s8qBPyEqw1Zok=;
        b=Lx0T8R3v1DfO3WLX66agVJl+NIH61jpNdij4bjvo3nsDc7LcC97Yqz++9Uc7FaC7IY
         hOVOJW7ML4o2PXQ6ofpIypWNsaUMDSW+gQ0jX7SYXyDFysTNeY1LETDfND6yAjZ7iOuW
         Ad3c/aA5IBQLhrmkrJi6jNUNDyCxY//4z9haJL0ivJ1y05xPVzAqauHFYTEzWWeFsK9d
         akMoRuXn/ur9pnyxyM2lLYCRJx2M8uqLh+tDKU2s+7jxAeL9yxXDwOumW5097DMiQEK7
         QFnp21VPyOsv61Y65tBJYKPkMuyMfEbO/v5llJazUB4yadfvvaIp4D3C3jm7EipDL4FN
         jBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769884870; x=1770489670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tCsyq6uHBZmu7f+VMX3I8Leg76iME8s8qBPyEqw1Zok=;
        b=rYsfdV5SnOu9Y9LiY5tjQECHzZi9CwEQ0BZQnWOzAOfEB7+A+sXu92dfOC/eP3Mj5s
         TgEZ98bLDejjvmloygdTqjTM+7K7HNiLF9dbf7L+npCgvTck/0xUrW3uJu982MrnUU7s
         vxi4UKheE584IBTkzCelZEdj1epu2Qo8mTQN0vXay5f62ZLvKap9lbbZkp4D8L+jPgIs
         toUMKafkKPcmt3Unc3fj30CkM0Wlzs/TB8VR1g4CyGcMjY4mUqaY5F1s0X4MroS0vhr2
         W0Dfem26nDRcUXLbsjm2HbFKbJlSZ5DxHEjS1xvLhbvqg7TAae+XbKuVAFO17eMOiTAW
         Dwjw==
X-Forwarded-Encrypted: i=1; AJvYcCUuZ3Wl5J/7ayQ3Ces07cBx3w1FReczvmpX4uchyUmEcF8NJgl1CuIiKu9OSSCkhdAvlbEd/pU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUZqVZJ/lCks1jSi1JHAKNIEgZRltvPyXQqiqaKJNTjYOLDE8z
	g+/tkn61CXXhmexKo1UysA3RORLrIb6jSKVlAU63Xc4r951lQBbw41MGFrazdOEjCzaQajG9d2X
	UnWW9HFGa/rtFnDaHAIT6sKHRfC4wbUA=
X-Gm-Gg: AZuq6aKR8eN92t7KyPMHMhCLIaaj25LQyuUDQmTH30pXnYrRCBRE4H9c5/Y9DyPXUrr
	ZFbUZu4uPjNgoO24T00UqJdHwbDMqXqHDfuV690+ijyg0IDcHfOhTDnYv985QCxtcd308pbAiqc
	Vjq24VNj0fGRMLh412aNyACmZQ3d9uYFwuIBEVKjONGZqTxYzNXbOH8dxlBBACWqJQckC0BVvaT
	nn9yXUm4lhOCk7Wtl41rEvbb9YhYU7MIfjKvhgFCkHdX7s4WzHqLrOc4Qb0ln5AKAmMrXU=
X-Received: by 2002:a05:690e:400d:b0:644:444f:3bd1 with SMTP id
 956f58d0204a3-649a84cf80fmr5260688d50.68.1769884870164; Sat, 31 Jan 2026
 10:41:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131050920.2574084-3-ameryhung@gmail.com> <978ac9073e0fadb08c40399bbff7d78cfa4a826ef98911fd654318a9ef9725b4@mail.kernel.org>
In-Reply-To: <978ac9073e0fadb08c40399bbff7d78cfa4a826ef98911fd654318a9ef9725b4@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 31 Jan 2026 10:40:59 -0800
X-Gm-Features: AZwV_QiX0B343TusihQFChhKSjsbE837pUNA0oKthdptcAdSvgLvkRaiz1Igm2c
Message-ID: <CAMB2axOww9RzMFVefSmkPXCggDxE8Y_vJONz=X+5Xaw7099e5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 02/16] bpf: Convert bpf_selem_unlink_map to failable
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kpsingh@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, haoluo@google.com, kernel-team@meta.com, ast@kernel.org, 
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 9:33=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
>
> commit 82de4fd08a55cc944c23c9ae889ed792870964d9
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Convert bpf_selem_unlink_map to failable
>
> This commit converts bpf_selem_unlink_map() to return an int (always 0 fo=
r
> now) in preparation for changing bpf_local_storage_map_bucket::lock to
> rqspinlock. It introduces _nolock helper variants and extends critical
> sections to ensure atomic link/unlink operations.
>
> > Remove the selem_linked_to_map_lockless() check as an selem in the
> > commom paths (not bpf_local_storage_map_free() or
>
> This isn't a bug, but there's a typo here: "commom" should be "common".
>

Will fix the typo

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/215393=
40647
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit demonstrates deep BPF subsystem kno=
wledge, contains a human-typical typo, and is part of a coherent patch seri=
es - all indicators of human authorship.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Minor typo in commit message (commom should b=
e common) - no functional impact.
