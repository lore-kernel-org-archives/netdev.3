Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FF84908D2
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790069491; cv=none; b=XzRahCEmb86Aho6WWt8a/B+GVoNG3/9N2Bdjv2KZCO3QdUzb8f4B4LcAthJRKNWGlU5vdLn76JGoEzBPP4Nv9lVnqJ17hX4Gjx5z/0MRRfT+xnSlahbLhzrSFPyIQbKZvI6kOFxk5C/+zDzXBCAtHcRQ3cunfk7XeYaBmJ2qt90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790069491; c=relaxed/simple;
	bh=i4OC9tNxEONK3UJ47m/89liS/etDNEUy6A3P8O2bP9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qh1Se77Y2CBUpvfL3NaK2V0IKZnjg9mqb6LkLfX0Q7FMMyHIJkHj2oaSpdwCasYrAt7pl0UvpZC+JWDN7nBawB8uXoSLzVuQ18odP9MpnTD1DkMBaRsekRoPZyWR/3yx7/NZHMNZsjztOh2R4FRMdyTZaQwDGcdUrLsNSrnp3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPG7OrNw; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPG7OrNw"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fbef5018so48172025ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790069489; x=1790674289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HeXwpq7Q2HF6GXy21WP33oJct9TNeHbmlRru5hr30uc=;
        b=ZPG7OrNw89Ql0ckmyWb9BU/lSS28OdBzUTejWW/3dK86of03atWQFNDFqZ6H/xQchE
         DhrRDrEpwypyrmveiq+G4IvA1lU1/yjEJMRidqmKPaIx6wGsKALxeIh2oTP8tTptaAxQ
         q5BJA4q79fypzdY2S8UNEk5qPoV+BAzwhC4fysqZOD489UAITFIkQC6NufMZ2KQBanqe
         Muzv/CYAna3z+mS1QbTIf+z1pHhLbkw9wxFAdMdySHjVnk9xeF4MEEV3B2g3/vY3eLbI
         41BU0wCINKKJJ8QfVeEiRcoC/ZTADV/yxwx0uQ15/LJEGU3sQc0MzvdIEKr1rzin5Nhb
         WXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790069489; x=1790674289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HeXwpq7Q2HF6GXy21WP33oJct9TNeHbmlRru5hr30uc=;
        b=RAHDBIx0oSAoNymSV/MMPHXrb68jbXdZo1BYa/CmmhZ+gIPXYc0kPzRH9fjfVDPPlz
         RDeH07cwUfS7RugE4GbOzHSUpTVajq3K68lAO4t4Aelz87Fu8lCaM6hRsG9Oho6Umnbg
         rpL/0MLs37/QyuKw2XYxoFT6boh/gqVELUZlrI2AnS4470la+wpASFRlHuTmayR0Zafb
         yBjc4AwspZYRERYz5S1wOKbNFi3YnmDH7wsMN5Zi7MXrAK6xMTnZcK00QUWAGYJD+p8S
         bPPAmRA48TZ1J1nRUtfpVHqh0Dt91D6p6pYwd+UU/UGPYDqnqASWwPX5d8p1jaN4dfZu
         wiGA==
X-Forwarded-Encrypted: i=1; AKwUvBxjAKZWPUUW3WkYuOZ4trZk/xcswb9BuN568FzLkLSl6IvMI0GEzYhCd9Abr7tE2LMHCr6OQh4=@vger.kernel.org
X-Gm-Message-State: AFuF++misRnJYMw3wze3Ya1dywKqtf6QXbNzNd6G8ilrBotFn8duv0r9
	M8uytpzozFfCKgXCCWF25tNNrKsjbOJagQEZxFfHUYHVAe9vKxAv8eCp
