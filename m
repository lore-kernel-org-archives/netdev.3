Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8069A41A504
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473070; cv=pass; b=Vm857ujBTYZK26GqvqAl0bV1YcIHbMY6nVcDphVTs0XpBXdOn+oI1RsJGfcw+ld7/BuvEMf5XRxQ5Cwmf+p2gCORHlHH93MuDzDd+HQYwsXPwn6o0H75IJ28sUmEoVfXq7btHFTZ5YQ2wugxB1Y2a9inMzHp4wa/wiAe4r+0sZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473070; c=relaxed/simple;
	bh=8xVRuDu/1hzRnGhCCn+PpalFfuvCjxava7ISS/y+fQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rn26q8ZgXk/21zGjUbxy2H3041r03Th/VjD5Oz8fUS0oZXERRSK4Tr2VzItKD08RPp8nahEjZoMOPaXEVcR4fvtTEXU3o3gxXcp1WI+KL37djDVH9Vqpe2wgq5xycnfqwEFNXMQNpsolJufiVpfIIqqFmXGc77jIpzD5IVdo8Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=rtKevHZv; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="rtKevHZv"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469f204f6so106928b3a.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 04:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789473068; cv=none;
        d=google.com; s=arc-20260327;
        b=Z7c82fFw+Ai2AszDdOEpxe9v/60bpi6uE1PJ9LLKx1EZbi10wAjdETfld981xR++Mo
         zKB9LHuJRXaJlNNcTzYaUSJfiCaoEXtu1i51K3ixuCQCf19KN44jcbpQiudKHEDdfEqY
         Hjt3rE8GMWEh+821M52IJr7iDzo/or5xC2m1/aXjHw6hzEhVESvY9st66bRckeXVM3zB
         u/gcAYaqpAUH/TwhIOAmdzq4ZlTqJfYD3av8QTRZfKOKiJ9k23BVVA8fDk/H4hrkKe1H
         0+98eCaBwEqYRQon7drtsLxbJ/7u6ux51m+BUQUkMvGZ68nAfCkdsaJA/lP4rKy+zxZh
         1u5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CCKObcxG8Ed77FbJ9Ag/dekaF5Vtwo2pMtCHGDt3aYU=;
        fh=42mcOubFrL/I78DWSiJvIjoMARg4t6eQ6t7E0LhX3h8=;
        b=JrR5cdZxk4saj+nlAO6M5GL+sOZpWYihqtI9fTKgVYBgZRL5GRBgR+vzM/PCZfguuD
         iGzlh5M478s8tUpl1mIN6JZKujTbSTz+v9Eau5Gb0mwF2i5JTHSkhCoUzaOZdlyyTvgy
         UMtTrwh1pJM6shxWI8rJRj+5tCRKM6LFVowGipw6+/1gHzTvTTXOngv5BGp0NZ+1KqAK
         VzUU+kkI89HblOAIwkxBFtuqWp93mBFqxFJjWPTE/EgkB+9ynEZPqnhum7SSsPdQx9tp
         6wE618LgnuQXdCO4she8a+D8ovk+pPQEHWZbki4wOQEWT5NkDpPp9l3wUgl62wLzj4e9
         +S9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789473068; x=1790077868; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CCKObcxG8Ed77FbJ9Ag/dekaF5Vtwo2pMtCHGDt3aYU=;
        b=rtKevHZvoYe7tu/XcjKG4ydu0tljuoCy0Kz0fNSAT5mo8dh9kGOvCySwQULVHPZady
         60Pnt7XGFgYV34xeyfdEV2XHJtQgp7V2q9WQKhAaZljLx9uURk/3l9WPhDDq8Hrlbqjo
         z0YsAZ2Nj2tkFS89uKKRqHkxr3q8SNKQpmpG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789473068; x=1790077868;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CCKObcxG8Ed77FbJ9Ag/dekaF5Vtwo2pMtCHGDt3aYU=;
        b=vlvpSg2I3/0ijI1cr38egsN7iX3bXjCJu84WE5xIZaDQe93C6rp/23Eu+URs8IO+ZD
         TQTzkcNi/GsDC+XX1FpMFP8x3vTBb3f5+Iv/N9czoCV09gz7en5CmKovv3fdmY4OmWrQ
         aHlreAz1oMKifIRsGumFi7f2/NYrTVHeMeTcQF7AmfXDDj4Wsd6b5JgB0xq3b3gk1+Tb
         3EFGuyrfegyV2PoqDmuhEFZgVgH+zEFLmZe1U86VDCa1rjVpWQB1JJ9moj5REvZl4O2Q
         NWAdGpKJi+76ypukKQDAVndMKTdIJ0nH+eh3spa9fhsQH36zsn+Pk2MyTc0jIfAn90tI
         6KDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwHFDLmDim7KUBOB/p9dQSdvOfZxLJ6Bm36/BRBH6zyeYDO9nSVx3NlTfB1lw5hzquvy76w/DI=@vger.kernel.org
