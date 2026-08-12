Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30439020C
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551754; cv=none; b=JHzrQtXJPnKfkYifR1YwVVoP4EcOUMJ6wt6zEGcctJHf93xrBy4keV4v86iRhrKyzPnDo8U3rcIfzkaPM7oKc87a6yOgWKBv3cOi2qaaCtybNtXxg/B5oMCa+k+WmkthtsaiP0WNdJVI7ibmZNy41bxYrjcs7t+PVYOjMyFQuiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551754; c=relaxed/simple;
	bh=WX+h646lZXfqeKCjGrMcRv13nAZgcSJtBQv236pEIk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fkkwyDHI+Gf4sLP0vro0wAh0iuBU9H2eoZ098Hw2u9eK91KGkPihe5t7VbSCQ0qpVi9BXW4V52tYzIizHlKoJ/Gf9eLoahHe41WlVWgfkZMuqEqQto2ASratUt0OhsTfoaryh0nhSzcBIStweKCPIs0EXkhpXibEkOwbg8DZs8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQBXafaf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQBXafaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922661F000E9;
	Wed, 12 Aug 2026 16:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551752;
	bh=3OG3rmu62sE1fRXq71e8Xa4G4+vdWfB0YF+LmjSMzkc=;
	h=From:To:Cc:Subject:Date;
	b=QQBXafafxC0bxYw6dXpIN6XG0zn5rwF05chBOWImCyiDB8Bq8EEHbS2KohPKGmYKv
	 JD+Qv+9BSZWtPpCMWC98otrrzyZJOPAN+jiUvuxCy4B4Hvi1L4eWE8GnLtXI6u6GBQ
	 /u1dYbn+aA6TWLACU2PaCSpT2ybrrVIKlPlSfdU856y9OvliPUjMFMdZvW1rrPxrCU
	 p2FoeTrCUwQOa6JcCM0u94saFov/paZV63FytXcCmYgO25rjiMgs2BDX0E7epn2fjd
	 xGw6xqWs51PetywUVAP1b11IBbDrZw7KafN2ofUD7AnWQY8SDj94b7OPZRzwcI41+x
	 NhrrK2cl2Td3g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next] ethtool: tsconfig: reject zero-valued tx_type and rx_filter bitsets
Date: Wed, 12 Aug 2026 09:22:30 -0700
Message-ID: <20260812162230.1837788-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ffs()/fls() guard in ethnl_set_tsconfig() was meant to enforce
that the user selects exactly one tx_type (and one rx_filter)
at a time (off / none are explicit types with non-zero values).
However, both ffs(0) and fls(0) return 0, so the guard passes
a zero-valued bitset through.

The subsequent ffs(req_tx_type) - 1 would produce -1, if user selected
no bit. net_hwtstamp_validate() catches the invalid -1 downstream,
but returns a generic error (-ERANGE) without telling the user
what went wrong. Return -EINVAL + extack instead.

Replace the ffs()/fls() comparison with a hweight32() == 1 check.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: vadim.fedorenko@linux.dev
---
 net/ethtool/tsconfig.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index 24b64862011f..6be3aa5d4bc1 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -359,8 +359,10 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
 		if (ret < 0)
 			goto err_free_hwprov;
 
-		/* Select only one tx type at a time */
-		if (ffs(req_tx_type) != fls(req_tx_type)) {
+		/* Select exactly one tx type at a time */
+		if (hweight32(req_tx_type) != 1) {
+			NL_SET_BAD_ATTR(info->extack,
+					tb[ETHTOOL_A_TSCONFIG_TX_TYPES]);
 			ret = -EINVAL;
 			goto err_free_hwprov;
 		}
@@ -380,8 +382,10 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
 		if (ret < 0)
 			goto err_free_hwprov;
 
-		/* Select only one rx filter at a time */
-		if (ffs(req_rx_filter) != fls(req_rx_filter)) {
+		/* Select exactly one rx filter at a time */
+		if (hweight32(req_rx_filter) != 1) {
+			NL_SET_BAD_ATTR(info->extack,
+					tb[ETHTOOL_A_TSCONFIG_RX_FILTERS]);
 			ret = -EINVAL;
 			goto err_free_hwprov;
 		}
-- 
2.55.0

