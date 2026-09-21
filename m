Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3250463B64;
	Mon, 21 Sep 2026 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.14.198.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982200; cv=none; b=FQt1nj031vk7bsQyYfkyTagUIfTJ0XqhFuhHGgb+kOMgWcdgAm9bT8dBrztE88PfQGJNl+haK5wIzjj4zTMT4tKsVhcL6eLvzLqJ9kXvvOYYGBvBrvCvFM5YHZUgu/IIpExT//NoGH/NJvyWwI9NkbfBWsabX09FQnt92zPans8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982200; c=relaxed/simple;
	bh=s0LfYbWXxk4lo7hwNnyTSEiNJf2wcikydWS8YkDLt4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jzh/UtuwlQpWOrm1DlpR0PFmfqmK4ez77bVagL+xXIM7ME1PLRTY7p4IRHNv/C0uBRbaqakOocgLdXZTTDk15HSoVuhmEdo8IOOl9EKGJZVRlP+4diIItAUSPhlaD1K4rNkY0Myn/K/MqsjCpGRgjR3tkwaMRYezBbDjNS1TWH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com; spf=pass smtp.mailfrom=rimpianto.com; dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.b=RxRuIjqb; arc=none smtp.client-ip=46.14.198.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.b="RxRuIjqb"
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: =?UTF-8?q?Gajdos=20Tam=C3=A1s?= <tamas@rimpianto.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gatis Peisenieks <gatis@mikrotik.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gajdos=20Tam=C3=A1s?= <tamas@rimpianto.com>
Subject: [PATCH 0/3] net: atl1c/atl1e/atl1: fix soft lockup on out-of-range tx consumer index
Date: Mon, 21 Sep 2026 11:13:31 +0200
Message-ID: <20260921091334.3571525-1-tamas@rimpianto.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id C865C182-7EAA-4089-A7CF-1E4542A5B920.1
	envelope-from <tamas@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Mon, 21 Sep 2026 11:15:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID: Date:
 Subject: Cc: To: From; q=dns/txt; s=s20260314391; t=1789982124;
 bh=nseJzbMKlU3HWMW3gCP6++4bXflfbxDjGZnBjFsqAgA=;
 b=RxRuIjqb0C7CtKDKNpCrj3QzU7SPTp7vBzzK2Mbt8LYCFz+fJIye/L+/CzaLvLYVke1dMbbaR
 O4XQQ3PDICYo29NQdknx3+KMdqk88It6JRG1+qOHC3wlKihMLpCZl7/USlOIzZ/Dio8YSSZbPNC
 wyCJgE/6tQbDI6LJYLMjcHEx5MS+sUMRv5GuiYfQRn1iiqy3vbJLTDgsaSpnlU2wVoU9E3Pn3KP
 PJLJUmdI3FecngpC3KYOc1+QTYFl5AKISJ0KkS3DALu/P8+2sZOZpvIkFbm/B24ONSPUlUHEVbW
 2u35JuKkROlz1K+N2Bt6j2hS48LZrOE/N5O+v3uJDyDw==

atl1c_clean_tx() reads a hardware-maintained tx consumer index and
walks a software index towards it:

    while (next_to_clean != hw_next_to_clean) {
            ...
            if (++next_to_clean == tpd_ring->count)
                    next_to_clean = 0;
    }

next_to_clean only ever takes values in [0, tpd_ring->count). If the
hardware read returns a value outside that range - seen as 0xffff
while the PCIe link/MAC is resetting, e.g. during a neighboring
device's reboot - the loop condition can never become false, and the
NAPI thread spins forever. This produced a real soft lockup on
current hardware:

    watchdog: BUG: soft lockup - CPU#12 stuck for 354s! [napi/eth%d-0]
    RIP: 0010:atl1c_clean_tx+0x142/0x2d0 [atl1c]

Patch 1 fixes this in atl1c. atl1e and atl1 (atlx) share the exact
same loop shape, reading their own hardware-maintained consumer index
with no bounds check either, and are just as reachable from the same
kind of PCIe link event. Patches 2 and 3 apply the same guard to each.

Gajdos Tamás (3):
  net: atl1c: fix soft lockup on out-of-range tpd_cons read
  net: atl1e: fix soft lockup on out-of-range hw_next_to_clean read
  net: atl1: fix soft lockup on out-of-range cmb_tpd_next_to_clean read

 drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 3 +++
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c | 3 +++
 drivers/net/ethernet/atheros/atlx/atl1.c        | 3 +++
 3 files changed, 9 insertions(+)

-- 
2.53.0

