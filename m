Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433533BD25C
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163467; cv=pass; b=AbYAOUuu0B8l38zXxmWY+WVFIODjX+++kKQmsBThBeshCrzMM0nObBdMOLhTGiU1brkjNO9Rwh8PaYeJsQie2p6fSBL4KJ0K+sNIG/u6Qm2hoFLc5yVOj4xBT63NYMAe+DqSRctWknq+gUjwoWHi6wY0wQQPPLzK+kwMJcImy6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163467; c=relaxed/simple;
	bh=qe6UOPyH09fVG+sn9JIknvgtuqP2tPFx+HmroRjB1BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e49RWmVeXcoijYC2h1r/XnatAAChn6sPzpR9VG78PYruMuLtgi2Ykvwva4Ef2hWy+WwuOXRF7+ntbboU50Lf++GuUSLh2qANGLajsaz6o9Qdw2CfF44H8rz7zpHY5sYZ1Fl/qNeuLVuv1KzOq8bAFK8In3pk2IQrgkYdxEJFV3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ld7NVVPT; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld7NVVPT"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-482f454be5bso1546825e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773163463; cv=none;
        d=google.com; s=arc-20240605;
        b=PrAscyBQLTAIhCuYFDoaEN/HNAxdrkKs9pFoVhzNV/3C7UeuXqZUesqwLbtOLB1Wax
         Cnziw1KWEjF5TyWTysBpJsO2BnjR5F/evQ/PhO5e2Vn8dgHk7+37MXMJ7Sf8tGTRw96/
         ZgkUZL4aeZgjUlV5Wqol1miIg7aEQxthngRoI4307abB4YLKcrDvGLwkFL/gzKuAzVv+
         7WyiikaQgQHRUe+W8etffa/ib7Kudr4Ds3NMC57HqbTzKmLTJ1qMe34NJcUjXlkAOj20
         2EeA8QOfDfM0Y1pyw9H9HeCdZq8f6Q5sPku5UvKb1kU8Wv6CIAdT2VKJdax196FyF042
         uz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m34P9qg5/9p0up6Ob522geMpxbEkYzYijmYKyt2ZJUw=;
        fh=ZkufZdZHwH3k+V8sWuGBU483c0qCHBsSpEyWzfQweJU=;
        b=BYpmQUUH6ipxtbJm+xDtY07qU9QGjSGAFNxz3xp5EkSar4DkLrZO5seAvT6Feizujr
         L+n3MAecsMfkU8GsZep5zMsqXHtpBlK37ANeCK/fh6pW+nDwWM5dq6K23HkxxSGW6+qP
         JbUiiLG4J0SnX5MAoRe64KFwUKJjNyXoAtaIFewiArPUqdYunCm31TTHMSk1mEdG4JFl
         k9uNC9UwI8WuhyrmlHH6Pm2WfeqJZL3cWXCKkp2nFYzd/PL67WfmLttR0cBg11XDQ/kb
         zrcMauNsMFV+qEA9LDR8RjXGF7CK05mD1vEM1bXJ9PmpYmgB+YDDce2N0HQxUc8C/d+M
         9Cyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773163463; x=1773768263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m34P9qg5/9p0up6Ob522geMpxbEkYzYijmYKyt2ZJUw=;
        b=ld7NVVPTHQ3qZjn108yq6rGOKQ8aSqMn0E4BqLLp0jATneuZIHFsKKjd3Hkgy4PJhh
         p5qxLlQtfImvbXRtM7Z3mwTgwM0vNT6QQ7S5/f7MP/J8rOQBEwtdlZKo29DVJwdhJ1o3
         kwdyuBQeDLES+itEZawxZB+FG8FXwWLjg8jw+4ldHM2vXohqKUB52OG6X4Jcv3UVrzZO
         Qjk6Ut/JFpJmFTvPPRrACxL0y7f3m7v7b/9RcruEL7t7st/yQnvSE0bGKPFfX2w7tP6x
         Zk+8aqtmiPkrRDDUZqt3SJjUrjjOBdWWDJLW8d+2Fq7G22hEaZtm4SWaNgfwYlJbIL5G
         iu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773163463; x=1773768263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m34P9qg5/9p0up6Ob522geMpxbEkYzYijmYKyt2ZJUw=;
        b=SsAfds4ptX3DEJzN+DTcmci7iXzk63Ym0CMGSYQFn58qlbX8FROGT7U4ngOKD5wKL/
         n01HzLuvs4k5/eyNqXq1sPLVQrmm1GVwx2NlZEIuIhL+3d/ALTBVDLKxdJBKe+jdwfza
         xEFFqnJgujFlaiR2cItYL6SjF2SX/WE0vT57n2//E10qHbJCtM2R+4byjTd+3LKsDAur
         j8KMjqbNBgIcNSF5PhyelP3ABNbloNDsiyefLnwI7NmagO1NlVt0gmn+1r2U2NXHKbwI
         fq2avUH7+PXET/A01JD+AJxF3XB6lDdORsLp1gvrQtWtD39CbtMILmuDGKQC9LlHRqNS
         T0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl/GHwHY+4hOwsxW61mD4m2Nv6TsD1Msh20qwYgYoHgg2zGws+IPPcy23FL3kbEcFVMH0ZQvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA8HZ/M6ofL79WRalOfJ3ZmuiaoKogJOtkmuTwA9vCQ+VOM5pi
	w2vSIiP+hOSsvU10S3ZGN9xf0NKlSAEEIlITEMRO/DGZ0JU4519xDUPiBNWtNKZFSXv2UOBJiUC
	tO3Zjcqqfn0ARmJbskii8pHyliZiwEpE=
