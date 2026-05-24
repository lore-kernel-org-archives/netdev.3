Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967D22E65D
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779621761; cv=pass; b=likhSbiWkSUffWgKfF1e0OhTQA4iQR5RI3YFasfUxMAJ1+zcf6inVgUZqQb3ppu4m4zI9H79d43ILo0iAvSesr1/gDdd75vMvVuMkOpJm3q6wgnl7vb2n85MMvCN/8nCk1wykftOBVRY09MxdB2Suv2aYV0dl7vIiSl69X2Tt7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779621761; c=relaxed/simple;
	bh=O+JZPaK3uRnpTVdRdyFVDzHP/W2oZHJawf02YCzFly4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHtaQfp11VzYt3b0DybrmjQx27F9xFP7nWguB1IPyPAEW4zVbp+gIMhczk3S982yB3BA14Nm0lpuVHq7XN7zA6hqGPUAr9/sc8sAa31vUkBbPlntNF68WShZYGLOYNFo4+HXOip1y6XDXqDaRDK1053l94wKWsKP2vhPtVx7ADw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyW8SkrH; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyW8SkrH"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so4763477f8f.2
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 04:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779621758; cv=none;
        d=google.com; s=arc-20240605;
        b=P/8m7ktVnsnpFr8F1lXRJSpUF9vV294owZZ8UarHJhIT8xFH5ijBbsN0SYttTJlrSw
         LxWmmqj1Ekhytfqb4wfSEALmBmGYbOn11gRZZYE+rPz56lQVfEQQvn3TPtFcopK9qpde
         IMg9XVP/N3x91aw65aMG1uX8QUZi4KonTG5diIxzaDBrhfmT0nT4NWoAQoBAXKYXvFbR
         zuwDHo8gHmxaNs3QyzQCPWR2dO10YdW/90hk6luIa/krei1hLflRqN+fXES60WnL8dze
         7Agkbv47ah7SJXPFnflZmCck0RjEVgv6ja+BzKbbM5DJTDUWZUYPMsY3lLCnditqUuVJ
         fWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JYSKa/1O4kDWFIkCrrL8W7AexNe9Onv81BeAx+bBfI8=;
        fh=WLjUlYFOTTDQOYsy4QBZHrTVpzWCcHt1gYdqy2ia/HI=;
        b=AzsUFJBvdIOCGApRPM99iS+OYx84BtY+qjfr1ptadUZIhLqa52WuKgibVs3+u92y9G
         qRdOfEAd/iZIJ17WJqaLfmiq+9i8zZhZBK0GLnJOk4r3ublzbC5BQB3Nt1NSjSlU8Zlr
         x4y0Sq1epMDhPsp1/txPsWjWHbve1z6NEgCYSXUN17bqtzo+gLSuXv84XnUiuED0PG7n
         49OTZrd2HuACDlgxWRex5KCyqOlmCHR7Wg3CKl3qRaCkbYlkTDzGrpeU/EAqktOoJ3Qa
         zNWbKUDWjG0Gl/JPbPIcgMaqiQMjNzOeFdWovqyCvKQjHWdH4kaz/QBzC9KAifpABqOp
         o9lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779621758; x=1780226558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYSKa/1O4kDWFIkCrrL8W7AexNe9Onv81BeAx+bBfI8=;
        b=fyW8SkrHpdAp0E10iPgLN4TZJpk2OlISyv5ozXCIVPOd7D2/eDJDYOH2p2jYkuoptK
         tzuaRtnwbECR2zjnISJcnL6m70BdPShM8C44Plua/pKRwW5E4j5RehDSkgIY6iEohDNw
         yHofDReNq1PN2D5LKlFEvPRUXYNWqJaQRqqnA/CbCo3gtfX22ZiCRM6J64G6jBkuq1Uz
         6IG8sczDjWpQ7MMJe6rDWMfmWumb7dFedFWztRBBc6hnbXrA9aiqhLcFmecXbm04GPAr
         V1wguZkwSSLZm8TaY886ZJ3n8UBqg3aOsfTmB2pSlsbnyzi03ArfyVp1cU9VaRTsXV3u
         6YPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779621758; x=1780226558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYSKa/1O4kDWFIkCrrL8W7AexNe9Onv81BeAx+bBfI8=;
        b=k9XUjQ2Yl+Drzs/EvUNfYKpcK9i7B7WwvIkh8gYEfq+RwETVyoBVS6IYE/981aJdk2
         pcnBr5sr8SNHdnjxvxgZvqVbjl9RuRJCMPqrAcDil2/GJeEVJPMgu6orMLOiWkvaaqTg
         1oousNXaLQ+XpOl6HsoIm8KKDneGlSlcs647a4U8SiiB2GVBw5h8jM7JXB+JLoRlcvy5
         lZm/fZCa6NRqxwoDx6l9azXH4iRtnj6xPrh6v86jBOhl0J6Bz/FOnlXD08LKpGz6MJfL
         r61igf1Z0/gx0O1dyPVhhiCl4CLb4gL7y501dMTHP+/tmeUMLyT9+ElLy/kfbXQOrs2K
         ssjw==
