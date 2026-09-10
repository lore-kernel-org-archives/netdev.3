Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CBC48664A;
	Thu, 10 Sep 2026 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052734; cv=none; b=s/PyXF7clVLlJ6REMZFzPjoxYv13pM4RIfkYMEJ594kNqd7EwmEnZj2xpc42Pw/1PZEQtF3mXGZ+4klVdfAuLZXfCHVoZhlSQCZEj2M68GpnpaO3kgIfAm0+jxU1drKk+c2VIhkpsBoqoq8iY9tjwwHSQq6v/+a+lYdIShs4XRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052734; c=relaxed/simple;
	bh=KSGVFgbz4FiNfm2W64tNSzPv0w5g8mNdfpyyzso4DM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5XlrHafWdwj9hqSjvo4Bdf7SRPwckAOG5beFt0oTYVosuouHgIrPiSVrLF2RUpf+aHuBMBnEKL5afE4fCXNzs19OzE5n4rF4O1ZjfO6Ejlxg48B2pqak1RWikyRqKqzsiZZUnfODxksiTVlAN4WPbvOumeGNspOgbkDsWNUR+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqwLkWDs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqwLkWDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1881F000FF;
	Thu, 10 Sep 2026 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052726;
	bh=Z5dbFYUCzwYKidlfc5UFRq99kcGzfase8a9ZR1yTgnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GqwLkWDs0Wfwl3H/6q7FSNuOsAEaYAkDe1q1wzuoURmxkPlbNq68PHzFur5pcIKIG
	 zRocxik1+iccHe6GL72GgAxMU2Uhi7uvaLobdGWsSiZLedFrRAiMZqTlxwnf09j7KA
	 EVk++tgottvu5pHht2TqUbgC/+n9f7QFazofCyuW0xubzHUnhTQuBDsWbXPurHr63v
	 E/ep22sSnG8qdZcI+7QkFySdfVnFaAnx8wl9AahJaDsMY7vvjEF+jWBDht45+ZYd0m
	 Fy+iplQC+YXrY+ZFi13Cho4vWcMyiyEkSIf9YXXRT2pU1X3HBvEo1cE9PB37WnUjX3
	 zCJtdl0g586cA==
Date: Thu, 10 Sep 2026 08:05:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: sinyavin@gmail.com, stephan@gerhold.net, stephan.gerhold@linaro.org,
 loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: wwan: qcom_bam_dmux: account network
 packets
Message-ID: <20260910080525.35eee3f4@kernel.org>
In-Reply-To: <178899001185.219967.6678486297703743680@kernel.org>
References: <20260904183737.2994139-1-sinyavin@gmail.com>
	<178899001185.219967.6678486297703743680@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 09 Sep 2026 21:40:11 +0000 netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>=20
> - [Medium] In `bam_dmux_netdev_start_xmit()` the new
>   `dev_sw_netstats_tx_add(netdev, 1, len)`=E2=80=A6

AI is right, the typical flow is to account packets and bytes
on completion of the transfer rather than initiation.

Also please drop the Fixes tag and re-target at net-next,
this is not a fix, as important as stats are.
