Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7721FC0;
	Sat, 19 Sep 2026 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789855493; cv=none; b=qnOagCRssftrEgwkAIdhN83w2ns2Nl/a4zkXCIa2N19CHczP721vB4wzPFwv0X7XtwsNCsjSKHeSgTPld5MIpFyDmOCGynkRw/D9kBJpQdHdwEnhJ8gukLdJP/aK4pVPQSrUn1NhHgfM5q2G/YrKuhHsmXc25yux+voiBLz/K54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789855493; c=relaxed/simple;
	bh=GAUR4WlzngGtujX+UFenfAJelbsQygoTgbSXqUzcrXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxoCno/SDlgQntVB4LY5qEAn0tX7uvdPyIgpeREIdxhSr2y1PzLep7VAkt+n3wUbt55EU2xFkiK4kLbbfb/xhXGyP/Qb88ZGwWTPEMrS8/Cdiipxwq/h9tus+6qWdAXmB2xoTWdcFLza+GwDHuRQjMEMNBDx3U5GzJuZtP6T64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHbXHm9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHbXHm9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816781F000FF;
	Sat, 19 Sep 2026 22:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789855491;
	bh=49qcSxqxDVwhZW9ihOD93zdnLFfJvXTlEoW8tKbwVJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fHbXHm9jpGMDBKnCfMnxH6g9Ljo/j19y5w6Eww9ZiwxMARqJ3dRAJjfJGb7h7J6NZ
	 rBTxX8q4z2p0/Q9vCsruRp2e/cWDcdzT7JLaOOau6lgx98sAjMjnqvmz2IbJhoA+52
	 SIABOvznxN1p5YDQQZ4zylOxmiKo+z/XIKgO5OEHWTX3YRK3utrBvUwbBqCKZnlhQe
	 b9ZFi5RILeJ9JGijj3bvAC8duT098qd61CLMzDLEl914iLsfe38G/NcBSVHJ7/r5LW
	 27c5Vhac/asGrPTxZ0Y0rlk9Gk6GGnn59L7tTpGRcHq+8xUmrO0w1+xC7ibFd/0uzL
	 k0vgIYSmH0h1A==
Date: Sat, 19 Sep 2026 15:04:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Subject: Re: [PATCH net-next v12 04/15] ax88179_178a: Split driver into
 library and device specific code
Message-ID: <20260919150450.3d0ec698@kernel.org>
In-Reply-To: <178968029415.22033.4203681974249867316@kernel.org>
References: <20260916-ax88179a-v12-4-60c04c9924a2@birger-koblitz.de>
	<178968029415.22033.4203681974249867316@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Sep 2026 21:24:54 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [Medium] The module is renamed from ax88179_178a.ko to ax88179.ko
>   (drivers/net/usb/Makefile: `obj-$(CONFIG_USB_NET_AX88179_178A) +=3D=E2=
=80=A6

Why not fix this? it's been reported before and looks both legit and
trivial to address.

When you repost please post the driver split first, separately.
We can get it merged more quickly since its trivial.
