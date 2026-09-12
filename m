Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D74BEE43
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789234530; cv=pass; b=CjouA/mcULAHXNgCrZdv8+5a0ZKURszDyWvOoxVzU51+YzAovUmaoet+fzJ3bVBCbr4b5bxhw/raL6TcQVd9bZEs2BzO2Zgbe2MSY5NAhwFzkMnLy1jK1bo2ZovhUhcIsBP1uQ4VJuCp6o/QyhDuW6mo3VTuRqEglgxYVlSufGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789234530; c=relaxed/simple;
	bh=MG/oMutIsKGUZqj5v7QgFG2V0GauV5NB34SQJzSYO0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgwZzEOhrGve7h8JjavSWmSRMiIlc2elVWv/8W8mOmk6vYJE9Tt1EOGEioR4Cb6quKGqr+ktkhyGUvbchRny0vM7VdH5+HEP3L2YDUqH2qaG9RHohm0yAGnLGjWcMKVDHSyH30X2gFAGAfI24Y+crOrI6JQGluyeU/unKXFm4gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXUv1d5Z; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXUv1d5Z"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9106feddbdfso12302216d6.0
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 10:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789234528; cv=none;
        d=google.com; s=arc-20260327;
        b=LpFsu9r9lu19OZN13VwRNV9y08wQCSLyHjByCuuIyXnvdEZ/U3izw1bQwzhJ4shI+d
         Jzd/9zc48+iBTC1zBo6xrnbL/EMr/b8GUiRVlhqyR05ITubdLLU/wD7NfhaNE8+DrMp3
         FocrIn7+Byp2tMskRGsAI6wAxdYguWRC6hzP2AsJ7646/zNFHQd2rVWpfn0NSGRXqc6Z
         SeFq5eZiOaCnzRJCFvq/2u+b/hFjcHh7FQfu7WdGbQpy+afXMCb7VXg7b5ZDh32IwdM6
         uneuoWAmZzBgxxKHkUtrm6lgTuKt5TpSE2P7KhGXbJQ2dIGA54vviGiFVVn3cIv6tSzP
         stcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MG/oMutIsKGUZqj5v7QgFG2V0GauV5NB34SQJzSYO0c=;
        fh=kTbgB25+oHCMfX5Puy1pC268Nol9gPiO327ZqPD58ww=;
        b=LsbcCzjBEThGrQ4hZev6zewSlo2UIiDz5ucSDy6ECiFTwlW4WQQ3uwT25hMJnwOSht
         HHiC585zK4aY3p9/vSVwkvLC/Cotl+s9U2x4OGxBY0jyCV6Lv8RPbkSTmVNjml3QO45h
         6y1WZrtceNTcVFgHiKJtKobE78S2/q2dxxxxNWMBmyTTVQNjtu0ZKzSe6EgNBTPkYMXm
         LNZGmAYdIU7a0QddPyoTSLYqSPmJp7cchdZ/kyLM57kaL+lBSTwtaHpYh6BmWFdX76rq
         4lzR7MRuWKEk5iX5dMKkO7utZkfH8j0u68IJTJ+cybvgxshWu2E1PLpw7kA+Sxg97swv
         KZYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789234528; x=1789839328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MG/oMutIsKGUZqj5v7QgFG2V0GauV5NB34SQJzSYO0c=;
        b=SXUv1d5ZusVbW6QMcQKAkJOafOuzAnGNaJTQE6I0n/3bZMidqHQPsUe7ezSYFvW5eR
         84P/Llv56IOl6B3OWHc9j9IntGx+ZJHGFyI6ANX6b055aX0YD9agYfz17+yFqUIKboAM
         t/V3BjQqU5C0VMj51Tx8kJGQpxfKlQvNtc1Nj5nfSzy2OHCMEKcSRLzMjxkYmezJ50K0
         NDrGQc9R+et6wU/9u3iSVefBBbJJUvqo+DX/A2CMY7XNNBPR8nao+11MuM8Ckn8PkiQP
         6OVnoQaP9vnIpYJUZ18pBbqwFqSGwMhua2TSadaykkpIslutQrmGMRsM99tIt1E8VSZb
         QuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789234528; x=1789839328;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MG/oMutIsKGUZqj5v7QgFG2V0GauV5NB34SQJzSYO0c=;
        b=DCWZynH0Xk5Y6ABfsM+ePQwxo+RH9sNOk+4yDe+7riVPfbXa9mEfn1I3e4ZQjswhBb
         m1xjJWGHBhVuod2XNINjPL5Dv95fTB3ZJLXr4HuRlspizwe9X2JI3MVL8TEvHdPF8Oai
         yJCdUDoSwzDsKjsHhfXdQsoZ8V7y1NAj3JN3kMU4Q43MfOa2sUP1hIhZLRtw4VSFd1eE
         yxlFh+RdQTIwOINj37hi2AzNXyIhUS/XCaGWZ5t8jnr5uDexy33lrpOi0kLI8Ncxn9ch
         ucPFbv9K+ci0C8mBmK8iN+rG+8J9zKT3rcNGeun8rlGm9xcwkDZZA/b8hiOJzz/LEiWp
         o5pg==
