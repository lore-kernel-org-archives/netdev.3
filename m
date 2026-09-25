Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E83509F17;
	Fri, 25 Sep 2026 23:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377782; cv=none; b=ckgVZszvp1rWF1QtMtnIDSyd3lFDRUl5aAbz/hke9kExlSwzQZ7GIbpLprDeriQMtmVDdKzPpi07Pj5q6yoD28d/2LFeYoXkkZBhY5n3UDIc4uIAmEKVqkuMHH5mC3oz27s7ySTpQRzYXgP7jwopFGQS7OnltRCJfR3CoA54juU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377782; c=relaxed/simple;
	bh=5p6BiXe7HWjkaON+GGeU8V6laoWvOJkcA7ywRDANmhc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OPLtNeqhshYxyh2qQBOhAo6qJyq+Ty7+qhTJaOrsWytZ6NzWtzEOuAhEdXpOBZXQSdUs8AogYE6hL9LFDuZZEWw1dy8+tHZDGuwB86bY8W+rk5zLB1yVooPdkf8ejhx3f1i7kh00IbfG85mLAEO0Gsnv53TmIte090KNgJX2eYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTwns0Yd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTwns0Yd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CAD1F000FF;
	Fri, 25 Sep 2026 23:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790377780;
	bh=l1hag7IhP/HH+Aj9sjNYtjynV3gjwA3LqV5K3Ae+M6A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XTwns0YdDK27DZwasvna1xHomRuMMCz4m1UZRw43NBZbwub5TRVoF2wGYuXv5HeVT
	 3exRi/V436ORhvj8repnmEf7tI39d+tYJWlpn9WcfH0IP1vUTuurUGZmuVcMNMgqSY
	 /nlzkU//Iyv5PQK6zgu0lrJNJd1OZaG4JcqAs7mwHp7uG55cLygIEjGEkYbznLWkH3
	 ML6a5E4JO2IJZamaLqvcqtffgAoTi9meZo2LWZ/h8llf0fWvQdRQ0/m6g7ss71dKzI
	 ecMFThWYhwitVSOe2qdi/umkr65UaZNlF9/vuoxPBJgf8hrbf+QWcSRsCWWeEDtzwd
	 mW77jzyBB6/MQ==
Subject:
 Re: [PATCH net v2 3/5] net: bcmgenet: do not skip WoL power up on GENET V1
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, nb@tipi-net.de, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 23:09:39 +0000
Message-ID: <179037777940.2160803.18391129495730255764@kernel.org>
In-Reply-To: <20260921220021.281418-4-florian.fainelli@broadcom.com>
References: <20260921220021.281418-4-florian.fainelli@broadcom.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message of "net: bcmgenet: do not skip WoL power up
  on GENET V1" (387c3a954a3a) ends with the malformed trailer `Siged-…

--

net: bcmgenet: do not skip WoL power up on GENET V1

This moves the bcmgenet_has_ext(priv) test out of the top of
bcmgenet_power_up() and into the GENET_POWER_PASSIVE and
GENET_POWER_CABLE_SENSE cases, where the EXT registers are actually
touched. That lets the GENET_POWER_WOL_MAGIC case reach
bcmgenet_wol_power_up_cfg() on GENET V1, which has no EXT block.

The only comment below is about the commit message trailers, so the diff
hunks are omitted.

> Fixes: c3ae64ae0c08 ("net: bcmgenet: handle GENET_POWER_WOL_MAGIC")
> Assisted-by: LLM
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Siged-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
  ^^^^^^^^^^^^

[Severity: Medium]
This isn't a code bug, but should this read Signed-off-by: instead of
Siged-off-by:?

As spelled, the trailer is not matched by checkpatch.pl or the patchwork
netdev checks, so the patch appears to have no author sign-off.

The other four patches in the same series use the correct spelling, so
this looks like an isolated typo in this patch only. Since a trailer can
only be corrected by amending this commit, would a resend be needed here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921220021.281418-1-florian.fainelli%40broadcom.com
