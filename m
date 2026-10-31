Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793434711;
	b=WnU6P2e6fSKvtC93w5sQqXw2PP+D0JKkjzFb/++DoBdUyg+SswiP5WAryWJGX0ImQy1q
	 dW9NnbHs2aN31CkC7xibooqJr+5O14+HWk2rJiEFUXWr7N16VZqymXusAyhqQlalhbpbv
	 S+QkKH3zne2vv+KUkQPxGajo2vj+6KxKAY83vcrV8k0mREQO0Ib5jCBhGy2/6MAUImInk
	 185Dg62xjjJ0oa0+Jsvd1/kEzv4Kw3mdJWw1NrHHhhxwyk6ElBlgt8ZcbJpfEv8xkThCJ
	 NrxL61sqluKNi+sva+XuGujtEGKNbgRHREcQQDix8rT4xfIoM3mSxx+mtz2PnNpQveg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793434711;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PVFuo8DbMy9Fqwdre1xQiPEF5EJOHp5QAIiV+UV03ak=;
	b=yRwmwUhyxHhyCLfGop0E22DWtnRdTLcSYqKrrvkV5knaJv3Ukhc62s6kfMWy+slQJHO6
	 sPnQ5VwjdJyORdxmGhgdGpLSS2si4vu44k5xXACx/bMXWx1CBGm7z6r/E6jthRd2iVNuS
	 2OFLVaJgv0CiNrA3jiFxS6O6iJWqkmYJWz4HRZcQytS95VMcjRNJbgyDQH11aQ07TXozm
	 Soce2X0HiH68AD7jgCiGVRnALDEBXK9rY+0Da3jGipcRIogn1P5S7AOBkpKq10JTmlIS/
	 MYF6uaz6J7lSicdRkziq7tx3JGLO+1A04Vj+yYH2eUfWyWT1T240nMd7GIVIl0t1YkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=vLrO30q2;
	arc=none smtp.remote-ip=162.62.57.49
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1A4606A32A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 08:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F1A4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=vLrO30q2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793434699;
	bh=PVFuo8DbMy9Fqwdre1xQiPEF5EJOHp5QAIiV+UV03ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vLrO30q2t8jmX+U0SIgcOIEND/wCbtj9cGtGtSQsV1QMzZWcDdcju7rGZX/zmIbk0
	 GLe0uhW9rJhwp/Iyq8hY9tYia5LlCcHeZAMpqEFDFxu3dqnMsis46Fnq4WTV74JPCo
	 i62CcJLI+BuHfRJFhNUWvkaJ1XhWcXrICAEvD0FU=
Received: from localhost.localdomain ([240e:3bb:302c:4eb1:751b:856d:f57c:9109])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 48E960B1; Sat, 31 Oct 2026 16:18:14 +0800
X-QQ-mid: xmsmtpt1793434697tma2iyjno
Message-ID: <tencent_D44024D3F44A0AEBD55B1ACB4D0C3F14A308@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku2VoUci3W/RTfsa9dVp6UhTrtroDcquhaEtwNsYzdm0CUm/SbyJT
	 Lo03uPC98PWrvMCj1KOUHfnvZyL9IazIh1P6FcpGzzA91JDFoZ8nBEHU3aVGTU0b12DeAh90/1JA
	 7ClvQOVrPbvsc5+rCUbe1SalHEPfV6p557x36L5AB/CBFsPx96o6JsVYU3vzQQx8E/uoXvO/zJdw
	 eE3nhJ7sD0iYT8b55dNZ9ucySl0T9M12K/igaquc2E9p0rRaKaMJGkLB/M5NU3CNszh1P5sXJagP
	 hXClNBrCn1u4QenDMN6Gl2JWDuNyBbISkLn7VegSBMt/iu2cb6x4i9AJK6fQHWfIl+Zo7H1HKcgN
	 bcVOCXhcmMMF/C2FqKT6ncu3cOPyXl8xmS6N1RhM7gO2MhASrhzw2wTo9bX+VL+gosHgMRl24glV
	 dfBGBbiE8cYL+SE0MxKLgehcQk3OdWLyBPF0OHLkYtKer70OTOihM+eyDrx3UloJOaOhh+iw10xS
	 WDkDzRgzCIJlfcmxdgpeGgl0iHH7hZc1rhDy58vAhmLqrp6ejPqXfi2qryGrrDMuXnLrL8nPfItW
	 ivrMEPXOxvAqd10srZfaHXk368XQRTP/38+JCcpvI9+ButIQxii+DoC3+AFkYVcJmFBTzKb7b+hl
	 0B6k3PmIT6qWKAkh4JGFQR564/HzVBNLIYVfI+4BoHCXjG+40pqZPT+Uc0xRBldfvWyengNx0ytf
	 8nvuwDb3YY9yZlMo7NLj+EhcxeP1pAm7xvZHgcJ4yWKF8Z1yrCADYyUDx1JD0VDOFJHWOceTf3ai
	 J0kHVB11zoqLOW6NmFepuCoXlMrLsJZEw05zuDNI6wtlk46luq4Fd4rhR8MDxIzCPgcf5tNrDQ3S
	 dnCUcCvkdmfehu2aWdo8QwPXbxVua4LytRiHCizPPBTAAPk4oDddMDW2sEfhwS5LVvkrhgsHs3Il
	 kmnd0sGVlOr/SMMjr1ggnlXKaT3clgowmcyVGstXmYXz804Yozgjo6/dTT6ujUUq7BDLuhmDWVMD
	 ypAJVkqpHd6fwo97dEzNwgQ1auoZBrKqgNvcg0Aw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel@makrotopia.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	johan@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v4 2/3] net: dsa: mxl862xx: validate the bridge id returned by BRIDGE_ALLOC
