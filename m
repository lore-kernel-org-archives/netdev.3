Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB03C0625
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903583; cv=pass; b=mcTvFj8Q+Yezt9pAwViJ1knkR9SnwgLvdJX/HaIgRNhespovoMGRmJLToy8yS9E2pONeRHLT5iC7gBHfxrtwVfxeySnlCWVcmi776h/Z2BGb/OnEGIcJcyrsHEDhFXmY9/CKbCPWaTu3aaQ7q1rflu9Sygekp15PLk0s155Iwhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903583; c=relaxed/simple;
	bh=TNafH1k/IbhOZ+c1ihZUoSaIWJuTHLQx1WBK/0hi05w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddWW9I3b4zGHUvYQcjJumlNwMB7rnxD+RdAl3BQgh1QDjIh14svT5VakD1R5UWslqnouDhKg0GX12DeJZYtKk3UOPGY5am9PGrRn+Gxpys2ZBxcMjYRuioBY80btqtZm8zwDbUAS8WWHFe3uJhc6liwV1xfPiip0+plqZTSgaw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=tWnSTDcu; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="tWnSTDcu"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a2e6d6c31dso6575141fa.2
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 00:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787903580; cv=none;
        d=google.com; s=arc-20260327;
        b=m4YhzBkGjaz9J31o8/v0cPZDFMDkfC2lAwFa1ffvZNScWn6zV0WF9YgU6IvPS7NsL8
         fVDX4fyFiW6zU9aQu7GC9HtnSZ5uCe5uTWnhXRlRWKbEgnTv/V5Xw9fHiTTiuRwdwAjn
         ij3wznUwcKHASlKD3bPYlUhW4pSlVsrRbVRpDwf3hsv7oxB0fFGVokoMYxJ/3XGHhuZ6
         gM3Hb+iA9EMLt0HcbFD1PbyBtN6TgGZ76aMDJP83aGxgQy/rG4OlbYS5qqvMX8keyWa4
         1bgRfkhOoWkNfbUe2lgquaxmbYxdwTvAxCXDBABGLsstRf1hg8+VZq5Cz4wbb2zFnS1m
         hRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kmYleCXYZYXRkt4vuaUJjHHMfAWiaxlT7cmkptdUeOY=;
        fh=bTvYvVRJZ/o+f3Ne3gpKNWlWsczp/GunEoVArvTyQII=;
        b=oQG5yFLuF8m9ZVlTa9j4SG82Bwx0ND+iCiwA/g6sMVE1U20/Diex9ZnvXcRehscBtd
         n5BaEs9kBEeAKgf34jty6cByrNOCSyKbeyXGU6jWAGE8s9Vm0TRovpTwmgPKEIlvvwvq
         3u+F1WeOLBBibhWQXiJkzSGUamxN9EiqJ27is6dTdmuOl0cEZIoXI5X9XI6cQNv3sGMe
         FQ3qGbKFWLczoKYiPD5Ai3Ek+3gHrIReld0QYBalSeca6Vk9jfqHnYdbK2fXtYnGoDvs
         HA9q2lRmuKbJHIfTM4CVQnj0+zHNzV9auvu4CvnJASYWbdse6c2ysY0UgIkYfaqfIff7
         nfkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787903580; x=1788508380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kmYleCXYZYXRkt4vuaUJjHHMfAWiaxlT7cmkptdUeOY=;
        b=tWnSTDcu0GYyc/e7/d0A8y7abDGzZs9N+RbdkkoOaQLFmpdmEjOxitrgNF8A/WNezC
         oLxucOmUo5SleW6WaOlYhtmtXO0Sj8isLirx55mp9tR+XD6ruQL0HYimhLtvXRSzMBqf
         OXVbxir/48YTXMgen6r3nMuMOGvI3U8VZ96ZxAUn4ViaVBCUucJG4OZFHZmIVrltGDTP
         jaQRukr4qeNJsPNg8u1Hs5dQtQDKSZncHvmK+BvMNqp5jhjw7giMhIdf+sSLA5a3KFcR
         3xeiIwe0cZB0dRlXfuibspYPMC7StEP/T8vdmY9RbDLSqYFyCvr985FcVGzlXmMdgleq
         SsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787903580; x=1788508380;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kmYleCXYZYXRkt4vuaUJjHHMfAWiaxlT7cmkptdUeOY=;
        b=Qc1K63lQJKpdox57yZyp0N3qHvPI9ELeEc+2fCLYnXWXvkgWoNZyYO+yOudIopWv8C
         f3HmzWtc8w3y4SVH8Q1JQO1XtBaRccU83V3/t9fWzU13c64syF7zaYw1iGLLOpJ6Jach
         NMAPOUaQALCmlf2ReCKz5nRokXKuen9Ir1v3HSgOV6k+k+Du0nf4JJkZS1W967qoJx1T
         NxYLro20LIs908cQfNVgwDKARsbZ2PlMKNBHy3Pu2T67ugsRO8p/0SXdTFXxeQDILfhu
         GCD/Dvck5XbXXn2Jrti6eifvotxqDMDYZgpCaM9zyB0tcqP5bGiZZYN5XrIG/mI6Siss
         079A==
