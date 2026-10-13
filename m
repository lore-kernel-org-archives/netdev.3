Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F048A3A4F5F
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877587; cv=none; b=I4jGHzLex+SdyCrYOi0pJDP5r35ZM2UrDpft54I0LI7pibAERadZ/n1Xe8SUJbDZ0xBiM4eYeRh736BdEmjZLczjJSTxJodblwq7ag6oIgtyZNZmNUBDfve/VogfltjRhACoLPQIebExJqhCvi6WM6692KRpQlqMCQf4+U/qtCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877587; c=relaxed/simple;
	bh=mveVOZV1cqSe9kjwGcpsqB9hQj8+IumH5VgQu3rUViY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5g2epMRV+7aMCHR/OGe/Vfri8NEmI8Ijtywjl299+7EZx0xfDttrSOPMTAeJ63J9vNUKvxWQEfz4k7q4J6dDKNhN1Y05EISI/h3kn6DwbmYJkKJgQrmcg1RTLyK+F4VvNeIcYxCL9EVPDAGnj4P6EFJ8dSpkvhJCJ8cutK41gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Foa4ZaOt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Foa4ZaOt"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-88d8bef6850so131094b3a.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 00:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791877585; x=1792482385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JtNaVvMG5Mqm08sLDfXPlT2jXVN8JsJ0XyUmmjwX9a0=;
        b=Foa4ZaOtjGmm752Nl1EoDO8oetROn17FzVIA/1RhB16ziwI3UhaKj91MOxBSwj5tjr
         udMlwKOccToHShpdPGeGP4WCJ1lVKXCw5NaQl6gvpYREZF/OYjNR6modWV70bnAncZN2
         fKG5EnTX8mt49rNbErCTI/9cKvwCVTFmXpvkLKWvwMz3Il4PsF9puVHwsKR1eF7YqWiU
         8SEXuxd9Hrr+lia5fCLIUrcwnfKWmi0540G70CTSy8ZektouRx9aGFgP7qHUkLo5xT97
         jnVFfYQbiczrYwdsC0y07+2a/VXEqFSa6zS0XtzqsvgM0LNxOLLhLAapbKDoeZqh7/1P
         btuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791877585; x=1792482385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JtNaVvMG5Mqm08sLDfXPlT2jXVN8JsJ0XyUmmjwX9a0=;
        b=b5Ml6YDc9LDcEG+lp1YTzHNGLV23rqoua/hghaM8NrTxWbbtU8NK7sx9SUcurM6WwQ
         nYfHqBWnLoPgDbwb7cmu7x6s6BSfZcA3G5y68DfYnZHuzCsSfhiueaI/7z9mFbmy1cMK
         5hGzCmL3qJeJXjK84YCBl6hmz/dNensGU2nsK0+cEqzBXUejsosal1MWc56kISqcqgnJ
         acf1wGdvKi2ahQqHJgUCCWQmVz53XxfYoPxh/r4ZbKrWHWoLqswpLr0f+lgapuPyPhOq
         b1ZhLSx8XlkUGMqnFl4KubQ8LjVbWopgj/R1c6+e+bd3U1D0eCgRRguvoZcP3UlVy4Nz
         fh0Q==
X-Gm-Message-State: AFq9FYLE/KOGhso5VDIKcqajNNZYoYEz/WQXxhBuEPhKNF2QV2Uzk8UH
	wUXi32gph8o0R3S3nnBT22e/fQU95H467R+eKaRhL/mwqR17oz3lAwWem4EXSA==
