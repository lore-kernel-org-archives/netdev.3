Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470522;
	b=gBet8r3qNnDQiFwYITaW4pK5cEoVM7B3mQ+rZ1b0/BH5WYUqCnFtlMnmxhxFpb380qvb
	 7Y4Sf/YpFy9lkx3WTOXHc1hPV7v0cBiW6VQwaDEUDpE4nbWB4SunG35PJG+6qjMG5Is1X
	 cWSLE2GNCKMDNBRsNokEPCxwGAeXW+GjbOXAgP5Q8EHOJUjAU65v6J8+e5Z/+Zli/aCFj
	 7zeULl4cW1MPPOgU+54wuZXuUlLbAJSztbotIx45Pub9NXsn3b9V5nxiThunDQ/dAmJcA
	 YTBgg7OeXdXm6MYk/MBtSq//2honEPGN5lHRjEfG8AFvDVCpiVPRR/w0dHWB4cV+riA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470522;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=bn7P8PbFl6aUu4qWbtZo51tRJb6g65PQpAsz7wEMkuqt4i7YkRP12hQbeW2+jemCW+wz
	 4o2DmiRwc/qXayRU9Z0iPMVu1mw9jaaf3rVMw3CHx9W7cfpZv/fxQGBxLyi/FoRYsO7hs
	 i6nxJqgJORjXclnWIuKs9zwqOl5+AL5R3zzOl5eZUO9GMO35Uh25PPLpDZtGSTsGFPy76
	 QXAn13TzJDi2FDStZbsAxvAQbohM7jnex6V8IYWv131SvlNRTPRnjvaoBPf8fp26ksQkI
	 Aj5LDFhGPzTeq4mjGTNbr9Ng3Ty7rcWeMuf4IDVPKt/NWpCABUGQaOyxCwjnELvCoPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1dKJtlT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B30606A323;
	Thu, 12 Nov 2026 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1dKJtlT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2081F00A05;
	Thu, 12 Nov 2026 08:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794470522;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R1dKJtlTG4farS8aqdQvOONRSGqV2KoOG8GbvAS+CKYRGmsN7qop+6QCtL5QQnlt3
	 yGwwsYtZ0+cK8hbgMtrw7LSR5SHJJfQjExKS+0Z5z83UasxNAM9SkwYKEqXRZ3Dkg1
	 O08fxEqlEs0dLGROV/035tftWJg8iP2cL27mqBCBKvWCMNJiNRnW/ldiQc7luwajJg
	 fiMEi+hMAakhVOvEyzi8bfz3btC2PBS7QwvrEj2oL9cIe1ClM/FTA/jDuuwHgp5GA2
	 NnMPXWNbZ8YCi6S8Gkt/wkf36zbZLsYmfQozpJoxccAq+BGnho4t2V+Gjw3bfa8JKd
	 f/Uqr66Oq5vVA==
From: netdev-bot+sinfo@kernel.org
To: Linkui Xiao <xiaolinkui@126.com>
Cc: maxime.chevallier@bootlin.com, andrew@lunn.ch, kuba@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 devnexen@gmail.com, sdf@fomichev.me, 2022090917019@std.uestc.edu.cn,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH net v2] net: ethtool: phy: warn about a phydev with no
 link topology
Date: Thu, 12 Nov 2026 08:02:00 +0000
Message-ID: <179447052068.2168702.1832622139543878794@kernel.org>
In-Reply-To: <20261112075517.3904496-1-xiaolinkui@126.com>
References: <20261112075517.3904496-1-xiaolinkui@126.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
