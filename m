Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7158D1DB356
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790297938; cv=pass; b=lP66+9j9tdQY3ZEhfZ5fewGl/nyC+H3F3ABOMCSHryk60Br5QRtzOZPO1GVEW52BC+HsrgLhM0A5EJr6bmi7dQW6/DaiyWXMlwAHX/HCOhR0hkg+OdSI+NLh/1jEXNoDs7u+9HMEOoncutpvD8yKjRK/ZgExDjn8NmojRj4Zw34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790297938; c=relaxed/simple;
	bh=urAmayGrk2/YKnpNUBvPoUR9FlB5GJJ9+v5VQMZfNXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsPTD+xsS9s9CmVEE7or6b3R44tLp2ACwYCRZuPI6NTSDGFLDCySmOY6EtUJ00rgpmI8RibhM3Gt0JoNn8BTMxxoaittmXAYYzzT3pc7TeQkhZnqXVD4J+qjp9vvSemcUJRCnNW6hMGkGh1pF9CbrlWCAlpHj82iH38SFElL+3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MezY1qMb; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MezY1qMb"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb767cc7fso4796231cf.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 17:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790297936; cv=none;
        d=google.com; s=arc-20260327;
        b=A59cW6Mg1yluslT0LanD5n1NlE+lPaq/o57RwabeHO0xaUKpnAXXv63eneTeJ4VmuQ
         GQ3veHCV7u6c2rT5TEG6cALPIt3n+lp2StNOFEciEkjH6NQnjWsAxXW03gX9DGbS+Mit
         0fmTe+zo2zipDkFltvfxNQhHUil6wwqV6xMAPAuj541j3yERWyW6bHMOSWOsrDPS45M1
         f6sXwxxtfb1sshHHxYaebkxe+J5FNICjKZgbYh03YIoNOWzZ36an0vyKD9U75XzVHAXU
         t6a5Q1kziYYc2SbGNCGsEtQ0f3IDFndq2ggGCD4ZDKgjavjoTStAJOVJvWTSlO88HXh2
         ySbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=urAmayGrk2/YKnpNUBvPoUR9FlB5GJJ9+v5VQMZfNXg=;
        fh=6zfc34g9dSC0U+f8Tklj1Fl9FF2409hSLYzYwy9S3Cg=;
        b=fym/j5lfG2dOVtIDPGOC1Izp+f9bC6sJIr0F+nKApgr11hE+YJWniNmObLqZJJGkze
         J2wWD3xtkhrlYS0F9UEulO15or0j0VlKWCbLP6XTfjZyhgjovmiIHYI3nF/J8x80DmA1
         pWeuoLWalFZ1D43Ys9F5pE8GLQefJD2qtJpUKSrJ69eYwlpKZk2OcAGBvwKkWPKQw73S
         nUoeYR+9UVEZ6m2TpqKUOnFuD6xnvkPKju+e2X73oBvQwWlxbvqmrAXl5HifvcqalAxx
         zdJihafqiDFiByVW1pY7Uffv3AI/b4k/zPjyoGr9InrW5V9pO5XkbTv9LK/nxqrEVSwB
         Zzpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790297936; x=1790902736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=urAmayGrk2/YKnpNUBvPoUR9FlB5GJJ9+v5VQMZfNXg=;
        b=MezY1qMbvEI7v31/hFS2NYGgdGoMKE9LPO27An0Mmy+vH0VGgaBGfUGCccceGuQ8cJ
         s3KZUEU4lqO3U5pgLTa1EprjzJFEg07sKnGep1+TaMbOgDC5dwnnFS7t4nrAK63/lU3n
         Tb5rgQ+hbKfJQH6plZaAEUFjn7yajHRvArYipEkTkX3GuWMx1rehJr6L33TzNiKPcAj6
         2kqhFaMCYMBBe/ZPW0d5kdOmikTJTdzveBfq0Z+Lki5qnb5bJt/y4kHwykbMQ3Trkihf
         mSRAecWWbWTc7EVa9EgtsFJSCMhZSuFlAQlMt7veidDsW7Lib/Tm3v+wkFYHHZNp09HQ
         gdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790297936; x=1790902736;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=urAmayGrk2/YKnpNUBvPoUR9FlB5GJJ9+v5VQMZfNXg=;
        b=RlMWpXwdAUE1r5abHd4HKOjqvq6UxeaAZVPqNlYeSYaRRndiVX3eYRVKTu5IPRqfNI
         NrDpy/wcBHmNKaxuKZ2S5bRSdcUUhP4w9jdEsAG6qOlxX7C2O6O97Nr+JsmL6OIXW4iw
         MFIfnx66SBtCYF+JpLpxSSJFOt48rlvBHnCneCdn4THZy4lZDbqqpatb5h4D7IhLQad4
         tMhY0lVx2rjZ0qMUUBmITaL/+wRKC3SMyVG+DV9JHslOGRYiKBVXT1WGTuayuN8KvlPS
         rYg31FBmqKPj2Z5yX0J1DUsrH41LosWLiUMFXTx/sjrG9hVCbmtU06HrzN5/GMwB6e4V
         d3+w==
