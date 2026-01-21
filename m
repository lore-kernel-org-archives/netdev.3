Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D31F4949E9;
	Wed, 21 Jan 2026 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004071; cv=none; b=Z/oDQtOaVOyi/5SB964a+sVweNzaYAupuvGrMLupCCnWmSr9a9vwQqO50seNDgtLGfGNresNxTWH4ld0xL1SLF+sOdZuII7IrtgvOJGxVQKnlYTOaHJ31nMyGJLzWl3UyK2cs09IyJmHN95mtdP6RvgdT/PkJFSYr9MCZMNsAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004071; c=relaxed/simple;
	bh=htvZ0BFtdntICwpCIHDXiKGuo9UWkej1fagGs3Fm4G0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqIq8cFeU7dBCW6xSG/pSr9xkODgtuFFn4e6Pee5+Q/JiaqNRSpo4bTdFp97Sbzh0Ga7LBwlWhe7JwhbNf/tqFHRggfiEwPOaDhtb5v8VMHFjJKvrX+gVELqfGRE8hqlIGK4Rj750ygrbsXmtdm3zEhcp+moPrzgzMUg3QNvf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=wcSgHLxJ; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="wcSgHLxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769004065; x=1769263265;
	bh=htvZ0BFtdntICwpCIHDXiKGuo9UWkej1fagGs3Fm4G0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=wcSgHLxJSMc4E4GwCvZ/I20W3voC4J8A6Sc6zym4lWWyvpd95tANmf3/uez401BYk
	 wMfIBGiLfd3g77zCD9n9Ka7oAVaOecEYvVB4oFc6N2EVXCssuRRNNd9y9SksOmay74
	 rPk+ionuH75aTA0MIrdQ5BT30hvH9RYRQPPSKpMaZ4/OhP6UUNmtvAj24r27VphhUg
	 qT/8WsbcswB5oC94GQyevJmcPwRoculIc8CdAxKFKY4LJLme3zjApELVjcu7OkkmVT
	 +TXehdlmVcAIbIHD77xH71xwdHrWyio4nTZ5jx5KkBHLCetp2M3oFMV956CNSpBzHT
	 t7xKYy9NXgueg==
Date: Wed, 21 Jan 2026 14:01:01 +0000
To: Eric Dumazet <edumazet@google.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/7] net/sched: act_gate: zero-initialize netlink dump struct
Message-ID: <YAOV0f1EtmF5tiEGoQMdsnQAKJSrqcg3h9hqnxDdba8MmAprjNHfcDBKselH1vYNZLb672n_zDJZpgjkVn0nHDS0Jh7BKQrh0uGwJYp2hEk=@1g4.org>
In-Reply-To: <CANn89iK_VqOThsWX2b-JwvF8suBVmKEmMm9D9SeZJBamDwfPog@mail.gmail.com>
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-2-p@1g4.org> <CANn89i+8_ZDxVGwQmo_44iCRs5Wexwxy1Wfhw4WmYg3qA7_t1A@mail.gmail.com> <BSn2a6IWtM_DnDrcd-qDBm8cXAwXPo3xj1l4Eu4SWy3BS2UW8Aw7-gXW6uo_DaCipnvmSxgDeGEQrnZ-pjqRKSOPPUW0usVN8M1lp1J-soM=@1g4.org> <CANn89iK_VqOThsWX2b-JwvF8suBVmKEmMm9D9SeZJBamDwfPog@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 29fab967485f950b33fe952df9c87630554f7bf2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

padding? why does fzero-init-padding-bits exist?




On Wednesday, January 21st, 2026 at 7:48 AM, Eric Dumazet <edumazet@google.=
com> wrote:

>=20
>=20
> On Wed, Jan 21, 2026 at 2:39=E2=80=AFPM Paul Moses p@1g4.org wrote:
>=20
> > Yes, it's not proven so you might be right, I knew it was 4 bytes at be=
st. We can do next or toss it, I don't feel strongly either way.
>=20
>=20
> These bytes are cleared by C compilers.
>=20
> https://en.cppreference.com/w/c/language/struct_initialization.html
>=20
> Only holes might be left uninitialized.
>=20
> > On Wednesday, January 21st, 2026 at 7:25 AM, Eric Dumazet edumazet@goog=
le.com wrote:
> >=20
> > > On Wed, Jan 21, 2026 at 2:20=E2=80=AFPM Paul Moses p@1g4.org wrote:
> > >=20
> > > > Zero-initialize the dump struct before selective assignment to avoi=
d
> > > > leaking stack padding in netlink replies. This matches other action=
s
> > > > (e.g. act_connmark) that zero-init their dump structs.
> > > >=20
> > > > Fixes: a51c328df310 ("net: qos: introduce a gate control flow actio=
n")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Paul Moses p@1g4.org
> > > > ---
> > >=20
> > > I do not see a bug to fix, current code is fine.
> > >=20
> > > act_connmark problem was that "struct tc_connmark" had a 16bit hole.
> > >=20
> > > No such issue for struct tc_gate.
