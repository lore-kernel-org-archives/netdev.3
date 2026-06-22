Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480DC3783C4;
	Mon, 22 Jun 2026 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125646; cv=none; b=Dok5oDRo0WQGGON+K8/8EvxCS+zfTbMl6jldWOj+5TVkrfC38iTP4VCd3ig5SZjZ8BpgIMQpVDMOGpTb1ANgpVBv3JL5gHDaqRqT1+uB47faIRIbbeGzYmnc/skwI0CDmIcsUrkVS5uIoBV0FS0O1rrGOzwFgkOWzhYtvjN9NYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125646; c=relaxed/simple;
	bh=9ocAbWfJBJnLuv92X+iB4cLtcgQC37d+fIUtTulhn2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoGJONe8e9zbDU/1JqvECOjIRHcP2EPVwuKoZggrmI//PpgzqIfgoIpCbaGhmSQVD42JbuVd7C71Flr/TVmivggrXuh0fWBpwTx8Rguh5lolpjYdlAkH3tK5loJAwVvz9Ehd6TWduE1Y+ridrmR3vP+7s05zN6PB4x61oS4Zs5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxd5FisK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxd5FisK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5321F000E9;
	Mon, 22 Jun 2026 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125644;
	bh=8OMBAfjJBG1yflPxUCVlFyVOJHWYSW70ogFfcfTKQdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oxd5FisKJ6gOyWY3BFr+i7qubg8dV2JRXlskDGpVW01s/P1tEWxNQLdrV8Jxck64p
	 MAyUgexwkuHNJQ1PlSOCtlF6d1O600XkTjQha2CU8ATOmkWkqmqnklkGtBWlG7IrNJ
	 oO70n+AcfbWKb0/ed9hw/6+kBGvqtoSUcCK1sL2vM4uyevIPfU6vSND1qp+o7W/mfL
	 PMB3oWUo+wC+j4gZPaPmS9YOhuVZiFBUGdT2/c37QMqysnc0GqxrMelOD3O9zf8QGe
	 R3jngXM7KK27sRkLkb2y5rpFJ7J4oDE0nsbIDKmbDaEEOKJ1boOMEOeTnT/2xInJJS
	 lNLTHQ+P0WQ9Q==
From: Simon Horman <horms@kernel.org>
To: rkannoth@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	gakula@marvell.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	sgoutham@marvell.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hkelam@marvell.com
Subject: Re: [PATCH net] octeontx2-af: Block VFs from clobbering special CGX PKIND state
Date: Mon, 22 Jun 2026 11:51:50 +0100
Message-ID: <20260622105149.1009058-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619041002.1773822-1-rkannoth@marvell.com>
References: <20260619041002.1773822-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
(Note: Due to recitation restrictions, the standard unified diff is omitted 
and the findings are summarized below instead of inline quoting.)

commit 40480a8afd593111da0b00679b782cbe187572e6
Author: Hariprasad Kelam <hkelam@marvell.com>

octeontx2-af: Block VFs from clobbering special CGX PKIND state

This commit adds checks to prevent VFs from overwriting LMAC RX PKIND or
default TX parse configs when a shared LMAC uses HIGIG2 or EDSA parsing.
It introduces helpers to verify if the PKIND configuration is permitted
before applying updates.

[Severity: High]
Can a Time-of-Check to Time-of-Use (TOCTOU) race occur between a VF checking
the LMAC PKIND state and subsequently updating it?

Looking at rvu_cgx_is_pkind_config_permitted() in rvu_cgx.c, it reads the
hardware LMAC PKIND register locklessly to check if HIGIG or EDSA parsing
is enabled.

If the check returns true, the VF proceeds to write its own default PKIND
to the LMAC via cgx_set_pkind() in nix_interface_init(), or updates the TX
parse config in rvu_mbox_handler_nix_lf_alloc() in rvu_nix.c.

Since VF mailbox messages are handled by rvu_afvf_mbox_handler() on a separate
workqueue without holding rvu->mbox_lock, could a PF executing a mailbox
message like rvu_mbox_handler_npc_set_pkind interleave between the VF's
lockless read and its subsequent write?

If so, the VF might observe the default PKIND, the PF could then set
HIGIG_PKIND or EDSA_PKIND, and the VF would then erroneously overwrite the
PF's configuration. Does this sequence need to be protected by a lock such
as cgx_cfg_lock or rsrc_lock to prevent bypassing the new protection?