X-Gm-Message-State: AFuF++moX5PXXZ9AmE3mvllRFZeYTkHSL9SnGeg5vWvf7B78bd7Caq/i
	S4gil8Hs2xmzfI+HHkRvE8Vy8y42ioZYtQulSlRJfdbSOsiHydy4Yj92IwetDgBAEBlEhTs7aTp
	KjSgyy7j9eBn2c3aSP8sI8Ly1aVizosVr3mVXPhFU
X-Gm-Gg: AYBFou1vuRAM7q8B0SEI5z4q9azC01od0Z1Rz+fxevbcj/hvVAdQMq0whdjr8eTX4r/
	cR/mjLrpuzLBpcgcj6b9MT+8vhbfa/9wkvIdEi0cjaTmHhLsa0MLrmUEYr08sMneYV11I/ncZhr
	RSIn4jtYo6RyGWb5w5Bz6t3Fv72/k8jEPJ6fCxhpwMVIgyqySo2Cb8OjVWEymF2GYFQmBKX5v0O
	D0dH/IGp2faQrkclMumPvZA9MnlxdPmOgQvgIsDyrr7YxZi0oR3CuFlsTyrvMpYy0dfrGNar0w6
	KxasP7x/6Pgmi3IDLu7zj9MGEo20O0bQuSqp1hkON8ywxZNwt/VmsUzjccfwPEbw01bgtBs4z+q
	289B/CIDInN0enYp4iWqq6PUP1rHtdOArtA==
X-Received: by 2002:a05:6a00:17a7:b0:845:c694:5c3d with SMTP id
 d2e1a72fcca58-8717cce5f94mr1059737b3a.1.1789473067637; Tue, 15 Sep 2026
 04:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911133146.3440982-1-victor@mojatatu.com> <20260914191108.55a1a4f1@kernel.org>
In-Reply-To: <20260914191108.55a1a4f1@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 15 Sep 2026 07:50:54 -0400
X-Gm-Features: AcwNN1U6M8nSHx3FhVHk1pnlNz7tTX94vDNhHnWYKT-haMBGjmzGBEJ_jbpeskA
Message-ID: <CAM0EoMk7CZA2qAPEfvZ_+tUDkcUYF5nanaxER1soLJQZqMuXxQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Avoid quadratic handle scan in qdisc_alloc_handle
To: Jakub Kicinski <kuba@kernel.org>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, horms@kernel.org, vega@nebusec.ai, 
	netdev@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000886284065b842a4f"

--000000000000886284065b842a4f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 10:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 11 Sep 2026 10:31:46 -0300 Victor Nogueira wrote:
> > This is a less intrusive fix meant for backporting; a cleaner approach =
that
> > uses a per-device IDA over all qdisc handles is planned for net-next.
>
> I don't think this is net-worthy in the first place.
> We have a ton of code under rtnl_lock.
> We cannot provide any protection from malicious netns admin from
> overloading the machine.

That is the one million dollar question.  We labelled this as net for
this exact reason. i.e malicious container could overload the whole
machine.
But it borders on "hardening" (improves performance), so net-next as a
target sounds reasonable. It was a coin toss.

Since we have a few similar "grey" issues in our pending queue - so
where's the line for net/net-next?

> Nothing against the patch itself, but if you plan to do something
> else in net-next let's just go with that from the start..

We could resend the same patch for net-next, the alternative "proper
fix" is more intrusive. See attached.
Another option: Is this worth fixing?

cheers,
jamal

> --
> pw-bot: cr

