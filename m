Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD836A358
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785191699; cv=pass; b=UkHZQUSvTWLpL/E2y8Uu8O/IXD+AYTrZ70RQ9Tx9byr6oah5tPhrH334Gxo1oVaDOZS74xy5F6nfO/gsFelsZp/3NzThKqRJ0lQUtQIDpfMX5LQC0gv8/9lOOtRavov4mBmDaxtQqIFSQ9KaCDaZf00MU/cpcjEnfP1zax56pik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785191699; c=relaxed/simple;
	bh=7TEtiOjQggZMEkErBJEVdUElI840RrHz3d6Cwx3+Ugw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hG07hmX5PXXTsbD0sZEAU2x0EXYre6A8IY1t7xDovBKlwteKium4cePyeBj4JVOhhiL515KEd1Zi/4cDf0XnFYg6r6f7OF1GWDp+wW81gnJA6fMnrkm4gNJIoLgNb1ffRZfwE3LNCRJWHyK/0HuACEqj0ZpamUHKaaItNdvirck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hP90/doz; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP90/doz"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e04df8c46so3275570b3a.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 15:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785191697; cv=none;
        d=google.com; s=arc-20260327;
        b=TdTen/zOUZoTUEQOJuLVptTSygHF9udwxcOZPLq9Jw/YeWaAqN3johfmkqlUe8lDx2
         u7riTEuyLTPj0Idz49dN1l8ED3fbtUnaXeaEDvlzJtgVG5YwDlG9U9nVSRZRtLLny87B
         fpli1TnCM43/kB3/V50Mr6IZNRKC1TL6dYcAYIib6tGpC4yalHtdjwvQ6F2S4YHP9c77
         2KtH9kKcXFM8l3wEXOr1JUboCFpTWR/CRxSo0BfNmSkv8eAO7B8t363zxYfBe1zFa44W
         8TVYa55TUA4bGlvnlJm4Z61t+E7eHWHGiB/Tx91kDWvGcnyvrOiFkO41to0Sc1WpES4o
         PGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ckKdQKUGKaG+4QmZlg5923goGW5J8z++c88IMXwUfJw=;
        fh=X27qq2GhPng6b31jvb291uqc3PODtrN+BoTWsncfQ+g=;
        b=cQvZSfwjRRrZ70yqw8Na6EI3JOa0oOCHZfIuMUHaEbEAEDk54xamLH7f9cQvaIt8lx
         d6cAB/LgouHvsCPJbEYdTgJEJqpf/2Lx+hlWTszld+2SXEQ3aNrTItHa6IWkcbpiR+dv
         UT/PQxnDSvsnAeFL7VtQSmGUgQog/8ei90OdDFmM5g2kDcHnEGw/sedPU6ZuW2XWICd8
         oEnDDrDUizqMkiNskRngkFgh4J5zxqrRncoV05OeBUrE8S4cMo4law2nYH4fMabXkVxM
         1vUExxWPBH+AH/L4LNDamKESG6g3/Fq/iqz4+eAzlRIhd9RGsHa/aliOqlEPtlX5/+iU
         tDqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785191697; x=1785796497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ckKdQKUGKaG+4QmZlg5923goGW5J8z++c88IMXwUfJw=;
        b=hP90/doz5L+6aRqvUPPKf4M8pYtZbbP70JdiTW1+JN/YHd8Ip5VBhw9krfLC0Y6eFH
         MLX2U2qarKACe27iLEuUgXl0ezLzfvJaaearPoRf7wTLZcAkbeKKGy+y6+nEBfYg5m0+
         GtBcujw+fbNXJzjdRk9K9l1PF/7qeSo0RpkpWJcdnTxJfR2mB5SOGsLEhNuQT2YusUai
         /iUImcgrPTG6JoPD6qP4Ct8BX7a1oA0Gn99MfoosgUvZp9cc6JNHzs2kAEZ4mr2ghEvW
         y2fiFbMz+yNth0DqrsbqzXVugGwM+xsvAGrQm1HqOgMRFyWl6LOvmGBJ6xuerDNZFZa2
         e4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785191697; x=1785796497;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckKdQKUGKaG+4QmZlg5923goGW5J8z++c88IMXwUfJw=;
        b=OQySv7ToQvpDEry/pdWDKuyNTCowVSJz/W2x3GqFWb6uTD1YFHeO38TQIxFvYyDi99
         8zxW5iPSs2aqZ6wpMOTIr264DpfSFmMQO0oTYGdqZVv10eLdt3YC/LId/8+GMdc7qvN+
         orVA3hF1GZk4zkA4w3iZb6MmDKPXrJRF4R7I+vz9pUee0hiEmty+wzN5HDK4hPNbTwGt
         ahl/Xt6u74TAlmtDdM/YEi9UXBXFVK5qBsifJayVnJsKmz0ejxHFeJg5/S/Pqt3NldJ3
         +5S94JcRNKpyy8Z7+xRuVAQTrlckkWMDKwEFBmP2EYB8wfVjw9bwxuxJeCYzD2bUqQj3
         gNfg==
