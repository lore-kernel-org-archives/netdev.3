Received: from mta1.migadu.com (out-116.mta1.migadu.com [95.215.58.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5ED426D09
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662145; cv=none; b=s8VryXFdBUcCkOvUzxroIMF8rjyduVLpdc+8PAiAfLmXg8GaWC/DQsx3QDcMyk8pGpHSSKWBmDmxFOHr9km2t4qhs/xwE7yBuIUBeFl6Hwsgje7Td8BD8ts+7rg7MGZa1gB9TwcbI0X7OxVZRysOsGzFXp6j5Ov1wbLXnhCut60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662145; c=relaxed/simple;
	bh=0HJWEDZFIN8MZC8iPItZ5UwVlbitRlaRPpoiRxUgAw8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JU96rt3mOnYsqQlAb9pi9tTq1bsx64thpVUVkZmFPD7ieyk+4wGIZCdH8Ai/4vL9vMUh/X5i0cjJMkhm71VFe5cgO7CsEr1iWJ/4CjDr94jDsYCNhJWGyPHC0rw7DRJQ2PW/7eIdr3IJSO7KSridQeUW5Kh0ys+XJy2u+coX9Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S4ek+oDd; arc=none smtp.client-ip=95.215.58.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S4ek+oDd"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0HJWEDZFIN8MZC8iPItZ5UwVlbitRlaRPpoiRxUgAw8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787662141; v=1; x=1788266941;
 b=S4ek+oDdHoMqTPIv2eCgtVU+nryHHqPDycWHS2PntclLVdh4UVS+qalDOLf5ogn5TAh1paoc
 BYecvl18/Cqcf6FTl4h7SSAp65OVh+HtJahDOAZjF0maDr0lSwC1Gzk4wtQABOhljL2HPownGIC
 UoSE/PQn9RKgkQFLj5km2+P8=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.242)
	by smtp.migadu.com with ESMTPS id 6a0e01fc849c52b2;
	Tue, 25 Aug 2026 12:49:01 +0000
X-Mizu-Trace-ID: 6a0e01fc849c52b2
X-Migadu-Flow: FLOW_OUT
Date: Tue, 25 Aug 2026 20:48:55 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: [ynl] how to fix the order of selector and `_decode_sub_msg`
Message-ID: <ao2PN6wp9A2SjRar@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Donald, Jakub,

Recently I have been trying to add encap decoding support for `rt‑route.yaml`,
with formats similar to:

      -
        name: encap-type
        type: u16
        enum: encap-type
      -
        name: encap
        type: sub-message
        sub-message: encap-data
        selector: encap-type

However, sub‑message decoding is broken inside `ynl.py`. The root cause is
that `lwtunnel_fill_encap()` sets the encap‑type *after* the encap payload
data.

In iproute2, `parse_rtattr()` extracts all attributes together. In contrast,
`ynl.py` stores attributes one‑by‑one into `search_attrs` after they get
decoded (_decode() -> self._rsp_add()). As a result, we cannot locate the
`selector` while decoding the "encap" payload.

Should we decode sub‑messages after finishing first‑level attribute decoding?
Do you have any suggestions on how we can fix this?

Thanks
Hangbin