X-Gm-Gg: AYBFou1kGOq22Drurh7DKsjYah1DaLFN8QiI5Vkurhma/r97VpaXsWwe3qAyBkThVj5
	X8AZT+Vuv8eN8i4oSCTMYtmEHG8YBoRVFnrRFnIUUrEJiT3r2AV2Px9YM7if1VPkxgVwgafTwnn
	TI5mWM9bdAMImqBrmcpsmKRDwZdw5a/ly49KRtZD3k7L9E1LHKNIv5M3uSuqxN4SW7pwVGVyM8P
	eNN3Lyowa3YNKK12F1rxGdDfp9uCLiZSLFjpjwL/+knLelGBhflIG2KDcx2WXVh4VePcVApJWwJ
	HCvlleV40rRvESN2EVvNRbmIhTIJBA8W4l66ACftWSKfRq+Kc+zK+CR9hm4SXo0JyQ/w78pA1Ng
	6VxgiyCvdfN7sbolCQkGOE+oBwV4U46NWUgQNF4coaBeBUfEIT9TGycrpOXZBwUjaGiT+2WL+4x
	3XWEvqaU2Ty4sTQQuPAQhmghCr68/NA/Y1QMl2OSVqussqhqy0/6YA+BTr5U/lbTe3X3TzqHG5u
	BC6EVxmEACue5v+fDqW2KhJ7gV3DFV9nBvkv6dluGKvGaviTj99VoH5Dilm5A==
X-Received: by 2002:a05:6a00:4889:b0:89a:ee91:e894 with SMTP id d2e1a72fcca58-89aeeb074bamr4683767b3a.0.1791877585236;
        Tue, 13 Oct 2026 00:46:25 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89805c75343sm4459011b3a.38.2026.10.13.00.46.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 00:46:24 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Christian Hopps <chopps@labn.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/3] xfrm: fix vti tunnel device use-after-free across async crypto resumption
Date: Tue, 13 Oct 2026 15:46:07 +0800
Message-ID: <20261013074610.17808-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This replaces the v1 vti/vti6 series.

vti_input() and vti6_input_proto() cache the tunnel pointer in the skb
control buffer without taking a reference.  With async crypto the
receive callback runs from the crypto completion, after a possible
device teardown, and dereferences the freed tunnel device.

The reference cannot simply be held in the input path and dropped in
the callback: the callback is not reached on every path (IPTFS frees
the outer skb itself, and the early drop for a non-valid state runs
with family still AF_UNSPEC), and on the success path the callback may
drop the last reference before xfrm_input() is done with skb->dev.

Make the reference travel with the skb instead: the receive callbacks
install the device in skb->dev and leave their reference with it, and
xfrm_input() releases it once the packet has been delivered.

Patch 3 covers vti, vti6 and xfrmi, the only receive callbacks that
replace skb->dev (esp, ah and ipcomp do not).

For Chris: patch 2 covers the outer-skb free paths in
__input_process_payload(), iptfs_input_ordered() and the reorder-window
free list.  The deferred fragment (consume_skb(defer)), the reassembly
drop timer / __iptfs_reassem_done() and the state teardown still free
the skb directly; I left those alone for now.

Changes since v1:
- split into three patches: the first two fix the paths where the
  receive callback is not dispatched at all, the third is the device
  reference handling
- the reference is taken before delivery and released through a saved
  pointer afterwards, instead of holding skb->dev after the callback
- v1: https://lore.kernel.org/netdev/20260930090813.73901-1-q.h.hack.winter@gmail.com/

Qihang (3):
  xfrm: set the address family before the early invalid-state drop
  xfrm: iptfs: run the receive callbacks before freeing the skb
  xfrm: transfer the skb->dev reference to the input path

 net/ipv4/ip_vti.c              |  6 ++++++
 net/ipv6/ip6_vti.c             |  7 +++++++
 net/xfrm/xfrm_inout.h          |  2 ++
 net/xfrm/xfrm_input.c          | 35 ++++++++++++++++++++++++++++++++--
 net/xfrm/xfrm_interface_core.c |  9 ++++++++-
 net/xfrm/xfrm_iptfs.c          |  6 +++---
 6 files changed, 59 insertions(+), 6 deletions(-)

-- 
2.54.0 (Apple Git-157)

