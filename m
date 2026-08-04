Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF743C069
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865177; cv=pass; b=bd2vFSPOZKHapc/FoE0g5bgRoJuxMZ/7+C3LZaWPegQr0of3gqkbQEBZKHRMA52b+U7r2Z+1o/FhFTlE71SKQ13mReDUitDr5fTQNioZJgl5cJp3tXHwpS1ZQmO+/gcjX6FRHeC02dL/r5j3g6+xWa3za1MbJe1hA3/NpsBu97w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865177; c=relaxed/simple;
	bh=7s4GgU0yWjrvZ/GMpAO1ho1vTRBzA7w8yzjMsH3cMCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ev0vXGZpos46nTZUvWuCUttas2LUC8kBWBdFfP8NRh5rn05601oPbyelK2PF1AmwssvhSuyt2PQN6CYjqdDRsfqnnCktI3W0C8W4BpFVjl22c2H7hKTWdBC7xGUrmrZ5aS5gxNlAcV5EGsC+Kpox+Pm0Rt3RY3oNfprAK2a6ldY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gkSW/Cub; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkSW/Cub"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47fd66a094eso24190f8f.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 10:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785865174; cv=none;
        d=google.com; s=arc-20260327;
        b=Kg3WJfbGMqPzfSBQBTrl1dkaFbtwtDR3HnV8kCBfrjxZ/b4H7RVtobG0gwNGunk9Y3
         y3x4B7fA3Q6KFRR/tXjUmjrar+IRkoU+VclXih3P8SDNfDpTCQtbklUofCBm8gcn4umQ
         qjsOP5bz2YHjitKIc7B4aeAMO0wtBHuznMPZvy2YSnX0pedJAa+WaNZtCbCN+ukcWlz9
         r2lP3Wt23qwESFYnhv+a/MLAIm4vonhFoOfsX6Xx8p3OsG7iq9XVWedkVWoXmBTkEgxL
         DMD34plY9lOzPsfnRKa8P0kmzOMgcJY2hwiQyfaodVwPSeqrd3SLRrryoxsC0/JbjJwu
         xjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a57h1gKhOLUfkryQSWJzZFefceNYQazOuLC74TR29w0=;
        fh=PKbUBpoesM0t9BM3xVosDoJDvj/rwrkalseCFe3WFFQ=;
        b=hHBM3w3ZBN4NAmCAXglD200y6GC8goSX3rjbzMFfdS6dahbw3PLOvZ3fC5QuQTWQIP
         NHPmtTa0gOOUdM6S0cgNWcsx+CNN7x0gGrVo9VqB32XmkSYnKx0VxuBh4JbNTjVCsjCh
         LqZp0JvZdF9vlqi1npsub35WIfNDZrUqyrQ49i00OHj+xm15ZjkMB/g/aJ6ZvyjprCYF
         7KOidSOTy4ToQVdEsMXun6Sd69E+3TbKQPluQWpikBNorSl03+36R5VIHNbIqymp9pvU
         HsmRX2nXjlxVvBo14mCftxeLGEkFhGKedWFutev9R/SA3aHrsNIZnd5koOFgE24BpN+A
         UDdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785865174; x=1786469974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a57h1gKhOLUfkryQSWJzZFefceNYQazOuLC74TR29w0=;
        b=gkSW/Cub3m+GnJMFc58mnY7dBg0tMJQhp6kijgnSEceLH29PViUBdTKNIN2qU2mo/t
         s9tyXTDhwh4FCACfhgx0ZyB2VLE6WWmvh1QoT4uKwDRuI4yjw4URtTKPvI5It9O/96x3
         tnLE13iQ1+ZccST/m8GQpY/A9jZ3UPq7IhKuiZizCHSbyyDTFAgV2Ivn/qty7EAI2vJ5
         ngnv9wpzVWPaZhF1xevtD9S7gR+vmyF9VWi1fFMnN6XhIvEU2y1rhthaL4D0uwFmCqAW
         9+qm2pjqN9+ZhinNEzH+saepD3WPma65FkCwDkL14UupY4l+W/cXYE4OYB8GrElSwzjl
         ZdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785865174; x=1786469974;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a57h1gKhOLUfkryQSWJzZFefceNYQazOuLC74TR29w0=;
        b=IgXpnvKwxPMuLFKVYgKjyHrlQMAH1/92yQch6juGuPaML9XXZeeDhsk323eda6LgoV
         MqMNgUCeqkSYErtECnfuEaPsISEZ46iHIbA7tfuP/RQ65S7jCEk+kQHPXJJQW3cjf+1W
         jD/ehkd7tLiJHcpPPA5xjFb+7vqoGOKLLq8GyrhHYrcrMVvxidzGOAvT8SYDugjCQ8dx
         z+IdBHt7Fis8YttuIzSXsG0NLr9PvXUABXPQ4JOVuAyGzJ7wzVIVTE5eoEeRH0Z89B7i
         HzmgzITHSjUQOTJN8NWK6SnaFpEw2D+mWRAF+BIKsRdMpFfiZwcBk5+BkgFxoEbQI3ky
         JUIA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3jYu1wAEYzqESFIaVteFuJLQvMuC5EXVSKHrdxS+r/P2rcG3o0PQTWl4YZSoftKzO+aBDIQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyth3OWm0jhJSeYW2ShS3diDYtSs4uUUhkEnPTtb91Y6jiZ/tPW
	vqVonqEUwgIP0ip2GDKZxgzluK/CtY+Pbp64AJWMQpDsh2FSMDK8dXWQUWYhshyvQ0bUUXzwYxZ
	Pc3eVsDLP3UjOpgSdYXhaz5QY2Cjcf0F8tybkhtaM
