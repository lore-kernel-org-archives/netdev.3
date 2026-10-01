Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01E53CCFC4;
	Thu,  1 Oct 2026 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790857263; cv=none; b=asimLoR4Js5hmWBrNeieti5aAcKBHgnbeO8pokrAJOXsWC7l93qE+uOmn/lDEU1dueF1fwE0rIvklQAKxc5DwcAr+jgTKl/1TBk9DuGyDezKlL9a0IMKMuzi0QMA9qs58l06/BaZ5QBSAnimG4S230xg+gw5YobPr6HQ25zPV5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790857263; c=relaxed/simple;
	bh=AwIB0G/MbYgTs/wRUH8SY9B5shS7m2+UmG0B1b6YR44=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KjXUGBGGmgOQ5psAS70Ndbw02KdrMxldev+AkGI3U47lyYXWdG6lNu5WZ571TFukDX8b/xnZyNPwd+IK0b/YaIRxbTpYq81hx7JUdA+9oG45G7m5/NFjyYOa62xGTdKNPtmnSvxEOz+8mwFc817ftmTQGg8lmCVjlMqURV2LO5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aawu+aG7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aawu+aG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9650F1F00898;
	Thu,  1 Oct 2026 12:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790857262;
	bh=jy83t7Lcy9TdGgtaQ9S3eHMDU7dPsfRU9pMJkGeu3F0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Aawu+aG7dL9yJxU+waW1r/kioZKu7wKmWe8hlXGWdIjnQEH+LFMWGZEVrW/xHHIn6
	 dWUXNun9nmYC2aIhNMxunq/D9OIH5Kjn+gvEJjbC/PxkkU6cSg0jtyPWnfSAwkpA1q
	 QwKgPOW7BLvfNIl4B4620rPSrYgZAcE/A7nVyULrsDAmgssg+fbH6YiZFPCE1KL38P
	 Zqy1fe9f7PUyzm/zuYlYWp6ZtMPnyK5E3OC0jDqawCkN9fSeugWBKHypS5T8YkOlPI
	 eWhB1hgifXx6N25vc8KnViFDkzxTu7ghS2rqF/HkpFjPKlG/kgcs1wS2YRsayvsJdZ
	 +6p1by1exij1Q==
Subject: Re: [PATCH net-next v2 2/3] net: pcs: rzn1-miic: Fix miic register
 initialization loop
From: netdev-bot+sashiko@kernel.org
To: khendry@reliablecontrols.com
Cc: clement.leger@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 12:21:01 +0000
Message-ID: <179085726114.434549.9959783778596639760@kernel.org>
In-Reply-To:
 <20260928-miic-validate-dtb-v2-2-1ee3d33748e9@reliablecontrols.com>
References:
 <20260928-miic-validate-dtb-v2-2-1ee3d33748e9@reliablecontrols.com>
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

- [Medium] The Fixes tag and commit message of "net: pcs: rzn1-miic: Fix
  miic register initialization loop" blame the wrong commit and describe…

--

net: pcs: rzn1-miic: Fix miic register initialization loop

This commit changes the loop in miic_init_hw() that writes default
register values. The loop now runs for miic_port_max - miic_port_start + 1
iterations instead of miic_port_max, so the count comes from the SoC port
range.

> The function to write default values to miic registers was looping from
> zero to miic_port_max, which might not cover all ports depending on SoC
> numbering. Determine the port count from SoC data and loop over that.
>
> Fixes: c112520de041758e ("net: pcs: rzn1-miic: move port range handling into SoC data")

[Severity: Medium]
Is this Fixes tag pointing at the right commit?

Before this series, the loop in miic_init_hw() already covered every
converter on both supported SoCs:

    for (port = 0; port < miic->of_data->miic_port_max; port++) {

RZ/N1 uses miic_port_start = 1 and miic_port_max = 5, so the loop walks
ports 0..4. That is 5 converters.

RZ/T2H uses miic_port_start = 0 and miic_port_max = 4 (from 08f89e42121d),
so the loop walks ports 0..3. That is CONV0..CONV3.

c112520de041 only added the RZ/N1 data.

The loop stops covering CONV3 only after the previous patch in this
series, "net: pcs: rzn1-miic: Fix port numbering on RZ/T2H". That patch
changes rzt2h_miic_of_data.miic_port_max from 4 to 3. So this patch seems
to fix a regression from earlier in the same series, not a problem from
c112520de041.

This leaves a bisect window. At the previous patch, miic_init_hw() on
RZ/T2H runs only 3 times. The CONVRST bit for CONV3 is never cleared
during init.

The two patches also carry different Fixes tags (08f89e42121d and
c112520de041), so stable trees could pick up one without the other. If a
tree takes only this patch, RZ/T2H still has miic_port_max = 4:

    num_ports = miic->of_data->miic_port_max -
        miic->of_data->miic_port_start + 1;    /* 4 - 0 + 1 = 5 */

The loop would then clear MIIC_CONVRST_PHYIF_RST(4), which is for a
converter RZ/T2H does not have. If a tree takes only the previous patch,
CONV3 is skipped as described above.

Could the miic_port_max change and the num_ports change be squashed into
one patch with Fixes: 08f89e42121d ("net: pcs: rzn1-miic: Add RZ/T2H MIIC
support")? If not, could the commit message at least state the dependency
on the previous patch and drop the c112520de041 attribution?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-miic-validate-dtb-v2-0-1ee3d33748e9%40reliablecontrols.com
