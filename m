Received: from mail-dl2-f33.google.com (mail-dl2-f33.google.com [74.125.229.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941122D7398
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296803; cv=pass; b=lblfM840nnGw4E17mXqu7SL+DNJ/Fg+Nfw0uouf3tKS6uyEMiOnz0+Om5i711qrIfxKB6+KhMRX5vH+BK3Z0d2Y0O9ZOwBhwkHXlt6GV5O3LjevtRRi1bnA9y/GsTwq9DHpOmOaStz7ecOy3edh2gr3CiywuU2ueNQggPLOZiAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296803; c=relaxed/simple;
	bh=ftxDqU9XlFwz6e2iit+lB9vVqjsOV4WsGNNi9lM6TeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEvWbGBzw6OyZKqSxQYe8oXZIi0YP19y/UgGTH7g7t+fRJaXWCFMQOIoPaPC1rnWFNC5DYuoDb/8hPBz2IYbEmdwT46Lbxj1WEKZcFBWgFdlSzKEjzCWZFKkvh9VoGw55BxpKPJSedJBG9JmA3OnzK0KPbfv4n9HCPSRuzh2GKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UnKxa/ST; arc=pass smtp.client-ip=74.125.229.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UnKxa/ST"
Received: by mail-dl2-f33.google.com with SMTP id a92af1059eb24-1438e88300cso349805c88.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 17:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790296800; cv=none;
        d=google.com; s=arc-20260327;
        b=f4ROE0uOQPgBQ3Kg+k/RWwbmHY5QI6VOYYotIyGKrEywHlDjtid0E7fsfU4TbXXU8G
         1bVWeu2lZJ3T+nAx7Hk6YFtjUWnHl9au+MZFv5bvCsIH4Zwmc/+SfYEpBSUfMINjJfRJ
         VDHWiNdYCelIqxZX3duARN1wGt4NKLLvKBZUeyLpFLCCXhCV+ZmtUD7VUlLbl6Q9onlE
         vPTK7Y0W68LaUg+IsZTlCQCPowSvnPCVT1DTaQNqaoM+w2VPHX9M8LeuNFv3FoLNsDB2
         u+u4MHSL7S+GxLj8YZvgx/pUvIzoa1ypw2vzA1OBlZHWEO9Jt1IeZXZ5Jz1oqS1Udzyh
         7MFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ifhmGNF90wvvVdVpuw9Aasse7UJ+lz8YulJtQDHPaE=;
        fh=JenOG4CPpvYinBTrcHHMSJob1oKDLhOagtoMGUoV9u4=;
        b=Bnu9+5fheDb34W3Dzg/dczAVGHiOHc+Ip4Mn08BFRcA5ZnHpq0g5GpMGlWfWNDDf5S
         k+abeZB0iFBSB2Cz5YckqFWKx8UfoMO5KE44kd6MkE+iirYTHNpPw4JWrpSZ+fjl/rpJ
         CoptSZ9DI86Ey/r67IZUwqS5I48JiF/rvZ5G9hVfh33rNATURBmiF3Rka6TfJAJ7JIKv
         nxegCkHuzvBCCgLyJIwQvkyO+QLKaDvn/RCVwVR/+59dZw279GkyCfucVf/u9TqoM9Al
         5cH55o1FejJjZUjh1OalitKighXynOgGU9LxPYxHndD+316h3bkGwTAdiOKUiGOrNuEa
         K4lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790296800; x=1790901600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ifhmGNF90wvvVdVpuw9Aasse7UJ+lz8YulJtQDHPaE=;
        b=UnKxa/STE13A+YnqlFpJW09IqU/HeF+aw9jLggVsG1wkHhh8VqSDwi1ncGPj846VFl
         DImfFWzrmL8XYUtyUpnVacqEckNMjd1tXNNnaO1IeRLNPBds7y17X419nhzBsOJwE5aq
         2T2WxMdn2nL7DC6wbZIqKfvr9pK4WnADPiecdokz/ejmmBu7pOirykQSAi9cGnS8DgpT
         hYyLxgziCWQ/rsycBf1o9W9smG73/e1SM5oeJ7oxksJUSYG/qq/kqnjO7+3LQfQGIcJr
         aZRqvGxBbUOpmm7LPWKxGLya3mhQz43BMpBfzAQ9WLpEUy6sDedk0zxKYWuNYFsqAlXy
         yLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790296800; x=1790901600;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ifhmGNF90wvvVdVpuw9Aasse7UJ+lz8YulJtQDHPaE=;
        b=2q80G9GjmNhQe5vj8+71EGZH0NsMcGpVoaaCVpx2m9qnRTliT+vXsI0iemt0uePJrs
         y2H+E/OcFxbwf0XbTX+fAYUyCwE+CVIqRRXdMAREd5xbB/UxhlffHZ0fewF8cKcZEesE
         FsQYXm2and+oWw7sC29XFe/7dUVatAMx+XvYHY0aPPH8zZ/0dwLXHN/TMq/EJeza2lWr
         BaF0eO4aiCqjk8jw9GknUi7Hwl8HBCEKyU/vgWv3EQAel2QGGMrZFNuG6HOwRH1EfAkq
         w0RMxVFO+0X/lMF8F/axI0zOnpmjB21NZ2EGyvYcYxduVzGmMHMv514rhCBO6cyK/3h5
         y/hw==
X-Forwarded-Encrypted: i=1; AKwUvBwkh0OXHAOc7g/TBFrbvLiwbUtQb0PickdoTJppjs9h8is1ARjc0HO/AvRl/ida4LBiOARXHP4=@vger.kernel.org
X-Gm-Message-State: AFuF++n8yZg8u3urfO2xOXgFgSN4Lr/q02uijLOHcffLb1f36z/xzZ+/
	zhsMhN88rX2gBea+S+nZy+AZmBQpez9V5Etofq3gDi1UfwjS+a9Fc6UseZnfse0XLeoXBSqBAqD
	d9aLg2DE8sOsbA59Zz1hjB8KvlbonbYrRZz4cpKdV
X-Gm-Gg: AYBFou2L9qBCE1fjUO+G94cMDAblSXpo57N7fsmSW508mNub7xby3WHouvW4G+tNbIL
	+SJ7E5xAR9/wI1iB3bri4DfOAVj2LiYQ2y3x4u9fp+NvD87wzNcBI8IcPU9RBUIiMM9JDqq3DEu
	LwDJ2W5WwubE27P+htsW5yt6RKKGODYTTJnxQpjjRroOQLNb7kGA3q7bas45MZVbtoIgzqoMmU/
	Z0xlCOymTNsdbo/YpFh5skYRmnOWK8XLr6mK27BZ7fyBZpYJ8vdhzYfrJH+YvQonQnD5Y0jZ+nR
	bZK4rGTvGog3DqC/xthqCWqTfHo244E9twVS/9cVudY9PkecbEuS2rqWZVDlwmJ+0luNJgShaOE
	a4a6NRlRJBmemcYwW2vxoDhpIryw3P3Vz35oW/fAONEbG3X+jmE229gijMGBowe1P7fMgYIcmoU
	x6p3aWQSen6eCWUSnTi6YE4g==
X-Received: by 2002:a05:7022:1e03:b0:144:f85a:a188 with SMTP id
 a92af1059eb24-14503f2d6ecmr5121732c88.2.1790296799688; Thu, 24 Sep 2026
 17:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com> <20260923213719.224838-4-kuniyu@google.com>
 <DLNYI40PF2Q3.1KYC8MHZU2VJ@gmail.com>
In-Reply-To: <DLNYI40PF2Q3.1KYC8MHZU2VJ@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 24 Sep 2026 17:39:47 -0700
X-Gm-Features: AclHuK_Qwt2GMVGY4hmLeMVx26fLamZTuVjIH8k3C8fGyjWtdVLuVOM-Awl3giY
Message-ID: <CAAVpQUBGSahLGEqGQCD2_0Ro2e-=59W7mhVyxOnoFU==LAK9tw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/8] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 5:04=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Sep 23, 2026 at 09:35 PM Kuniyuki Iwashima <kuniyu@google.com> wr=
ote:
> > +     /* Call bpf when the TCP stack enqueues/dequeues payload
> > +      * to/from sk->sk_receive_queue.
> > +      *
> > +      * Only bpf_tcp_ops is supported.
> > +      *
> > +      * It can be used to adjust sk->sk_rcvlowat and suppress
> > +      * unnecessary wakeups before sufficient data is available.
> > +      */
> > +     BPF_SOCK_OPS_RCVQ_CB_FLAG =3D (1<<7),
> >  /* Mask of all currently supported cb flags */
> > -     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
> > +     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0xFF,
>
> can we drop the flag ?
> hdr_opt_len() is called for every tx skb without per-socket opt-in.

Oh, I assumed bpf_tcp_ops keeps the same behaviour.

We have a bpf prog to turn the hook on (from cgroup_skb/ingress),
only when ingress rate exceeds the allocated capacity, to signal that
via a custom TCP option and turn the hook off from the hook itself.
(and I planned to post another patch for that)

Anyway, is it because calling bpf prog is not very expensive
or per-prog switch is preferable to per-socket flag ?


> The prog in patch 8 already returns when the socket has no
> sk_storage.

Yes, but this is only for bpf verifier.

>
> The flag is one bit per socket shared by all bpf_tcp_ops in the
> cgroup hierarchy. When one prog clears it the others stop getting
> enqueue_rcvq().

Just an idea, would it make sense to add a kfunc to move bpf_tcp_ops
callback to a shadow pointer by allocating sizeof(bpf_tcp_ops) * 2 ?


>
> Then sk_is_mptcp() check in the kfunc is enough and there is no need
> to touch bpf_sock_ops_cb_flags_set() and TCP_BPF_SOCK_OPS_CB_FLAGS.

It also works, but I wanted to move the dead check to the
control path instead of checking for every rx skb / recvmsg().

and now I think we should move bpf_sock_ops_cb_flags to
a better place (maybe tcp_sock_read_txrx) in tcp_sock.
