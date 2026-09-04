Received: from mta0.migadu.com (out-58.mta0.migadu.com [91.218.175.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245D8483BC2
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526690; cv=none; b=haKNHaAvvBuwjU3i4Nvba8/bJzH2Di8pAXVEhYLU4IWlmyCev1ZI5rC/wu7Z4fCpUS+vt7fQXKoJj65IHQYIDHjQbixVTKkUqsLJFi7k4gDak1pj3rRqhKF2YY69l7bTbeiwY+Qnv4HPkDR+H4YTD8HFrgdPE9rsYZ086pqeUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526690; c=relaxed/simple;
	bh=+usWt1vB2N5f2YUiJHGZ4UcnC8jzGuYnlVt3gnLcxZ8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc; b=nj2XYFLFxpd6TUh7r3g7eKLtM5isOTcPiIuROeXC1O0HvMUEuKRDEgcLdzRm8m9H4FpLtnqhec1GUeUXY4XMUE5YQENpU0kmxwsnvEo6gskvAAp6naYIxg25sz6NWPLuXSwK8qQOcIGe0x65gdlvBZih79369nCVAQsemgT9zQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QHf6LpA1; arc=none smtp.client-ip=91.218.175.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QHf6LpA1"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+usWt1vB2N5f2YUiJHGZ4UcnC8jzGuYnlVt3gnLcxZ8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788526686; v=1; x=1789131486;
 b=QHf6LpA1jDCRKMqMlSDKh6ZGkzc4vt6tyUUc0VXxJKRMLpg9po9+u5a74YaiK7GrBiAg3VFI
 xlndkYJWaXyXrCadppuYv7k9gzOjApPljKhoIcR+Ad3L77gtgPESnmmurHmCRbv9TZDy6K7/lgb
 E4agDXuPrT3qantoPpGNRqtI=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0a98928b6cf7ffbc;
	Fri, 04 Sep 2026 12:57:56 +0000
X-Mizu-Trace-ID: 0a98928b6cf7ffbc
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 04 Sep 2026 12:57:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Tianchu Chen" <tianchu.chen@linux.dev>
Message-ID: <7d886d74276c05eeb1b1698e31b72a5aed98612a@linux.dev>
TLS-Required: No
Subject: [PATCH] wifi: mwifiex: bound SDIO fw dump count by memory table size
To: briannorris@chromium.org, francesco@dolcini.it
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org

From: Tianchu Chen <flynnnchen@tencent.com>

mwifiex_sdio_fw_dump() reads the number of memory regions (dump_num) from=
=20
a=20device register and uses it to index the static 15-entry
mem_type_mapping_tbl[] without any bounds check. A bogus device can
report a dump_num larger than the table, making each loop iteration
store a vmalloc pointer and a device-controlled size past the end
of the table into adjacent .data (up to ~5.7KB when dump_num is 255).

The dump path runs after command timeouts or firmware crashes, so a
bogus device can first force an error to trigger the dump and
then report a bogus dump_num.

Aborting the dump only loses the firmware snapshot; the card reset=20
that=20follows is unaffected, so error recovery still completes.

Discovered by Atuin - Automated Vulnerability Discovery Engine.

Fixes: 54881c6b37c8d ("mwifiex: add firmware dump feature for SDIO")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wi=
reless/marvell/mwifiex/sdio.c
index f039d6f19183a..e40ca40418b30 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -2795,6 +2795,11 @@ static void mwifiex_sdio_fw_dump(struct mwifiex_ad=
apter *adapter)
 		mwifiex_dbg(adapter, ERROR, "SDIO read memory length err\n");
 		goto done;
 	}
+	if (dump_num > ARRAY_SIZE(mem_type_mapping_tbl)) {
+		mwifiex_dbg(adapter, ERROR,
+			    "Invalid fw dump num: %d\n", dump_num);
+		goto done;
+	}
=20
=20	/* Read the length of every memory which will dump */
 	for (idx =3D 0; idx < dump_num; idx++) {
--=20
2.51.0
