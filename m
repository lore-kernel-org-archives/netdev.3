Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4F92264A3
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500481; cv=pass; b=MUs2UAve7ZIMq+J076dVTzfzEB17G88tBncaQjYmTKA51J1T2/JuOr52V1pJwJD0m1exBjFZbC0HcqxUADXH09lw4jVNPQh+tlnPuTHf5aA0+51+nridCx3M2jFVux9l9ueASJhKBq78A2Q2XPFn1klcj17nRPI0c/nZYBtNW1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500481; c=relaxed/simple;
	bh=aEP7uy33qGNpUUDQxlNY8I1X9OL2s9AG5vb3XEuG76o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOB2oBZSE7GYURmuaPVwUCKuZCs0tfRLyItNHPYqwGCkMfTq0A2BNMaH7rQDaFKDCof+qsadL2gS4vRN8fCYKeMAwPMwso5CjBaEO88ThaxamDuEerGdOffIiYn0QjhNLTGvouizU7CvLiAAqtQAYNi3ST63s005cXlKbUaSDuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=CSevkJzd; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="CSevkJzd"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8588583a7c3so7309057b3.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 22:41:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788500479; cv=none;
        d=google.com; s=arc-20260327;
        b=CwjmOP+wie+jgNSCpPNIYMGgmrRF+G+JuG0JhL7XVmdV8UuIclYm5Z7RvdfdmcxlFC
         uwP8NO0sYrPh+QCP0TsLjawAwf7VSK/EvhmpLn7wi5icYCmYdHh2QKuF3RAgc5C05Kxp
         6+7xdb5Bmt6KoTLzOvlTq9DY78xwlE17hUGrvwkvcZGFOBCLLV43KxennuSxAQXmLWnQ
         Ti+egZhqadv4CRlu7XHj3yGYRE7V9QboXVcr9yqPd/zjfD2acTkvM4DX0nD596ucWPwc
         4xGc0jyMf5BmbN6l/6FLAmqnRzdLEARuAexzmrKw9cHolLSM/mt4uhqogdpKn+P+WtPD
         epDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EuqE3ueVRiiHxh+pCSOdLubfFSA664DpxbaoLMe0ato=;
        fh=xHLRENnH2T91SJbeRoGKCFoFdzi39Jl+HQSfOqtvXdA=;
        b=fm1gBdS85pQZWaJT5jmgQzs12MaAHV50b06Tec6dqPFaDmUycygKQg0VAx6XOxNU6e
         GIBAxNXjzDjN8CUPn7zlRj3TXbdIQ6ah+HyDRDjYxnWMc+IhAjy+aZr0tVDaYotB7UGa
         3KID15x9r6PRuQzgL8NYNFeh7tVTdaP26acSuc2YRobc9xoEPVa7CGrUvChNU4AyUi7T
         v6JLaUjiAyRLRyhJtXrVM4ObnZ8bNS+MT7P+VulYR1yqp+yJLIwPiZG0srb4a5mxFoAm
         OX/D5PlFgAg17YODQ+cOxjvjDdR4D/gzA2ylDRUFtyB0mSbLPAiZw5iXMrwWPLESB1Wg
         Hwxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788500479; x=1789105279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EuqE3ueVRiiHxh+pCSOdLubfFSA664DpxbaoLMe0ato=;
        b=CSevkJzdj/mbLj+qNLY8wxuZo8cDYLYmf/y5vaicKUV71Qx+NwtLWlhFxY5N7hiRmR
         qMjE31yjhZdFZxXlML/PeDFDdG6sR41Qbp7uwtnT7WaDbOC/5oycXRvUrpjAyQ/aGACf
         /RnECDpMeB6zj4jdLVUtsyKDN/NKMBI5Xa5rVldDPdk7Gwq7KDMbLLyLCNWm4kfA4IIX
         V/WsHNqP+uMw/HvodTfIKs1THYs1FT4VG8pnX2SnHlZMeW2I57N3ocmmDxIV25HBNqTA
         LJyXvWqS162HkzX8wWQlTstnWvKSGHwvjvs7ERQMgnR/DwHlv3t9BMykKbIaPBGbTjLT
         rN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788500479; x=1789105279;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EuqE3ueVRiiHxh+pCSOdLubfFSA664DpxbaoLMe0ato=;
        b=fqwCdpGfsZ0rGcjZAyaf1XUWnw7RLTv8VuMIfpXi6/Cnjka41NV8sn5WddINDQTdPP
         ai9Oncy0vM9fH4QX2ElJyu+vCfFJae9dEURpkVgYMtbTujxa8LSJOOvF/NTftejiqprM
         4WWovz5nFj4ZO5WePrhPmZrdEGZ3Or+uIBonUM7pT2jh+s+sOhuFBBXoGVcm9D2wQACZ
         WpjocN2+dLZg9CcM0TQyY9Xwv7ZwzDUp8aUcHtel+QtyC2ULCfLPPMuR8zJ/pxqtdmPH
         xDV8aLxNj0h++YaTBSCpKRHZPonIdD5zck2iiwllHnm5LlTg53GA5svurBlMhNKu9WDM
         nj0w==
X-Gm-Message-State: AFuF++mwQYwr08oCwOUjPS04NG5qdS2lf1jE5t+U74LTVHZGdVV7kDJj
	w05FodORK6fMTx/Axp4m8SDHsIe349eHq4gauuSDNhkbIZMxd/vcFArnqp7x9f9VAZfaof+QzCm
	N/o4OdxTTCjPjKwutDnHe7icDVc0Tn2vsZz1CoQYWgQ==
