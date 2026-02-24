Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F673EBF08;
	Tue, 24 Feb 2026 00:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771891938; cv=none; b=gtefHaGEsHi0EGVoQS5JGgOQMlMHwFx4+sAIg9Wf1m/HM8+7RX2nFyydd/Px7Pc5kwe81WqM4YYziy0GDF7qcws1i4j0zSpmWnMvw2UZDSIBkqYyE6dpdX8+kdgR3rh7x8DS85e2ubRR07wvCWKroiapGYIgRdl0/NDxq+VD16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771891938; c=relaxed/simple;
	bh=9eNhWko4VxFgwbEsqMEAiJBYdT2SfwPPRQqT2fqq1QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvlPLqbBcdUMk4syOZ0P9rAXFHACF0d9S0CKBYN+sRcHKj4LfNiLzTMulWnFXDX6pGvDavG65e7xBGSYQk2DK4vk4bAaMZ2HlRJuzQjvfU7P5woT+1/+SNqFs5SR2yN7Juz2TB5Tnoy6YG99p81PzsE4RE/MWWQlt336Ijyp6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcyKdemW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcyKdemW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3480C116C6;
	Tue, 24 Feb 2026 00:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771891937;
	bh=9eNhWko4VxFgwbEsqMEAiJBYdT2SfwPPRQqT2fqq1QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pcyKdemWEZ3YxPH8/Lv+CtJO9OMxkDDidx5m9D1WiwQALKjC6SKWwWqTQCvvcOOGp
	 UGjZ7hyca1ZT0Gzs+TolDhzwAXzJLIQYKMZhbYxbV8IP2533aFdc9wbORfbJe4uP85
	 cj216MUoVZBAwCR4xOrzw86yY/tbm5NcFOHMIpCxtTSusNEivcNtZZ+z9rw0UnHYhj
	 c2Y6Y5OJsn3r0yQr4sny90jV6Gf1kJLC1RsqYCOmO5wD+9RB83raOc6GgZ2VySaM7a
	 IPPeUgbBKFcrMFuY9H+ug5hbymvCACeUNsXMm8Re2uPdt03QUCOjpn/QF1YeBmO5bx
	 6n1BGIIWSYRTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: bhargava.marreddy@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	michael.chan@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	ajit.khaparde@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	edumazet@google.com,
	vikas.gupta@broadcom.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	rajashekar.hudumula@broadcom.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	pavan.chebbi@broadcom.com
Subject: Re: [net-next,3/7] bng_en: add ethtool link settings, get_link, and nway_reset
Date: Mon, 23 Feb 2026 16:12:02 -0800
Message-ID: <20260224001201.146384-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223163641.755200-4-bhargava.marreddy@broadcom.com>
References: <20260223163641.755200-4-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
bng_en: add ethtool link settings, get_link, and nway_reset

This commit adds get/set_link_ksettings, get_link, and nway_reset
support. It also adds reporting for supported, advertised, and
link-partner speeds across NRZ, PAM4, and PAM4-112 signaling modes,
and enables lane count reporting.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
> index bff04dfadaca..f037229db7b4 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c

[ ... ]

> +enum bnge_link_speed_indices {
> +	BNGE_LINK_SPEED_UNKNOWN = 0,
> +	BNGE_LINK_SPEED_50GB_IDX,
> +	BNGE_LINK_SPEED_100GB_IDX,
> +	BNGE_LINK_SPEED_200GB_IDX,
> +	BNGE_LINK_SPEED_400GB_IDX,
> +	BNGE_LINK_SPEED_800GB_IDX,
> +	__BNGE_LINK_SPEED_END
> +};

[ ... ]

> +static const u16 bnge_nrz_speed_masks[] = {
> +	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEED_MSK_100GB,
> +	[__BNGE_LINK_SPEED_END - 1] = 0 /* make any legal speed a valid index */
> +};
> +
> +static const u16 bnge_pam4_speed_masks[] = {
> +	[BNGE_LINK_SPEED_50GB_IDX] = BNGE_LINK_PAM4_SPEED_MSK_50GB,
> +	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_PAM4_SPEED_MSK_100GB,
> +	[BNGE_LINK_SPEED_200GB_IDX] = BNGE_LINK_PAM4_SPEED_MSK_200GB,
> +	[__BNGE_LINK_SPEED_END - 1] = 0 /* make any legal speed a valid index */
> +};
> +
> +static const u16 bnge_nrz_speeds2_masks[] = {
> +	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEEDS2_MSK_100GB,
> +	[__BNGE_LINK_SPEED_END - 1] = 0 /* make any legal speed a valid index */
> +};
> +
> +static const u16 bnge_pam4_speeds2_masks[] = {
> +	[BNGE_LINK_SPEED_50GB_IDX] = BNGE_LINK_SPEEDS2_MSK_50GB_PAM4,
> +	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEEDS2_MSK_100GB_PAM4,
> +	[BNGE_LINK_SPEED_200GB_IDX] = BNGE_LINK_SPEEDS2_MSK_200GB_PAM4,
> +	[BNGE_LINK_SPEED_400GB_IDX] = BNGE_LINK_SPEEDS2_MSK_400GB_PAM4,
> +};

Is the missing sentinel entry here intentional? The bnge_pam4_speeds2_masks
array has its highest initializer at BNGE_LINK_SPEED_400GB_IDX (4), making
it 5 elements long (indices 0-4). However, bnge_set_ethtool_speeds loops
'for (i = 1; i < __BNGE_LINK_SPEED_END; i++)' which reaches i = 5
(BNGE_LINK_SPEED_800GB_IDX). When BNGE_PHY_FL_SPEEDS2 is set, sp_pam4_msks
points to bnge_pam4_speeds2_masks, causing sp_pam4_msks[5] to read past
the array end. All other speed mask arrays include
'[__BNGE_LINK_SPEED_END - 1] = 0' to prevent this.

> +
> +static const u16 bnge_pam4_112_speeds2_masks[] = {
> +	[BNGE_LINK_SPEED_100GB_IDX] = BNGE_LINK_SPEEDS2_MSK_100GB_PAM4_112,
> +	[BNGE_LINK_SPEED_200GB_IDX] = BNGE_LINK_SPEEDS2_MSK_200GB_PAM4_112,
> +	[BNGE_LINK_SPEED_400GB_IDX] = BNGE_LINK_SPEEDS2_MSK_400GB_PAM4_112,
> +	[BNGE_LINK_SPEED_800GB_IDX] = BNGE_LINK_SPEEDS2_MSK_800GB_PAM4_112,
> +};
-- 
pw-bot: cr
