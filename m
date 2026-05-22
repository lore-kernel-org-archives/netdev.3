Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FF38CFE8
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491608; cv=none; b=SLQGTS57paqE6bUdy94ZMoKCt+V4keh6cUghgRqbywykf0wzUm8LyLtlc4zV3HTPpQgGm/nGE6h4IyyEja2+9NkSEmKiDGOj/ZaIb4fCS9ydsQQD1/l6YTKkmX5+HUHNfFjigVsnfr0i5NqdXbULlUpnlVu9RNfvykK7Oc9jv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491608; c=relaxed/simple;
	bh=umdoF5sU8foZfCQJqv8Pe6TlalQGJKTklSfelmaEu/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsEWlTu1avElX4hKbGaMWwWE21Pu0vBXYPmkYiwZNf1JZeTs/kRuj+zrq4YJ4hha+Mbofycuh+VWe4hr0LnKvuOQlngSpUin8skl5LBpBYyMFNI9JlRA6m9unj7HsWwbI/zqY7NY3LT6sgnq1Or2TtPxZR8lThkXgKpI/y37Sec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpSRE9Vg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpSRE9Vg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC371F00ADE;
	Fri, 22 May 2026 23:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491607;
	bh=IZ+Qk4pWApzKfTct1PkZ846E+gNmkHNGYvfWcMngO3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RpSRE9VgxCyPyPvjfSBCk0lYAyR8CFCY00Nmmu6B+v1unAxXXUisea+lDbJ+Qf2tb
	 HxPWCKhe49Mcz5fuqh/1X3ELszm8Wt6rrTnvyW+OKGjFeBJ95JfJcqiLtzZFmitoM6
	 1EzXkDOe05paiMe0Tzq2NFtTJ4Dk69E9OdiOi6gfPaaiaTbxuW41okLqhmAk9TUt5O
	 wqJRRbZ6Yz4N35B/1plUFjN78enEszZuoKTC0vUMd2nDCy54uMlZu0u/oTD34A9+Lm
	 gHi08csn/tC6M4tsanxhYfzZgWifhRILAKMTjzxsQfvMLyg7sKbI9A/yafJFx3yWy6
	 Jnh/pyeIj/s8Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	petrm@nvidia.com,
	o.rempel@pengutronix.de,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	kees@kernel.org
Subject: [PATCH net 6/9] ethtool: cmis: require exact CDB reply length
Date: Fri, 22 May 2026 16:13:09 -0700
Message-ID: <20260522231312.1710836-7-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522231312.1710836-1-kuba@kernel.org>
References: <20260522231312.1710836-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Malicious SFP module could respond with rpl_len longer than
what cmis_cdb_process_reply() expected, leading to OOB writes.
Malicious HW is a bit theoretical but some modules may just
be buggy and/or the reads may occasionally get corrupted,
so let's protect the kernel.

The existing check protects from short replies. We need to
protect from long ones, too. All callers that pass a non-zero
rpl_exp_len cast the reply payload to a fixed-layout struct
and read fields at fixed offsets, with no version negotiation
or short-reply handling:

  - cmis_cdb_validate_password()
  - cmis_cdb_module_features_get()
  - cmis_fw_update_fw_mng_features_get()

so let's assume that responses longer than expected do not
have to be handled gracefully here. Add a warning message
to make the debug easier in case my understanding is wrong...

Note that page_data->length (argument of kmalloc) comes from
last arg to ethtool_cmis_page_init() which is rpl_exp_len.

Note2 that AIs also like to point out overflows in args->req.payload
itself (which is a fixed-size 120 B buffer, on the stack),
but callers should be reading structs defined by the standard,
so protecting from requests for more data than max seem like
defensive programming.

Fixes: a39c84d79625 ("ethtool: cmis_cdb: Add a layer for supporting CDB commands")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: kees@kernel.org
CC: danieller@nvidia.com
CC: petrm@nvidia.com
---
 net/ethtool/cmis_cdb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
index 3670ca42dd40..f3a53a984460 100644
--- a/net/ethtool/cmis_cdb.c
+++ b/net/ethtool/cmis_cdb.c
@@ -513,8 +513,13 @@ static int cmis_cdb_process_reply(struct net_device *dev,
 	}
 
 	rpl = (struct ethtool_cmis_cdb_rpl *)page_data->data;
-	if ((args->rpl_exp_len > rpl->hdr.rpl_len + rpl_hdr_len) ||
-	    !rpl->hdr.rpl_chk_code) {
+	if (rpl->hdr.rpl_len != args->rpl_exp_len) {
+		netdev_warn(dev, "CDB reply length mismatch, expected %u got %u\n",
+			    args->rpl_exp_len, rpl->hdr.rpl_len);
+		err = -EIO;
+		goto out;
+	}
+	if (!rpl->hdr.rpl_chk_code) {
 		err = -EIO;
 		goto out;
 	}
-- 
2.54.0

