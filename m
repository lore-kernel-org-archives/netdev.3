Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699487;
	b=oXuFYw5UGHRct8uGwptQZZ7+wUKhilLgO3jfA4xHjo1Tjg2Oi17gndmdVaWs7bBZP5/7
	 qLVGDwqaYgPY66CC9MXK5HM1sYJRpSLjkX1aZgawejXV7Vwj1/uWegcjxJ+2Pj2h0bbNj
	 EYJc0Bs+M73lahCu1cqQmbIO7KjzKPGxrcl0vFy9+C73OsKn4JZ004pnHFWNC9uTaSBq3
	 GDXIVib6tQoy/TeAZ5w5StKDSRffr+EOsxErK2ZvKrXEw0CsXKuDb6l6y6DM6WidTQqNg
	 nSmxGw0gYubez0xFYvgawH5uPLBrBqX8P8JVte9593UsSTMbIoo4DxTwa7czogZzOjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699487;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VYb1+IbllOUjGkhumc3tQxsC4S8HxcWAoy5cbC2qX78=;
	b=mqDcREYawwXjP1oOIisTBulp17H1jXHTUi201w8Q01LNiN143myXJzwor3a2So4ZCYgc
	 f5yXWRFCGvtkbhtRXFXz19EZq5mrlrJ0jpGG+HcTEVh1rAsw14IHGOSbE8NxBIKtMiyWn
	 iBoSdc3T/Ai5DWgx4PCparVhR+VAvrzp95LmcvzRFhIThceFUGF5EK/LfcGIPCgdXbrVc
	 WJ3cVTRh+YHJnFyrHF0QvXvZ0/2ltA9t4MgHg8GCygnUNpu47TfS3DMwIYB3KBxcjlyxv
	 wDX7sknZa7DdFDU3lQlAqMd6KzDjIHiJjrOvGAkfdRBdwkCOErS5hydsCvPl0MYYQEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=WKCD+amG;
	arc=none smtp.remote-ip=203.205.221.205
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E95606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9E95606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=WKCD+amG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1792699478;
	bh=VYb1+IbllOUjGkhumc3tQxsC4S8HxcWAoy5cbC2qX78=;
	h=From:To:Cc:Subject:Date;
	b=WKCD+amGp+mhCUSi0zNI8OuKJ8mk30Hetc83YmnOWAAwvd1mC9H3kJctxxYhGgn2O
	 9V87LkYl9veW1dGy40ps4s37KAaRoCzbnNWjMR4UveerZptjbFKW6YLtWMg75deQJm
	 Oy8fAo8sWoPevu9Pi3QSJvJsZ67cGgo98oDzDkdE=
Received: from localhost.localdomain ([180.165.29.111])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 12294C65; Fri, 23 Oct 2026 04:04:34 +0800
X-QQ-mid: xmsmtpt1792699474tudu7cdmp
Message-ID: <tencent_5A7AEC56CDB23A83120519D0C074B592C706@qq.com>
X-QQ-XMAILINFO: MMwjR1C73eIsv43A4PnJHzHxQIoPpQAkAvenYRD66LcOcw6BbJOEnBGaXw7kzS
	 NfGIp5XXoSWtW0q6Fj/vZNNZ3zfBWMNlyDScSJ7Apbc2oTFeBnK2wuhaXjRgw+uh6GIax21685f1
	 gosqMiTvy+US5c9iypnImQsc+VpNTHUBmnJVrakoQ0Paqri6C8L1jv4C1mk63LXlv5uEpww/BUl9
	 nbKu5ZbpPD1neeHCHgD/6ZJmkjAJhs8ZMGOm6aifa/ayqKuYGegZf4ctPAa0GWprB+DulUnyfUKy
	 EhJvjemuovVYgBkRB57cQrLcyGEkWvmuxrEaLhg4Detb1306mBNGPsI1DPdtFQ/yx1lwE3NXq3nJ
	 R6x4XYT4gRVllRWm5r6ZMHQs9EVN5EQ/N0nZfswqfgny68C9Dg2liNV9DfZKzizH/iNy1QNx+O0h
	 ewdfx+DSPioDDtmnC0hBt+Is19eLToXW1fuBkoThQfbpeXM6cubaG4iktNxuSqcMz/v2anVDYMpU
	 v/Ze52am6EV/Ny6+T6XF8C0SpQJ42f64iKz9oTg7tKcpnHgkEsorAAhpsK1KjOrA2uLTI73J0SEQ
	 BM3LYEAtb7jFLsGOKR+o6iRe1LaC6qbAn7Jj/X0dIKT2DRD5RkbFz2xcj/Vns6UHAy3vZOS1Pndn
	 3yvrAzYre4ClG9dGJwBfYTHo4LURBuqaM+RcDmYe8uopvppjE53zYi70WGoXCMfjljSO0VJYUeFp
	 3MQfsAPu1wEUjlCN4R+kWpzz3wpryWViUh63aM2rANzgP07M76RtD6CQkI4dyKpU3Pg6tULpuyR9
	 W9Jl/ncrV9+KW1KRDi8O/6NQx1zF1oNanZK6KEvWajRSMS+fkA0BgAftB/AIQrLzKDOmiNSmOCQ4
	 jOybMJR8Qd7gHKKdMGp5U/iTJWgmdDIZrCCio2F8P+dHYuWGAqhyONr4Y8crRAMcWv1B/m/5gpmb
	 Z90OSKiXAuII23SaWnromJZMeLRHuafdODMUWS89Okj6xgZt/myN+b1Fr20vDv
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel@makrotopia.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	johan@kernel.org,
	kuba@kernel.org
Subject: [PATCH net 0/2] net: dsa: mxl862xx: bound FDB dump walk and reject bridge_id 0
Date: Fri, 23 Oct 2026 04:04:32 +0800
X-OQ-MSGID: <20261022200434.80182-1-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

Hi,

Two robustness fixes for the mxl862xx DSA driver, both hardening the
driver against unvalidated device-controlled responses:

Patch 1 bounds the MAC table walk in mxl862xx_port_fdb_dump() by a
conservative upper bound. The loop currently exits only on the
device-driven "last" flag, so a device (or its firmware) that stops
setting it keeps the driver looping forever with RTNL held.

Patch 2 rejects bridge_id == 0 in the BRIDGE_ALLOC response. The API
header documents id 0 as unused; accepting it verbatim collides with
MXL862XX_DEFAULT_BRIDGE (the CPU port) and merges the port's filtering
domain with the CPU port's.

Both were found while auditing the driver's handling of
device-controlled state; thanks to Daniel Golle, Andrew Lunn and Johan
Hovold for the discussion that steered these towards a plain
robustness fix.

Base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984 (mainline)

Zhang Hewei (2):
  net: dsa: mxl862xx: bound FDB dump walk by table capacity
  net: dsa: mxl862xx: reject bridge_id 0 from BRIDGE_ALLOC

 drivers/net/dsa/mxl862xx/mxl862xx.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

-- 
2.39.5 (Apple Git-154)

