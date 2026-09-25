Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D8B27FD5B
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 01:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790300512; cv=none; b=FQneCL13kdey5/fV3YdAqsFXc3O3hC17werZRANcE0o/Eg4/XKnWvxsiMokgsUNz1WdfTEgnkSNQgDT+Wd1SI9DiWtYJFgAJbMdVm9V1SFJK411UKEaSAAXoadiCvrrVwHdjivz33ZVgJF8eykH2Yw1D4WPby3yppKSaJIjPoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790300512; c=relaxed/simple;
	bh=HthLM1PNuMxWBTXS0+87vYoHdZV1BdbX8Mxz0swEQZM=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=faDiqwvsA9oAZn6lA8Zc2kdHoBkc+blpOGazmEvoKQCkzbvS+tDArh0d7tAEEWlVtVJkjtTprvDHOMB+x/dTMHK9kA9GWLKNCAK7e1oXfSkt/+KGMQIsZY/p3Yj/kdRhUvTd58J5QihizNztrWkWqxjMurPTG/9/8Ns/PlNjYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi5uHPAP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi5uHPAP"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caced6038eso3422475ad.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 18:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790300510; x=1790905310; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Puu4CDfvezT3ht6t8GsmQo1t/a87HCIDmLSfwmKbMYM=;
        b=Xi5uHPAP+nnuCFNFZsW870C369kbysRQcixIRh1hW4RsNqpF6chI/hJM7uSBfmYo/x
         bK9S+uB4JRnXgrNy3D6Wk2gfh2nv4vnq3mQSrdL4YNkIxXdjn8HySX/tt3IbyoWtxuRI
         bswVkFCXkcIqbnCqTGNd+WgvbxV0r6kX+IpHbAV2m/Vw1aH+5v6vxZMx3V9fMGZWLx6j
         oPE00kYJCtvEQgbbG5Yz3OXsMmaCFJA1OHrjk2JgNO8i6xMJOVEzTzgJxvmLutmgiFJS
         YTIWzwihROFf211McJ5dtO/yHBp+8W/i79kS2+CgtItOxztxPJpqBO6S66XBW1QKxLrX
         6H2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790300510; x=1790905310;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Puu4CDfvezT3ht6t8GsmQo1t/a87HCIDmLSfwmKbMYM=;
        b=QnceJkjC5oxTpPF6OSL/LzXbKi8/NS7PFy1JU5nLMkTUMatdyCE5ym7Lq8IgY0qWAc
         +4ROSoVwfWToskxdjAJ6tDPdcq2Rw5toAQS7AVKddWvDKTAU2yOSf3aYCCs7SrcXDlDe
         Pf3+PMx3BEltMySvii1ljA/ZGzrURdQsOusdrWYIdh8U+8+Ds7epw/nquoR2e5vHnHD2
         XTYPj+8Q/6ENG0MFIS1Qxb3YrkJHrC3x5AUj05vg8aPWdCw8lbPg4Q4QkDpFqeyY6wW1
         c9dpgh9ciExAVTaRuXcsCNBZmqWeUThM9CcGrdjNoefYKI+pk6Y1Vh5ooun6C6py9nnl
         PE9Q==
X-Forwarded-Encrypted: i=1; AKwUvBywfz8toUl+I3Ts7VcQrerJZjgdeCYDvnFfa9GfpQXKqj2FmtfE0OJQAFhB4foRRAm4NexBjNM=@vger.kernel.org
X-Gm-Message-State: AFuF++kzDLvEs3wTy1O1Si9XZoujCur00Qamcf9RrhoGN0QtyElDeq2H
	a0etGZzi9P+XZczprjonU/dvdwcgFtj1VQDTIWXI+gWfs+HWf2ECjEMP
X-Gm-Gg: AYBFou08ZVVKFeHYfBYvCINCkhLa95vjpp+PXH3xgpBQ1+MSjmKELuOHf5vzkb3HUPy
	jP8aQ9yiLeK0MWwNjB11WY9s00htbu6+hk4rcEsN1w5J3TN/lU9PET12uBx08XAeHwoQiC5vAeH
	dxxsz+5Up6EtX4vCHRhvQvSkAAtXQqYPRcnpnIUHslMBBa5x3cqhoJkg9ldsaWnbYLXRzVcPoJ0
	nJC6QV79XMZ48pfdj3O6xUoY68vn2UBvi5oQJgHUadxh4L0HGntUZIrtK9/vGQaPhJ8inlmLE50
	7BEWVdl1BbfWNcYmqK9NHKWQCF54wA7ml2RulWdHqPvPIMuD93Flcz7i/d0LDflJsvdCBnx6pHF
	YBfa/htCKxyIhhjjyXVtpQAgHkLdC/yYL8g5YlKFHr7B2ohjCz89AitQlC4Yk9ChGYK5ybhhFye
	xnThyv2KIbI4z+faZ3CVpG2RcAdl7IQ5XtbWVb531ntU9dKMdvITYsIu7ig88AlSwYp50+DIQGW
	D3fHGRBTQmNNLlpXUKS2gxOcbC3bUeudR2rOvtBw4RdU/jOPdWzy+vwxNvR096KK58vOMg+DtiM
	RNE=
