Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67582AD3F;
	Tue,  8 Sep 2026 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788827825; cv=none; b=NVo+HHWMOGxJ5y+q8kGvSXASCXwO5FKcccYYtAEfoEJm9ofl1kiE2EJ28FG8UzjYLthEvXi+k9fGHkRC0G1GH+H86q4SUs30HupWL5M6hoWoxXqjy0ZGjfb2FYS7WKbEZUk82xbg5JybDxLXmZnN2GKfIDEvwPaQ6IbqQ/TTbxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788827825; c=relaxed/simple;
	bh=CuZSdMbS2Awj5nCTrDKhJUorKlxoAunBcLegyLOEnFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5xkRkdIh/VDQS7SrSsfgUVIjV/iD3QqLf6LcnREVccneiY2TCf06SFxvQESutBK3IKCztvdPHG4oaOg+kmKw8rlG6VR2bsuQYTwL1OJZpZZgskTNx7+DRe2P7KxMLM4OUrQShwapfv7FHVxfSXU4qxHnGsopoZ8cxXE4JE36O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9+42RmC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9+42RmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7D21F00A3A;
	Tue,  8 Sep 2026 00:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788827824;
	bh=mX69DRdJangRyIPPn+KbCE2FIdITKkWLBHqdwb2evQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B9+42RmC1hLKBrK8OuK6uA5lm+7gEI+eBUvdsN3H/JZW6UZMFX9wyfR+nCCbYQ9GG
	 v9X9L7np1VWEG/YG7CPN28mOEDbF52jLvWqy1TY+bshK8geqdT6b/9VCQty6kG4ZRL
	 4qE2bIycs/0itzFCU7W4NBV11/vl35NIiiuDjdmDZXhR0po7QyMj4ObqELg8P9uHMz
	 PGgmA2XL4nKWaIsRRgmMbVK9gmFjt8mPiQAYrLu94Ruo//5RcZuVObmWozvdKd4aFw
	 iTBzjbyFuXcjBPEqgHRu1u5gwNPmtVsNOF39QQdMB1K5M7+UgrO9JMftDWnJbYGGIu
	 V3zonK8D8RAvg==
Date: Mon, 7 Sep 2026 17:37:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>, Luiz Angelo Daros de Luca
 <luizluca@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, Ahmad Fatoum
 <a.fatoum@pengutronix.de>, Alvin =?UTF-8?B?xaBpcHJhZ2E=?=
 <alvin.sipraga@analog.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: dsa: realtek: rtl8365mb: add EEE
 support
Message-ID: <20260907173702.32b6dd2b@kernel.org>
In-Reply-To: <20260903092211.2922058-3-o.rempel@pengutronix.de>
References: <20260903092211.2922058-1-o.rempel@pengutronix.de>
	<20260903092211.2922058-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 11:22:11 +0200 Oleksij Rempel wrote:
> Add EEE support on the integrated-PHY ports, controllable per port via
> ethtool.

Looks like clang is doing more aggressive inlining here because build
fails with:

../drivers/net/dsa/realtek/rtl8365mb_main.c:894:9: error: call to '__compiletime_assert_1481' declared with 'error' attribute: FIELD_PREP: value too large for the field
  894 |         val |= FIELD_PREP(RTL8365MB_INDIRECT_ACCESS_ADDRESS_OCPADR_5_1_MASK,
      |                ^
../include/linux/bitfield.h:138:3: note: expanded from macro 'FIELD_PREP'
  138 |                 __FIELD_PREP(_mask, _val, "FIELD_PREP: ");              \
      |                 ^
../include/linux/bitfield.h:91:3: note: expanded from macro '__FIELD_PREP'
   91 |                 __BF_FIELD_CHECK_MASK(mask, val, pfx);                  \
      |                 ^
../include/linux/bitfield.h:70:3: note: expanded from macro '__BF_FIELD_CHECK_MASK'
   70 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
      |                 ^
note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
./../include/linux/compiler_types.h:690:2: note: expanded from macro '_compiletime_assert'
  690 |         __compiletime_assert(condition, msg, prefix, suffix)
      |         ^
./../include/linux/compiler_types.h:683:4: note: expanded from macro '__compiletime_assert'
  683 |                         prefix ## suffix();                             \
      |                         ^
<scratch space>:18:1: note: expanded from here
   18 | __compiletime_assert_1481
      | ^

Looks legit at a glance. Maybe the addrs you're defining should be
relative to RTL8365MB_PHY_OCP_ADDR_PHYREG_BASE ?
