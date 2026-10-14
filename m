Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB729992A
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791939196; cv=none; b=uaxyk3c1K51FCy2jC4qk8h8ryhUI5sF7XBjAYrhFjuVGW7S3qlhl3u32hqhG2lbORox9r5yo/bsugGk8XpsAvOx6U94k2eVZxYgKZsr1oS52OFKuu4Xgea/E9CDkE7MsGN9OCGmmBR6t6oV3SpFHwsAB6B/j0F3uV1J/I6VnZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791939196; c=relaxed/simple;
	bh=co20+7mT+3UzeD19Nig91kgThQSR9/gwYi+GKbAoh8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYxQbonQ1HR14enhF/nkerZi60pLbFpOnthN3sjKvLoe95xelvpb/T1LPv7qZ8qduXT//5zb7qI3l+fq6O0LoGG8O8EgR4Ya+WxKPZgqcmZRm/DDbMD7MlfZaj5X6Y9ULHQd2vP7gOAQP/e6IOjNcVnn1/dNafdorP/v/mn9iS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8q3o6Pk; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8q3o6Pk"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcf18ddc95so2710686e87.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791939193; x=1792543993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mo/Fq7S+9OWSrgqvuWM4SxxT74GAgR1Se3IWFDwNrRE=;
        b=V8q3o6PktKFZQPTKmPVGvNKNAZR0+wp40ZuhgsXVEDEmrZ0hIOfs9pzOIiW7KJaKUE
         1vZ6trXK4Yc38FABYmnN/4cjXRNn37i/hvXradtIeEmStYTjE84nbs6zlR5mv0z/Z26g
         JtJsovS1viI4l4llpJHmjasAF3M4QXvhxSFxfwvbNaQEUXRpJQ9p+OjWPZ66P8CELY5J
         UspFMlaMroEJiyfmF4qcW4KI4Ff/W5Xubrv23tLqn3K1A6AQFle+e1V1nSzTt11gKK7Y
         NSAHrhWjg7Ds26xYTyB0yPARyeSSf1ewtuUnER4usYE72g2rblg9gqZtbTo9bXFuxWkf
         ksQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791939193; x=1792543993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mo/Fq7S+9OWSrgqvuWM4SxxT74GAgR1Se3IWFDwNrRE=;
        b=IaWacww7hH8GVtaOL/AhnXUlwI5+45jaEOjVOt8QIIdbUdj0r783CmpbVfrT+K2Zhc
         AOoz3Hj+y5SC6y8F/tqlQLBV5uBDR2hXArP5KLb0DHCY/uwpBC8IUtIX+bhw6wyQUycc
         LJ3RNDnP2EOieDuJBJ3lUK/GSRp/RD0c6YyaCe6/IvKH4nszAo+AjJ/KuFjAcy2sD0tQ
         sTJyAVolFxAKqXPi5lnDF7bfa4Q6KP1apc0hJTaK2WINnNTf7Uho4LE6/Bk+R93Fi0PN
         8580WGWtZkSN8WOY/Dm1LeHIs4O68sbtPWo305nJOGtNaMoWRVul/WcKMvGdX+eRtCAB
         cLYQ==
X-Gm-Message-State: AFq9FYLSR7acxYtTelUfDOtoGOpc+ZzoTSCCRdm3EAVlCzf4ncmUPmzn
	hLFEEDv72G1h3UF4F6qCRtz1/3HJfsAKsdIIhy1eysMMq+Fb3iklf6uQzbvibfLheXY=
X-Gm-Gg: AYBFou1oWyE/JXAO72uM1STLHZ5+nze3UHECac/E8B8sPf7g2aiPlqfeYu9wvPvE4Yb
	663OpmqMVvdgDfkY4CNSUtLeTUo8zNk0XTG+8On5kBU0iK6TVnhJeuI0VzuqtcKGdaL5jb61rBY
	aLZbDV60YrscQ6RBk2l25GTXkpHJJJfZAZJj5hxML0XY5b/OqaXGnvBbYr1aLg9eLB6B2VZHMPD
	LgRBOCT585dxkOv87jB6R2IslaFy1pYZVs1l51zMYWazYYtYmvpnLw2qswzAI4v+mL4qORXDuvA
	kwQwDq86o/pL8Pr4Hz86Nas7lcfJEyeJwITqREgYpgwAzo0RgBhL86z3pQpj5TlkU2Q5zGzkX+5
	QzL/UDBxJm4sE4rcQx/rJY+kGrGMyEXK31rOjH0seMFFxH5jkYhgvPuqysPdZfAyWiSrCXBZHmE
	5gAleuC4oCarFwHcuvp6VeER5UINbAd0Sun9n4FghleXsWKpZhddmFOkWhp3IrR6SkMamdA1YK2
	r50Lb/57Ppni/mlxaMiCQim7vGEJSpy8ScJXLoxb9Enhv0mUEcYXQ7EVPPlea9+
X-Received: by 2002:a05:6512:158d:b0:5bc:bbd0:7a7f with SMTP id 2adb3069b0e04-5bcde8db29cmr4733785e87.67.1791939193220;
        Tue, 13 Oct 2026 17:53:13 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([95.139.131.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be33d70328sm272609e87.23.2026.10.13.17.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 17:53:11 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Mazin Al Haddad <mazin@getstate.dev>,
	Matthias May <matthias.may@westermo.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
Date: Wed, 14 Oct 2026 03:53:07 +0300
Message-ID: <20261014005308.1606362-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179176844482.434549.5708346025808067831@kernel.org>
References: <20261008012554.202925-1-littlesmilingcloud@gmail.com> <179176844482.434549.5708346025808067831@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before I send a v7, I would like guidance on how much of this to fix in
net, because the one-line syzbot bug keeps pulling in pre-existing
problems on the ip6gre/ip6erspan transmit path, and each attempt to
cover them has drawn a new report.

The bug itself is narrow: for a VLAN-typed skb->protocol,
pskb_inet_may_pull() checks the length from skb->protocol while the code
that follows parses through the tags, so the inner header is read
without being pulled. Pulling it for that case closes the report.

What makes it larger is that the inner protocol is worked out three
times on the way out, each from a different base:

  - the length check, from skb->data;
  - the ipvX dispatch, from skb->mac_len via skb_protocol();
  - the inherited hop limit in ip6_tnl_xmit(), from the MAC header,
    after the GRE and ERSPAN headers are pushed (b09ab9c92e50).

As long as these three derive the protocol independently, a frame whose
bases disagree breaks one of the pairs: skb->data not at the MAC header
(a frame decoded by act_ife on egress), a tag not at the usual offset
(a DSA conduit's in-band tag), or no MAC header at all (L3 ip6gre). A
patch that lines up one pair leaves another exposed; the ERSPAN COS,
which a separate patch takes from the frame, is a fourth reader with its
own base.

The robust shape I see is to classify the payload once at
ndo_start_xmit and pass the result into ip6_tnl_xmit(), instead of
re-deriving it after the push. That removes the post-push walk and the
cross-file precondition behind it, but it changes the signature of the
exported ip6_tnl_xmit().

So, two questions:

  - for the net/stable fix of the syzbot report, would you prefer the
    minimal change (pull the inner header for a VLAN skb->protocol so
    the length check matches the existing parse, and leave the
    re-parse, the ERSPAN COS and the DSA/act_ife cases as separate
    net-next work), or the fuller rework now?
  - is changing the exported ip6_tnl_xmit() signature acceptable in
    net, or should anything touching it wait for net-next?

I have the measurements for the regression and for the pre-existing
reads and can post either form quickly once the scope is clear.

Thanks,
Anton Danilov

pw-bot: cr
