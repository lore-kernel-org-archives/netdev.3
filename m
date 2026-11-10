Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794280977;
	b=N9NqqaY/WFcaYzICD5BjaVzFHOIlICopNMqvB73qaTxsdp3TZc57XVVlBahN2p3lGvGT
	 R8mbmrNfynpfLgE3FVCw9zf9ncBM16gH/MbA1ZvSO7iOxoNO7C8dutmXCkEUnpO5PsVQX
	 MhxB+5tiib5gqeUb856kt/+ccZMsB2Nsd7h8w9DdhQUxI5QqMFafoEGGEjJX3PEJvEMvM
	 oCITxyyKXHb3uwavcZbCsL3q9xXJcvvZfScQXZzhs8plkdEDPY3Q7CkFbVHqzsAggtaIb
	 /zn659t2Yn3IVO3rlw8GbA7GqKt0hXauXTgonSvlBh8+PB/uoje0DUvNyulbVUFQFIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280977;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=p3uziPHDXqnXv0ygutwm8dNEm3yfhIso9WpsFw+cr4g=;
	b=XFoch4Dmsr3D9L31qDZvpi7PpOP+GBM+nnC83nEgQpdBrHBx91QX2o39FBIRs4mZCkKQ
	 LeYsvhmYd+jPoau214dEZ5a1VtV4sTHkCqiWEzogi5OV38d/vL/IBDHsId/6BbLSX9K7w
	 G+C+jLo8L5RJJvHH+3h2elRbcaZaM3DHo2JgrUgyJALmccsSKONaIgZjjKxtZR2IeOC0K
	 Nzw/abbPF8ry8eJOjkCJzYNKuGzq4JpkQy9SdKbdtEpiMfwYNVWJwe70Z4FaKxyRMdXIZ
	 eb9+4IQfkPTyCOAB3nbkfs46a6ZJEyeT+5FgOkewDnfJkZ//pijF5SKiSZFtKYgSF+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HoatDZXU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE4960A2626;
	Tue, 10 Nov 2026 03:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HoatDZXU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794280976;
	b=UFo5UHgcCtc2zh86qlbVaWVHHkcFOtm0DVct1kKWpQcd1Ru3a81HaUUAgBr7FSucJBm3
	 p+xYqRwkzxvwf/1r15zecfl4tFtmxoPVXWIB5enAILiw/L7TaWtuo2ypQ7ufgn5YffXRJ
	 r1ReoQeFFL1awiXb85iIcRvwiHak2OMrejQLDO7xYmiqKKyuYEchE63EXKhm6vXiJ5ViG
	 tlbKSaWZ9bD037Ua/+5y/7bICgu0sKWlR3JxbFHlQWUfYjqsaFRvODnJVOo4AJNR0p1WQ
	 BqyFs+XYDddbWcxXyUI3kOJ66maGpw1x9asRrv68d1y+tZZFDVxX1hiiIlTHq9pk6aA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794280976;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=p3uziPHDXqnXv0ygutwm8dNEm3yfhIso9WpsFw+cr4g=;
	b=LT+HD0JJsU2fFOXboc5MyRyOsBuNqfrORlDgneQhO5Y8v7xms5fCrg0MspAg4JutBwfV
	 apKNUiiOqffLhImiBjtOsfxBg+BsVTft1G1viLwDB+LfiJQe2/xro7h0/cjRDgeSTSiAg
	 WpW1iGYp1crouCYVch7D8FounUYCp5BYCHBRfVftEj3b08aMYZv/7Fc0M2BQ0/Pb7hOyW
	 CoyfIkx4qignv4b7U+OcrxxpItcs0BUQA1QbmPQBfli/tFPZUUlXd6ia99oJHTQT3nemv
	 bhozTMU4Xua/DxX+t8rlViC54NHsUcSeyLiFFra4degVtdOa8zXNpGBwym0xxqV7Law==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4C28A1F008BD;
	Tue, 10 Nov 2026 03:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280976;
	bh=p3uziPHDXqnXv0ygutwm8dNEm3yfhIso9WpsFw+cr4g=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=HoatDZXUhjaiot2aXz4xinGpHBmm/QJxI7flF9R+J5+WHzPyQWCgy1zaVQgj60mhg
	 H4sF+2/SI/Z+8nXPfe1YhM4YdlWPwT1gmbpm3+g+Km779IXdPvROAGYF9OUEmUV1VL
	 GIc4xaP78od8UrsfYfTUuVKsIHv9gcsGLAnp8e//7wYM+jbTjlcTGhW2jHRSrIcLR6
	 63kPFQnUKTB7P7ZUMjOOmSj6SUgaKve1ApxdTqJdluqJStpPt/pZ4aKBjoTSo8ssVh
	 gphxwH85Fno42iyjTaxBRvlnfS+k0TwwTnWKwqy0Jpidjhq3Du3sRMWYa2pRQnEAV8
	 zLZEMDlpcQTiQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C0FB9487AD;
	Tue, 10 Nov 2026 03:22:54 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Subject: [PATCH RESEND v2 0/2] nfc: st21nfca: fix SE APDU request race
 condition
Date: Tue, 10 Nov 2026 03:22:54 +0000
Message-Id: <20261110-st21nfca-v2-v2-0-cf9102b314cb@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: joasantonio108@gmail.com, david@ixit.cz, krzk@kernel.org
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, horms@kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794280974; l=1341;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=ebXR0iQXcJSvVd4YPxZu8WAcSHjyWGZ3ferWgFqe25E=;
 b=gJuL3Cfi5rfEv9AshF/bce652gT/67VgR68YAgOkWWXYusEBjJjTMBmHbi0+Odsqk16Omh6q8
 7FdBJqpi/UoAitQhaexn+mAeQbfHitEsC5cRDNfTgp66/IvxQeJvKlX
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com

Fix a race between the timeout work handler and the EVT_TRANSMIT_DATA
event handler that can lead to a double invocation of the SE APDU
callback, resulting in use-after-free or double-free of the callback
context.

Split into two patches:
  1/2: Add a spinlock to serialize access to bwi_active, cb, and
       cb_context across the three concurrent paths.
  2/2: Use the lock to guard against double completion and reject
       overlapping requests.

Changes since v1:
  - Use spinlock instead of plain bwi_active flag checks (Simon Horman)
  - Split into 2-patch series: locking infrastructure + completion fix
  - Move bwi_active = true before mod_timer()
  - Copy cb/cb_context under lock, invoke after releasing
  - Reject overlapping se_io requests with -EBUSY
  - Drop Assisted-by trailer

---
Joas Antonio dos Santos (2):
      nfc: st21nfca: add spinlock to serialize SE APDU request state
      nfc: st21nfca: prevent double completion of SE APDU request

 drivers/nfc/st21nfca/se.c       | 36 ++++++++++++++++++++++++++++++++----
 drivers/nfc/st21nfca/st21nfca.h |  2 ++
 2 files changed, 34 insertions(+), 4 deletions(-)
---
base-commit: 602042bf29f6efde39cfb5fdd9289bf4854bc0c5
change-id: 20261108-st21nfca-v2-f4c5f861e416

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


