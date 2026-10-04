Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A91B37C0EC
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129941; cv=pass; b=j9sBvP87URyhC53sKUYf5F+C5aTeXz2dEwXoj9/kjxdd3j+zQFK5FzmqkSJFq/OYCWZ7Ok+7BfZsNxqjgoPpGAhgbNl2ONOFzrWfGiN9jHWpCJAPxQ633XrcJQ7sSmu3AkqN0QnVQWyTSVJcjabzbGruOTEWd+4zndSgoxvooiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129941; c=relaxed/simple;
	bh=JqhgSbKXiRs9KJieJ1Lo+MaB0d6v2jx8N12NDJx+2Yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cffLh7ksFsq5kt8j+DRirqsAewNMcDSjIdr3Jgf+c6KtzveLfBhiSSSLsG5q8cf197/zOJtXz5iXVAK5beoMCOzS6TJHPEdWGjmVTFVcrYRDadCZiPwxBCmRL2VRSnHWIfkSWwpQktA/jVqAfA55FEJgCEVD/ZHr3B+zeBZAdwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=RjGZsGAq; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="RjGZsGAq"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e50968489so662649d50.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 09:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791129939; cv=none;
        d=google.com; s=arc-20260327;
        b=GIPjUlh1W2/dpvLqV8YOe6xNANFRo6lMMLganxXhkRZ2jKLgzNXBI3bFZ052L8gAE7
         8gDV5HI9w495FUjbIADp+Gs55CyxcfjA2wiD8hukjQ/YwzIp09WEtobuRkmfbyOjxKJf
         BeckbTDifis4AdBfps1/REih3qKrhlwGAqvfXdWEjzD06U/CifnmodbPDTc29OSPfg/1
         TQajzmCeXVJuAK7RcegEFKCRNKGPTvSL4W44rdL0Z5dNKOgHZR9hAMZgf2C5lWCzHyGw
         yeI2ZjViLq9VmpnZ1Mmxigd5/ys/LdL0SIdvVBsevL6/EFi4pIax2XxpE3qGZjIaGrEq
         VYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y3fsU5omFgw6BhNB+mUuwA3rZgfGs6fxlIGxVAPmPAU=;
        fh=kDE0JXKkIv2X4wwfdXQ5un52mZTUKyy+R8gbCEeMDWs=;
        b=SVEdLt7dxnjh3EFGT82lrR/KHzxUi3LyEkE6hWyFGie+bTmaUTqjFcSQfLKUF1dJk/
         TFy7VA9ZSQvYmooZuXupFr6CP591ZwRiNreiXwn+8YRg7U3Dfq9g23HH6ZN1ENQkFlXj
         4swi0BLq7PZ7yZ+ldjjtai4OVBYfoU0rU8VnW2zFUjOeQwtYsH0lE2Cm5yxJ3CVYN4qp
         235gPlYio0Kylq5OOMmKZBgfWmHvSqBsna4cYjsIX86NNp1IRSrTyCMOL6IYN1Ldujc3
         v8b+1xy6mGLguONTYPLSo8MF8+jfk/sSH5KuOvynF4nCtKh0FTni0+OQOYlbpJXtvH9g
         W8gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791129939; x=1791734739; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y3fsU5omFgw6BhNB+mUuwA3rZgfGs6fxlIGxVAPmPAU=;
        b=RjGZsGAqhhSreoarXDoOvhzfpy3W/aOihmSVvX3Tf9P2vktJ2e6wWDjLIdVPrpjh1D
         oschrti25pzjEp6Mnwk5tiZKjiopvhZ6PS2DbllQr7ta2pDNWnE0EuT85UzqWdfHMlCh
         saoVnuiF4AUA6Ldbc9TYJOaaXNBmO9wTz/TTeex4BUacJeZZrS7VPRi5F0AsFenJmXPM
         Sgn6CmXMAq2bhzDUmzeXvTrTE/2Zj0wYyQAl1gGWJ77mvGSX6T9qkcvM+LfLp7q63jKO
         303rmGpSP1Aa33AGwS1cC4SdaT2DgMuRi7/M4z1QemGdjhq5++ndolRtCJ+teG8PHDOo
         BG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791129939; x=1791734739;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y3fsU5omFgw6BhNB+mUuwA3rZgfGs6fxlIGxVAPmPAU=;
        b=GvkEnAeKmL/xX5Ki0/If77uVei3nnMSm/4wK4pw4nfdWxt1JQ2vRaQiA/zfpafazgD
         eJp/+hkeElrTBIPxRNC1tLn0SvVJx6kefOIidxCU9fgmlMm/dBQQoKUQn2NNHxy3JR+4
         p8zmqDr6aKnwIgchDzqH9jMyvTQe1ZmcrLWkfIlTquWGjSTdqzcpkKBolTLf/RnCoyn9
         hH57UW8reUTonAJQmnWjoXsLvTkut/0khgVHYPOqY15x+bCHKE+6kiTwHQ0kY5kEoL+i
         GUs44ZIF3zHX9qAGuY9TvbWmhIHnHHwfAh1WcMvqHQXoDC/XFBl7TWUjMb7C1rhi4klS
         3AGQ==