--000000000000886284065b842a4f
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-net-sched-allocate-qdisc-handles-from-a-per-device-I.patch"
Content-Disposition: attachment; 
	filename="0001-net-sched-allocate-qdisc-handles-from-a-per-device-I.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mu2lzp6y0>
X-Attachment-Id: f_mu2lzp6y0

IGluY2x1ZGUvbGludXgvbmV0ZGV2aWNlLmggfCAgIDQgKysKIGluY2x1ZGUvbmV0L3BrdF9zY2hl
ZC5oICAgfCAgIDEgKwogbmV0L2NvcmUvZGV2LmMgICAgICAgICAgICB8ICAgNiArKysKIG5ldC9z
Y2hlZC9zY2hfYXBpLmMgICAgICAgfCAxMDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0KIG5ldC9zY2hlZC9zY2hfZ2VuZXJpYy5jICAgfCAgIDEgKwogNSBmaWxlcyBjaGFu
Z2VkLCA5MCBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L25ldGRldmljZS5oIGIvaW5jbHVkZS9saW51eC9uZXRkZXZpY2UuaAppbmRleCA4
N2NhZmM5MzJlOWUuLmY3ZmJkMzZmOWVmOCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9uZXRk
ZXZpY2UuaAorKysgYi9pbmNsdWRlL2xpbnV4L25ldGRldmljZS5oCkBAIC0yMDEwLDYgKzIwMTAs
OSBAQCBlbnVtIG5ldGRldl9yZWdfc3RhdGUgewogICoJQHRjeF9lZ3Jlc3M6CQlCUEYgJiBjbHNh
Y3QgcWRpc2Mgc3BlY2lmaWMgZGF0YSBmb3IgZWdyZXNzIHByb2Nlc3NpbmcKICAqCUBuZl9ob29r
c19lZ3Jlc3M6CW5ldGZpbHRlciBob29rcyBleGVjdXRlZCBmb3IgZWdyZXNzIHBhY2tldHMKICAq
CUBxZGlzY19oYXNoOgkJcWRpc2MgaGFzaCB0YWJsZQorICoJQHFkaXNjX2hhbmRsZV9pZGE6CUlE
QSBvZiB0aGUgcWRpc2MgaGFuZGxlIG1ham9ycyBpbiB0aGUgYXV0b21hdGljCisgKgkJCQlyYW5n
ZSB0aGF0IGFyZSBpbiB1c2U7IE5VTEwgdW50aWwgdGhlIGZpcnN0IG9uZQorICoJCQkJaXMgaGFu
ZGVkIG91dAogICoJQHdhdGNoZG9nX3RpbWVvOglSZXByZXNlbnRzIHRoZSB0aW1lb3V0IHRoYXQg
aXMgdXNlZCBieQogICoJCQkJdGhlIHdhdGNoZG9nIChzZWUgZGV2X3dhdGNoZG9nKCkpCiAgKglA
d2F0Y2hkb2dfbG9jazoJCXByb3RlY3Qgd2F0Y2hkb2dfcmVmX2hlbGQKQEAgLTI0MjYsNiArMjQy
OSw3IEBAIHN0cnVjdCBuZXRfZGV2aWNlIHsKCiAjaWZkZWYgQ09ORklHX05FVF9TQ0hFRAogCURF
Q0xBUkVfSEFTSFRBQkxFCShxZGlzY19oYXNoLCA0KTsKKwlzdHJ1Y3QgaWRhCQkqcWRpc2NfaGFu
ZGxlX2lkYTsKICNlbmRpZgogCS8qIFRoZXNlIG1heSBiZSBuZWVkZWQgZm9yIGZ1dHVyZSBuZXR3
b3JrLXBvd2VyLWRvd24gY29kZS4gKi8KIAlzdHJ1Y3QgdGltZXJfbGlzdAl3YXRjaGRvZ190aW1l
cjsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3BrdF9zY2hlZC5oIGIvaW5jbHVkZS9uZXQvcGt0
X3NjaGVkLmgKaW5kZXggOTBkM2U3OTQzYjE5Li4yZjMyYWY4MzE4MzUgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvbmV0L3BrdF9zY2hlZC5oCisrKyBiL2luY2x1ZGUvbmV0L3BrdF9zY2hlZC5oCkBAIC0x
MDIsNiArMTAyLDcgQEAgaW50IHFkaXNjX3NldF9kZWZhdWx0KGNvbnN0IGNoYXIgKmlkKTsKCiB2
b2lkIHFkaXNjX2hhc2hfYWRkKHN0cnVjdCBRZGlzYyAqcSwgYm9vbCBpbnZpc2libGUpOwogdm9p
ZCBxZGlzY19oYXNoX2RlbChzdHJ1Y3QgUWRpc2MgKnEpOwordm9pZCBxZGlzY19mcmVlX2hhbmRs
ZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCB1MzIgaGFuZGxlKTsKIHN0cnVjdCBRZGlzYyAqcWRp
c2NfbG9va3VwKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHUzMiBoYW5kbGUpOwogc3RydWN0IFFk
aXNjICpxZGlzY19sb29rdXBfcmN1KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHUzMiBoYW5kbGUp
Owogc3RydWN0IHFkaXNjX3JhdGVfdGFibGUgKnFkaXNjX2dldF9ydGFiKHN0cnVjdCB0Y19yYXRl
c3BlYyAqciwKZGlmZiAtLWdpdCBhL25ldC9jb3JlL2Rldi5jIGIvbmV0L2NvcmUvZGV2LmMKaW5k
ZXggZWNmYmQ3MmQ1ZDFhLi5jYjAzZjdjMTk3ZjcgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL2Rldi5j
CisrKyBiL25ldC9jb3JlL2Rldi5jCkBAIC0xMjI3Nyw2ICsxMjI3NywxMiBAQCB2b2lkIGZyZWVf
bmV0ZGV2KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCiAJbmV0aWZfZnJlZV9yeF9xdWV1ZXMoZGV2
KTsKCiAJa2ZyZWUocmN1X2RlcmVmZXJlbmNlX3Byb3RlY3RlZChkZXYtPmluZ3Jlc3NfcXVldWUs
IDEpKTsKKyNpZmRlZiBDT05GSUdfTkVUX1NDSEVECisJaWYgKGRldi0+cWRpc2NfaGFuZGxlX2lk
YSkgeworCQlpZGFfZGVzdHJveShkZXYtPnFkaXNjX2hhbmRsZV9pZGEpOworCQlrZnJlZShkZXYt
PnFkaXNjX2hhbmRsZV9pZGEpOworCX0KKyNlbmRpZgoKIAlfX2h3X2FkZHJfZmx1c2goJmRldi0+
cnhfbW9kZV9hZGRyX2NhY2hlKTsKCmRpZmYgLS1naXQgYS9uZXQvc2NoZWQvc2NoX2FwaS5jIGIv
bmV0L3NjaGVkL3NjaF9hcGkuYwppbmRleCA0NjNlZGVkY2RjZmUuLjgxOTMzZGNjY2NiYSAxMDA2
NDQKLS0tIGEvbmV0L3NjaGVkL3NjaF9hcGkuYworKysgYi9uZXQvc2NoZWQvc2NoX2FwaS5jCkBA
IC03NzAsMjYgKzc3MCw3OCBAQCB2b2lkIHFkaXNjX2NsYXNzX2hhc2hfcmVtb3ZlKHN0cnVjdCBR
ZGlzY19jbGFzc19oYXNoICpjbGhhc2gsCiB9CiBFWFBPUlRfU1lNQk9MKHFkaXNjX2NsYXNzX2hh
c2hfcmVtb3ZlKTsKCi0vKiBBbGxvY2F0ZSBhbiB1bmlxdWUgaGFuZGxlIGZyb20gc3BhY2UgbWFu
YWdlZCBieSBrZXJuZWwKLSAqIFBvc3NpYmxlIHJhbmdlIGlzIFs4MDAwLUZGRkZdOjAwMDAgKDB4
ODAwMCB2YWx1ZXMpCisvKiBBIHFkaXNjIGhhbmRsZSBpcyBhbHdheXMgbWFqb3I6MCwgc28gdGhl
IG1ham9yIGFsb25lIGlkZW50aWZpZXMgaXQuIEV2ZXJ5CisgKiBtYWpvciBpbiB1c2Ugb24gYSBk
ZXZpY2UgaXMgdHJhY2tlZCBpbiBkZXYtPnFkaXNjX2hhbmRsZV9pZGEsIHdoZXRoZXIKKyAqIHVz
ZXJzcGFjZSBuYW1lZCBpdCBvciB0aGUga2VybmVsIHBpY2tlZCBpdCwgd2hpY2ggaXMgd2hhdCBs
ZXRzIGFuCisgKiBhdXRvbWF0aWMgaGFuZGxlIG5ldmVyIGNvbGxpZGUgd2l0aCBhbiBleHBsaWNp
dCBvbmUuCisgKgorICogVXNlcnNwYWNlIG1heSBuYW1lIGFueSBtYWpvciBpbiBbMSwgRkZGRl0u
IFRoZSBrZXJuZWwgcGlja3MgZnJvbQorICogWzgwMDAsIEZGRkVdLCB0aGUgc2FtZSBzZXQgdGhl
IG9sZCByb3RhdGluZyBjdXJzb3IgY291bGQgcmVhY2g6IEZGRkYgaXMKKyAqIGxlZnQgb3V0IGJl
Y2F1c2UgaXQgaXMgdGhlIG1ham9yIG9mIFRDX0hfUk9PVCBhbmQgb2YgdGhlIGluZ3Jlc3MgYW5k
CisgKiBjbHNhY3QgcWRpc2NzLgorICovCisjZGVmaW5lIFFESVNDX0hBTkRMRV9BVVRPX01JTgkw
eDgwMDAKKyNkZWZpbmUgUURJU0NfSEFORExFX0FVVE9fTUFYCTB4RkZGRQorCisvKiBEZXZpY2Vz
IHRoYXQgbmV2ZXIgY2FycnkgYSBxZGlzYyBoYW5kbGUgb2YgdGhlaXIgb3duIG5ldmVyIHBheSBm
b3IgdGhlCisgKiBJREEsIHNvIGl0IGlzIGNyZWF0ZWQgb24gZmlyc3QgdXNlLiBTZXJpYWxpc2Vk
IGJ5IHRoZSBydG5sIGxvY2suCiAgKi8KLXN0YXRpYyB1MzIgcWRpc2NfYWxsb2NfaGFuZGxlKHN0
cnVjdCBuZXRfZGV2aWNlICpkZXYpCitzdGF0aWMgc3RydWN0IGlkYSAqcWRpc2NfZ2V0X2hhbmRs
ZV9pZGEoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKIHsKLQlpbnQgaSA9IDB4ODAwMDsKLQlzdGF0
aWMgdTMyIGF1dG9oYW5kbGUgPSBUQ19IX01BS0UoMHg4MDAwMDAwMFUsIDApOworCXN0cnVjdCBp
ZGEgKmlkYSA9IGRldi0+cWRpc2NfaGFuZGxlX2lkYTsKKworCUFTU0VSVF9SVE5MKCk7CisKKwlp
ZiAoIWlkYSkgeworCQlpZGEgPSBrbWFsbG9jX29iaigqaWRhLCBHRlBfS0VSTkVMKTsKKwkJaWYg
KCFpZGEpCisJCQlyZXR1cm4gTlVMTDsKKworCQlpZGFfaW5pdChpZGEpOworCQlkZXYtPnFkaXNj
X2hhbmRsZV9pZGEgPSBpZGE7CisJfQorCisJcmV0dXJuIGlkYTsKK30KKworLyogQ2xhaW0gdGhl
IG1ham9yIG9mICpoYW5kbGUsIG9yIHRoZSBsb3dlc3QgZnJlZSBtYWpvciBpbiB0aGUgYXV0b21h
dGljCisgKiByYW5nZSB3aGVuICpoYW5kbGUgaXMgemVybywgYW5kIHN0b3JlIHRoZSByZXN1bHRp
bmcgaGFuZGxlIGJhY2suCisgKi8KK3N0YXRpYyBpbnQgcWRpc2NfcmVzZXJ2ZV9oYW5kbGUoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiwgdTMyICpoYW5kbGUpCit7CisJdTMyIG1pbiA9IFFESVNDX0hB
TkRMRV9BVVRPX01JTiwgbWF4ID0gUURJU0NfSEFORExFX0FVVE9fTUFYOworCXN0cnVjdCBpZGEg
KmlkYTsKKwlpbnQgbWFqb3I7CisKKwlpZGEgPSBxZGlzY19nZXRfaGFuZGxlX2lkYShkZXYpOwor
CWlmICghaWRhKQorCQlyZXR1cm4gLUVOT01FTTsKCi0JZG8gewotCQlhdXRvaGFuZGxlICs9IFRD
X0hfTUFLRSgweDEwMDAwVSwgMCk7Ci0JCWlmIChhdXRvaGFuZGxlID09IFRDX0hfTUFLRShUQ19I
X1JPT1QsIDApKQotCQkJYXV0b2hhbmRsZSA9IFRDX0hfTUFLRSgweDgwMDAwMDAwVSwgMCk7Ci0J
CWlmICghcWRpc2NfbG9va3VwKGRldiwgYXV0b2hhbmRsZSkpCi0JCQlyZXR1cm4gYXV0b2hhbmRs
ZTsKLQkJY29uZF9yZXNjaGVkKCk7Ci0JfSB3aGlsZQkoLS1pID4gMCk7CisJaWYgKCpoYW5kbGUp
IHsKKwkJbWluID0gVENfSF9NQUooKmhhbmRsZSkgPj4gMTY7CisJCW1heCA9IG1pbjsKKwl9CisK
KwltYWpvciA9IGlkYV9hbGxvY19yYW5nZShpZGEsIG1pbiwgbWF4LCBHRlBfS0VSTkVMKTsKKwlp
ZiAobWFqb3IgPCAwKSB7CisJCS8qIEEgbmFtZWQgbWFqb3IgdGhhdCBpcyB0YWtlbiBpcyBhIGNv
bGxpc2lvbiwgbm90IGV4aGF1c3Rpb24uICovCisJCXJldHVybiAoKmhhbmRsZSAmJiBtYWpvciA9
PSAtRU5PU1BDKSA/IC1FRVhJU1QgOiBtYWpvcjsKKwl9CgorCSpoYW5kbGUgPSBUQ19IX01BS0Uo
bWFqb3IgPDwgMTYsIDApOwogCXJldHVybiAwOwogfQoKKy8qIE9ubHkgZXZlciBjYWxsZWQgZm9y
IGEgaGFuZGxlIHRoYXQgcWRpc2NfY3JlYXRlKCkgcmVzZXJ2ZWQsIHNvIHRoZSBJREEgdGhlCisg
KiByZXNlcnZhdGlvbiB3YXMgdGFrZW4gZnJvbSBpcyBzdGlsbCB0aGVyZS4gUWRpc2NzIHRoYXQg
Y2Fycnkgbm8gaGFuZGxlIG9mCisgKiB0aGVpciBvd24gaG9sZCBubyBtYWpvci4KKyAqLwordm9p
ZCBxZGlzY19mcmVlX2hhbmRsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCB1MzIgaGFuZGxlKQor
eworCWlmIChoYW5kbGUpCisJCWlkYV9mcmVlKGRldi0+cWRpc2NfaGFuZGxlX2lkYSwgVENfSF9N
QUooaGFuZGxlKSA+PiAxNik7Cit9CisKIHZvaWQgcWRpc2NfdHJlZV9yZWR1Y2VfYmFja2xvZyhz
dHJ1Y3QgUWRpc2MgKnNjaCwgaW50IG4sIGludCBsZW4pCiB7CiAJY29uc3Qgc3RydWN0IFFkaXNj
X2NsYXNzX29wcyAqY29wczsKQEAgLTEzMDYsMTcgKzEzNTgsMTUgQEAgc3RhdGljIHN0cnVjdCBR
ZGlzYyAqcWRpc2NfY3JlYXRlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCiAJCQlnb3RvIGVycl9v
dXQzOwogCQl9CiAJCWhhbmRsZSA9IFRDX0hfTUFLRShUQ19IX0lOR1JFU1MsIDApOwotCX0gZWxz
ZSB7Ci0JCWlmIChoYW5kbGUgPT0gMCkgewotCQkJaGFuZGxlID0gcWRpc2NfYWxsb2NfaGFuZGxl
KGRldik7Ci0JCQlpZiAoaGFuZGxlID09IDApIHsKLQkJCQlOTF9TRVRfRVJSX01TRyhleHRhY2ss
ICJNYXhpbXVtIG51bWJlciBvZiBxZGlzYyBoYW5kbGVzIHdhcyBleGNlZWRlZCIpOwotCQkJCWVy
ciA9IC1FTk9TUEM7Ci0JCQkJZ290byBlcnJfb3V0MzsKLQkJCX0KLQkJfQotCQlpZiAoIW5ldGlm
X2lzX211bHRpcXVldWUoZGV2KSkKLQkJCXNjaC0+ZmxhZ3MgfD0gVENRX0ZfT05FVFhRVUVVRTsK
Kwl9IGVsc2UgaWYgKCFuZXRpZl9pc19tdWx0aXF1ZXVlKGRldikpIHsKKwkJc2NoLT5mbGFncyB8
PSBUQ1FfRl9PTkVUWFFVRVVFOworCX0KKworCWVyciA9IHFkaXNjX3Jlc2VydmVfaGFuZGxlKGRl
diwgJmhhbmRsZSk7CisJaWYgKGVycikgeworCQlpZiAoZXJyID09IC1FTk9TUEMpCisJCQlOTF9T
RVRfRVJSX01TRyhleHRhY2ssICJNYXhpbXVtIG51bWJlciBvZiBxZGlzYyBoYW5kbGVzIHdhcyBl
eGNlZWRlZCIpOworCQlnb3RvIGVycl9vdXQzOwogCX0KCiAJc2NoLT5oYW5kbGUgPSBoYW5kbGU7
CkBAIC0xMzgzLDYgKzE0MzMsMTAgQEAgc3RhdGljIHN0cnVjdCBRZGlzYyAqcWRpc2NfY3JlYXRl
KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCiAJCW9wcy0+ZGVzdHJveShzY2gpOwogCXFkaXNjX3B1
dF9zdGFiKHJ0bmxfZGVyZWZlcmVuY2Uoc2NoLT5zdGFiKSk7CiBlcnJfb3V0MzoKKwkvKiBzY2gt
PmhhbmRsZSBpcyBhc3NpZ25lZCBvbmx5IG9uY2UgdGhlIGhhbmRsZSBoYXMgYmVlbiByZXNlcnZl
ZCwgc28KKwkgKiB0aGlzIGlzIGEgbm8tb3Agb24gdGhlIHBhdGhzIHRoYXQgZmFpbGVkIGJlZm9y
ZSBvciBkdXJpbmcgaXQuCisJICovCisJcWRpc2NfZnJlZV9oYW5kbGUoZGV2LCBzY2gtPmhhbmRs
ZSk7CiAJcWRpc2NfbG9ja191bmluaXQoc2NoLCBvcHMpOwogCW5ldGRldl9wdXQoZGV2LCAmc2No
LT5kZXZfdHJhY2tlcik7CiAJcWRpc2NfZnJlZV9yY3Uoc2NoKTsKZGlmZiAtLWdpdCBhL25ldC9z
Y2hlZC9zY2hfZ2VuZXJpYy5jIGIvbmV0L3NjaGVkL3NjaF9nZW5lcmljLmMKaW5kZXggNmY2YTZm
MGQ1ZWIwLi4yMTc2NGEzZWUxZTAgMTAwNjQ0Ci0tLSBhL25ldC9zY2hlZC9zY2hfZ2VuZXJpYy5j
CisrKyBiL25ldC9zY2hlZC9zY2hfZ2VuZXJpYy5jCkBAIC0xMTEwLDYgKzExMTAsNyBAQCBzdGF0
aWMgdm9pZCBfX3FkaXNjX2Rlc3Ryb3koc3RydWN0IFFkaXNjICpxZGlzYykKCiAjaWZkZWYgQ09O
RklHX05FVF9TQ0hFRAogCXFkaXNjX2hhc2hfZGVsKHFkaXNjKTsKKwlxZGlzY19mcmVlX2hhbmRs
ZShkZXYsIHFkaXNjLT5oYW5kbGUpOwoKIAlxZGlzY19wdXRfc3RhYihydG5sX2RlcmVmZXJlbmNl
KHFkaXNjLT5zdGFiKSk7CiAjZW5kaWYKLS0KMi41NS4wCgo=
--000000000000886284065b842a4f--
