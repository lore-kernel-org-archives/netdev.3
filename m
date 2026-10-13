Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64517349CFF;
	Tue, 13 Oct 2026 01:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853710; cv=none; b=WiGlLyQDMgyzGeWsHxj6y+m0eeZ7G7PwlNJks8MevZHQjcxRinWXIRn/Ry3kPIA83Us1EtUotCrw+RkG6wfSimwTEbt7ocIZlViV4KBKOPtgGyugx7T1CFyNt+k2kykXS7dULciJbKXIMpG5bj3EtU2pG4Edwg7ScRNXSOYsLBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853710; c=relaxed/simple;
	bh=RnZztOYQv8Yw3fpBzj1ipmHwtp2riDu6PNftUYzVJ8s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=usewBiRkSTBeiL23QEMxd18Qh1cSswxw+WLsYxRy0Ns+8TNK4INulmfGVYFMkvPOYWxeU8Dg3VOJ6TwQua2e632buYZKWFfyPpvi7UI2x/+c/ZDA2OOBvQwpcpOXVPEjh/0DVJTt47Dc/RzY18etI9m5ZFsRH7IvyHqrc32wqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXbLo6aI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXbLo6aI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B6C1F0089B;
	Tue, 13 Oct 2026 01:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791853709;
	bh=8UH2nKww14Rwaso5/0jYgIaWsgMkvo0DNQvhS2bxx/k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TXbLo6aIOUJgzCwvV8+wqllCLm2gz6lPWCNaEcqjZCcuOMLeT/7veT48wPcIuzmg/
	 ZC6mrYax84iFGlEI/xqgKbP0MRHo+9Z3RL5RwH2wucmhEIURBy/sNin/RPp0w9Vth6
	 N7JEyT9nNxzYO/2iqQwstpuE53TTBjHBl5RQj2uvAaBDT4lplVLr2X19N1OILjared
	 HobVDgBzlVPKSIYOrZi4DeeGF4BnITvkgigTP8UkSkqae2fywTjEnQ/zfAnEZ3irxP
	 GIaTjfYdOfvPpoo5jJbcSzMRqZLRm0XYJaFqp0NEcgXHG8Hf9P87FAj08UwoVTVXiZ
	 VsGztoTG843hg==
Subject:
 Re: [PATCH net-next v4 1/9] dt-bindings: net: dsa: realtek: add RTL8367S-V
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 01:08:27 +0000
Message-ID: <179185370779.434549.9086223025050329928@kernel.org>
In-Reply-To: <5dbd1b29-72d0-454d-83e1-19f7232a0ee0@yahoo.com>
References: <5dbd1b29-72d0-454d-83e1-19f7232a0ee0@yahoo.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit subject names the wrong part.

--

dt-bindings: net: dsa: realtek: add RTL8367S-V

This commit adds RTL8367S-VB (chip ID 0x6642) to the list of models
covered by the realtek,rtl8365mb compatible in the DSA realtek binding.
The chip is identified by its chip ID register, so it does not get a
separate compatible string.

> dt-bindings: net: dsa: realtek: add RTL8367S-V

[Severity: Low]
This isn't a bug, but the subject line seems to be missing the final B.

The commit body and the diff both say RTL8367S-VB:

> The RTL8367S-VB (chip ID 0x6642) is supported by the rtl8365mb driver

> +        RTL8367S-VB, RTL8367SB, RTL8370MB, RTL8310SR

The later driver patch in the series, "net: dsa: realtek: rtl8365mb: add
support for RTL8367S-VB", also uses RTL8367S-VB.

Could the subject be changed to "add RTL8367S-VB"?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/38872e6f-1264-4a93-9f81-8212173e909d%40yahoo.com
