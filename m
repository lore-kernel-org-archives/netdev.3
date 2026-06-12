Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7536CE10
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287078; cv=none; b=h0GjFjnJI90BVFCYjBOcGAoShuxavt8GSunJbSgo08lUUAlsJtKCjz7ZXA6P9eXBHFojMqZqmcQyA+2ogxf9hYVeqadEVfNmUNmNh7EY9h1yLU8x/4RuJX/MSrCaOe6uaMtrxPNZuo+UdF8LMNVNB/ysF+dYde7Mz/Aizw6KULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287078; c=relaxed/simple;
	bh=zRWoQXCtMOBWBsutRSnFWCREpC3BqoSSxc5qXc+RcdU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGoBGjDMVamzJirA0btGDnX0vhc8wEpSok/mKfpAbhdwxZ/F/MeoecT7NIMv9pbk5GDm2ze8Hgb5h6louExbW26RYOjrBB/LBsecGS634xo1MM1TLBgBxvp8w991vH5qLg3LLZxBDa7W6J5gWslpXBxFc88z47NS51Wy73TBLv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=az5AtMOC; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="az5AtMOC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=5rmaei73r5ff7fednab3j47elq.protonmail; t=1781287066; x=1781546266;
	bh=uqoNIEdJd9o31lWk+Soo4RDv+i0iKH20B2Ql9d/JqAE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=az5AtMOCGmIx2/Yuy/rpSL6WYDfkTPnpW3n1LTMnrbodtazamwXPM4F/hpkPES+wS
	 q+n2IS8QjexDgOrl/Byyr7h+DUCaAT86oo26nFBIZ0wAKor2KZIuUK0LUfALccukoe
	 Z98B9yjH8cIiWxiknkP0Qs6W19TmDdXsg3JPtPdTNmgFvpLCdbq48zn1LBhspgecuD
	 R77Lx4OfdcM1dOmi8+mkhVi9WDeAZg39M7RiuUcRnG3vkaD4m1tNqtoceV/K+Fmxet
	 09Cuv0ItWUUWS3dSswJ+ASvsuVKhE2vkUIasx1O0j/37I7E4jmVLXZWJwiFHJVREEb
	 EzPaQXrAlweDw==
Date: Fri, 12 Jun 2026 17:57:42 +0000
To: Simon Horman <horms@kernel.org>, David Heidelberg <david@ixit.cz>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfc: nci: add data_len bound checks to activation parameter extractors
Message-ID: <20260612175739.11466-1-hexlabsecurity@proton.me>
In-Reply-To: <20260612131813.674622-3-horms@kernel.org>
References: <20260610064104.143042-1-hexlabsecurity@proton.me> <20260612131813.674622-3-horms@kernel.org>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 56fae6bbf76c1489fe07d621a3edf42cceb13acd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the review. v3 is posted as a new top-level thread:
https://lore.kernel.org/all/20260612-b4-disp-6d52d8b0-v3-1-ae1f21cdd8ab@pro=
ton.me/
Point-by-point below.

> [Severity: Medium] Is the correct error type being returned here?
> [...] -EINVAL [...] nci_to_errno() will truncate it [...] -ENOSYS [...]
> Should a valid NCI status code [...] be used instead?

Correct. These extractors return into the int 'err' in
nci_rf_intf_activated_ntf_packet(), which is handed to nci_req_complete()
and later run through nci_to_errno(). nci_to_errno() takes a __u8, so the
-EINVAL is truncated (to 234) at that argument and falls through to the
default case as -ENOSYS. The contract here is an NCI_STATUS_* code: 'err'
is initialized to NCI_STATUS_OK and the functions' own default cases
already return NCI_STATUS_RF_PROTOCOL_ERROR.

v3 returns NCI_STATUS_RF_PROTOCOL_ERROR from the new short-region guards,
which matches the sibling default cases and maps to -EPROTO via
nci_to_errno(). NCI_STATUS_INVALID_PARAM is equally valid (also -EPROTO) --
I went with RF_PROTOCOL_ERROR for consistency with the surrounding code;
glad to switch if you prefer INVALID_PARAM. v3 is otherwise identical to v2
and is posted as a new top-level thread.

> [Severity: Critical] [...] atr_res_len [...] integer underflow [...]
> up to 47 uninitialized stack bytes into ndev->remote_gb [...] broadcast
> to userspace?

The uninitialized-stack read is real: in nci_store_general_bytes_nfc_dep()
an atr_res_len below NFC_ATR_RES_GT_OFFSET makes min_t() clamp to
NFC_ATR_RES_GB_MAXSIZE and memcpy() copies stale bytes of the on-stack
atr_res[] into ndev->remote_gb. I could not, however, confirm the
"broadcast to userspace" part: remote_gb has no netlink attribute (there is
no NFC_ATTR_TARGET_GENERAL_BYTES), and its only path out is LLCP, which is
gated by the 3-byte llcp_magic memcmp on those same uninitialized bytes --
so a deterministic leak of the 47 bytes isn't reachable that way. It's
still a genuine uninitialized read worth closing; see below.

> [Severity: High] [...] sel_res [...] uninitialized [...] nci_add_new_prot=
ocol()
> [...] nfc_genl_send_target() [...] sent out unconditionally [...]

Confirmed, and this one does reach userspace: with sel_res_len =3D=3D 0,
nci_extract_rf_params_nfca_passive_poll() leaves sel_res unwritten in the
on-stack ntf, nci_add_new_protocol() copies it unconditionally, and
nfc_genl_send_target() puts it into NFC_ATTR_TARGET_SEL_RES on
NFC_CMD_GET_TARGET -- a one-byte stack disclosure (the discover-NTF path
reaches it without the err=3D=3DNCI_STATUS_OK gate).

Both pre-existing issues are closed by zero-initializing the on-stack
notification structs:

    struct nci_rf_discover_ntf ntf =3D {};        /* nci_rf_discover_ntf_pa=
cket */
    struct nci_rf_intf_activated_ntf ntf =3D {};  /* nci_rf_intf_activated_=
ntf_packet */

I'll send that as a separate patch rather than fold it into this one, since
it's an independent change in different functions.

