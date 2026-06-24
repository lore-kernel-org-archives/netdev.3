Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188E73D905F;
	Wed, 24 Jun 2026 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782314687; cv=none; b=q2MPmhmfbPrutbJ0DADijrox92AlyTN3wWoVqzJUTbcG2k+NyM/DYBLN8xyXmrOFxd2vHwh9rA/ECxmcd6SG6qlrreOCSRlZcaGzLu0J1ZiUbAhFE5nGlDO5cXWQJzJD6rOuAwarKg23D0fQFEgpe6nfOL51293VJkBTbrBRw/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782314687; c=relaxed/simple;
	bh=0AXDlhhx2EVTJhKxESKF3/J+HgzWO+ttLuCkwSjK3Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpQqayOzkfO2EOCxhRPGQsNkUTmCeOKDqP1nHYQvDJlDD4AaQuKdI8r3wQwTdN4XbibFWAL8PbUycCEIvHdmB9cewoMwlez8gzQYUPq1AWZO8VledLmAPoLk39rfavRsYm1w6vFKF2NWgMhApnz23DSSCVEvcxiHkMAEZoWzMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0YWQzYo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0YWQzYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762D61F000E9;
	Wed, 24 Jun 2026 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782314685;
	bh=F/HuVviSppLHm5Q0igLfBiI5LadeQp+102bTsQ7/fPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o0YWQzYozjwbS3hYrCZfxdo/96aw6AGr0rWyaBP+oxOJC097GAjmc6E/Y2zuF0lME
	 NIBS4vWusRPTxbmk1UaN8UGpihPhy8jTpX6G0fdEz2RwXreTSubAmXH81hrY+diBM0
	 MrKA5ZYv2uZbb1Tum3dpIDEvQnnwO0BNUECDp8UnLmo+HlK8XedZCFw5YbS67QWwa0
	 Gjbz/JW0VKs6mMbxCSTGaGREDtn9d/Y6QEU0XQ8aTCWTtIKhUKCsseBzrLZtN8FIPK
	 YoVZJ7c2XjtGECsRp4o8QpWj2YBU5JloC3kri8qenocv0yvqei7kH/G+8YWeOWG/vs
	 5Ad0tj3rIa9fQ==
From: Simon Horman <horms@kernel.org>
To: nshettyj@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sgoutham@marvell.com,
	rkannoth@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Sunil.Goutham@marvell.com,
	naveenm@marvell.com,
	hkalra@marvell.com
Subject: Re: [PATCH net v2 2/2] octeontx2-af: suppress kpu profile loading warning
Date: Wed, 24 Jun 2026 16:24:25 +0100
Message-ID: <20260624152424.1138178-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623040609.3090846-3-nshettyj@marvell.com>
References: <20260623040609.3090846-3-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
octeontx2-af: suppress kpu profile loading warning

This commit replaces request_firmware_direct() with
firmware_request_nowarn() in npc_load_kpu_profile_from_fs() to suppress
a warning observed when the KPU profile is loaded via the firmware
database method rather than being integrated into the kernel image.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index c7bc0b3a29b9..007d3f22b0c9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -2246,7 +2246,7 @@ static int npc_load_kpu_profile_from_fs(struct rvu *rvu)
>  
>  	strcat(path, kpu_profile);
>  
> -	if (request_firmware_direct(&fw, path, rvu->dev))
> +	if (firmware_request_nowarn(&fw, path, rvu->dev))

[Medium]
Does this actually change the warning behavior the commit message
describes?

Looking at the two helpers in drivers/base/firmware_loader/main.c, both
pass FW_OPT_NO_WARN into _request_firmware():

  int firmware_request_nowarn(...) {
        ...
        ret = _request_firmware(firmware, name, device, NULL, 0, 0,
                                FW_OPT_UEVENT | FW_OPT_NO_WARN);
        ...
  }

  int request_firmware_direct(...) {
        ...
        ret = _request_firmware(firmware_p, name, device, NULL, 0, 0,
                                FW_OPT_UEVENT | FW_OPT_NO_WARN |
                                FW_OPT_NOFALLBACK_SYSFS);
        ...
  }

The dev_warn() calls in the firmware loader hot path (for example the
"Direct firmware load for %s failed" message, the "loading %s failed"
message, and the sysfs fallback notice) are all gated by
!(opt_flags & FW_OPT_NO_WARN), and have been since commit 1fe6e4f0b0c4
("firmware_loader: Suppress warning on FW_OPT_NO_WARN flag").

Given that request_firmware_direct() already sets FW_OPT_NO_WARN, where
does the spurious warning mentioned in the commit message
("causes a spurious warning from the Linux firmware subsystem ... due
to the absence of firmware in the kernel image") originate?

[Medium]
This change also silently drops FW_OPT_NOFALLBACK_SYSFS, which is not
mentioned in the commit message.

The kerneldoc for request_firmware_direct() says it "doesn't fall back
to usermode helper even if the firmware couldn't be loaded directly
from fs.  Hence it's useful for loading optional firmwares, which
aren't always present, without extra long timeouts of udev."

firmware_request_nowarn()'s kerneldoc states the opposite: "The sysfs
fallback mechanism is enabled if direct filesystem lookup fails."

On kernels built with CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y, or where
the force_sysfs_fallback sysctl is enabled, fw_run_sysfs_fallback() no
longer short-circuits on FW_OPT_NOFALLBACK_SYSFS, so the absent-firmware
case will now invoke firmware_fallback_sysfs() and wait on udev for the
loading timeout (default 60s) before returning -ENOENT.

The commit message itself states that "in most cases the profile is
loaded using the 2nd method", so this is precisely the optional-firmware
scenario that request_firmware_direct() was designed for. Was the
fallback-sysfs behavior change intentional, and is there a reason not
to keep the no-fallback semantics on configurations that enable the
usermode helper?

>  		return -ENOENT;
>  
>  	dev_info(rvu->dev, "Loading KPU profile from filesystem: %s\n",