X-Gm-Message-State: AFq9FYJw9arnEWh1FTfRQsvDBrE9Wwe/2nvVxp5QhKTC9jodf6Cq3HUb
	P0r0mcam+XDfguaufst3ON9I5ye6ATf/LQxEPVaNR00CJKh95sRgBRhEFcgdJiaSI/IBEGB2/ed
	anUcma8HHONaHwFjTLEDmWonDTY9hbF5epREDq1dj
X-Gm-Gg: AYBFou37xwIj8ZLuVbwhZ7IlSZRAb6B/RRsYP67DNlyipLy6H3IEzH/Ud47dAx7OLGc
	wVhFR7ZFy6WNgPDvnEHMjRva75SxmupB91EhpSbMb3hbqgDTfgvtwOIbf4GzEAD+XHzqTwqTpgj
	4PNXDYvlKh9Fo5gxb0698Pw4fAtlhnDr7EgHKGc9Ht2LCUccucFrV56iJ+dPW+5ExweBw8iUyXA
	G7qt/WXNFvdetZMLclRESetNtfnb0bRTwEO1MYyHHFkmKD/sL7cSM7lP2rXMQqdYyKX4fLav2FY
	RYk4vy1mLd5e9/xebMvamIgB+aJOXziUsmt9SK+J4dXtsGgNA4MH42eyVbhZUNG5hdD6lqE46YT
	tqlMcWqrhYfpzcBH1Hu0xo8WrD/55n8n5BKJ1S57PmZg92hl8g5dP9Iu9OCYiuZuspf4LypulPq
	Cx0QGP9eCaAX62QZqp56CYmWxO9vONUuwI9yKWR3lSibW+0wF122OmVZD1cmIr18b4Xc8LHR8nt
	BxD4suRWPFiP3WsGm+lhNGE3VtpPq7vNmyyzWKl4HoLKXnd7hM9kFL3qT/GAeTUdHP11w==
X-Received: by 2002:a05:690e:1616:b0:672:be40:5eaf with SMTP id
 956f58d0204a3-677ac079547mr3282301d50.54.1791129938951; Sun, 04 Oct 2026
 09:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004124254.3525496-1-julius@bairaktaris.de> <01600be7-3d8b-48b2-a59a-1125eb452714@blackwall.org>
In-Reply-To: <01600be7-3d8b-48b2-a59a-1125eb452714@blackwall.org>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Sun, 4 Oct 2026 16:05:02 +0000
X-Gm-Features: AclHuK90kbEfr1-jBe_BFIZ77DR1u5zlZLof02Y-HmHYvTegFl8NjlWTcp5jAKI
Message-ID: <CAC1t37+4-Pf3j_x4_cYj-+_hj50W66f7TZWQaLavPJwSzmAf5Q@mail.gmail.com>
Subject: Re: [PATCH net] net: bridge: fdb: hold hash_lock when an entry roams
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, 
	Ido Schimmel <idosch@nvidia.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Nik,

Thanks for the review. Sounds reasonable to me and I will look into it.

Julius

Am So., 4. Okt. 2026 um 13:44 Uhr schrieb Nikolay Aleksandrov
<razor@blackwall.org>:
>
> On 04/10/2026 15:42, Julius Bairaktaris wrote:
> > br_fdb_update() lets an entry roam to a new port without holding
> > hash_lock. It notifies switchdev that the entry left the old port,
> > writes the new port, then notifies the addition. When two CPUs receive
> > the same source address on different ports, these steps interleave: a
> > driver sees two deletions for one addition, or an addition for the port
> > the other CPU wrote.
> >
> > DSA counts references to a host address on the CPU port. The extra
> > deletion fails and the extra addition is never released:
> >
> >    qca-ppe 3a000000.ppe: port 5 failed to delete 02:5a:0b:a2:1a:46 vid 0 from fdb: -2
> >
> > With one address roaming between a DSA user port and a Wi-Fi AP port of
> > the same bridge, the error appears 3-6 times per address when the two
> > ports receive on different CPUs, and not at all when they share one CPU
> > (4 runs each). With this change it does not appear (6 runs, different
> > CPUs).
> >
> > Take hash_lock when the entry roams or its flags change, and send both
> > notifications under it. The common case, where the entry neither roams
> > nor changes, stays lockless.
> >
> > Fixes: 90dc8fd36078 ("net: bridge: notify switchdev of disappearance of old FDB entry upon migration")
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
> > ---
> >
> > Notes:
> >      net-next 941056f91907 ("net: bridge: fdb: factor out existing entry updates")
> >      moves this code into __fdb_update(); the same change applies there.
> >
> >   net/bridge/br_fdb.c | 14 ++++++++++++--
> >   1 file changed, 12 insertions(+), 2 deletions(-)
> >
>
> Absolutely not, this was made intentionally. Taking the hash_lock would further kill learning
> and roaming scaling. Surely switchdev drivers must have dealt with this for some time
> now, if you'd like to fix it do it so the software path isn't affected.
>
> Cheers,
>   Nik
>
>
>
