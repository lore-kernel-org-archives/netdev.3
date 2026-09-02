Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1739CCFB
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378215; cv=pass; b=TwMkTGVwf/NF4d8VmNMXqKZEHZ88RmNtluEDEnX1dFUbhGT7OS929iQ9JLE/8DxvkSCnwUy6mdT2bqxG5/9D3qGkSyVqAdknWCpqkYWFomS9iKtwOndaj/DxijuIIB9FizmlfZtjStGxuJefk3DfVzQqszaomEoZ5SORA6y5+JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378215; c=relaxed/simple;
	bh=v13IBvJ3Cs5k45Op8zhzzynqZs/Da4H7F6eGXP4EZOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJr0SPaq9ec3JHr9IYOqtMecwG560PzB5kPn9w0Un2r72sf9hx3M3iXNMsHtZoaMA3m3k5pP4LT1q/iPEUHhKlLOpsPB60/W6soWO+N3A4349zNVqRA/9z2XXNB00XcH6IaVP6DZqisDeEErq/sX+EqqCuW0uZAGyFpsud7SLVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aYFA5tCO; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aYFA5tCO"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1483802b3a.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 12:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788378196; cv=none;
        d=google.com; s=arc-20260327;
        b=ZJgQk95ezG+6KQ4olLfWgLNB93S4XNBWAS+OTdHj+8ocMdaV82ThJrN+kcRNHKWvNS
         29q8dYNsAXjVxPmjJPbCPeabwHE9Gu0lkpmcxZFC9PTMi0zbGEfQnJilqJIgZ30Ux1VD
         dN2QVM53xho4rJTlnKwmhn3nzTzzsSG/vxd8UiIfzx+bzby8ICweK3U7km5ZgJJ7e7Cg
         XBHkp6MMcH4iR1DIddetuu7S4B429rlwm/WIMTIeoaIahtCyy97xmp44KaymWy7IKBqX
         5gEoLHKg+mHYc3D40dRMY4wmBVowIUB67Bk5mbaq3hYomcDkCAARRGK9spOATQkWzGwH
         laVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HZzgWfQ/86NrxOY8y/QdFfPZVfg39pEM5TlwSWapW24=;
        fh=uRuF63zACNWM/AyVHFELnFymGuvgLbxakvhY/vkzmeA=;
        b=PvhJeeziWuLFI0iTm97/IbiXOmd9MtXtR1+OgjhWyucwC1kh5dGl1vE9t8/uVFchDv
         HahHgPE7kwiDiWaGDAi/zYtZbX7/yU1xtBXfG022V5cKu8NxgnDMZcAXzrNa96RKuWtR
         onDbP8AiA1odQCv0YLD6lVwTFgUiqx8JCjbjOj9VrvBnCnSIq3Jx8q7GjyOzBnQACzhl
         yzaNcdMlv3a5H6mfVDdg8w1X1h0C/4x4vTVdoDhsr/WkKS9KbvWX9MPhQ7CzMKfBmuGx
         MCf03HlOMQfUjEO6PdhAPJcqKIpdQOamHAwOrW3CVsBpeVwWn6xpRUWacoYUmqB7xwrw
         vHyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788378196; x=1788982996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HZzgWfQ/86NrxOY8y/QdFfPZVfg39pEM5TlwSWapW24=;
        b=aYFA5tCOZ5UjOiabbKf+4Li2QUBDULtgqc0UtYdMcN42FuRj6wzgCLFhAKAaI60NZg
         7u1Eli49zAV6MQy2b78QDrhXqwsAAyzcu0FxEVwk7WavXov/6rxM2LcwYoEZz+y3+VJW
         UPE1ELzTJgWxSva8X0e2e1NXkBo3cCfyVB0GIATavl2RU2ZDH7e8KvDWAqlS6L4lRWc7
         K6dMtF07P92DD6er/SfN4xho3HHF40di7hzQcuudBqZKdhG7XH6aiNRsVxtH3VbzeKgV
         MtP22v903BOORWOseI5xsYPMTLbzRrrQg9QhGLpbqq1N/BcLGnPT4dTtTl6qp/VcSKPD
         sBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378196; x=1788982996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZzgWfQ/86NrxOY8y/QdFfPZVfg39pEM5TlwSWapW24=;
        b=Hn8uxZd5oGSDvtuE89vhjLcyFwVvU9ZnrctZVZDeR8YB8JgPDrD5Yhct5TPTbamb7D
         s/R2zeBkTVCAjr2G7+kQ4lD9mlrksPcdcxOZYHS4Q03xTW+6k0FSnBmCfWRPbNeXvXV5
         8D+HEuHoVwrYDxw2XHriYAFrFWK3P/vebxvWY5u95jDKo2PCviskt9eL5vg15s4j5YAp
         +xYkt0cPt77wf1pg/VSYKvFyxFIh586PAe74krnC+491oHZ0zYxYkbrFV6yS7cyqMTh2
         L5VSbRYa8/bS8pCRzHIs7ckCZqcBOPU+fHakJovVhcM8DGF/YD6OXRquyacbsyuiF2pw
         OJzQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/qN2dmzmy0JaXuaFtyXuIj3KaZpwV13MwoOMXMMIemXfisV84UwU3/nBHu+ETQ3J3TbatlU8=@vger.kernel.org
