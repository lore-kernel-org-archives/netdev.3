Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6C73A9870
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269712; cv=pass; b=XvuoHzZtY1/XdYCLWZWlFbznq4ccbNkW5LrIuah1vdog1pjR39RthYc4OXV56l5TxG464EM7LI9cVfqKeG/eksSUZae2AMScWytvX0DkkLLvQJZMXNymltZRv9FJ+A7je1pBKAqDWpuDTDnOL6z3SnzYJRetO6wP8gMlgfjAtZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269712; c=relaxed/simple;
	bh=RqB2yGqdzKFEgXjhHIwd+aQbFWqhaTJjYOr226NpJ/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLT3TgKe6K4ISV2udKp20pFcZvy7K84ZS5rbfk6aQ54Z51P6aMw4TjRtyU5e/12r3YIr8diETx8kX6hSUsJuQKUo1wEPqKQPEFxhz0kQvt1BuKsij72/rwewAXK4a9pb12XOM9JXj6X42vq2Um6CyyIGtl5mNHJ1VIbnaf9+GvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfIyg5Kw; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfIyg5Kw"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a9ccfb75f0so291536a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 23:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791269708; cv=none;
        d=google.com; s=arc-20260327;
        b=ghsGQ39hnvlLQZqUD8DnWHnVDWrX3F/RtzyuS7qG2WOQ2fccxo3yZ82iXNZ/tlWxfp
         ovF5k8d4/Q30JgYiDKSPtFLoPfE8Ch8f2+Z0NUascq8oma5K7l7dAENepRFj73tdO2U4
         VSQSkFSp3fhLN1EF0AeUe0grhQ/WrN21hF8Rshlitc6PCkcKDTcFn+6UD+qR7eiYrGBb
         167BiEw6m/CiAXJP+QOBxeiPoRPyTiyQxi2yDhMDJMKfWb4nCNtHXpRCUiP4EN/+QUDe
         ATdUjSysGCeBraEu4oQiJaNG6AWHXfU73ch7OJJvGLDQDa+bZGSxkFxtpLKoSx381Ian
         UweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=n0KFHAoUlkbus3zAE1BEMvXKDx48kJxczsUI2dPHxAE=;
        fh=/xVo72KaZT1aSjcuYrwlcrlmh6gKuWwyan/ITvXxtfc=;
        b=GazJhbWDkmEv2QwESG49wA2RiC+/lFRKjf/wX+ryj/d/R+dYS5WbzsmH8H8vIVCqyh
         wZsX1nhnMgnXUKc9MlMbykxJWxxeudvk+3ComtteNR2deJXYxOmvmqotvYPyOrpOpyN2
         hSiyxrt5pQZ5kb89rgAmvJx0kkfZj0vlee0hhwJfu4bePnCTjuikUoHKB/DHXLTyrimb
         R307EqJr7i39eN83UqvBKK4dsJ1uhZyj4793+vDBr636DJps1UHeSbPxU7pPIfeBJgja
         H772RP4I80KBYYLGkYJH10CY6M2wNIvphEoHxA0HytGYK4qyl4VPrksl+bDVXV6Y7PWz
         nvLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791269708; x=1791874508; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n0KFHAoUlkbus3zAE1BEMvXKDx48kJxczsUI2dPHxAE=;
        b=SfIyg5KwCAr6Ooc17Wc/8lKry7sB/vxp10f2DvWH1Z3YFVe4ohqBeDrpZfrs7A+o7q
         uTPAiljDMH3naAsSxczFs4UU/TVk5aMLBURTpVlNGM2/0AQEaCCB6tXWatEB2ssTHlQh
         u/r2lKcsty145tldGUVpKuZU8feXnaV1AViJFTdZd5yCRtdVn8zpyQbkpiRL0bmOUFIh
         MH0VNIUl/mYEmEVGoVv3sPZZol4u8XMltsCIQGaXV55RX1H7mF3yzYwLJ5XctlcmYDyf
         132i/GHBsSbnu1G7lDaBZU8TTdHzOOfEqGYS5YVVwNM6EP4jQKb+AMovEJfoFJm+OQYs
         NV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791269708; x=1791874508;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n0KFHAoUlkbus3zAE1BEMvXKDx48kJxczsUI2dPHxAE=;
        b=HXhTr6g5TMYnxKED4fB6gczPj3GnBeXdrUTWju7ZZHx/7m9bwZe5SdWg+qp+Hde2iq
         vPTcTKeRpJ03IaRZbjDCDBMVzqoRvBhLFzmXgMHyAS4ndZr8Kq065Rb+XFXMbcN7RQ0a
         shdIDE+JT0Olv8Wy72E8//ztcAkgNt6P5dGAo0usEwrChrBZ/iP1iE6wwFt4+IPkO236
         rmxgcb79Y+bVJls/rEXJlIvUZNt/r3+a1grzOE5JHRHpXAN5yE14GYkGdXdQuYxEy4iN
         u0/epGtzJ/XfbxAw0SrWXqYe5fUYheRmTLLQgWoM6YmuCkcjqyaUSZRhJ2EBLfSk6ujD
         R9LA==