X-Gm-Gg: AR+sD10DeqkHuv4mjGldVOFEGI4gb/speI8eSVldg5Gtn4vhpG5i013l0Bs5aQTVBO8
	ymzK7wEonpFmPcH9ZGroKuYQ6KdUOVL/S10yPjpeEz1JTq0iaRa5sqeFaYv72j7zXR5vltJ+xcS
	NzEOxPW40n6stIkRgmRjH2fLWjvCrOqRU7CoPeGQLK2yWCQd3VFt+4hLwzgVdCj/KN0wPqrYAdS
	89TmtBfNGPhP+PVUYjT2lwzCFMetCXZjdDx8bsJL3RTJryPadvW24y9pqqFNFeWMqWuzPEw5o7Z
	Sud+vSMPkTKyCzIITfNCgxxyIxA0wEapqjReA/0bYQDS3mqPpiUgbZkXm5s1qFyX1hg7Q3P0Zzw
	=
X-Received: by 2002:a05:6000:1787:b0:47f:8802:c182 with SMTP id
 ffacd0b85a97d-47fec63cdd1mr1488152f8f.29.1785865173107; Tue, 04 Aug 2026
 10:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721063829.7d9e6c7f@kernel.org> <CADWJPTsP=2=JFE9Oh5ym_wz4vROEFOCqa+dyCLRymyYLRB1BSg@mail.gmail.com>
 <20260723103607.55debff2@kernel.org> <CADWJPTs6G7zy+9aLxz9QD9Fk1szZK0b-vEFUm2jxTMtxt+t1uQ@mail.gmail.com>
 <20260804072522.784ead37@kernel.org>
In-Reply-To: <20260804072522.784ead37@kernel.org>
From: Sheena Mohan <sheenamo@google.com>
Date: Tue, 4 Aug 2026 10:39:21 -0700
X-Gm-Features: AUfX_mxHkTMCgS1g1WD7h_0w76Yi_-GTF4WXvZRsN7AiPbNZ7Ij2p-EGz7gYc5g
Message-ID: <CADWJPTuxT4Vh4ja_5Wza=0Y-XW-xVh6DwEBVfKmXdBoUJKMwRw@mail.gmail.com>
Subject: Re: [TEST] google runner needs nested cases
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 7:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 28 Jul 2026 10:07:15 -0700 Sheena Mohan wrote:
> > The recent updates have been merged, and the tests should now report
> > sub-case results.
> > Please let us know if any further improvements are needed.
>
> It doesn't look right.
>
> https://gve-netdev-nipa.static.usercontent.goog/json/results-202608040108=
-88cb54ab-ca48-426b-9c9a-50bfbb0de32a.json
>
> test    "napi-threaded-py"
> group   "selftests-drivers-net"
> result  "pass"
> ^^^^^^^^^^^^^
> link    "https://gve-netdev-nipa.static.usercontent.goog/results/20260804=
0108-88cb54ab-ca48-426b-9c9a-50bfbb0de32a/napi-threaded-py/logs.html"
> time    20.788391
>
> # selftests: drivers/net: napi_threaded.py
> not ok 1 selftests: drivers/net: napi_threaded.py # exit=3D1
> # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> # not ok 1 napi_threaded.napi_init
> # not ok 2 napi_threaded.change_num_queues
> # not ok 3 napi_threaded.enable_dev_threaded_disable_napi_threaded
>
> Does not look like a pass at all. Subcases not in JSON.
> Not sure why the subcases are listed under the main return
> in the output, I've never seen that.
>
>
> test    "psp-py"
> group   "selftests-drivers-net"
> result  "pass"
> link    "https://gve-netdev-nipa.static.usercontent.goog/results/20260804=
0108-88cb54ab-ca48-426b-9c9a-50bfbb0de32a/psp-py/logs.html"
> time    341.833939
>
> # selftests: drivers/net: psp.py
> not ok 1 selftests: drivers/net: psp.py # exit=3D1
> # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
>
> Again, doesn't seem to be a pass??
>
>
> test    "queues-py"
> group   "selftests-drivers-net"
> result  "pass"
> link    "https://gve-netdev-nipa.static.usercontent.goog/results/20260804=
0108-88cb54ab-ca48-426b-9c9a-50bfbb0de32a/queues-py/logs.html"
> time    686.483495
> results
>         test    "queues-check-xsk"
>         result  "pass"
>
> Okay, here we have a subcase..
>
> # selftests: drivers/net: queues.py
> ok 1 selftests: drivers/net: queues.py
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> check_down
> # ok 4 queues.check_xsk
> # # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> But why only one? What happened to the other 3 that ksft clearly saw
> since it enumerated check_xsk as the fourth??
>
>
> Something is mangling the output on your runner, it seems.
> And the parsing seems off.
Thanks for bringing this to our attention. We will look into the
parsing issues and work on getting this fixed.
