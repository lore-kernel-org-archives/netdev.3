Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4339E6EF
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127865; cv=none; b=ilNkaoaPf1LxjHyn4eVe3q2211SahIDfnEgGOYW7PEBTFAjeb0XXWD6psd2loU9ylNoLfVW5uXigUo402I9H+oicYVV+lwKEIZzW1LIPqRjFSSB682dPScX7Xjebz5Wd+w4/XrNnnpttAU5+Fk0tmt0+2cuNGptvw6zOKKLoQtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127865; c=relaxed/simple;
	bh=Pyy4Ud5YR50xGXylHe5nNlnTzMYlylWFtHYirAjMfrw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9P9GDESm43T5n0GtXPeOZ3x/dGuZ1vTg/iAtFxMGr9JO7DVci+KTLws2yx3xknnA1u4SDr/Ll66fAjJdMOtG3shieldml8aX4E3y4OlLlOwj5tA39wa6qrOE8KOwte8exy/q1sVPUCcQHGFrnh5qC1VrO2+zGHwBLzXzPlhUQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZWVe0Xow; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZWVe0Xow"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613EAb7U2593544
	for <netdev@vger.kernel.org>; Tue, 3 Feb 2026 06:11:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=xPwa66gSxYzT9+eApTEv
	0hHKetW3SWjPgCTZ/WnD5iE=; b=ZWVe0Xowl5JzZJOU6X+TdeNjVlT9WAQIIjjX
	poVKLvHvQgdO30ecqbVFUy93gjHZImhkbz94Qd9CFqJbEBOiBOAPco+dwg0v16/Q
	AQZnBgkuS2mbtetynROmaQRNJK6La9RiaDjhG6Tv83NJMIO6wX4pRFgo/s0TyuNc
	3+ttYvQsqspoJHy5J6oUGZshddpkc2E+7pqXznuutaCEGHyaVYQG7+T5g8SgkrhT
	Srbz7yahf/H1Lc+CeUoFsL3jnzL88UNClO/6DM6vIhmvbHNrpnEbo3rxP9lJOIf/
	tshM7whLv1SXtSYCUov4kqJwc1umRBWkqcNFZ6PvrihorQ37og==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c3jhx804m-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 06:11:02 -0800 (PST)
Received: from twshared26871.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 3 Feb 2026 14:11:00 +0000
Received: by devbig010.atn3.facebook.com (Postfix, from userid 224791)
	id 6DFC490F750; Tue,  3 Feb 2026 06:05:20 -0800 (PST)
Date: Tue, 3 Feb 2026 06:05:20 -0800
From: Daniel Hodges <hodgesd@meta.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon
 Horman <horms@kernel.org>, Ying Xue <ying.xue@windreiver.com>,
        Tuong Lien
	<tuong.t.lien@dektech.com.au>, <netdev@vger.kernel.org>,
        <tipc-discussion@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] tipc: fix RCU dereference race in tipc_aead_users_dec()
Message-ID: <aYIAWS7wm1WGeDIq@fb.com>
References: <20260201022128.2658251-1-hodgesd@meta.com>
 <20260202174833.3e0ea821@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260202174833.3e0ea821@kernel.org>
X-FB-Internal: Safe
X-Proofpoint-GUID: l-o7_SGGC2Zruq-dh9qmf43qBxzVLdCL
X-Authority-Analysis: v=2.4 cv=faKgCkQF c=1 sm=1 tr=0 ts=698201f6 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=zGRTnv7GGmDJrsnug2wA:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: l-o7_SGGC2Zruq-dh9qmf43qBxzVLdCL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDExMyBTYWx0ZWRfXx/DAy9/L5n2c
 L6GRTPc/I+qFrBMg9iSCFxl96nGXdebcezPyOjmYZLzrtHF/wrZ/KpnNgP3knHaIWAhfZM0aAmD
 WmBv/Rtyq+zO+HdqUR/CY/AhPP7d4HTIzhT4ApMIZABsgazfdSqad8ITrmvMmd1Cu6k9+arwyZy
 88OL/Yq9WICQ4jE/unbCp/Hg8/qZATzgCrbaCfbdMyS7VJviXr6ewPbdIt57nEKEZKreq9nuNzX
 pDrP+3BF2DSsH5OPZ1R8+N8bCHTELggSW6BFHfWDpfrKtQgo32IvjG3f/MIQWQvz76LRwFLujy+
 /rBMva/BS5Jxg3pdKvIYloPtTjMqfnu0Cb+4OjYKBdnhJFzK+7o96IpDPh7bOIusCXTunPqylyE
 Y7VG87TZoRfCNK9XL1QFdLaHgVpYyU9mjuyQzRtk/ubmM2mePbo50+BBiE/HUB2Dw1IhGzIv9qa
 kuLAel3tCu7iZgKeEpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01

On Mon, Feb 02, 2026 at 05:48:33PM -0800, Jakub Kicinski wrote:
> On Sat, 31 Jan 2026 18:21:28 -0800 Daniel Hodges wrote:
> > tipc_aead_users_dec() calls rcu_dereference(aead) twice: once to store
> > in 'tmp' for the NULL check, and again inside the atomic_add_unless()
> > call.
> > 
> > Use the already-dereferenced 'tmp' pointer consistently, matching the
> > correct pattern used in tipc_aead_users_inc() and tipc_aead_users_set().
> > 
> > Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
> > Cc: stable@vger.kernel.org
> > 
> > Signed-off-by: Daniel Hodges <hodgesd@meta.com>
> 
> Somehow this didn't reach patchwork, please resend, and while you do
> that please remove the empty line between cc stable and you sob.

Sounds good, the corp email keeps getting filtered so I'll resend from
my personal email.