X-Forwarded-Encrypted: i=1; AKwUvBzFc31v2W7qoBN7WsRTIqXWVjX+pCII7z5qtN3ZGLo4q3Y0z0m4MHXcfxT4OIXIQe6i76440EM=@vger.kernel.org
X-Gm-Message-State: AFuF++mXtcFaARoL68lgguQODm1rbLaXoi0b9WW3Z1QeZ3H5qzrV7ywv
	plB6usPqLGMUY2DLp90lm4eZ0NQW2qDz9cF1JT9Ke1HlTwMwGle5s87PX7sc7tkri6MOIHHZaRz
	qgEx6eZharxDxVmr6n5vj09iprOuYg1s=
X-Gm-Gg: AYBFou2ez2b9OPNvLJ/9JLYMv/QWLjcGapHmjZI8uIi1KBVc2mgwJmN+gCkRWO9JnP8
	X4/v7pjZdmnBm/oX6BcKUYfP7u1OxTJSEKYANe83IjIvY13OOR9eefLHCJ+OnJ8SZgS4ZjsHmPo
	WcosIcSZ6M9VeJaBPsptRLwDDPujPAero8bptIOliK45Thfnx3KFQmGwvo/DtBWh/TxtVxoLILz
	cOhjPaHOZ095A4LhJBLp5jy3V54Fci8mMvJFGMcR220G5MfyU+SwrhChiOQm/xmf0NJ32WcNSdc
	vjoAZuC/XI6JenUI2rcE+QsrhpUieGaQJpTbLaHTM6efXxI/WfPoBRFCLuekz4OvsUXA1E6QKFG
	mbyiRr9q1BvxXGg==
X-Received: by 2002:a05:6214:328c:b0:910:4402:f410 with SMTP id
 6a1803df08f44-91212091c4bmr186100076d6.13.1789234528323; Sat, 12 Sep 2026
 10:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com> <20260910192314.209ecb01@kernel.org>
In-Reply-To: <20260910192314.209ecb01@kernel.org>
From: tmbates12 <tmbates12@gmail.com>
Date: Sat, 12 Sep 2026 13:35:16 -0400
X-Gm-Features: AcwNN1VO8FHui11gOOlIP1du45BV5WIWfuLdWO8vIfsBmwBzL9VU8kIrvC85IlM
Message-ID: <CAC4WM+zvK1zFuPfS5WnzuDR3b_DRX==x_S=Gg7LSLgZb9=33Ng@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] netlink: fix ynl spec tooling robustness bugs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Sep 2026 22:23:14 -0700 Jakub Kicinski wrote:
> Why are you doing this? What's your intended use?
> YNL extensions for classic families are unlikely to be accepted.
> It's definitely not a goal for us to backfill all the ancient baggage.

As part of work I've been doing on switchdev based ethernet switches
for configuration and state monitoring, I'd like to avoid having to rely
on shelling out to iproute2 to query bridge VLAN devices.
Parsing its output is fine as it can emit structured JSON
output, but as bridge(8) always resolves the ifindex to its interface
name, additional lookups are required in order to find the ifindex.

Is a bridge VLAN spec something you would consider at all, or should
I drop the idea before writing it up?

> So you know that the Fixes tags are pointless and yet you add them?
> Please, if it's not a bug that needs to go to LTS it should not have
> a Fixes tag :/

Understood, I will drop the Fixes: tags.

I will be dropping patches 2/4 and 3/4 based on your comments on each.
I'll drop 4/4 as well, since I'm not planning to submit the OVS spec
work it would need to go with.


On Thu, Sep 10, 2026 at 10:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 08 Sep 2026 19:45:06 -0400 Taylor Bates wrote:
> > This series is intended to address several robustness bugs found in the=
 ynl
> > tooling and the netlink-raw YAML specification.
> >
> > These issues were found while writing a netlink-raw spec for the Bridge
> > VLAN family. However each stands independently of that work, and fixes
> > bugs in the parser that can be reproduced against the existing spec
> > definitions.
>
> Why are you doing this? What's your intended use?
> YNL extensions for classic families are unlikely to be accepted.
> It's definitely not a goal for us to backfill all the ancient baggage.
>
> > The patches in this series carry Fixes tags, but are all in developer
> > tooling and have no effect on the running kernel. That is why they have
> > been targeted at net-next rather than net.
>
> So you know that the Fixes tags are pointless and yet you add them?
> Please, if it's not a bug that needs to go to LTS it should not have
> a Fixes tag :/