X-Gm-Message-State: AFuF++lFP45kz3Li5tOz9yYLikd1WlZXzt5zWt/uiGO8YNiGP4yHZLxP
	bL3nifTclKwjtFoJh3OJZGBZ7Fcw+mcMRCGf2lcuJJOV+Pq/3XNz2RDlacTh/I9CEcMXLHVXX8j
	LKOjI43az9DydZTTWUI0L22gwxAe+S6e0r5duWL5V
X-Gm-Gg: AYBFou28OcB3XUB8lnvazoUJqtlJl1fPkR2A3POBJ+LJz5cUQ2mURGAo648VU3o4aZw
	3whZyDcTXtqbqAG6d4agL75dWgGLfTxcScGSJFXwv8xeXCcX9WHrIAbPTVMcp0Hfl+eN2OHa5u9
	sN8OZ9ZzbYBmTui1wdWKKfiWp7TslWzKSErWKX+Lo1RjJ1E+dIHhwMz/eGYNZiFtffScJwvXHbw
	vYJRU4erR/8hc49u7QyyZx2yI2UcaM876XQ7SVHJ/2w3MYp8hXv9a/+0y+JP7mGz3NziFC9ySjN
	+ShuyqDMn3QpLOVvnkkvgLyk5VAXKVOzJITycvDBHnf7EfUWNFd8aNTsA7q/1IpChE7U7fjlHYm
	OB0MVZ4LGFWG6FMTN8CFIR8ZTCtgcwG5dtfuwrcYO/I45vCorznx+gI5a8KEumt48hZIn
X-Received: by 2002:a05:622a:1908:b0:530:f3f7:ca19 with SMTP id
 d75a77b69052e-5330b5dfbd0mr19703701cf.25.1790297935585; Thu, 24 Sep 2026
 17:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924224456.55690-4-jeffjo@openai.com> <20260924224456.55690-6-jeffjo@openai.com>
In-Reply-To: <20260924224456.55690-6-jeffjo@openai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Sep 2026 02:58:44 +0200
X-Gm-Features: AclHuK9sfmq7kaDYlZhIb51eTI_YTaqPKeo-GWlhfKE_S3RVg2Vy8HH2SQdgf3E
Message-ID: <CANn89iJiOQNrxAOU_OuOZafaH00K6bHM9nS9NCWEpg8yKq8fgg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests: net: check timestamp echo after an
 old ACK
To: Jeff Jo <jeffjo@openai.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 12:45=E2=80=AFAM Jeff Jo <jeffjo@openai.com> wrote:
>
> Add a regression test for a gap-filling packet whose acknowledgment has
> become old. Linux first sends data to the peer. Deliver two peer data
> packets out of order: the later packet acknowledges Linux's data, while
> the delayed packet still carries the earlier acknowledgment.
>
> Require the ACK that closes the receive gap to echo the delayed packet's
> timestamp, 301000. Without the fix, Linux accepts the data but still echo=
es
> the previously saved timestamp, 1000. Also check that the application can
> read all 34 bytes.
>
> Use a large jump in peer timestamps to represent the idle interval, with
> no real wait, loss or retransmission. The test directly checks the outgoi=
ng
> timestamp echo. It requires packetdrill's merged TSecr verification fix
> (linked below); older tools incorrectly pass on an unfixed kernel.
>
> Use the existing packetdrill selftest runner for IPv4, IPv6 and
> IPv4-mapped IPv6.
>
> Link: https://github.com/google/packetdrill/commit/83f72d3f9085d0e26eb4d2=
06fe4d7cfab5b6d872
> Assisted-by: LLM
> Signed-off-by: Jeff Jo <jeffjo@openai.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!