X-Gm-Message-State: AFuF++lQ3bqWbKlmrbXrF0QqNvDTgBuCWhWIkHKwJmz9ojR0Z70LylyF
	a39zoptRUNFf6t8I75STaievVQ59ExuL8ZXE7uFZnPls9H2QXgj6wu8wFYEO+0Q+WJDmqOPx0g8
	xi+3g0ZY1+zldsDglrm9PixtdJ0/lO97kOdTLh3w5psj9sxsSfKXxx48UznuY3fLl
X-Gm-Gg: AR+sD10cbdlCy21bH+4agFC6Ol5yXHhYkqcS0EPWDw7kIYnb+axO3HqpCh95Qp/as7+
	6+E5iT5Cn5MrRBluvj9PIQxm3TfVjKhbxlfSLyYPaaLIJ4ltz8T5f6GneQSAhdhQuyMHUcCOe63
	dtfc1DhpnEEBTiS/WX4AgcbsVMl8WgQRbpi9sPJ7qH6UuIpWCvdeW24sAv4hYIGzMmC9jITGm+H
	H0GynAo7HOP7EhO/v5CMmI9Y8vYEeAmDuwPZZUxBg9HTwoXVWeEXX7Aa9Da6Ai6UPkMsYdmA0gu
	x3a4MMbrhXvjsNBBuQ8QMKIcSvnANCFjq/oN5owudcRskzulVU5iKhl96gjb2pt40epcy21nMv0
	YESBbA5GQBWBmZXZ/FmT+
X-Received: by 2002:a05:651c:3056:b0:3a3:a3:3560 with SMTP id
 38308e7fff4ca-3a301b1b926mr7137971fa.6.1787903579652; Fri, 28 Aug 2026
 00:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787854085.git.zihanx@nebusec.ai> <a31c6fb1ab9846c85e245fcf34948ac2bc27e521.1787854085.git.zihanx@nebusec.ai>
 <CANn89i+1xLiL=nZOwoSH+OwX1+8io_Cd2_5b4s-_NcN+kBh+8A@mail.gmail.com>
In-Reply-To: <CANn89i+1xLiL=nZOwoSH+OwX1+8io_Cd2_5b4s-_NcN+kBh+8A@mail.gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Fri, 28 Aug 2026 15:52:45 +0800
X-Gm-Features: AcwNN1Wlw2xmG9VSQqhlLFZOqVW920HInRT6-kbppYVXYZCPm1-sEjFLBIVBm2Q
Message-ID: <CAANe3eSydRy9qiDQhQMPO1nEni_Ekz4aUjnhYh-o2gwEn=9Y8w@mail.gmail.com>
Subject: Re: [PATCH net 1/1] ipmr: restore a limit for unresolved cache entries
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, stable@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 3:33=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Aug 28, 2026 at 8:52=E2=80=AFAM Zihan Xi <zihanx@nebusec.ai> wrot=
e:
> >
> > Unresolved multicast cache entries retain up to four received skbs whil=
e
> > waiting for userspace to install an MFC route.  The cache entry count w=
as
> > tracked but no longer bounded, so a stream of distinct source and group
> > pairs could retain packet memory until the system ran out of memory.
> >
> > Restore the unresolved-entry limit for both IPv4 and IPv6 multicast
> > routing.  Reject new cache entries once the limit is reached while keep=
ing
> > existing entries available for normal route resolution.
> >
> > Fixes: 0079ad8e8dc3 ("ipmr: remove hard code cache_resolve_queue_len li=
mit")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
> >  include/linux/mroute_base.h | 3 +++
> >  net/ipv4/ipmr.c             | 6 ++++++
> >  net/ipv6/ip6mr.c            | 5 +++++
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
> > index 4d55827e9705..af9247bb3f4d 100644
> > --- a/include/linux/mroute_base.h
> > +++ b/include/linux/mroute_base.h
> > @@ -224,6 +224,9 @@ struct mr_table_ops {
> >         void *cmparg_any;
> >  };
> >
> > +/* Bound unresolved MFC entries and their queued skbs. */
> > +#define MFC_UNRES_QUEUE_LEN_MAX        10
>
> Wasn't this very very very small limit a reported problem in the past?
>
> Nothing will prevent an OOM to happen, even if you set the limit to 1
>
> If panic_on_oom is set, it seems to me that this is working as intended.
>
> If we want to silence the OOM, just change ipmr_cache_alloc_unres()
> to add a __GFP_NOWARN?

Hi Eric,

You are right. I missed the rationale for 0079ad8e8dc3 and the
earlier report that the fixed limit caused problems on busy networks.

The reproducer was run with vm.panic_on_oom=3D2. It therefore only shows
the expected result of forcing a panic on generic memory exhaustion; it
does not justify reintroducing a per-table limit.

Please disregard this series. I will not post a v2.

Thanks,
Zihan
