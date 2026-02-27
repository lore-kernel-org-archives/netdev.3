Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D7B3ECBCB;
	Fri, 27 Feb 2026 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194068; cv=none; b=VqlOHVKf4DSm4KYSgj4GLKo07yJfwaoEX9RxyupVwY1luhu2R44I8JJwsGEGX3nQNtZ5S2kk7hZcEqKVWfgRJarmz/H0KRyWwbUzlxvesrAPmwwYVUNFhxce/F8iPdf0q1uexq3wjLHZXF8I9DH+0hQjs0dVz6CnI25mY4JXfeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194068; c=relaxed/simple;
	bh=jsxDa2cjEDGqNh6pk9vrCNSPq95Oixrv/Y//SByYdG8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcBlZpopC4czdoFGYnV09UP8xBqUB7fAxevwpyVaUBQLGUTEuvhqJpS8OwkPkzuC52mN+j6TSfkMZNo74QkfaymaRg7HOKIwQ83+fpQnlBtujW50It6rBA57ARFOCkaq0UKImxLyvYqgw1fIRqlTNVlPMDFiIIn8ZMuBWqciIFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=WbTjrk/y; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="WbTjrk/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1772194056; x=1772453256;
	bh=jsxDa2cjEDGqNh6pk9vrCNSPq95Oixrv/Y//SByYdG8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WbTjrk/y+wxh3Gg85XeaF//KDSYmd9Sh09LP4btYjFMghKHCYXd0BwZYibqom2wLT
	 JdQhgLRll3OvnhVHhKdnfphAwQw7hhr80hzBxFCeONK7kAzUToItnhrmo/lSFmVTMU
	 prCVteE3pKFnUqrCGfdEcxpuOBAhS7rGwipevec4A/LJq9EsUdW6EJJtrXHmdhSDSW
	 apHgRoAIwCSJ+FSyEa0AyNx0NZ6voiWAqf8OiD4G/H7dA5ReWM7bBopH2fbG/94ODb
	 xRgPcLiOXqZVXUPrLYIFtmMiUeqGGpw4rICXuqNxuEFhQTcZqSh9iQVMvXzW5j+478
	 +lnSqh2QxKVjg==
Date: Fri, 27 Feb 2026 12:07:30 +0000
To: Vladimir Oltean <vladimir.oltean@nxp.com>
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net v8 1/1] net/sched: act_gate: snapshot parameters with RCU on replace
Message-ID: <px_b8_2gC-ZLFXok9C1Cjh3OAR-3fh7q3tMvB6ddv9V_IR2UOe0ANtPfCbh_s3xFARel2DT6Yg5cVJe3LPmgLpgDgGfqTrJuPa0OADyxdts=@1g4.org>
In-Reply-To: <20260227013151.qaw4hvb4fyt5roeq@skbuf>
References: <20260223150512.2251594-1-p@1g4.org> <20260223150512.2251594-2-p@1g4.org> <CAM0EoMmr0SUf7U3CTqd=MSYX=D60zYOfBS-L=GJOsWB-cxZHcg@mail.gmail.com> <20260227013151.qaw4hvb4fyt5roeq@skbuf>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 234b2a4dd7c0867d8a0afb78ee285997c20d982a
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> The ocelot/felix driver doesn't offload standalone actions (TC_SETUP_ACT)=
 so it
> doesn't notice changes made to the action using the "tc action" command.
>=20
> If I make changes to the "tc gate" action parameters using "tc filter rep=
lace ...",
> then I trigger the "The stream is added on this port" extack error in the=
 offload
> driver, which seems to not have been written to handle parameter changes =
very well.

Thanks for testing. Just to confirm: unpatched kernel returns the same erro=
r?

Thanks
Paul



