Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF84DD6CD;
	Thu, 22 Jan 2026 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097109; cv=none; b=FLAvUW2bqWEuX0ZFDDrkEbbdN2XsRM8gZJbIVuzvxSgOZlBnHPscF/9iPYzZfZKAGoJ4lBHjyhHTtLWpp1hHV5DJwUsrUPt22pixi7OW0CZvvRY36Hlq8WxquRHig0sbQUpkDmPWpFSHAewj2zIsPRYjr16dujEKZ3tX2dqCY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097109; c=relaxed/simple;
	bh=7h2XkfgOdUz5g5zmlNRx7nx1fk0QWfhgAuwkgPE8WuI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FB3cLcVEbtm4K/K/pjoBwj35zxCiQ4ycs71Kc5r/gKGytbC9A6liA+rpuDPFLUN8s9ZWfdcrm1QlHLKJgRRhL2TjFYOYp/xjY8LC99z19FueUdWU5OQiTEcnvVcgXrNkcWtPegYca9YdvlWp4GDcGgmbHulSiC1Pnysww72CiYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=hCilvyYC; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="hCilvyYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769097096; x=1769356296;
	bh=7h2XkfgOdUz5g5zmlNRx7nx1fk0QWfhgAuwkgPE8WuI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hCilvyYC9v0QWNSLx6E+tLoxvBPrshyX9eypU+apGKP6t8hBCdht3HGpZ5wf3FXm4
	 Wjgh5gi9ppeurV3GhaGyKsyOO6BdevOV37w3Xq9IQF9SndYhKvwh254e3RwRUiOrWp
	 LMdYFWMvGAWjktdatXVNcu5Lozzc78B3Hor7LJCth1kic9T+xeq29m8y8gFpKCv+SS
	 MoW2xODXiJwaSOf+rFR/HLMRZO2L7K5I6uYyfN22H3EykT1SUe/rEyYKNn1S+FdIeR
	 +sir0pmLjVuNV3wh/Ag3I16ae9gIf4aie1s1kW+0SqvD9WEqcu2bYBXDUPVfbU+vmQ
	 LW7dhhvhGZcJg==
Date: Thu, 22 Jan 2026 15:51:30 +0000
To: Victor Nogueira <victor@mojatatu.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 2/7] net/sched: act_gate: add RCU support for parameter update
Message-ID: <P2V-v-jfjb25y-nEIwKOu8x8N-xaC9avCsuZvL5B0RZRluny9zrE9htYN3bWaBX-XLb14bNJ0D-HaqgvKuk46IxtMaJ02-2_nv2ObmnAjBk=@1g4.org>
In-Reply-To: <e58a29bc-3512-47ce-80cd-6c96a879c9cc@mojatatu.com>
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-3-p@1g4.org> <e58a29bc-3512-47ce-80cd-6c96a879c9cc@mojatatu.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 3f0d1de9dfba595177adaba287b0053bec868b74
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yes, wanted to show logical flow in this iteration.=20

Thanks
Paul




On Wednesday, January 21st, 2026 at 1:42 PM, Victor Nogueira <victor@mojata=
tu.com> wrote:

>=20
>=20
> On 21/01/2026 10:20, Paul Moses wrote:
>=20
> > Make gact->param RCU-protected and reclaim old params via call_rcu(). T=
his
> > follows the pattern used by other actions: act_pedit swaps params with
> > rcu_replace_pointer() and defers free via call_rcu() (commit 52cf89f78c=
01bf),
> > act_connmark uses rcu_replace_pointer() under tcf_lock (commit 288864ef=
fe3388),
> > and act_tunnel_key does the same under lockdep (commit 445d3749315f34).
> >=20
> > Dump readers in act_ct and act_pedit already use rcu_read_lock() +
> > rcu_dereference() (commits 554e66bad84ce4 and 9d096746572616), so act_g=
ate
> > must keep old params alive past updates as well.
> > [...]
>=20
>=20
> I think you could've transformed patches 2, 3, 4 into a single patch.
> Since all of them are RCU-related changes and they sometimes overwrite
> each other.