X-Forwarded-Encrypted: i=1; AKwUvBxun002V5b9rWjp0DPTe1ae2Uv1V5Gy7W5pPI6b7J+8cv5G0a8TR4fC8gBXCGGFGbG3fT0Z1Y0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7Q3TNlirqLJvoyZ/heWYaoahaHUhMdt5cMyCr3mfWq5pYsC4l
	qb62rHkKmrk2NMcNXssmVj6JmIY5L0UjlYkBcCoyH1NDQvFWkHEYh40Ngu3v7CWbbtmN5hCsRSm
	ampzetQLWXl+mY8zNHq0Nz+yKOb8t5bg=
X-Gm-Gg: AYBFou0SaJbiXm8pwDBvBYRQyLSGhnTrN3T4jtD/oygWM4x/vs5i1UKuP2Lc43V4r1L
	yX+CTyxiBh2YKK39I9cA8AoBmI0J4DBv4U5UtcBzsCHPYCOU7Acxw5DrgMi8Bzed+qVwQd18RlJ
	7MU4kkHgXniOgdGf1WbGcIwsC78fVl0ZWkSoeiiN0AvAAbiYRL8FsqlnoDkL3ZtgYUgDaNOWOjH
	HzY+uFTM0rNKheQjOWOtsp4jJSRMZG3vcZNugq/RQKgeTh730MemZuCGeec052+o/D3YjfXeQe4
	Z3cGk/qCvT2tdFXvSq0flJXX9fQopO7/QTiRirk56QyijCB4Hu6i8j3t9pqm3KC8NnU=
X-Received: by 2002:a05:6402:2811:b0:6ac:94cf:9f2e with SMTP id
 4fb4d7f45d1cf-6afe29a9f12mr459844a12.13.1791269708098; Mon, 05 Oct 2026
 23:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHeizqGJ6WpknaU=WE+PB2A09jWi==-sUUgmc36qgStVDRdSLQ@mail.gmail.com>
In-Reply-To: <CAHeizqGJ6WpknaU=WE+PB2A09jWi==-sUUgmc36qgStVDRdSLQ@mail.gmail.com>
From: Subham Pal <subhampal789@gmail.com>
Date: Tue, 6 Oct 2026 12:24:54 +0530
X-Gm-Features: AclHuK8TyziJLreAFopSk65jnfmukaSzcAmarsHWLzj4F7rZbbrlst_zv_uhOks
Message-ID: <CAHeizqHTKneQUtcSr6k5HmNk+-WQmzK1jDVLFmwTTndUPugPcQ@mail.gmail.com>
Subject: [PATCH nf-next v2 2/2] netfilter: nf_conntrack_h323: check extension
 bitmap before decoding components
To: Pablo Neira Ayuso <pablo@netfilter.org>, fw@strlen.de
Cc: phil@nwl.cc, kaber@trash.net, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Subham Pal <subhampal789@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000a628fc065d267a0b"

--000000000000a628fc065d267a0b
Content-Type: text/plain; charset="UTF-8"

In decode_seq(), the extension components loop iterates through bmp2_len
bits. However, it evaluates whether the component index exceeds the known
upper bound (`i >= f->ub`) and whether it contains a STOP attribute before
checking if the field is actually present in `bmp2`:

    if (i >= f->ub) {
        ...
        len = get_len(bs);
        ...
    }
    if (son->attr & STOP)
        return H323_ERROR_STOP;

    if (!((0x80000000 >> opt) & bmp2))
        continue;

