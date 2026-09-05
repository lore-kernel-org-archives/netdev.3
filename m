Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB97E333439
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788639793; cv=none; b=fS0n2Q7q2ICXX+3HQ+VVtoVVR7K8t/Bb471BMvaj4dY8lcNWiaoz10Zi+RrfhY0KlSdV6PHofHWTGq+mtgSQI+TO0t7d7ncCGEmDRSzf4LIASTzs4zrOQiYnubuNBC4T22VPE6GWK3lz9JGwZ6VCgfQMjjWo506ALCFqHhA3qak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788639793; c=relaxed/simple;
	bh=DNDbd91qqA1K3hMPzgERbnV6Pn4oinAjsYTPHQlM/n0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GE25ayPfVxV08t+4VA+FuIzbDFj2EHngUTr56WJK0nu2lT4zrG7WS9uYvAp4LUogmzYC/nWs/85qCNg1o0N9wjqKOrICZ6edCCbA3qYs+Odunkk09rSQnTsAMOwsZhb7f1b4vBLHVOro8ytdEfHWVX+ydRejbKLh4LXyPbOQ8pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT7cWf+E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT7cWf+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927F01F00AC4
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 20:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788639791;
	bh=DNDbd91qqA1K3hMPzgERbnV6Pn4oinAjsYTPHQlM/n0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RT7cWf+Etk4WgX5HcrynlFoJVU4QhMy6gWOG0NsXFIFILPo8XE4mUqoU4u7SCstO8
	 uEriXDcHi9v+GZJI9b5zs8yua9F1eMBD4AlZxZe8NxbGQrkO3Xc6H4LOTNGI+Vf5fF
	 oYW5qqHykTVu5c4pZTcgdsLhirK/5DE1RD0C2pvnVI0TRuicjoBBt4fgKIaQ+jsQcA
	 T0q5KzaxCaHeOqMW2Gu24gazpfpOQzZ1H1Am1gIv0spMFUR/JSmcspMyBY5OkDxQ7o
	 fr1GY4imREjYYIo/lBOxZs/kpboVc2D8M1V5W0LaZwzqYJFZHVDGam583xS/S1XMzi
	 4tpWfzUBcN9EA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b4af730f8aso2398485e87.1
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 13:23:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxVqQ4a5kZ5UP3BJl2CzPj7CuGfiVbro3wGGj80GOF9GH9eNKcZo8knA9az8QlnXIy8ZKY7iRo=@vger.kernel.org
X-Gm-Message-State: AFuF++mx7kxGwhYRwVSg2bolJTIE0J3I7RpFcKFR/13YwX0dcaO7b9vr
	Grx86203p91nIapRI0CcmbaWsHlxuX1NBZYBVWcf/93EOnJbm6MSvztVojRJGpKjaC5Aj/dEfks
	/o34KDN8eMAAQZtRPE5sF+Va3+5ywy/o=
X-Received: by 2002:a05:6512:39d0:b0:5b6:183c:5c9d with SMTP id
 2adb3069b0e04-5b6183c5e63mr2060524e87.59.1788639790281; Sat, 05 Sep 2026
 13:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905134131.66680-1-hppiscas@163.com>
In-Reply-To: <20260905134131.66680-1-hppiscas@163.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 22:22:58 +0200
X-Gmail-Original-Message-ID: <CAD++jLky_xX28S3aw88wvZy2gv77-6AaOzK9vG+5YnmV91ErMg@mail.gmail.com>
X-Gm-Features: AcwNN1Uu2OyjV_h0PksTSTYNqQxzAZUaF8VKTqiR_G0Mg84ZDEQ0kUOzYT_17OA
Message-ID: <CAD++jLky_xX28S3aw88wvZy2gv77-6AaOzK9vG+5YnmV91ErMg@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: mv88e6060: Publish the OF module alias
To: "hpp.iscas" <hppiscas@163.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 3:42=E2=80=AFPM hpp.iscas <hppiscas@163.com> wrote:

> The MV88E6060 MDIO driver uses mv88e6060_of_match for OF matching.
> The MDIO bus emits an OF modalias for such devices, but the module
> only provides the legacy platform:mv88e6060 alias.
>
> Publish the OF match table and retain the legacy alias.
>
> Fixes: 277617603c02 ("net: dsa: mv88e6060: Support probing as an mdio dev=
ice")
> Signed-off-by: hpp.iscas <hppiscas@163.com>

Fair enough.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
