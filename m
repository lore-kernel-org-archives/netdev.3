Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58B3374E67
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791325387; cv=none; b=eCWrdbeADnzJGLe3/cICdRNbvYAYYiu/BYy4ENgN4La9ZVhl/htmW0y7y/3l48NBg49QcOBwGuTf+LomgYo19xnHIIQlYJoldG7rctnqZg9ofFkjewOpiJgzUDg9JihPvqQvzd7A1n4JZvT1svmrv6APh3quus7cN7VMmDNJzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791325387; c=relaxed/simple;
	bh=bFnG8yZ5td1q8WJAjS+Zi9PC6iLvCquLMDul11glZL0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4Sofs0906X1OqhtW/v21aiunnPlycnXwOEnFaoL1T4euO/ffIbfuwdk64Zs229JjJFB8YqNAsAXdoXS9fo841pA9/OfEpXFCOFBP1RxsrRLJjCUPkKx41ZLDFJqOLog/auLy7Ga8SbGaVP5q7LW1//1O15tP0MUR3kow2LAGQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=LTRc49W0; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="LTRc49W0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1791325376; x=1791584576;
	bh=bFnG8yZ5td1q8WJAjS+Zi9PC6iLvCquLMDul11glZL0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LTRc49W0YJYKrc2WSfI67cLCTOJN+avwqszEqShwSskorK2gR9eMZw0opDyyEzDtS
	 wIoQwuP7RUX7cvD9y1wfX3Va9WPugRrnNTz3p+/XmXL/iJv6GLLWtDQvS5O/DNWSkN
	 si5goAYkRPQ6vrnJG03V68GMKoS3m9SXkvse9L6jCBMNUaaqvldby3+b0h3RXqZZH6
	 O32ArpGhJ8O6/CxHKHz63PehtQtZvcSGRUs6djwIMDGrCx8l8DFr+IhlVQ7Aw4vZlP
	 gxr5tHmqRmJA9HMewBhQdlPQNF8Ow1yTtc+C9AydVjt5k2BADbnWxLtaEhOrtzFzLb
	 sCn70j4BZ/GCA==
Date: Tue, 06 Oct 2026 22:22:51 +0000
To: Joe Damato <joe@dama.to>
From: anmory <anmory@protonmail.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com, pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC net v4 0/4] bnxt_en: Make RING FREE more robust
Message-ID: <eXJey19uF3K9zJxeuqly_VAGq8y6AiyexdzLKxv22b7m1Av025Dp-w9cGWDelfFwBqcD-wtUIjtz7p1ZYKwlKeyzd3vHHpdY7U6FGPIrK7M=@protonmail.com>
In-Reply-To: <asVYjdbZGMAEck2t@devvm20253.cco0.facebook.com>
References: <VyyrJwrwBZEIGezDRJP8QPxbcsGROaxnmohLCnzNQY6sX5CEt0BK3AEC_0MGBx6OxGf4H5UG_xQcqgtAonwmXLdZ5Bd3INWMsof8Oj6ruqg=@protonmail.com> <asVYjdbZGMAEck2t@devvm20253.cco0.facebook.com>
Feedback-ID: 107053670:user:proton
X-Pm-Message-ID: 2a1d023a01d49c8fa5c2c0f5463d72d48a8186d3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Joe,
one important detail I omitted from my previous mail: the affected eth1 int=
erface is an 802.1Q trunk with multiple VLAN subinterfaces.
We also use Keepalived VRRP with use_vmac, so virtual MAC interfaces are la=
yered on the VLAN interfaces. Traffic is routed/forwarded through the host =
and uses conntrack/SNAT before leaving through another physical interface.
We are not deliberately toggling VLAN offload during the test. The reproduc=
tion so far is simply to boot Debian 6.12.111-1 with this normal network co=
nfiguration and workload. On one host it reproduced after about 20 minutes;=
 on another it reproduced almost immediately. We have also seen a previous =
occurrence after several hours, so we do not yet have a deterministic packe=
t-level trigger.
Given the VLAN configuration, Eric's patch looks especially relevant. I'll =
test 6.12.111 with that patch first as you suggested and report whether the=
 failure still reproduces.
Thanks, R.

-------- Original Message --------
On Tuesday, 10/06/26 at 22:22 Joe Damato <joe@dama.to> wrote:
On Tue, Oct 06, 2026 at 04:43:42PM +0000, anmory wrote:
> Hi Joe,
>
> we appear to be hitting a very similar issue to the one described in
> this RFC on two Broadcom BCM57504 systems.
>
> One detail that may be particularly relevant is the ordering in our
> reproductions: on both systems the AMD-Vi IO_PAGE_FAULT occurs before
> the NETDEV WATCHDOG / TX timeout.
>
> We originally encountered the problem after updating from Debian
> 6.12.107-1 to 6.12.111-1.

BTW there was recently this patch [1] proposed by Eric which helps prevent
a bug Stefan reported [2].

I am not sure whether the bug you are hitting is Eric's bug or the bug I am
chasing.

Other than explaining how you repro'd the issue, if you want to test Eric's
patch you could apply his patch to v6.12.111 and see if the issue still
occurs.

If it stops, it's probably the bug Eric fixed and not the one I'm chasing :=
)
but if it continues, it could be what I've been looking for and I'd really
want to know how you reproduced it, please.

[1]: https://lore.kernel.org/netdev/20261006042153.199444-1-edumazet@kernel=
.org/
[2]: https://lore.kernel.org/netdev/20261004122616.56714cbd@nargothrond/

