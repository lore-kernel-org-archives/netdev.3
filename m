Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122043C1090
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360478; cv=pass; b=L1vQ4v/uir1YDljUzK0P0QjjkBuYGLyPE1s08BVt7aWTRxcRhqYgBMTdeJ+NNmcw9rpWMfRUaI3unjFEM1zHOKsG9I122WKIFHZRMBy7dH0plF/J+wHkQgTfJsMOMQNjOutrFhC+5bTLganR9391eGHNef1RcEsYMrpfl/8Fiwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360478; c=relaxed/simple;
	bh=cRfc/QaU5QXqQWriDe7bBcszgQMf/vLtgDAQyxrgu2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mf4oVzggzCN0x9H+NYvFcUiG/yze+ID1kFI+mrDNzvR0kWIfuxkzodb+Nq43UFzt6wRWBjApK3QmD1jwM2xOvIQuauFdi1shfJGR/6Iv6axj11doi5EaMkhSu4NMZLM/VmH8y/0aAbd101RRTyiMlY/IQKOUaX5WVsUZpPIaIbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=X7Ao9rwo; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="X7Ao9rwo"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c89636920a3so1592722a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783360476; cv=none;
        d=google.com; s=arc-20260327;
        b=mOalZpJRHzGxClBqeyUl4Nn65Vakqh6jtMOgzNUTcxmAfjzwR3h1GUIrryJFyGRT8p
         5jF6nL88TNbIsK8fMRUgRlx5d/wmF3vA6ThZzMYyD622ioI5RNiWY5daJUezREASGY9W
         uIxP0jKUvfZPkdD23hj2a7MPZXPnNEEDBkWFSSyoyGI/gbkoIwG8hp7JpCJR1dNgyn33
         /E5Kag+Lkr987OEXhlllrCaDf4m9cN5wcSgRnjp0o7BTEl1b4/GcMVWDGzU6f3bbHhiP
         FwPqz4jtxEQ5pcKmpO9HJ0U3RUs/FeMc+lKKlI/81p253J6k9PJVjFCRNkEYGZ1JnH51
         zKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S+HjSggw8tQDkDKIfCm1yOxtLYYzrIetkGeZyiNmdXo=;
        fh=oH9Tx+podRF7DEj3LsJFg09mgx0C3WCDnzuPaRRhFEw=;
        b=lQ5ZQRlRhm7/K6fspIf8Apd2HCP8u4Av3F57rzqkSGgVdLHM4iOVFmY0iv+fOeXwPv
         l+F9IbeKg38VaCxuXtz3xeJXPvIPWFUUDuaSocl7rvQM2WEGMSiZui+cjH6PAl2SpI/1
         n0cCXpe9JvzVaqy+BCX0rYTDL9DGYLsTnfogptWUHVFv8O+wt2GRydDqao5pdvUznOT5
         59JRrSUru9nCVUl95DoHTgFsWCFdKW11mB446YmXFZXmpSoKVTLUYQrtToucGSF/ppwm
         60DXjktE5ampQ7eD8Y3EMMihgy3TFgARdlfcqVVZXAwe6VM25GiXnyvl4KI9qveYEcNt
         56lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1783360476; x=1783965276; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S+HjSggw8tQDkDKIfCm1yOxtLYYzrIetkGeZyiNmdXo=;
        b=X7Ao9rwoxnm/VTvmsFnz0nqaTCDY5UY1+qP5ICH9Ndh32r8B73rH4bp2sk2sh2mHRt
         hkjEm59w0GgW5SgNQIHFz2ZbmtyR91R1NrMMdVgOMyIVZEOkjsvQe7FeynD2E70uL9Zi
         AcTw+XhB9TfZE3QjgugH/jHgtiHBKWhVGXNMD+tCZWWm2Jad3BvsvoL+N6/agD+cv8HJ
         EEhtyjZ3nA9kO6p0xc3OHDB0D8ozt685KyiYgUuU8DBMM05eckLDa20/G4FTyf3IKqGa
         r6PKrXWcYD/1ZLHtSewU1Gdlck8ePwjBPs9ShveqC4SD64ltgigDTz+EUyLL7UINyc8Q
         wr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360476; x=1783965276;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S+HjSggw8tQDkDKIfCm1yOxtLYYzrIetkGeZyiNmdXo=;
        b=L2kkkAbJSNx3O0pDVgixvubUBM0zbW5Tz72XRtUvpBmn6DfQ0gdR4sq3bzfVIqjlJt
         fm6tuuwleeAQg68X0ySxNYU49Bq+z6IXNDd1mpH2PGAjs4JMU/hN38HvwykKzkjtbAvh
         qoJuxkZmO1lhZR14ZqLZTuNCVf6AObxTWwfhN2fl4yQxxirelX5D75sKWeYK69hxGQAd
         4FrLS/6nDQNshRCxSnzUODLQlFdk3Iq0JHXJFE6Gg0UpLiksSvz890lU06/387DALxs7
         VBhP7muaCEiFWGcHwn50dV982RKSr3VhHaGuRafCGbYKFeuUZ3DWNSH70DaXV2kUMNnv
         3a3w==