X-Gm-Message-State: AFuF++nKnYkUtM6dkvRYAqwT8BvpCee3i8pj01xwLzgBVnhfiXcKNZ/Y
	zIZlmYHNyX3RJ84AUBhrsAI8n9F5O+k1+wKszqBJH7KHWibUKUqULqhvEFvrZMGmLzboI9bA4Dp
	bQabORxLkX+VWEcMhHJAxtcU5Xz+gCREs5LjBQqq9
X-Gm-Gg: AYBFou3g+drGkoFhi8Rr+vY9gpPIMfhXs9JKqz2N9ysq2XjUfmPInOphbTYoveExtJo
	C68hjj7An5SCVkpnI918+mfPMtBtjry22UP+yBJZeeK6TGVp8Eu/6lrpMCUTCOlqi36W4c5TTFe
	fRIRS7rNEw/a+v4ZjNqYcp15IrUUZxOeHk6BmXvrOESO63ytjlpuAfuUkeLdXS0eTVY6ZcPxziZ
	zdWkoO+A1rvcSngY0SUbPC3MNPMljsA7Q9seK4uYeISJpByEWp/GA2u4XhE0o6To1jPhXYCy9wP
	ft/y+5CylTo7PPMsRRTGxRNoDIMc4MITbMAPCkzxLXyF
X-Received: by 2002:a05:6a21:2d04:b0:3d1:8876:fb1e with SMTP id
 adf61e73a8af0-3d9a9695714mr11592712637.0.1788378196405; Wed, 02 Sep 2026
 12:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <20260831110934.241898-2-a.s.protopopov@gmail.com> <CAHC9VhT7=wMsB9mERWoiM6pF+_T1=2tyAsSrxMphhtdE2NPHMw@mail.gmail.com>
 <apbU8-fpioNIwUA8@mail.gmail.com> <CAHC9VhQbWPqEz5g1rVcMyJgrzzd4cQuwi7cddgJQK1H3ugMz7A@mail.gmail.com>
 <aphBNqQK0JeVy5Sm@mail.gmail.com>
In-Reply-To: <aphBNqQK0JeVy5Sm@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Sep 2026 15:43:04 -0400
X-Gm-Features: AcwNN1XYNCXydNpNM6ZU2Rnek6l8sLmm3paMheXeGevlLusJ85KkWm2it_ZUJS0
Message-ID: <CAHC9VhREB2krVp9XkV6Psp4PWhYT14281+1TQUZL7o+GTo1cXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Allow BPF LSM programs to attach to
 more hooks
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, John Fastabend <john.fastabend@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 11:20=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
> On 26/09/01 06:15PM, Paul Moore wrote:

...

> > The core issue has little to do with BPF, it has everything to do with
> > in-tree vs out-of-tree code.  The BPF LSM is explicitly mentioned as a
> > "pass through" because some have argued that the BPF LSM is in-tree,
> > and while the basic BPF enablement is in-tree, the actual LSM code
> > that is executed has thus far always been out-of-tree.
>
> Yes, the actual code isn't, but all the building blocks are.
> The BPF is just a sophisticated policy language, in which,
> given, say, ethtool hooks are present, one can say "block
> all ethtool ETHTOOL_TEST_CMD calls for the XXX driver" or so.
>
> Is there any way into turning BPF first-class citizen from LSMs
> point of view?

As I said earlier, the important part is in-tree vs out-of-tree code.
We are not going to add new LSM hooks only for code that lives outside
the kernel sources, regardless of whether that code is written in C,
Rust, or BPF.

--=20
paul-moore.com
