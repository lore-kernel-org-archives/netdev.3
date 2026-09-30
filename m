Received: from mail-ej2-f14.google.com (mail-ej2-f14.google.com [74.125.228.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C3E4756B8
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808872; cv=pass; b=sQYz8qNHlJreGe7YTAG89xqCFI4yT/aON3SkpiX8oF1v69FnFO5890uytMBvmMirMebe2I2U0h9nDw1gnFBxyvD2kF/HgR1Z0mBb3GNVU7fT++QMtoXaeQcKh1nceWYKdB3y745gSrtY46RsrpWWQv44tAFVPKFs2tPawGXIljw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808872; c=relaxed/simple;
	bh=25OW8kJVzXxMj1f7wl7vPyZB0Mh372NuIRML4c+wriE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnmGXqVAhms4AXEXCu4XIk23QYfO1rlH3T0UIN84KGMI84DbYhz1M7zguhszbPPn8ClJEYN/Nc2udXxqgHeSkXLJyrR0IRQAtkI7yFEjve7120HrGUQEKoC2yMYjYt0msp10IbEmyv1/C4zU5xmxxWn32RVZzRc3KYkPn+9P3mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zy6xGcMl; arc=pass smtp.client-ip=74.125.228.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zy6xGcMl"
Received: by mail-ej2-f14.google.com with SMTP id a640c23a62f3a-c2e3507d4a9so43102566b.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790808862; cv=none;
        d=google.com; s=arc-20260327;
        b=Htbw3oaMbXhr3pS3cDnGVFllbJHr0nQZOZY6648gGB2OA86ezBaUwukRNHQdVSgyaE
         Fv0Ds5Qj4Kcd7R03zNqqw3IB/OqB1M77lwpbLlcSVcNS+OXttGUXtJV5PdI2BwtMAq4R
         kpup4hzC0s0xZV61WtdyL5GWD9D+MCp3xLHhLMMHotKcgq9ESHOL2z9J4f8z7Dmnlbzq
         YDZ6N9xTydTgJxsUfiWBlui7uUCrPtc10Q6DEftGi8fHKVbEnteeYXX+v1ro0fIBXqzM
         cDkILvnbQo1LGdG4FEZQ1upGrJr1D6r4H+HeIAIfDjkyKwB9MuXfLUuLruMKC/zrnm2a
         aktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BMDqFIaP1O55HQyhPMTHQHywZWJn4sXJBK7hF4BIEBo=;
        fh=Gi4SYFNJ+4sfQqX34blw69cCYXhfM4lrrciwIsYkwW0=;
        b=LxhwR/Uk4Nx1OZWqzJpC9oAGFMuPQEqWSdCq4dhLzcl1lAv35EwZ6KDqIvLRu1WCsO
         WCcsH5KVkfxIFGUKRBdQrwB5+lniFxlPxmblGRMkPmwWzv3gxQ8eBQAChc1VKyfSY+6e
         BZHYybW1IKG3uVGxCe/qzvUhwb1vTy1GUA3u7sD+4tuOYwVEELCz/pgoC34JT4Mkh2+n
         3qtPcCKVgIj8On4CMODLC61uNF4F8s4rLKcvtHjYZKz6ND3THCUjt7EKC3vasIYiQBEg
         X3uHTKYzsdlFoWY4mz9YIW9l9LiG7ihTLIQj3f9k0gHkv/aRe/VwjLrDXbCE61kRGrKm
         5LIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790808862; x=1791413662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BMDqFIaP1O55HQyhPMTHQHywZWJn4sXJBK7hF4BIEBo=;
        b=Zy6xGcMlXVBd+eFtXChF9aS7xQKph7IQFCB6hlxE/Gn77dVpltkC5j+60MPQi1YqRh
         FrxcrOg6LDIi3yNq7tNq57mP4Hl0L5J+F8OBEmbEqRaxPT1wpI3r9lYTWP/rzPCeFYtZ
         WqFkvsxL9Ouvjy55QvXZuzZVCS4YT6g8dwlVYE86YsmVsqjA02AXaRq/hyzAsa+/qLQH
         JgCjG/XANB8/gBpMjftnf9B6EYVYV0M3xdeaKSjQQmIKHmbrNZpjaU6mlNwgTBnZzEQF
         hGGnSovGmdHLgREBDFVpenSDsMozh1hleZCO5/f3gq2XUT9EMCJ8mrkLnrGmD0j2iBgR
         KwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790808862; x=1791413662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BMDqFIaP1O55HQyhPMTHQHywZWJn4sXJBK7hF4BIEBo=;
        b=DS5JatjcYBbrSUPa/aPjCbLXre2xmfjxX0SAJMC95VCa325TBOYCRkS+vmaKHf6fZA
         0APX97CLWsx7uY8DM7u+CmeId56+Vsx7asB+RNR8AUzvUCa7JsVoEbpc+hyp9ov5nbMB
         Opos2PdOko+xuD75l2LHb0ige2XfSl8RaHtYPhIjHOeR1aslxpTv/BjD0Y7VHftUSZSq
         pJzKCrIopGVPE2QIx6V0uNigIft4L2C3Seir/YBOxGX8j0m460rJbMrqZKMPtKnF8Boi
         1DgkzdU08BHv/A8LepTgqyhtRK9C8zg27V1/tJQUDLx4wsdzwNkIAjBi96Qswr+q79wS
         f5Uw==
X-Gm-Message-State: AFq9FYKqSCR9Wb9/v7Lk9Z7qek1JnzrzVO7NjQ1fKFyG1ge/olZw/pAl
	aSpKVJhP3yaxJbMd8ahZW4/JRqbyI04MUOMUs6UapH2TFrY1cXUnK41v5BI7KTMb4mwYIXDQura
	dpCnG6Rac8WgdGXXPqf5Yb6vUpJf/pnixMxw2mlFviqwvfuG/JSOYc1MHXDg=
X-Gm-Gg: AYBFou3xNb58zXOdbG/FDN6pB4hHWWbHskbrMjShR2BC0NmUzR5lIrzmixFWJXrFOkb
	VXw2TFrqfgLDqsxhCYJXYo/iFihpv0EmsyH00jGobE9y9tH0aO2bBS0EXP/FZgvqRka3I2FfetH
	9Lhz/bncUisiLShvhiLd77GW6Eey9+qtXhfvsnIFk2JAla0AJBVem11BESl6wFqv9sj09XkX2Jr
	36YBb81UXrIuJ7r8XRPKGk489HuRUZVBjf81bSVaoWNOMV1biSMtb451KQ0B96tlBZCCCVw5jSA
	uVmTxaRN5g5a6Tl0sdE/3FPa/AXVR86B6vv3hTFE56F/f3Ylgt0RW7lzWoaLMXg9eeQ40kVrjM5
	CwBbXzNcqOWVJ9ay4Cs1L
X-Received: by 2002:a17:907:9449:b0:c27:420b:7c79 with SMTP id
 a640c23a62f3a-c2e23e520f1mr221873866b.48.1790808861871; Wed, 30 Sep 2026
 15:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930214735.3288780-1-joshwash@google.com> <179080528731.31693.11268580346361726174@kernel.org>
In-Reply-To: <179080528731.31693.11268580346361726174@kernel.org>
From: Joshua Washington <joshwash@google.com>
Date: Wed, 30 Sep 2026 15:54:10 -0700
X-Gm-Features: AclHuK9fnFHxOP4qsQ_Oocv5ijMmdZLzMw5uNrAYSg6n06sJyJ3ZPqhXptnZoq4
Message-ID: <CALuQH+VEopCYRwDmxyaLadDtMy29m5=Li9YowmjWpZha_SEMjw@mail.gmail.com>
Subject: Re: [PATCH net v3 0/3] gve: various XDP fixes
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:54=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

(1/3) gve: fix XSK buffer leak when rings are stopped

This issue was hit in production.

(2/3) gve: fix XSK buffer leak on error descriptor

This issue was caught by LLM

(3/3)  gve: fix napi_disable deadlock when attempting to disable XSK pools

This issue was found in production.


>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

(1/3) gve: fix XSK buffer leak when rings are stopped

This issue was actually triggered; symptoms included a buffer leak.
Reproduced by continually performing ip link up/down on an interface
while XSK traffic was flowing. Eventually, no more packets can pass
because all of the XSK buffers from the UMEM pool have been leaked.

(2/3) gve: fix XSK buffer leak on error descriptor

This issue is theoretical, as RX error packets are extremely rare in
my personal experience. But it is plain to see by static analysis that
the buffer will be leaked if an RX error is returned, due to the early
return in the driver. All other XSK-releated paths free the XSK buffer
in gve_rx_xsk_dqo().

(3/3)  gve: fix napi_disable deadlock when attempting to disable XSK pools

This one can be very easily reproduced by enabling an AF_XDP zero-copy
socket, and disabling it. The deadlock becomes more apparent when
attempting to enable a second AF_XDP zero-copy socket, as that
operation will stall waiting to get the netdev instance lock.

Snipped stacktrace from
https://github.com/GoogleCloudPlatform/compute-virtual-ethernet-linux/pull/=
96:

Workqueue: events xp_release_deferred
napi_disable+0x1d/0x50
gve_xsk_pool_disable+0xed/0x1d0 [gve]
gve_xdp+0x14a/0x1c0 [gve]
xp_disable_drv_zc+0x89/0xe0
xp_clear_dev+0x59/0xf0
xp_release_deferred+0x20/0x90

>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

All of these changes were tested on the GVE driver using the DQO RDA
queue format.

>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.



--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3