X-Forwarded-Encrypted: i=1; AHgh+RoBJ//ilclMyvNouj2EdrT3mnizVDgCd2S2b9MdxOpzBv3mXs1rrdjrvuxkdO/JzSmUi2srhUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwqqUaXJ6pCB5z+b/tPFwbToNIi+9dk8sIQ7DtEhBEgukIPcm0
	C363VJJQ/zPNzCWa5Av5UTPU5kJKMODLb8J1GY29DOD9dJM5mvMoW1I8nuaevtuey7JTSt+ZnLn
	f+DR4ioKF2P+TLWmH9cI1/9FhFBupR0RCuW4EFaI50w==
X-Gm-Gg: AfdE7clDTaJ+LB6gwuiuWLAAgnDVXAWHJoMbYIXaijw2DpOgzbXbQjunSknJKyxt3wM
	7Io8wpCrQEByU0sIkuvjyxNoHeP+kfZDlVW78yBOH7TC2yeC7KnZkLqSa/IQL3q/1Rdg6/AJSSo
	SvlUg85mHqsUngfDekNWGYcm5smcuCS9R7OR2qSvZBXsZSSSDi72a09Cj7p0bsuz1ocpUwUsfuD
	1h/61cCK3fa1kY21pN9drn9Ny80zWqyDauQnZj/57Fvk4CH43bwQhUxdToLnk6zLVxbciwm/3lr
	xNOqpOod4hdjPNmfpafVwwrcn74RSHix9Ouzg4Mc1LSZK8ymtN0bVLjkxiAyfeu5wVZ9BQ==
X-Received: by 2002:a05:6a20:d494:b0:3bf:a11c:176e with SMTP id
 adf61e73a8af0-3c08efab30emr2114739637.57.1783360475954; Mon, 06 Jul 2026
 10:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
 <20260611192955.604661-4-alice.kernel@fastmail.im> <aiw8JPsgG1K4D3z_@zx2c4.com>
In-Reply-To: <aiw8JPsgG1K4D3z_@zx2c4.com>
From: Alice Mikityanska <alice@isovalent.com>
Date: Mon, 6 Jul 2026 20:54:17 +0300
X-Gm-Features: AVVi8Cdu3scUO05R-2_TzrJL7PiQ7EzfbyGo_F5p6iQj7fzVgepF5A5_oIM-_xU
Message-ID: <CAD0BsJXLPELBROKq=tf6FbDEbFqfpiDBfow_ZeVa9z=vH--dFA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 03/11] net: Use helpers to get/set UDP len tree-wide
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Xin Long <lucien.xin@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jun 2026 at 20:04, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Thu, Jun 11, 2026 at 09:29:47PM +0200, Alice Mikityanska wrote:
> > diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
> > index eb8851113654..275fe1bc994c 100644
> > --- a/drivers/net/wireguard/receive.c
> > +++ b/drivers/net/wireguard/receive.c
> > @@ -62,7 +62,7 @@ static int prepare_skb_header(struct sk_buff *skb, struct wg_device *wg)
> >                * to have UDP fields.
> >                */
> >               return -EINVAL;
> > -     data_len = ntohs(udp->len);
> > +     data_len = udp_get_len_short(udp); /* GRO not expected here. */
>
> Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> However, I don't think that comment is necessary and you can remove it if you
> wind up needing to roll a v+1.

Thanks! Removing the comment before resubmitting.

> But also, I was thinking:
>
> > +static inline unsigned int udp_get_len_short(const struct udphdr *uh)
> > +{
> > +     return ntohs(uh->len);
> > +}
> > +
>
> Do you think it'd be better to call this udp_get_len_nogro(), which would then
> make its usage rules more explicitly without needing to litter comments?

I'll probably keep the original name; "short [packet]" sounds better
to me than nogro/nogso, and this naming doesn't exclude the usage of
udp_get_len_short to get the raw value of len even in GSO packets.
