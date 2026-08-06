Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C4C3C09EE
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041944; cv=pass; b=HZ1Ef/Lm6oIRLnrAyPmLGxJIhtBT7VpKo30++X9V4v+XWN707i6PXcygJizmRaHWuFqMHJZ8Bnl6rUxOxr9B+ri53B/QVzfaYGCywXoB966VrOiOspRwX6lkkj+LeLUMyIHnPiUyUzb6pf1rbxdQ3AvG0lq8xFveTkep/CzGCmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041944; c=relaxed/simple;
	bh=de5JCYycT9XMebZgSgL4FUbLSZcYTscfvpLUwqXfOZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqmxXbfRzr2r0386UpCXY5P8tN+zq9/RJ7mXsDzAyHpcFWTJqZ4+c3u8AT5y6Cef2Xny1dOQ4BfMm4Ybez6cvsdUkYpIDg+obBxKBfsGgJs2ML0fc/HotwV7wfG8Kk+jGs8r6jicnXJ6p/ljwkLKsW0cPdhu8lgdyOY6LOmgnY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=DgtZQLYN; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="DgtZQLYN"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84864086bfeso2244035b3a.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 11:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786041938; cv=none;
        d=google.com; s=arc-20260327;
        b=ecz9hBXnGvXXCv075ARgfOJq8Tj6IMJfh9Ag5g0k6tpocoNUxALKCBUU2zFgRjtNLd
         hCGi8LFSJyCWfk3+2Y+ynlFXGNB2tDTwJkQbhe9SnA9KG9K7vVBvUHM4bRp6m+FS0dVI
         coh1mw4lUDvf1rXlOH/OQeUdOOZcTyzkoYqEnlFeK5pgLEnk2IG4VnBYmA7pZwdNhMem
         buONHvtk/9SifTqvua4MsWjzVOLeBzpjjbQMbfy2NIB5nFH0UFHBnnDpoA9DYk7lJtlU
         UpQ2seUnwBkoaIPtkfnlFLAQMV+sP6IZ4evpaHqldtWk4VY0wANkNSXn7lG7MK+o51xy
         tZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DTiPbsyj0cZyuyHgSf/xXpq0YFIKQg3L7+3p9Oiu6a4=;
        fh=P1/sk2v/ynfj3YqUvYad93KPQ1XIYnEzobMT0w/CzYw=;
        b=TzBR0wiA39x4WvqCLlaiexbnNjjJdl46ewC1E57k1yKZbiBwIQaTmiT6UgRTrS/DVE
         ARTqElrqBNuchXtu6rWQfMnNq280QfUzQaMEk9LRvrcHpifd6ZvIKEnzD0AIEFYxBiBF
         xkHSnKRvPxXd2RVVzn2ys27SZ1nLAEQ6v4MJ8O+onXK5Ir3UzxIB0H+Tc7qXqWBXppu7
         BRF+1bj1S9B38FSJHgoWf9K2vNJosJHLQZoqb8cgalK5kHxqX+385ngrfaeX5FbqJPHX
         81Cwi9RYO7OCjjm08enU3K4kYlMUnIegG1gFqMnmBssxW8RwxnmYuqa1LTqESLlnRR+C
         2QLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786041938; x=1786646738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DTiPbsyj0cZyuyHgSf/xXpq0YFIKQg3L7+3p9Oiu6a4=;
        b=DgtZQLYNM1AHhbErv8VAdewM9WTyglG+DKnfhQhF0F4p+15ZDud9kMtaAjBiTJAIgy
         65GR6VQPqkgNaaaRqiCyZqci4Cj3ja5wHrfTTtZKkinVWcEVSVZLBPeevXKS+8BVDaZd
         qttJ/xujUmljy85fhhsj3vnZ5YeQeXSaar7As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786041938; x=1786646738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DTiPbsyj0cZyuyHgSf/xXpq0YFIKQg3L7+3p9Oiu6a4=;
        b=resTFbht98+cDfy+Vu5+ZkB7I9iJ5XF/G0iqYoldMbFdBYeGP0wbWPQnSljNo5EuI4
         1xeU8+ill8tk6JTeSwhZiGiGNnOhpuKS9NQXrDoiV/C73iIL5p1MvU8BnUVNhRva9REQ
         o4pZWjs8yxE4HM9cEeGNWeux8vnyINnrx0QJfaWxoc3uvSECaLVE0qNoP+nhvfZsKc7D
         P6n0ZccT38nVv9RgTLHl5/nw5U+S6qJqtZhwq6zqqX/rSUe3hfAvE0qDD5M1A3MHc6Va
         q859FHUoisf4SsBWDui6uxZ63QeUYCQlaqlIt1V/RtBrIUIATwq/cZLjaOaCVG+9S30n
         gB6Q==
