Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D4942B327
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380466; cv=none; b=Q776tf+qp5O7OF2LtTXjKTt7ATa6DxLryykC4Ux2g5lhjf7YWXRqcPYHBQgda/c2FpcOKapDNnK48ah5veO4GqHCA5njVh03zsRATDGjXd5jpHPqLYf0yswVhaPuGM6FT9MJno6uzSLstr0gteK0fEgcq2Rcwcte30GUEh1fCvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380466; c=relaxed/simple;
	bh=xKkdk+oRipYl2FBIJ5sU6JRzIZiSNmYEwP0+g6e80EE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lbRSu5eigit+Xp/dualQIlSS4D+v1OIkMV/Oe3JV2iQKPIYnHtpmdHeRdEKVqVI3AdyXCMLf7T4zFp96lAzUgLSJmZEQcM0+i1GcMFqS0m+zE2az0KzZ6ISkvh5FcfJtjM/KFCXgAOgAy6uezHa8QBjhWB3ulEJ4U/hP9H2UVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2jsgefw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2jsgefw"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47df6a5655aso282469f8f.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380463; x=1786985263; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M4cFeuYVe2PqMmlNs+0IiLZAQTX9Mf3yqFTkdggjSb4=;
        b=g2jsgefwC+qbMj/7MF9HbeOPjFIIaoioydMo2z435hGgPgMxr6Y8AgO2zcjBNuAeT3
         bFc7d+uXEnDCAsfY/w0tSpwS5fCRASGLB4Ao63e+QVWMJ2wkj548ZQQOY2I09T8/h8i7
         EkdBdcIXTAhY3sElpnpI2flGPwwbV34WbjmUsAG0eQ1vK4fZzEgFdyhWZNk3OJjclaJb
         O51/CG4YVtgbuadHzj48dLpsF3p+5cUKAoMWS3iABRXhofDmzk1NcXD8Z97+9RVzPpU0
         P//qOSfNeW1BgqKBu1KtiXSg2neUGheQIuY45nCn6WZyf8g/vmvydlwkFCodA3JgCRnL
         xq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380463; x=1786985263;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M4cFeuYVe2PqMmlNs+0IiLZAQTX9Mf3yqFTkdggjSb4=;
        b=mMNH5mqL4zrlLPoYEddoNYYBKqk+mPSKysWWOsyhem5RPSBwNgdw2VGPaqkY0pSzvI
         gEvZbRJ2tqTZbbdmYr4KvMrXHP5fIq8uSl+ISbRVOGK/q/YUt0Vq6dnnr0Vpz/2Y2vtL
         8QmH8EUy1vMHf6JjqI4pWYoO6L/IGgp7Tb0qhPnWaY1rf+BQ+ifVYlviJMum2EXKOnET
         L0WJmUWtbtqF3ItEbFtwoTKRVdyqWRndEIizZT3PxZGkn7wqEPXg9CMHsDCRzQ0D+yqK
         RqQVEqAJXbB5YHKKZICWXA3jgRpto6byDW0APh2vcvr5WtqXImkBTutw4Alq/meRmwNF
         C4NQ==
X-Gm-Message-State: AOJu0YzWS2I9I8x+aGZ74t1bvT1jJ0yjGjtCvEPLm8lI6KE4rFaoTaNc
	Zsmw8Rji+GoxKnamBB5azEI6ne+JAnGCAQ5EUxs31PQA10cgdlROxFH8
X-Gm-Gg: AR+sD10KU9BpYW8A7Afc0zlb/ofBzugnkQcT7LZqzIZysghV/lxiP9/kStBhjs0kBlE
	tk/e5k7SY0y3gy9y+fWub3/kh+UdeFKSwzF++OwiAKmgt3qcgYVXQeqDrwSdj1miTCNcB5afIkS
	eMwNEqhvBiG2GW/o585VRNyF/Q4jQ/WLCFGaeUteQh51rmQBXx3iXWwVtpJUNHzSFEAFGbpnskt
	0kQahg04g1QitRLThGHzunb9iWZS/VxQZyfKWNp4+acmRMkSU6mrWd5VzUD9xl1GnttczSbDpDr
	OYwcBDNnMHulOgf2ZywWiolm4rTDW4dIR+xNGSL4NRoHxx+jhSaa6izMKHdUcIRC91HvEAIX9GP
	wouh9CewXTFE5VSmIczluX0Dp7lrZ4xtzrrv+1yBEYFtF8zERi2+7MTGU7/cvsAxVYEK+E2oVli
	KILm1dsTVB0p1l2Djxf0R7b5Nbj+jULKoWjpx7n52gppQ=
X-Received: by 2002:a05:600c:34d0:b0:496:c249:ddb1 with SMTP id 5b1f17b1804b1-4994e7d7feamr301690235e9.4.1786380462618;
        Mon, 10 Aug 2026 09:47:42 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:692b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995bb81731sm222804075e9.0.2026.08.10.09.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:47:41 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net-next v2 0/6] netconsole: validate a target's IP address
 configuration
Date: Mon, 10 Aug 2026 17:47:24 +0100
Message-Id: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNQQ6DIBREr2L+ujSAQWtXvUdjGkTU31QwQImN8
 e5FuupyMm/mbeC1Q+3hWmzgdESP1qTATwWoSZpRE+xTBk55ReuSEqODssY/cIkVEZXohRiEqHk
 DabI4PeCa7+6QyESvAdpf49/dU6twvB3shD5Y98nmyPIiSy5U/EsiI5SwmspSdA3vJbuNs8TXW
 dkZ2n3fv/hxk5PEAAAA
X-Change-ID: 20260730-netcons_ipv6-565d55f55729
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.15.2

This series adds two validations to the target configuration when the
user tries to enable it: first whether remote_ip was set, and second
whether local_ip and remote_ip address families match. Refuse to enable
the target if any of those validations fail.

These validations are already done for the target passed on the
command-line, so this aligns dynamic targets with the command-line
behavior.

The first two patches replace the per-target 'ipv6' flag with a
per-address 'family' field, which makes it easier to detect these error
conditions. Patches 3 and 4 implement the actual validations.

Patches 5 and 6 are follow-ups from review of v1: move inet_addr from
netpoll.h into netconsole.c, and show an unset address as an empty
string rather than "0.0.0.0".

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
Changes in v2:
- Show empty string in configfs for an unset IP address
- Moved inet_addr definition from netpoll.h to netconsole.c
- Moved address checks out of rtnl_lock()
- Link to v1: https://patch.msgid.link/20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com

To: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Gustavo Luiz Duarte (6):
      netconsole: add an address family to struct inet_addr
      netconsole: use the address family instead of the ipv6 flag
      netconsole: reject enabling a target with no remote IP address
      netconsole: reject a target mixing IPv4 and IPv6 addresses
      netconsole: show empty string for an unset IP address
      netconsole: move struct inet_addr into netconsole.c

 drivers/net/netconsole.c | 132 +++++++++++++++++++++++------------------------
 include/linux/netpoll.h  |   5 --
 2 files changed, 65 insertions(+), 72 deletions(-)
---
base-commit: a23b36233d4103def55dc8cf65698106d0bd1e62
change-id: 20260730-netcons_ipv6-565d55f55729

Best regards,
--  
Gustavo Luiz Duarte <gustavold@gmail.com>

