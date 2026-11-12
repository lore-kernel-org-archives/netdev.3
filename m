Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503968;
	b=hS+Jc28ncA2vn3gXAX68LTOxkmbPs+b4EqWVFpLwkqid4zGs+pSywfmXhNhice9YQrA0
	 X2J7njSefy8od3KstqGR5qYPzA1VxYc/FKaiCHdUQ8nqkUwQI09JIen+r9EPHUKHJn0TB
	 SlhqkD80ebb7/rWtDmmf82P3nMCvqGOL0xfBXRbtplEFUp50FQ3zBN3o/kuQ3sBT3jzEd
	 lUzj3iuEeDEN6MpiGMGQh099PCvqkBD1K7wxraW1mEB3Fh1eqEWVIMmsTYSVY8PoJBOVd
	 3Q1T84lEvP3bt0+uX9Ea4EMxVkeaVBsaFtAxeRbmYOG8azCUqE6ywhaZ91TG6JS3KpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503968;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=P2Gig9OwHOUYlTaddi8niRaoitTx2nbDWiMlCl6hlN4=;
	b=hzO1jSvr9tCWWimmhMTolnxDGGmzyWVE/6vRBevJKUyfy7mpVUl/E7Xz4eoBpwfRtgWM
	 HL0UnwjYbnSupRkwWa6auHd0eK+vIYe0jsBPlVYB0jIn9upbTuuUSqbwQbmD8pmJQ0Y6g
	 kEpiBhu9ZgDu7nCH4HscoeIcVD1tOVy4euE5XtnagkxMCw/eRw4/E8RI74NgrNmG/vAsc
	 PEW7Dkg6DZ08BHikWoZ1z8NBXmNP455/kS45K+wjvDQsATwToK12LNKEOquQaqkgfuWFo
	 WU0BQK0h3Vj5r4bRsnWMBwdB7K8sId7CmQ1yr14PRY5lzU+WMKNrwZyjkoJU8wM3tYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHWUJoGu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E488606A323;
	Thu, 12 Nov 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHWUJoGu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4731F000C4;
	Thu, 12 Nov 2026 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503968;
	bh=P2Gig9OwHOUYlTaddi8niRaoitTx2nbDWiMlCl6hlN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bHWUJoGu4MamQmp5hL54s4ZDiZmxuyKYYIvP3+GekkIAXszDY+GPmrg6H+3I5Gcht
	 Ce85vHCPUStM0nFvviQQBeutEg5hmBs//vQlIZuLdw/I6Eg27ntuM2xIwiifnotTDp
	 jjfLaYa9q51nWO+M/bsvXDRqzqV5hckAt+crCoBPRZJiDCx0FlKIcRqyJTSCQHlODg
	 oLcizbc5e/5LyC0qmnFI7Zg3SOrEZCiX2s7382GjtakVBdKCpxcWkeq7yMFt4s6L9Z
	 vMKHY79qpc2mnmBfCZRkTFLTWZAnzyH3FlVaiHus/xEOMsqzT4/N2Ip7zBBbyAQbzH
	 mTs4IEOU19CjA==
Date: Thu, 12 Nov 2026 09:19:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>, Andrew
 Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net v4 7/8] net: dsa: b53: harden mirror register
 programming
Message-ID: <20261112091927.7773f0a3@kernel.org>
In-Reply-To: <20261110035018.2169370-8-florian.fainelli@broadcom.com>
References: <20261110035018.2169370-1-florian.fainelli@broadcom.com>
	<20261110035018.2169370-8-florian.fainelli@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Nov 2026 19:50:17 -0800 Florian Fainelli wrote:
> --- a/drivers/net/dsa/b53/b53_priv.h
> +++ b/drivers/net/dsa/b53/b53_priv.h
> @@ -548,6 +548,7 @@ int b53_mdb_add(struct dsa_switch *ds, int port,
>  int b53_mdb_del(struct dsa_switch *ds, int port,
>  		const struct switchdev_obj_port_mdb *mdb,
>  		struct dsa_db db);
> +int b53_mirror_init(struct dsa_switch *ds);

this needs to go to patch 6, otherwise there's a transient:

drivers/net/dsa/b53/b53_common.c:2607:5: warning: no previous prototype for function 'b53_mirror_init' [-Wmissing-prototypes]
 2607 | int b53_mirror_init(struct dsa_switch *ds)
      |     ^
-- 
pw-bot: cr