Date: Sat, 31 Oct 2026 16:18:12 +0800
X-OQ-MSGID: <20261031081813.64518-3-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261031081813.64518-1-memoriaru@foxmail.com>
References: <20261031081813.64518-1-memoriaru@foxmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Hewei <memoriaru@foxmail.com>

mxl862xx_allocate_bridge() only checks the transport status and
returns the firmware-supplied bridge id verbatim. Two problems:

- MXL862XX_API_READ() returns the firmware result value (>= 0) on
  success, not an errno. A CRC-valid firmware status of 1..1023 comes
  back as a positive value that passes the "if (ret)" guard, skipping
  the bridge_id validation entirely; the callers store that status in
  priv->bridges[] because they only test ret < 0. Split the transport
  result from the payload id: forward negative errnos, turn a non-zero
  firmware status into -EIO, and keep the contract checks on the
  ret == 0 path.

- the returned bridge id itself is never validated: id 0 is reserved
  and doubles as the "not allocated" value in priv->bridges[] and
  priv->ports[].fid (it also collides with MXL862XX_DEFAULT_BRIDGE,
  the CPU port); 0xffff is the INVALID_HANDLE of the MaxLinear GSW
  API; and a duplicate id collapses the FID isolation of two domains
  (FDB and MDB entries are matched by FID, VID and MAC). Firmware
  that follows the API never returns these values; the checks only
  guard against firmware that breaks it.

Fixes: 340bdf984613c4a9 ("net: dsa: mxl862xx: implement bridge offloading")
Reported-by: netdev-bot+sashiko@kernel.org
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 drivers/net/dsa/mxl862xx/mxl862xx.c | 47 +++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index 37e8c18f1..fe4db9b7f 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -589,16 +589,59 @@ static int mxl862xx_vf_alloc(struct mxl862xx_priv *priv,
 	return mxl862xx_vf_entry_discard(priv, vf->block_id, 0);
 }
 
+/* Firmware bridge ids are stored in priv->bridges[] (bridged ports)
+ * and priv->ports[].fid (standalone ports, which also allocate one),
+ * so a fresh allocation must not collide with either.
+ */
+static bool mxl862xx_bridge_id_in_use(struct mxl862xx_priv *priv, u16 id)
+{
+	int i;
+
+	for (i = 0; i <= MXL862XX_MAX_BRIDGES; i++)
+		if (priv->bridges[i] == id)
+			return true;
+
+	for (i = 0; i < MXL862XX_MAX_PORTS; i++)
+		if (priv->ports[i].fid == id)
+			return true;
+
+	return false;
+}
+
 static int mxl862xx_allocate_bridge(struct mxl862xx_priv *priv)
 {
 	struct mxl862xx_bridge_alloc br_alloc = {};
+	u16 id;
 	int ret;
 
+	/* MXL862XX_API_READ() returns the firmware result value (>= 0) on
+	 * success, not an errno. A non-zero result is a firmware-reported
+	 * error status: return a proper error instead of leaking it to the
+	 * callers, which only test ret < 0 and would otherwise store the
+	 * status as a bridge id.
+	 */
 	ret = MXL862XX_API_READ(priv, MXL862XX_BRIDGE_ALLOC, br_alloc);
-	if (ret)
+	if (ret < 0)
 		return ret;
+	if (ret > 0)
+		return -EIO;
+
+	id = le16_to_cpu(br_alloc.bridge_id);
+
+	/* The API reserves id 0 ("not used for historic reasons"), which
+	 * also doubles as the "not allocated" value in priv->bridges[]
+	 * and priv->ports[].fid, and collides with
+	 * MXL862XX_DEFAULT_BRIDGE (the CPU port). It documents
+	 * INVALID_HANDLE for failed allocations without defining its
+	 * value; the MaxLinear GSW API uses 0xffff, so reject that too.
+	 * A duplicate id would collapse the FID isolation of two domains
+	 * (FDB and MDB entries are matched by FID, VID and MAC).
+	 * Firmware that follows the API never returns these values.
+	 */
+	if (!id || id == 0xffff || mxl862xx_bridge_id_in_use(priv, id))
+		return -EIO;
 
-	return le16_to_cpu(br_alloc.bridge_id);
+	return id;
 }
 
 static void mxl862xx_free_bridge(struct dsa_switch *ds,
-- 
2.39.5 (Apple Git-154)

