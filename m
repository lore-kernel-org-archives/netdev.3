Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.185.58.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887817;
	b=0siqJdD1+gQRiIA666jtxv2jKtadUYvkQgXERVI1pUtWMaML488um6H2ItLa9iMe0L9s
	 TLYj6E9dygEH/1KSf3cWB+KeZ95i1XRj70IdBH+l9m7HlaqvayqrT2k/S7rA4YAHWOAgg
	 Cn7zG47XqgPQeDGEuKmmAoq5AqEc/8e4Rd6VquPwlTcUUAccT/GO9sBBUq0Vz5lzlJ8iV
	 wEB3fu/pdXXULIzILUBU0D9r7veWS5uxvp/ibcMQVsGBX6gSQ892RWOpGYNOK+ujZuClG
	 kUFhUMyPVXKqdlQjAZ9xE57tW131Q+S91BxUUREyc702xv2feiJrEmtyi6WubA0FNFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887817;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:X-Spam-Level:X-Spamd-Bar;
	bh=B0NMlHCXbtd1qBfAR3EnPhSrPzqZtuXAFJZ0/+KbPU8=;
	b=3atcaFwufFTea/chPtcbw4V2bsBcsPaCTrodrcPkcXWPwA/v7oeQr0Ht90enO6XRC1S0
	 rla09Rn/hR0wl3W+4B6aQoixrIcCVmIe+MkQ9JxRUS0CCL7854x1LV9seNf/VMgEt0rlE
	 nOwDQdtrCZhDqQaQ7OxMEWBFJcq4P+W4g99TlWub4Qt6KNfqzeVbFaNt+MVueb2Qwc4Gv
	 HCLYkELLHWZuSt1ewfGcyN6amwdrCXXQFapBXUZQdFm9Qtpp8aD3Za7H8NmyGYKjXvnFo
	 lOMpLn14zWZmCNwWoj4Cz26g+bqBWRwJOPBs3Dq2kdiazPP2Pb1qP2GmVnVBbbCD+SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=badcode.im;
	spf=pass smtp.mailfrom=badcode.im;
	dkim=pass header.d=badcode.im header.i=@badcode.im header.a=rsa-sha256 header.s=dkim header.b=ZExZtbtF;
	arc=none smtp.remote-ip=185.185.58.180
Received: from badcode.im (badcode.im [185.185.58.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1535D606A331;
	Thu,  5 Nov 2026 14:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1535D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=badcode.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=badcode.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=badcode.im header.i=@badcode.im header.a=rsa-sha256 header.s=dkim header.b=ZExZtbtF
From: Alexander Ildiyarov <alex@badcode.im>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=badcode.im; s=dkim;
	t=1793887814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B0NMlHCXbtd1qBfAR3EnPhSrPzqZtuXAFJZ0/+KbPU8=;
	b=ZExZtbtFtNxdBEMVI+107J8XYgUoY1TZNXvWU04Wv+dAN2rfTH60yruTrSWwpmvPbKzgVi
	IZxahIyTQDUXm5AezNw+onAjWACAsva6IqXf3pQtAzlGYvyXbt6PGX9JqPeIykYJSVHwsW
	flQD8/sBKggXmt9e+zyi7rjp6Sr+dtftsuKRvD2LgId/cnbJwvmPmHCk3FwCCWdA0XP8Gg
	MNhv8rDGSyOAi6KTOg30Hm9o7P6e7rppUWhM8ha/XYzROlLvYVEfo9GBUlgwlFY9/Kn/rz
	k2fkjDSLPCuydW8P8K6b8ezdR83fJB6uBsiv3kPTeJ+hQru18CWtBK2N/Q3i4g==
Authentication-Results: badcode.im;
	auth=pass smtp.mailfrom=alex@badcode.im
To: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Alexander Ildiyarov <alex@badcode.im>
Subject: [PATCH net 0/2] wireguard: memcg accounting and initiation race fix
Date: Thu,  5 Nov 2026 17:10:04 +0300
Message-ID: <20261105141006.95083-1-alex@badcode.im>
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
X-Spam-Level: **
X-Spamd-Bar: ++

  Two independent fixes:
  
  1/2 charges peer, allowedips, dst_cache and hashtable allocations to the
  memcg of the configuring process, which currently can allocate
  unaccounted kernel memory through WG_CMD_SET_DEVICE.
  
  2/2 rechecks the replay/flood conditions under the write lock in
  wg_noise_handshake_consume_initiation(), the initiation-side counterpart
  of 2a73c9b2c0ca. The race window is narrow and was only reproduced with
  an artificial delay; details are in the commit message.
  
  Tested in qemu (x86_64, 4 vCPUs) with reproducers for both issues and
  CONFIG_WIREGUARD_DEBUG self-tests. netns.sh was run up to the
  allowed-ips removal step, where the available wg(8) is too old; that
  part was not run.


Alexander Ildiyarov (2):
  wireguard: account peer and allowedips allocations to memcg
  wireguard: noise: recheck replay and flood under write lock on
    initiation

 drivers/net/wireguard/allowedips.c |  2 +-
 drivers/net/wireguard/noise.c      | 29 ++++++++++++++++++++++-------
 drivers/net/wireguard/peer.c       |  4 ++--
 drivers/net/wireguard/peerlookup.c |  4 ++--
 4 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.43.0