X-Gm-Gg: AYBFou2U+zc/yIyUalyeJkzikzYzqdpV8sV8rBOuPX3Gonb8CVprUma4FR+ZxoQnFNk
	RpAVPzXa3pVXrh6FMDA/t9Otn7dt4d/FFJgt3rTQapyqgt8xt8VxXBWLv9NnAvyc2mM39iH55fm
	vtxEQC7q+suI9ypzAXSqTF1BSSDleq4jwYDxnzK7dpIVJmDRKhH6/vAOb+3RJ1rmHs91n61FN2Z
	N6e94kQuHOP4hXCVQQawo0Fc3bEvyREQK+LMjr4UJa1U61CG3BuwE+3x/n+irgudTfieOVhnqK9
	/Njg0s233UzFgTZGFNBi8BR2/HenDcy1adkDzhLDvPaS
X-Received: by 2002:a05:690c:a7cb:b0:81e:6658:53fe with SMTP id
 00721157ae682-87126aa6a93mr15719417b3.20.1788500478753; Thu, 03 Sep 2026
 22:41:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819024443.781764-1-tushar.vyavahare@intel.com>
In-Reply-To: <20260819024443.781764-1-tushar.vyavahare@intel.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Fri, 4 Sep 2026 01:41:07 -0400
X-Gm-Features: AcwNN1W0qi_ei7Umz4XIh7S5aRdHKz5JTDd5nP5DkVfbP_TCgZcBavx87UB0Ftc
Message-ID: <CABFh=a4ooWHaSzd1sk7bEP=KT1e+24EjJ0344aFg552ySoj_7A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] selftests/xsk: improve shared-UMEM coverage
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, stfomichev@gmail.com, kernelxing@tencent.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, tirthendu.sarkar@intel.com, andrii@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 10:53=E2=80=AFPM Tushar Vyavahare
<tushar.vyavahare@intel.com> wrote:
>
> AF_XDP shared-UMEM support in the existing XSK selftests is limited to
> a small set of scenarios, while the supporting setup and cleanup paths
> become fragile as coverage expands.
>
> This series improves shared-UMEM testing and infrastructure in four
> steps.
>
> Patch 1 makes UMEM ownership explicit with refcounting and centralizes
> socket and UMEM teardown, keeping cleanup behavior consistent across
> normal completion and error paths. A UMEM that survives teardown now
> fails the test instead of leaking silently.
>
> Patch 2 prevents TX setup when RX socket configuration has already
> failed. This avoids shared-UMEM TX setup relying on incomplete RX-side
> socket and UMEM state.
>
> Patch 3 expands XSKMAP and test capacity to four sockets and adds a
> length-based XDP steering program. The classifier uses total
> XDP-visible packet length (data_end - data) and SHARED_UMEM_LEN_SPLIT.
>
> Patch 4 adds the shared-UMEM callback runner and initial 4-socket,
> length-based steering, uneven-distribution, and unaligned-chunk test
> cases. The three packet-stream sequences share one transactional helper
> that stages replacement streams and publishes them into the socket
> arrays only after every allocation has succeeded.
>
> Together, these patches strengthen shared-UMEM setup and cleanup and
> extend selftest coverage to multi-socket and packet-distribution
> scenarios.
>
> v1 -> v2:
> - [1/4] Track per-slot UMEM ownership and centralize refcount-based
>   teardown. [sashiko]
> - [2/4] Publish RX failure before the setup barrier and skip TX setup
>   after a failed RX configuration. [BPF AI]
> - [3/4] Trim the length-classifier comment to match nearby BPF style.
>   [BPF AI]
> - [4/4] Clarify the partial stream replacement leak in the commit
>   message. [BPF AI]
>
> v2 -> v3:
> - [1/4] Keep one xsk_umem_info for shared-UMEM TX setup instead of
>   copying it; initialize only the non-owning TX buffer view. [sashiko]
> - [1/4] Propagate xsk_umem__delete() errors so the stack-allocated
>   zero-copy probe cannot lose deferred cleanup. [sashiko]
> - [1/4] Record UMEM deletion failures in test->fail; in-test teardown
>   cannot retry them. [sashiko]
> - [1/4] Collapse the redundant teardown helpers into a single loop.
>   [sashiko]
> - [4/4] Fold the previous 5/5 rollback-safe stream replacement into
>   this patch. [BPF AI]
> - [4/4] Factor the three stream sequences into pkt_stream_replace_seq(),
>   driven by a pkt_stream_dims_fn callback. [BPF AI]
> - [4/4] Drop the stream-readiness check and the uneven-distribution
>   hook; neither could fail. [sashiko]
> - [4/4] Drop the unreachable NULL-safe UMEM guards from the unaligned
>   test. [co-pilot]
>
> Co-developed-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
>
> Tushar Vyavahare (4):
>   selftests/xsk: add UMEM users refcount and centralize socket teardown
>   selftests/xsk: skip TX setup after RX configuration failure
>   selftests/xsk: expand XSKMAP capacity and add length-based XDP program
>   selftests/xsk: add shared-UMEM callback framework and initial test
>     cases
>

For the series:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  .../selftests/bpf/prog_tests/test_xsk.c       | 340 +++++++++++++++---
>  .../selftests/bpf/prog_tests/test_xsk.h       |  27 +-
>  .../selftests/bpf/progs/xsk_xdp_progs.c       |  15 +-
>  tools/testing/selftests/bpf/xsk_xdp_common.h  |   3 +-
>  tools/testing/selftests/bpf/xskxceiver.c      |  40 +--
>  5 files changed, 344 insertions(+), 81 deletions(-)
>
> --
> 2.43.0
>
>