X-Received: by 2002:a17:903:19cd:b0:2d7:5da6:2af4 with SMTP id d9443c01a7336-2df7dea6233mr27180655ad.4.1790300509668;
        Thu, 24 Sep 2026 18:41:49 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913ff226sm2784535ad.34.2026.09.24.18.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 18:41:49 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 01:41:48 +0000
Message-Id: <DLO0KBIOE5JY.3DY4JTZOWT5IU@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Yonghong Song" <yonghong.song@linux.dev>, "John
 Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Eric Dumazet" <edumazet@google.com>, "Neal Cardwell"
 <ncardwell@google.com>, "Willem de Bruijn" <willemb@google.com>, "Tenzin
 Ukyab" <ukyab@berkeley.edu>, =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@meta.com>, "Kuniyuki Iwashima" <kuni1840@gmail.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ameryhung@gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/8] bpf: tcp: Introduce
 bpf_tcp_ops.{enqueue,dequeue}_rcvq().
In-Reply-To: <CAAVpQUBGSahLGEqGQCD2_0Ro2e-=59W7mhVyxOnoFU==LAK9tw@mail.gmail.com>
References: <20260923213719.224838-1-kuniyu@google.com> <20260923213719.224838-4-kuniyu@google.com> <DLNYI40PF2Q3.1KYC8MHZU2VJ@gmail.com> <CAAVpQUBGSahLGEqGQCD2_0Ro2e-=59W7mhVyxOnoFU==LAK9tw@mail.gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 05:39 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>> can we drop the flag ?
>> hdr_opt_len() is called for every tx skb without per-socket opt-in.
>
> Oh, I assumed bpf_tcp_ops keeps the same behaviour.

bpf_tcp_ops were moved out of BPF_SOCK_OPS_TEST_FLAG() guards on
purpose. None of the existing members has per-socket opt-in.
hdr_opt_len() runs for every tx skb, rtt() for every rtt sample.
See the log of commit 3bb54768fe3e
("bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_ops"):
"A per-member/per-cgroup gate could be added later if the extra
fast-path work proves measurable."

> We have a bpf prog to turn the hook on (from cgroup_skb/ingress),
> only when ingress rate exceeds the allocated capacity, to signal that
> via a custom TCP option and turn the hook off from the hook itself.
> (and I planned to post another patch for that)

That should work today without another patch and without the flag.
cgroup_skb/ingress prog does
  bpf_sk_storage_get(&map, sk, 0, BPF_SK_STORAGE_GET_F_CREATE);
when the rate is exceeded. hdr_opt_len() and write_hdr_opt() do
  bpf_sk_storage_get(&map, sk, 0, 0);
and return when it's NULL. write_hdr_opt() calls
bpf_sk_storage_delete() after the option went out.
cg_skb_func_proto() has both helpers and get_func_proto() in
bpf_tcp_ops.c allows them in every member.
egress_read_sock_fields() in test_sock_fields.c does the cgroup_skb
part.

> Anyway, is it because calling bpf prog is not very expensive
> or per-prog switch is preferable to per-socket flag ?

The switch is still per socket. It's sk_storage instead of a bit in
tcp_sock, so every prog has its own.

While such new flag is per socket, but it's one for all progs.

And you want to take the last bit of u8 bpf_sock_ops_cb_flags...

As far as the cost. A socket that didn't opt in pays for an indirect
call into the prog and for bpf_sk_storage_get() that finds nothing,
but only in cgroups where bpf_tcp_ops with enqueue_rcvq is attached.
The members that are not set are NULL and bpf_tcp_ops_call() skips
them. That's what hdr_opt_len() costs on tx.

I don't remember what Amery measured, but worth benchmarking
for your case.

>> The prog in patch 8 already returns when the socket has no
>> sk_storage.
>
> Yes, but this is only for bpf verifier.

tcp_init_autolowat_cb() can be the only place that passes
BPF_SK_STORAGE_GET_F_CREATE.
So for a socket that didn't do setsockopt(BPF_TCP_AUTOLOWAT)
other cbs will return NULL on lookup.

tcp_disable_autolowat() will do:
  bpf_sk_storage_delete(&tcp_autolowat_map, sk);
  bpf_tcp_ops_set_rcvlowat(sk, 1);

> Just an idea, would it make sense to add a kfunc to move bpf_tcp_ops
> callback to a shadow pointer by allocating sizeof(bpf_tcp_ops) * 2 ?

Doesn't look right to me.

Amery,
please share your thoughts here.