X-Gm-Gg: AYBFou0ldz0BpI4nlIWTwB0oRR9JbFw6W7kysn7RR1oFqVp7+qdTP1dpGXiRnK3eWrP
	4KXUyNEztpcmDDXLtsY66+SjwCtG2C/xVaZOnA9JFAqAZ62NuxPvFFHNitklNpNGmyTlv2cKdk6
	BMQbg6Kz1Cj32DYKd8IJv5nfqaxZXiDDZLIIotSvMHDpVTESOnwMKDRIcQLmB1D7LJ1iPH0y8zZ
	qezFoyMJY2rqzkTvmDgx1E1ryzXTI+0w+LosnGsHZjAQeAc161GsITlY2KxmOWXvLKH06PQFFAh
	bPytuG2PZ7KqDaP4G+obO5MvxzIqBlu2O1j/1muuq4oWrhrXGhG7ouEdfJZCiekFUi65Kg37aNR
	CkPTClW0L1HGkm1bo+hdf4dREv1eNo0WRPE6RNFAUVgzd9P6w7r7k+Km3MDjEsO1cWjgwHCRLng
	A2TXkLtN+3dBWDdHfUJFUkUHLSF5MHZBGiV0adSy8oFeN1lAp+j84E9whufSh/UaiaqaOcLElJe
	/XbOf+4Nd0N592RDsuE8jbml0J34B0JLi71DVS1T4m0Ivqg0W62QnsNnrFI4SXJuUM9lUNokNZo
	P/WCD87W3g==
X-Received: by 2002:a17:903:8c3:b0:2dd:c100:3133 with SMTP id d9443c01a7336-2df60b640ecmr6299945ad.47.1790069488860;
        Tue, 22 Sep 2026 02:31:28 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df63a22f54sm103915ad.61.2026.09.22.02.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:31:28 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Harry Morris <h.morris@cascoda.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Hui Peng <benquike@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/3] ieee802154: ca8210: prevent stack buffer overflow in hwme_get_request_sync()
Date: Tue, 22 Sep 2026 09:30:24 +0000
Message-ID: <20260922093126.141969-3-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260922093126.141969-1-benquike@gmail.com>
References: <20260922093126.141969-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ca8210_get_ed(), an uninitialized u8 lenvar and a pointer to a 1-byte
stack buffer (u8 *level) are passed to hwme_get_request_sync(), which
unconditionally copies response.pdata.hwme_get_cnf.hw_attribute_length
bytes into hw_attribute_value without checking the caller's destination
buffer capacity, overflowing level on the stack when hw_attribute_length
exceeds 1:

  BUG: KASAN: stack-out-of-bounds in hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
  Write of size 16 at addr ffff888001907780 by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x3c/0x60
   hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
   ca8210_get_ed+0x9c/0xf0
  ...
  The buggy address belongs to stack of task init/1
   and is located at offset 48 in frame:
   ca8210_get_ed+0x0/0xf0
  This frame has 2 objects:
   [48, 49) 'level'
   [64, 65) 'lenvar'

Initialize lenvar = 1 in ca8210_get_ed() and return
IEEE802154_SYSTEM_ERROR in hwme_get_request_sync() if
response.pdata.hwme_get_cnf.hw_attribute_length exceeds
*hw_attribute_length.

Tested in QEMU with KASAN enabled by passing an oversized
hw_attribute_length response into ca8210_get_ed().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- No changes.

Changes in v2:
- Split out as patch 2/3.
- Replaced the temporary stack buffer in ca8210_get_ed() with lenvar = 1
  and an upper-bound check against *hw_attribute_length in
  hwme_get_request_sync() as requested by Miquel Raynal.

 drivers/net/ieee802154/ca8210.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index a990a0f..8aa7ffe 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1677,6 +1677,9 @@ static u8 hwme_get_request_sync(
 		return IEEE802154_SYSTEM_ERROR;
 
 	if (response.pdata.hwme_get_cnf.status == IEEE802154_SUCCESS) {
+		if (response.pdata.hwme_get_cnf.hw_attribute_length >
+		    *hw_attribute_length)
+			return IEEE802154_SYSTEM_ERROR;
 		*hw_attribute_length =
 			response.pdata.hwme_get_cnf.hw_attribute_length;
 		memcpy(
@@ -2027,7 +2030,7 @@ static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
  */
 static int ca8210_get_ed(struct ieee802154_hw *hw, u8 *level)
 {
-	u8 lenvar;
+	u8 lenvar = 1;
 	struct ca8210_priv *priv = hw->priv;
 
 	return link_to_linux_err(
-- 
2.49.0