X-Gm-Gg: ATEYQzwLG9LxQnm/plqBsLSH5NqF/FYfHdzWhoTZ9uk1oMDdAXuspVCb0+via3sb5g5
	muLoX8aHQU3sx5IwH66EBh14xnYOjrGIXeDv9P/BuQv3vz/VNN3k3rA7W+qCI+Ln85sl0LITGGQ
	kWWcwQaJQNQMycIJdkccHA+Nj98Rc+2mVOhxMI7CQ/cjyweORS7FiWs02tdgDeTFu6t9Yu6oHQc
	muYeffi8cfOb/QKCHFExGELV5DExXxF2g7/ojosOJ2AR/vxW6UNcS8NzDK6oY2EEydUrX2SYRt4
	R6p9OqCmtFaxz4aDEkifPqdLjkp+BnwKIfmm2Cbqi2o/rBC6EpDQubagZ7Zw
X-Received: by 2002:a05:600d:6450:20b0:483:a2b0:d210 with SMTP id
 5b1f17b1804b1-485419e0654mr57793155e9.7.1773163462372; Tue, 10 Mar 2026
 10:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303150639.85007-4-leon.hwang@linux.dev> <47fbcb9aa941b07054bfef30b802d488688fafdf6df889e78b38313a614b98c1@mail.kernel.org>
In-Reply-To: <47fbcb9aa941b07054bfef30b802d488688fafdf6df889e78b38313a614b98c1@mail.kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 10 Mar 2026 18:23:45 +0100
X-Gm-Features: AaiRm513_5D97dMh5zZ6mTaj8z2tHS7OLQWsE8CcolmJzu3CwwWzrNbuIqXtyes
Message-ID: <CAP01T74sqmUAL7=PuzFPNbghX+6N_OzrsZiOHcMEMtg01CuL4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
To: bot+bpf-ci@kernel.org
Cc: leon.hwang@linux.dev, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, yangfeng@kylinos.cn, 
	menglong8.dong@gmail.com, puranjay@kernel.org, bjorn@kernel.org, 
	pulehui@huawei.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	kernel-patches-bot@fb.com, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Mar 2026 at 17:04, <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
>
> [ ... ]
>
> > +     switch (match) {
> > +     case BPF_MAP_OWNER_MATCH_FOR_INIT:
> > +             if (owner->kprobe_write_ctx != aux->kprobe_write_ctx)
> > +                     return false;
> > +             break;
> > +
> > +     case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
> > +             if (!owner->kprobe_write_ctx && aux->kprobe_write_ctx)
> > +                     return false;
> > +             break;
> > +     }
>
> In the v1 review, Alexei Starovoitov asked for strict conformance
> both ways rather than one-directional validation:
>
>     "Don't be fancy. Require strict conformance both ways
>     in *all* patches."
>
> https://lore.kernel.org/bpf/CAADnVQ+-V0-1i8_+CYpK7G0CnV-2n8e9Szv43yM3Az197eL_0A@mail.gmail.com/
>
> The BPF_MAP_OWNER_MATCH_FOR_UPDATE case still uses one-directional
> matching, rejecting only !owner->kprobe_write_ctx && aux->kprobe_write_ctx
> but allowing the reverse.  Was this an intentional design choice, and
> if so, should the changelog note the disagreement?
>

Let's follow the approach Alexei outlined, while the changes look ok
to me, let's remove the one way check and just do
owner->kprobe_write_ctx != aux->kprobe_write_ctx, same for the other
two checks. With this we can also get rid of this INIT vs UPDATE
distinction.

Other than that I think patches are good, please also test both
directions in the selftest in next respin.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22630000544