X-Forwarded-Encrypted: i=1; AHgh+RrtJQ4VYgiG4luuuLHQpvLGxIZk7rBOOo9IEX507VCnbuet6sjjnHbDEUKZ0q8UL72+KsI1bZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMhS+dVo4AoX29L01aBGouvkQ+Mw0C2EdF8KhsYqdNSsB3dkq7
	z7TxVuGt4horL5aMj9t9nGIii7DoFTJp/69v0KHNgiOY4eYosj6e+KFdzqyiQl+iMIbV0oiXeVz
	IYkzuid/j25etXOKGrKc2YG6/cc5Mb2sXUgxyG5qS
X-Gm-Gg: AR+sD134N9ZqYX7do2Topjz59rO24AqcrNZ6YDhxoJK/XEKDbTbX5y310OXy6NfD98K
	cSc3Dr5BvmV6xkV5DR8ybu7/av+n+oEnA+WaIofnK4zX1Ry7Y/+LBz7dVb6IST+k3uqYx5AJyuH
	uZ8u/1DtCEYIUD8p2qqljZCAgpv+T3TliGqHSIq4t9g9g6zsM0Rpz1Rb4y9qRlxQy8wYsb71Kt1
	SDsLDW9iyfvOFPvi1oSB5K23p3VlQVWMbhdrEdTnT3ZTNMTbGZ+5Rp5VzqVH9iaz2Ipumw+oqdv
	s9YbJvP5oTHVRySe35P5ulfKPas8J6z3MH6XxxkiQSIdkw==
X-Received: by 2002:a05:6a00:3012:b0:845:40d1:87fa with SMTP id
 d2e1a72fcca58-84f2e017f3dmr20415499b3a.25.1786041937952; Thu, 06 Aug 2026
 11:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806101235.809370-1-hj351016@gmail.com> <20260806101235.809370-2-hj351016@gmail.com>
 <86bdf738-6b23-4a13-870d-8f3403d806f7@mojatatu.com>
In-Reply-To: <86bdf738-6b23-4a13-870d-8f3403d806f7@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 6 Aug 2026 14:45:26 -0400
X-Gm-Features: AUfX_mwrvyto5FLhWXg8_Q3fLpeDorfL0uu_IFlnewNdmaDVZpSxIHylrKINpXQ
Message-ID: <CAM0EoMnMHjq=G0PaHvDs9yJ9Vv0uJP=h69cbV11LNiYG_o-O_Q@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests: tc-testing: add act_ct test for
 malformed header handling
To: Victor Nogueira <victor@mojatatu.com>
Cc: Hyunjung Ko <hj351016@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Tao Liu <taoliu828@163.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 2:43=E2=80=AFPM Victor Nogueira <victor@mojatatu.com=
> wrote:
>
> On 06/08/2026 07:12, Hyunjung Ko wrote:
> > Add a tdc case covering the leak fixed by the previous patch.
> >
> > The test attaches "action ct" to a clsact ingress chain and injects ten
> > IPv6 frames whose nexthdr says hop-by-hop but which carry nothing after
> > the 40-byte header, so ipv6_find_hdr() fails and
> > tcf_ct_ipv6_is_fragment() returns -EPROTO.
> >
> > Before the fix act_ct returned TC_ACT_CONSUMED for these packets, so
> > tc_run() never reached its TC_ACT_SHOT arm and the clsact drop counter
> > stayed at zero while the skbs leaked. After the fix the packets are
> > dropped properly and the counter reflects them, which is what the test
> > matches on:
> >
> >    before:  Sent 476 bytes 11 pkt (dropped 0, overlimits 0 requeues 0)
> >    after:   Sent 400 bytes 10 pkt (dropped 10, overlimits 0 requeues 0)
> >
> > Assisted-by: Anthropic-Claude-Code:Claude-Opus-5
> > Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
