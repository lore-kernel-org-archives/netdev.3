Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC1230D0F;
	Sun, 25 Jan 2026 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769383406; cv=none; b=KTkjzPf0GKhme7o4BtCix950R+iU0Jsb3HQTC4H4jzRwajZCK3hcnt98squya9X1+Zd5F3whqcUb/UIPDVUrU7uaL8D6WY3VDFoFb9rfglVuzS+39YoNLrhDiZ1G2wH3F2W4i+BOjU6UKu12tSlAHXg+n1uLMEVjlaa/em/oJvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769383406; c=relaxed/simple;
	bh=bGLaHBn1IjojJVZhvgMqVVXp64JzJ5tiA32E6pxU0Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hylo62ObYHSfmlZZgyMMsc0YXVotRuEN2+Sb9sHZROl5Af0DiMTfBSTz9crzARSm540LSSTGTNyNB61Yr76jKBYc83igJkgKu1ASiWoEWMQMuNFHRm6fHEliOGKCSFkmlIIBmrNiwsDMD/+3G8DnEcprPLL2sA7i3pT/jZFlt3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcBQzA4U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcBQzA4U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473D4C4CEF1;
	Sun, 25 Jan 2026 23:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769383405;
	bh=bGLaHBn1IjojJVZhvgMqVVXp64JzJ5tiA32E6pxU0Sc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AcBQzA4U3e35VHsdAP53ZMNjfiFL+x884yReqpvJKrDRZ9f413R6fuW8e/Gc+KePm
	 RZrZCIamMNGjx82XZ9GGXy+mJdGEoYXqgmpPzxcWAacFf/HRwtRjNf84o7ooI2rJle
	 FRE/VeyugItQbHObI24Yh1o7D4cu/dvDqophnhOgbSNauZrNj0adYA/YtgtylqnDDg
	 wVeqN0r62eDTv8BCF6APUHyIXYFNagYwuNW3toCUrGN3x8boxBh8KX41cmolwoL6BY
	 iAYzSsaX2xroPJDCZ6b7gg2BFNKjXqeP/5P/CtLb7lK3MxztlOueWjjMT6NUNXTNqf
	 yTC1Ho1osuuzQ==
Date: Sun, 25 Jan 2026 15:23:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: alacritech: Use u64_stats_t with
 u64_stats_sync properly
Message-ID: <20260125152324.1b7e5a9f@kernel.org>
In-Reply-To: <20260122185113.2760355-1-mmyangfl@gmail.com>
References: <20260122185113.2760355-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jan 2026 02:51:07 +0800 David Yang wrote:
> On 64bit arches, struct u64_stats_sync is empty and provides no help
> against load/store tearing. Convert to u64_stats_t to ensure atomic
> operations.

Eric, could you comment if this matters? I expect David may send a
non-trivial number of these, I want to make sure we're making good
use of everyone's time here. 64b accesses are not torn on 64b arches,
and never used for control flow.