If an unknown extension is marked absent in the bitmap (`bit == 0`), the
parser erroneously attempts to read a non-existent open type length from
the bitstream and advances `bs->cur` by garbage bytes. Furthermore, if a
known field has the STOP attribute but is absent from the transmission,
decoding aborts prematurely.

Move the presence bitmap check to the beginning of the loop body so absent
extensions are skipped immediately before attempting to decode or inspect
attributes. Also append a 'U' suffix to 0x80000000 to prevent signed shift
overflow.

Fixes: f587de0e2feb ("[NETFILTER]: nf_conntrack/nf_nat: add H.323 helper port")
Cc: stable@vger.kernel.org
Signed-off-by: Subham Pal <subhampal789@gmail.com>
---
 [Note: Raw patch attached to avoid webmail tab/whitespace corruption]

--000000000000a628fc065d267a0b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-netfilter-nf_conntrack_h323-check-extension-bitmap-b.patch"
Content-Disposition: attachment; 
	filename="0002-netfilter-nf_conntrack_h323-check-extension-bitmap-b.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_muwbpkyk0>
X-Attachment-Id: f_muwbpkyk0

RnJvbSA0NjgzNTYzMWU2OTQ5ZWQ5MzZhNDRjZDhlNDY0OGIxYWRmNzMwNGVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdWJoYW0gUGFsIDxzdWJoYW1wYWw3ODlAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDIyIFNlcCAyMDI2IDE2OjM1OjA4ICswNTMwClN1YmplY3Q6IFtQQVRDSCBuZi1u
ZXh0IHYyIDIvMl0gbmV0ZmlsdGVyOiBuZl9jb25udHJhY2tfaDMyMzogY2hlY2sgZXh0ZW5zaW9u
CiBiaXRtYXAgYmVmb3JlIGRlY29kaW5nIGNvbXBvbmVudHMKCkluIGRlY29kZV9zZXEoKSwgdGhl
IGV4dGVuc2lvbiBjb21wb25lbnRzIGxvb3AgaXRlcmF0ZXMgdGhyb3VnaCBibXAyX2xlbgpiaXRz
LiBIb3dldmVyLCBpdCBldmFsdWF0ZXMgd2hldGhlciB0aGUgY29tcG9uZW50IGluZGV4IGV4Y2Vl
ZHMgdGhlIGtub3duCnVwcGVyIGJvdW5kIChgaSA+PSBmLT51YmApIGFuZCB3aGV0aGVyIGl0IGNv
bnRhaW5zIGEgU1RPUCBhdHRyaWJ1dGUgYmVmb3JlCmNoZWNraW5nIGlmIHRoZSBmaWVsZCBpcyBh
Y3R1YWxseSBwcmVzZW50IGluIGBibXAyYDoKCiAgICBpZiAoaSA+PSBmLT51YikgewogICAgICAg
IC4uLgogICAgICAgIGxlbiA9IGdldF9sZW4oYnMpOwogICAgICAgIC4uLgogICAgfQogICAgaWYg
KHNvbi0+YXR0ciAmIFNUT1ApCiAgICAgICAgcmV0dXJuIEgzMjNfRVJST1JfU1RPUDsKCiAgICBp
ZiAoISgoMHg4MDAwMDAwMCA+PiBvcHQpICYgYm1wMikpCiAgICAgICAgY29udGludWU7CgpJZiBh
biB1bmtub3duIGV4dGVuc2lvbiBpcyBtYXJrZWQgYWJzZW50IGluIHRoZSBiaXRtYXAgKGBiaXQg
PT0gMGApLCB0aGUKcGFyc2VyIGVycm9uZW91c2x5IGF0dGVtcHRzIHRvIHJlYWQgYSBub24tZXhp
c3RlbnQgb3BlbiB0eXBlIGxlbmd0aCBmcm9tCnRoZSBiaXRzdHJlYW0gYW5kIGFkdmFuY2VzIGBi
cy0+Y3VyYCBieSBnYXJiYWdlIGJ5dGVzLiBGdXJ0aGVybW9yZSwgaWYgYQprbm93biBmaWVsZCBo
YXMgdGhlIFNUT1AgYXR0cmlidXRlIGJ1dCBpcyBhYnNlbnQgZnJvbSB0aGUgdHJhbnNtaXNzaW9u
LApkZWNvZGluZyBhYm9ydHMgcHJlbWF0dXJlbHkuCgpNb3ZlIHRoZSBwcmVzZW5jZSBiaXRtYXAg
Y2hlY2sgdG8gdGhlIGJlZ2lubmluZyBvZiB0aGUgbG9vcCBib2R5IHNvIGFic2VudApleHRlbnNp
b25zIGFyZSBza2lwcGVkIGltbWVkaWF0ZWx5IGJlZm9yZSBhdHRlbXB0aW5nIHRvIGRlY29kZSBv
ciBpbnNwZWN0CmF0dHJpYnV0ZXMuIEFsc28gYXBwZW5kIGEgJ1UnIHN1ZmZpeCB0byAweDgwMDAw
MDAwIHRvIHByZXZlbnQgc2lnbmVkIHNoaWZ0Cm92ZXJmbG93LgoKRml4ZXM6IGY1ODdkZTBlMmZl
YiAoIltORVRGSUxURVJdOiBuZl9jb25udHJhY2svbmZfbmF0OiBhZGQgSC4zMjMgaGVscGVyIHBv
cnQiKQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBTdWJoYW0gUGFs
IDxzdWJoYW1wYWw3ODlAZ21haWwuY29tPgotLS0KdjEgLT4gdjI6CiAgLSBSZXRhcmdldGVkIHRv
IG5mLW5leHQgcGVyIG1haW50YWluZXIgcmVxdWVzdC4KICAtIE5vIGZ1bmN0aW9uYWwgY2hhbmdl
cy4KCiBuZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19oMzIzX2FzbjEuYyB8IDYgKysrLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL25ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2gzMjNfYXNuMS5jIGIvbmV0L25ldGZpbHRl
ci9uZl9jb25udHJhY2tfaDMyM19hc24xLmMKaW5kZXggNjgzMGM5ZGEzNTA3Li41NzMxN2EyODIx
MmIgMTAwNjQ0Ci0tLSBhL25ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2gzMjNfYXNuMS5jCisr
KyBiL25ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2gzMjNfYXNuMS5jCkBAIC01OTYsNiArNTk2
LDkgQEAgc3RhdGljIGludCBkZWNvZGVfc2VxKHN0cnVjdCBiaXRzdHIgKmJzLCBjb25zdCBzdHJ1
Y3QgZmllbGRfdCAqZiwKIAogCS8qIERlY29kZSB0aGUgZXh0ZW5zaW9uIGNvbXBvbmVudHMgKi8K
IAlmb3IgKG9wdCA9IDA7IG9wdCA8IGJtcDJfbGVuOyBvcHQrKywgaSsrLCBzb24rKykgeworCQlp
ZiAoISgoMHg4MDAwMDAwMFUgPj4gb3B0KSAmIGJtcDIpKQkvKiBOb3QgcHJlc2VudCAqLworCQkJ
Y29udGludWU7CisKIAkJLyogQ2hlY2sgUmFuZ2UgKi8KIAkJaWYgKGkgPj0gZi0+dWIpIHsJLyog
TmV3ZXIgVmVyc2lvbj8gKi8KIAkJCWlmIChuZl9oMzIzX2Vycm9yX2JvdW5kYXJ5KGJzLCAyLCAw
KSkKQEAgLTYxMyw5ICs2MTYsNiBAQCBzdGF0aWMgaW50IGRlY29kZV9zZXEoc3RydWN0IGJpdHN0
ciAqYnMsIGNvbnN0IHN0cnVjdCBmaWVsZF90ICpmLAogCQkJcmV0dXJuIEgzMjNfRVJST1JfU1RP
UDsKIAkJfQogCi0JCWlmICghKCgweDgwMDAwMDAwID4+IG9wdCkgJiBibXAyKSkJLyogTm90IHBy
ZXNlbnQgKi8KLQkJCWNvbnRpbnVlOwotCiAJCWlmIChuZl9oMzIzX2Vycm9yX2JvdW5kYXJ5KGJz
LCAyLCAwKSkKIAkJCXJldHVybiBIMzIzX0VSUk9SX0JPVU5EOwogCQlsZW4gPSBnZXRfbGVuKGJz
KTsKLS0gCjIuNDMuMAoK
--000000000000a628fc065d267a0b--