X-Forwarded-Encrypted: i=1; AFNElJ/ozKW+6+HRQi+F63FrpC+KS0yG64sCe0DdHyz1qOsUNJbcR7yC8Izgb77iMlqvqtXE/V0TzS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDy5xXRky/m2Re9uR0u8zuOGJPRC61WfJ4SP30g4U4x6mR7TZ
	jPywzKWkdkov04+lA5vz236FCFxNnVSxB1JSHofQxlQd1BnO9+xgXx/OuYOcIgk6Hlr4/Pt9SgP
	hggUsmeuQfUXTpxIbvD7Xn2g+ITdu/C8=
X-Gm-Gg: Acq92OFmrDOeZ9K28N63nvowF06dpZ/9OuGlibBA6EFQepPXJVy32b/KYRcaHCbZ0/v
	7jKUPASJiD6H/Y2WXc/rFypKi604S5tVzSp1I83sOTkw8a2e78GeXFD547/2Gs+0wIryZ3mlFGX
	v1ool8mB03CR2UY/rKF9y1urJeGM55ajjQKbdLYElqOSMpsCKegC/zpmViERekWLS62rUVfGqSg
	DuA3asrCV+PRAguDvk1JgffT4AL86CxYb48wQ8KHDSsOXE8nTznaIWU3bdX+htZkt3ZEOuExGal
	sTS9g1smxABpfp6h9AphXlhsNNbvdUzRlwWWk1WkMfO7LAhTQ4vOo2Pfq/t+aGl8xEjIuA==
X-Received: by 2002:a05:6000:468c:b0:43b:5b25:67f8 with SMTP id
 ffacd0b85a97d-45eb38b392bmr12088047f8f.20.1779621757808; Sun, 24 May 2026
 04:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
 <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
In-Reply-To: <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 May 2026 13:22:26 +0200
X-Gm-Features: AVHnY4I78oJkw5wlqyzmj1cIkIp7UAJvj1KW0IsPVe2CbVCPVcMgnKOQ0enezFI
Message-ID: <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
To: Yuyang Huang <yuyanghuang@google.com>, Daniel Borkmann <daniel@iogearbox.net>
Cc: bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 1:41=E2=80=AFPM Yuyang Huang <yuyanghuang@google.co=
m> wrote:
>
> >This looks like a bug fix for an out-of-bounds write vulnerability.
> >Should this include a Fixes: tag to identify which commit introduced the
> >unconditional copy_to_user() calls for query.revision without checking
> >the user-provided buffer size?
>
>  > Fixes: 3fe213c040b3 ("adding ci files")
>
> I completely missed this checkpatch comment. I will add the Fixes tag
> in v2 if there is a consensus that this patch is the right approach to
> resolve the issue.

AI is wrong.
The fixes tag should probably point to 053c8e1f235dc or a subsequent patch?

bpf_mprog_query() and tcx_prog_query() were only introduced there.
How come your userspace passes shorter uatter to query newer
BPF_TCX_EGRESS attachment?

Please provide more details.

I'm still not convinced that what you're saying:
"
For example, our Android net_test  suite uses this legacy 40-byte
Python ctypes struct layout:

  # legacy 40-byte layout (pre-revision field)
  BpfAttrProgQuery =3D cstruct.Struct(
    "bpf_attr_prog_query", "=3DIIIIQI4xQ",
    "target_fd attach_type query_flags attach_flags prog_ids_ptr
prog_cnt prog_attach_flags"
  )
  # Invoked via: syscall(__NR_bpf, BPF_PROG_QUERY, &attr, 40)
"
is a kernel bug.

Looks like user space is querying new attachment types
with old structure.
Potentially the check can only be around:
        case BPF_TCX_INGRESS:
        case BPF_TCX_EGRESS:
                return tcx_prog_query(attr, uattr);

to be nice to broken user space,
but, really, attr->query.attach_type shouldn't be equal to BPF_TCX_EGRESS
with a smaller uattr.

pw-bot: cr