X-Gm-Message-State: AOJu0Yxg9ESm5/izF9vNmub4uBY9pkm5dIqADWD5/HFBPI0o/bejbAap
	diOIPE01MFokwhcXJpCd5tF/iaNO7zG5yTeSq3TwHymQVlNZs9KPTbKPmjaQYsbGp9ePLl+pSpM
	+G2LEI37U6sMOT3AP3PGPZQAFjhoWZSqZw9QoDJw=
X-Gm-Gg: AR+sD13m3F0Xl/2pKm2HF1aOq0JShrWDNU5wWJtk/lG/TsubvlmBz1smeOgUYSHuOH7
	3LM7W52pOrwuJR7a+z21j0y3Abf+ZtmRyPnZusCx64zR+1bJn7Io41T+t2ywIoqNpJNGn6E9TaX
	sVeEvSKAREHJud/+2vsFCp+f64zxl3S6fPnXduhx+o7E16T/cn9Bqygf3HRrANjuS31jcGjIcTt
	MZKpcA/SCJP8lv0K/QpVSTLtBd9UVdRgFvIM9JAIPw8D+iTCc28yrnx2D5aiOAaOa2w78yOE0wf
	NiKyPNsR/Qi9YkBcu3gukTLF70MM64aqSEqVG70lnCpZtBtvzaj6vGbc4YRYkAA8wIn5
X-Received: by 2002:a05:6a00:399d:b0:84e:7ec:aa42 with SMTP id
 d2e1a72fcca58-84e594330d6mr8645260b3a.10.1785191697579; Mon, 27 Jul 2026
 15:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718134450.575758-1-tushar.vyavahare@intel.com>
In-Reply-To: <20260718134450.575758-1-tushar.vyavahare@intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jul 2026 15:34:42 -0700
X-Gm-Features: AUfX_mzH-8hI-auF3xbbXN6CBjkT2xhvmKQLEnB2zwkeFu8lJ5TB-EqTuuf6keY
Message-ID: <CAEf4BzYRKO-h=7vhzVnV7Du3fVycZhDdAduUHMta9TxNXXY1+g@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests/xsk: decouple xskxceiver and xdp apps
 from test_progs objects
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, stfomichev@gmail.com, kernelxing@tencent.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, tirthendu.sarkar@intel.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 6:46=E2=80=AFAM Tushar Vyavahare
<tushar.vyavahare@intel.com> wrote:
>
> Build xskxceiver, xdp_hw_metadata, and xdp_features from explicit source
> lists instead of reusing helper objects produced by test_progs rules.
>
> Reusing shared objects such as network_helpers.o and xsk.o can pull in
> test_progs-only dependency chains and trigger unrelated libarena builds
> when invoking a single target.
>
> Keep these standalone binaries self-contained so each target builds only
> its own required sources and BPF skeleton dependencies.
>
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index b642ee489ea6..a6f0ed10ccb4 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -934,17 +934,27 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/t=
ests.h $(BPFOBJ) | $(OUTPUT)
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
> -# Include find_bit.c to compile xskxceiver.
> -EXTRA_SRC :=3D $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c prog_tes=
ts/test_xsk.h
> -$(OUTPUT)/xskxceiver: $(EXTRA_SRC) xskxceiver.c xskxceiver.h $(OUTPUT)/n=
etwork_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) |=
 $(OUTPUT)
> +# Keep xskxceiver independent from test_progs object dependencies.
> +XSKXCEIVER_SRC :=3D xskxceiver.c xsk.c network_helpers.c \
> +                 $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c
> +$(OUTPUT)/xskxceiver: $(XSKXCEIVER_SRC) xskxceiver.h xsk.h network_helpe=
rs.h \
> +                          prog_tests/test_xsk.h test_progs.h bpf_util.h =
\
> +                          $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(O=
UTPUT)
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
> -$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c $(OUTPUT)/network_helpers.o=
 $(OUTPUT)/xsk.o $(OUTPUT)/xdp_hw_metadata.skel.h | $(OUTPUT)
> +XDP_HW_METADATA_SRC :=3D xdp_hw_metadata.c xsk.c network_helpers.c \
> +                              $(TOOLSDIR)/lib/find_bit.c
> +$(OUTPUT)/xdp_hw_metadata: $(XDP_HW_METADATA_SRC) xdp_metadata.h \
> +                          xsk.h network_helpers.h test_progs.h bpf_util.=
h \
> +                          $(OUTPUT)/xdp_hw_metadata.skel.h $(BPFOBJ) | $=
(OUTPUT)
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
> -$(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/network_helpers.o $(OUT=
PUT)/xdp_features.skel.h | $(OUTPUT)
> +XDP_FEATURES_SRC :=3D xdp_features.c network_helpers.c

I'm missing the point of these xxx_SRC variables, given you then go
and list .h files explicitly... Just have an inline list of all the
dependencies, maybe?

pw-bot: cr


> +$(OUTPUT)/xdp_features: $(XDP_FEATURES_SRC) xdp_features.h network_helpe=
rs.h \
> +                          test_progs.h bpf_util.h $(OUTPUT)/xdp_features=
.skel.h \
> +                          $(BPFOBJ) | $(OUTPUT)
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
> --
> 2.43.0
>
>
